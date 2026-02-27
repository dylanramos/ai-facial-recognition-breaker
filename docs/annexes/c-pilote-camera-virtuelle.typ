#import "@preview/codelst:2.0.2": sourcecode

#let author = "Dylan Oliveira Ramos"

#set text(font: "New Computer Modern", size: 11pt)
#set page(
  margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm),
  numbering: "1",
  header: context [
    #set text(size: 9pt)
    #let selector = selector(heading).before(here())
    #let headings = query(selector).filter(it => it.level == 1)
    #let is_even = calc.even(counter(page).get().first())

    #if headings.len() == 0 and is_even {
      line(length: 100%, stroke: 0.5pt)
    } else if (is_even) {
      let current_heading = headings.last()

      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        upper(current_heading.body), line(length: 99%, stroke: 0.5pt),
      )
    } else {
      grid(
        columns: (1fr, auto),
        align: bottom,
        line(length: 99%, stroke: 0.5pt), author,
      )
    }
  ],
  footer: context [
    #set text(size: 9pt)
    #let selector = selector(heading).before(here())
    #let headings = query(selector)
    #let is_even = calc.even(counter(page).get().first())

    #if (is_even) {
      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        counter(page).display(), line(length: 99%, stroke: 0.5pt),
      )
    } else {
      grid(
        columns: (1fr, auto),
        align: bottom,
        line(length: 99%, stroke: 0.5pt), counter(page).display(),
      )
    }
  ],
)
#set par(justify: true)
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  v(2.5cm)
  text(size: 20pt)[Annexe C]
  v(0.3cm)
  text(size: 26pt)[#it.body]
  v(0.7cm)
}
#show heading.where(level: 2): it => {
  set text(size: 16pt)
  v(0.5cm)
  it
  v(0.5cm)
}
#show heading.where(level: 3): it => {
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
}

= Pilote de caméra virtuelle

== v4l2loopback

Module kernel de Linux qui permet de créer des périphériques de caméra virtuelle.

=== Installation

#sourcecode[```
sudo apt install v4l2loopback-dkms v4l2loopback-utils
```]

Note: si le secure boot est activé, il faut enroll la clé de signature en redémarrant la machine

=== Création d'une caméra virtuelle

#sourcecode[```
sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
```]

- `modprobe v4l2loopback` : charge le module kernel
- `devices=1` : crée 1 device virtuel
- `video_nr=2` : spécifie le numéro du device (erreur s'il existe déjà)
- `card_label="VirtualCam"` : spécifie le nom du device
- `exclusive_caps=1` : pour la compatibilité avec les applications (simulation d'une caméra réelle, OUTPUT + CAPTURE)

Pour lister les caméras : `v4l2-ctl --list-devices`

== ffmpeg

Outil en ligne de commande pour manipuler des flux vidéo.

=== Installation

#sourcecode[```
sudo apt install ffmpeg
```]

=== Envoyer un flux vidéo vers la caméra virtuelle

#sourcecode[```
ffmpeg -re -stream_loop -1 -i video.mp4 -f v4l2 -pix_fmt yuv420p /dev/video2
```]

- `re` : real time (simule une vrai caméra sans envoyer toutes les frames en une fois)
- `stream_loop -1` : boucle infinie
- `i video.mp4` : vidéo à lancer
- `f v4l2` : format de sortie
- `pix_fmt yuv420p` : format utilisé par les vrai caméras
- `/dev/video2` : device de sortie

Important : il faut reload le module `v4l2loopback` avant chaque vidéo :

#sourcecode[```
sudo modprobe -r v4l2loopback
sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
```]

== Script d'automatisation

Ci-dessous un script qui automatise la création de la caméra virtuelle et l'envoi d'une vidéo :

#sourcecode[```
#!/bin/bash

# Check if video file argument is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide a video file path"
    echo "Usage: $0 <video_file>"
    exit 1
fi

VIDEO_FILE="$1"

# Check if the video file exists
if [ ! -f "$VIDEO_FILE" ]; then
    echo "Error: Video file '$VIDEO_FILE' not found"
    exit 1
fi

echo "Removing v4l2loopback module..."
sudo modprobe -r v4l2loopback

echo "Loading v4l2loopback module with virtual camera..."
sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1

# Small delay to ensure the device is ready
sleep 1

echo "Starting video stream to virtual camera..."
echo "Press Ctrl+C to stop streaming"
ffmpeg -re -stream_loop -1 -i "$VIDEO_FILE" -f v4l2 -pix_fmt yuv420p /dev/video2
```]

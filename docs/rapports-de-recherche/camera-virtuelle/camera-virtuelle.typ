#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux
#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt)
#show bibliography: set text(lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Caméra virtuelle et redirection de flux vidéo"
#let location_and_date = [Yverdon-les-Bains, le #datetime.today().display("[day].[month].[year]")]
#let academic_year = "2025-2026"

// Page de garde

#grid(
  columns: (1fr, 2fr),
  align: (left, right),
  image("images/logo-heig-vd.png", width: 3cm),
  [
    Département des Technologies de l'information et de la communication (TIC) \
    Filière Informatique et systèmes de communication \
    Orientation Sécurité informatique
  ],
)

#v(4cm)
#align(center, text(weight: "bold", size: 14pt)[Rapport de recherche])
#align(center, text(weight: "bold", size: 26pt)[#title])
#v(4cm)

#align(left, [#block(width: 70%, [
  #table(
    stroke: none,
    columns: (50%, 50%),
    [*Étudiant*], [*#author*],
    [*Enseignant responsable*], [#professor],
    [*Année académique*], [#academic_year],
  )
])])

#v(2cm)

#align(right, location_and_date)

#set page(
  margin: 2.5cm,
  header: context [
    #set text(size: 9pt)
    #let is_even = calc.even(counter(page).get().first())

    #if (is_even) {
      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        upper(title), line(length: 99%, stroke: 0.5pt),
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

// Configuration des titres

#set heading(numbering: "1.1")
#show heading.where(level: 1): it => {
  set text(size: 15pt)
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
  v(0.2cm)
}
#show heading.where(level: 2): it => {
  set text(size: 13pt)
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
  v(0.1cm)
}
#show heading.where(level: 3): it => {
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
}

= v4l2loopback

Module kernel de Linux qui permet de créer des périphériques de caméra virtuelle.

== Installation

#sourcecode[```sh
sudo apt install v4l2loopback-dkms v4l2loopback-utils
```]

Note: si le secure boot est activé, il faut enroll la clé de signature en redémarrant la machine

== Création d'une caméra virtuelle

#sourcecode[```sh
sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
```]

- `modprobe v4l2loopback` : charge le module kernel
- `devices=1` : crée 1 device virtuel
- `video_nr=2` : spécifie le numéro du device (erreur s'il existe déjà)
- `card_label="VirtualCam"` : spécifie le nom du device
- `exclusive_caps=1` : pour la compatibilité avec les applications (simulation d'une caméra réelle, OUTPUT + CAPTURE)

Pour lister les caméras : `v4l2-ctl --list-devices`

= ffmpeg

Outil en ligne de commande pour manipuler des flux vidéo.

== Installation

#sourcecode[```sh
sudo apt install ffmpeg
```]

== Envoyer un flux vidéo vers la caméra virtuelle

#sourcecode[```sh
ffmpeg -re -stream_loop -1 -i video.mp4 -f v4l2 -pix_fmt yuv420p /dev/video2
```]

- `re` : real time (simule une vrai caméra sans envoyer toutes les frames en une fois)
- `stream_loop -1` : boucle infinie
- `i video.mp4` : vidéo à lancer
- `f v4l2` : format de sortie
- `pix_fmt yuv420p` : format utilisé par les vrai caméras
- `/dev/video2` : device de sortie

Important : il faut reload le module `v4l2loopback` avant chaque vidéo :

#sourcecode[```sh
sudo modprobe -r v4l2loopback
sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
```]

= Script d'automatisation

Ci-dessous un script qui automatise la création de la caméra virtuelle et l'envoi d'une vidéo :

#sourcecode[```sh
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

= CLI en python

J'ai commencé un CLI en python qui utilise la librairie `Typer`. J'ai réussi à générer une vidéo en passant par l'API de Kie.ai, mais je n'ai plus de crédits.

#sourcecode[```sh
python main.py generate \
--prompt "A realistic identity verification style video. The person is centered in frame, facing the camera with neutral expression. After a short pause, they slowly turn their head to the left, then to the right, and return to the center. No speech. Consistent indoor lighting, plain background, clear facial visibility, natural blinking, no exaggerated movements." \
--image ~/Downloads/TB/boy.png
```]

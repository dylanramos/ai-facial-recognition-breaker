#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Caméras virtuelles et redirection de flux vidéo"
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
  set text(size: 17pt)
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
  v(0.2cm)
}
#show heading.where(level: 2): it => {
  set text(size: 14pt)
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
  v(0.1cm)
}
#show heading.where(level: 3): it => {
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
}

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)


= Introduction

Pour pouvoir tromper les sites de vérification d'identité, il faut trouver un moyen de rediriger la vidéo générée vers une caméra détectée comme réelle par ceux-ci. La solution la plus simple est d'utiliser une caméra virtuelle, qui est un périphérique logiciel simulant une caméra physique.

== Comparaison des solutions

Le tableau ci-dessous compare les différentes solutions permettant de créer des caméras virtuelles :

#set par(justify: false)

#table(
  columns: (auto, auto, auto, auto, auto),
  align: horizon + center,
  [*Solution*], [*OS*], [*Open source*], [*Avantages*], [*Inconvénients*],
  [*v4l2loopback*], [Linux], [Oui], [Natif au noyau Linux, faible latence], [Linux uniquement],
  [*OBS Studio*],
  [Linux, Windows, macOS],
  [Oui],
  [Abstraction de l'OS],
  [Nécessite des actions manuelles, haute latence],

  [*UnityCapture*], [Windows], [Oui], [Caméra Windows native], [Windows uniquement],
  [*CoreMedia IO*], [macOS], [Non], [Caméra macOS native], [macOS uniquement],
)

#set par(justify: true)

= Caméras virtuelles sous Linux

Sous Linux, il existe un module noyau appelé `v4l2loopback` permettant de créer des périphériques vidéo virtuels. Avec `FFmpeg`, il est ensuite possible de rediriger un flux vidéo vers ces périphériques, qui seront détectés comme des caméras réelles par les applications.

Les commandes qui vont suivre ont été effectuées sur une machine *Ubuntu 24.04*.

== Installation

#sourcecode[```sh
sudo apt install v4l2loopback-dkms v4l2loopback-utils ffmpeg
```]

== Création d'une caméra virtuelle

La commande ci-dessous crée une caméra virtuelle appelée `VirtualCam` :

#sourcecode[```sh
sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
```]

- `modprobe v4l2loopback` : charge le module noyau.
- `devices=1` : crée 1 périphérique virtuel.
- `video_nr=2` : spécifie le numéro du périphérique (erreur s'il existe déjà).
- `card_label="VirtualCam"` : spécifie le nom du périphérique.
- `exclusive_caps=1` : rend la caméra compatible avec les applications (simule une caméra réelle).

Il est ensuite possible de lister les caméras disponibles :

#sourcecode[```sh
v4l2-ctl --list-devices
```]

== Envoi d'un flux vidéo vers la caméra virtuelle

La commande ci-dessous joue la vidéo `video.mp4` en boucle sur la caméra virtuelle :

#sourcecode[```sh
ffmpeg -re -stream_loop -1 -i video.mp4 -f v4l2 -pix_fmt yuv420p /dev/video2
```]

- `re` : temps réél (simule une vraie caméra sans envoyer toutes les images en une fois).
- `stream_loop -1` : boucle indéfiniment.
- `i video.mp4` : spécifie la vidéo à lancer.
- `f v4l2` : spécifie le format de sortie.
- `pix_fmt yuv420p` : spécifie le format de la vidéo (utilisé par les vraies caméras).
- `/dev/video2` : spécifie le périphérique de sortie.

=== Rechargement du module

Avant chaque diffusion de vidéo, il faut recharger le module `v4l2loopback` pour éviter les problèmes de conflits. Cela garantit que la caméra virtuelle est correctement réinitialisée et prête à recevoir le flux vidéo :

#sourcecode[```sh
sudo modprobe -r v4l2loopback
sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
```]

== Script d'automatisation

Le script ci-dessous automatise le processus de rechargement du module et de diffusion de la vidéo sur la caméra virtuelle :

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

Pour l'utiliser, il suffit de lancer la commande suivante :

#sourcecode[```sh
./runvirtcam.sh video.mp4
```]

= Caméras virtuelles sous Windows

Sous Windows, contrairement à Linux, il n'existe pas d'outils en ligne de commande permettant de créer des caméras virtuelles. Pour pouvoir créer une caméra virtuelle, il faut soit développer un driver customisé #footnote[https://medium.com/@sbonnet.dev/how-to-build-a-virtual-camera-under-linux-and-windows-7af0e6433796#3914], soit utiliser un logiciel proposant cette fonctionnalité.
`OBS Studio` par exemple, utilise la scène comme caméra virtuelle et permet de rediriger un flux vidéo vers celle-ci.

Les instructions qui vont suivre ont été effectuées sur une machine virtuelle *Windows 10 22H2*.

== Installation <obs-install>

Télécharger et installer `OBS Studio` : #underline(link("https://obsproject.com/")). Une fois le logiciel installé, la caméra virtuelle est automatiquement créée et est disponible sous le nom de `OBS Virtual Camera`.

== Envoi d'un flux vidéo vers la caméra virtuelle

+ Lancer `OBS Studio`.
+ Dans la section `Sources`, cliquer sur le bouton `+` et sélectionner `Media Source`.
+ Insérer le nom de la source.
+ Cocher `Local File` et `Loop`, sélectionner la vidéo à lancer dans `Local File`, puis cliquer sur `OK`.
+ Dans la section `Controls`, cliquer sur `Start Virtual Camera`.

La vidéo est maintenant diffusée en boucle sur la caméra virtuelle et est accessible aux applications, mais attention, la caméra n'apparaît pas dans le gestionnaire de périphériques Windows.

En effet, cela est dû au fait que c'est une caméra logicielle qui utilise le framework DirectShow, elle est donc enregistrée dynamiquement à l'exécution et n'est pas détectée comme un périphérique physique par le système d'exploitation #footnote[https://medium.com/deelvin-machine-learning/how-does-obs-virtual-camera-plugin-work-on-windows-e92ab8986c4e#0878]. Il est néanmoins possible de vérifier qu'elle existe vraiment en utilisant `FFmpeg` pour lister les périphériques vidéo disponibles :

#sourcecode[```sh
ffmpeg.exe -list_devices true -f dshow -i dummy
```]

== Automatisation

Comme vu dans le point précédent, la création de la source vidéo nécessite des actions manuelles, mais une fois celle-ci créée, il est tout à fait possible d'automatiser le lancement des vidéos via la ligne de commande. Comme pour Linux, il est possible d'envoyer un flux vidéo vers la caméra virtuelle en utilisant `FFmpeg`, cependant, pour que cela fonctionne avec `OBS Studio`, le flux doit être envoyé via le protocole `UDP`.

=== Création de la source vidéo

+ Lancer `OBS Studio`.
+ Dans la section `Sources`, cliquer sur le bouton `+` et sélectionner `Media Source`.
+ Insérer le nom de la source.
+ Décocher `Local File`.
+ Dans `Input`, entrer : `udp://127.0.0.1:1234` et cliquer sur `OK`.

Cette source vidéo est maintenant prête à recevoir un flux vidéo via `UDP` sur le port `1234`.

=== Envoi d'un flux vidéo vers la caméra virtuelle

La commande ci-dessous joue la vidéo `video.mp4` en boucle sur la caméra virtuelle de `OBS Studio` :

#sourcecode[```sh
ffmpeg.exe -re -stream_loop -1 -i video.mp4 -c:v libx264 -preset ultrafast -tune zerolatency -f mpegts "udp://127.0.0.1:1234?pkt_size=1316"
```]

- `re` : temps réél (simule une vraie caméra sans envoyer toutes les images en une fois).
- `stream_loop -1` : boucle indéfiniment.
- `i video.mp4` : spécifie la vidéo à lancer.
- `c:v libx264` : encode la vidéo en H.264 (format compatible avec OBS).
- `preset ultrafast` : utilise le preset d'encodage le plus rapide (réduit la qualité mais permet d'avoir une latence plus faible).
- `tune zerolatency` : optimise l'encodage pour réduire la latence.
- `f mpegts` : spécifie le format de sortie (MPEG-TS est un format de conteneur compatible avec le streaming en direct).
- `udp://127.0.0.1:1234?pkt_size=1316` : spécifie l'adresse et le port de destination du flux UDP, ainsi que la taille des paquets (1316 est une taille courante pour le streaming en direct).

= pyvirtualcam

La librairie Python `pyvirtualcam` permet d'envoyer un flux vidéo vers une caméra virtuelle existante, que ce soit sur Linux, Windows ou macOS. Elle a le grand avantage de gérer automatiquement les différentes étapes nécessaires pour que le flux vidéo soit correctement redirigé vers la caméra virtuelle. Ainsi, il est possible de s'affranchir de l'utilisation de `FFmpeg` et de la configuration de `OBS Studio`, le tout en étant compatible avec tous les systèmes d'exploitation.

== Exemple d'utilisation sur Windows

Pour que `pyvirtualcam` fonctionne sur Windows, il faut avoir une caméra virtuelle disponible. Dans cet exemple, la caméra virtuelle de `OBS Studio` est utilisée (voir le #underline()[@obs-install] pour l'installation).

=== Création de l'environnement virtuel

#sourcecode[```sh
python -m venv .venv
.venv\Scripts\activate
pip install pyvirtualcam opencv-python
```]

=== Exemple de code

#text(style: "italic")[Source : https://github.com/letmaik/pyvirtualcam/blob/main/examples/video.py]

#sourcecode[```python
# This script plays back a video file on the virtual camera.
# It also shows how to:
# - select a specific camera device
# - use BGR as pixel format

import argparse
import pyvirtualcam
from pyvirtualcam import PixelFormat
import cv2

parser = argparse.ArgumentParser()
parser.add_argument("video_path", help="path to input video file")
parser.add_argument("--fps", action="store_true", help="output fps every second")
parser.add_argument("--device", help="virtual camera device, e.g. /dev/video0 (optional)")
args = parser.parse_args()

video = cv2.VideoCapture(args.video_path)
if not video.isOpened():
    raise ValueError("error opening video")
length = int(video.get(cv2.CAP_PROP_FRAME_COUNT))
width = int(video.get(cv2.CAP_PROP_FRAME_WIDTH))
height = int(video.get(cv2.CAP_PROP_FRAME_HEIGHT))
fps = video.get(cv2.CAP_PROP_FPS)

with pyvirtualcam.Camera(width, height, fps, fmt=PixelFormat.BGR,
                         device=args.device, print_fps=args.fps) as cam:
    print(f'Virtual cam started: {cam.device} ({cam.width}x{cam.height} @ {cam.fps}fps)')
    count = 0
    while True:
        # Restart video on last frame.
        if count == length:
            count = 0
            video.set(cv2.CAP_PROP_POS_FRAMES, 0)

        # Read video frame.
        ret, frame = video.read()
        if not ret:
            raise RuntimeError('Error fetching frame')

        # Send to virtual cam.
        cam.send(frame)

        # Wait until it's time for the next frame
        cam.sleep_until_next_frame()

        count += 1
```]

=== Utilisation

#sourcecode[```sh
python video.py video.mp4
```]

La vidéo `video.mp4` est maintenant diffusée en boucle sur la caméra virtuelle de `OBS Studio`.

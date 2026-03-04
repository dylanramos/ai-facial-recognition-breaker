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

= Introduction

Pour pouvoir tromper les sites de vérification d'identité, il faut trouver un moyen de rediriger la vidéo générée vers une caméra détectée comme réelle par ceux-ci. La solution la plus simple est d'utiliser une caméra virtuelle, qui est un périphérique logiciel simulant une caméra physique. Sur Linux, il existe un module noyau appelé `v4l2loopback` qui permet de créer de tels périphériques. En utilisant `FFmpeg`, il est ensuite possible d'envoyer un flux vidéo vers la caméra virtuelle, qui sera alors détectée par les applications comme une caméra réelle.

== Pourquoi Linux ?

Linux est particulièrement adapté pour ce type de tâche car les différentes opérations peuvent être scriptées et automatisées facilement. De plus, Linux permet de reproduire les configurations sur d'autres machines via Docker par exemple, ce qui est idéal pour tester et déployer la solution.

= Installation

Les commandes qui vont suivre ont été effectuées sur une machine #underline("Ubuntu 24.04").

== v4l2loopback

#sourcecode[```sh
sudo apt install v4l2loopback-dkms v4l2loopback-utils
```]

== FFmpeg

#sourcecode[```sh
sudo apt install ffmpeg
```]

= Création d'une caméra virtuelle

La commande ci-dessous crée une caméra virtuelle appelée `VirtualCam` :

#sourcecode[```sh
sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
```]

- `modprobe v4l2loopback` : charge le module noyau
- `devices=1` : crée 1 périphérique virtuel
- `video_nr=2` : spécifie le numéro du périphérique (erreur s'il existe déjà)
- `card_label="VirtualCam"` : spécifie le nom du périphérique
- `exclusive_caps=1` : rend la caméra compatible avec les applications (simule une caméra réelle)

Il est ensuite possible de lister les caméras disponibles :

#sourcecode[```sh
v4l2-ctl --list-devices
```]

= Envoi d'un flux vidéo vers la caméra virtuelle

La commande ci-dessous joue la vidéo `video.mp4` en boucle sur la caméra virtuelle :

#sourcecode[```sh
ffmpeg -re -stream_loop -1 -i video.mp4 -f v4l2 -pix_fmt yuv420p /dev/video2
```]

- `re` : temps réél (simule une vraie caméra sans envoyer toutes les images en une fois)
- `stream_loop -1` : boucle indéfiniment
- `i video.mp4` : spécifie la vidéo à lancer
- `f v4l2` : spécifie le format de sortie
- `pix_fmt yuv420p` : spécifie le format de la vidéo (utilisé par les vraies caméras)
- `/dev/video2` : spécifie le périphérique de sortie

== Rechargement du module

Avant chaque diffusion de vidéo, il faut recharger le module `v4l2loopback` pour éviter les problèmes de conflits. Cela garantit que la caméra virtuelle est correctement réinitialisée et prête à recevoir le flux vidéo :

#sourcecode[```sh
sudo modprobe -r v4l2loopback
sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
```]

= Script d'automatisation

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

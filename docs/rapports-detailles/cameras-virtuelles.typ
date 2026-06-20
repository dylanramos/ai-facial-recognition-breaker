#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Caméras virtuelles et diffusion de flux vidéo"
#let location_and_date = [Yverdon-les-Bains, le #datetime.today().display("[day].[month].[year]")]
#let academic_year = "2025-2026"

// Page de garde

#grid(
  columns: (1fr, 2fr),
  align: (left, right),
  image("../images/logo-heig-vd.png", width: 3cm),
  [
    Département des Technologies de l'information et de la communication (TIC) \
    Filière Informatique et systèmes de communication \
    Orientation Sécurité informatique
  ],
)

#v(4cm)
#align(center, text(weight: "bold", size: 14pt)[Rapport détaillé])
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

#outline(title: "Table des matières")

#pagebreak()

#outline(title: "Table des figures", target: figure)

#pagebreak()

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

Ce rapport détaillé est rédigé dans le cadre de mon travail de bachelor qui vise à démontrer les risques de la vérification d'identité en ligne avec l'avénement des outils d'IA. Une fois la vidéo générée par IA, encore faut-il pouvoir la présenter à un site de vérification d'identité comme si elle provenait d'une vraie caméra. Le maillon technique entre la vidéo générée et le système de vérification est la caméra virtuelle, un périphérique logiciel qui simule une caméra physique aux yeux du système d'exploitation et des applications.

Chaque système d'exploitation gère les caméras virtuelles différemment. Sous Linux, un module noyau dédié suffit #footnote[https://github.com/v4l2loopback/v4l2loopback], tandis que sous Windows, il faut recourir à un logiciel tiers ou développer un pilote personnalisé #footnote[https://medium.com/deelvin-machine-learning/how-does-obs-virtual-camera-plugin-work-on-windows-e92ab8986c4e#0878]. Ce rapport présente les solutions existantes pour créer des caméras virtuelles sur Linux et Windows, les étapes pour y diffuser un flux vidéo, leur utilisation dans un émulateur Android pour les sites imposant une vérification sur smartphone ainsi que les librairies Python disponibles pour automatiser l'ensemble du processus dans le cadre du démonstrateur.

= Caméras virtuelles sous Linux

Sous Linux, il existe un module noyau appelé `v4l2loopback` permettant de créer des périphériques vidéo virtuels. Avec `FFmpeg`, il est ensuite possible de diffuser un flux vidéo vers ces périphériques, qui seront détectés comme des caméras physiques par les applications.

Les commandes qui vont suivre ont été effectuées sur une machine *Ubuntu 26.04*.

== Installation

#figure(
  sourcecode[```sh
  sudo apt install v4l2loopback-dkms v4l2loopback-utils ffmpeg
  ```],
  caption: [Installation de `v4l2loopback` et `FFmpeg` sur Ubuntu.],
)

== Création d'une caméra virtuelle <v4l2loopback-install>

La commande ci-dessous crée une caméra virtuelle appelée `VirtualCam` :

#figure(
  sourcecode[```sh
  sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
  ```],
  caption: [Création d'une caméra virtuelle avec `v4l2loopback`.],
)

- `modprobe v4l2loopback` : charge le module noyau.
- `devices=1` : crée 1 périphérique virtuel.
- `video_nr=2` : spécifie le numéro du périphérique (erreur s'il existe déjà).
- `card_label="VirtualCam"` : spécifie le nom du périphérique.
- `exclusive_caps=1` : rend la caméra compatible avec les applications (simule une caméra physique).

Il est ensuite possible de lister les caméras disponibles :

#figure(
  sourcecode[```sh
  v4l2-ctl --list-devices
  ```],
  caption: [Énumération des caméras disponibles avec `v4l2loopback`.],
)

== Diffusion d'un flux vidéo vers la caméra virtuelle <v4l2loopback-stream>

La commande ci-dessous joue la vidéo `video.mp4` en boucle sur la caméra virtuelle :

#figure(
  sourcecode[```sh
  ffmpeg -re -stream_loop -1 -i video.mp4 -f v4l2 -pix_fmt yuv420p /dev/video2
  ```],
  caption: [Diffusion d'une vidéo sur une caméra virtuelle sous Linux.],
)

- `re` : temps réél (simule une vraie caméra sans envoyer toutes les images en une fois).
- `stream_loop -1` : boucle indéfiniment.
- `i video.mp4` : spécifie la vidéo à lancer.
- `f v4l2` : spécifie le format de sortie.
- `pix_fmt yuv420p` : spécifie le format de la vidéo (utilisé par les vraies caméras).
- `/dev/video2` : spécifie le périphérique de sortie.

À noter qu'avant chaque diffusion de vidéo, il faut recharger le module `v4l2loopback` pour éviter les problèmes de conflits. Cela garantit que la caméra virtuelle est correctement réinitialisée et prête à recevoir le flux vidéo :

#figure(
  sourcecode[```sh
  sudo modprobe -r v4l2loopback
  sudo modprobe v4l2loopback devices=1 video_nr=2 card_label="VirtualCam" exclusive_caps=1
  ```],
  caption: [Rechargement du module `v4l2loopback`.],
)

== Script d'automatisation

Le script ci-dessous automatise le processus de rechargement du module et de diffusion de la vidéo sur la caméra virtuelle :

#pagebreak()

#figure(
  sourcecode[```sh
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
  ```],
  caption: [Script d'automatisation pour diffuser une vidéo sur une caméra virtuelle sous Linux.],
)

Pour l'utiliser, il suffit de lancer la commande suivante :

#figure(
  sourcecode[```sh
  ./runvirtcam.sh video.mp4
  ```],
  caption: [Lancement du script d'automatisation pour diffuser une vidéo sur la caméra virtuelle.],
)

= Caméras virtuelles sous Windows

Sous Windows, contrairement à Linux, il n'existe pas d'outils en ligne de commande permettant de créer des caméras virtuelles. Pour pouvoir créer une caméra virtuelle, il faut soit développer un pilote customisé #footnote[https://medium.com/@sbonnet.dev/how-to-build-a-virtual-camera-under-linux-and-windows-7af0e6433796#3914], soit utiliser un logiciel proposant cette fonctionnalité.
OBS Studio par exemple, utilise la scène comme caméra virtuelle et permet de diffuser un flux vidéo vers celle-ci.

Les instructions qui vont suivre ont été effectuées sur une machine virtuelle *Windows 11 25H2*.

== Installation <obs-install>

Télécharger et installer OBS Studio : #underline(link("https://obsproject.com/")). Une fois le logiciel installé, la caméra virtuelle est automatiquement créée et est disponible sous le nom de `OBS Virtual Camera`.

== Diffusion d'un flux vidéo vers la caméra virtuelle

+ Lancer OBS Studio.
+ Dans la section `Sources`, cliquer sur le bouton `+` et sélectionner `Media Source`.
+ Insérer le nom de la source.
+ Cocher `Local File` et `Loop`, sélectionner la vidéo à lancer dans `Local File`, puis cliquer sur `OK`.
+ Dans la section `Controls`, cliquer sur `Start Virtual Camera`.

La vidéo est maintenant diffusée en boucle sur la caméra virtuelle et est accessible aux applications, mais attention, la caméra n'apparaît pas dans le gestionnaire de périphériques Windows.

En effet, cela est dû au fait que c'est une caméra logicielle qui utilise le framework DirectShow, elle est donc enregistrée dynamiquement à l'exécution et n'est pas détectée comme un périphérique physique par l'OS #footnote[https://medium.com/deelvin-machine-learning/how-does-obs-virtual-camera-plugin-work-on-windows-e92ab8986c4e#0878]. Il est néanmoins possible de vérifier qu'elle existe vraiment en utilisant `FFmpeg` pour lister les périphériques vidéo disponibles :

#figure(
  sourcecode[```sh
  ffmpeg.exe -list_devices true -f dshow -i dummy
  ```],
  caption: [Énumération des périphériques vidéo disponibles avec `FFmpeg` sur Windows.],
)

== Automatisation

Comme vu dans le point précédent, la création de la source vidéo nécessite des actions manuelles, mais une fois celle-ci créée, il est tout à fait possible d'automatiser le lancement des vidéos via la ligne de commande. Comme pour Linux, il est possible de diffuser un flux vidéo vers la caméra virtuelle en utilisant `FFmpeg`, cependant, pour que cela fonctionne avec OBS Studio, le flux doit être envoyé via le protocole `UDP`, ce qui ajoute de la latence.

=== Création de la source vidéo

+ Lancer OBS Studio.
+ Dans la section `Sources`, cliquer sur le bouton `+` et sélectionner `Media Source`.
+ Insérer le nom de la source.
+ Décocher `Local File`.
+ Dans `Input`, entrer : `udp://127.0.0.1:1234` et cliquer sur `OK`.

Cette source vidéo est maintenant prête à recevoir un flux vidéo via `UDP` sur le port `1234`.

=== Diffusion d'un flux vidéo vers la caméra virtuelle

La commande ci-dessous joue la vidéo `video.mp4` en boucle sur la caméra virtuelle de OBS Studio :

#figure(
  sourcecode[```sh
  ffmpeg.exe -re -stream_loop -1 -i video.mp4 -c:v libx264 -preset ultrafast -tune zerolatency -f mpegts "udp://127.0.0.1:1234?pkt_size=1316"
  ```],
  caption: [Diffusion d'une vidéo sur une caméra virtuelle sous Windows en utilisant `FFmpeg`.],
)

- `re` : temps réél (simule une vraie caméra sans envoyer toutes les images en une fois).
- `stream_loop -1` : boucle indéfiniment.
- `i video.mp4` : spécifie la vidéo à lancer.
- `c:v libx264` : encode la vidéo en H.264 (format compatible avec OBS).
- `preset ultrafast` : utilise le preset d'encodage le plus rapide (réduit la qualité mais permet d'avoir une latence plus faible).
- `tune zerolatency` : optimise l'encodage pour réduire la latence.
- `f mpegts` : spécifie le format de sortie (MPEG-TS est un format de conteneur compatible avec le streaming en direct).
- `udp://127.0.0.1:1234?pkt_size=1316` : spécifie l'adresse et le port de destination du flux UDP, ainsi que la taille des paquets (1316 est une taille courante pour le streaming en direct).

= Comparaison des solutions

Comme vu dans les chapitres précédents, l'utilisation d'une caméra virtuelle sous Linux est relativement simple grâce à `v4l2loopback` et `FFmpeg`, tandis que sous Windows, il est nécessaire d'utiliser un logiciel tiers comme OBS Studio pour créer une caméra virtuelle, ce qui ajoute des étapes manuelles ou de la latence si l'on souhaite automatiser le processus avec `FFmpeg`.

#set par(justify: false)

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: horizon + center,
    [*Solution*], [*OS*], [*Avantages*], [*Inconvénients*],
    [*v4l2loopback + FFmpeg*],
    [Linux],
    [Facilement automatisable, faible latence, pas de dépendance à un logiciel tiers],
    [Linux uniquement],

    [*OBS Studio + FFmpeg*],
    [Linux, Windows],
    [Abstraction de l'OS, multi-plateforme],
    [Nécessite des actions manuelles, haute latence, dépendance à un logiciel tiers],

    [*OBS Studio*], [Linux, Windows], [Abstraction de l'OS, multi-plateforme], [Pas d'automatisation possible],
  ),
  caption: "Comparaison des solutions de caméras virtuelles et de diffusion de flux vidéo sous Linux et Windows.",
)

#set par(justify: true)

Ainsi, la solution v4l2loopback + FFmpeg sous Linux semble être la plus adaptée pour le développement du démonstrateur (CLI), car elle permet d'automatiser entièrement le processus de création de la caméra virtuelle et de diffusion du flux vidéo, le tout avec une latence faible et sans dépendance à un logiciel tiers.

= Utilisation d'une caméra virtuelle sur un émulateur Android (Linux)

Certains sites demandent de vérifier l'identité de l'utilisateur sur un téléphone plutôt que sur un ordinateur, il faut donc que la caméra virtuelle de la machine hôte soit détectée par les émulateurs Android. L'exemple ci-dessous utilise `Genymotion` comme émulateur Android (sous Linux) car il est plus rapide et plus léger que l'émulateur de Android Studio.

== Installation de Genymotion

+ Télécharger `Genymotion` : #underline(link("https://www.genymotion.com/product-desktop/download/")).
+ Installer `Genymotion`.
  #sourcecode[```sh
  chmod +x genymotion-3.10.0-linux_x64.run
  ./genymotion-3.10.0-linux_x64.run
  ```]
+ Lancer `Genymotion` et créer un compte.
+ Dans l'onglet `Devices`, cliquer sur `Create` puis sur `Install` en laissant les paramètres par défaut.

#figure(
  rect(image("../images/04-cameras-virtuelles/genymotion.png"), stroke: 0.1pt),
  caption: [Interface de `Genymotion` après la création d'un appareil virtuel.],
)

== Utilisation de la caméra virtuelle de la machine hôte

+ Diffuser une vidéo sur la caméra virtuelle de la machine hôte (voir #underline()[@v4l2loopback-stream])
+ Lancer l'appareil virtuel créé précédemment (bouton `Play`).
+ Une fois l'appareil démarré, cliquer sur `Media injection` (icône de la caméra dans la barre d'outils à droite).
+ Sélectionner la caméra virtuelle dans la section `Video` de `Inputs mapping`.

#figure(
  rect(image("../images/04-cameras-virtuelles/genymotion-cam.png"), stroke: 0.1pt),
  caption: [Utilisation de la caméra virtuelle de la machine hôte dans `Genymotion`.],
)

= Librairies Python pour la diffusion de flux vidéo vers une caméra virtuelle

Pour développer le démonstrateur, il est nécessaire de pouvoir diffuser un flux vidéo vers une caméra virtuelle de manière programmatique. Il existe plusieurs librairies Python permettant de faire cela, avec chacune leurs avantages et leurs inconvénients.

== pyvirtualcam

La librairie Python `pyvirtualcam` permet d'envoyer un flux vidéo vers une caméra virtuelle existante, que ce soit sur Linux ou Windows. Elle a le grand avantage de gérer automatiquement les différentes étapes nécessaires pour que le flux vidéo soit correctement redirigé vers la caméra virtuelle. Ainsi, il est possible de s'affranchir de l'utilisation de `FFmpeg` et de la configuration de OBS Studio, le tout en étant compatible avec tous les OS.

Mais attention, `pyvirtualcam` nécessite que les caméras virtuelles soient déjà créées, ce qui implique de devoir installer une solution de caméra virtuelle adaptée à son OS (voir #underline()[@v4l2loopback-install] pour Linux et #underline()[@obs-install] pour Windows).

L'exemple ci-dessous montre comment utiliser `pyvirtualcam` sur Windows. Dans cet exemple, la caméra virtuelle de OBS Studio est utilisée (voir le #underline()[@obs-install] pour l'installation).

Création de l'environnement virtuel :

#figure(
  sourcecode[```sh
  python -m venv .venv
  .venv\Scripts\activate
  pip install pyvirtualcam opencv-python
  ```],
  caption: [Création d'un environnement virtuel Python et installation des dépendances.],
)

Exemple de code :

#text(style: "italic")[Source : https://github.com/letmaik/pyvirtualcam/blob/main/examples/video.py]

#figure(
  sourcecode[```python
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
  ```],
  caption: [Exemple de code Python utilisant `pyvirtualcam` pour diffuser une vidéo sur une caméra virtuelle.],
)

Utilisation :

#figure(
  sourcecode[```sh
  python video.py video.mp4
  ```],
  caption: [Lancement du script Python pour diffuser une vidéo sur la caméra virtuelle.],
)

La vidéo `video.mp4` est maintenant diffusée en boucle sur la caméra virtuelle de OBS Studio.

== ffmpeg-python

La librairie `ffmpeg-python` est une interface Python qui permet de construire des commandes `FFmpeg` de manière programmatique. L'avantage de cette librairie est qu'elle offre plus de flexibilité que `pyvirtualcam`, notamment en permettant de rogner la vidéo, changer sa résolution, changer le format des pixels, etc. Un autre avantage est qu'elle permet de diffuser une image statique comme une vidéo, ce qui est utile pour simuler une caméra scanant une pièce d'identité. Par contre, elle implique l'utilisation de `FFmpeg` or, comme vu précédemment, l'utilisation de `FFmpeg` avec OBS Studio sur Windows implique de devoir diffuser le flux vidéo via `UDP`, ce qui ajoute de la latence.

L'exemple ci-dessous montre comment utiliser `ffmpeg-python` sur Linux. Pour que cet exemple fonctionne, il faut avoir une caméra virtuelle disponible (voir le #underline()[@v4l2loopback-install] pour l'installation) ainsi que `FFmpeg` installé.

Création de l'environnement virtuel :

#figure(
  sourcecode[```sh
  python3 -m venv .venv
  source .venv/bin/activate
  pip install ffmpeg-python
  ```],
  caption: [Création d'un environnement virtuel Python et installation de `ffmpeg-python`.],
)

Exemple de code :

#figure(
  sourcecode[```python
  import ffmpeg
  import sys


  def main(arg1):
      ffmpeg.input(arg1, re=None, stream_loop=-1).filter("scale", 640, 480).filter("fps", 30).output("/dev/video2", format="v4l2", pix_fmt="yuv420p").run()


  if __name__ == "__main__":
      if len(sys.argv) != 2:
          print("Usage: python main.py <video_file>")
          sys.exit(1)
      main(sys.argv[1])

  ```],
  caption: [Exemple de code Python utilisant `ffmpeg-python` pour diffuser une vidéo sur une caméra virtuelle.],
)

Utilisation :

#figure(
  sourcecode[```sh
  python main.py video.mp4
  ```],
  caption: [Lancement du script Python pour diffuser une vidéo sur la caméra virtuelle.],
)

La vidéo passée en argument est maintenant diffusée en boucle sur la caméra virtuelle `/dev/video2`.

== Comparaison des librairies

Les librairies `pyvirtualcam` et `ffmpeg-python` permettent d'atteindre le même objectif, diffuser une vidéo sur une caméra virtuelle créée préalablement. `pyvirtualcam` est multiplateforme mais moins flexible que `ffmpeg-python` car elle ne permet pas d'éditer les vidéos ni de diffuser des images statiques. Cependant, `ffmpeg-python` bien que multiplateforme également, est moins efficace sur Windows lorsqu'elle est utilisée avec OBS Studio car elle nécessite de diffuser le flux vidéo via `UDP`, ce qui ajoute de la latence.

#figure(
  rect(image("../images/04-cameras-virtuelles/libs-compare.png"), stroke: 0.1pt),
  caption: [Comparaison de `pyvirtualcam` et `ffmpeg-python` pour diffuser un flux vidéo vers une caméra virtuelle.],
)

= Conclusion

Ce rapport a permis d'identifier et de valider les solutions techniques nécessaires pour diffuser un flux vidéo généré par IA vers une caméra virtuelle, condition indispensable pour mener les attaques contre les systèmes de vérification d'identité en ligne.

Pour la plateforme Linux, la combinaison `v4l2loopback` et `FFmpeg` s'est imposée comme la solution la plus adaptée au démonstrateur. En effet, elle est entièrement automatisable, a une faible latence et ne dépend pas d'un logiciel tiers. Sous Windows, OBS Studio constitue l'alternative principale, au prix d'étapes manuelles ou d'une latence accrue lors de l'automatisation via UDP. Pour les sites exigeant une vérification sur smartphone, l'émulateur `Genymotion` sous Linux permet d'injecter le flux de la caméra virtuelle de la machine hôte directement dans l'appareil Android virtuel, couvrant ainsi ce cas d'usage sans nécessiter de vrai téléphone.

Côté librairies Python, `ffmpeg-python` a été retenue pour le développement du démonstrateur en raison de sa flexibilité, notamment pour la possibilité de diffuser des images statiques et d'éditer les vidéos à la volée. L'ensemble de ces briques techniques forme le socle d'injection vidéo sur lequel s'appuieront les attaques décrites dans les rapports suivants.

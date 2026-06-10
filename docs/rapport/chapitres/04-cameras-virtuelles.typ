#import "@preview/codelst:2.0.2": sourcecode

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Caméras virtuelles et redirection de flux vidéo

== Introduction

Pour pouvoir tromper les sites de vérification d'identité, il faut trouver un moyen de rediriger la vidéo générée vers une caméra détectée comme réelle par ceux-ci. La solution la plus simple est d'utiliser une caméra virtuelle, qui est un périphérique logiciel simulant une caméra physique.

Chaque OS a sa propre manière de gérer les caméras virtuelles. Sous Linux, il faut passer par un module du noyau dédié, alors que sous Windows, il faut développer son propre pilote de caméra virtuelle @virtual-camera. Les chapitres 3 et 4 du rapport de recherche #link("../rapports-de-recherche/cameras-virtuelles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")] expliquent en détail comment mettre en place une caméra virtuelle sous Linux et Windows et comment y rediriger un flux vidéo manuellement.

== Comparaison des solutions

L'objectif n'est pas de développer une caméra virtuelle de zéro, mais plutôt d'utiliser une solution existante qui la crée automatiquement. Le tableau ci-dessous compare les différentes solutions permettant de créer des caméras virtuelles :

#set par(justify: false)

#figure(
  table(
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
  ),
  caption: "Comparaison des différentes solutions de caméras virtuelles.",
)

#set par(justify: true)

Ces solutions permettent toutes de créer une caméra virtuelle, mais pour y rediriger un flux vidéo, elles nécessitent soit l'utilisation d'un logiciel à part, soit des actions manuelles. Par exemple :
- Sous Linux, il est possible d'utiliser `FFmpeg` pour rediriger un flux vidéo vers la caméra virtuelle créée avec `v4l2loopback`.
- Sous Windows et macOS, il est nécessaire de manuellement créer une source vidéo dans `OBS Studio` pour rediriger un flux vidéo vers la caméra virtuelle.

== pyvirtualcam

Pour éviter de devoir s'adapter à chaque OS et pour simplifier le développement du démonstrateur, il est possible d'utiliser une librairie Python appelée `pyvirtualcam`. Cette librairie a le grand avantage de gérer automatiquement les différentes étapes nécessaires pour que le flux vidéo soit correctement redirigé vers la caméra virtuelle. Ainsi, il est possible de s'affranchir de l'utilisation de `FFmpeg` et de la configuration de `OBS Studio`, le tout en étant compatible avec tous les OS.

Mais attention, `pyvirtualcam` nécessite que les caméras virtuelles soient déjà créées, ce qui implique de devoir installer une solution de caméra virtuelle adaptée à son OS (voir le chapitre 3.2 (Linux) et 4.1 (Windows/MacOS) du rapport de recherche #link("../rapports-de-recherche/cameras-virtuelles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")]).

#figure(
  rect(image("../../images/04-cameras-virtuelles/libs-compare.png"), stroke: 0.1pt),
  caption: [Comparaison avec `pyvirtualcam` et sans `pyvirtualcam` pour rediriger un flux vidéo vers une caméra virtuelle.],
)

L'exemple de code ci-dessous permet de lancer une vidéo en boucle sur une caméra virtuelle. À noter que, quel que soit l'OS utilisé, `pyvirtualcam` détecte automatiquement la caméra virtuelle, à condition que celle-ci existe.

#figure(
  sourcecode[```python
  # Source : https://github.com/letmaik/pyvirtualcam/blob/main/examples/video.py

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

Le chapitre 5.1 du rapport de recherche #link("../rapports-de-recherche/cameras-virtuelles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")] présente une marche à suivre détaillée pour utiliser ce code.

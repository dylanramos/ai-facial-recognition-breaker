#import "@preview/codelst:2.0.2": sourcecode

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Caméras virtuelles et diffusion de flux vidéo

== Introduction

Contourner un système de vérification d'identité nécessite de pouvoir injecter une vidéo générée par IA dans le flux capturé par l'application comme si elle provenait d'une caméra physique. La caméra virtuelle est la solution retenue, il s'agit d'un périphérique logiciel qui se comporte du point de vue du système, comme une webcam réelle.

La prise en charge des caméras virtuelles varie selon les systèmes d'exploitation. Sous Linux, elle repose sur un module du noyau dédié, tandis que sous Windows, elle requiert le développement d'un pilote spécifique @virtual-camera.

== Solutions

L'objectif n'est pas de développer une caméra virtuelle de zéro, mais plutôt d'utiliser une solution existante qui la crée automatiquement.

=== Linux

Sous Linux, il existe un module noyau appelé `v4l2loopback` permettant de créer des périphériques vidéo virtuels @v4l2loopback-ref. Avec `FFmpeg`, il est ensuite possible de diffuser un flux vidéo vers ces périphériques, qui seront détectés comme des caméras réelles par les applications.

Le chapitre 2 du rapport détaillé #link("../rapports-detailles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")] explique en détail comment installer `v4l2loopback` et comment utiliser `FFmpeg` pour diffuser un flux vidéo vers la caméra virtuelle créée.

=== Windows <04-windows>

Sous Windows, il n'existe pas d'outils en ligne de commande permettant de créer des caméras virtuelles. Pour pouvoir créer une caméra virtuelle, il faut soit développer un pilote customisé @virtual-camera, soit utiliser un logiciel proposant cette fonctionnalité. OBS Studio par exemple, utilise la scène comme caméra virtuelle et permet de diffuser un flux vidéo vers celle-ci. Le problème avec ce type de logiciels, c'est qu'ils nécessitent des actions manuelles, notamment pour créer la caméra virtuelle et pour y diffuser un flux vidéo.

Comme l'explique le chapitre 3.3 du rapport détaillé #link("../rapports-detailles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")], l'utilisation de `FFmpeg` combinée à OBS Studio pour automatiser la diffusion d'un flux vidéo est possible, cependant, cela nécessite de devoir envoyer le flux via le protocole `UDP` à OBS Studio, ce qui engendre une latence importante.

=== Comparaison des solutions

Le tableau ci-dessous résume les différentes possibilités de création de caméras virtuelles et de diffusion de flux vidéo.

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

== Librairies Python pour la diffusion de flux vidéo vers une caméra virtuelle

Pour développer le démonstrateur, il est nécessaire de pouvoir diffuser un flux vidéo vers une caméra virtuelle de manière programmatique. Il existe plusieurs librairies Python permettant de faire cela.

=== pyvirtualcam

La librairie Python `pyvirtualcam` permet d'envoyer un flux vidéo vers une caméra virtuelle existante, que ce soit sur Linux ou Windows @pyvirtualcam-ref. Elle a le grand avantage de gérer automatiquement les différentes étapes nécessaires pour que le flux vidéo soit correctement diffusé vers la caméra virtuelle. Ainsi, il est possible de s'affranchir de l'utilisation de `FFmpeg` et de la configuration de OBS Studio, le tout en étant compatible avec tous les OS.

L'exemple de code Python ci-dessous montre comment diffuser un flux vidéo en boucle vers une caméra virtuelle en utilisant `pyvirtualcam` :

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

Une marche à suivre pour installer `pyvirtualcam` et utiliser cet exemple de code est disponible dans le chapitre 6.1 du rapport détaillé #link("../rapports-detailles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")].

=== ffmpeg-python

La librairie `ffmpeg-python` est une interface Python qui permet de construire des commandes `FFmpeg` de manière programmatique @ffmpeg-python-ref. L'avantage de cette librairie est qu'elle offre plus de flexibilité que `pyvirtualcam`, notamment en permettant de rogner la vidéo, changer sa résolution, changer le format des pixels, etc. Un autre avantage est qu'elle permet de diffuser une image statique comme une vidéo, ce qui est utile pour simuler une caméra scannant une pièce d'identité. Par contre, elle implique l'utilisation de `FFmpeg` or, comme vu au #underline[@04-windows], l'utilisation de `FFmpeg` avec OBS Studio sur Windows implique de devoir diffuser le flux vidéo via le protocole `UDP`, ce qui ajoute de la latence.

L'exemple de code Python ci-dessous montre comment diffuser un flux vidéo en boucle vers la caméra virtuelle `/dev/video2` en utilisant `ffmpeg-python` :

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

Une marche à suivre pour installer `ffmpeg-python` et utiliser cet exemple de code est disponible dans le chapitre 6.2 du rapport détaillé #link("../rapports-detailles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")].

=== Comparaison des librairies

Les librairies `pyvirtualcam` et `ffmpeg-python` permettent d'atteindre le même objectif, diffuser une vidéo sur une caméra virtuelle créée préalablement. `pyvirtualcam` est multiplateforme mais moins flexible que `ffmpeg-python` car elle ne permet pas d'éditer les vidéos ni de diffuser des images statiques. Cependant, `ffmpeg-python` bien que multiplateforme également, est moins efficace sur Windows lorsqu'elle est utilisée avec OBS Studio car elle nécessite de diffuser le flux vidéo via le protocole `UDP`, ce qui engendre une latence importante.

#figure(
  rect(image("../../images/04-cameras-virtuelles/libs-compare.png"), stroke: 0.1pt),
  caption: [Comparaison de `pyvirtualcam` et `ffmpeg-python` pour diffuser un flux vidéo vers une caméra virtuelle.],
)

== Conclusion

Ce chapitre a établi que la combinaison `v4l2loopback` + `ffmpeg-python` sous Linux est la solution la plus adaptée au démonstrateur, car elle est entièrement automatisable, sans latence notable et sans dépendance à un logiciel tiers.

Avec les modèles de génération IA sélectionnés au chapitre précédent et la couche de diffusion vidéo désormais définie, les éléments techniques nécessaires aux attaques sont en place. Le chapitre suivant présente les scénarios d'attaque du démonstrateur qui les intègre.

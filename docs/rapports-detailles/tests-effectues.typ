#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Tests effectués"
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

Certains sites candidats n'ont pas pu être contournés, soit parce qu'ils utilisent une technologie de vérification d'identité plus avancée que les autres, soit parce que la vérification d'identité est intégrée à un processus plus complexe qui rend le contournement plus difficile. Ce document présente les différents tests effectués dans l'ordre chronologique pour tenter de comprendre et de contourner les systèmes de vérification par selfie vidéo et par scan de documents d'identité.

= Tests effectués pour les selfies vidéo

== Comparaison des caméras

Il es possible que le système de vérification analyse les caractéristiques des caméras pour vérifier si celles-ci sont bien réelles. La première chose que j'ai essayé de faire est de comparer les caractéristiques de ma caméra réelle avec celles d'une caméra virtuelle en allant sur le site #underline[#link("https://webcamtests.com/")].

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/08-attaques-non-reussies/real-camera.png"), stroke: 0.1pt),
    caption: "Caractéristiques de la caméra réelle.",
  ),
  [#figure(
    rect(image("../images/08-attaques-non-reussies/fake-camera.png"), stroke: 0.1pt),
    caption: "Caractéristiques de la caméra virtuelle.",
  )<fake-camera>],
)

Nous pouvons voir que mis à part le nom de la caméra, rien n'indique que la #underline[@fake-camera] est une caméra virtuelle, en effet, les caméras ont les mêmes megapixels (0.31 MP), résolutions (640x480) et formats d'image (1.33). D'autre part, toutes les informations en dessous de "Aspect Ratio" sont différentes, mais cela est normal car elles dépendent du contenu de la vidéo et non de la caméra elle-même. Un point intéressant à noter est que la caméra virtuelle a une fréquence d'images de 31 fps alors que la caméra réelle en a une de 30 fps, ce qui pourrait suggérer une source logicielle dont la synchronisation n'est pas liée à une horloge matérielle. Mais cela n'est pas suffisant pour conclure que la caméra virtuelle est détectée comme telle car une instabilité de mesure pourrait faire passer une valeur réelle de 30 à une valeur affichée de 31.

== Analyse des métadonnées des vidéos

Étant donné que les caractéristiques des deux caméras sont plutôt similaires, je me suis penché sur l'analyse des métadonnées des vidéos diffusées. Pour cela, j'ai commencé par installer ExifTool, un outil en ligne de commande qui permet d'extraire et de modifier les métadonnées des fichiers multimédias #footnote[https://exiftool.org/].

J'ai ensuite repris une vidéo générée par le modèle HappyHorse 1.0 pour analyser ses métadonnées.

#sourcecode[```sh
exiftool happyhorse-1-0.mp4
```]

#sourcecode[```
ExifTool Version Number         : 13.58
File Name                       : happyhorse-1-0.mp4
Directory                       : .
File Size                       : 1934 kB
File Modification Date/Time     : 2026:06:09 10:18:35+02:00
File Access Date/Time           : 2026:06:17 13:16:33+02:00
File Inode Change Date/Time     : 2026:06:10 14:38:42+02:00
File Permissions                : -rw-rw-r--
File Type                       : MP4
File Type Extension             : mp4
MIME Type                       : video/mp4
Media Data Size                 : 1928320
Media Data Offset               : 48
Movie Header Version            : 0
Create Date                     : 0000:00:00 00:00:00
Modify Date                     : 0000:00:00 00:00:00
Time Scale                      : 1000
Duration                        : 5.16 s
Preferred Rate                  : 1
Preferred Volume                : 100.00%
Preview Time                    : 0 s
Preview Duration                : 0 s
Poster Time                     : 0 s
Selection Time                  : 0 s
Selection Duration              : 0 s
Current Time                    : 0 s
Next Track ID                   : 3
Track Header Version            : 0
Track Create Date               : 0000:00:00 00:00:00
Track Modify Date               : 0000:00:00 00:00:00
Track ID                        : 1
Track Duration                  : 5.04 s
Track Layer                     : 0
Track Volume                    : 0.00%
Image Width                     : 960
Image Height                    : 960
Graphics Mode                   : srcCopy
Op Color                        : 0 0 0
Compressor ID                   : avc1
Source Image Width              : 960
Source Image Height             : 960
X Resolution                    : 72
Y Resolution                    : 72
Bit Depth                       : 24
Buffer Size                     : 0
Max Bitrate                     : 2936812
Average Bitrate                 : 2936812
Video Frame Rate                : 24
Matrix Structure                : 1 0 0 0 1 0 0 0 1
Media Header Version            : 0
Media Create Date               : 0000:00:00 00:00:00
Media Modify Date               : 0000:00:00 00:00:00
Media Time Scale                : 24000
Media Duration                  : 5.16 s
Media Language Code             : und
Handler Description             : SoundHandler
Balance                         : 0
Audio Format                    : mp4a
Audio Channels                  : 2
Audio Bits Per Sample           : 16
Audio Sample Rate               : 24000
Handler Type                    : Metadata Tags
Major Brand                     : isom
Minor Version                   : 512
Compatible Brands               : isomiso2avc1mp41
AIGC                            : {"Label":"1",."ContentProducer":"001191330106MA2CFLDG4R10001",."ProduceID":"R-RI_4brMNTYm1kmZsehYuWw",."ReservedCode1":"K-LBkc9peJ0GoxPECtYBct7vfZZgZvwy4FZrhe/DJovt3rGFEyBJ4z5WZYsl9yWMbL+j6YI/dnc0TvjwK1pNQvH/PdtPaJhFM6N06bmQdVF5NX2uq7GlOEtaQq7CYg3wLYt1zAC4pMfsQoUzUlix
OEmtUgRhPibmjNhqlnGv8I8K2UL4nJuZWSmT2/7OB9Y7whxjPn9yiVh9KsGALv9ZivDxcaEp+fjj+
kLWDV+iJRVqva1M9BVWyWASWEZLH6pXhuk4BXQdk/r3Y4VkCy6KPbfCgYbqjX6tBc0zUjK/nFHWw=",."ContentPropagator":"001191330106MA2CFLDG4R10001",."PropagateID":"R-RI_4brMNTYm1kmZsehYuWw",."ReservedCode2":"K-LBkc9peJ0GoxPECtYBct7vfZZgZvwy4FZrhe/DJovt3rGFEyBJ4z5WZYsl9yWMbL+j6YI/dnc0TvjwK1pNQvH/PdtPaJhFM6N06bmQdVF5NX2uq7GlOEtaQq7CYg3wLYt1zAC4pMfsQoUzUlixOEmtUgRhPibmjNhqln
Gv8I8K2UL4nJuZWSmT2/7OB9Y7whxjPn9yiVh9KsGALv9ZivDxcaEp+fjj+kLWDV+iJRVqva1M9BVWy
WASWEZLH6pXhuk4BXQdk/r3Y4VkCy6KPbfCgYbqjX6tBc0zUjK/nFHWw="}
Encoder                         : Lavf58.76.100
Image Size                      : 960x960
Megapixels                      : 0.922
Avg Bitrate                     : 2.99 Mbps
Rotation                        : 0
```]

Les métadonnées ci-dessus nous montrent qu'effectivement, la vidéo a été générée par une IA, en effet, le champ `AIGC` signifie "AI-Generated Content". Cette mesure découle du cadre réglementaire chinois relatif à l'étiquetage obligatoire des contenus générés par l'IA, qui depuis septembre 2025, impose aux services d'IA générative d'intégrer une balise lisible par machine dans les métadonnées du fichier #footnote[https://www.insideprivacy.com/international/china/china-releases-new-labeling-requirements-for-ai-generated-content/]. Les vidéos générées par ce modèle risquent donc d'être détectées par les systèmes de vérification d'identité, mais qu'en est-il des autres modèles ?

Après avoir analysé les métadonnées de HappyHorse 1.0, j'ai analysé celles d'une vidéo générée par le modèle Kling 3.0.

#sourcecode[```sh
exiftool kling-3-0.mp4
```]

#sourcecode[```
ExifTool Version Number         : 13.58
File Name                       : kling-3-0.mp4
Directory                       : .
File Size                       : 2.3 MB
File Modification Date/Time     : 2026:06:09 10:18:07+02:00
File Access Date/Time           : 2026:06:13 11:51:36+02:00
File Inode Change Date/Time     : 2026:06:10 14:38:42+02:00
File Permissions                : -rw-rw-r--
File Type                       : MP4
File Type Extension             : mp4
MIME Type                       : video/mp4
Movie Header Version            : 0
Create Date                     : 0000:00:00 00:00:00
Modify Date                     : 0000:00:00 00:00:00
Time Scale                      : 1000
Duration                        : 5.04 s
Preferred Rate                  : 1
Preferred Volume                : 100.00%
Preview Time                    : 0 s
Preview Duration                : 0 s
Poster Time                     : 0 s
Selection Time                  : 0 s
Selection Duration              : 0 s
Current Time                    : 0 s
Next Track ID                   : 2
Track Header Version            : 0
Track Create Date               : 0000:00:00 00:00:00
Track Modify Date               : 0000:00:00 00:00:00
Track ID                        : 1
Track Duration                  : 5.04 s
Track Layer                     : 0
Track Volume                    : 0.00%
Matrix Structure                : 1 0 0 0 1 0 0 0 1
Image Width                     : 960
Image Height                    : 960
Media Header Version            : 0
Media Create Date               : 0000:00:00 00:00:00
Media Modify Date               : 0000:00:00 00:00:00
Media Time Scale                : 12288
Media Duration                  : 5.04 s
Media Language Code             : und
Handler Description             : VideoHandler
Graphics Mode                   : srcCopy
Op Color                        : 0 0 0
Compressor ID                   : avc1
Source Image Width              : 960
Source Image Height             : 960
X Resolution                    : 72
Y Resolution                    : 72
Compressor Name                 : Lavc60.31.102 h264_slapi
Bit Depth                       : 24
Buffer Size                     : 0
Max Bitrate                     : 3678734
Average Bitrate                 : 3678734
Video Frame Rate                : 24
Handler Type                    : Metadata Tags
Major Brand                     : isom
Minor Version                   : 512
Compatible Brands               : isomiso2avc1mp41
Encoder                         : Lavf60.16.100
Media Data Size                 : 2318369
Media Data Offset               : 1566
Image Size                      : 960x960
Megapixels                      : 0.922
Avg Bitrate                     : 3.68 Mbps
Rotation                        : 0
```]

Nous pouvons voir que, bien que la vidéo soit générée par un modèle chinois, les métadonnées ne contiennent pas de champ `AIGC`. Cependant, lors d'une vérification d'identité sur Facebook par exemple, la vidéo n'est pas uploadée telle quelle, elle est capturée en temps réel par le navigateur et probablement réencodée avant d'être envoyée au serveur.

Par curiosité, nous pouvons récupérer la vidéo qui est capturée par le navigateur lors du selfie vidéo sur Facebook pour analyser ses métadonnées. Pour cela, il faut effectuer le selfie vidéo une première fois, inspecter la page du navigateur, puis aller dans l'onglet "Application".

#figure(
  rect(image("../images/08-attaques-non-reussies/facebook-page.png"), stroke: 0.1pt),
  caption: "Récupération de la vidéo capturée par Facebook lors du selfie vidéo.",
)

Nous pouvons ensuite lancer ExifTool pour analyser les métadonnées de cette vidéo.

#sourcecode[```sh
exiftool 94b92281-7599-4059-973a-4cfdf231a4ec.webm
```]

#sourcecode[```
ExifTool Version Number         : 13.58
File Name                       : 94b92281-7599-4059-973a-4cfdf231a4ec.webm
Directory                       : .
File Size                       : 4.1 MB
File Modification Date/Time     : 2026:06:17 13:53:17+02:00
File Access Date/Time           : 2026:06:17 13:53:25+02:00
File Inode Change Date/Time     : 2026:06:17 13:53:25+02:00
File Permissions                : -rw-rw-r--
File Type                       : WEBM
File Type Extension             : webm
MIME Type                       : video/webm
EBML Version                    : 1
EBML Read Version               : 1
Doc Type                        : webm
Doc Type Version                : 4
Doc Type Read Version           : 2
Timecode Scale                  : 1 ms
Duration                        : 11.46 s
Muxing App                      : Chrome
Writing App                     : Chrome
Track Number                    : 1
Track UID                       : 4d676b703b984e
Track Type                      : Video
Video Codec ID                  : V_VP8
Image Width                     : 640
Image Height                    : 480
Image Size                      : 640x480
Megapixels                      : 0.307
```]

Nous pouvons voir que dans les métadonnées de la vidéo qui sera envoyée à Facebook, il n'y a aucune mention d'IA. En effet, la vidéo a été créée par le navigateur Chrome et encodée avec le codec VP8, les métadonnées seront donc toujours similaires quel que soit la caméra ou la vidéo utilisée.

Nous pouvons donc conclure que même si une vidéo contient des métadonnées informant que celle-ci a été générée avec de l'IA, cela n'aura aucun impact sur la vérification d'identité car elle est capturée en temps réel par le navigateur avant d'être envoyée au serveur.

== Ajout de bruit dans les vidéos

Une vidéo générée par IA est souvent très "parfaite", c'est-à-dire qu'elle ne contient pas de bruit ou d'imperfections dus aux capteurs d'une caméra réelle. Il est donc possible que les systèmes de vérification repèrent les vidéos générées par IA en analysant le manque d'imperfections dans une vidéo. Pour tester cette hypothèse, j'ai ajouté du bruit #footnote[https://ffmpeg.org/ffmpeg-filters.html#noise] dans les vidéos à l'aide d'un filtre FFmpeg lors des diffusions sur la caméra virtuelle.

#sourcecode[```py
ffmpeg_input.filter("noise", c0s=8, c0f="t+u", c1s=2, c1f="t", c2s=2, c2f="t")
```]

- `c0s=8` / `c1s=2` / `c2s=2` : la luminance reçoit une valeur nettement plus élevée (8) que la chrominance (2).
- `c0f="t+u"` / `c1f="t"` / `c2f="t"` : indicateurs de bruit contrôlant la nature du bruit.
  - `t` = temporel (le motif de bruit change à chaque frame au lieu d'être figé).
  - `u` = distribution uniforme (gaussienne par défaut).

Ce filtre imite l'aspect typique du bruit d'une caméra réelle, plus fort sur la luminance, présent mais plus faible sur la chrominance et vacillant d'une frame à l'autre.

Malheureusement le résultat est le même, Facebook détecte que la vérification d'identité a échoué et désactive le compte.

== Utilisation d'un modèle en 3D

Certains articles sur internet mentionnent qu'il serait possible contourner le selfie vidéo de vérification de Facebook en utilisant le modèle 3D d'une personne généré par une IA #footnote[https://procpa.media/articles/kak-proiti-video-selfi-facebook/#%D0%A1%D0%BF%D0%BE%D1%81%D0%BE%D0%B1_%D1%82%D1%80%D0%B5%D1%82%D0%B8%D0%B9_%E2%80%93_%D1%87%D0%B5%D1%80%D0%B5%D0%B7_3D_%D0%BC%D0%BE%D0%B4%D0%B5%D0%BB%D1%8C]. J'ai donc tenté de reproduire cette méthode en générant un modèle 3D sur le site #underline[#link("https://www.krea.ai/3d")] et en diffusant la page web sur la caméra virtuelle de OBS Studio.

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/08-attaques-non-reussies/man.jpg", width: 70%), stroke: 0.1pt),
    caption: "Image de référence utilisée pour générer le modèle 3D.",
  ),
  figure(
    rect(image("../images/08-attaques-non-reussies/3d.png", width: 78%), stroke: 0.1pt),
    caption: "Modèle 3D généré par l'IA à partir de l'image de référence.",
  ),
)

Résultat : #link("../videos/08-attaques-non-reussies/facebook-3d.mp4")[#underline("videos/08-attaques-non-reussies/facebook-3d.mp4")]

Sans surprise, cette méthode ne fonctionne pas non plus, Facebook détecte que la vérification d'identité a échoué et désactive le compte.

== Utilisation d'un échangeur de visage en temps réel

Plutôt que de générer ou d'éditer une vidéo, j'ai tenté d'utiliser Deep-Live-Cam, un échangeur de visage en temps réel permettant de remplacer son visage par celui d'une autre personne #footnote[https://github.com/hacksider/deep-live-cam]. L'outil est un programme Python qui tourne sur la machine locale et qui s'appuie sur des modèles pré-entraînés comme `inswapper` pour l'échange de visages  et `GFPGAN` pour l'amélioration des visages #footnote[https://huggingface.co/hacksider/deep-live-cam/tree/main].

Le problème est que pour utiliser cet outil, il faut avoir un système très puissant avec une bonne carte graphique, comme le montre la #underline[@deeplivecam] ci-dessous.

#figure(
  rect(image("../images/08-attaques-non-reussies/deeplivecam.png"), stroke: 0.1pt),
  caption: "Système recommandé pour le bon fonctionnement de Deep-Live-Cam.",
)<deeplivecam>

J'ai donc dû faire appel à un ami qui possède une machine avec une carte graphique NVIDIA RTX 3080 pour tester cet outil.

// TODO

== Modification du module `v4l2loopback`

Lorsque nous tentons de contourner la vérification d'identité du site Parship, nous voyons le message d'erreur ci-dessous.

#figure(
  rect(image("../images/08-attaques-non-reussies/parship-2.png", width: 60%), stroke: 0.1pt),
  caption: "Échec de la vérification d'identité en utilisant une caméra virtuelle.",
)

Contrairement à Facebook, Parship nous dit pourquoi la vérification a échoué, nous pouvons donc en déduire que le système analyse également le type de caméra qui est utilisé. J'ai donc essayé de refaire la vérification, mais cette fois-ci avec une caméra réelle pour voir si le résultat était différent. Pour cela, j'ai affiché l'image de la personne fictive sur mon écran et j'ai filmé cette image avec ma caméra.

Résultat : #link("../videos/08-attaques-non-reussies/parship-real-camera.mp4")[#underline("videos/08-attaques-non-reussies/parship-real-camera.mp4")]

Le résultat est bien différent, cela confirme donc que le système de vérification de Parship analyse le type de caméra utilisé et que la diffusion d’une vidéo sur une caméra virtuelle est détectée et bloquée.

#figure(
  rect(image("../images/08-attaques-non-reussies/parship-3.png", width: 70%), stroke: 0.1pt),
  caption: "Échec de la vérification d'identité avec une caméra réelle.",
)

Suite à cette découverte, j'ai cherché un moyen de faire croire au système de vérification que la caméra virtuelle était une caméra réelle. Pour cela, j'ai essayé de modifier le code source du module `v4l2loopback` utilisé pour créer la caméra virtuelle pour qu'il n'affiche pas les caractéristiques d'une caméra virtuelle mais celles d'une caméra réelle.

*Étape 1 :* cloner le dépôt GitHub du projet `v4l2loopback`.

#sourcecode[```sh
git clone git@github.com:v4l2loopback/v4l2loopback.git
cd v4l2loopback
```]

*Étape 2 :* ouvrir le fichier `v4l2loopback.c` et modifier les chaînes de caractères affichées par des `snprintf`.

#figure(
  rect(image("../images/08-attaques-non-reussies/v4l2loopback.png"), stroke: 0.1pt),
  caption: "Modification du module v4l2loopback.",
)

*Étape 3 :* recompiler et réinstaller le module.

#sourcecode[```sh
make
sudo make install
sudo depmod -a
```]

*Étape 4 :* créer une nouvelle caméra virtuelle.

#sourcecode[```sh
sudo modprobe v4l2loopback devices=1 video_nr=0 card_label="AUKEY PC-W1: AUKEY PC-W1" exclusive_caps=1
```]

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/08-attaques-non-reussies/old-module.png"), stroke: 0.1pt),
    caption: "Caméra créée avec le module original.",
  ),
  figure(
    rect(image("../images/08-attaques-non-reussies/new-module.png"), stroke: 0.1pt),
    caption: "Caméra créée avec le module modifié.",
  ),
)

Cependant, malgré toutes ces modifications, j'obtiens le même résultat, Parship détecte toujours que la caméra utilisée est une caméra virtuelle.


= Tests effectués pour la falsification de documents d'identité

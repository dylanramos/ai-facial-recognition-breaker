#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Utilisation du CLI"
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

Ce document présente les différentes commandes disponibles du démonstrateur avec des exemples d'utilisation. La #underline[@available-cmds] ci-dessous illustre les commandes disponibles après l'installation du démonstrateur.

#figure(
  rect(image("../images/06-developpement/aifrb-cmd.png"), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb` après l'installation du démonstrateur.],
) <available-cmds>

= Camera Commands

== create-camera

La commande `create-camera` permet de créer une caméra virtuelle en spécifiant le nom et le numéro de celle-ci. Par exemple, la commande suivante crée une caméra virtuelle nommée "VirtualCam" avec le numéro 0 :

#sourcecode[```sh
    aifrb create-camera "VirtualCam" 0
```]

À noter que si une caméra virtuelle avec le même numéro existe déjà, elle sera écrasée. D'autre part, cette commande est la seule à nécessiter des privilèges administrateur, car elle utilise le module `v4l2loopback` pour créer la caméra virtuelle. C'est pourquoi le programme demande le mot de passe `sudo` lors de son exécution.

Nous pouvons ensuite vérifier que la caméra a bien été créée en utilisant la commande `v4l2-ctl`.

#figure(
  rect(image("../images/06-developpement/create-camera.png"), stroke: 0.1pt),
  caption: [Vérification de la création de la caméra virtuelle.],
)

== broadcast

La commande `broadcast` permet de diffuser une image ou un flux vidéo vers une caméra virtuelle. Les options disponibles sont les suivantes :
- `--pixel-format (-f)`: format des pixels du flux vidéo. Le format par défaut est `yuv420p` car c'est le même utilisé par les vraies caméras, néanmoins tous les formats proposés par `FFmpeg` sont disponibles #footnote("https://www.ffmpeg.org/doxygen/1.0/pixfmt_8h.html").
- `--portrait (-p)`: option permettant de rogner l'image ou le flux vidéo en orientation portrait (paysage par défaut).

Lorsque la caméra virtuelle est utilisée sur un navigateur web, l'option `--portrait` n'est pas recommandée car les caméras d'ordinateur sont généralement en orientation paysage. En revanche, lorsque la caméra virtuelle est utilisée sur un smartphone, l'option `--portrait` peut être utile pour que le contenu diffusé prenne tout l'écran du smartphone.

Exemple sans l'option `--portrait` avec une image en orientation paysage sur Genymotion (émulateur Android) :

#sourcecode[```sh
    aifrb broadcast templates/face.jpg /dev/video0
```]

#figure(
  rect(image("../images/06-developpement/no-portrait.png", width: 40%), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb broadcast` sur Genymotion sans l'option `--portrait`.],
)

Exemple avec l'option `--portrait` avec une image en orientation paysage sur Genymotion (émulateur Android) :

#sourcecode[```sh
    aifrb broadcast templates/face.jpg /dev/video0 --portrait
```]

#figure(
  rect(image("../images/06-developpement/portrait.png", width: 40%), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb broadcast` sur Genymotion avec l'option `--portrait`.],
)

= AI Commands

== generate-image

La commande `generate-image` permet de générer une image à partir d'un prompt en utilisant l'API de KIE AI. Une fois générée, l'image est automatiquement téléchargée dans le dossier `downloads/` à la racine du projet. Les options disponibles sont les suivantes :
- `--model (-m)` : modèle de génération d'image à utiliser. Par défaut, le modèle utilisé est Nano Banana 2 car c'est le plus réaliste.
- `--aspect-ratio (-a)` : format de l'image générée (1:1 par défaut).
- `--resolution (-r)` : résolution de l'image générée (1K par défaut).

Exemple :

#sourcecode[```sh
    aifrb generate-image "A headshot portrait of a young man in his early 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography." -m "Grok Imagine" -a "9:16" -r "1K"
```]

#figure(
  rect(image("../images/06-developpement/generate-image.jpg", width: 30%), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb generate-image`.],
)

Mais attention, les modèles ne proposent pas tous les mêmes options, par exemple le modèle Nano Banana 2 permet de générer des images en 4K alors que le modèle Wan 2.7 ne permet que de générer des images en 1K et 2K.

Le tableau ci-dessous présente les paramètres disponibles pour chaque modèle :

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Formats*], [*Résolutions*],
    [Nano Banana 2], [auto, 1:1, 1:4, 1:8, 2:3, 3:2, 3:4, 4:1, 4:3, 4:5, 5:4, 8:1, 9:16, 16:9, 21:9], [1K, 2K, 4K],
    [GPT Image 2], [auto, 1:1, 1:2, 2:1, 1:3, 3:1, 2:3, 3:2, 3:4, 4:3, 4:5, 5:4, 9:16, 16:9, 9:21, 21:9], [1K, 2K, 4K],

    [Grok Imagine], [1:1, 2:3, 3:2, 9:16, 16:9], [-],
    [Wan 2.7], [-], [1K, 2K],
  ),
  caption: [Paramètres disponibles pour chaque modèle de génération d'image.],
)

== edit-image

La commande `edit-image` permet d'éditer une image en utilisant l'API de KIE AI. Une fois éditée, l'image est automatiquement téléchargée dans le dossier `downloads/` à la racine du projet. Les options disponibles sont les suivantes :
- `--model (-m)` : modèle de génération d'image à utiliser. Par défaut, le modèle utilisé est Nano Banana 2 car c'est le plus réaliste.
- `--aspect-ratio (-a)` : format de l'image éditée (1:1 par défaut).
- `--resolution (-r)` : résolution de l'image éditée (1K par défaut).
- `--reference-image (-i)` : image de référence pour l'édition. Cette option permet de fournir une image supplémentaire pour remplacer un visage par exemple.

Exemple :

#sourcecode[```sh
aifrb edit-image "Modify the ID card by replacing the name 'de Maienfeld Muste' by 'Teste', the name 'Lara Sample' by 'Alice', the date of birth '01 08 1991' by '07 02 2000' and the signature 'Signature' by 'A. Teste'. Replace the pictures on the ID card by the woman on the second image. The pictures should keep their black and white color and the triangles at the end of the names should not be removed." templates/id-front.jpg -i templates/woman.png -a "auto"
```]

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: [Image à éditer (`templates/id-front.jpg`).],
  ),
  figure(
    rect(image("../images/03-generation-ia/face.png", width: 62%), stroke: 0.1pt),
    caption: [Image de référence pour l'édition (`templates/woman.png`).],
  ),
)

#figure(
  rect(image("../images/03-generation-ia/nano-banana-2.jpeg", width: 50%), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb edit-image`.],
)

Comme pour la commande `generate-image`, les paramètres disponibles pour chaque modèle d'édition d'image sont présentés dans le tableau ci-dessous :

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Formats*], [*Résolutions*],
    [Nano Banana 2], [auto, 1:1, 1:4, 1:8, 2:3, 3:2, 3:4, 4:1, 4:3, 4:5, 5:4, 8:1, 9:16, 16:9, 21:9], [1K, 2K, 4K],
    [GPT Image 2], [auto, 1:1, 1:2, 2:1, 1:3, 3:1, 2:3, 3:2, 3:4, 4:3, 4:5, 5:4, 9:16, 16:9, 9:21, 21:9], [1K, 2K, 4K],

    [Grok Imagine], [1:1, 2:3, 3:2, 9:16, 16:9], [-],
    [Wan 2.7], [-], [1K, 2K],
    [Seedream 4.5], [1:1, 2:3, 3:2, 3:4, 4:3, 9:16, 16:9, 21:9], [2K, 4K],
  ),
  caption: [Paramètres disponibles pour chaque modèle d'édition d'image.],
)

== generate-video

La commande `generate-video` permet de générer une vidéo à partir d'un prompt en utilisant l'API de KIE AI. Une fois générée, la vidéo est automatiquement téléchargée dans le dossier `downloads/` à la racine du projet. Les options disponibles sont les suivantes :
- `--model (-m)` : modèle de génération de vidéo à utiliser. Par défaut, le modèle utilisé est Grok Imagine Video 1.5 car c'est le plus réaliste.
- `--duration (-d)` : durée de la vidéo générée (3 secondes par défaut).
- `--aspect-ratio (-a)` : format de la vidéo générée (16:9 par défaut).
- `--resolution (-r)` : résolution de la vidéo générée (720p par défaut).
- `--start-image (-s)` : image de départ pour la génération de la vidéo. Cette option permet de fournir la première "frame" de la vidéo.
- `--end-image (-e)` : image de fin pour la génération de la vidéo. Cette option permet de fournir la dernière "frame" de la vidéo.

Exemple :

#sourcecode[```sh
    aifrb generate-video "This woman is facing the camera. She turns her head left, then up, then right and then faces the camera again." -d 5 -a "auto" -s templates/woman.png
```]

Résultat : #underline[#link("../videos/03-generation-ia/grok-imagine-video-1-5.mp4")[videos/03-generation-ia/grok-imagine-video-1-5.mp4]]

Comme pour les modèles de génération d'images, les modèles de génération de vidéos ne proposent pas tous les mêmes options. Le tableau ci-dessous présente les paramètres disponibles pour chaque modèle de génération de vidéo :

#set par(justify: false)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Durée*], [*Formats*], [*Résolutions*], [*Images*],
    [Grok Imagine Video 1.5], [1-15s], [auto, 1:1, 2:3, 3:2, 3:4, 4:3, 9:16, 16:9], [480p, 720p], [1],
    [HappyHorse 1.0], [3-15s], [-], [720p, 1080p], [1],
    [Kling 3.0], [3-15s], [-], [720p, 1080p, 4K], [0-2],
    [Wan 2.7], [2-15s], [1:1, 3:4, 4:3, 9:16, 16:9], [720p, 1080p], [0-2],
  ),
  caption: [Paramètres disponibles pour chaque modèle de génération de vidéo.],
)

#set par(justify: true)

== edit-video

La commande `edit-video` permet d'éditer une vidéo en utilisant l'API de KIE AI. Une fois éditée, la vidéo est automatiquement téléchargée dans le dossier `downloads/` à la racine du projet. Les options disponibles sont les suivantes :
- `--model (-m)` : modèle de génération de vidéo à utiliser. Par défaut, le modèle utilisé est Kling 3.0 car c'est le plus réaliste.
- `--resolution (-r)` : résolution de la vidéo éditée (720p par défaut).

Exemple :

#sourcecode[```sh
    aifrb edit-video "Replace the person on the video by the person on the image." docs/videos/03-generation-ia/grok-imagine-video-1-5.mp4 templates/man.jpg -m "HappyHorse 1.0"
```]

Vidéo à éditer : #underline[#link("../videos/03-generation-ia/grok-imagine-video-1-5.mp4")[videos/03-generation-ia/grok-imagine-video-1-5.mp4]]

#figure(
  rect(image("../images/06-developpement/man.jpg", width: 30%), stroke: 0.1pt),
  caption: [Image de référence pour l'édition (`templates/man.jpg`).],
)

Résultat : #underline[#link("../videos/06-developpement/happyhorse-1-0.mp4")[videos/06-developpement/happyhorse-1-0.mp4]]

Comme pour `generate-video`, les paramètres disponibles pour chaque modèle d'édition de vidéo sont présentés dans le tableau ci-dessous :

#set par(justify: false)

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Durée*], [*Résolutions*],
    [Kling 3.0], [-], [720p, 1080p],
    [HappyHorse 1.0], [-], [720p, 1080p],
    [Wan 2.7], [0-10s], [720p, 1080p],
  ),
  caption: [Paramètres disponibles pour chaque modèle d'édition de vidéo.],
)

#set par(justify: true)

= KIE AI Account Commands

== remaining-credits

La commande `remaining-credits` permet d'afficher le nombre de crédits restants sur le compte KIE AI. Les crédits sont consommés à chaque utilisation des commandes de la catégorie "AI Commands". Le nombre de crédits consommés dépend du modèle utilisé et des paramètres choisis. Par exemple, la génération d'une image en 4K consomme plus de crédits que la génération d'une image en 1K. Pour donner un ordre d'idée, 1000 crédits équivalent à 5\$.

#figure(
  rect(image("../images/06-developpement/remaining-credits.png"), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb remaining-credits`.],
)

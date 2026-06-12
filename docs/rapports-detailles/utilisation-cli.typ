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
- `--no-crop (-n)`: option permettant de ne pas recadrer l'image ou le flux vidéo à la résolution de la caméra virtuelle. Par défaut, l'image ou le flux vidéo est recadré à la résolution de la caméra virtuelle pour éviter une sortie déformée sur le système de vérification d'identité.

Exemple sans `--no-crop` (par défaut) :

#sourcecode[```sh
    aifrb broadcast templates/man.jpg /dev/video0
```]

#figure(
  rect(image("../images/06-developpement/broadcast.png", width: 70%), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb broadcast` sans le paramètre `--no-crop`.],
)

Exemple avec `--no-crop` :

#sourcecode[```sh
    aifrb broadcast templates/face.jpg /dev/video0 --no-crop
```]

#figure(
  rect(image("../images/06-developpement/broadcast-no-crop.png", width: 70%), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb broadcast` avec le paramètre `--no-crop`.],
)

= AI Commands

== generate-image

La commande `generate-image` permet de générer une image à partir d'un prompt en utilisant l'API de KIE AI. Une fois générée, l'image est automatiquement téléchargée dans le dossier `downloads/` à la racine du projet. Les options disponibles sont les suivantes :
- `--model (-m)`: modèle de génération d'image à utiliser. Par défaut, le modèle utilisé est Nano Banana 2 car c'est le plus réaliste.
- `--aspect-ratio (-a)`: format de l'image générée.
- `--resolution (-r)`: résolution de l'image générée.

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
    [GPT Image 2.0],
    [auto, 1:1, 1:2, 2:1, 1:3, 3:1, 2:3, 3:2, 3:4, 4:3, 4:5, 5:4, 9:16, 16:9, 9:21, 21:9],
    [1K, 2K, 4K],

    [Grok Imagine], [1:1, 2:3, 3:2, 9:16, 16:9], [-],
    [Wan 2.7], [-], [1K, 2K],
  ),
  caption: [Paramètres disponibles pour chaque modèle de génération d'image.],
)

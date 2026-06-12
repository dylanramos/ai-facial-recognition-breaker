#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Selfie vidéo"
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

La plupart des entreprises développant des systèmes de vérification d'identité en ligne ne divulguent pas la manière dont ils vérifient les identités. Ainsi, il est très difficile voire impossible d'identifier une méthode de contournement qui fonctionne à tous les coups. Ce document présente les différents tests effectués pour essayer de comprendre et de contourner les systèmes de vérification par selfie vidéo.

== Facebook

Lors de la création d'un compte, Facebook demande de prendre un selfie vidéo en tournant la tête dans différentes directions. Les directions étant aléatoires, j'ai dû me filmer sur le moment puis demander à l'IA de remplacer mon visage par celui d'une personne fictive.

Un point important à prendre en compte est que Facebook bloque automatiquement les comptes créés avec un alias comme adresse e-mail. J'ai donc dû créer une adresse Gmail pour chacune de mes tentatives.

#figure(
  rect(image("images/selfie-video/alias.png", width: 30%), stroke: 0.1pt),
  caption: "E-mail de suspension du compte lors de l'utilisation d'un alias.",
)

Une fois le compte créé, la vérification d'identité est demandée. Pour pouvoir essayer de la contourner, je dois d'abord savoir quels sont les mouvements demandés, pour cela je diffuse un écran noir sur la caméra virtuelle car une caméra doit être détectée pour que la vérification commence. La vidéo #underline[#link("videos/selfie-video/facebook-1.webm")[facebook-1.webm]] démontre le type de mouvements demandés par Facebook.

Une fois les mouvements connus, je me suis filmé en train de les faire, puis j'ai demandé à l'IA de remplacer mon visage par celui d'une personne fictive, le tout en gardant la page de vérification ouverte.

Génération de la personne :

- Modèle : `nano-banana-2`
- Prompt : `A headshot portrait of a young woman in her early 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography.`
- Format d'image : `auto`
- Résolution : `1K`

#figure(
  rect(image("images/selfie-video/personne-fictive.png", width: 30%), stroke: 0.1pt),
  caption: "Personne fictive générée.",
)

Génération de la vidéo :

- Modèle : `happyhorse/video-edit`
- Prompt : `Replace the man on the video by the woman on the image.`
- Resolution : `720p`

Résultat : #underline[#link("videos/selfie-video/facebook-2.mp4")[facebook-2.mp4]].

Enfin, j'ai diffusé la vidéo sur la caméra virtuelle et je suis retourné sur la page de vérification, le résultat est le suivant : #underline[#link("videos/selfie-video/facebook-3.webm")[facebook-3.webm]]. Et après quelques heures d'attente, j'ai reçu un e-mail de Facebook m'informant que ma vérification d'identité avait échoué.

#figure(
  rect(image("images/selfie-video/echec-verification.png", width: 30%), stroke: 0.1pt),
  caption: "Échec de la vérification d'identité.",
)

Après plusieurs tentatives similaires, j'ai toujours reçu le même résultat. Je suis maintenant dans l'incapacité d'en faire d'autres car je ne peux plus créer d'adresses Gmail, mon numéro de téléphone ayant été utilisé trop de fois.

== Parship

Comme pour Facebook, Parship demande de prendre un selfie vidéo lors de la création d'un compte. Cependant, aucun mouvement n'est demandé, il faut simplement centrer son visage dans un oval puis se rapprocher de la caméra. Je n'ai donc pas eu besoin de me filmer préalablement, j'ai directement demandé à l'IA de générer une vidéo d'une personne fictive en train de se filmer :

- Modèle : `kling-3.0/video`
- Prompt : `The woman in the image looks into the camera for a while, her body is not moving. Then the camera slowly zooms to her face and the woman continues to look at the camera. Then the camera zoom more and the woman is still looking at the camera. Then the camera slowly goes back.`
- Durée : `15s`
- Format d'image : `16:9`

Résultat : #underline[#link("videos/selfie-video/parship-1.mp4")[parship-1.mp4]].

J'ai ensuite diffusé la vidéo sur la caméra virtuelle et je suis retourné sur la page de vérification, le résultat est le suivant : #underline[#link("videos/selfie-video/parship-2.mp4")[parship-2.mp4]]. La vérification a échoué, mais contrairement à Facebook, Parship nous dit pourquoi la vérification a échoué, comme nous pouvons le voir à la fin de la vidéo.

#figure(
  rect(image("images/selfie-video/echec-verification-2.png", width: 70%), stroke: 0.1pt),
  caption: "Échec de la vérification d'identité en utilisant une caméra virtuelle.",
)

Nous pouvons en déduire que le système de vérification de Parship analyse également le type de caméra qui est utilisé. J'ai donc essayé de refaire la vérification, mais cette fois-ci avec une caméra réelle pour voir si le résultat était différent. Pour cela, j'ai affiché l'image de la personne fictive sur mon écran et j'ai filmé cette image avec une webcam.

Résultat : #underline[#link("videos/selfie-video/parship-3.mp4")[parship-3.mp4]].

Le résultat est bien différent, cela confirme donc que le système de vérification de Parship analyse le type de caméra utilisé et que la diffusion d'une vidéo sur une caméra virtuelle est détectée et bloquée.

#figure(
  rect(image("images/selfie-video/echec-verification-3.png", width: 70%), stroke: 0.1pt),
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
  rect(image("images/selfie-video/v4l2loopback.png"), stroke: 0.1pt),
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
    rect(image("images/selfie-video/old-module.png"), stroke: 0.1pt),
    caption: "Caméra créée avec le module original.",
  ),
  figure(
    rect(image("images/selfie-video/new-module.png"), stroke: 0.1pt),
    caption: "Caméra créée avec le module modifié.",
  ),
)

Cependant, malgré toutes ces modifications, j'obtiens le même résultat, Parship détecte toujours que la caméra utilisée est une caméra virtuelle.

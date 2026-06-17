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

== Changement des métadonnées de la vidéo

Il es possible que le système de vérification analyse les métadonnées de la vidéo pour vérifier ci celles-ci proviennent bien d'une caméra réelle. La première chose que j'ai essayé de faire est de comparer les caractéristiques de ma caméra réelle avec celles d'une caméra virtuelle en allant sur le site #underline[#link("https://webcamtests.com/")].

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

Étant donné que les caractéristiques des deux caméras sont plutôt similaires, je me suis penché sur l'analyse des métadonnées des vidéos qu'elles produisent.

== Utilisation d'un modèle en 3D

== Ajout de bruit dans la vidéo

== Utilisation d'un échangeur de visage en temps réel

== Modification du module `v4l2loopback`

= Tests effectués pour la falsification de documents d'identité

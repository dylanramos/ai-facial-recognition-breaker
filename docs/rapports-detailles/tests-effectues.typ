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

Certains sites candidats n'ont pas pu être contournés, soit parce qu'ils utilisent une technologie de vérification d'identité plus avancée que les autres, soit parce que la vérification d'identité est intégrée à un processus plus complexe qui rend le contournement plus difficile. Ce document commence par présenter une marche à suivre pour tenter de contourner la vérification des sites Facebook et Parship et termine avec des tests effectués sur ces sites et des hypothèses sur les raisons pour lesquelles le contournement de la vérification d'identité n'a pas été possible.

= Facebook

Lors de la création d'un compte, Facebook demande systématiquement de prendre un selfie vidéo en tournant la tête dans cinq directions, avec à chaque fois trois possibilités (gauche, droite ou haut), ce qui fait un total de 243 combinaisons possibles.

#figure(
  rect(image("../images/05-conception/facebook-example.png", width: 70%), stroke: 0.1pt),
  caption: "Exemple de selfie vidéo demandé par Facebook.",
) <facebook-example>

Les directions étant aléatoires, il est impossible de savoir à l'avance quelles directions seront demandées, ce qui nous oblige à lancer la vérification une première fois pour connaître les directions demandées. Une fois les directions connues, la solution la plus simple est de se filmer en train de faire les mouvements, puis de remplacer sa personne par une personne générée à l'aide de l'IA. En effet, générer une vidéo de ce type uniquement à partir d'un prompt est très difficile car il y a tout un timing à respecter pour que les mouvements soient synchronisés avec les instructions.

Comme vu dans le chapitre 4.6 du rapport détaillé #link("../rapports-detailles/generation-ia.pdf")[#underline("generation-ia.pdf")], le meilleur modèle pour éditer une vidéo est Kling Motion Control 3.0, c'est donc avec celui-ci que nous allons générer la vidéo. Pour cela, il faut tout d'abord se prendre en photo, puis remplacer son visage par une personne générée.

#sourcecode[```sh
aifrb generate-image "A headshot portrait of a young man in his early 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography." -m "GPT Image 2"
```]

#figure(
  rect(image("../images/08-tests-effectues/facebook-1.png", width: 40%), stroke: 0.1pt),
  caption: "Nouvelle personne générée par l'IA.",
)

#sourcecode[```sh
aifrb edit-image "Replace the man on the first image by the man on the second image." downloads/myface.jpg -m "GPT Image 2" -a "auto" -i downloads/new-face.png
```]

#figure(
  rect(image("../images/08-tests-effectues/facebook-2.png", width: 60%), stroke: 0.1pt),
  caption: "Résultat de l'édition de l'image de référence.",
)

Il faut ensuite se filmer en train de faire les mouvements, puis remplacer son visage par la personne générée.

#sourcecode[```sh
aifrb edit-video "No distortion, the character's movements are consistent with the video." downloads/video.mp4 downloads/new-face.png
```]

Résultat : #link("../videos/08-tests-effectues/facebook-edit.mp4")[#underline("videos/08-tests-effectues/facebook-edit.mp4")]

Pour des questions de vie privée, l'image et la vidéo de référence de ma personne n'est pas publiée sur GitHub et n'est donc pas disponible dans ce rapport.
Une fois la vidéo générée, il suffit de créer une caméra virtuelle et d'y diffuser la vidéo.

#sourcecode[```sh
aifrb create-camera "Facebook Attack" 0
```]

#sourcecode[```sh
aifrb broadcast downloads/new-video.mp4 /dev/video0
```]

Résultat : #link("../videos/08-tests-effectues/facebook-result.mp4")[#underline("videos/08-tests-effectues/facebook-result.mp4")]

Enfin, après quelques heures d'attente ...

= Parship

= Tests

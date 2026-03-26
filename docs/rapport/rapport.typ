// Paramètres globaux
#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")
#show bibliography: set text(lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Casser la reconnaissance faciale grâce à l'IA"
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
#align(center, text(weight: "bold", size: 14pt)[Travail de Bachelor])
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

#pagebreak(to: "odd")

// Configuration des pages avant les chapitres

#set page(
  header: context [
    #set text(size: 9pt)
    #let selector = selector(heading).before(here())
    #let headings = query(selector).filter(it => it.level == 1)
    #let is_even = calc.even(counter(page).get().first())

    #if headings.len() == 0 and is_even {
      line(length: 100%, stroke: 0.5pt)
    } else if (is_even) {
      let current_heading = headings.last()

      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        upper(current_heading.body), line(length: 99%, stroke: 0.5pt),
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
  numbering: "i",
)
#set par(justify: true)

// Page de résumé

#align(right)[
  Département des Technologies de l'information et de la communication (TIC) \
  Filière Informatique et systèmes de communication \
  Orientation Sécurité informatique \
  Étudiant : #author \
  Enseignant responsable : #professor
]

#v(2cm)
#align(center)[
  Travail de Bachelor #academic_year \
  #title
]
#line(length: 100%, stroke: 0.5pt)

*Résumé publiable*

Dans un monde de plus en plus numérisé, les technologies de reconnaissance faciale sont devenues omniprésentes. Du simple déverrouillage de smartphone à la surveillance de masse, ces systèmes sont utilisés dans une variété d'applications. C'est notamment le cas pour les services sensibles qui proposent un enregistrement en ligne, comme les banques ou les services gouvernementaux qui utilisent la reconnaissance faciale pour vérifier l'identité des utilisateurs.

L'intelligence artificielle permet aujourd'hui de facilement générer des contenus multimédia réalistes. Photos, vidéos ou encore voix, les possibilités sont nombreuses et les outils de génération sont de plus en plus accessibles au grand public. Évidemment, cette démocratisation n'est pas sans risques, ces contenus peuvent être utilisés à des fins malveillantes, falsification de documents, usurpation d'identité ou encore désinformation, la nécessité de comprendre les risques liés à ces technologies est plus que jamais d'actualité.

Ce travail de Bachelor cherche à comprendre les risques associés à l'utilisation de la reconnaissance faciale dans les services en ligne et à démontrer s'il est possible de contourner ces systèmes de vérification d'identité en utilisant l'intelligence artificielle.

#v(0.5cm)

#table(
  stroke: none,
  columns: (40%, 30%, 30%),
  row-gutter: 0.3cm,
  align: bottom,
  [Étudiant :], [Date et lieu :], [Signature :],
  [#author],
  [#line(stroke: (dash: "dotted", thickness: 1pt), length: 100%)],
  [#line(stroke: (dash: "dotted", thickness: 1pt), length: 100%)],
)
#v(0.5cm)
#table(
  stroke: none,
  columns: (40%, 30%, 30%),
  row-gutter: 0.3cm,
  align: bottom,
  [Enseignant responsable :], [Date et lieu :], [Signature :],
  [#professor],
  [#line(stroke: (dash: "dotted", thickness: 1pt), length: 100%)],
  [#line(stroke: (dash: "dotted", thickness: 1pt), length: 100%)],
)

#pagebreak(to: "odd")

// Configuration des titres

#show heading.where(level: 1): it => {
  set text(size: 26pt)
  v(2.5cm)
  it
  v(1.5cm)
}
#show heading.where(level: 2): it => {
  set text(size: 16pt)
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
}
#show heading.where(level: 3): it => {
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
}

// Pages préliminaires

= Préambule

Ce travail de Bachelor (ci-après TB) est réalisé en fin de cursus d'études, en vue de l'obtention du titre de Bachelor of Science HES-SO en Ingénierie.
#v(0.5cm)
En tant que travail académique, son contenu, sans préjuger de sa valeur, n'engage ni la responsabilité de l'auteur, ni celles du jury du travail de Bachelor et de l'Ecole.
#v(0.5cm)
Toute utilisation, même partielle, de ce TB doit être faite dans le respect du droit d'auteur.
#v(2.5cm)

#grid(
  columns: (60%, 40%),
  [], [HEIG-VD],
  [], [#v(2.5cm)],
  [], [Vincent Peiris\ Chef de département TIC],
)

#v(3.5cm)

#location_and_date

#pagebreak(to: "odd")

= Authentification

Le soussigné, #author, atteste par la présente avoir réalisé ce travail et n'avoir utilisé aucune autre source que celles expressément mentionnées.
#v(2cm)
#location_and_date
#v(3cm)
#grid(
  columns: (60%, 40%),
  [], [#author],
)

#pagebreak(to: "odd")

#include "chapitres/00-cahier-des-charges.typ"
#pagebreak(to: "odd")

#show outline.entry.where(level: 1): it => [
  #strong(it)
  #v(0.5cm)
]
#show outline.entry.where(level: 2): it => [
  #v(-0.2cm)
  #it
  #v(0.3cm)
]
#show outline.entry.where(level: 3): it => [
  #v(-0.2cm)
  #it
  #v(0.3cm)
]
#set outline.entry(fill: line(length: 100%, stroke: 0.5pt))

#outline(title: "Table des matières")

#pagebreak(to: "odd")

#include "chapitres/00-glossaire.typ"
#pagebreak(to: "odd")

// Configuration des chapitres

#set page(numbering: "1")
#counter(page).update(1)
#set heading(numbering: "1.1")
#counter(heading).update(0)
#show heading.where(level: 1): it => {
  let current_heading = query(selector(heading.where(level: 1)).before(here())).last()
  let chapter_number = counter(heading).at(current_heading.location()).first()
  v(2.5cm)
  text(size: 20pt)[Chapitre #chapter_number]
  v(0.3cm)
  text(size: 26pt)[#it.body]
  v(0.7cm)
}
#show heading.where(level: 2): it => {
  v(0.5cm)
  it
  v(0.5cm)
}
#set page(
  header: context [
    #set text(size: 9pt)
    #let current_heading = query(selector(heading.where(level: 1)).before(here())).last()
    #let chapter_number = counter(heading).at(current_heading.location()).first()
    #let is_even = calc.even(counter(page).get().first())

    #if (is_even) {
      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        upper("Chapitre " + str(chapter_number) + ".  " + current_heading.body), line(length: 99%, stroke: 0.5pt),
      )
    } else {
      grid(
        columns: (1fr, auto),
        align: bottom,
        line(length: 99%, stroke: 0.5pt), author,
      )
    }
  ],
)

// Chapitres

#include "chapitres/01-introduction.typ"
#pagebreak(to: "odd")

#include "chapitres/02-etat-de-lart.typ"
#pagebreak(to: "odd")

#include "chapitres/03-conception.typ"
#pagebreak(to: "odd")

#include "chapitres/04-developpement.typ"
#pagebreak(to: "odd")

#include "chapitres/05-retour-sur-experience.typ"
#pagebreak(to: "odd")

#set heading(numbering: none)
#show heading.where(level: 1): it => {
  v(3cm)
  text(size: 26pt)[#it.body]
  v(2cm)
}
#set page(
  header: context [
    #set text(size: 9pt)
    #let current_heading = query(selector(heading.where(level: 1)).before(here())).last()
    #let chapter_number = counter(heading).at(current_heading.location()).first()
    #let is_even = calc.even(counter(page).get().first())

    #if (is_even) {
      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        upper(current_heading.body), line(length: 99%, stroke: 0.5pt),
      )
    } else {
      grid(
        columns: (1fr, auto),
        align: bottom,
        line(length: 99%, stroke: 0.5pt), author,
      )
    }
  ],
)

#include "chapitres/00-bibliographie.typ"
#pagebreak(to: "odd")

#include "chapitres/00-table-des-figures.typ"
#pagebreak(to: "odd")

#include "chapitres/00-annexes.typ"

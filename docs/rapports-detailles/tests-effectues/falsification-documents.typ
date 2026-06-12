#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Falsification de documents d'identité"
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
#align(center, text(weight: "bold", size: 14pt)[rapport détaillé])
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

La plupart des entreprises développant des systèmes de vérification d'identité en ligne ne divulguent pas la manière dont ils vérifient les identités. Ainsi, il est très difficile voire impossible d'identifier une méthode de contournement qui fonctionne à tous les coups. Ce document présente les différents tests effectués pour essayer de comprendre et de contourner les systèmes de vérification de documents d'identité.

== Roblox

Pour analyser la résistance des systèmes de vérification d'identité à la falsification de documents d'identité, j'ai commencé par le site Roblox. Tout d'abord, j'ai généré une photo d'une personne fictive :

- Modèle : `grok-imagine/text-to-image`
- Prompt : `A headshot portrait of a young man in his mid 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography`
- Format d'image : `2:3`

#figure(
  rect(image("images/falsification-documents/personne-fictive.jpg", width: 30%), stroke: 0.1pt),
  caption: "Personne fictive utilisée pour la falsification de documents d'identité.",
)

À l'aide d'un exemple de carte d'identité suisse trouvé sur Internet, j'ai ensuite généré une fausse carte d'identité suisse pour cette personne.

Recto :

- Modèle : `nano-banana-2`
- Prompt : `Modify the ID card by replacing the name 'de Maienfeld Muste' by 'Pick', the name 'Lara Sample' by 'Simon', the date of birth '01 08 1991' by '07 02 2000' and the signature 'Signature' by 'S. Pick'. Replace the pictures on the ID card by the man on the second image. The pictures should keep their black and white color and the triangles at the end of the names should not be removed.`

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("images/falsification-documents/id-front.jpg"), stroke: 0.1pt),
    caption: "Exemple de carte d'identité suisse (recto).",
  ),
  figure(
    rect(image("images/falsification-documents/id-front-fake.jpeg"), stroke: 0.1pt),
    caption: "Carte d'identité suisse générée (recto).",
  ),
)

Verso :

- Modèle : `nano-banana-2`
- Prompt : `Modify the ID card by replacing 'DE<MAIENFELD<MUSTER<<LARA<SAMP' by 'PICK<<SIMON' and the place of origin 'Le Lieu VD' by 'Lausanne VD'. Replace the face on the ID card by the man on the second image. The picture should keep its black and white color.`

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("images/falsification-documents/id-back.jpg"), stroke: 0.1pt),
    caption: "Exemple de carte d'identité suisse (verso).",
  ),
  figure(
    rect(image("images/falsification-documents/id-back-fake.jpeg"), stroke: 0.1pt),
    caption: "Carte d'identité suisse générée (verso).",
  ),
)

Enfin, j'ai diffusé une image à la fois sur la caméra virtuelle, le résultat est le suivant : #underline[#link("videos/falsification-documents/roblox-1.mp4")[roblox-1.mp4]].

Malheureusement, la vérification ne passe pas, je suis donc parti sur une autre piste : poser la carte sur une table afin d'ajouter de la profondeur à la vidéo. Pour cela, j'ai commencé par prendre en photo une carte réelle posée sur une table.

#figure(
  rect(image("images/falsification-documents/carte-sur-table.jpg", width: 30%), stroke: 0.1pt),
  caption: "Carte réelle posée sur une table.",
)

J'ai ensuite demandé à l'IA de remplacer la carte réelle par les images du recto et du verso de la carte d'identité générée précédemment.

Recto :

- Modèle : `nano-banana-2`
- Prompt : `Replace the card on the table by the ID card.`

#figure(
  rect(image("images/falsification-documents/carte-sur-table-recto.png", width: 30%), stroke: 0.1pt),
  caption: "Carte d'identité générée posée sur une table (recto).",
)

Verso :

- Modèle : `nano-banana-2`
- Prompt : `Replace the card on the table by the ID card.`

#figure(
  rect(image("images/falsification-documents/carte-sur-table-verso.png", width: 30%), stroke: 0.1pt),
  caption: "Carte d'identité générée posée sur une table (verso).",
)

Enfin, comme précédemment, j'ai diffusé une image à la fois sur la caméra virtuelle, le résultat est le suivant : #underline[#link("videos/falsification-documents/roblox-2.mp4")[roblox-2.mp4]].

Mais encore une fois, la vérification ne passe pas.

== Google

Contrairement à Roblox, Google ne demande pas de filmer un document d'identité, mais seulement d'en uploader une photo. J'ai donc directement uploadé les images du recto et du verso de la carte d'identité générée précédemment, malheureusement la vérification ne passe pas non plus.

Résultat avec l'image initialement générée : #underline[#link("videos/falsification-documents/google-1.mp4")[google-1.mp4]].

Résultat avec l'image générée de la carte posée sur une table : #underline[#link("videos/falsification-documents/google-2.mp4")[google-2.mp4]].

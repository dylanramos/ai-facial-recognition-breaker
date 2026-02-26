// Paramètres globaux
#set text(font: "New Computer Modern", size: 11pt)

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Sites d'enregistrement"
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
#align(center + horizon, text(weight: "bold", size: 14pt)[Annexe B])
#align(center, text(weight: "bold", size: 26pt)[#title])
#v(4cm)

#align(left + bottom, [#block(width: 70%, [
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

#pagebreak()

#set par(justify: true)
#set heading(numbering: "1.1.")

= Critères de sélection

- *Type* : identification par photo, vidéo, ou les deux.
- *Interlocuteur humain* : présence ou non d'un interlocuteur humain pour guider l'utilisateur.
- *Documents d'identité* : nécessité ou non de fournir des documents d'identité.

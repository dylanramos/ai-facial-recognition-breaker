// Paramètres globaux
#set text(font: "New Computer Modern", size: 11pt)

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Services de génération de vidéo"
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
#align(center + horizon, text(weight: "bold", size: 14pt)[Annexe A])
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

= Types de services

== Propriétaires

Les services de génération de vidéo propriétaires générent des vidéos avec leur propres modèles d'IA.

*Avantages*:
- Coûts réduits (on ne paie que ce dont on a besoin)

== Aggrégateurs

Les services de génération de vidéo aggrégateurs mettent à disposition des modèles d'IA de différents fournisseurs, laissant ainsi le choix du modèle aux utilisateurs.

*Avantages*:
- Choix du modèle en fonction des besoins (réalisme, rapidité, etc.)
- Comparaison facile entre les différents modèles

= Critères de sélection

- *Temps de vidéo maximum* : la vidéo générée doit être suffisament longue pour que la vérification de l'identité puisse se faire.

- *Nombre de vidéos mensuel* : le nombre de vidéos généré par mois doit être suffisant pour pouvoir faire des tests et des démonstrations.

- *API disponible* : une API permet d'automatiser la génération de vidéos et ainsi le cassage de la reconnaissance faciale.

- *Prix* : les prix des abonnements et de l'API doivent être résonnables.

- *Qualité maximale de la vidéo* : la qualité de la vidéo doit être assez bonne pour tromper les systèmes de reconnaissance faciale.

- *Vidéo à partir d'images possible* : il doit être possible de générer une vidéo à partir d'une ou plusieurs images, afin que le visage de la personne corresponde à ses documents d'identité.

#pagebreak()

#set page(flipped: true)

= Services testés

== Tableau comparatif

Chaque donnée du tableau ci-dessous correspond à l'abonnement standard du service.

#set par(justify: false)

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto),
  align: horizon + center,
  [*Service*],
  [*Type*],
  [*Temps de vidéo maximum*],
  [*Nombre de vidéos mensuel*],
  [*API disponible*],
  [*Prix*],
  [*Qualité maximale de la vidéo*],
  [*Vidéo à partir d'images possible*],

  [*Veo 3.1*], [Propriétaire], [8s], [2], [Oui], [3.5 CHF / mois \ 0.15-0.60\$], [1080p], [Oui],
)

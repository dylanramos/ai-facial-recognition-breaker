// Paramètres globaux
#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt)
#show bibliography: set text(lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Génération de vidéos IA"
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
#align(center, text(weight: "bold", size: 14pt)[Rapport de recherche])
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

= Introduction

Les modèles de génération de vidéos IA doivent permettre de générer des vidéos réalistes de personnes effectuant une vérification d'identité (regarder la caméra, tourner la tête, sourire, etc.), il en existe deux catégories :
- Text-to-Video
- Image-to-Video

Les deux générent des vidéos mais ce qui les différencie sont les données d'entrée nécessaires.

== Text-to-Video

Les modèles de type Text-to-Video analysent le prompt et créent eux-mêmes les visuels et les mouvements à partir de zéro. Cela leur laisse beaucoup de créativité mais rend plus difficile le contrôle du résultat final, ce qui peut être problématique pour la vérification d'identité.

== Image-to-Video

Les modèles de type Image-to-Video partent d'une image fournie et génèrent la séquence demandée dans le prompt. Ce type de modèle est plus contrôlable visuellement et est plus adapté à la vérification d'identité car il permet de faire correspondre le visage de la vidéo avec celui des documents d'identité s'il viennent à être demandés.

= Choix des modèles

== Critères de sélection

Plusieurs modèles de type Image-to-Video ont été analysés, les critères de séléction sont les suivants :

+ *API disponible* : une API doit être disponible pour pouvoir automatiser la génération de vidéos.
+ *Temps de vidéo* : la vidéo générée doit être suffisament longue pour que la vérification de l'identité puisse se faire.
+ *Qualité de la vidéo* : la qualité de la vidéo doit être assez bonne pour tromper les systèmes de reconnaissance faciale.
+ *Audio* : la possibilité d'ajouter de l'audio est un plus.

À noter que le prix n'est pas mentionné dans les critères car il dépend de la qualité de la vidéo, de l'audio, etc. Celui-ci est analysé plus bas dans la @service-d-api.

== Tableau comparatif

#table(
  columns: (1fr, auto, auto, auto, auto),
  align: horizon + center,
  [*Service*], [*API disponible*], [*Temps de vidéo*], [*Qualité de la vidéo*], [*Audio*],

  [*Veo 3.1*], [Oui], [8s], [1080p], [Oui],
  [*Sora 2*], [Oui], [15s], [720p], [Oui],
  [*Kling 3.0*], [Oui], [15s], [1080p], [Oui],
  [*Wan 2.6*], [Oui], [15s], [1080p], [Oui],
  [*Grok Imagine*], [Oui], [15s], [720p], [Oui],
  [*Hailuo 2.3*], [Oui], [10s], [1080p], [Non],
)

= Service d'API <service-d-api>

Un service d'API est une plateforme qui regroupe les APIs des différents services de génération. Il met à disposition une API qui permet d'utiliser plusieurs modèles d'IA de manière centralisée et moins coûteuse que chez les fournisseurs directement.

== Kie.ai

Le service d'API choisi est #link("https://kie.ai/")[Kie.ai]. Il a été choisi pour sa simplicité d'utilisation, sa documentation claire et son prix compétitif. De plus, il propose un "bac à sable" permettant de tester les APIs des modèles gratuitement et offre 80 crédits lors de l'inscription. Il regroupe également des modèles de génération d'images, ce qui peut être utile pour générer des visages et des documents d'identité.

== Comparaison des prix des modèles

Les tableaux ci-dessous comparent les prix de chaque modèle dans leur configuration minimale (moins bonne qualité, plus courte durée, etc.) et maximale (meilleure qualité, durée plus longue, etc.).

=== Prix minimum

#table(
  columns: (1fr, auto, auto, auto, auto),
  align: horizon + center,
  [*Modèle*], [*Temps de vidéo*], [*Qualité de la vidéo*], [*Audio*], [*Prix*],

  [*Veo 3.1*], [], [], [], [],
  [*Sora 2*], [10s], [720p], [Oui], [0.175\$],
  [*Kling 3.0*], [], [], [], [],
  [*Wan 2.6*], [5s], [720p], [Oui], [0.35\$],
  [*Grok Imagine*], [6s], [480p], [Oui], [0.05\$],
  [*Hailuo 2.3*], [6s], [768p], [Non], [0.15\$],
)

=== Prix maximum

#table(
  columns: (1fr, auto, auto, auto, auto),
  align: horizon + center,
  [*Modèle*], [*Temps de vidéo*], [*Qualité de la vidéo*], [*Audio*], [*Prix*],

  [*Veo 3.1*], [], [], [], [],
  [*Sora 2*], [15s], [720p], [Oui], [0.20\$],
  [*Kling 3.0*], [], [], [], [],
  [*Wan 2.6*], [15s], [1080p], [Oui], [1.575\$],
  [*Grok Imagine*], [15s], [720p], [Oui], [0.20\$],
  [*Hailuo 2.3*], [], [], [], [],
)

= Exemple de prompt

A realistic identity verification style video. The person is centered in frame, facing the camera with neutral expression. After a short pause, they slowly turn their head to the left, then to the right, and return to the center. No speech. Consistent indoor lighting, plain background, clear facial visibility, natural blinking, no exaggerated movements.

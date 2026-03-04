// Paramètres globaux
#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt)
#show bibliography: set text(lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Services de génération de vidéos IA"
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

Les services de génération de vidéos IA doivent permettre de générer des vidéos réalistes de personnes effectuant une vérification d'identité (regarder la caméra, tourner la tête, sourire, etc.). Chaque service utilise des modèles d'IA différents, qui ont leurs avantages et leurs inconvénients.

Les services d'APIs sont des plateformes qui regroupent les APIs des différents services de génération. Ils permettent d'utiliser plusieurs modèles d'IA de manière centralisée sans avoir à gérer plusieurs abonnements et leurs prix sont souvent plus avantageux.

= Critères de sélection

== Services de génération

+ *API disponible* : une API doit être disponible pour pouvoir automatiser la génération de vidéos.
+ *Temps de vidéo* : la vidéo générée doit être suffisament longue pour que la vérification de l'identité puisse se faire.
+ *Qualité de la vidéo* : la qualité de la vidéo doit être assez bonne pour tromper les systèmes de reconnaissance faciale.
+ *Vidéo à partir d'images* : il doit être possible de générer une vidéo à partir d'images afin que le visage de la personne corresponde à ses documents d'identité.

== Services d'APIs

+ *Modèles proposés* : les modèles de génération choisis doivent être disponibles.
+ *Nombre de vidéos* : le nombre de vidéos générées possible doit être suffisant pour pouvoir faire plusieurs tentatives de vérification d'identité.
+ *Prix* : le prix doit être resonnable.
+ *Génération d'images* : être en mesure de générer des documents d'identité avec le visage d'une personne fictive est un plus.
+ *Option gratuite* : tester l'API avant de payer est un plus.

#pagebreak()

#set page(flipped: true)

= Tableaux comparatifs

== Services de génération

#set par(justify: false)

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  align: horizon + center,
  [*Service*],
  [*API disponible*],
  [*Temps de vidéo*],
  [*Qualité de la vidéo*],
  [*Vidéo à partir d'images*],
  [*Remarques*],

  [*Veo 3.1*], [Oui], [8s], [1080p], [Oui], [Réaliste],
  [*Sora 2*], [Oui], [10s], [720p], [Oui], [Réaliste],
  [*Kling AI*], [Oui], [10s], [1080p], [Oui], [Possibilité d'acheter des crédits; 1 vidéo = \~100 crédits],
  [*JoggAI*],
  [Oui],
  [3 min],
  [1080p],
  [Oui],
  [Permet de créer des deepfakes (remplacer des gens dans une vidéo); 1 vidéo = ~1 crédit],

  [*HeyGen*], [Oui], [3 min], [1080p], [Oui], [3 vidéos par mois gratuites de 3 min],
  [*Stable Diffusion*], [Oui], [5s], [720p], [Oui], [10 crédits gratuits par jour; 1 vidéo = ~25 crédits],
  [*Grok Imagine*], [Oui], [10s], [720p], [Oui], [10 vidéos gratuites par jour],
)

#pagebreak()

== Services d'APIs

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  align: horizon + center,
  [*Service*],
  [*Modèles proposés*],
  [*Nombre de vidéos*],
  [*Prix*],
  [*Génération d'images*],
  [*Option gratuite*],
  [*Remarques*],

  [*KIE AI*], [], [], [], [], [Oui], [80 crédits gratuits à l'inscription; minimum 60 crédits pour une vidéo],
  [*Luma AI*], [], [], [], [], [], [],
  [*AI4Chat*], [], [], [], [], [], [],
  [*VidgoAI*], [], [], [], [], [], [],
)

#set page(flipped: false)
#set par(justify: true)

= Exemple de prompt

A realistic identity verification style video. The person is centered in frame, facing the camera with neutral expression. After a short pause, they slowly turn their head to the left, then to the right, and return to the center. No speech. Consistent indoor lighting, plain background, clear facial visibility, natural blinking, no exaggerated movements.

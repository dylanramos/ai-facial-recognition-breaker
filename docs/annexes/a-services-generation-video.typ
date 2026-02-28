#let author = "Dylan Oliveira Ramos"

#set text(font: "New Computer Modern", size: 11pt)
#set page(
  margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm),
  numbering: "1",
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
)
#set par(justify: true)
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  v(2.5cm)
  text(size: 20pt)[Annexe A]
  v(0.3cm)
  text(size: 26pt)[#it.body]
  v(0.7cm)
}
#show heading.where(level: 2): it => {
  set text(size: 16pt)
  v(0.5cm)
  it
  v(0.5cm)
}
#show heading.where(level: 3): it => {
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
}

= Services de génération de vidéo

== Types de services

=== Propriétaires

Les services de génération de vidéo propriétaires générent des vidéos avec leur propres modèles d'IA.

*Avantages*:
- Coûts réduits (on ne paie que ce dont on a besoin)

=== Aggrégateurs

Les services de génération de vidéo aggrégateurs mettent à disposition des modèles d'IA de différents fournisseurs, laissant ainsi le choix du modèle aux utilisateurs.

*Avantages*:
- Choix du modèle en fonction des besoins (réalisme, rapidité, etc.)
- Comparaison facile entre les différents modèles

== Critères de sélection

- *Temps de vidéo maximum* : la vidéo générée doit être suffisament longue pour que la vérification de l'identité puisse se faire.

- *Nombre de vidéos mensuel* : le nombre de vidéos généré par mois doit être suffisant pour pouvoir faire des tests et des démonstrations.

- *API disponible* : une API permet d'automatiser la génération de vidéos et ainsi le cassage de la reconnaissance faciale.

- *Prix* : les prix des abonnements et de l'API doivent être résonnables.

- *Qualité maximale de la vidéo* : la qualité de la vidéo doit être assez bonne pour tromper les systèmes de reconnaissance faciale.

- *Vidéo à partir d'images* : il doit être possible de générer une vidéo à partir d'une ou plusieurs images, afin que le visage de la personne corresponde à ses documents d'identité.

#pagebreak()

#set page(flipped: true)

== Services testés

=== Tableau comparatif des abonnements standards

Chaque donnée du tableau ci-dessous correspond à l'abonnement standard du service.

#set par(justify: false)

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto),
  align: horizon + center,
  [*Service*],
  [*Type*],
  [*Temps de vidéo maximum*],
  [*Nombre de vidéos mensuel*],
  [*Prix mensuel*],
  [*Qualité maximale de la vidéo*],
  [*Vidéo à partir d'images*],
  [*Remarques*],

  [*Veo 3.1*], [Propriétaire], [8s], [2], [3.5 CHF], [1080p], [Oui], [Réaliste],
  [*Sora 2*], [Propriétaire], [10s], [12], [20\$], [720p], [Oui], [Réaliste],
  [*Kling AI*],
  [Propriétaire],
  [10s],
  [6],
  [6.99\$],
  [1080p],
  [Oui],
  [Possibilité d'acheter des crédits; 1 vidéo = \~100 crédits],

  [*Invideo AI*],
  [Aggrégateur],
  [30s],
  [50 min],
  [35\$],
  [1080],
  [Oui],
  [Offre la génération d'images avec l'abonnement; 1 vidéo par semaine gratuite],

  [*Veed IO*], [Aggrégateur], [Dépend du modèle], [150], [19\$], [1080p], [Oui], [Permet d'éditer les vidéos],
  [*2.Video*],
  [Aggrégateur],
  [Dépend du modèle],
  [24],
  [49\$],
  [1080p],
  [Oui],
  [Possibilité d'acheter des crédits; 1 vidéo = \~50 crédits; Crédits offerts chaque jours],

  [*JoggAI*],
  [Propriétaire],
  [3 min],
  [200],
  [24\$],
  [1080p],
  [Oui],
  [Permet de créer des deepfakes (remplacer des gens dans une vidéo); 1 vidéo = ~1 crédit],

  [*Artlist*],
  [Aggrégateur],
  [Dépend du modèle],
  [103],
  [19.99€],
  [1080p],
  [Oui],
  [Permet de générer \~1650 images avec l'abonnement],

  [*HeyGen*], [Propriétaire], [3 min], [Illimité], [29\$], [1080p], [Oui], [3 vidéos par mois gratuites de 3 min],
  [*D-ID*],
  [-],
  [10 min],
  [10 min],
  [5.9\$],
  [1080p],
  [Oui],
  [Pas adapté (la personne ne bouge que les lèvres, pas de génération)],

  [*Stable Diffusion*],
  [Propriétaire],
  [5s],
  [50],
  [20\$],
  [720p],
  [Oui],
  [10 crédits gratuits par jour; 1 vidéo = ~25 crédits],

  [*Grok Imagine*], [Propriétaire], [10s], [3000], [30\$], [720p], [Oui], [10 vidéos gratuites par jour],
)

#pagebreak()

=== Tableau comparatif des API

#table(
  columns: (auto, auto, auto, auto),
  align: horizon + center,
  [*Service*], [*API disponible*], [*Option gratuite*], [*Prix*],

  [*Veo 3.1*], [Oui], [Non], [0.15-0.60\$ / vidéo (en fonction de la qualité)],
  [*Sora 2*], [Oui], [Non], [0.10-0.50\$ / vidéo (en fonction de la qualtié)],
  [*Kling AI*], [Oui], [Non], [~0.10\$ / vidéo (dépend du modèle)],
  [*Invideo AI*], [Non], [-], [-],
  [*Veed IO*], [Non], [-], [-],
  [*2.Video*], [Non], [-], [-],
  [*JoggAI*], [Oui], [Oui (10 crédits)], [99\$ / mois],
  [*Artlist*], [Non], [-], [-],
  [*HeyGen*], [Oui], [Non], [1-6\$ / min],
  [*D-ID*], [Oui], [Oui], [18\$ / mois],
  [*Stable Diffusion*], [Non], [-], [-],
  [*Grok Imagine*], [Oui], [Non], [0.05\$ / sec],
)

== Example de prompt

A realistic identity verification style video. The person is centered in frame, facing the camera with neutral expression. After a short pause, they slowly turn their head to the left, then to the right, and return to the center. No speech. Consistent indoor lighting, plain background, clear facial visibility, natural blinking, no exaggerated movements.

== Kie.ai

Kie.ai est une plateforme qui centralise des API de différents fournisseurs (Veo, Sora, etc.). Elle propose des API gratuites pour certains modèles. Les prix sont moins chers que les prix des API des fournisseurs : https://docs.kie.ai/#2-pricing.

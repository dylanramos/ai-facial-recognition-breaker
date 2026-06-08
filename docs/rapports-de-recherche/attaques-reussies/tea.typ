// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Attaque du site Tea for Women"
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

= Mise en place

En allant sur le site #underline(link("https://www.teaforwomen.com")) et en cliquant sur "Sign up" puis "Create your Tea account" nous arrivons sur la page ci-dessous.

#figure(
  rect(image("images/tea/tea-1.png"), stroke: 0.1pt),
  caption: "Page d'inscription.",
)

Nous pouvons voir que toutes les informations demandées sur cette page peuvent être faussées et qu'aucune vérification d'email ou de numéro de téléphone n'est demandée. Une fois le formulaire rempli et soumis, nous arrivons sur la page de vérification d'identité et nous constatons que l'option recommandée est la plus simple à attaquer.

#figure(
  rect(image("images/tea/tea-2.png"), stroke: 0.1pt),
  caption: "Page de choix de la vérification d'identité.",
)

Une fois la vérification démarrée, nous pouvons voir que le site nous demande de montrer notre visage de face, puis de tourner la tête dans des directions aléatoires.

#figure(
  rect(image("images/tea/tea-3.png"), stroke: 0.1pt),
  caption: "Page de vérification d'identité.",
)

= Contournement

Les directions demandées sont aléatoires, mais le système autorise l'utilisateur à se tromper. Ainsi, il est possible de préenregistrer une vidéo où la personne tourne la tête dans toutes les directions possibles.

Pour cela, j'ai commencé par générer l'image d'une femme :
- Modèle : `nano-banana-2`
- Prompt : `A headshot portrait of a young woman in her early 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography.`
- Format d'image : `auto`
- Résolution : `1k`

#figure(
  rect(image("images/tea/tea-4.png", width: 36%), stroke: 0.1pt),
  caption: "Femme fictive générée.",
)

Ensuite, je me suis filmé en train de tourner la tête dans toutes les directions possibles, puis j'ai demandé à l'IA d'éditer la vidéo pour remplacer mon visage par celui de la femme générée précédemment :
- Modèle : `happyhorse/video-edit`
- Prompt : `Replace the man on the video by the woman on the image.`
- Résolution : `720p`

Le résultat est le suivant : #underline[#link("videos/tea/tea-edit.mp4")[tea-edit.mp4]].

Enfin, j'ai diffusé la vidéo générée en boucle sur une caméra virtuelle, puis j'ai lancé la vérification. *L'attaque est un succès*.

Résultat : #underline[#link("videos/tea/tea-result.webm")[tea-result.webm]].

= Remarques

- J'ai dû changer la résolution de la vidéo générée pour que la tête soit bien dans le cadre, ce qui ajoute des bandes noires sur les côtés dans la vidéo de résultat. Mais cela n'a pas empêché la vérification de réussir.
- La vérification d'identité fonctionne aussi avec un visage d'homme alors que le site est destiné aux femmes.

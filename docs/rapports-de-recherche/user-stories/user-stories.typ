// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "User Stories"
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

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Vérification d'âge par photo

*Préambule :* une personne mineure possède un compte sur un site vulnérable et veut modifier sa date de naissance via les paramètres de son compte.

*Scénario 1*

#figure(
  rect(image("images/verification-age-1.png"), stroke: 0.1pt),
  caption: "La personne envoie une photo d'une autre personne."
)

*Scénario 2*

#figure(
  rect(image("images/verification-age-2.png"), stroke: 0.1pt),
  caption: "La personne demande au démonstrateur de générer l'image d'une personne fictive."
)

#pagebreak()

*Scénario 3*

#figure(
  rect(image("images/verification-age-3.png"), stroke: 0.1pt),
  caption: "La personne demande au démonstrateur de modifier sa photo pour la faire ressembler à une personne plus âgée."
)

= Enregistrement en ligne par photo <photo>

== Avec un exemple de carte d'identité trouvé sur internet

*Préambule :* un attaquant veut se créer un compte sur un site vulnérable. Il récupère un exemple de carte d'identité sur internet #footnote[https://api.i-web.ch/public/guest/getImageString/g403/6bcf2b7eece394289e83e74e6bbafbf5/495/0/4c1884cc9c238], puis suit le processus d'enregistrement en ligne du site vulnérable en renseignant des informations fictives.

*Scénario 1*

#figure(
  rect(image("images/verification-photo-1.png"), stroke: 0.1pt),
  caption: "L'attaquant demande au démonstrateur de modifier une photo d'une carte d'identité trouvée sur internet."
)

#pagebreak()

== Avec une photo d'un document d'identité volé

*Préambule :* un attaquant a volé une photo d'un document d'identité d'une personne et veut se créer un compte sur un site vulnérable. Il suit le processus d'enregistrement en ligne du site vulnérable en renseignant les informations d'identité avec celles contenues sur le document d'identité volé.

*Scénario 1*

#figure(
  rect(image("images/verification-photo-2.png"), stroke: 0.1pt),
  caption: "L'attaquant envoie la photo du document d'identité volé."
)

= Enregistrement en ligne par vidéo

== Sans interlocuteur humain

*Préambule :* l'attaquant vient d'effectuer l'un des scénarios du #underline()[@photo], mais le site vulnérable demande en plus une vérification par vidéo.

*Scénario 1*

#figure(
  rect(image("images/verification-video-1.png"), stroke: 0.1pt),
  caption: "L'attaquant demande au démonstrateur de générer une vidéo simulant la caméra en train de filmer un document d'identité."
)

#pagebreak()

*Scénario 2*

#figure(
  rect(image("images/verification-video-2.png"), stroke: 0.1pt),
  caption: "L'attaquant demande au démonstrateur de générer une vidéo de la personne sur le document d'identité simulant la caméra en train de filmer son visage."
)

== Avec un interlocuteur humain

*Préambule :* l'attaquant vient d'effectuer l'un des scénarios du #underline()[@photo], mais le site vulnérable demande en plus une vérification par vidéo lors d'un entretien avec un employé. L'attaquant diffuse une vidéo sur sa caméra virtuelle de la personne sur le document d'identité prête à effectuer les actions demandées par l'employé.

*Scénario 1*

#figure(
  rect(image("images/verification-video-3.png"), stroke: 0.1pt),
  caption: "L'attaquant attend les instructions de l'employé, puis demande au démonstrateur de générer une vidéo de la personne sur le document d'identité en train d'effectuer les actions demandées. En attendant la génération, l'attaquant simule des problèmes de caméra, latence, etc."
)

#pagebreak()

= Enregistrement en ligne avec un démonstrateur automatisé

*Préambule :* 

*Scénario 1*

#figure(
  rect(image("images/verification-video-4.png"), stroke: 0.1pt),
  caption: "Le démonstrateur lit les instructions du site vulnérable, génère le contenu demandé, puis le diffuse sur la caméra virtuelle."
)
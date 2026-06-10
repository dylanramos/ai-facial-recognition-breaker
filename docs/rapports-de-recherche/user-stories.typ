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
  image("../images/logo-heig-vd.png", width: 3cm),
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

= Introduction

Ce rapport de recherche est rédigé dans le cadre de mon travail de bachelor qui vise à démontrer les risques de la vérification d'identité en ligne avec l'avénement des outils d'IA. Il présente les scénarios d'attaque dont nous voulons vérifier la faisabilité dans un démonstrateur. Les scénarios d'attaque ainsi que tous les sites cités se basent sur les quatre patterns de vérification d'identité identifiés au chapitre 7 du rapport de recherche #underline[#link("sites-de-verification.pdf")].

À noter que seuls les scénarios impliquant l'utilisation de l'IA sont pris en compte. En effet, l'objectif de ce travail est de démontrer les risques face aux progrès et à la démocratisation de l'IA dans les processus de vérification d'identité en ligne. Ainsi, les sites qui ne demandent que d'envoyer une photo d'un document d'identité par exemple ne sont pas pris en compte, car le document peut être facilement falsifié avec des outils de retouche d'image classiques.

= Vérification par selfie vidéo uniquement

Les sites concernés par ce pattern sont Facebook, Tea for Women, Roblox, Parship et Google. L'interêt pour un attaquant de cibler ces sites serait de nuire à la réputation de quelqu'un en créant un faux compte sur Facebook, Tea for Women ou Parship. Dans le cas de Roblox et de Google, ce serait plutôt une personne mineure possédant déjà un compte qui chercherait à modifier sa date de naissance pour accéder à des contenus ou services inappropriés.

La #underline[@facebook-example] ci-dessous montre un exemple de selfie vidéo demandé par Facebook. Nous pouvons voir que cinq mouvements de tête sont demandés avec à chaque fois trois possibilités (gauche, droite ou haut). À noter que les mouvements sont différents à chaque rafraîchissement de page.

#figure(
  rect(image("../images/05-conception/facebook-example.png", width: 70%), stroke: 0.1pt),
  caption: "Exemple de selfie vidéo demandé par Facebook.",
) <facebook-example>



== Scénario 1 : création d'un faux compte

*Contexte :* l'attaquant veut créer un faux compte sur un site vulnérable pour nuire à la réputation de quelqu'un dont il possède une photo. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité.

#figure(
  rect(image("../images/05-conception/selfie-video-1.png"), stroke: 0.1pt),
  caption: "Scénario 1 : l'attaquant demande au démonstrateur de générer un selfie vidéo d'une personne à partir de son image.",
)

== Scénario 2 : modification de la date de naissance

*Contexte :* l'attaquant est une personne mineure qui possède déjà un compte sur un site vulnérable et qui cherche à modifier sa date de naissance pour accéder à des contenus ou services inappropriés. Il se connecte à son compte, change sa date de naissance et arrive à l'étape de vérification d'âge.

#figure(
  rect(image("../images/05-conception/selfie-video-2.png"), stroke: 0.1pt),
  caption: "Scénario 2 : l'attaquant demande au démonstrateur de générer un selfie vidéo de lui en plus âgé à partir de son image.",
)

= Vérification par scan de document d'identité et selfie vidéo sur ordinateur

Les sites concernés par ce pattern sont Migros Bank, Swissquote, Lotterie Romande, Swiss Casinos, Bet365, Binance et Kraken. L'interêt pour un attaquant de cibler ces sites serait de créer un faux compte pour commettre des fraudes financières. Par rapport au pattern précédent, il faut non seulement produire un selfie mais en plus, celui-ci doit correspondre à la photo d'un document d'identité à fournir.

== Scénario 1 : création d'un faux compte avec un document d'identité volé

*Contexte :* l'attaquant a volé une photo d'un document d'identité et veut créer un faux compte sur un site vulnérable pour commettre des fraudes financières. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité.

#figure(
  rect(image("../images/05-conception/ordinateur-1.png"), stroke: 0.1pt),
  caption: "Scénario 1 : l'attaquant a volé une photo d'un document d'identité et demande au démonstrateur de simuler le scan du document et de générer un selfie vidéo correspondant à la personne sur le document.",
)

== Scénario 2 : création d'un faux compte avec un document d'identité falsifié

*Contexte :* l'attaquant a récupéré un exemple de document d'identité sur Internet #footnote[https://media.lematin.ch/4/image/2025/11/12/d10f8b1e-512b-4e61-9ccb-6a391f05621f.jpg?auto=format%2Ccompress%2Cenhance&fit=max&w=1200&h=1200&rect=0%2C0%2C1024%2C640&fp-x=0.2265625&fp-y=0.44375&s=5c24eb000b8b1c27d35d5c4e9d79d9bd] et veut créer un faux compte sur un site vulnérable pour commettre des fraudes financières. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité.

#figure(
  rect(image("../images/05-conception/ordinateur-2.png"), stroke: 0.1pt),
  caption: "Scénario 2 : l'attaquant a récupéré un exemple de document d'identité sur Internet et demande au démonstrateur de le modifier avec des informations fictives. Ensuite, il demande de simuler le scan du document et de générer un selfie vidéo correspondant à la personne sur le document.",
)

= Vérification par scan de document d'identité et selfie vidéo sur smartphone

Les sites concernés par ce pattern sont UBS, Swissborg, Okx, Zak Cler et OkCupid. L'interêt pour l'attaquant est le même que pour le pattern précédent (sauf pour OkCupid qui est un site de rencontres), mais cette fois il y a la contrainte de devoir utiliser un smartphone au lieu d'un ordinateur.

Les scénarios sont donc les mêmes que dans le chapitre précédent, mais au lieu de passer par le navigateur pour la création du compte, l'attaquant passe par l'application mobile du site vulnérable, possiblement via un émulateur Android.

= Vérification par scan de document d'identité et appel vidéo

Les sites concernés par ce pattern sont Neon Bank, Revolut, Yuh et le Portail de l'Etat de Vaud. L'interêt pour l'attaquant est le même que pour les deux patterns précédents, mais cette fois il y a la contrainte de devoir effectuer un appel vidéo avec un agent humain au lieu d'une vérification automatisée.

De plus, comme pour le pattern précédent, la création du compte se fait via l'application mobile du site vulnérable.

== Scénario 1 : création d'un faux compte en sachant ce qui va être demandé lors de l'appel vidéo

*Contexte :* l'attaquant possède un document d'identité falsifié et veut créer un faux compte sur une application vulnérable pour commettre des fraudes financières. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité. L'attaquant sait ce qui va lui être demandé lors de l'appel vidéo (tenir le document d'identité devant la caméra, faire des mouvements de tête, etc.), il pré-enregistre donc une vidéo de lui en train d'effectuer ces actions.

#figure(
  rect(image("../images/05-conception/appel-1.png"), stroke: 0.1pt),
  caption: "Scénario 1 : l'attaquant sait ce qui est demandé lors de l'appel vidéo, il pré-enregistre une vidéo de lui en train d'effectuer les actions demandées et demande au démonstrateur de la modifier avec une autre personne et un autre document.",
)

== Scénario 2 : création d'un faux compte sans savoir ce qui va être demandé lors de l'appel vidéo

*Contexte :* l'attaquant possède un document d'identité falsifié et veut créer un faux compte sur une application vulnérable pour commettre des fraudes financières. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité. Ne sachant pas ce qui va lui être demandé lors de l'appel vidéo, il doit miser sur de l'ingénierie sociale pour réussir à tromper l'agent humain.

#figure(
  rect(image("../images/05-conception/appel-2.png"), stroke: 0.1pt),
  caption: "Scénario 2 : l'attaquant attend les instructions de l'employé, puis demande au démonstrateur de générer une vidéo de la personne en train d'effectuer les actions demandées. En attendant la génération, l'attaquant simule des problèmes de caméra.",
)

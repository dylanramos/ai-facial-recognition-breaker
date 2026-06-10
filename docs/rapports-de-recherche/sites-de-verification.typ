// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 10.1pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Sites de vérification d'identité"
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

Plusieurs sites demandent aujourd'hui une vérification d'identité, que ce soit pour créer un compte ou pour accéder à certaines fonctionnalités. L'objectif est de trouver des sites qui demandent une vérification d'identité et d'analyser comment ils vérifient l'identité des utilisateurs.

= Synthèse des recherches <synthese>

Plusieurs catégories de sites ont été testées, les réseaux sociaux, les banques, les casinos en ligne, les plateformes de trading, les sites de rencontre, etc. Ils ne demandent pas tous les mêmes informations, certains se contentent d'une simple photo d'un document d'identité, tandis que d'autres demandent une vérification via une caméra en direct. Un autre facteur à prendre en compte est qu'il faut souvent vérifier une adresse e-mail et/ou un numéro de téléphone, ce qui peut constituer une barrière supplémentaire pour les attaquants.

Les critères ci-dessous ont été analysés pour chaque site, ceux-ci permettront par la suite d'établir une échelle de difficulté pour les attaques :

- *Type* :
  - vérification par photo (ex : envoi d'une photo d'un document d'identité)
  - vérification par vidéo (ex : selfie vidéo ou scan d'un document d'identité)
  - vérification par appel vidéo (ex : appel vidéo avec un employé).
- *Documents d'identité* : nécessité de fournir des documents d'identité.
- *Uniquement via smartphone* : obligation d'utiliser un smartphone.
- *Vérification* : vérification de l'adresse e-mail et/ou du numéro de téléphone.

*Légende :*

#table(
  columns: (auto, auto),
  [*Couleur*], [*Signification*],
  table.cell(fill: red)[], [Aucune vérification d'identité demandée.],
  table.cell(fill: yellow)[], [Vérification d'identité sous certaines conditions],
  table.cell(fill: green)[], [Vérification d'identité demandée.],
)

#set par(justify: false)

#table(
  columns: (auto, auto, auto, auto, auto),
  align: horizon + center,
  [*Site*],
  [*Type*],
  [*Documents d'identité*],
  [*Uniquement via smartphone*],
  [*Vérification*],

  table.cell(fill: red)[*TikTok*], [-], [-], [-], [-],
  table.cell(fill: green)[*Facebook*], [Vidéo], [Non], [Non], [E-mail],
  table.cell(fill: red)[*Instagram*], [-], [-], [-], [-],
  table.cell(fill: red)[*Snapchat*], [-], [-], [-], [-],
  table.cell(fill: yellow)[*LinkedIn*], [-], [-], [-], [-],
  table.cell(fill: yellow)[*Discord*], [-], [-], [-], [-],
  table.cell(fill: yellow)[*Youtube*], [-], [-], [-], [-],
  table.cell(fill: green)[*Migros Bank*], [Vidéo], [Oui], [Non], [N° de téléphone],
  table.cell(fill: green)[*Neon Bank*], [Appel vidéo], [Oui], [Oui], [E-mail + n° de téléphone],
  table.cell(fill: green)[*Swissquote*], [Vidéo], [Oui], [Non], [E-mail],
  table.cell(fill: red)[*E-ID*], [-], [-], [-], [-],
  table.cell(fill: green)[*Revolut*], [Appel vidéo], [Oui], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Yuh*], [Appel vidéo], [Oui], [Oui], [E-mail + n° de téléphone],
  table.cell(fill: green)[*UBS*], [Photo], [Oui], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Coinbase*], [Photo], [Oui], [Non], [N° de téléphone],
  table.cell(fill: green)[*Swissborg*], [Photo], [Oui], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Zak Cler*], [Vidéo], [Oui], [Oui], [E-mail],
  table.cell(fill: red)[*X*], [-], [-], [-], [-],
  table.cell(fill: green)[*Portail Etat de Vaud*], [Appel vidéo], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Lotterie Romande*], [Vidéo], [Oui], [Oui], [E-mail + n° de téléphone],
  table.cell(fill: green)[*Mycasino*], [Photo], [Oui], [Non], [-],
  table.cell(fill: green)[*Swiss Casinos*], [Vidéo], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Casino777*], [Photo], [Oui], [Non], [-],
  table.cell(fill: red)[*Polymarket*], [-], [-], [-], [-],
  table.cell(fill: green)[*Bet365*], [Vidéo], [Oui], [Non], [N° de téléphone],
  table.cell(fill: green)[*Binance*], [Vidéo], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Bybit*], [Photo], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Kraken*], [Photo], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Okx*], [Vidéo], [Oui], [Oui], [E-mail + n° de téléphone],
  table.cell(fill: green)[*Tea for Women*], [Photo], [Non], [Non], [-],
  table.cell(fill: yellow)[*Upwork*], [Photo], [Oui], [Non], [E-mail],
  table.cell(fill: green)[*Roblox*], [Vidéo], [Non], [Non], [-],
  table.cell(fill: green)[*Parship*], [Vidéo], [Non], [Non], [-],
  table.cell(fill: red)[*Tinder*], [-], [-], [-], [-],
  table.cell(fill: red)[*Grindr*], [-], [-], [-], [-],
  table.cell(fill: green)[*OkCupid*], [Photo], [Non], [Oui], [N° de téléphone],
  table.cell(fill: green)[*Google*], [Vidéo], [Non], [Non], [-],
)

#set par(justify: true)

= Sites sans vérification d'identité

Les sites en rouge du tableau du #underline()[@synthese] ne demandent aucune vérification d'identité, c'est notamment le cas pour certains réseaux sociaux. En sachant qu'en Australie une récente loi oblige les plateformes à vérifier l'âge de leurs utilisateurs #footnote[https://www.oaic.gov.au/__data/assets/pdf_file/0025/257515/SMMA-Fact-Sheets-General.pdf], des tests ont été effectués avec un VPN pour voir s'il y avait bien une demande de vérification d'identité. Mais impossible de le savoir, car ces sites ne fonctionnent plus lorsque le VPN est activé, comme le démontrent les images ci-dessous.

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/02-sites-de-verification/tiktok-australie.png"), stroke: 0.1pt),
    caption: "Erreur lors de la création d'un compte TikTok.",
  ),
  figure(rect(image("../images/02-sites-de-verification/x.png"), stroke: 0.1pt), caption: "Erreur lors de la création d'un compte X."),
)

= Sites avec vérification d'identité sous certaines conditions

Les sites en jaune du tableau du #underline()[@synthese] demandent une vérification d'identité sous certaines conditions, la liste ci-dessous présente les conditions pour lesquelles une vérification est demandée pour ces sites :

- LinkedIn : vérification d'identité pour obtenir un badge de vérification, mais il y a une liste d'attente.
- Discord : vérification d'identité si le compte est suspecté d'être utilisé par un mineur.
- Youtube : vérification d'identité si le compte est suspecté d'être utilisé par un mineur.
- Upwork : vérification d'identité pour obtenir un badge de vérification, mais il faut avoir 35 "connects" (en payant).

= Sites avec vérification d'identité <vert>

Les sites en vert dans le tableau du #underline()[@synthese] demandent une vérification d'identité obligatoire, ils sont détaillés ci-dessous.

== Facebook

Facebook demande une vérification d'identité lors de la création d'un compte. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.facebook.com/reg/?entry_point=login&next=")]
*Processus de vérification d'identité :*
+ Vérifier l'adresse e-mail.
+ Effectuer un selfie vidéo.

#figure(
  rect(image("../images/02-sites-de-verification/facebook.png", width: 50%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Facebook.",
)

== Migros Bank

Migros Bank demande une vérification d'identité lors de la création d'un compte. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.migrosbank.ch/onb-onboarding/onboarding/personal-data")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Scanner une pièce d'identité avec la caméra.
+ Effectuer un selfie vidéo.

#figure(
  rect(image("../images/02-sites-de-verification/migros-bank.png", width: 30%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Migros Bank.",
)

== Neon Bank

Neon Bank demande une vérification d'identité lors de la création d'un compte. Cette vérification doit se faire sur smartphone.
- Lien : #underline()[#link("https://neon-free.ch/")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Vérifier l'adresse e-mail.
+ Effectuer un appel vidéo avec un employé.

#figure(
  rect(image("../images/02-sites-de-verification/neon-bank.jpg", width: 30%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Neon Bank.",
)

== Swissquote

Swissquote demande une vérification d'identité lors de la création d'un compte. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.swissquote.com/en-ch/become-client/open-account")]
*Processus de vérification d'identité :*
+ Vérifier l'adresse e-mail.
+ Effectuer un selfie vidéo.
+ Scanner une pièce d'identité avec la caméra.

#figure(
  rect(image("../images/02-sites-de-verification/swissquote.png", width: 50%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Swissquote.",
)

== Revolut

Revolut demande une vérification d'identité lors de la création d'un compte. Cette vérification doit se faire sur smartphone.
- Lien : #underline()[#link("https://www.revolut.com/fr-CH/")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Effectuer un appel vidéo avec un employé.

#emph[Remarque : l'application empêche de faire des captures d'écran.]

== Yuh

Yuh demande une vérification d'identité lors de la création d'un compte. Cette vérification doit se faire sur smartphone.
- Lien : #underline()[#link("https://www.yuh.com/en/")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Vérifier l'adresse e-mail.
+ Effectuer un appel vidéo avec un employé.

#figure(
  rect(image("../images/02-sites-de-verification/yuh.jpg", width: 30%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Yuh.",
)

== UBS

UBS demande une vérification d'identité lors de la création d'un compte. Cette vérification doit se faire sur smartphone.
- Lien : #underline()[#link("https://www.ubs.com/ch/fr/services/accounts-and-cards/daily-banking/private-account-adults/key4.html#explore")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Scanner une pièce d'identité avec la caméra.

#emph[Remarque : l'application empêche de faire des captures d'écran.]

== Coinbase

Coinbase demande une vérification d'identité lors de la création d'un compte. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.coinbase.com/")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Envoyer une photo d'un document d'identité.

#figure(
  rect(image("../images/02-sites-de-verification/coinbase.png", width: 50%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Coinbase.",
)

== Swissborg

Swissborg demande une vérification d'identité lors de la création d'un compte. Cette vérification doit se faire sur smartphone.
- Lien : #underline()[#link("https://swissborg.com/sign-up")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Scanner une pièce d'identité avec la caméra.

#emph[Remarque : pas de capture d'écran car mon compte est déjà vérifié.]

== Zak Cler

Zak Cler demande une vérification d'identité lors de la création d'un compte. Cette vérification doit se faire sur smartphone.
- Lien : #underline()[#link("https://www.cler.ch/fr")]
*Processus de vérification d'identité :*
+ Vérifier l'adresse e-mail.
+ Scanner une pièce d'identité avec la caméra.
+ Effectuer un selfie vidéo.

#figure(
  rect(image("../images/02-sites-de-verification/zak.jpg", width: 30%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Zak Cler.",
)

== Portail de l'Etat de Vaud

Le Portail de l'Etat de Vaud demande une vérification d'identité lors de la création d'un compte. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.vd.ch/prestation/demander-un-moyen-didentification-electronique-et-lacces-au-portail-securise")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Prendre rendez-vous avec un employé pour un appel vidéo.

#figure(
  rect(image("../images/02-sites-de-verification/etat-de-vaud.png", width: 70%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité du Portail de l'Etat de Vaud.",
)

== Lotterie Romande

La Lotterie Romande demande une vérification d'identité lors de la création d'un compte. Cette vérification doit se faire sur smartphone.
- Lien : #underline()[#link("https://jeux.loro.ch/account/registration-start")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Vérifier l'adresse e-mail.
+ Scanner une pièce d'identité avec la caméra.

#figure(
  rect(image("../images/02-sites-de-verification/loro.jpg", width: 30%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de la Lotterie Romande.",
)

== Mycasino

Mycasino demande une vérification d'identité pour pouvoir retirer de l'argent. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.mycasino.ch/fr/")]
*Processus de vérification d'identité :*
+ Envoyer une photo d'un document d'identité.

#figure(
  rect(image("../images/02-sites-de-verification/mycasino.png", width: 60%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Mycasino.",
)

== Swiss Casinos

Swiss Casinos demande une vérification d'identité pour pouvoir retirer de l'argent. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://online.swisscasinos.ch/fr/")]
*Processus de vérification d'identité :*
+ Vérifier l'adresse e-mail.
+ Scanner une pièce d'identité avec la caméra.

#figure(
  rect(image("../images/02-sites-de-verification/swiss-casinos.png", width: 80%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Swiss Casinos.",
)

== Casino777

Casino777 demande une vérification d'identité pour pouvoir retirer de l'argent. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.casino777.ch/fr/")]
*Processus de vérification d'identité :*
+ Envoyer une photo d'un document d'identité.

#figure(
  rect(image("../images/02-sites-de-verification/casino777.png", width: 40%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Casino777.",
)

== Bet365

Bet365 demande une vérification d'identité pour pouvoir parier de l'argent. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.bet365.com/")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Scanner une pièce d'identité avec la caméra.

#figure(
  rect(image("../images/02-sites-de-verification/bet365.png", width: 40%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Bet365.",
)

== Binance

Binance demande une vérification d'identité pour pouvoir acheter des cryptomonnaies. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.binance.com/")]
*Processus de vérification d'identité :*
+ Vérifier l'adresse e-mail.
+ Scanner une pièce d'identité avec la caméra.

#figure(
  rect(image("../images/02-sites-de-verification/binance.png", width: 50%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Binance.",
)

== Bybit

Bybit demande une vérification d'identité pour pouvoir acheter des cryptomonnaies. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.bybit.com/")]
*Processus de vérification d'identité :*
+ Vérifier l'adresse e-mail.
+ Envoyer une photo d'un document d'identité.

#figure(
  rect(image("../images/02-sites-de-verification/bybit.png", width: 40%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Bybit.",
)

== Kraken

Kraken demande une vérification d'identité pour pouvoir acheter des cryptomonnaies. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.kraken.com/")]
*Processus de vérification d'identité :*
+ Vérifier l'adresse e-mail.
+ Scanner une pièce d'identité avec la caméra.

#figure(
  rect(image("../images/02-sites-de-verification/kraken.png", width: 50%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Kraken.",
)

== Okx

Okx demande une vérification d'identité pour pouvoir acheter des cryptomonnaies. Cette vérification doit se faire sur smartphone.
- Lien : #underline()[#link("https://www.okx.com/")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Vérifier l'adresse e-mail.
+ Scanner une pièce d'identité avec la caméra.

#figure(
  rect(image("../images/02-sites-de-verification/okx.png", width: 60%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Okx.",
)

== Tea for Women

Tea for Women demande une vérification d'identité lors de la création d'un compte. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.teaforwomen.com/")]
*Processus de vérification d'identité :*
+ Effectuer un selfie vidéo.

#figure(
  rect(image("../images/02-sites-de-verification/tea.png", width: 50%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Tea for Women.",
)

== Roblox

Roblox demande une vérification d'identité pour accéder à certaines fonctionnalités. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://www.roblox.com/my/account#!/info")]
*Processus de vérification d'identité :*
+ Effectuer un selfie vidéo.

#figure(
  rect(image("../images/02-sites-de-verification/roblox.png", width: 30%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Roblox.",
)

== Parship

Parship demande une vérification d'identité lors de la création d'un compte. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://uk.parship.com/")]
*Processus de vérification d'identité :*
+ Effectuer un selfie vidéo.

#figure(
  rect(image("../images/02-sites-de-verification/parship.png", width: 40%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Parship.",
)

== OkCupid

OkCupid demande une vérification d'identité lors de la création d'un compte. Cette vérification doit se faire sur smartphone.
- Lien : #underline()[#link("https://www.okcupid.com/")]
*Processus de vérification d'identité :*
+ Vérifier le numéro de téléphone.
+ Scanner une pièce d'identité avec la caméra.

#emph[Remarque : pas de capture d'écran car mon compte est banni.]

== Google

Google demande une vérification d'identité lors du changement de la date de naissance de mineur à majeur. Cette vérification peut se faire sur ordinateur.
- Lien : #underline()[#link("https://accounts.google.com/")]
*Processus de vérification d'identité :*
+ Effectuer un selfie vidéo.

#figure(
  rect(image("../images/02-sites-de-verification/google.png", width: 40%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Google.",
)

= Identification des sites cibles

== Sites exclus

Les sites en rouge et en jaune du tableau du #underline()[@synthese] ne seront pas testés lors des attaques, car soit ils ne demandent aucune vérification d'identité, soit la vérification d'identité n'est pas systématique et dépend de conditions qui sont trop difficiles à reproduire. Ceux-ci sont les suivants :
- TikTok
- Instagram
- Snapchat
- LinkedIn
- Discord
- Youtube
- E-ID
- X
- Polymarket
- Tinder
- Grindr

Les sites du #underline()[@vert] demandent tous une vérification d'identité, mais certains ne sont pas intéressants dans le cadre de ce projet. C'est le cas pour les sites qui ne demandent que d'envoyer une photo d'un document d'identité, car un attaquant peut simplement voler une photo d'un document d'identité et l'IA n'est donc pas nécessaire. Les sites concernés sont :
- Coinbase
- Mycasino
- Casino777
- Bybit

== Sites cibles <sites-cibles>

Le reste des sites sont ceux qui seront testés lors des attaques, car ils impliquent l'utilisation de l'IA, notamment pour générer des vidéos. Ceux-ci sont les suivants :
- Facebook : #underline()[#link("https://www.facebook.com/reg/?entry_point=login&next=")]
- Migros Bank : #underline()[#link("https://www.migrosbank.ch/onb-onboarding/onboarding/personal-data")]
- Neon Bank : #underline()[#link("https://neon-free.ch/")]
- Swissquote : #underline()[#link("https://www.swissquote.com/en-ch/become-client/open-account")]
- Revolut : #underline()[#link("https://www.revolut.com/fr-CH/")]
- Yuh : #underline()[#link("https://www.yuh.com/en/")]
- UBS : #underline()[#link("https://www.ubs.com/ch/fr/services/accounts-and-cards/daily-banking/private-account-adults/key4.html#explore")]
- Swissborg : #underline()[#link("https://swissborg.com/sign-up")]
- Zak Cler : #underline()[#link("https://www.cler.ch/fr")]
- Portail Etat de Vaud : #underline()[#link("https://www.vd.ch/prestation/demander-un-moyen-didentification-electronique-et-lacces-au-portail-securise")]
- Lotterie Romande : #underline()[#link("https://jeux.loro.ch/account/registration-start")]
- Swiss Casinos : #underline()[#link("https://online.swisscasinos.ch/fr/")]
- Bet365 : #underline()[#link("https://www.bet365.com/")]
- Binance : #underline()[#link("https://www.binance.com/")]
- Kraken : #underline()[#link("https://www.kraken.com/")]
- Okx : #underline()[#link("https://www.okx.com/")]
- Tea for Women : #underline()[#link("https://www.teaforwomen.com/")]
- Roblox : #underline()[#link("https://www.roblox.com/my/account#!/info")]
- Parship : #underline()[#link("https://uk.parship.com/")]
- OkCupid : #underline()[#link("https://www.okcupid.com/")]
- Google : #underline()[#link("https://accounts.google.com/")]

= Patterns de vérification des sites cibles <patterns>

Parmis les sites identifiés au #underline()[@sites-cibles], plusieurs d'entre utilisent un même processus de vérification d'identité.

== Vérification par selfie vidéo uniquement <selfie-video>

Facebook, Tea for Women, Roblox, Parship et Google demandent une vérification d'identité par selfie vidéo sans avoir à fournir de documents d'identité. Ces sites semblent être les plus faciles à attaquer car il n'est pas nécessaire de fournir de documents d'identité. De plus, la vérification peut se faire sur un ordinateur, ce qui facilite la mise en place d'une caméra virtuelle.

#figure(
  rect(image("../images/02-sites-de-verification/verif-1.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par selfie vidéo.",
)

== Vérification par scan de document d'identité et selfie vidéo sur ordinateur <scan-ordinateur>

Migros Bank, Swissquote, Lotterie Romande, Swiss Casinos, Bet365, Binance et Kraken demandent une vérification d'identité par scan de document d'identité et selfie vidéo (pour certains) sur ordinateur. Ces sites sont un peu plus difficiles à attaquer que ceux du #underline()[@selfie-video] car il est nécessaire de fournir des documents d'identité, ce qui implique de devoir voler des documents d'identité ou d'en générer de faux. De plus, le selfie vidéo, lorsqu'il est requis, doit correspondre à la photo sur le document d'identité.

#figure(
  rect(image("../images/02-sites-de-verification/verif-2.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par scan de document d'identité et selfie vidéo sur ordinateur.",
)

== Vérification par scan de document d'identité et selfie vidéo sur smartphone <scan-smartphone>

UBS, Swissborg, Okx, Zak Cler et OkCupid demandent aussi une vérification d'identité par scan de document d'identité et selfie vidéo, mais celle-ci doit se faire sur smartphone. Cela rend l'attaque plus difficile que pour les sites du #underline()[@scan-ordinateur] car il est nécessaire de gérer une caméra virtuelle sur un smartphone.

#figure(
  rect(image("../images/02-sites-de-verification/verif-3.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par scan de document d'identité et selfie vidéo sur smartphone.",
)

== Vérification par scan de document d'identité et appel vidéo <appel-video>

Neon Bank, Revolut, Yuh et le Portail de l'Etat de Vaud demandent une vérification d'identité par scan de document d'identité suivie d'un appel vidéo avec un employé. Ces sites semblent être les plus difficiles à attaquer car il faut non seulement fournir des documents d'identité, mais aussi réussir à tromper un employé lors d'un appel vidéo sur un smartphone.

#figure(
  rect(image("../images/02-sites-de-verification/verif-4.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par scan de document d'identité et appel vidéo.",
)

= Classement des sites par difficulté d'attaque

En se basant sur les patterns de vérification d'identité identifiés au chapitre précédent, les sites candidats peuvent être classés par difficulté d'attaque de la manière suivante :

*Facile :*
- Facebook
- Tea for Women
- Roblox
- Parship
- Google
*Intermédiaire :*
- Migros Bank
- Swissquote
- Lotterie Romande
- Swiss Casinos
- Bet365
- Binance
- Kraken
*Difficile :*
- UBS
- Swissborg
- Okx
- Zak Cler
- OkCupid
*Très difficile :*
- Neon Bank
- Revolut
- Yuh
- Portail de l'Etat de Vaud

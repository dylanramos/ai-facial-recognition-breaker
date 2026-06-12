// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Sites de vérification d'identité

== Introduction

Les sites demandant une vérification d'identité sont plus ou moins sensibles, parmi ceux-ci, nous y trouvons des réseaux sociaux, des sites de rencontres, des casinos en ligne ou encore des banques. Lors de la création d'un compte par exemple, ils ne demandent pas tous les mêmes informations, certains se contentent d'un simple selfie vidéo, tandis que d'autres exigent une vérification plus poussée, notamment en obligeant l'utilisateur à fournir un document d'identité.

Ce chapitre présente les sites candidats pour nos tests, c'est-à-dire ceux qui demandent systématiquement une vérification d'identité. Les sites analysés qui n'ont pas été retenus sont ceux qui ne demandent pas de vérification d'identité ou qui demandent une vérification d'identité sous certaines conditions (en détectant une activité suspecte par exemple), ceux-ci sont détaillés dans les chapitres 3 et 4 du rapport détaillé #link("../rapports-detailles/sites-de-verification.pdf")[#underline("sites-de-verification.pdf")].

== Synthèse des recherches

Les critères ci-dessous ont été analysés pour chaque site, ceux-ci ont permis par la suite d'établir une échelle de difficulté pour les attaques :

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

Les sites candidats sont donc :

#set par(justify: false)

- *Facebook* : #underline()[#link("https://www.facebook.com/reg/?entry_point=login&next=")]
- *Migros Bank* : #underline()[#link("https://www.migrosbank.ch/onb-onboarding/onboarding/personal-data")]
- *Neon Bank* : #underline()[#link("https://neon-free.ch/")]
- *Swissquote* : #underline()[#link("https://www.swissquote.com/en-ch/become-client/open-account")]
- *Revolut* : #underline()[#link("https://www.revolut.com/fr-CH/")]
- *Yuh* : #underline()[#link("https://www.yuh.com/en/")]
- *UBS* : #underline()[#link("https://www.ubs.com/ch/fr/services/accounts-and-cards/daily-banking/private-account-adults/key4.html#explore")]
- *Swissborg* : #underline()[#link("https://swissborg.com/sign-up")]
- *Zak Cler* : #underline()[#link("https://www.cler.ch/fr")]
- *Portail Etat de Vaud* : #underline()[#link("https://www.vd.ch/prestation/demander-un-moyen-didentification-electronique-et-lacces-au-portail-securise")]
- *Lotterie Romande* : #underline()[#link("https://jeux.loro.ch/account/registration-start")]
- *Swiss Casinos* : #underline()[#link("https://online.swisscasinos.ch/fr/")]
- *Bet365* : #underline()[#link("https://www.bet365.com/")]
- *Binance* : #underline()[#link("https://www.binance.com/")]
- *Kraken* : #underline()[#link("https://www.kraken.com/")]
- *Okx* : #underline()[#link("https://www.okx.com/")]
- *Tea for Women* : #underline()[#link("https://www.teaforwomen.com/")]
- *Roblox* : #underline()[#link("https://www.roblox.com/my/account#!/info")]
- *Parship* : #underline()[#link("https://uk.parship.com/")]
- *OkCupid* : #underline()[#link("https://www.okcupid.com/")]
- *Google* : #underline()[#link("https://accounts.google.com/")]

Une analyse détaillée du processus de vérification de chacun des sites mentionnés ci-dessus est disponible dans le chapitre 5 du rapport détaillé #link("../rapports-detailles/sites-de-verification.pdf")[#underline("sites-de-verification.pdf")].

#set par(justify: true)

== Patterns de vérification d'identité <patterns>

Certains processus de vérification d'identité sont similaires d'un site à l'autre, ainsi, il a été possible d'identifier 4 patterns de vérification d'identité parmi les sites candidats.

=== Vérification par selfie vidéo uniquement <selfie-video>

Facebook, Tea for Women, Roblox, Parship et Google demandent une vérification d'identité par selfie vidéo sans avoir à fournir de documents d'identité. Ces sites semblent être les plus faciles à attaquer car il n'est pas nécessaire de fournir de documents d'identité. De plus, la vérification peut se faire sur un ordinateur, ce qui facilite la mise en place d'une caméra virtuelle.

#figure(
  rect(image("../../images/02-sites-de-verification/verif-1.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par selfie vidéo.",
)

=== Vérification par scan de document d'identité et selfie vidéo sur ordinateur <scan-ordinateur>

Migros Bank, Swissquote, Lotterie Romande, Swiss Casinos, Bet365, Binance et Kraken demandent une vérification d'identité par scan de document d'identité et selfie vidéo (pour certains) sur ordinateur. Ces sites sont un peu plus difficiles à attaquer que ceux du #underline()[@selfie-video] car il est nécessaire de fournir des documents d'identité, ce qui implique de devoir voler des documents d'identité ou d'en générer de faux. De plus, le selfie vidéo, lorsqu'il est requis, doit correspondre à la photo sur le document d'identité.

#figure(
  rect(image("../../images/02-sites-de-verification/verif-2.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par scan de document d'identité et selfie vidéo sur ordinateur.",
)

=== Vérification par scan de document d'identité et selfie vidéo sur smartphone

UBS, Swissborg, Okx, Zak Cler et OkCupid demandent aussi une vérification d'identité par scan de document d'identité et selfie vidéo, mais celle-ci doit se faire sur smartphone. Cela rend l'attaque plus difficile que pour les sites du #underline[@scan-ordinateur] car il est nécessaire de gérer une caméra virtuelle sur un smartphone.

#figure(
  rect(image("../../images/02-sites-de-verification/verif-3.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par scan de document d'identité et selfie vidéo sur smartphone.",
)

=== Vérification par scan de document d'identité et appel vidéo

Neon Bank, Revolut, Yuh et le Portail de l'Etat de Vaud demandent une vérification d'identité par scan de document d'identité suivie d'un appel vidéo avec un employé. Ces sites semblent être les plus difficiles à attaquer car il faut non seulement fournir des documents d'identité, mais aussi réussir à tromper un employé lors d'un appel vidéo sur un smartphone.

#figure(
  rect(image("../../images/02-sites-de-verification/verif-4.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par scan de document d'identité et appel vidéo.",
)

== Classement des sites par difficulté d'attaque

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

=== Exemple 1 : pourquoi Facebook semble facile à attaquer ?

Comme le montre le chapitre 5.1 du rapport détaillé #link("../rapports-detailles/sites-de-verification.pdf")[#underline("sites-de-verification.pdf")], Facebook ne demande qu'une vérification d'identité par selfie vidéo, cela signifie que c'est un algorithme qui va déterminer si la personne est humaine et non un employé de Facebook. D'autre part, aucun document d'identité n'est demandé, l'attaquant n'a donc pas besoin de voler ou de générer un document d'identité et n'a pas besoin non plus de faire correspondre le visage sur le document d'identité avec celui de la vidéo. Enfin, la vérification peut se faire sur un ordinateur, ce qui facilite la mise en place d'une caméra virtuelle.

#figure(
  rect(image("../../images/02-sites-de-verification/facebook.png", width: 50%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Facebook.",
)

=== Exemple 2 : pourquoi Neon Bank semble très difficile à attaquer ?

Comme le montre le chapitre 5.3 du rapport détaillé #link("../rapports-detailles/sites-de-verification.pdf")[#underline("sites-de-verification.pdf")], Neon Bank demande une vérification d'identité lors d'un appel vidéo avec un employé. Cela complique grandement la tâche pour un attaquant car il doit non seulement obtenir un document d'identité, mais aussi faire correspondre le visage sur le document d'identité avec celui de l'appel vidéo, le tout en réussissant à tromper l'employé en temps réel sur un smartphone.

#figure(
  rect(image("../../images/02-sites-de-verification/neon-bank.jpg", width: 30%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Neon Bank.",
)

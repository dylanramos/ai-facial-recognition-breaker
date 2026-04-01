// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= État de l'art

== Sites de vérification d'identité

Les sites demandant une vérification d'identité sont plus ou moins sensibles, parmi ceux-ci, on peut trouver des réseaux sociaux, des sites de rencontres, des casinos en ligne ou encore des banques. Ils ne demandent pas tous les mêmes informations, certains se contentent d'une simple photo d'un document d'identité, tandis que d'autres demandent une vérification via une caméra. Un autre facteur à prendre en compte est que parfois, la vérification se fait lors d'un appel vidéo avec un employé, ce qui complique la tâche pour les attaquants.

=== Sites cibles

La liste ci-dessous présente les sites qui seront ciblés pour les attaques, ceux-ci ont été sélectionnés car ils impliquent l'utilisation de l'IA, notamment pour générer des vidéos. Les critères de sélection ainsi que les sites exclus sont détaillés dans le #link("../rapports-de-recherche/sites-de-verification/sites-de-verification.pdf")[#underline("chapitre 2 du rapport de recherche sites-de-verification.pdf")].

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

=== Patterns de vérification d'identité <patterns>

Ci-dessous, les quatre patterns de vérification d'identité identifiés lors de l'analyse des sites cibles. Pour plus de détails concernant le processus de vérification de ceux-ci, consulter le #link("../rapports-de-recherche/sites-de-verification/sites-de-verification.pdf")[#underline("chapitre 7 du rapport de recherche sites-de-verification.pdf")].

*Vérification par selfie vidéo uniquement*

#figure(
  rect(image("../images/02-etat-de-lart/verif-1.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par selfie vidéo.",
)

Sites concernés :
- Facebook
- Tea for Women
- Roblox
- Parship
- Google

*Vérification par scan de document d'identité et selfie vidéo sur ordinateur*

#figure(
  rect(image("../images/02-etat-de-lart/verif-2.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par scan de document d'identité et selfie vidéo sur ordinateur.",
)

Sites concernés :
- Migros Bank
- Swissquote
- Lotterie Romande
- Swiss Casinos
- Bet365
- Binance
- Kraken

*Vérification par scan de document d'identité et selfie vidéo sur smartphone*

#figure(
  rect(image("../images/02-etat-de-lart/verif-3.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par scan de document d'identité et selfie vidéo sur smartphone.",
)

Sites concernés :
- UBS
- Swissborg
- Okx
- OkCupid

*Vérification par scan de document d'identité et appel vidéo*

#figure(
  rect(image("../images/02-etat-de-lart/verif-4.png"), stroke: 0.1pt),
  caption: "Processus de vérification d'identité par scan de document d'identité et appel vidéo.",
)

Sites concernés :
- Neon Bank
- Revolut
- Yuh
- Zak Cler
- Portail de l'Etat de Vaud

=== Classement des sites par difficulté d'attaque

En se basant sur les patterns de vérification d'identité identifiés au #underline()[@patterns], les sites cibles peuvent être classés par difficulté d'attaque comme suit :

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
- OkCupid
*Très difficile :*
- Neon Bank
- Revolut
- Yuh
- Zak Cler
- Portail de l'Etat de Vaud

*Exemple 1 : pourquoi Facebook est facile à attaquer ?*

Comme le montre le #link("../rapports-de-recherche/sites-de-verification/sites-de-verification.pdf")[#underline("chapitre 5.1 du rapport de recherche sites-de-verification.pdf")], Facebook ne demande qu'une vérification d'identité par selfie vidéo, cela signifie que c'est un algorithme qui va déterminer si la personne est humaine et non un employé de Facebook. D'autre part, aucun document d'identité n'est demandé, l'attaquant n'a donc pas besoin de voler ou de générer un document d'identité et n'a pas besoin non plus de faire correspondre le visage sur le document d'identité avec celui de la vidéo. Enfin, la vérification peut se faire sur un ordinateur, ce qui facilite la mise en place d'une caméra virtuelle.

#figure(
  rect(image("../images/02-etat-de-lart/facebook.png", width: 50%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Facebook.",
)

*Exemple 2 : pourquoi Neon Bank est très difficile à attaquer ?*

Comme le montre le #link("../rapports-de-recherche/sites-de-verification/sites-de-verification.pdf")[#underline("chapitre 5.3 du rapport de recherche sites-de-verification.pdf")], Neon Bank demande une vérification d'identité lors d'un appel vidéo avec un employé. Cela complique grandement la tâche pour un attaquant car il doit non seulement obtenir un document d'identité, mais aussi faire correspondre le visage sur le document d'identité avec celui de l'appel vidéo, le tout en réussissant à tromper l'employé en temps réel sur un smartphone.

#figure(
  rect(image("../images/02-etat-de-lart/neon-bank.jpg", width: 30%), stroke: 0.1pt),
  caption: "Processus de vérification d'identité de Neon Bank.",
)

== Génération d'images et de vidéos IA

*Analyses détaillées* : #link("../rapports-de-recherche/generation-ia/generation-ia.pdf")[#underline("generation-ia.pdf")]

Pour qu'un attaquant puisse modifier la photo d'une personne sur un document d'identité ou générer une vidéo d'une personne effectuant une vérification d'identité, il doit utiliser des modèles de génération d'images et de vidéos IA.

Ainsi, la solution la plus simple pour utiliser ces différents modèles est de passer par un service d'API. Un service d'API est une plateforme qui regroupe les APIs des différents services de génération. Il met à disposition une API qui permet d'utiliser plusieurs modèles d'IA de manière centralisée et moins coûteuse que chez les fournisseurs directement. Le service d'API choisi est #link("https://kie.ai/")[#underline("Kie.ai")].

=== Modèles de génération d'images

Il y a deux catégories de modèles de génération d'images :

- *Text-to-Image :* qui sont des modèles créatifs qui créent des images à partir de rien et qui sont utiles pour générer des images de personnes fictives.
- *Image-to-Image :* qui sont des modèles d'édition d'images qui modifient une image fournie et qui sont utiles pour modifier une photo sur un document d'identité.

Généralement, les modèles de génération d'images proposent les deux catégories de modèles, le tableau ci-dessous concerne donc les deux catégories.

*Text-to-Image et Image-to-Image*

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Qualité de l'image*], [*Prix*],

    [*Nano Banana 2*], [4k], [0.09\$],
    [*GPT Image 1.5*], [4k], [0.11\$],
    [*Seedream 4.5*], [4k], [0.0325\$],
    [*Grok Imagine*], [2k], [0.02\$],
    [*Flux 2*], [2k], [0.12\$],
  ),
  caption: "Comparaison des modèles de génération d'images en qualité maximale.",
)

Il n'y a pas forcément de modèles meilleurs que d'autres, il faudra donc les tester le moment venu pour déterminer lequel est le plus adapté aux attaques à réaliser.

=== Modèles de génération de vidéos

Il y a trois catégories de modèles de génération de vidéos :

- *Text-to-Video :* qui sont des modèles créatifs qui créent des vidéos à partir de rien et qui ne seront probablement pas utiles pour les attaques à réaliser.
- *Image-to-Video :* qui sont des modèles plus contrôlables visuellement car ils prennent deux images en entrée, une pour débuter la séquence et l'autre pour la terminer. Ainsi, ils permettent par exemple de faire correspondre le visage de la personne dans la vidéo avec celui sur les documents d'identité.
- *Video-to-Video :* qui sont des modèles d'édition de vidéos qui prennent une vidéo et une image de référence en entrée. Ils sont particulièrement utiles car ils permettent d'enregistrer une vidéo au préalable puis de remplacer la vraie personne par une autre personne.

Comme pour les modèles de génération d'images, les modèles de génération de vidéos proposent généralement une version Text-to-Video et Image-to-Video. Les modèles de type Video-to-Video eux, sont plus spécifiques et ont des modèles dédiés.

#pagebreak()

*Text-to-Video et Image-to-Video*

#figure(
  table(
    columns: (1fr, auto, auto, auto, auto),
    align: horizon + center,
    [*Modèle*], [*Temps de vidéo*], [*Qualité de la vidéo*], [*Audio*], [*Prix*],

    [*Veo 3.1*], [8s], [1080p], [Oui], [1.25\$],
    [*Sora 2*], [15s], [720p], [Oui], [0.20\$],
    [*Kling 3.0*], [15s], [1080p], [Oui], [3.00\$],
    [*Wan 2.6*], [15s], [1080p], [Oui], [1.575\$],
    [*Grok Imagine*], [15s], [720p], [Oui], [0.20\$],
    [*Hailuo 2.3*], [10s], [768p], [Non], [0.45\$],
  ),
  caption: "Comparaison des modèles de génération de vidéos en qualité maximale.",
)

*Video-to-Video*

À ce jour, le seul modèle de type Video-to-Video disponible sur Kie.ai est *Kling 3.0 motion control*. Les prix sont les suivants :

- Pour une vidéo en 720p : *0.10\$ par seconde*.
- Pour une vidéo en 1080p : *0.135\$ par seconde*.

== Caméras virtuelles et redirection de flux vidéo

*Analyses détaillées* : #link("../rapports-de-recherche/cameras-virtuelles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")]

Pour pouvoir tromper les sites de vérification d'identité, il faut trouver un moyen de rediriger la vidéo générée vers une caméra détectée comme réelle par ceux-ci. La solution la plus simple est d'utiliser une caméra virtuelle, qui est un périphérique logiciel simulant une caméra physique.

Chaque OS a sa propre manière de gérer les caméras virtuelles. Sous Linux, il faut passer par un module du noyau dédié, alors que sous Windows, il faut développer son propre pilote de caméra virtuelle.

=== pyvirtualcam

Pour éviter de devoir s'adapter à chaque OS et pour simplifier le développement du démonstrateur, la solution choisie est d'utiliser la librairie Python `pyvirtualcam` qui permet d'envoyer des flux vidéo à une caméra virtuelle de manière simple et multiplateforme.

== Conclusion

Les attaques se concentreront dans un premier temps sur les sites les plus faciles à attaquer.

Pour les sites qui demandent une vérification par photo, il faudra commencer par tester avec des images non générées pour voir si l'IA peut vraiment apporter quelque chose ou si une simple photo d'une autre personne suffit. Si l'IA peut apporter quelque chose, il faudra tester les différents modèles de type Image-to-Image pour déterminer lequel est le plus adapté pour modifier une image (faire vieillir une personne, changer une photo sur un document d'identité, etc.).

Pour les sites qui demandent une vérification par vidéo, il faut que le modèle soit capable de générer une vidéo réaliste d'une personne mais aussi d'une caméra filmant un document d'identité. Les modèles les plus utiles seront probablement ceux de type Image-to-Video et Video-to-Video. Il faudra également prendre en compte le fait qu'un interlocuteur humain peut être présent et penser à des méthodes pour le tromper, en jouant sur les temps de réponse par exemple.

Enfin, pour rediriger une vidéo générée vers une caméra virtuelle, la librairie Python `pyvirtualcam` semble être une bonne solution car elle est multiplateforme et utilise un langage de progammation populaire.

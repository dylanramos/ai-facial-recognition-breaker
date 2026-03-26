// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= État de l'art

== Sites de vérification d'identité

*Analyses détaillées* : #link("../rapports-de-recherche/sites-de-verification/sites-de-verification.pdf")[#underline("sites-de-verification.pdf")]

Les sites demandant une vérification d'identité sont plus ou moins sensibles, parmi ceux-ci, on peut trouver des réseaux sociaux, des sites de rencontres, des casinos en ligne ou encore des banques. Ils ne demandent pas tous les mêmes informations, certains se contentent d'une simple photo d'un document d'identité, tandis que d'autres demandent une vérification via une caméra en direct. Un autre facteur à prendre en compte est qu'il faut souvent vérifier une adresse e-mail et/ou un numéro de téléphone, ce qui peut constituer une barrière supplémentaire pour les attaquants.

=== Classement des sites par difficulté d'attaque

Pour classer les sites par difficulté d'attaque, les critères suivants ont été pris en compte :

- *Type* : vérification par photo ou vidéo.
- *Interlocuteur humain* : présence d'un interlocuteur humain pour guider l'utilisateur.
- *Documents d'identité* : nécessité de fournir des documents d'identité.
- *Uniquement via smartphone* : obligation d'utiliser un smartphone.
- *Vérification* : vérification de l'adresse e-mail ou du numéro de téléphone.


Ci-dessous, les sites sont classés par difficulté d'attaque, allant du plus facile au plus difficile :

#emph[Vérification par photo :]

1. Tea Dating Safety for Women
2. Google
3. Mycasino
4. Casino777
5. Facebook
6. Bybit
7. Bet365
8. Swissquote
9. UBS
10. Swissborg
11. OkCupid
12. Lotterie Romande

#emph[Vérification par vidéo :]

13. Migros Bank
14. Roblox
15. Parship
16. Portail Etat de Vaud
17. Swiss Casinos
18. Binance
19. Coinbase
20. Zak Cler
21. Kraken
22. Revolut
23. Neon Bank
24. Yuh
25. Okx

== Génération d'images et de vidéos IA

*Analyses détaillées* : #link("../rapports-de-recherche/generation-ia/generation-ia.pdf")[#underline("generation-ia.pdf")]

Pour qu'un attaquant puisse modifier la photo d'une personne sur un document d'identité ou générer une vidéo d'une personne effectuant une vérification d'identité, il doit utiliser des modèles de génération d'images et de vidéos IA.

Ainsi, la solution la plus simple pour utiliser ces différents modèles est de passer par un service d'API. Un service d'API est une plateforme qui regroupe les APIs des différents services de génération. Il met à disposition une API qui permet d'utiliser plusieurs modèles d'IA de manière centralisée et moins coûteuse que chez les fournisseurs directement. Le service d'API choisi est #link("https://kie.ai/")[#underline("Kie.ai")].

=== Modèles de génération d'images

Il y a deux catégories de modèles de génération d'images :

- *Text-to-Image :* qui sont des modèles créatifs qui créent des images à partir de rien et qui sont utiles pour générer des images de personnes fictives.
- *Image-to-Image :* qui sont des modèles d'édition d'images qui modifient une image fournie et qui sont utiles pour modifier une photo sur un document d'identité.

Généralement, les modèles de génération d'images proposent les deux types de modèles, le tableau ci-dessous concerne donc les deux types et présente les différents modèles avec leur prix moyen par image :

#table(
  columns: (1fr, 1fr),
  align: horizon + center,
  [*Modèle*], [*Prix*],

  [*Nano Banana 2*], [0.065\$],
  [*GPT Image 1.5*], [0.065\$],
  [*Seedream 4.5*], [0.0325\$],
  [*Grok Imagine*], [0.02\$],
  [*Flux 2*], [0.095\$],
)

Il n'y a pas forcément de modèles meilleurs que d'autres, ils ont chacun leurs caractéristiques et limitations. Il faudra donc les tester le moment venu pour déterminer lequel est le plus adapté aux attaques à réaliser.

=== Modèles de génération de vidéos

Il y a trois catégories de modèles de génération de vidéos :

- *Text-to-Video :* qui sont des modèles créatifs qui créent des vidéos à partir de rien et qui ne seront probablement pas utiles pour les attaques à réaliser.
- *Image-to-Video :* qui sont des modèles plus contrôlables visuellement car ils prennent deux images en entrée, une pour débuter la séquence et l'autre pour la terminer. Ainsi, ils permettent par exemple de faire correspondre le visage de la personne dans la vidéo avec celui sur les documents d'identité.
- *Video-to-Video :* qui sont des modèles d'édition de vidéos qui prennent une vidéo et une image de référence en entrée. Ils sont particulièrement utiles car ils permettent d'enregistrer une vidéo au préalable puis de remplacer la vraie personne par une autre personne.

Comme pour les modèles de génération d'images, les modèles de génération de vidéos proposent généralement les types Text-to-Video et Image-to-Video. Les modèles de type Video-to-Video eux, sont plus spécifiques et ont des modèles dédiés.

=== Critères de sélection des modèles de génération de vidéos (Text-to-Video et Image-to-Video)

Pour sélectionner les modèles de génération de vidéos à utiliser pour les attaques, les critères suivants ont été pris en compte :

+ *Temps de vidéo* : la vidéo générée doit être suffisament longue pour que la vérification de l'identité puisse se faire.
+ *Qualité de la vidéo* : la qualité de la vidéo doit être assez bonne pour tromper les systèmes de reconnaissance faciale.
+ *Audio* : la possibilité d'ajouter de l'audio est un plus.

=== Tableaux comparatifs des modèles de génération de vidéos (Text-to-Video et Image-to-Video)

Les tableaux ci-dessous comparent les prix de chaque modèle dans leur configuration minimale (moins bonne qualité, plus courte durée, etc.) et maximale (meilleure qualité, durée plus longue, etc.).

*Prix minimum*

#table(
  columns: (1fr, auto, auto, auto, auto),
  align: horizon + center,
  [*Modèle*], [*Temps de vidéo*], [*Qualité de la vidéo*], [*Audio*], [*Prix*],

  [*Veo 3.1*], [8s], [1080p], [Oui], [0.30\$],
  [*Sora 2*], [10s], [720p], [Oui], [0.175\$],
  [*Kling 3.0*], [3s], [720p], [Non], [0.10\$],
  [*Wan 2.6*], [5s], [720p], [Oui], [0.35\$],
  [*Grok Imagine*], [6s], [480p], [Oui], [0.05\$],
  [*Hailuo 2.3*], [6s], [768p], [Non], [0.15\$],
)

*Prix maximum*

#table(
  columns: (1fr, auto, auto, auto, auto),
  align: horizon + center,
  [*Modèle*], [*Temps de vidéo*], [*Qualité de la vidéo*], [*Audio*], [*Prix*],

  [*Veo 3.1*], [8s], [1080p], [Oui], [1.25\$],
  [*Sora 2*], [15s], [720p], [Oui], [0.20\$],
  [*Kling 3.0*], [15s], [1080p], [Oui], [3.00\$],
  [*Wan 2.6*], [15s], [1080p], [Oui], [1.575\$],
  [*Grok Imagine*], [15s], [720p], [Oui], [0.20\$],
  [*Hailuo 2.3*], [10s], [768p], [Non], [0.45\$],
)

=== Modèles de génération de vidéos de type Video-to-Video

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
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

- *Text-to-Image :* qui sont des modèles créatifs qui créent des images à partir de rien.
- *Image-to-Image :* qui sont des modèles d'édition d'images qui modifient une image fournie.
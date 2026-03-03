= Cahier des charges

#text(weight: "bold", size: 14pt)[Contexte]

Dans un monde de plus en plus numérisé, les technologies de reconnaissance faciale sont devenues omniprésentes. Du simple déverrouillage de smartphone à la surveillance de masse, ces systèmes sont utilisés dans une variété d'applications. C'est notamment le cas pour les services sensibles qui proposent un enregistement en ligne, comme les banques ou les services gouvernementaux qui utilisent la reconnaissance faciale pour vérifier l'identité des utilisateurs.

Avec l'essor de l'intelligence artificielle, il est désormais possible de générer des vidéos à la demande, ce qui ouvre la porte à de nouvelles formes d'attaques contre les systèmes de reconnaissance faciale. En particulier, les techniques de génération de visages synthétiques et de deepfakes permettent de reproduire de manière très réaliste l'apparence et les expressions d'une personne à partir de quelques images seulement @sumsub. Un attaquant pourrait ainsi créer une vidéo crédible d'un individu et tenter de tromper un système d'authentification biométrique basé sur le visage.

Ces nouvelles capacités soulèvent d'importants enjeux de sécurité. Les systèmes de vérification d'identité doivent désormais être capables de distinguer un visage réel capturé en direct d'un contenu généré artificiellement. La compréhension de ces vulnérabilités et le développement de mécanismes de défense robustes constituent aujourd'hui un enjeu majeur pour la sécurité des systèmes numériques.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Objectifs]

Ce travail de bachelor vise à analyser les risques associés à l'utilisation de la reconnaissance faciale dans les services en ligne face à la menace croissante des vidéos générées par l'IA. Les objectifs sont les suivants :

+ Analyser les différents services de generation de vidéos IA.
+ Analyser les sites nécessitant une vérification d'identité par reconnaissance faciale.
+ Étudier la faisabilité des attaques contre les sites proposant une vérification d'identité par reconnaissance faciale.
+ Développer un outil permettant de diffuser une vidéo générée par l'IA sur les sites ciblés.

En fonction des résultats obtenus et si le temps le permet :

- Automatiser tout le processus d'attaque pour ne nécessiter aucune intervention humaine.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Méthodologie]

*Phase 1 : recherches et analyses*

- Trouver et analyser des services de génération de vidéos IA.
- Trouver et analyser des sites nécessitant une vérification d'identité par reconnaissance faciale.

*Phase 2 : tests de faisabilité*

- Effectuer des tests manuels sur les sites qui ne demandent qu'une vérification d'identité par image dans un premier temps, puis sur les sites qui demandent une vérification d'identité par vidéo.
- Documenter les différents tests effectués et leurs résultats.

*Phase 3 : développement de l'outil*

- Tester le fonctionnement d'une caméra virtuelle et de la redirection d'un flux vidéo sur Linux.
- Développer une interface en ligne de commande permettant de générer des vidéos via une API de génération de vidéos IA, puis de rediriger le flux vidéo vers une caméra virtuelle.

*(Phase 4 : automatisation de l'attaque)*

- Modifier l'interface en ligne de commande pour automatiser tout le processus d'attaque (simuler les interactions utilisateur dans un navigateur).

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Planning]

Ce travail de bachelor débute le *16 février 2026* et se termine le *26 juin 2026*, ce qui fait un total de 19 semaines pour 450 heures de travail.

*Semaine 1-6 (16.02 - 29.03)*

- Recherches et analyses (Phase 1).
- Rédaction du rapport.
- #underline("Rendu du cahier des charges le 18.03.")
- _Semaine 4 réservée au CRUNCH._

*Semaine 7-12 (30.03 - 10.05)*

- Tests de faisabilité (Phase 2).
- Rédaction du rapport.
- #underline("Rendu intermédiaire le 02.04 à 16h00.")
- _Semaine 8 réservée au vacances de Pâques._

*Semaine 13-15 (11.05 - 31.05)*

- Développement de l'outil (Phase 3).
- Rédaction du rapport.

*Semaine 16-18 (01.06 - 21.06)*

- Automatisation de l'attaque (Phase 4).
- Rédaction du rapport.

*Semaine 19 (22.06 - 26.06)*

- Finalisation des rendus.
- Production de l'affiche de présentation du travail de bachelor.
- #underline("Rendu final le 26.06 à 15h00.")

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Livrables]

*Livrables intermédiaires*

- Cahier des charges.
- Rapport intermédiaire.
- Rapports de recherche :
  - Services de génération de vidéos IA.
  - Sites de vérification d'identité.
  - Tests de faisabilité des attaques.
  - Caméra virtuelle et redirection de flux vidéo.

*Livrables finaux*

- Rapport final.
- Dépôt GitHub contenant le code source de l'outil développé ainsi que la documentation.
- Affiche de présentation du travail de bachelor.

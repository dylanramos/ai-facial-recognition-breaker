= Cahier des charges

#text(weight: "bold", size: 14pt)[Contexte]

Dans un monde de plus en plus numérisé, les technologies de reconnaissance faciale sont devenues omniprésentes. Du simple déverrouillage de smartphone à la surveillance de masse, ces systèmes sont utilisés dans une variété d'applications. C'est notamment le cas pour les services sensibles qui proposent un enregistement en ligne, comme les banques ou les services gouvernementaux qui utilisent la reconnaissance faciale pour vérifier l'identité des utilisateurs.

Avec l'essor de l'intelligence artificielle, il est désormais possible de générer des vidéos à la demande, ce qui ouvre la porte à de nouvelles formes d'attaques contre les systèmes de reconnaissance faciale. En particulier, les techniques de génération de visages synthétiques et de deepfakes permettent de reproduire de manière très réaliste l'apparence et les expressions d'une personne à partir de quelques images seulement @sumsub. Un attaquant pourrait ainsi créer une vidéo crédible d'un individu et tenter de tromper un système d'authentification biométrique basé sur le visage.

Ces nouvelles capacités soulèvent d'importants enjeux de sécurité. Les systèmes de vérification d'identité doivent désormais être capables de distinguer un visage réel capturé en direct d'un contenu généré artificiellement. La compréhension de ces vulnérabilités et le développement de mécanismes de défense robustes constituent aujourd'hui un enjeu majeur pour la sécurité des systèmes numériques.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Objectifs]

Ce travail de bachelor vise à analyser les risques associés à l'utilisation de la reconnaissance faciale dans les services en ligne face à la menace croissante des vidéos générées par l'IA. Les objectifs sont les suivants :

+ Analyser des services de génération de vidéos IA afin de déterminer lesquels sont les plus adaptés pour générer des vidéos réalistes de personnes effectuant une vérification d'identité.
+ Analyser des sites proposant une vérification d'identité par reconnaissance faciale afin d'identifier les différentes méthodes de vérification utilisées.
+ Savoir comment utiliser une caméra virtuelle sur Linux afin de rediriger un flux vidéo vers une application.
+ Choisir des sites cibles et savoir s'il est possible d'attaquer leur système de vérification d'identité.
+ Développer un outil en ligne de commande permettant de générer une vidéo via une API et de la rediriger vers une caméra virtuelle afin de pouvoir attaquer les sites cibles.

En fonction des résultats obtenus et si le temps le permet :

- Automatiser tout le processus d'attaque pour ne nécessiter aucune intervention humaine.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Méthodologie]

*Phase 1 : recherches et analyses*

- Analyse des services de génération de vidéos IA.
- Analyse des sites proposant une vérification d'identité par reconnaissance faciale.
- Étude de l'utilisation d'une caméra virtuelle sur Linux.

*Phase 2 : tests de faisabilité*

- Séléction des sites avec une vérification d'indentité simple (photos).
- Séléction des sites avec une vérification d'indentité plus complexe (vidéos).
- Évaluation des résultats obtenus lors des attaques manuelles.

*Phase 3 : conception de l'outil en ligne de commande*

- Schématisation du fonctionnement de l'outil.
- Identification des fonctionnalités nécessaires.

*Phase 4 : développement de l'outil en ligne de commande*

- Implémentation des différentes fonctionnalités de l'outil.
- Mise en place d'un environnement de test reproductible.
- Documentation de la mise en place de l'outil.
- Documentation de l'utilisation de l'outil.

*(Phase 4 : automatisation de l'attaque)*

- Modifier l'outil pour automatiser tout le processus d'attaque (simuler les interactions utilisateur dans un navigateur).
- Modifier l'outil pour vérifier automatiquement les emails et les numéros de téléphone.

*Phase 5 : retour sur expérience*

- Documentation des succès et des échecs rencontrés lors des attaques.

*Phase 6 : publication du projet en open source*

- Création d'un dépôt GitHub dédié au projet.
- Documentation des pistes d'amélioration et des idées pour de futurs travaux.

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

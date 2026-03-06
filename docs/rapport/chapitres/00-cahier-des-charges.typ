= Cahier des charges

#text(weight: "bold", size: 14pt)[Contexte]

Dans un monde de plus en plus numérisé, les technologies de reconnaissance faciale sont devenues omniprésentes. Du simple déverrouillage de smartphone à la surveillance de masse, ces systèmes sont utilisés dans une variété d'applications. C'est notamment le cas pour les services sensibles qui proposent un enregistement en ligne, comme les banques ou les services gouvernementaux qui utilisent la reconnaissance faciale pour vérifier l'identité des utilisateurs.

Avec l'essor de l'intelligence artificielle, il est désormais possible de générer des vidéos à la demande, ce qui ouvre la porte à de nouvelles formes d'attaques contre les systèmes de reconnaissance faciale. En particulier, les techniques de génération de visages synthétiques et de deepfakes permettent de reproduire de manière très réaliste l'apparence et les expressions d'une personne à partir de quelques images seulement @sumsub. Un attaquant pourrait ainsi créer une vidéo crédible d'un individu et tenter de tromper un système d'authentification biométrique basé sur le visage.

Ces nouvelles capacités soulèvent d'importants enjeux de sécurité. Les systèmes de vérification d'identité doivent désormais être capables de distinguer un visage réel capturé en direct d'un contenu généré artificiellement. La compréhension de ces vulnérabilités et le développement de mécanismes de défense robustes constituent aujourd'hui un enjeu majeur pour la sécurité des systèmes numériques.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Objectifs]

Ce travail de bachelor vise à analyser les risques associés à l'utilisation de la reconnaissance faciale dans les services en ligne face à la menace croissante des vidéos générées par IA. Les objectifs sont les suivants :

+ Analyser des services de génération de vidéos IA afin de déterminer lesquels sont les plus adaptés pour générer des vidéos réalistes de personnes effectuant une vérification d'identité.
+ Analyser des sites proposant une vérification d'identité par reconnaissance faciale afin d'identifier les différentes méthodes de vérification utilisées.
+ Savoir comment utiliser une caméra virtuelle afin de rediriger un flux vidéo vers une application.
+ Choisir des sites cibles et savoir s'il est possible d'attaquer leur système de vérification d'identité avec des vidéos générées par IA.
+ Avoir un outil en ligne de commande permettant de générer des vidéos via une API et de les rediriger vers une caméra virtuelle afin de pouvoir attaquer les sites cibles.
+ Avoir un environnement de test reproductible afin que l'outil fonctionne sur tous les environnements.

En fonction des résultats obtenus et si le temps le permet :

- Automatiser tout le processus d'attaque pour ne nécessiter aucune intervention humaine.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Méthodologie]

*Phase 1 : recherches et analyses*

- Analyse des services de génération de vidéos IA.
- Analyse des sites proposant une vérification d'identité par reconnaissance faciale.
- Étude de l'utilisation d'une caméra virtuelle sur Linux et Windows.

*Phase 2 : tests de faisabilité*

- Séléction des sites avec une vérification d'identité simple (photos) et attaques manuelles.
- Séléction des sites avec une vérification d'identité plus complexe (vidéos) et attaques manuelles.
- Séléction des services de génération de vidéos IA les plus adaptés.
- Évaluation des résultats obtenus lors des attaques manuelles.

*Phase 3 : conception de l'outil en ligne de commande*

- Schématisation du fonctionnement de l'outil.
- Identification des fonctionnalités nécessaires.

*Phase 4 : développement de l'outil en ligne de commande*

- Implémentation des différentes fonctionnalités de l'outil.
- Mise en place d'un environnement de test reproductible (Docker).
- Documentation de la mise en place de l'outil.
- Documentation de l'utilisation de l'outil.

*Phase 5 : retour sur expérience*

- Documentation des succès et des échecs rencontrés lors des attaques.
- Documentation des pistes d'amélioration possibles.

*Phase 6 : publication du projet en open source*

- Création d'un dépôt GitHub dédié au projet.
- Mise en place des directives de contribution et de la documentation pour les futurs contributeurs.

*(Phase 7 : automatisation de l'attaque)*

- Modification de l'outil pour automatiser tout le processus d'attaque (simuler les interactions utilisateur dans un navigateur).
- Modification de l'outil pour vérifier automatiquement les emails et les numéros de téléphone.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Livrables]

*Livrables intermédiaires*

- Cahier des charges.
- Rapport intermédiaire.
- Rapports de recherche :
  - Génération de vidéos IA.
  - Sites de vérification d'identité.
  - Tests de faisabilité des attaques.
  - Caméra virtuelle et redirection de flux vidéo.

*Livrables finaux*

- Rapport final.
- Dépôt GitHub contenant le code source de l'outil développé ainsi que :
  - Le guide d'installation de l'outil.
  - Le guide d'utilisation de l'outil.
  - La documentation de maintenance.
  - Le script de mise en place de l'environnement de test.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Planning]

Ce travail de bachelor débute le *16 février 2026* et se termine le *26 juin 2026*, ce qui fait un total de 18 semaines pour 450 heures de travail.

*Semaine 1 (16.02 - 22.02)*

Phase 1 :
- Recherche et analyse des services de génération de vidéos IA.
- Recherche et analyse des sites proposant une vérification d'identité par reconnaissance faciale.
- Étude de l'utilisation d'une caméra virtuelle sur Linux.

*Semaine 2 (23.02 - 01.03)*

Phase 1 :
- Recherche et analyse des services de génération de vidéos IA.
- Recherche et analyse des sites proposant une vérification d'identité par reconnaissance faciale.
- Test d'une API de génération de vidéos gratuite.
- Rédaction du cahier des charges.

*Semaine 3 (02.03 - 08.03)*

Phase 1 :
- Étude de l'utilisation d'une caméra virtuelle sur Windows.
- Rédaction du cahier des charges.
- Rédaction du rapport de recherche sur les services de génération de vidéos IA.
- Rédaction du rapport de recherche sur les sites de vérification d'identité.
- Rédaction du rapport de recherche sur la caméra virtuelle et la redirection de flux vidéo.

*Semaine 4 (09.03 - 15.03)*

_Semaine réservée au CRUNCH._

*Semaine 5 (16.03 - 22.03)*

- #underline("Rendu du cahier des charges le 18.03.")

Phase 1 :
- Rendu du rapport de recherche sur les services de génération de vidéos IA.
- Rendu du rapport de recherche sur les sites de vérification d'identité.
- Rendu du rapport de recherche sur la caméra virtuelle et la redirection de flux vidéo.

*Semaine 6 (23.03 - 29.03)*

Phase 2 :
- Séléction des sites cibles
- Séléction des services de génération de vidéos.
- Tests manuels sur les sites cibles.

*Semaine 7 (30.03 - 05.04)*

- #underline("Rendu intermédiaire le 02.04 à 16h00.")

Phase 2 :
- Tests manuels sur les sites cibles.

*Semaine 8 (13.04 - 19.04)*

Phase 2 :
- Tests manuels sur les sites cibles.
- Rendu du rapport de recherche sur les tests de faisabilité des attaques.

*Semaine 9 (20.04 - 26.04)*

Phase 3 :
- Schématisation du fonctionnement de l'outil.
- Identification des fonctionnalités nécessaires.

Phase 4 :
- Implémentation de l'outil.

*Semaine 10 (27.04 - 03.05)*

Phase 4 :
- Implémentation de l'outil.

*Semaine 11 (04.05 - 10.05)*

Phase 4 :
- Implémentation de l'outil.
- Documentation de la mise en place de l'outil.
- Documentation de l'utilisation de l'outil.
- Mise en place de l'environnement docker.

*Semaine 12 (11.05 - 17.05)*

Phase 5 :
- Documentation des succès et des échecs rencontrés lors des attaques.
- Documentation des pistes d'amélioration possibles.

*Semaine 13 (18.05 - 24.05)*

Phase 5 :
- Documentation des succès et des échecs rencontrés lors des attaques.
- Documentation des pistes d'amélioration possibles.

*Semaine 14 (25.05 - 31.05)*

Phase 6 :
- Création d'un dépôt GitHub dédié au projet.
- Mise en place des directives de contribution et de la documentation pour les futurs contributeurs.

*Semaine 15 (01.06 - 07.06)*

Phase 7 :
- Simulation des interactions utilisateur dans le navigateur.
- Vérification automatique des emails et des numéros de téléphone.

*Semaine 16 (08.06 - 14.06)*

Phase 7 :
- Simulation des interactions utilisateur dans le navigateur.
- Vérification automatique des emails et des numéros de téléphone.

*Semaine 17 (15.06 - 21.06)*

Phase 7 :
- Simulation des interactions utilisateur dans le navigateur.
- Vérification automatique des emails et des numéros de téléphone.

*Semaine 18 (22.06 - 26.06)*

- Finalisation des livrables.
- #underline("Rendu final le 26.06 à 15h00.")


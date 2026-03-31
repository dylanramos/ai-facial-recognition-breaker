= Cahier des charges

#text(weight: "bold", size: 14pt)[Contexte]

Dans un monde de plus en plus numérisé, les technologies de reconnaissance faciale sont devenues omniprésentes. Du simple déverrouillage de smartphone à la surveillance de masse, ces systèmes sont utilisés dans une variété d'applications. C'est notamment le cas pour les services sensibles qui proposent un enregistrement en ligne, comme les banques ou les services gouvernementaux qui utilisent la reconnaissance faciale pour vérifier l'identité des utilisateurs @swisscom-video-identification.

Avec l'essor de l'intelligence artificielle, il est désormais possible de générer des vidéos à la demande, ce qui ouvre la porte à de nouvelles formes d'attaques contre les systèmes de reconnaissance faciale. En particulier, les techniques de génération de visages synthétiques et de deepfakes permettent de reproduire de manière très réaliste l'apparence et les expressions d'une personne à partir de quelques images seulement @sumsub. Un attaquant pourrait ainsi créer une vidéo crédible d'un individu et tenter de tromper un système d'authentification biométrique basé sur le visage @securing-pl.

Ces nouvelles capacités soulèvent d'importants enjeux de sécurité. Les systèmes de vérification d'identité doivent désormais être capables de distinguer un visage réel capturé en direct d'un contenu généré artificiellement. La compréhension de ces vulnérabilités et le développement de mécanismes de défense robustes constituent aujourd'hui un enjeu majeur pour la sécurité des systèmes numériques.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Objectifs]

Ce travail de Bachelor cherche à comprendre et à démontrer les risques associés à l'utilisation de la reconnaissance faciale dans les services en ligne face à la menace croissante des vidéos générées par IA. Les objectifs sont les suivants :

+ Connaître les offres de génération de vidéos IA disponibles sur le marché.
+ Connaître les différentes méthodes de vérification d'identité par reconnaissance faciale utilisées par les sites en ligne.
+ Savoir comment fonctionne et comment utiliser une caméra virtuelle sur Linux et Windows.
+ Avoir un démonstrateur capable de générer à la demande, une fausse pièce d'identité à partir d'une photo d'un individu.
+ Avoir un démonstrateur capable de générer à la demande, une vidéo d'un individu à partir de quelques photos de celui-ci.
+ Avoir un démonstrateur capable de rediriger un flux vidéo vers une caméra virtuelle.
+ Connaître les sites en ligne dont la vérification d'identité est vulnérable à des images ou des vidéos générées par IA.

En option :

- Avoir un démonstrateur complétement autonome capable d'enregistrer sur un site choisi, une personne donnée à l'aide de quelques photos de celle-ci.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Méthodologie]

*Phase 1 : recherches et analyses*

- Analyse des offres de génération de vidéos IA.
- Analyse des sites proposant une vérification d'identité par image.
- Analyse des sites proposant une vérification d'identité par vidéo.
- Analyse de l'utilisation d'une caméra virtuelle sur Linux et Windows.

*Phase 2 : conception*

- Rédaction des User Stories.
- Rédaction des cas de test.
- Schématisation de l'architecture du démonstrateur.
- Schématisation du diagramme de séquence du démonstrateur.
- Justification des choix techniques.

*Phase 3 : développement*

- Implémentation des fonctionnalités du démonstrateur.
- Mise en place d'un environnement de test reproductible.
- Documentation de la mise en place du démonstrateur.
- Documentation de l'utilisation du démonstrateur.

*Phase 4 : retour sur expérience*

- Remplissage des cas de test.
- Synthèse des succès et des échecs rencontrés lors des attaques.
- Documentation des pistes d'amélioration possibles.

*(Phase 5 : automatisation du démonstrateur)*

- Simulation des interactions utilisateur dans un navigateur.
- Vérification automatique des e-mails et des numéros de téléphone.

*Phase 6 : publication du projet sur GitHub*

- Création d'un dépôt GitHub dédié au projet et transfert de la propriété.

*(Phase 7 : publication du projet en open source)*

- Mise en place des directives de contribution et de la documentation pour les futurs contributeurs.


#v(0.5cm)

#text(weight: "bold", size: 14pt)[Livrables]

*Livrables intermédiaires*

- Cahier des charges.
- Rapport intermédiaire.
- Rapports de recherche :
  - Génération d'images et de vidéos IA.
  - Sites de vérification d'identité.
  - Caméras virtuelles et redirection de flux vidéo.
  - User Stories.

*Livrables finaux*

- Rapport final.
- Dépôt GitHub contenant le code source du démonstrateur ainsi que :
  - Le guide d'installation du démonstrateur.
  - Le guide d'utilisation du démonstrateur.
  - La documentation de maintenance.
  - La documentation de mise en place de l'environnement de test.
  - La synthèse des succès et des échecs rencontrés lors des attaques.
  - La documentation des pistes d'amélioration possibles.

#v(0.5cm)

#text(weight: "bold", size: 14pt)[Planning]

Ce travail de Bachelor débute le *16 février 2026* et se termine le *26 juin 2026*, ce qui fait un total de 18 semaines pour 450 heures de travail.

*Semaine 1 (16.02 - 22.02)*

Phase 1 :
- Recherche et analyse des offres de génération de vidéos IA.
- Recherche et analyse des sites proposant une vérification d'identité par reconnaissance faciale.
- Étude de l'utilisation d'une caméra virtuelle sur Linux.

*Semaine 2 (23.02 - 01.03)*

- Rédaction du cahier des charges.

Phase 1 :
- Recherche et analyse des offres de génération de vidéos IA.
- Recherche et analyse des sites proposant une vérification d'identité par reconnaissance faciale.
- Test d'une API de génération de vidéos gratuite.

*Semaine 3 (02.03 - 08.03)*

- Rédaction du cahier des charges.

Phase 1 :
- Étude de l'utilisation d'une caméra virtuelle sur Windows.
- Rédaction du rapport de recherche sur les offres de génération de vidéos IA.
- Rédaction du rapport de recherche sur les sites de vérification d'identité.
- Rédaction du rapport de recherche sur les caméras virtuelles et la redirection de flux vidéo.

*Semaine 4 (09.03 - 15.03)*

_Semaine réservée au CRUNCH._

*Semaine 5 (16.03 - 22.03)*

- #underline("Rendu du cahier des charges le 18.03.")
- Rédaction du cahier des charges.
- Rédaction du rapport.

Phase 1 :
- Rédaction du rapport de recherche sur les sites de vérification d'identité.
- Rédaction du rapport de recherche sur les caméras virtuelles et la redirection de flux vidéo.

Phase 2 :
- Rédaction des User Stories.
- Rédaction des cas de test.

*Semaine 6 (23.03 - 29.03)*

- Rédaction du rapport.

Phase 1 :
- Rédaction du rapport de recherche sur les sites de vérification d'identité.

Phase 2 :
- Rédaction des cas de test.

*Semaine 7 (30.03 - 05.04)*

- #underline("Rendu intermédiaire le 02.04 à 16h00.")
- Rédaction du rapport.

Phase 2 :
- Schématisation de l'architecture du démonstrateur.
- Schématisation du diagramme de séquence du démonstrateur.
- Justification des choix techniques.

*Semaine 8 (13.04 - 19.04)*

- Rédaction du rapport.

Phase 3 :
- Implémentation des fonctionnalités du démonstrateur.

*Semaine 9 (20.04 - 26.04)*

- Rédaction du rapport.

Phase 3 :
- Implémentation des fonctionnalités du démonstrateur.
- Mise en place d'un environnement de test reproductible.

*Semaine 10 (27.04 - 03.05)*

- #underline("Prise de contact avec une entreprise pour obtenir un accord de test.")
- Rédaction du rapport.

Phase 3 :
- Documentation de la mise en place du démonstrateur.
- Documentation de l'utilisation du démonstrateur.

Phase 4 :
- Remplissage des cas de test.
- Synthèse des succès et des échecs rencontrés lors des attaques.

*Semaine 11 (04.05 - 10.05)*

- Rédaction du rapport.

Phase 4 :
- Remplissage des cas de test.
- Synthèse des succès et des échecs rencontrés lors des attaques.

*Semaine 12 (11.05 - 17.05)*

- Rédaction du rapport.

Phase 4 :
- Remplissage des cas de test.
- Synthèse des succès et des échecs rencontrés lors des attaques.

*Semaine 13 (18.05 - 24.05)*

- Rédaction du rapport.

Phase 4 :
- Remplissage des cas de test.
- Synthèse des succès et des échecs rencontrés lors des attaques.
- Documentation des pistes d'amélioration possibles.

*Semaine 14 (25.05 - 31.05)*

- Rédaction du rapport.

(Phase 5) :
- Simulation des interactions utilisateur dans le navigateur.
- Vérification automatique des e-mails et des numéros de téléphone.

*Semaine 15 (01.06 - 07.06)*

- Rédaction du rapport.

(Phase 5) :
- Simulation des interactions utilisateur dans le navigateur.
- Vérification automatique des e-mails et des numéros de téléphone.

*Semaine 16 (08.06 - 14.06)*

- Rédaction du rapport.

Phase 6 :
- Création d'un dépôt GitHub dédié au projet et transfert de la propriété.

*Semaine 17 (15.06 - 21.06)*

- Rédaction du rapport.

(Phase 7) :
- Publication du projet en open source.
- Mise en place des directives de contribution et de la documentation pour les futurs contributeurs.

*Semaine 18 (22.06 - 26.06)*

- Finalisation des livrables.
- #underline("Rendu final le 26.06 à 15h00.")


= Conception

== User Stories

=== Vérification d'âge par photo

*Préambule :* une personne mineure possède un compte sur un site vulnérable sous contrôle parental et veut modifier sa date de naissance via les paramètres de son compte.

*Scénario 1 :* le site vulnérable demande à l'utilisateur de prendre un selfie pour estimer son âge. L'utilisateur rédige un prompt pour le moteur de génération d'images qui crée une image d'une personne majeure. L'utilisateur récupère l'image puis la soumet au formulaire de vérification d'âge.

=== Enregistrement en ligne par photo

*Préambule :* un attaquant a volé une photo d'un document d'identité d'une personne. Il suit le processus d'enregistrement en ligne d'un site vulnérable en renseignant les informations d'identité avec celles contenues sur le document d'identité volé.

*Scénario 1 :* le site vulnérable demande à l'attaquant de fournir une photo du document d'identité. L'attaquant rédige un prompt pour le moteur de génération d'images qui remplace la photo d'identité du document d'identité volé par une image d'une personne fictive. L'attaquant récupère l'image puis la soumet au formulaire d'enregistrement.

*Scénario 2 :* le site vulnérable demande à l'attaquant de fournir une photo du document d'identité ainsi qu'un selfie de la personne sur le document d'identité. L'attaquant rédige un prompt pour le moteur de génération d'images qui remplace la photo d'identité du document d'identité volé par une image d'une personne fictive, puis génère un selfie de cette même personne fictive. L'attaquant récupère les deux images puis les soumet au formulaire d'enregistrement.

=== Enregistrement en ligne par vidéo

*Préambule :* un attaquant a volé une photo d'un document d'identité d'une personne. Il suit le processus d'enregistrement en ligne d'un site vulnérable en renseignant les informations d'identité avec celles contenues sur le document d'identité volé.

*Scénario 1 :* le site vulnérable demande à l'attaquant de fournir une photo du document d'identité avec sa caméra. L'attaquant rédige un prompt pour le moteur de génération d'images qui remplace la photo d'identité du document d'identité volé par une image d'une personne fictive. L'attaquant rédige ensuite un prompt pour le moteur de génération de vidéos qui crée une vidéo du document précedement généré posé sur une surface neutre prêt à être pris en photo. L'attaquant récupère la vidéo, la diffuse sur sa caméra virtuelle puis clique sur le bouton de prise de photo.

*Scénario 2 :* le site vulnérable demande à l'attaquant de fournir une photo du document d'identité puis d'effectuer un selfie avec sa caméra. L'attaquant rédige un prompt pour le moteur de génération d'images qui remplace la photo d'identité du document d'identité volé par une image d'une personne fictive. L'attaquant récupère l'image puis la soumet au formulaire d'enregistrement. L'attaquant rédige ensuite un prompt pour le moteur de génération de vidéos qui crée une vidéo de cette personne fictive face à la caméra prête à effectuer un selfie. L'attaquant récupère la vidéo, la diffuse sur sa caméra virtuelle puis clique sur le bouton de prise de selfie.

*Scénario 3 :* le site vulnérable demande à l'attaquant de fournir une photo du document d'identité puis d'effectuer une vérification vidéo en direct. L'attaquant rédige un prompt pour le moteur de génération d'images qui remplace la photo d'identité du document d'identité volé par une image d'une personne fictive. L'attaquant récupère l'image puis la soumet au formulaire d'enregistrement. L'attaquant rédige ensuite un prompt pour le moteur de génération de vidéos qui crée une vidéo de cette personne fictive effectuant les mouvements demandés par le site vulnérable. L'attaquant récupère la vidéo puis la diffuse sur sa caméra virtuelle pour la soumettre au formulaire d'enregistrement.
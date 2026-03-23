= Conception

== User Stories <user_stories>

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

== Fonctionnalités du démonstrateur

En se basant sur les scénarios décrits dans la @user_stories, les fonctionnalités du démonstrateur sont les suivantes :

- Génération d'images à partir de prompts textuels (génération de personnes fictives).
- Modification d'images à partir de prompts textuels et d'images (modification de documents d'identité avec des visages fictifs).
- Génération de vidéos à partir de prompts textuels et d'images (génération de vidéos de personnes fictives).
- Diffusion de vidéos sur une caméra virtuelle.

== Architecture

La @architecture ci-dessous présente l'architecture du démonstrateur. Le démonstrateur est un CLI qui communique avec l'API de Kie.ai pour générer des images et des vidéos à partir de commandes entrées par l'utilisateur. Une fois les images et les vidéos générées, le démonstrateur les récupère puis offre la possibilité à l'utilisateur de diffuser les vidéos sur une caméra virtuelle de l'OS.

#figure(
    rect(image("../images/03-conception/architecture.png"), stroke: 0.1pt),
    caption: "Architecture du démonstrateur."
) <architecture>
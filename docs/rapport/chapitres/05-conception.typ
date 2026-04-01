= Conception

== User Stories <user_stories>

*Analyses détaillées* : #link("../rapports-de-recherche/user-stories/user-stories.pdf")[#underline("user-stories.pdf")]

Plusieurs scénarios d'attaque ont été définis, parmis ceux-ci, le scénario typique est un mélange de vérification par photo (ex : document d'identité) et de vérification par vidéo (ex : selfie vidéo) sans interlocuteur humain. Un autre scénario également intéressant est celui du démonstrateur automatisé, qui démontre comment fonctionnerait le démonstrateur sans intervention humaine.

=== Scénario typique

Un attaquant veut se créer un compte sur un site vulnérable. Il récupère un exemple de carte d'identité sur internet, puis suit le processus d'enregistrement en ligne du site vulnérable en renseignant des informations fictives.

#figure(
  rect(image("../images/05-conception/verification-photo-1.png"), stroke: 0.1pt),
  caption: "L'attaquant demande au démonstrateur de modifier une photo d'une carte d'identité trouvée sur internet.",
)

Une fois le document d'identité envoyé, le site vulnérable demande à scanner le visage de la personne via une vérification par vidéo.

#figure(
  rect(image("../images/05-conception/verification-video-2.png"), stroke: 0.1pt),
  caption: "L'attaquant demande au démonstrateur de générer une vidéo de la personne sur le document d'identité simulant la caméra en train de filmer son visage.",
)

=== Scénario avec démonstrateur automatisé

Le démonstrateur dispose d'un exemple de document d'identité. L'attaquant configure une personne fictive sur le démonstrateur (nom, prénom, date de naissance, etc.), se rend sur un site vulnérable pour se créer un compte puis lance le démonstrateur en mode automatique.

#figure(
  rect(image("../images/05-conception/verification-auto-2.png"), stroke: 0.1pt),
  caption: "Le démonstrateur renseigne les informations demandées en fonction de la configuration de l'attaquant, génère le document demandé puis la vidéo en fontion des instructions affichées sur la page web.",
)

== Architecture

La #underline()[@architecture] ci-dessous présente l'architecture du démonstrateur. Le démonstrateur est un CLI qui communique avec l'API de Kie.ai pour générer des images et des vidéos à partir de commandes entrées par l'utilisateur. Une fois les images et les vidéos générées, le démonstrateur les récupère puis offre la possibilité à l'utilisateur de diffuser les vidéos sur une caméra virtuelle de l'OS.

#figure(
  rect(image("../images/05-conception/architecture.png"), stroke: 0.1pt),
  caption: "Architecture du démonstrateur.",
) <architecture>

#import "@preview/codelst:2.0.2": sourcecode

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Attaques non réussies

== Introduction

Ce chapitre présente les attaques effectuées sur les sites dont la vérification d'identité n'a pas pu être contournée. Il commence par expliquer la marche à suivre pour tenter de contourner la vérification d'identité sur les sites Facebook, Parship et Google, puis présente les différents tests effectués en suivant à chaque fois la même marche à suivre.

== Facebook <08-facebook>

Lors de la création d'un compte, Facebook demande systématiquement de prendre un selfie vidéo en tournant la tête dans cinq directions, avec à chaque fois trois possibilités (gauche, droite ou haut), ce qui fait un total de 243 combinaisons possibles.

#figure(
  rect(image("../../images/05-conception/facebook-example.png", width: 70%), stroke: 0.1pt),
  caption: "Exemple de selfie vidéo demandé par Facebook.",
)

Les directions étant aléatoires, il est impossible de savoir à l'avance quelles directions seront demandées, ce qui nous oblige à lancer la vérification une première fois pour connaître les directions demandées. Une fois les directions connues, la solution la plus simple est de se filmer en train de faire les mouvements, puis de remplacer sa personne par une personne générée à l'aide de l'IA. En effet, générer une vidéo de ce type uniquement à partir d'un prompt est très difficile car il y a tout un timing à respecter pour que les mouvements soient synchronisés avec les instructions.

Comme vu dans le #underline[@03-generation-selfie], le meilleur modèle pour éditer une vidéo est Kling Motion Control 3.0, c'est donc avec celui-ci que nous allons générer la vidéo. Pour cela, il faut tout d'abord se prendre en photo, puis remplacer son visage par une personne générée.

#sourcecode[```sh
aifrb generate-image "A headshot portrait of a young man in his early 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography." -m "GPT Image 2"
```]

#figure(
  rect(image("../../images/08-attaques-non-reussies/facebook-1.png", width: 40%), stroke: 0.1pt),
  caption: "Personne générée par l'IA pour tenter de contourner la vérification d'identité sur le site Facebook.",
)

#sourcecode[```sh
aifrb edit-image "Replace the man on the first image by the man on the second image." downloads/myface.jpg -m "GPT Image 2" -a "auto" -i downloads/new-face.png
```]

#figure(
  rect(image("../../images/08-attaques-non-reussies/facebook-2.png", width: 60%), stroke: 0.1pt),
  caption: "Résultat de l'édition de l'image de référence pour tenter de contourner la vérification d'identité sur le site Facebook.",
)

Il faut ensuite se filmer en train de faire les mouvements, puis remplacer son visage par la personne générée.

#sourcecode[```sh
aifrb edit-video "No distortion, the character's movements are consistent with the video." downloads/video.mp4 downloads/new-face.png
```]

Résultat : #link("../videos/08-attaques-non-reussies/facebook-edit.mp4")[#underline("videos/08-attaques-non-reussies/facebook-edit.mp4")]

Pour des questions de vie privée, l'image et la vidéo de référence de ma personne n'est pas publiée sur GitHub et n'est donc pas disponible dans ce rapport.
Une fois la vidéo générée, il suffit de créer une caméra virtuelle et d'y diffuser la vidéo.

#sourcecode[```sh
aifrb create-camera "Facebook Attack" 0
```]

#sourcecode[```sh
aifrb broadcast downloads/new-video.mp4 /dev/video0
```]

Résultat : #link("../videos/08-attaques-non-reussies/facebook-result.mp4")[#underline("videos/08-attaques-non-reussies/facebook-result.mp4")]

Enfin, après environ une heure d'attente, un e-mail a été envoyé par Facebook informant que la vérification d'identité a échoué et que le compte a été désactivé. Cette méthode ne permet donc pas de contourner la vérification d'identité.

#figure(
  rect(image("../../images/08-attaques-non-reussies/facebook-3.png", width: 40%), stroke: 0.1pt),
  caption: "Échec de la vérification d'identité sur le site Facebook.",
)

== Parship <08-parship>

Comme pour Facebook, Parship demande de prendre un selfie vidéo lors de la création d'un compte. Cependant, aucun mouvement n'est demandé, il faut simplement centrer son visage dans un oval puis se rapprocher de la caméra. Ainsi, il n'y a pas besoin de se filmer préalablement, nous pouvons directement demander à l'IA de générer une vidéo d'une personne en train de se filmer. Pour cela, il faut commencer par générer l'image d'une personne.

#sourcecode[```sh
aifrb generate-image "A headshot portrait of a young woman in her early 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography." -a "auto"
```]

#figure(
  rect(image("../../images/08-attaques-non-reussies/parship-1.png", width: 40%), stroke: 0.1pt),
  caption: "Personne générée par l'IA pour tenter de contourner la vérification d'identité sur le site Parship.",
)

Une fois l'image générée, nous pouvons générer la vidéo de la personne en train de se filmer.

#sourcecode[```sh
aifrb generate-video "The woman in the image looks into the camera for a while, her body is not moving. Then the camera slowly zooms to her face and the woman continues to look at the camera. Then the camera zoom more and the woman is still looking at the camera. Then the camera slowly goes back." -m "Kling 3.0" -d 15 -s downloads/face.jpeg
```]

Résultat : #link("../videos/08-attaques-non-reussies/parship-edit.mp4")[#underline("videos/08-attaques-non-reussies/parship-edit.mp4")]

Il suffit maintenant de créer une caméra virtuelle et d'y diffuser la vidéo.

#sourcecode[```sh
aifrb create-camera "Parship Attack" 0
```]

#sourcecode[```sh
aifrb broadcast downloads/video.mp4 /dev/video0
```]

Résultat : #link("../videos/08-attaques-non-reussies/parship-result.mp4")[#underline("videos/08-attaques-non-reussies/parship-result.mp4")]

La vidéo ci-dessus nous montre que la vérification d'identité a échoué, mais contrairement à Facebook, Parship nous dit pourquoi la vérification a échoué.

#figure(
  rect(image("../../images/08-attaques-non-reussies/parship-2.png", width: 75%), stroke: 0.1pt),
  caption: "Échec de la vérification d'identité sur le site Parship en utilisant une caméra virtuelle.",
)

En effet, il semble que le système de vérification de Parship analyse également le type de caméra qui est utilisé.

== Google

Lorsqu'un utilisateur mineur souhaite modifier son âge sur son compte Google, celui-ci doit effectuer un selfie vidéo.

#figure(
  rect(image("../../images/08-attaques-non-reussies/google-1.png", width: 50%), stroke: 0.1pt),
  caption: "Demande de selfie vidéo pour modifier l'âge sur un compte Google.",
)

Comme le montre la #underline[@08-google] ci-dessous la vérification doit se faire via un smartphone, il faut donc passer par un émulateur Android de la même manière que pour Roblox au #underline[@07-roblox].

#figure(
  rect(image("../../images/08-attaques-non-reussies/google-2.png", width: 50%), stroke: 0.1pt),
  caption: "Demande d'effectuer la vérification via un smartphone pour modifier l'âge sur un compte Google.",
)<08-google>

En copiant le lien sur le navigateur de l'émulateur, nous pouvons accéder à la page de vérification d'identité. Cependant, une erreur survient lorsque nous essayons de lancer la vérification, comme le montre la vidéo ci-dessous.

Résultat : #link("../videos/08-attaques-non-reussies/google-result.mp4")[#underline("videos/08-attaques-non-reussies/google-result.mp4")]

== Tests effectués pour les selfies vidéo

Comme l'ont montré le #underline[@08-facebook] et le #underline[@08-parship], le contournement de la vérification d'identité par selfie vidéo ne fonctionne pas avec une vidéo IA simple diffusée sur une caméra virtuelle. Ainsi, plusieurs tests ont été effectués pour tenter de comprendre ces systèmes de vérification et trouver une méthode pour les contourner, mais aucun n'a abouti à un contournement réussi.

=== Comparaison des caméras

Une caméra virtuelle et une caméra réelle ont été comparées à l'aide du site #underline[#link("https://webcamtests.com/")]. Cependant, aucune différence notable n'a été identifiée entre les caractéristiques (mégapixels, résolution, etc.) d'une caméra virtuelle et d'une caméra réelle.

Des informations détaillées sur ce test sont disponibles dans le chapitre 2.1 du rapport détaillé #link("../rapports-detailles/tests-effectues.pdf")[#underline("tests-effectues.pdf")].

=== Analyse des métadonnées des vidéos

Les modèles d'IA chinois sont soumis à une réglementation qui les oblige à indiquer dans les métadonnées que le contenu a été généré par une IA @covington. Malgré cette réglementation, le modèle chinois Kling 3.0 s'avère ne pas respecter cette obligation car aucune indication n'est présente dans les métadonnées des vidéos générées avec ce modèle. Cependant, que les métadonnées indiquent que le contenu a été généré par une IA ou non, cela n'affecte pas le système de vérification d'identité car la vidéo est capturée en temps réel par le navigateur.

Des informations détaillées sur ce test sont disponibles dans le chapitre 2.2 du rapport détaillé #link("../rapports-detailles/tests-effectues.pdf")[#underline("tests-effectues.pdf")].

=== Ajout de bruit dans les vidéos

Une vidéo ou une image générée par IA ne contient pas d'imperfections ou de bruit dus aux capteurs, contrairement à une vidéo ou une image capturée par une caméra réelle. Ainsi, un filtre FFmpeg a été appliqué aux selfies vidéo générés pour ajouter du bruit afin de rendre les vidéos plus réalistes @ffmpeg-noise. Cependant, cela n'a pas changé le résultat de la vérification.

Des informations détaillées sur ce test sont disponibles dans le chapitre 2.3 du rapport détaillé #link("../rapports-detailles/tests-effectues.pdf")[#underline("tests-effectues.pdf")].

=== Utilisation d'un modèle en 3D

Certains articles sur internet mentionnent qu'il serait possible contourner le selfie vidéo de vérification de Facebook en utilisant le modèle 3D d'une personne généré par une IA @procpa.

#figure(
  rect(image("../../images/08-attaques-non-reussies/3d.png", width: 40%), stroke: 0.1pt),
  caption: [Modèle 3D généré par l'IA.],
)

Cependant, après avoir généré le modèle 3D puis effectué la vérification d'identité, le résultat est le même que pour une vidéo générée par IA classique, Facebook a désactivé le compte.

Des informations détaillées sur ce test sont disponibles dans le chapitre 2.4 du rapport détaillé #link("../rapports-detailles/tests-effectues.pdf")[#underline("tests-effectues.pdf")].

=== Utilisation d'un échangeur de visage en temps réel

Il existe un projet appelé Deep-Live-Cam permettant de remplacer son visage par celui d'une autre personne en temps réel @deep-live-cam. L'outil est un programme Python qui tourne en local et qui fonctionne avec des modèles d'IA pré-entrainés comme `inswapper` et `GFPGAN` @hugging-face. Cependant, l'outil nécessite une configuration matérielle très puissante et n'est donc pas accessible à tous.

#figure(
  rect(image("../../images/08-attaques-non-reussies/deeplivecam.png"), stroke: 0.1pt),
  caption: "Système recommandé pour le bon fonctionnement de Deep-Live-Cam.",
)

// TODO

Des informations détaillées sur ce test sont disponibles dans le chapitre 2.5 du rapport détaillé #link("../rapports-detailles/tests-effectues.pdf")[#underline("tests-effectues.pdf")].

=== Modification du module `v4l2loopback`

Contrairement à Facebook, Parship explique pourquoi la vérification d'identité échoue, en l'occurrence il semblerait que les systèmes de vérification ne se contentent pas juste d'analyser les vidéos, ils analysent également le type de caméra utilisée.

#figure(
  rect(image("../../images/08-attaques-non-reussies/parship-2.png", width: 80%), stroke: 0.1pt),
  caption: "Échec de la vérification d'identité en utilisant une caméra virtuelle.",
)

Ce test consistait donc à modifier le module `v4l2loopback` pour qu'il ne divulgue pas qu'il s'agit d'une caméra virtuelle, notamment en modifiant les informations affichées par des `snprintf` dans le code source du module.

#figure(
  rect(image("../../images/08-attaques-non-reussies/v4l2loopback.png"), stroke: 0.1pt),
  caption: "Modification du module v4l2loopback.",
)

Cependant, même en modifiant le module, la vérification échoue et Parship détecte toujours que la vidéo est diffusée sur une caméra virtuelle.

Des informations détaillées sur ce test sont disponibles dans le chapitre 2.6 du rapport détaillé #link("../rapports-detailles/tests-effectues.pdf")[#underline("tests-effectues.pdf")].

== Tests effectués pour la falsification de documents d'identité

Pour analyser la résistance des systèmes de vérification d'identité à la falsification de documents d'identité, des tests ont été effectués sur le site Roblox, qui propose une seconde méthode pour permettre à l'utilisateur de vérifier son âge.

À l'aide du CLI développé pour ce projet, un exemple de carte d'identité suisse a été modifié pour tenter de faire croire au système que le document d'identité est authentique.

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../../images/08-attaques-non-reussies/id-front.jpg"), stroke: 0.1pt),
    caption: "Exemple de carte d'identité suisse (recto).",
  ),
  figure(
    rect(image("../../images/08-attaques-non-reussies/id-front-fake.jpeg"), stroke: 0.1pt),
    caption: "Carte d'identité suisse modifiée à l'aide de l'IA (recto).",
  ),
)

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../../images/08-attaques-non-reussies/id-back.jpg"), stroke: 0.1pt),
    caption: "Exemple de carte d'identité suisse (verso).",
  ),
  figure(
    rect(image("../../images/08-attaques-non-reussies/id-back-fake.jpeg"), stroke: 0.1pt),
    caption: "Carte d'identité suisse modifiée à l'aide de l'IA (verso).",
  ),
)

Malheureusement, le système de vérification d'âge de Roblox a détecté que les documents d'identité étaient falsifiés et la vérification a échoué.

Des informations détaillées sur ce test sont disponibles dans le chapitre 3 du rapport détaillé #link("../rapports-detailles/tests-effectues.pdf")[#underline("tests-effectues.pdf")].
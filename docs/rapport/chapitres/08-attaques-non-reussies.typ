#import "@preview/codelst:2.0.2": sourcecode

= Attaques non réussies

== Introduction

Ce chapitre présente les attaques effectuées sur les sites dont la vérification d'identité n'a pas pu être contournée et émet des hypothèses sur les raisons pour lesquelles le contournement de celle-ci n'a pas été possible.

== Facebook

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

== Parship

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

== Tests effectués pour les selfies vidéo

== Tests effectués pour la falsification de documents d'identité

== Hypothèses

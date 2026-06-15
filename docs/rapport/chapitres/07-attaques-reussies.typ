#import "@preview/codelst:2.0.2": sourcecode

= Attaques réussies

== Tea for Women

=== Qu'est-ce que c'est ?

Tea for Women est une plateforme de sécurité dédiée aux rencontres conçue pour protéger les femmes dans le monde des rencontres modernes. Elle permet aux utilisatrices d'effectuer des recherches d'antécédents crowdsourcées, de vérifier les numéros de téléphone pour détecter les mariages cachés et de consulter des avis anonymes sur des hommes spécifiques @tea. L'objectif de la plateforme est de répondre à la question « Sortons-nous avec le même garçon ? » avant même le premier rendez-vous.

=== Attaque

En allant sur le site #underline(link("https://www.teaforwomen.com")) et en cliquant sur "Sign up" puis "Create your Tea account" nous arrivons sur la page ci-dessous.

#figure(
  rect(image("../../images/07-attaques-reussies/tea-1.png"), stroke: 0.1pt),
  caption: "Page d'inscription du site Tea for Women.",
)

Nous pouvons voir que toutes les informations demandées sur cette page peuvent être faussées et qu'aucune vérification d'email ou de numéro de téléphone n'est demandée. Une fois le formulaire rempli et soumis, nous arrivons sur la page de vérification d'identité et nous constatons que l'option recommandée est la plus simple à attaquer.

#figure(
  rect(image("../../images/07-attaques-reussies/tea-2.png"), stroke: 0.1pt),
  caption: "Page de choix de la vérification d'identité du site Tea for Women.",
)

Une fois la vérification démarrée, nous pouvons voir que le site nous demande de montrer notre visage de face, puis de tourner la tête dans des directions aléatoires.

#figure(
  rect(image("../../images/07-attaques-reussies/tea-3.png"), stroke: 0.1pt),
  caption: "Page de vérification d'identité du site Tea for Women.",
)

Les directions demandées sont aléatoires, mais le système autorise l'utilisateur à se tromper. Ainsi, il est possible de se préenregistrer en tournant la tête dans toutes les directions possibles, puis de remplacer sa personne par une personne générée.

Pour cela, nous commençons par générer l'image d'une femme face caméra qui remplacera notre visage sur la vidéo.

#sourcecode[```sh
    aifrb generate-image "A headshot portrait of a young woman in her early 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography." -a "auto"
```]

#figure(
  rect(image("../../images/07-attaques-reussies/tea-4.jpeg", width: 40%), stroke: 0.1pt),
  caption: "Image générée pour remplacer le visage de l'attaquant sur le site Tea for Women.",
)

Une fois l'image générée, nous pouvons nous filmer en train de tourner la tête dans toutes les directions, puis remplacer notre visage par l'image générée. Pour des questions de vie privée, la vidéo de référence de ma personne n'est pas publiée sur GitHub et n'est donc pas disponible dans ce rapport.

#sourcecode[```sh
    aifrb edit-video "Replace the person on the video by the person on the image." downloads/video.mp4 downloads/new-face.jpeg -m "HappyHorse 1.0"
```]

Résultat : #link("../videos/07-attaques-reussies/tea-edit.mp4")[#underline[videos/07-attaques-reussies/tea-edit.mp4]]

Nous pouvons maintenant diffuser la vidéo sur une caméra virtuelle puis activer la caméra sur le navigateur.

#sourcecode[```sh
    aifrb create-camera "Tea Attack" 0
```]

#sourcecode[```sh
    aifrb broadcast downloads/tea-edit.mp4 /dev/video0
```]

Résultat : #link("../videos/07-attaques-reussies/tea-result.mp4")[#underline[videos/07-attaques-reussies/tea-result.mp4]]

La vérification d'identité par selfie vidéo est *contournée avec succès*.

=== L'utilisation de l'IA est-elle vraiment nécessaire ?

Le chapitre précédent a montré qu'il est possible de contourner la vérification d'identité sur le site Tea for Women avec une vidéo générée par l'IA, mais l'utilisation de l'IA est-elle vraiment nécessaire pour réussir cette attaque ? Pour le savoir, nous pouvons essayer d'effectuer une "Presentation Attack".

Une Presentation Attack consiste à tenter de tromper un système de vérification d'identité en présentant à la caméra un élément autre qu'une personne réelle et vivante @presentation-attack. Parmis les éléments couramment utilisés pour ce type d'attaque, on trouve des photos de personnes imprimées, des masques en silicone portés par les attaquants ou encore des vidéos préenregistrées placées directement devant la caméra.

Pour répondre à cette question, nous pouvons donc commencer par l'attaque la plus simple, à savoir présenter une photo imprimée d'une personne à la caméra.

#figure(
  rect(image("../../images/07-attaques-reussies/printed.jpg", width: 60%), stroke: 0.1pt),
  caption: "Photo imprimée utilisée pour tenter de contourner la vérification d'identité du site Tea for Women.",
)

Résultat : #link("../videos/07-attaques-reussies/tea-printed.mp4")[#underline[videos/07-attaques-reussies/tea-printed.mp4]]

Comme le montre la vidéo ci-dessus, montrer un simple visage sur une feuille de papier ne suffit pas, nous pouvons donc tenter une autre approche, présenter une vidéo préenregistrée directement devant la caméra.

Résultat : #link("../videos/07-attaques-reussies/tea-phone.mp4")[#underline[videos/07-attaques-reussies/tea-phone.mp4]]

Effectivement, cette approche fonctionne. Pour des raisons de simplicité, la vidéo utilisée pour cette attaque est la même que celle utilisée au chapitre précédent, soit la vidéo générée par IA. Mais cette approche a démontré que l'utilisation de l'IA n'est pas nécessaire, en effet, un attaquant pourrait très bien trouver une vidéo sur internet d'une personne effectuant ces mouvements ou bien simplement se filmer en utilisant un masque en silicone.

=== Le fournisseur de la solution de vérification d'identité est-il vraiment sûr ?

Lors de la vérification d'identité, nous pouvons voir que la solution de vérification d'identité utilisée par le site Tea for Women est #link("https://regulaforensics.com/")[#underline[Regula]]. Regula est un fournisseur mondial de solutions de vérification d'identité et de dispositifs forensiques avec plus de 30 ans d'expérience et des clients majeurs tels que UBS, IATA ou encore Uber @regula. Pour utiliser leurs solutions, un SDK est mis à disposition des développeurs afin de les intégrer dans leurs applications.

En allant sur leur #link("https://faceapi.regulaforensics.com/")[#underline[page de test]], nous pouvons tenter de reproduire l'attaque effectuée précédemment pour vérifier si le même résultat est obtenu.

Résultat : #link("../videos/07-attaques-reussies/regula.mp4")[#underline[videos/07-attaques-reussies/regula.mp4]]

La vidéo ci-dessus nous montre que le résultat est bien différent, l'attaque ne fonctionne plus. Nous pouvons donc en déduire que le site Tea for Women n'a probablement pas mis à jour son SDK et que le contournement de la solution de Regula est bien plus complexe. En effet, la #underline[@regula-release-notes] ci-dessous nous montre que certaines versions du #link("https://docs.regulaforensics.com/develop/face-sdk/release-notes/")[#underline[Face SDK de Regula]] ne sont plus maintenues.

#figure(
  rect(image("../../images/07-attaques-reussies/regula.png", width: 60%), stroke: 0.1pt),
  caption: "Release notes du Face SDK de Regula.",
)<regula-release-notes>

== Roblox

=== Qu'est-ce que c'est ?

Roblox est une plateforme de jeu en ligne et un système de création qui permet aux utilisateurs de programmer, jouer et partager des expériences en 3D générées par la communauté @roblox. La plateforme est très populaire auprès des enfants et des adolescents et applique des contrôles parentaux stricts pour les joueurs de moins de 13 ans.

=== Attaque

En allant sur le site #underline(link("https://www.roblox.com")) nous arrivons sur la page ci-dessous.

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-1.png"), stroke: 0.1pt),
  caption: "Page d'inscription du site Roblox.",
)

Nous pouvons voir que toutes les informations demandées sur cette page peuvent être faussées et qu'aucune vérification d'email ou de numéro de téléphone n'est demandée. Un enfant peut donc facilement créer un compte avec un faux âge sans l'intervention d'un adulte.

Une fois le formulaire rempli et soumis, nous pouvons aller dans "Paramètres", puis "Infos sur le compte" pour accéder à la page permettant de confirmer son âge.

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-2.png", width: 70%), stroke: 0.1pt),
  caption: "Page permettant de confirmer son âge sur le site Roblox.",
)

En cliquant sur "Continuer avec la caméra" puis "Continuer", le site nous demande de scanner un code QR pour commencer la vérification d'âge sur notre téléphone.

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-3.png", width: 30%), stroke: 0.1pt),
  caption: "Code QR pour commencer la vérification d'âge sur le site Roblox.",
)

Étant donné qu'un téléphone est nécessaire, nous allons utiliser un émulateur Android, Genymotion dans cet exemple. Mais au lieu de scanner le code QR, nous copions le lien juste en dessous et accédons à ce lien depuis le navigateur de l'émulateur. Une marche à suivre détaillée pour installer et configurer Genymotion est disponible dans le chapitre 5 du rapport détaillé #link("../rapports-detailles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")].

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-4.png", width: 37%), stroke: 0.1pt),
  caption: "Page de vérification d'âge sur l'émulateur Android.",
)<roblox-4>

Les actions demandées pour cette vérification d'âge sont simples : montrer son visage de face, tourner la tête à gauche, puis à droite. Ainsi, pour tromper cette vérification, il suffit de diffuser une image statique sur la caméra virtuelle à chaque mouvement demandé.

Pour cela, nous pouvons nous prendre en photo de face, puis de profil gauche, puis de profil droit et demander à l'IA de remplacer notre visage par celui d'une personne générée.

#sourcecode[```sh
    aifrb generate-image "A headshot portrait of a young man in his early 20s, calm and neutral facial expression, looking directly forward at the viewer, sharp focus on the face, passport-style portrait photography." -a "auto"
```]

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-5.jpeg", width: 40%), stroke: 0.1pt),
  caption: "Image générée pour remplacer le visage de l'attaquant sur le site Roblox.",
)

#sourcecode[```sh
    aifrb edit-image "Replace the man on the first image by the man on the second image." downloads/face.jpg -a "auto" -i downloads/new-face.jpg
```]

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-6.jpg", width: 70%), stroke: 0.1pt),
  caption: "Image de face modifiée avec l'IA pour remplacer le visage de l'attaquant sur le site Roblox.",
)

#sourcecode[```sh
    aifrb edit-image "Replace the man on the first image by the man on the second image." downloads/left.jpg -a "auto" -i downloads/new-face.jpg
```]

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-7.jpg", width: 70%), stroke: 0.1pt),
  caption: "Image de profil gauche modifiée avec l'IA pour remplacer le visage de l'attaquant sur le site Roblox.",
)

#sourcecode[```sh
    aifrb edit-image "Replace the man on the first image by the man on the second image." downloads/right.jpg -a "auto" -i downloads/new-face.jpg
```]

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-8.jpg", width: 70%), stroke: 0.1pt),
  caption: "Image de profil droit modifiée avec l'IA pour remplacer le visage de l'attaquant sur le site Roblox.",
)

Nous pouvons ensuite créer la caméra virtuelle et y diffuser la première image de la personne de face.

#sourcecode[```sh
    aifrb create-camera "Roblox Attack" 0
```]

#sourcecode[```sh
    aifrb broadcast downloads/face.jpg /dev/video0 --portrait
```]

Puis configurer la caméra de l'émulateur pour qu'elle utilise la caméra virtuelle de la machine hôte en allant dans « Media injection » (icône de caméra sur la barre d'outils à droite), puis en la sélectionnant comme source. D'autre part, il est important de sélectionner l'option "Resize" pour que le visage soit centré et bien formé dans la caméra de l'émulateur comme le montrent les images ci-dessous.

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-9.png"), stroke: 0.1pt),
  caption: "Configuration de la caméra de l'émulateur Android pour utiliser la caméra virtuelle de la machine hôte.",
)

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-10.png", width: 40%), stroke: 0.1pt),
  caption: "Diffusion de l'image de face centrée et bien formée sur l'émulateur Android.",
)

Enfin, nous pouvons poursuivre la vérification d'âge de la #underline[@roblox-4] en cliquant sur "Continuer" puis en diffusant les images de profil gauche et droit au moment où les mouvements correspondants sont demandés.

// TODO : Dire pourquoi pas vidéo : parce que difficile à timer et plus cher

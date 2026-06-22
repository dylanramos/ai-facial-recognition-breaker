#import "@preview/codelst:2.0.2": sourcecode

= Attaques réussies

== Introduction

Ce chapitre détaille deux attaques ayant permis de contourner avec succès des systèmes de vérification d'identité par selfie vidéo. Pour chacune, la démarche est décrite étape par étape, accompagnée d'une analyse du rôle joué par l'IA et d'une évaluation de la robustesse du fournisseur de solution de vérification d'identité concerné. Des vidéos illustrent le déroulement de chaque attaque.

== Tea for Women

=== Qu'est-ce que c'est ?

Tea for Women est une plateforme de sécurité conçue pour protéger les femmes dans le monde des rencontres en ligne. Elle permet aux utilisatrices d'effectuer des recherches d'antécédents, de vérifier les numéros de téléphone pour détecter les mariages cachés et de consulter des avis anonymes sur des hommes spécifiques @tea. L'objectif de la plateforme est de répondre à la question « Sortons-nous avec le même garçon ? » avant même le premier rendez-vous.

=== Attaque

En allant sur le site #underline(link("https://www.teaforwomen.com")) et en cliquant sur "Sign up" puis "Create your Tea account" nous arrivons sur la page ci-dessous.

#figure(
  rect(image("../../images/07-attaques-reussies/tea-1.png"), stroke: 0.1pt),
  caption: "Page d'inscription du site Tea for Women.",
)

Nous pouvons voir que toutes les informations demandées sur cette page peuvent être faussées et qu'aucune vérification d'e-mail ou de numéro de téléphone n'est demandée. Une fois le formulaire rempli et soumis, nous arrivons sur la page de vérification d'identité et nous constatons que l'option recommandée est la plus simple à attaquer.

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

=== L'utilisation de l'IA est-elle vraiment nécessaire ? <07-ia-necessaire>

Le chapitre précédent a montré qu'il est possible de contourner la vérification d'identité sur le site Tea for Women avec une vidéo générée par l'IA, mais l'utilisation de l'IA est-elle vraiment nécessaire pour réussir cette attaque ? Pour le savoir, nous pouvons essayer d'effectuer une attaque par présentation.

Une attaque par présentation consiste à tenter de tromper un système de vérification d'identité en présentant à la caméra un élément autre qu'une personne réelle et vivante @presentation-attack. Parmi les éléments couramment utilisés pour ce type d'attaque, on trouve des photos de personnes imprimées, des masques en silicone portés par les attaquants ou encore des vidéos préenregistrées placées directement devant la caméra.

Pour répondre à cette question, nous pouvons donc commencer par l'attaque la plus simple, à savoir présenter une photo imprimée d'une personne sur une caméra physique.

#figure(
  rect(image("../../images/07-attaques-reussies/printed.jpg", width: 60%), stroke: 0.1pt),
  caption: "Photo imprimée utilisée pour tenter de contourner la vérification d'identité du site Tea for Women.",
)

Résultat : #link("../videos/07-attaques-reussies/tea-printed.mp4")[#underline[videos/07-attaques-reussies/tea-printed.mp4]]

Comme le montre la vidéo ci-dessus, le visage est bien détecté, mais lorsque les mouvements sont demandés une seule feuille ne suffit pas. Cette méthode fonctionne probablement, mais il faudrait imprimer une feuille par mouvement. Nous pouvons tenter une approche moins coûteuse en présentant une vidéo préenregistrée directement devant la caméra à l'aide d'un smartphone.

Résultat : #link("../videos/07-attaques-reussies/tea-phone.mp4")[#underline[videos/07-attaques-reussies/tea-phone.mp4]]

Effectivement, cette approche fonctionne. Pour des raisons de simplicité, la vidéo utilisée pour cette attaque est la même que celle utilisée au chapitre précédent, soit la vidéo générée par IA. Mais cette approche a démontré que *l'utilisation de l'IA n'est pas nécessaire*, en effet, un attaquant pourrait très bien trouver une vidéo sur internet d'une personne effectuant ces mouvements ou bien simplement se filmer en utilisant un masque en silicone.

=== Le fournisseur de la solution de vérification d'identité est-il vraiment sûr ?

Lors de la vérification d'identité, nous pouvons voir que la solution de vérification d'identité utilisée par le site Tea for Women est #link("https://regulaforensics.com/")[#underline[Regula]]. Regula est un fournisseur mondial de solutions de vérification d'identité et de dispositifs forensiques avec plus de 30 ans d'expérience et des clients majeurs tels que UBS, IATA ou encore Uber @regula. Pour utiliser leurs solutions, un SDK est mis à disposition des développeurs afin de les intégrer dans leurs applications.

En allant sur leur #link("https://faceapi.regulaforensics.com/")[#underline[page de test]], nous pouvons tenter de reproduire l'attaque effectuée précédemment pour vérifier si le même résultat est obtenu.

Résultat : #link("../videos/07-attaques-reussies/regula.mp4")[#underline[videos/07-attaques-reussies/regula.mp4]]

La vidéo ci-dessus nous montre que le résultat est bien différent, l'attaque ne fonctionne plus. Nous pouvons donc en déduire que le site Tea for Women n'a probablement pas mis à jour son SDK et que le contournement de la solution de Regula est bien plus complexe. En effet, la #underline[@regula-release-notes] ci-dessous nous montre que certaines versions du #link("https://docs.regulaforensics.com/develop/face-sdk/release-notes/")[#underline[Face SDK de Regula]] ne sont plus maintenues.

#figure(
  rect(image("../../images/07-attaques-reussies/regula.png", width: 60%), stroke: 0.1pt),
  caption: "Release notes du Face SDK de Regula.",
)<regula-release-notes>

== Roblox <07-roblox>

=== Qu'est-ce que c'est ?

Roblox est une plateforme de jeu en ligne et un système de création qui permet aux utilisateurs de programmer, jouer et partager des expériences en 3D générées par la communauté @roblox. La plateforme est très populaire auprès des enfants et des adolescents et applique des contrôles parentaux stricts pour les joueurs de moins de 13 ans.

=== Attaque

En allant sur le site #underline(link("https://www.roblox.com")) nous arrivons sur la page ci-dessous.

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-1.png"), stroke: 0.1pt),
  caption: "Page d'inscription du site Roblox.",
)

Nous pouvons voir que toutes les informations demandées sur cette page peuvent être faussées et qu'aucune vérification d'e-mail ou de numéro de téléphone n'est demandée. Un enfant peut donc facilement créer un compte avec un faux âge sans l'intervention d'un adulte.

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
  caption: "Image de face modifiée avec l'IA.",
)

#sourcecode[```sh
    aifrb edit-image "Replace the man on the first image by the man on the second image." downloads/left.jpg -a "auto" -i downloads/new-face.jpg
```]

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-7.jpg", width: 70%), stroke: 0.1pt),
  caption: "Image avec la tête tournée à gauche modifiée avec l'IA.",
)

#sourcecode[```sh
    aifrb edit-image "Replace the man on the first image by the man on the second image." downloads/right.jpg -a "auto" -i downloads/new-face.jpg
```]

#figure(
  rect(image("../../images/07-attaques-reussies/roblox-8.jpg", width: 70%), stroke: 0.1pt),
  caption: "Image avec la tête tournée à droite modifiée avec l'IA.",
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

Résultat : #link("../videos/07-attaques-reussies/roblox-result.mp4")[#underline[videos/07-attaques-reussies/roblox-result.mp4]]

La vérification d'âge par selfie vidéo est *contournée avec succès*.

=== L'utilisation de l'IA est-elle vraiment nécessaire ?

Comme l'a démontré le chapitre précédent, il a suffi de trois images pour contourner la vérification d'âge sur le site Roblox. Donc, l'utilisation de l'IA n'est pas nécessaire dans ce cas précis, car les images de n'importe quelle personne font l'affaire tant que les mouvements sont corrects, que ce soit généré par IA ou non.

Comme pour le site Tea for Women, nous pouvons également essayer d'effectuer une attaque par présentation pour vérifier si l'utilisation d'une caméra virtuelle apporte réellement quelque chose à l'attaque. Pour ce faire, nous présentons simplement les photos à une caméra physique, une fois imprimées sur papier, puis une seconde fois affichées sur un téléphone.

Résultat avec une photo imprimée : #link("../videos/07-attaques-reussies/roblox-printed.mp4")[#underline[videos/07-attaques-reussies/roblox-printed.mp4]]

Résultat avec une photo affichée sur un téléphone : #link("../videos/07-attaques-reussies/roblox-phone.mp4")[#underline[videos/07-attaques-reussies/roblox-phone.mp4]]

Comme le montrent les deux vidéos ci-dessus, ce type d'attaque ne fonctionne pas. En effet, le système de vérification semble détecter que les images manquent de profondeur et qu'il ne s'agit pas d'une personne réelle. Ainsi, l'utilisation d'une caméra virtuelle est nécessaire pour contourner la vérification d'âge sur le site Roblox.

=== Le fournisseur de la solution de vérification d'identité est-il vraiment sûr ?

Lors de la vérification d'identité, nous pouvons voir que la solution de vérification d'identité utilisée par le site Roblox est #link("https://withpersona.com/")[#underline[Persona]]. Persona est une société américaine spécialisée dans la vérification d'identité qui propose une plateforme d'infrastructure d'identité unifiée qui aide les entreprises à vérifier l'identité des particuliers et des organisations à se conformer aux normes KYC @persona. Parmi les clients de Persona, on retrouve des entreprises telles que LinkedIn, Reddit ou encore OpenAI.

Pour utiliser leurs solutions, une API est mise à disposition des développeurs afin de les intégrer dans leurs applications. Contrairement à Regula, Persona ne fournit pas de SDK pour des applications web, ce qui signifie que les mises à jour de leurs solutions sont directement appliquées sur leur plateforme et que les clients n'ont pas à faire quoi que ce soit pour en bénéficier. Ainsi, nous pouvons en déduire que *la vérification d'âge à l'aide de la solution de Persona est vulnérable* et que le problème ne vient pas de Roblox.

== Conclusion

Les deux attaques présentées dans ce chapitre ont permis de contourner avec succès la vérification d'identité par selfie vidéo sur Tea for Women et Roblox. Dans les deux cas, l'IA s'est avérée utile mais non indispensable, une caméra virtuelle diffusant du contenu approprié suffit à condition que le système ne détecte pas le manque de profondeur propre aux photos ou vidéos affichées sur un écran.

L'analyse des fournisseurs révèle des situations contrastées. Tea for Women utilise une version obsolète du SDK de Regula, une version à jour résiste probablement à l'attaque, tandis que la vulnérabilité de Roblox provient directement de la solution Persona, indépendamment de l'intégration faite par Roblox. Le chapitre suivant examine les cas où ces mêmes approches ont échoué et les pistes explorées pour tenter de les surmonter.

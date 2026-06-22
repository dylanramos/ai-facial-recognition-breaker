= Conception

== Introduction

Ce chapitre traduit les patterns de vérification d'identité identifiés précédemment en scénarios d'attaque concrets. Pour chaque pattern, un scénario typique est défini, décrivant comment un attaquant pourrait exploiter les failles du système. Ces scénarios permettent ensuite de dériver les fonctionnalités nécessaires au démonstrateur et d'en définir l'architecture.

== User Stories <user_stories>

Suite aux patterns de vérification d'identité identifiés au #underline()[@patterns], des scénarios d'attaque ont été définis pour chaque pattern. Ces scénarios décrivent comment un attaquant pourrait contourner les mécanismes de vérification d'identité et permettent de définir les fonctionnalités nécessaires au démonstrateur pour simuler ces attaques.

Les sous-chapitres suivants détaillent les scénarios typiques pour chaque pattern. Ces scénarios ont été sélectionnés, car ils concernent la majorité des sites (par pattern) et démontrent de manière complète les fonctionnalités requises du démonstrateur. Néanmoins, d'autres scénarios sont présentés dans le rapport détaillé #link("../rapports-detailles/user-stories.pdf")[#underline("user-stories.pdf")].

=== Pattern 1 : vérification par selfie vidéo uniquement <user-story-pattern-1>

Les sites concernés par ce pattern sont Facebook, Tea for Women, Roblox, Parship et Google. L'intérêt pour un attaquant de cibler ces sites serait de nuire à la réputation de quelqu'un en créant un faux compte sur Facebook, Tea for Women ou Parship. Dans le cas de Roblox et de Google, ce serait plutôt une personne mineure possédant déjà un compte qui chercherait à modifier sa date de naissance pour accéder à des contenus ou services inappropriés.

La #underline[@facebook-example] ci-dessous montre un exemple de selfie vidéo demandé par Facebook. Nous pouvons voir que cinq mouvements de tête sont demandés avec à chaque fois trois possibilités (gauche, droite ou haut). À noter que les mouvements sont différents à chaque rafraîchissement de page.

#figure(
  rect(image("../../images/05-conception/facebook-example.png", width: 70%), stroke: 0.1pt),
  caption: "Exemple de selfie vidéo demandé par Facebook.",
) <facebook-example>

*Scénario typique*

L'attaquant veut créer un faux compte sur un site vulnérable pour nuire à la réputation de quelqu'un dont il possède une photo. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité.

#figure(
  rect(image("../../images/05-conception/selfie-video-1.png"), stroke: 0.1pt),
  caption: "Scénario typique du pattern 1 : l'attaquant demande au démonstrateur de générer un selfie vidéo d'une personne à partir de son image.",
)

Pour ce scénario, deux types de modèles de génération de vidéos sont intéressants à tester :
- *Image-to-Video :* l'attaquant demande au démonstrateur de générer un selfie vidéo à partir d'une image de référence (récupérée sur internet par exemple).
- *Video-to-Video :* l'attaquant demande au démonstrateur de modifier une vidéo de lui pré-enregistrée pour y intégrer un autre visage.

=== Pattern 2 : vérification par scan de document d'identité et selfie vidéo sur ordinateur

Les sites concernés par ce pattern sont Migros Bank, Swissquote, Lotterie Romande, Swiss Casinos, Bet365, Binance et Kraken. L'interêt pour un attaquant de cibler ces sites serait de créer un faux compte pour commettre des fraudes financières. Par rapport au pattern précédent, il faut non seulement produire un selfie mais en plus, celui-ci doit correspondre à la photo d'un document d'identité à fournir.

*Scénario typique*

L'attaquant a récupéré un exemple de document d'identité sur Internet @swiss-id-template et veut créer un faux compte sur un site vulnérable pour commettre des fraudes financières. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité.

#figure(
  rect(image("../../images/05-conception/ordinateur-2.png"), stroke: 0.1pt),
  caption: "Scénario typique du pattern 2 : l'attaquant a récupéré un exemple de document d'identité sur Internet et demande au démonstrateur de le modifier avec des informations fictives. Ensuite, il demande de simuler le scan du document et de générer un selfie vidéo correspondant à la personne sur le document.",
)

Ce scénario est intéressant car il combine à la fois la génération d'images et la génération de vidéos.

Pour la modification du document d'identité, les modèles de type *Text-to-Image* ne sont pas adaptés, il faut utiliser les modèles de type *Image-to-Image* comme le démontre le #underline[@03-modification-id].

Pour la génération de la vidéo du document d'identité et du selfie vidéo, les modèles de type *Text-to-Video* ne sont également pas adaptés. En effet, pour ce cas d'utilisation, il est important que les vidéos soient cohérentes avec l'image du document d'identité. Il faut donc utiliser des modèles de type *Image-to-Video* ou *Video-to-Video*.

=== Pattern 3 : vérification par scan de document d'identité et selfie vidéo sur smartphone

Les sites concernés par ce pattern sont UBS, Swissborg, Okx, Zak Cler et OkCupid. L'interêt pour l'attaquant est le même que pour le pattern précédent (sauf pour OkCupid qui est un site de rencontres), mais cette fois il y a la contrainte de devoir utiliser un smartphone au lieu d'un ordinateur.

Les scénarios sont donc les mêmes que dans le chapitre précédent, mais au lieu de passer par le navigateur pour la création du compte, l'attaquant passe par l'application mobile du site vulnérable, possiblement via un émulateur Android.


=== Pattern 4 : vérification par scan de document d'identité et appel vidéo

Les sites concernés par ce pattern sont Neon Bank, Revolut, Yuh et le Portail de l'Etat de Vaud. L'interêt pour l'attaquant est le même que pour les deux patterns précédents, mais cette fois il y a la contrainte de devoir effectuer un appel vidéo avec un agent humain au lieu d'une vérification automatisée.

De plus, comme pour le pattern précédent, la création du compte se fait via l'application mobile du site vulnérable.

*Scénario typique*

L'attaquant possède un document d'identité falsifié et veut créer un faux compte sur une application vulnérable pour commettre des fraudes financières. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité. Ne sachant pas ce qui va lui être demandé lors de l'appel vidéo, il doit miser sur de l'ingénierie sociale pour réussir à tromper l'agent humain.

#figure(
  rect(image("../../images/05-conception/appel-2.png"), stroke: 0.1pt),
  caption: "Scénario typique du pattern 4 : l'attaquant attend les instructions de l'employé, puis demande au démonstrateur de générer une vidéo de la personne en train d'effectuer les actions demandées. En attendant la génération, l'attaquant simule des problèmes de caméra.",
)

Ce scénario est de loin le plus complexe, il s'agit non seulement de générer une vidéo cohérente avec le document d'identité, mais aussi de réagir en temps réel aux instructions de l'agent humain. Il faudra donc jouer sur de l'ingénierie sociale pour simuler des problèmes de caméra le temps de la génération de la vidéo ou dans le meilleur des cas, réussir à négocier avec l'agent humain pour qu'il accepte une vidéo envoyée plutôt qu'un appel vidéo.

Pour ce scénario, le modèle de type *Video-to-Video* semble être le plus adéquat, car il permet de partir d'une vidéo préenregistrée de l'attaquant et ainsi de reproduire les actions demandées de la manière la plus réaliste possible.

== Fonctionnalités du démonstrateur

Les User Stories identifiées au chapitre précédent permettent de définir les fonctionnalités nécessaires au démonstrateur pour réaliser les attaques. Le démonstrateur doit être capable de :
- Modifier des images à partir d'une image de référence (Image-to-Image) pour falsifier des documents d'identité.
- Générer des vidéos à partir d'une image de référence (Image-to-Video) pour générer des vidéos de documents d'identité et des selfies vidéos cohérents avec les documents falsifiés.
- Générer des vidéos à partir d'une vidéo préenregistrée (Video-to-Video) pour réagir en temps réel aux instructions de l'agent humain ou pour générer des selfies vidéos plus contrôlés.
- Diffuser des vidéos sur une caméra virtuelle de l'OS.

== Architecture

La #underline()[@architecture] ci-dessous présente l'architecture du démonstrateur. Le démonstrateur est un CLI qui communique avec l'API de Kie.ai pour générer des images et des vidéos à partir de commandes entrées par l'utilisateur. Une fois les images et les vidéos générées, le démonstrateur les récupère puis offre la possibilité à l'utilisateur de les diffuser sur une caméra virtuelle de l'OS.

#figure(
  rect(image("../../images/05-conception/architecture.png"), stroke: 0.1pt),
  caption: "Architecture du démonstrateur.",
) <architecture>

== Conclusion

Ce chapitre a permis de définir les fonctionnalités du démonstrateur à partir des scénarios d'attaque, notamment la modification d'images, la génération de vidéos (Image-to-Video et Video-to-Video) et la diffusion sur caméra virtuelle. Ces fonctionnalités s'appuient directement sur les briques techniques sélectionnées dans les chapitres précédents, KIE AI pour la génération IA et `v4l2loopback` + `pyvirtualcam` pour la diffusion vidéo. Le chapitre suivant décrit la mise en œuvre concrète du démonstrateur.
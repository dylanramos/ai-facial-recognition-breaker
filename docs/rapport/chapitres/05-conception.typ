= Conception

== User Stories <user_stories>

En fonction des patterns de vérification d'identité identifiés au #underline()[@patterns], des scénarios d'attaque ont été définis pour chaque pattern. Ces scénarios décrivent comment un attaquant pourrait contourner les mécanismes de vérification d'identité et permettent de définir les fonctionnalités nécessaires du démonstrateur pour simuler ces attaques. 

Les chapitres suivants détaillent les scénarios typiques pour chaque pattern. Ces scénarios ont été sélectionnés car ils concernent la majorité des sites (par pattern) et démontrent de manière complète les fonctionnalités requises du démonstrateur. Néanmoins, d'autres scénarios sont présentés dans le rapport de recherche #link("../rapports-de-recherche/user-stories/user-stories.pdf")[#underline("user-stories.pdf")].

=== Scénarios non pris en compte

Seuls les scénarios impliquant l'utilisation de l'IA ont été pris en compte. En effet, l'objectif de ce travail est de démontrer les risques liés à l'utilisation de l'IA dans les processus de vérification d'identité en ligne. Ainsi, les sites qui ne demandent que d'envoyer une photo d'un document d'identité par exemple ne sont pas pris en compte, car le document peut être facilement falsifié avec des outils de retouche d'image classiques.

=== Pattern 1 : vérification par selfie vidéo uniquement <user-story-pattern-1>

Les sites concernés par ce pattern sont Facebook, Tea for Women, Roblox, Parship et Google. L'interêt pour un attaquant de cibler ces sites serait de nuire à la réputation de quelqu'un en créant un faux compte sur Facebook, Tea for Women ou Parship. Dans le cas de Roblox et de Google, ce serait plutôt une personne mineure possédant déjà un compte qui chercherait à modifier sa date de naissance pour accéder à des contenus ou services inappropriés.

Le lien ci-après montre un exemple de selfie vidéo demandé par Facebook : #underline()[#link("https://drive.proton.me/urls/D81WJDY3PG#XU6kPbSIfchZ")].

*Scénario typique* 

L'attaquant veut créer un faux compte sur un site vulnérable pour nuire à la réputation de quelqu'un. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité.

#figure(
  rect(image("../images/05-conception/selfie-video-1.png"), stroke: 0.1pt),
  caption: "Scénario typique du pattern 1 : l'attaquant demande au démonstrateur de générer un selfie vidéo d'une personne à partir de son image."
)

Pour ce scénario, les trois types de génération de vidéos sont intéressants à tester :
- *Text-to-Video :* l'attaquant demande au démonstrateur de générer un selfie vidéo sans image de référence.
- *Image-to-Video :* l'attaquant demande au démonstrateur de générer un selfie vidéo à partir d'une image de référence (récupérée sur Internet par exemple).
- *Video-to-Video :* l'attaquant demande au démonstrateur de modifier une vidéo de lui pré-enregistrée pour y intégrer un autre visage.

=== Pattern 2 : vérification par scan de document d'identité et selfie vidéo sur ordinateur

Les sites concernés par ce pattern sont Migros Bank, Swissquote, Lotterie Romande, Swiss Casinos, Bet365, Binance et Kraken. L'interêt pour un attaquant de cibler ces sites serait de créer un faux compte pour commettre des fraudes financières. Contrairement au pattern précédent, celui-ci est plus difficile à contourner, car il nécessite à la fois un faux document d'identité (ou un document volé) et un selfie vidéo correspondant. 

*Scénario typique*

L'attaquant a récupéré un exemple de document d'identité sur Internet #footnote[https://media.lematin.ch/4/image/2025/11/12/d10f8b1e-512b-4e61-9ccb-6a391f05621f.jpg?auto=format%2Ccompress%2Cenhance&fit=max&w=1200&h=1200&rect=0%2C0%2C1024%2C640&fp-x=0.2265625&fp-y=0.44375&s=5c24eb000b8b1c27d35d5c4e9d79d9bd] et veut créer un faux compte sur un site vulnérable pour commettre des fraudes financières. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité.

#figure(
  rect(image("../images/05-conception/ordinateur-2.png"), stroke: 0.1pt),
  caption: "Scénario typique du pattern 2 : l'attaquant a récupéré un exemple de document d'identité sur Internet et demande au démonstrateur de le modifier avec des informations fictives. Ensuite, il demande de simuler le scan du document et de générer un selfie vidéo correspondant à la personne sur le document."
)

Ce scénario est intéressant car il combine à la fois la génération d'images et la génération de vidéos. 

Pour la modification du document d'identité, les modèles de type *Text-to-Image* ne sont pas adaptés, il faut utiliser les modèles de type *Image-to-Image* comme le démontre le #underline[@exemples-tests-effectues]. 

Pour la génération de la vidéo du document d'identité et du selfie vidéo, les modèles de type *Text-to-Video* ne sont également pas adaptés. En effet, pour ce cas d'utilisation, il est important que les vidéos soient cohérentes avec l'image du document d'identité. Il faut donc utiliser des modèles de type *Image-to-Video* ou *Video-to-Video*.

=== Pattern 3 : vérification par scan de document d'identité et selfie vidéo sur smartphone

Les sites concernés par ce pattern sont UBS, Swissborg, Okx, Zak Cler et OkCupid. L'interêt pour l'attaquant est le même que pour le pattern précédent (sauf pour OkCupid où l'interêt serait plutôt de nuire à la réputation de quelqu'un), mais cette fois il y a la contrainte de devoir utiliser un smartphone au lieu d'un ordinateur.

Les scénarios sont donc les mêmes que dans le chapitre précédent, mais au lieu de passer par le navigateur pour la création du compte, l'attaquant passe par l'application mobile du site vulnérable via un émulateur Android, qui détectera la caméra virtuelle de l'ordinateur.

=== Pattern 4 : vérification par scan de document d'identité et appel vidéo

Les sites concernés par ce pattern sont Neon Bank, Revolut, Yuh et le Portail de l'Etat de Vaud. L'interêt pour l'attaquant est le même que pour les deux patterns précédents, mais cette fois il y a la contrainte de devoir effectuer un appel vidéo avec un agent humain au lieu d'une vérification automatisée.

De plus, comme pour le pattern précédent, la création du compte se fait via l'application mobile du site vulnérable.

*Scénario typique*

L'attaquant possède un document d'identité falsifié et veut créer un faux compte sur une application vulnérable pour commettre des fraudes financières. Il suit le processus d'enregistrement en ligne en renseignant les informations nécessaires et arrive à l'étape de vérification d'identité. Ne sachant pas ce qui va lui être demandé lors de l'appel vidéo, il doit miser sur de l'ingénierie sociale pour réussir à tromper l'agent humain.

#figure(
  rect(image("../images/05-conception/appel-2.png"), stroke: 0.1pt),
  caption: "Scénario typique du pattern 4 : l'attaquant attend les instructions de l'employé, puis demande au démonstrateur de générer une vidéo de la personne en train d'effectuer les actions demandées. En attendant la génération, l'attaquant simule des problèmes de caméra."
)

Ce scénario est de loin le plus complexe, il s'agit non seulement de générer une vidéo cohérente avec le document d'identité falsifié, mais aussi de réagir en temps réel aux instructions de l'agent humain. Il faudra donc jouer sur de l'ingénierie sociale pour simuler des problèmes de caméra le temps de la génération de la vidéo ou dans le meilleur des cas, réussir à négocier avec l'agent humain pour qu'il accepte une vidéo envoyée plutôt qu'un appel vidéo.

Pour ce scénario, le modèle de type *Video-to-Video* semble être le plus adéquat, car il permet de partir d'une vidéo pré-enregistrée de l'attaquant et ainsi de réproduire les actions demandées de la manière la plus réaliste possible.

== Fonctionnalités du démonstrateur

Les User Stories identifiées au chapitre précédent permettent de définir les fonctionnalités nécessaires au démonstrateur pour réaliser les attaques. Le démonstrateur doit être capable de :
- Modifier des images à partir d'une image de référence (Image-to-Image) pour falsifier des documents d'identité.
- Générer des vidéos à partir d'un prompt uniquement (Text-to-Video) pour générer des selfies vidéos sans image de référence et vérifier si la vérification est réussie pour le scénario du #underline[@user-story-pattern-1].
- Générer des vidéos à partir d'une image de référence (Image-to-Video) pour générer des vidéos de documents d'identité et des selfies vidéos cohérents avec les documents falsifiés.
- Générer des vidéos à partir d'une vidéo pré-enregistrée (Video-to-Video) pour réagir en temps réel aux instructions de l'agent humain ou pour générer des selfies vidéos plus contrôlés.
- Diffuser des vidéos sur une caméra virtuelle de l'OS.

Concernant la partie optionnelle (automatisation du démonstrateur), celle-ci concerne les mêmes scénarios que ceux présentés, mais au lieu que l'utilisateur écrive lui-même un prompt détaillé, le démonstrateur s'occupe de générer le prompt à partir d'une instruction simple de l'utilisateur. Optionnellement, le démonstrateur doit donc être capable de :
- Générer un prompt détaillé pour chaque modèle à partir d'une instruction simple de l'utilisateur.

== Architecture

La #underline()[@architecture] ci-dessous présente l'architecture du démonstrateur. Le démonstrateur est un CLI qui communique avec l'API de Kie.ai pour générer des images et des vidéos à partir de commandes entrées par l'utilisateur. Une fois les images et les vidéos générées, le démonstrateur les récupère puis offre la possibilité à l'utilisateur de diffuser les vidéos sur une caméra virtuelle de l'OS.

#figure(
  rect(image("../images/05-conception/architecture.png"), stroke: 0.1pt),
  caption: "Architecture du démonstrateur.",
) <architecture>

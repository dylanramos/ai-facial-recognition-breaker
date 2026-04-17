= Conception

== User Stories <user_stories>

En fonction des patterns de vérification d'identité identifiés au #underline()[@patterns], des scénarios d'attaque ont été définis pour chaque pattern. Ces scénarios décrivent comment un attaquant pourrait contourner les mécanismes de vérification d'identité et permettent de définir les fonctionnalités nécessaires du démonstrateur pour simuler ces attaques. 

Les chapitres suivants détaillent les scénarios typiques pour chaque pattern. Ces scénarios ont été sélectionnés car ils concernent la majorité des sites (par pattern) et démontrent de manière complète les fonctionnalités requises du démonstrateur. Néanmoins, d'autres scénarios sont présentés dans le rapport de recherche #link("../rapports-de-recherche/user-stories/user-stories.pdf")[#underline("user-stories.pdf")].

=== Scénarios non pris en compte

Seuls les scénarios impliquant l'utilisation de l'IA ont été pris en compte. En effet, l'objectif de ce travail est de démontrer les risques liés à l'utilisation de l'IA dans les processus de vérification d'identité en ligne. Ainsi, les sites qui ne demandent que d'envoyer une photo d'un document d'identité par exemple ne sont pas pris en compte, car le document peut être facilement falsifié avec des outils de retouche d'image classiques.

=== Pattern 1 : vérification par selfie vidéo uniquement

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

== Fonctionnalités du démonstrateur

== Architecture

La #underline()[@architecture] ci-dessous présente l'architecture du démonstrateur. Le démonstrateur est un CLI qui communique avec l'API de Kie.ai pour générer des images et des vidéos à partir de commandes entrées par l'utilisateur. Une fois les images et les vidéos générées, le démonstrateur les récupère puis offre la possibilité à l'utilisateur de diffuser les vidéos sur une caméra virtuelle de l'OS.

#figure(
  rect(image("../images/05-conception/architecture.png"), stroke: 0.1pt),
  caption: "Architecture du démonstrateur.",
) <architecture>

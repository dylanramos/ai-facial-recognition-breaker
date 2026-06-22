/*
 Vars
*/
#import "./vars.typ": *

/*
 Includes
*/
#import "template/affiche_setting.typ": affiche
#show: affiche.with(
  title: TBtitle,
  dpt: "ISC",
  filiere_short: "ISC",
  filiere_long: TBfiliere,
  orientation: "ISCS",
  author: TBauthor,
  supervisor: TBsupervisor,
  industryContact: TBindustryContact,
  industryName: TBindustryName,
)

= Contexte
L'intelligence artificielle permet aujourd'hui de facilement générer des contenus multimédia réalistes. Photos, vidéos ou encore voix, les possibilités sont nombreuses et les outils de génération sont de plus en plus accessibles au grand public. Évidemment, cette démocratisation n'est pas sans risques, ces contenus peuvent être utilisés à des fins malveillantes, falsification de documents, usurpation d'identité ou encore désinformation, la nécessité de comprendre les risques liés à ces technologies est plus que jamais d'actualité. C'est notamment le cas pour les sites en ligne, qui utilisent des systèmes de vérification d'identité basés sur la reconnaissance faciale pour vérifier qu'une personne est bien celle qu'elle prétend être.

= Objectifs
Ce travail de Bachelor cherche à comprendre les risques associés à l'utilisation de la reconnaissance faciale dans les services en ligne et à démontrer s'il est possible de contourner ces systèmes de vérification d'identité en utilisant l'intelligence artificielle.

= Résultats
Parmi les cinq sites demandant une vérification d'identité par selfie vidéo analysés en profondeur, deux se sont révélés vulnérables. Tea for Women, dont l'objectif est de protéger les femmes dans le monde des rencontres en ligne, s'est avéré vulnérable à l'utilisation d'une vidéo IA lors de la création d'un compte. Roblox, une plateforme de jeux en ligne très populaire auprès des enfants, a également été contournée avec des images IA lors d'une vérification d'âge pour accéder à des fonctionnalités de chat destinées aux adultes.

= Conclusion
Ce travail a montré que la robustesse d'un système de vérification d'identité dépend de deux facteurs indépendants : la qualité de la solution tierce utilisée et la rigueur de son intégration et de sa maintenance. D'autre part, il a également montré que les outils de génération IA sont aujourd'hui accessibles à faible coût via des plateformes agrégées comme KIE AI, ce qui abaisse considérablement la barrière à l'entrée pour un attaquant potentiel. La question n'est donc plus de savoir si ce type d'attaque est techniquement faisable, mais de savoir dans quelle mesure les systèmes de vérification en place sont à jour et correctement configurés.


#align(center, rect(image("template/images/facebook-example.png", width: 100%), stroke: 0.1pt))

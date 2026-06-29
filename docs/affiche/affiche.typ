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
Avec l'essor de l'intelligence artificielle, il est désormais possible de générer des contenus multimédia ultraréalistes à la demande, ce qui ouvre la porte à de nouvelles formes d'attaques contre les systèmes de vérification d'identité en ligne. Ce travail analyse en profondeur cinq sites demandant une vérification d'identité par selfie vidéo, à savoir Facebook, Tea for Women, Roblox, Parship et Google. Des attaques concrètes ont été menées sur ceux-ci à l'aide d'un outil Python développé qui génère du contenu IA via la plateforme KIE AI et l'injecte dans une caméra virtuelle Linux.

= Objectifs
Ce travail de Bachelor cherche à comprendre les risques associés à l'utilisation de la reconnaissance faciale dans les services en ligne et à démontrer s'il est possible de contourner ces systèmes de vérification d'identité en utilisant l'intelligence artificielle.

= Résultats
Parmi les cinq sites, deux se sont révélés vulnérables. Tea for Women, dont l'objectif est de protéger les femmes dans le monde des rencontres en ligne, s'est avéré vulnérable à l'utilisation d'une vidéo IA lors de la création d'un compte. Roblox, une plateforme de jeux en ligne très populaire auprès des enfants, a également été contournée avec des images IA lors d'une vérification d'âge pour accéder à des fonctionnalités de chat destinées aux adultes. Facebook, Parship et Google ont en revanche résisté à toutes les tentatives grâce à des mécanismes multicouches, notamment la détection de contenus multimédia synthétiques, la détection d'appareils virtuels et l'analyse comportementale.

= Conclusion
Ce travail a montré que la robustesse d'un système de vérification d'identité dépend de deux facteurs indépendants : la qualité de la solution tierce utilisée et la rigueur de son intégration et de sa maintenance. D'autre part, il a également montré qu'aucun système n'est infaillible et qu'il reste des pistes inexplorées qui pourraient permettre de contourner ces mécanismes de défense. Par exemple, en utilisant des périphériques d'injection de flux vidéo physiques ou en interceptant les appels API du navigateur pour tromper les systèmes de détection.


#align(center, rect(image("template/images/facebook-example.png", width: 100%), stroke: 0.1pt))

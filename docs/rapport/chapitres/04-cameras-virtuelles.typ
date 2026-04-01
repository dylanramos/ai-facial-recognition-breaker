#import "@preview/codelst:2.0.2": sourcecode

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Caméras virtuelles et redirection de flux vidéo

*Analyses détaillées* : #link("../rapports-de-recherche/cameras-virtuelles/cameras-virtuelles.pdf")[#underline("cameras-virtuelles.pdf")]

Pour pouvoir tromper les sites de vérification d'identité, il faut trouver un moyen de rediriger la vidéo générée vers une caméra détectée comme réelle par ceux-ci. La solution la plus simple est d'utiliser une caméra virtuelle, qui est un périphérique logiciel simulant une caméra physique.

Chaque OS a sa propre manière de gérer les caméras virtuelles. Sous Linux, il faut passer par un module du noyau dédié, alors que sous Windows, il faut développer son propre pilote de caméra virtuelle.

=== pyvirtualcam

Pour éviter de devoir s'adapter à chaque OS et pour simplifier le développement du démonstrateur, la solution choisie est d'utiliser la librairie Python `pyvirtualcam` qui permet d'envoyer des flux vidéo à une caméra virtuelle de manière simple et multiplateforme.

== Conclusion

Les attaques se concentreront dans un premier temps sur les sites les plus faciles à attaquer.

Pour les sites qui demandent une vérification par photo, il faudra commencer par tester avec des images non générées pour voir si l'IA peut vraiment apporter quelque chose ou si une simple photo d'une autre personne suffit. Si l'IA peut apporter quelque chose, il faudra tester les différents modèles de type Image-to-Image pour déterminer lequel est le plus adapté pour modifier une image (faire vieillir une personne, changer une photo sur un document d'identité, etc.).

Pour les sites qui demandent une vérification par vidéo, il faut que le modèle soit capable de générer une vidéo réaliste d'une personne mais aussi d'une caméra filmant un document d'identité. Les modèles les plus utiles seront probablement ceux de type Image-to-Video et Video-to-Video. Il faudra également prendre en compte le fait qu'un interlocuteur humain peut être présent et penser à des méthodes pour le tromper, en jouant sur les temps de réponse par exemple.

Enfin, pour rediriger une vidéo générée vers une caméra virtuelle, la librairie Python `pyvirtualcam` semble être une bonne solution car elle est multiplateforme et utilise un langage de progammation populaire.

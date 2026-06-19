= Conclusion

== Bilan global

Ce travail de Bachelor avait pour objectif d'évaluer la résistance des systèmes de vérification d'identité en ligne aux attaques basées sur l'intelligence artificielle. En raison des contraintes de temps, seul le premier pattern de vérification d'identité par selfie vidéo sans document d'identité a pu être étudié en profondeur, les patterns plus complexes comme l'appel vidéo avec un employé restent à explorer.

Parmi les cinq sites relevant de ce pattern, Facebook, Tea for Women, Roblox, Parship et Google, deux se sont révélés vulnérables. Dans les deux cas, la faiblesse identifiée tient à l'absence de détection des attaques par injection (IAD), Tea for Women utilisait une version obsolète du SDK de Regula, tandis que la vulnérabilité de Roblox provenait directement de la solution Persona, indépendamment de son intégration.

Ces résultats montrent que la robustesse d'un système de vérification dépend de deux facteurs indépendants : la qualité de la solution tierce utilisée et la rigueur de son intégration et de sa maintenance. Un fournisseur solide dont le SDK est obsolète, comme dans le cas de Tea for Women avec Regula, reste vulnérable. À l'inverse, même une solution à jour, comme Persona sur le site de Roblox, peut présenter des failles.

Sur le plan technique, les systèmes de vérification robustes opèrent sur plusieurs couches défensives simultanément, notamment en détectant les attaques par présentation et les attaques par injection, mais aussi en  analysant le comportement de l'utilisateur. C'est cette combinaison de mécanismes qui explique la résistance observée sur les plateformes les plus robustes.

Enfin, ce travail a également montré que les outils de génération IA sont aujourd'hui accessibles à faible coût via des plateformes agrégées comme KIE AI, ce qui abaisse considérablement la barrière à l'entrée pour un attaquant potentiel. La question n'est donc plus de savoir si ce type d'attaque est techniquement faisable, mais de savoir dans quelle mesure les systèmes de vérification en place sont à jour et correctement configurés.

== Suites possibles

Ce travail s'est concentré sur les patterns de vérification les plus accessibles, c'est-à-dire ceux ne requérant qu'un selfie vidéo sans document d'identité. Plusieurs axes d'approfondissement restent à explorer.

=== Amélioration de la qualité des vidéos générées
Les modèles évolueront rapidement. Des attaques qui échouent aujourd'hui pourraient réussir avec des modèles plus récents produisant moins d'artefacts visuels et des mouvements plus cohérents. Un suivi régulier des nouveaux modèles disponibles sur KIE AI ou d'autres plateformes permettrait de réévaluer les attaques sur Facebook et Parship.

=== Échange de visage en temps réel
L'outil Deep-Live-Cam, testé mais non concluant faute de matériel suffisamment puissant, mériterait d'être réévalué sur une configuration disposant d'un GPU performant. La capacité à remplacer un visage en temps réel sans passer par une vidéo préenregistrée changerait fondamentalement la dynamique des attaques, notamment pour le pattern 4.

=== Utilisation d'un smartphone physique

L'utilisation d'un émulateur Android a été détectée par Google. Tester les mêmes attaques sur un vrai smartphone rooté permettrait de vérifier si la détection provient de l'émulation elle-même ou d'une analyse plus large du flux vidéo.

=== Évaluation de la résistance dans le temps
Les systèmes de vérification sont mis à jour régulièrement. Une réévaluation des attaques réussies sur Tea for Women et Roblox après mise à jour de leurs SDKs permettrait de confirmer si ces contournements sont durables ou s'ils constituent des vulnérabilités temporaires liées à une version spécifique.

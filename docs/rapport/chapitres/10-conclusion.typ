= Conclusion

== Bilan global

Ce travail de Bachelor avait pour objectif d'évaluer la résistance des systèmes de vérification d'identité en ligne aux attaques basées sur l'intelligence artificielle. En raison des contraintes de temps, seul le premier pattern de vérification d'identité par selfie vidéo sans document d'identité a pu être étudié en profondeur, les patterns plus complexes comme l'appel vidéo avec un employé restent à explorer.

Parmi les cinq sites relevant de ce pattern, Facebook, Tea for Women, Roblox, Parship et Google, deux se sont révélés vulnérables. Dans les deux cas, la faiblesse identifiée tient à l'absence de détection des attaques par injection (IAD), Tea for Women utilisait une version obsolète du SDK de Regula, tandis que la vulnérabilité de Roblox provenait directement de la solution Persona, indépendamment de son intégration.

Ces résultats montrent que la robustesse d'un système de vérification dépend de deux facteurs indépendants : la qualité de la solution tierce utilisée et la rigueur de son intégration et de sa maintenance. Un fournisseur solide dont le SDK est obsolète, comme dans le cas de Tea for Women avec Regula, reste vulnérable. À l'inverse, même une solution à jour, comme Persona sur le site de Roblox, peut présenter des failles.

Sur le plan technique, les systèmes de vérification robustes opèrent sur plusieurs couches défensives simultanément, notamment en détectant les attaques par présentation et les attaques par injection, mais aussi en  analysant le comportement de l'utilisateur. C'est cette combinaison de mécanismes qui explique la résistance observée sur les plateformes les plus robustes.

Enfin, ce travail a également montré que les outils de génération IA sont aujourd'hui accessibles à faible coût via des plateformes agrégées comme KIE AI, ce qui abaisse considérablement la barrière à l'entrée pour un attaquant potentiel. La question n'est donc plus de savoir si ce type d'attaque est techniquement faisable, mais de savoir dans quelle mesure les systèmes de vérification en place sont à jour et correctement configurés.

== Suites possibles

=== Approfondir les mécanismes d'injection

=== Utiliser un smartphone physique

L'utilisation d'un émulateur Android a été détectée par Google. Tester les mêmes attaques sur un vrai smartphone permettrait de vérifier si la détection provient de l'émulation elle-même ou d'une analyse plus large du flux vidéo.

=== Échanger de visage en temps réel lors d'un appel vidéo

L'outil Deep-Live-Cam s'est avéré fonctionnel et très réaliste, malgré son échec sur Facebook et Parship. Il serait intéressant de tester un tel outil lors d'un appel vidéo avec un employé pour vérifier si intégrer un humain dans le processus de vérification rend le système moins fiable que lorsqu'il est automatisé.

=== Évaluer la robustesse d'un système avec l'accord d'une entreprise

Les patterns de vérification d'identité plus complexes combinant analyse d'un document d'identité et selfie vidéo n'ont pas pu être testés. Il serait pertinent de tester le système d'une entreprise partenaire, telle que Migros Bank, avec un vrai document d'identité pour simuler le cas d'un attaquant qui l'aurait volé. Cela permettrait de vérifier la robustesse d'un système de vérification d'identité dans un scénario plus réaliste, tout en respectant les contraintes légales et éthiques.

=== Améliorer la qualité des vidéos générées

Les modèles d'IA évoluent rapidement. Des attaques qui échouent aujourd'hui pourraient réussir avec des modèles plus récents produisant moins d'artefacts visuels et des mouvements plus cohérents. Un suivi régulier des nouveaux modèles disponibles sur KIE AI ou d'autres plateformes permettrait de réévaluer les attaques échouées.

= Mécanismes de défense

== Introduction


== Détection des attaques par présentation (PAD)

Comme vu précédemment dans le #underline[@07-ia-necessaire], une attaque par présentation consiste à tenter de tromper un système de vérification d'identité en présentant à une caméra physique un élément autre qu'une personne réelle et vivante. Pour détecter ce type d'attaque, les systèmes analysent les signaux qui permettent de distinguer un visage réel comme la microtexture de la peau (par opposition à celle du papier ou d'un écran), les indices de profondeur liés à l'éclairage et aux ombres, la façon dont la lumière se reflète sur une surface ainsi que les micro-mouvements biologiques (micro-clignements des yeux, mouvements respiratoires, etc.) @didit.

== Détection des attaques par injection (IAD)

Une attaque par injection consiste à insérer un flux vidéo synthétique ou préenregistré directement dans le processus de capture du logiciel. Cette attaque intercepte les données transitant entre la caméra physique et l'application de vérification avant que tout modèle de détection de présence ne soit exécuté @didit. Pour détecter ce type d'attaque, les systèmes analysent les sources multimédias afin de déterminer si une pile d'émulation est utilisée pour présenter un appareil virtuel @biometricupdate. D'autre part, les systèmes surveillent également les appels SDK susceptibles d'être interceptés et rejoués avec une vidéo substituée. Ainsi, la détection des attaques par injection permet de protéger la chaîne d'authentification, c'est-à-dire préserver l'intégrité de la capture vidéo contre les données injectées ou altérées.

== TODO

Un modèle PAD entraîné à partir d'images capturées en direct par une caméra peut être contourné par une injection si le modèle part du principe que ses données proviennent d'une caméra physique. L'analyse PAD s'effectue sur des données synthétiques ou réutilisées qui risquent de passer la vérification car l'attaque ne présente pas une simple photo, mais ce qui ressemble à un flux vidéo cohérent en temps réel.

== Hypothèses concernant les attaques échouées
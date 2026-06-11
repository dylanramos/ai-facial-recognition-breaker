= Développement

== Choix technologiques

Le démonstrateur est un *CLI développé en Python* qui fonctionne *uniquement sur Linux*.

=== Pourquoi le langage Python ?

Le langage Python a été choisi car il permet de prototyper et développer une application rapidement grâce à sa syntaxe concise et lisible. De plus, Python est disponible par défaut sur la plupart des distributions Linux, ce qui facilite l'installation et l'utilisation du démonstrateur. Il est vrai qu'il existe des langages plus performants, mais l'objectif de ce projet n'est pas de développer une application haute performance, ici, la fonctionnalité prime sur la performance.

=== Pourquoi uniquement Linux ?

Le #underline[@04-windows] a montré que l'utilisation de `FFmpeg` combinée à `OBS Studio` engendre une latence importante, or, l'utilisation de `FFmpeg` s'avère nécessaire pour pouvoir diffuser des images statiques et éditer les vidéos. C'est pourquoi la compatibilité du démonstrateur a été limitée à Linux, en effet, `FFmpeg` s'intégre parfaitement avec le module `v4l2loopback` et permet d'avoir une latence très faible, le tout sans dépendance à un logiciel tiers.

== Dépendances

Le projet utilise #underline[#link("https://docs.astral.sh/uv/")[uv]] pour la gestion des dépendances et de l'environnement virtuel. `uv` est un outil moderne extrêmement rapide écrit en Rust qui permet de gérer les dépendances Python d'un projet de manière simple et efficace. Il offre des fonctionnalités avancées telles que la résolution automatique des dépendances, la création d'environnements virtuels isolés, et une interface en ligne de commande intuitive.

=== typer

La librairie `Typer` permet de construire des interfaces en ligne de commande de manière simple et intuitive. Elle a l'avantage de simplifier l'analyse des arguments et la validation des types en réduisant considérablement le code "boilerplate" nécessaire par rapport à des librairies comme `argparse`.

=== ffmpeg-python

La librairie `ffmpeg-python` fournit une interface pour interagir avec `FFmpeg`, elle permet ainsi d'éviter de devoir construire manuellement des commandes `FFmpeg` dans le code. À noter que pour qu'elle fonctionne, `FFmpeg` doit être installé sur le système et accessible via la ligne de commande.

=== requests

La librairie `requests` est une librairie Python très répandue qui permet de simplifier l'envoi de requêtes HTTP. Celle-ci est utilisée pour communiquer avec l'API de KIE AI, notamment pour générer des images et des vidéos.

=== python-dotenv

La librairie `python-dotenv` permet de charger des variables d'environnement à partir d'un fichier `.env`. Celle-ci permet de stocker la clé d'API de KIE AI de manière sécurisée et de la charger facilement dans le code.

== Structure du projet

#text(fill: red)[Structure du repo git, qu'est-ce qui est où (code, docs, etc.)]

== Fonctionnalités du démonstrateur

#text(fill: red)[Listing des commandes et qu'est-ce qu'elles font]

== Guides

=== Installation du démonstrateur

=== Utilisation du démonstrateur

=== Mise en place de l'environnement de test

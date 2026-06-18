#import "@preview/codelst:2.0.2": sourcecode

= Développement

== Introduction

Ce chapitre présente le démonstrateur développé pour réaliser les attaques : un CLI Python nommé `aifrb` (AI Facial Recognition Breaker), conçu exclusivement pour Linux. Sont abordés successivement les choix technologiques, les dépendances retenues, la structure du projet, la procédure d'installation et les fonctionnalités disponibles.

== Choix technologiques

Le démonstrateur est un *CLI développé en Python* qui fonctionne *uniquement sur Linux*.

=== Pourquoi le langage Python ?

Le langage Python a été choisi car il permet de prototyper et développer une application rapidement grâce à sa syntaxe concise et lisible. De plus, Python est disponible par défaut sur la plupart des distributions Linux, ce qui facilite l'installation et l'utilisation du démonstrateur. Il est vrai qu'il existe des langages plus performants, mais l'objectif de ce projet n'est pas de développer une application haute performance, ici, la fonctionnalité prime sur la performance.

=== Pourquoi uniquement Linux ?

Le #underline[@04-windows] a montré que l'utilisation de `FFmpeg` combinée à OBS Studio engendre une latence importante, or, l'utilisation de `FFmpeg` s'avère nécessaire pour pouvoir diffuser des images statiques et éditer les vidéos. C'est pourquoi la compatibilité du démonstrateur a été limitée à Linux, en effet, `FFmpeg` s'intégre parfaitement avec le module `v4l2loopback` et permet d'avoir une latence très faible, le tout sans dépendance à un logiciel tiers.

== Dépendances

Le projet utilise #underline[#link("https://docs.astral.sh/uv/")[uv]] pour la gestion des dépendances et de l'environnement virtuel. `uv` est un outil moderne extrêmement rapide écrit en Rust qui permet de gérer les dépendances Python d'un projet de manière simple et efficace @uv-ref. Il offre des fonctionnalités avancées telles que la résolution automatique des dépendances, la création d'environnements virtuels isolés et une interface en ligne de commande intuitive.

=== typer

La librairie `typer` permet de construire des interfaces en ligne de commande de manière simple et intuitive @typer-ref. Elle a l'avantage de simplifier l'analyse des arguments et la validation des types en réduisant considérablement le code "boilerplate" nécessaire par rapport à des librairies comme `argparse`.

=== ffmpeg-python

La librairie `ffmpeg-python` fournit une interface pour interagir avec `FFmpeg`, elle permet ainsi d'éviter de devoir construire manuellement des commandes `FFmpeg` dans le code @ffmpeg-python-ref. À noter que pour qu'elle fonctionne, `FFmpeg` doit être installé sur le système et accessible via la ligne de commande.

=== requests

La librairie `requests` est une librairie Python très répandue qui permet de simplifier l'envoi de requêtes HTTP @requests-ref. Celle-ci est utilisée pour communiquer avec l'API de KIE AI, notamment pour générer des images et des vidéos.

=== python-dotenv

La librairie `python-dotenv` permet de charger des variables d'environnement à partir d'un fichier `.env` @python-dotenv-ref. Celle-ci permet de stocker la clé d'API de KIE AI de manière sécurisée et de la charger facilement dans le code.

== Structure du projet

Le projet est organisé de la manière suivante :

- `docs/rapport/`: rapport principal et sources des chapitres.
- `docs/rapports-detailles/`: rapports détaillés par thème.
- `docs/diagrammes/`: diagrammes Draw.io (architecture & workflows).
- `docs/images/`: images utilisées dans le rapport.
- `docs/videos/`: vidéos utilisées dans le rapport.
- `src/aifrb/main.py`: point d'entrée du CLI (application Typer).
- `src/aifrb/api/`: fournisseurs d'API (actuellement uniquement KIE AI).
- `src/aifrb/api/kieai/`: implémentation de l'API de KIE AI.
- `src/aifrb/commands/`: implémentation des commandes.
- `src/aifrb/utils/`: fonctions utilitaires (ex : téléchargement de fichiers).
- `templates/`: images et vidéos utilisées pour générer du contenu fictif (ex : modèle de carte d'identité).
- `downloads/`: destination du contenu généré par l'IA (créé automatiquement).

Note : `aifrb` est le nom du CLI, il s'agit d'un acronyme pour "AI Facial Recognition Breaker".

#figure(
  rect(image("../../images/06-developpement/structure.png", width: 40%), stroke: 0.1pt),
  caption: "Structure du projet.",
)

== Installation du démonstrateur

*Prérequis :*
- Une machine Ubuntu 26.04 ou supérieure (les autres distributions n'ont pas été testées).
- Python 3.12 ou supérieur.
- Un compte KIE AI avec une clé d'API valide.

*Installation :*

Les commandes suivantes doivent être exécutées à la racine du projet.

+ Installer `uv` :
  #sourcecode[```sh
      curl -LsSf https://astral.sh/uv/install.sh | sh
  ```]
+ Installer le module `v4l2loopback` et `FFmpeg` :
  #sourcecode[```sh
      sudo apt install v4l2loopback-dkms v4l2loopback-utils ffmpeg
  ```]
+ Créer un environnement virtuel et installer les dépendances :
  #sourcecode[```sh
      uv sync
      source .venv/bin/activate
  ```]
+ Ajouter la variable d'environnement pour la communication avec l'API de KIE AI :
  #sourcecode[```sh
      echo "KIEAI_API_KEY=votre_clé_api" > .env
  ```]
+ Lancer le programme :
  #sourcecode[```sh
      aifrb
  ```]

#figure(
  rect(image("../../images/06-developpement/aifrb-cmd.png"), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb` après l'installation du démonstrateur.],
)

== Fonctionnalités du démonstrateur

Le démonstrateur dispose de trois catégories de fonctionnalités :
- *Camera Commands* : commandes liées à la gestion des caméras virtuelles.
- *AI Commands* : commandes liées à la génération de contenu IA.
- *KIE Account Commands* : commandes liées à la gestion du compte KIE AI.

Pour savoir ce que fait une commande et comment l'utiliser, il suffit de taper `aifrb` suivi du nom de la commande. Par exemple :
#sourcecode[```sh
    aifrb generate-image
```]

#figure(
  rect(image("../../images/06-developpement/cmd-help.png"), stroke: 0.1pt),
  caption: [Résultat de la commande `aifrb generate-image`.],
)

Des informations détaillées sur l'utilisation de chaque commande sont disponibles dans le rapport détaillé #link("../rapports-detailles/utilisation-cli.pdf")[#underline("utilisation-cli.pdf")].

== Conclusion

Le démonstrateur est opérationnel : il expose via la commande `aifrb` l'ensemble des fonctionnalités nécessaires aux attaques, génération d'images et de vidéos via KIE AI et diffusion de contenu multi-média sur une caméra virtuelle. Le choix de Python sur Linux, combiné à `v4l2loopback` et `FFmpeg` garantit une intégration fluide et sans latence. Les chapitres suivants mettent ce démonstrateur à l'épreuve sur les cinq premiers sites cibles identifiés précédemment.

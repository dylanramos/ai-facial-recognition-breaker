#import "@preview/codelst:2.0.2": sourcecode

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Génération d'images et de vidéos IA

== Introduction

Pour qu'un attaquant puisse modifier la photo d'une personne sur un document d'identité ou générer une vidéo d'une personne effectuant une vérification d'identité, il doit utiliser des modèles de génération d'images et de vidéos IA.

Ainsi, la solution la plus simple pour utiliser ces différents modèles est de passer par un service d'API. Un service d'API est une plateforme qui regroupe les APIs des différents services de génération. Il met à disposition une API qui permet d'utiliser plusieurs modèles d'IA de manière centralisée et moins coûteuse que chez les fournisseurs directement.

#figure(
  rect(image("../images/03-generation-ia/service-api.png", width: 80%), stroke: 0.1pt),
  caption: "Architecture d'un service d'API.",
)

== Kie.ai

Le service d'API choisi est #link("https://kie.ai/")[#underline("Kie.ai")]. Il a été choisi pour sa large gamme de modèles, sa simplicité d'utilisation, sa documentation claire et son prix compétitif. De plus, il propose un "bac à sable" permettant de tester les APIs des modèles gratuitement et offre 80 crédits lors de l'inscription. C'est donc sur cette plateforme que vont se baser les chapitres suivants notamment pour les comparaisons de prix.

#figure(
  rect(image("../images/03-generation-ia/kie.png", width: 33%), stroke: 0.1pt),
  caption: "Catégories de modèles proposées par Kie.ai.",
)

Les catégories utiles à ce projet sont "Video Generation" et "Image Generation", mais la catégorie "Chat" reste intéressante si un générateur de prompt automatique vient à être nécessaire.

=== Exemple d'utilisation de l'API pour générer une vidéo <generate-video>

L'exemple de code ci-dessous montre comment générer une vidéo avec le modèle *kling 3.0*. La vidéo part d'une image de début et termine par une image de fin fournies en paramètre. À noter que la vidéo est générée de manière asynchrone, cela signifie que la requête retourne un `taskId` qui devra par la suite être utilisé pour vérifier l'état de la génération de la vidéo et récupérer le résultat une fois la vidéo générée.

#figure(
  sourcecode[```python
  # Source : https://kie.ai/kling-3-0
  def generate_video_kling(prompt: str, image_url: str) -> str:
      url = "https://api.kie.ai/api/v1/jobs/createTask"
      payload = {
          "model": "kling-3.0/video",
          "input": {
              "mode": "std",
              "image_urls": [
                  image_url,
                  image_url
              ],
              "sound": False,
              "duration": "3",
              "aspect_ratio": "9:16",
              "multi_shots": False,
              "prompt": prompt,
          }
      }

      response = requests.post(url, headers=HEADERS, json=payload)
      data = response.json()

      if data["code"] != 200:
          print(f"Failed to generate video: {data['msg']}")
          sys.exit(1)

      return data["data"]["taskId"]

  ```],
  caption: "Exemple de code pour générer une vidéo avec le modèle kling 3.0 sur Kie.ai.",
)

=== Exemple d'utilisation de l'API pour récupérer une vidéo générée

L'exemple de code ci-dessous montre comment récupérer une vidéo générée après avoir lancé la génération (voir #underline()[@generate-video]). Cette fonction utilise le polling pour vérifier l'état de la génération de la vidéo en envoyant des requêtes à intervalles croissants. Si la vidéo est générée avec succès, la fonction retourne l'URL de la vidéo.

#figure(
  sourcecode[```python
  # Source : https://docs.kie.ai/market/common/get-task-detail
  def get_video_url(task_id: str) -> str:
      url = "https://api.kie.ai/api/v1/jobs/recordInfo"
      params = { "taskId": task_id }
      start_time = time.time()
      max_duration = 15 * 60 # 15 minutes

      while True:
          elapsed_time = time.time() - start_time

          if elapsed_time > max_duration:
              print("Video generation timed out after 15 minutes.")
              sys.exit(1)

          response = requests.get(url, headers=HEADERS, params=params)
          data = response.json()

          if data["data"]["state"] == "success":
              result_json = json.loads(data["data"]["resultJson"])
              return result_json["resultUrls"][0]

          if data["data"]["state"] == "fail":
              print(f"Video generation failed: {data['data']['failMsg']}")
              sys.exit(1)

          # Recommended polling interval
          if elapsed_time < 30:
              wait = 3
          elif elapsed_time < 120:
              wait = 10
          else:
              wait = 30

          time.sleep(wait)
  ```],
  caption: "Exemple de code pour récupérer l'URL d'une vidéo générée sur Kie.ai.",
)

== Génération d'images

Les modèles de génération d'images doivent être capables de modifier des images existantes, par exemple, vieillir une personne, modifier une photo d'identité, etc. Il en existe deux catégories :
- Text-to-Image
- Image-to-Image

La catégorie utile pour ce projet est "Image-to-Image" car elle permet de modifier des parties d'une image existante, ce qui est très utile pour modifier une photo d'identité par exemple. Une explication détaillée de ces deux catégories est disponible dans le #link("../rapports-de-recherche/generation-ia/generation-ia.pdf")[#underline("chapitre 3 du rapport de recherche generation-ia.pdf")].

=== Modèles testés

Parmis les modèles testés il y a :
- Nano Banana 2
- GPT Image 1.5
- Seedream 4.5
- Grok Imagine
- Flux 2

=== Tests effectués

Lors des tests des modèles, l'objectif était de modifier un exemple de carte d'identité suisse trouvée sur internet en changeant :
- La photo d'identité par une autre photo.
- Le nom "de Maienfeld Muster" par "Teste".
- Le prénom "Lara Sample" par "Alice".
- La signature par une autre signature.

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Exemple de carte d'identité suisse utilisée pour les tests.",
  ),
  figure(
    rect(image("../images/03-generation-ia/face.jpg", width: 47%), stroke: 0.1pt),
    caption: "Nouvelle photo d'identité utilisée pour les tests.",
  ),
)

Le modèle qui semble le mieux fonctionner pour modifier une carte d'identité est *Nano Banana 2*. En effet, la modification de la carte d'identité est plutôt bien réussie, les éléments modifiés sont bien intégrés à l'image originale et les motifs de la carte sont conservés, notamment sur les photos. Par contre les petits triangles à la fin du nom et du prénom ont disparu.

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Carte d'identité originale.",
  ),
  figure(
    rect(image("../images/03-generation-ia/nano-banana.png"), stroke: 0.1pt),
    caption: "Résultat du modèle Nano Banana 2.",
  ),
)

À l'inverse, le modèle *Seedream 4.5* est plutôt mauvais. En effet, le texte est illisible et le format de l'image est mauvais. À noter que l'image n'a pas été modifiée car la version gratuite de Seedream 4.5 ne permet pas de déposer plusieurs images en même temps.

#grid(
  columns: (1fr, 1fr),
  inset: 3pt,
  figure(
    rect(image("../images/03-generation-ia/id-front.jpg"), stroke: 0.1pt),
    caption: "Carte d'identité originale.",
  ),
  figure(
    rect(image("../images/03-generation-ia/seedream.jpg"), stroke: 0.1pt),
    caption: "Résultat du modèle Seedream 4.5.",
  ),
)

Les résultats des autres modèles sont disponibles dans le #link("../rapports-de-recherche/generation-ia/generation-ia.pdf")[#underline("chapitre 3.3 du rapport de recherche generation-ia.pdf")].

=== Tableau comparatif des modèles

Le tableau ci-dessous présente les caractéristiques des différents modèles dans leur configuration maximale (meilleure qualité d'image possible).

#set par(justify: false)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: horizon + center,
    [*Modèle*], [*Résultat lors des tests*], [*Qualité de l'image*], [*Prix*],

    [*Nano Banana 2*], [Bon], [4k], [0.09\$],
    [*GPT Image 1.5*], [-], [4k], [0.11\$],
    [*Seedream 4.5*], [Mauvais], [4k], [0.0325\$],
    [*Grok Imagine*], [-], [2k], [0.02\$],
    [*Flux 2*], [Moyen], [2k], [0.12\$],
  ),
  caption: "Comparaison des modèles de type Image-to-Image en qualité maximale.",
)

#set par(justify: true)

== Génération de vidéos

Les modèles de génération de vidéos doivent permettre de générer des vidéos réalistes de personnes effectuant une vérification d'identité (regarder la caméra, tourner la tête, sourire, etc.), il en existe trois catégories :
- Text-to-Video
- Image-to-Video
- Video-to-Video

Les catégories utiles pour ce projet sont "Image-to-Video" et "Video-to-Video" car elles permettent de partir d'une image ou d'une vidéo existante pour générer une nouvelle vidéo, ce qui est très utile pour générer un selfie vidéo à partir de l'image d'une personne par exemple. Une explication détaillée de ces trois catégories est disponible dans le #link("../rapports-de-recherche/generation-ia/generation-ia.pdf")[#underline("chapitre 4 du rapport de recherche generation-ia.pdf")].

=== Modèles de type Image-to-Video

Parmi les modèles de type Image-to-Video il y a :

- Veo 3.1
- Sora 2
- Kling 3.0
- Wan 2.6
- Grok Imagine
- Hailuo 2.3

Le tableau ci-dessous présente les caractéristiques de ces modèles dans leur configuration maximale (meilleure qualité de vidéo possible, durée maximale, audio).

#figure(
  table(
    columns: (1fr, auto, auto, auto, auto),
    align: horizon + center,
    [*Modèle*], [*Temps de vidéo*], [*Qualité de la vidéo*], [*Audio*], [*Prix*],

    [*Veo 3.1*], [8s], [1080p], [Oui], [1.25\$],
    [*Sora 2*], [15s], [720p], [Oui], [0.20\$],
    [*Kling 3.0*], [15s], [1080p], [Oui], [3.00\$],
    [*Wan 2.6*], [15s], [1080p], [Oui], [1.575\$],
    [*Grok Imagine*], [15s], [720p], [Oui], [0.20\$],
    [*Hailuo 2.3*], [10s], [768p], [Non], [0.45\$],
  ),
  caption: "Comparaison des modèles de génération de vidéos en configuration maximale.",
)

Une description détaillée des critères de sélection des modèles est disponible dans le #link("../rapports-de-recherche/generation-ia/generation-ia.pdf")[#underline("chapitre 4.3 du rapport de recherche generation-ia.pdf")].

La génération d'une vidéo est malheureusement payante, il n'est donc pas possible pour le moment de tester les modèles pour générer des selfies vidéo par exemple. Néanmoins, un aperçu provenant de Kie.ai est disponible et montre ce que chaque modèle est capable de faire :

- Veo 3.1 : #underline()[#link("https://drive.proton.me/urls/3RJ1C3ZH84#OFC9m63b8dO2")]
- Sora 2 : #underline()[#link("https://drive.proton.me/urls/PNY07W2MBG#uw97Ssx5gdc4")]
- Kling 3.0 : #underline()[#link("https://drive.proton.me/urls/296EXVS94R#ilI14aY7rLkr")]
- Wan 2.6 : #underline()[#link("https://drive.proton.me/urls/F8FJMDYT3R#ieBukdTVVjZ4")]
- Grok Imagine : #underline()[#link("https://drive.proton.me/urls/RRHCDQCGCR#gCtg0GZ9lzP4")]
- Hailuo 2.3 : #underline()[#link("https://drive.proton.me/urls/J1S5922PTG#gGDrXOGqjHWB")]

=== Modèles de type Video-to-Video

Les modèles de type Video-to-Video (édition de vidéos) modifient une vidéo fournie en fonction du prompt et d'une image de référence. Ils sont particulièrement utiles car ils permettent d'enregistrer une vidéo au préalable puis de remplacer la vraie personne par une autre personne.

À ce jour, le seul modèle de type Video-to-Video disponible sur Kie.ai est *Kling 3.0 motion control*. Les prix sont les suivants :

- Pour une vidéo en 720p : *0.10\$ par seconde*.
- Pour une vidéo en 1080p : *0.135\$ par seconde*.

#import "@preview/codelst:2.0.2": sourcecode

// Paramètres globaux

#set page(margin: (top: 5cm, bottom: 4cm, left: 2.5cm, right: 2.5cm))
#set text(font: "New Computer Modern", size: 11pt, lang: "fr")

// Variables

#let author = "Dylan Oliveira Ramos"
#let professor = "Prof. Jean-Marc Bost"
#let title = "Génération d'images et de vidéos IA"
#let location_and_date = [Yverdon-les-Bains, le #datetime.today().display("[day].[month].[year]")]
#let academic_year = "2025-2026"

// Page de garde

#grid(
  columns: (1fr, 2fr),
  align: (left, right),
  image("images/logo-heig-vd.png", width: 3cm),
  [
    Département des Technologies de l'information et de la communication (TIC) \
    Filière Informatique et systèmes de communication \
    Orientation Sécurité informatique
  ],
)

#v(4cm)
#align(center, text(weight: "bold", size: 14pt)[Rapport de recherche])
#align(center, text(weight: "bold", size: 26pt)[#title])
#v(4cm)

#align(left, [#block(width: 70%, [
  #table(
    stroke: none,
    columns: (50%, 50%),
    [*Étudiant*], [*#author*],
    [*Enseignant responsable*], [#professor],
    [*Année académique*], [#academic_year],
  )
])])

#v(2cm)

#align(right, location_and_date)

#set page(
  margin: 2.5cm,
  header: context [
    #set text(size: 9pt)
    #let is_even = calc.even(counter(page).get().first())

    #if (is_even) {
      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        upper(title), line(length: 99%, stroke: 0.5pt),
      )
    } else {
      grid(
        columns: (1fr, auto),
        align: bottom,
        line(length: 99%, stroke: 0.5pt), author,
      )
    }
  ],
  footer: context [
    #set text(size: 9pt)
    #let selector = selector(heading).before(here())
    #let headings = query(selector)
    #let is_even = calc.even(counter(page).get().first())

    #if (is_even) {
      grid(
        columns: (auto, 1fr),
        align: bottom + right,
        counter(page).display(), line(length: 99%, stroke: 0.5pt),
      )
    } else {
      grid(
        columns: (1fr, auto),
        align: bottom,
        line(length: 99%, stroke: 0.5pt), counter(page).display(),
      )
    }
  ],
)
#set par(justify: true)

// Configuration des titres

#set heading(numbering: "1.1")
#show heading.where(level: 1): it => {
  set text(size: 17pt)
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
  v(0.2cm)
}
#show heading.where(level: 2): it => {
  set text(size: 14pt)
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
  v(0.1cm)
}
#show heading.where(level: 3): it => {
  block(counter(heading).display(it.numbering) + h(0.5cm) + it.body)
}

// Configuration des tableaux

#set table(
  fill: (x, y) => if x == 0 or y == 0 { silver },
)

= Introduction

Pour qu'un attaquant puisse modifier la photo d'une personne sur un document d'identité ou générer une vidéo d'une personne effectuant une vérification d'identité, il doit utiliser des modèles de génération d'images et de vidéos IA.

Ainsi, la solution la plus simple pour utiliser ces différents modèles est de passer par un service d'API. Un service d'API est une plateforme qui regroupe les APIs des différents services de génération. Il met à disposition une API qui permet d'utiliser plusieurs modèles d'IA de manière centralisée et moins coûteuse que chez les fournisseurs directement.

#figure(
  rect(image("images/service-api.png", width: 80%), stroke: 0.1pt),
  caption: "Architecture d'un service d'API.",
)

= Kie.ai

Le service d'API choisi est #link("https://kie.ai/")[#underline("Kie.ai")]. Il a été choisi pour sa large gamme de modèles, sa simplicité d'utilisation, sa documentation claire et son prix compétitif. De plus, il propose un "bac à sable" permettant de tester les APIs des modèles gratuitement et offre 80 crédits lors de l'inscription. C'est donc sur cette plateforme que vont se baser les chapitres suivants notamment pour les comparaisons de prix.

#figure(
  rect(image("images/kie.png", width: 40%), stroke: 0.1pt),
  caption: "Catégories de modèles proposées par Kie.ai.",
)

Les catégories utiles à ce projet sont "Video Generation" et "Image Generation", mais la catégorie "Chat" reste intéressante si un générateur de prompt automatique vient à être nécessaire.

== Exemple d'utilisation de l'API pour générer une vidéo <api-generation>

L'exemple de code ci-dessous montre comment générer une vidéo avec le modèle *kling 3.0*. La vidéo part d'une image de début et termine par une image de fin fournies en paramètre. À noter que la vidéo est générée de manière asynchrone, cela signifie que la requête retourne un `taskId` qui devra par la suite être utilisé pour vérifier l'état de la génération de la vidéo et récupérer le résultat une fois la vidéo générée.

#pagebreak()

#sourcecode[```python
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

```]

== Exemple d'utilisation de l'API pour récupérer une vidéo générée

L'exemple de code ci-dessous montre comment récupérer une vidéo générée après avoir lancé la génération (voir #underline()[@api-generation]). Cette fonction utilise le polling pour vérifier l'état de la génération de la vidéo en envoyant des requêtes à intervalles croissants. Si la vidéo est générée avec succès, la fonction retourne l'URL de la vidéo.

#pagebreak()

#sourcecode[```python
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
```]

= Génération d'images

Les modèles de génération d'images doivent être capables de générer des images réalistes de personnes fictives ainsi que de modifier des images existantes (vieillir une personne, modifier une photo d'identité, etc.). Il en existe deux catégories :
- Text-to-Image
- Image-to-Image

== Text-to-Image

Les modèles de type Text-to-Image analysent le prompt et créent eux-mêmes les visuels à partir de zéro. Ils sont utiles pour générer des images de personnes fictives mais ne sont pas adaptés pour modifier des images existantes.

== Image-to-Image

Les modèles de type Image-to-Image (édition d'images) partent d'une image fournie et la modifient en fonction du prompt. Ils sont utiles pour modifier des images existantes contrairement aux modèles de type Text-to-Image.

== Tableaux comparatifs des modèles

Les modèles de génération d'images proposent généralement une version Text-to-Image et une version Image-to-Image, les tableaux ci-dessous concernent donc les deux types de modèles et présentent la qualité minimale et maximale d'image que chaque modèle peut générer avec les prix correspondants.

*Qualité minimale*

#table(
  columns: (1fr, 1fr, 1fr),
  align: horizon + center,
  [*Modèle*], [*Qualité de l'image*], [*Prix*],

  [*Nano Banana 2*], [1k], [0.04\$],
  [*GPT Image 1.5*], [2k], [0.02\$],
  [*Seedream 4.5*], [4k], [0.0325\$],
  [*Grok Imagine*], [2k], [0.02\$],
  [*Flux 2*], [1k], [0.07\$],
)

*Qualité maximale*

#table(
  columns: (1fr, 1fr, 1fr),
  align: horizon + center,
  [*Modèle*], [*Qualité de l'image*], [*Prix*],

  [*Nano Banana 2*], [4k], [0.09\$],
  [*GPT Image 1.5*], [4k], [0.11\$],
  [*Seedream 4.5*], [4k], [0.0325\$],
  [*Grok Imagine*], [2k], [0.02\$],
  [*Flux 2*], [2k], [0.12\$],
)

= Génération de vidéos

Les modèles de génération de vidéos doivent permettre de générer des vidéos réalistes de personnes effectuant une vérification d'identité (regarder la caméra, tourner la tête, sourire, etc.), il en existe trois catégories :
- Text-to-Video
- Image-to-Video
- Video-to-Video

== Text-to-Video et Image-to-Video

Les modèles de type Text-to-Video analysent le prompt et créent eux-mêmes les visuels et les mouvements à partir de zéro. Cela leur laisse beaucoup de créativité mais rend plus difficile le contrôle du résultat final, ce qui peut être problématique pour la vérification d'identité.

Les modèles de type Image-to-Video prennent généralement une image de début et une image de fin puis génèrent la séquence demandée dans le prompt. Ce type de modèle est plus contrôlable visuellement et est plus adapté à la vérification d'identité car il permet de faire correspondre le visage de la personne dans la vidéo avec celui sur les documents d'identité.

Comme pour les modèles de génération d'images, les modèles de génération de vidéos proposent généralement une version Text-to-Video et une version Image-to-Video avec les mêmes paramètres et les mêmes prix. C'est pourquoi les tableaux du #underline()[@comparaison-videos] ne font pas de distinction entre ces deux types.

=== Critères de sélection des modèles

Plusieurs modèles de génération de vidéos ont été analysés, les critères de séléction sont les suivants :

+ *Temps de vidéo* : la vidéo générée doit être suffisament longue pour que la vérification de l'identité puisse se faire.
+ *Qualité de la vidéo* : la qualité de la vidéo doit être assez bonne pour tromper les systèmes de reconnaissance faciale.
+ *Audio* : la possibilité d'ajouter de l'audio est un plus.

=== Tableaux comparatif des modèles <comparaison-videos>

Les tableaux ci-dessous comparent les prix de chaque modèle dans leur configuration minimale (moins bonne qualité, plus courte durée, etc.) et maximale (meilleure qualité, durée plus longue, etc.).

*Prix minimum*

#table(
  columns: (1fr, auto, auto, auto, auto),
  align: horizon + center,
  [*Modèle*], [*Temps de vidéo*], [*Qualité de la vidéo*], [*Audio*], [*Prix*],

  [*Veo 3.1*], [8s], [1080p], [Oui], [0.30\$],
  [*Sora 2*], [10s], [720p], [Oui], [0.175\$],
  [*Kling 3.0*], [3s], [720p], [Non], [0.10\$],
  [*Wan 2.6*], [5s], [720p], [Oui], [0.35\$],
  [*Grok Imagine*], [6s], [480p], [Oui], [0.05\$],
  [*Hailuo 2.3*], [6s], [768p], [Non], [0.15\$],
)

*Prix maximum*

#table(
  columns: (1fr, auto, auto, auto, auto),
  align: horizon + center,
  [*Modèle*], [*Temps de vidéo*], [*Qualité de la vidéo*], [*Audio*], [*Prix*],

  [*Veo 3.1*], [8s], [1080p], [Oui], [1.25\$],
  [*Sora 2*], [15s], [720p], [Oui], [0.20\$],
  [*Kling 3.0*], [15s], [1080p], [Oui], [3.00\$],
  [*Wan 2.6*], [15s], [1080p], [Oui], [1.575\$],
  [*Grok Imagine*], [15s], [720p], [Oui], [0.20\$],
  [*Hailuo 2.3*], [10s], [768p], [Non], [0.45\$],
)

== Video-to-Video

Les modèles de type Video-to-Video (édition de vidéos) modifient une vidéo fournie en fonction du prompt et d'une image de référence. Ils sont particulièrement utiles car ils permettent d'enregistrer une vidéo au préalable puis de remplacer la vraie personne par une autre personne.

À ce jour, le seul modèle de type Video-to-Video disponible sur Kie.ai est *Kling 3.0 motion control*. Les prix sont les suivants :

- Pour une vidéo en 720p : *0.10\$ par seconde*.
- Pour une vidéo en 1080p : *0.135\$ par seconde*.

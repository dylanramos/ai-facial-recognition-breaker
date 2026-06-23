#let language = "fr"

#let studentFirstname = "Dylan"
#let studentLastname = "Oliveira Ramos"

// Use feminine or masculine form in template's text. Example: "La soussignée" or "Le soussigné"
#let TBfeminineForm = false // for the author
#let TBsupervisorFeminineForm = false // same, but for the supervisor. Example: "Enseignante responsable"

#let confidential = false

#let TBtitle = "Contourner la vérification d'identité en ligne à l'aide de l'intelligence artificielle"
#let TBsubtitle = ""
#let TByear = "2026"
#let TBacademicYears = "2025-2026"

#let TBdpt = "Département des Technologies de l'information et de la communication (TIC)"
#let TBfiliere = "Filière Informatique et systèmes de communication"
#let TBorient = "Orientation Sécurité informatique"

#let TBauthor = studentFirstname + " " + studentLastname
#let TBsupervisor = "Prof. Jean-Marc Bost"
#let TBindustryContact = ""
#let TBindustryName = ""
#let TBindustryAddress = [
]

#let TBresumePubliable = [
L'intelligence artificielle permet aujourd'hui de facilement générer des contenus multimédia réalistes. Photos, vidéos ou encore voix, les possibilités sont nombreuses et les outils de génération sont de plus en plus accessibles au grand public. Évidemment, cette démocratisation n'est pas sans risques, ces contenus peuvent être utilisés à des fins malveillantes, falsification de documents, usurpation d'identité ou encore désinformation, la nécessité de comprendre les risques liés à ces technologies est plus que jamais d'actualité. C'est notamment le cas pour les sites en ligne, qui utilisent des systèmes de vérification d'identité basés sur la reconnaissance faciale pour vérifier qu'une personne est bien celle qu'elle prétend être.

Parmi les cinq sites demandant une vérification d'identité par selfie vidéo analysés en profondeur, deux se sont révélés vulnérables. Tea for Women, dont l'objectif est de protéger les femmes dans le monde des rencontres en ligne, s'est avéré vulnérable à l'utilisation d'une vidéo IA lors de la création d'un compte. Roblox, une plateforme de jeux en ligne très populaire auprès des enfants, a également été contournée avec des images IA lors d'une vérification d'âge pour accéder à des fonctionnalités de chat destinées aux adultes.

Ce travail a montré que la robustesse d'un système de vérification d'identité dépend de deux facteurs indépendants : la qualité de la solution tierce utilisée et la rigueur de son intégration et de sa maintenance. D'autre part, il a également montré que les outils de génération IA sont aujourd'hui accessibles à faible coût via des plateformes agrégées comme KIE AI, ce qui abaisse considérablement la barrière à l'entrée pour un attaquant potentiel. La question n'est donc plus de savoir si ce type d'attaque est techniquement faisable, mais de savoir dans quelle mesure les systèmes de vérification en place sont à jour et correctement configurés.
]
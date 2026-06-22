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
Ce travail analyse en profondeur cinq sites demandant une vérification d'identité par selfie vidéo, à savoir Facebook, Tea for Women, Roblox, Parship et Google. Des attaques concrètes ont été menées sur ceux-ci à l'aide d'un outil Python développé qui génère du contenu IA via la plateforme KIE AI et l'injecte dans une caméra virtuelle Linux.

Parmi les cinq sites, deux se sont révélés vulnérables. Tea for Women, dont l'objectif est de protéger les femmes dans le monde des rencontres en ligne, s'est avéré vulnérable à l'utilisation d'une vidéo IA lors de la création d'un compte. Roblox, une plateforme de jeux en ligne très populaire auprès des enfants, a également été contournée avec des images IA lors d'une vérification d'âge pour accéder à des fonctionnalités de chat destinées aux adultes.

Facebook, Parship et Google ont en revanche résisté à toutes les tentatives grâce à des mécanismes multicouches, notamment la détection de contenus multimédia synthétiques, la détection d'appareils virtuels et l'analyse comportementale.

Ces résultats montrent que la robustesse d'un système dépend autant de la qualité de la solution tierce que de la rigueur de sa maintenance. Les outils de génération IA étant désormais accessibles à faible coût, la question n'est plus de savoir si ces attaques sont techniquement faisables, mais si les systèmes en place sont suffisamment à jour pour y résister.
]
#show outline.entry.where(level: 1): it => [
  #strong(it)
  #v(0.5cm)
]
#show outline.entry.where(level: 2): it => [
  #v(-0.2cm)
  #it
  #v(0.3cm)
]
#show outline.entry.where(level: 3): it => [
  #v(-0.2cm)
  #it
  #v(0.3cm)
]
#set outline.entry(fill: line(length: 100%, stroke: 0.5pt))

#outline(title: "Table des matières")

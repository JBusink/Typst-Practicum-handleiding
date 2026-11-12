#import "template.typ": professional-development, invulveld, rubriektabel

#show: professional-development.with(
  titel: "Rubriek - titel van de opdracht",
  documenttype: "Beoordelingsformulier",
  liggend: true,
  tekstgrootte: 9pt,
  marges: 15mm,
)

#grid(columns: (1fr, 1fr, 1fr), gutter: 3mm,
  invulveld("Student / studentnummer:"),
  invulveld("Beoordelaar:"),
  invulveld("Datum:"),
)
#v(3mm)
*Gebruik:* vervang de voorbeeldcriteria en niveaubeschrijvingen door de
criteria van de opdracht. Vul vooraf de scoreschaal, eventuele weging en
berekening van het eindcijfer in.

#rubriektabel(
  [*Criterium 1*],
  [Beschrijf concreet waaraan een goede prestatie voldoet.],
  [Beschrijf de minimaal voldoende prestatie.],
  [Beschrijf wat ontbreekt of onjuist is.],
  [Score: ........],
  [*Criterium 2*],
  [Beschrijf concreet waaraan een goede prestatie voldoet.],
  [Beschrijf de minimaal voldoende prestatie.],
  [Beschrijf wat ontbreekt of onjuist is.],
  [Score: ........],
)
#v(4mm)
#grid(columns: (1fr, 1fr), gutter: 3mm,
  invulveld("Sterk punt (met voorbeeld):", hoogte: 20mm),
  invulveld("Belangrijkste verbeteractie:", hoogte: 20mm),
)

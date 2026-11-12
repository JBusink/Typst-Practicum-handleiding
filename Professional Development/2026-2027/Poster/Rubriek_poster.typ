#import "../../Template Professional Development/template.typ": professional-development, kader, invulveld

#show: professional-development.with(
  titel: "Rubriek Wetenschappelijke Poster",
  documenttype: "Beoordelingsformulier",
  liggend: true,
  tekstgrootte: 9pt,
)

#let checkbox = box(
  width: 9pt,
  height: 9pt,
  stroke: 0.7pt,
)

#let opties(items) = {
  for item in items {
    grid(
      columns: (11pt, 1fr),
      column-gutter: 3pt,
      checkbox,
      item,
    )
    v(1.5pt)
  }
}

*Naam student:* #box(width: 8cm, line(length: 100%, stroke: 0.5pt))

#v(5mm)

#table(
  columns: (3.3fr, 2.6fr, 2.6fr, 2.4fr, 0.8fr),

  table.header(
    [*Onderdeel*],
    [*Uitstekend*],
    [*Voldoende*],
    [*Onvoldoende*],
    [*Score*],
  ),

  // Inhoud
  [
    *Inhoud (30%)*

    - Alle belangrijke concepten en resultaten aanwezig
    - Doel stage duidelijk
    - Conclusie, discussie en aanbevelingen duidelijk
    - Relevante achtergrond en context van het onderzoek
    - Resultaten correct en volledig weergegeven
  ],
  [
    #opties((
      [Concepten volledig en correct],
      [Doel stage helder],
      [Conclusie, discussie en aanbevelingen duidelijk],
      [Achtergrond helder en relevant],
      [Resultaten volledig en correct],
    ))
  ],
  [
    #opties((
      [Meeste concepten aanwezig],
      [Doel stage grotendeels duidelijk],
      [Conclusie/discussie deels duidelijk],
      [Achtergrond deels relevant],
      [Belangrijkste resultaten aanwezig],
    ))
  ],
  [
    #opties((
      [Concepten incompleet of fout],
      [Doel stage onduidelijk],
      [Conclusie/discussie ontbreekt of fout],
      [Achtergrond ontbreekt of irrelevant],
      [Resultaten incompleet of fout],
    ))
  ],
  [],

  // Structuur
  [
    *Structuur (20%)*

    - Logische indeling van secties
    - Hoofdpunten zijn te volgen
    - Overgangen vloeiend
  ],
  [
    #opties((
      [Logische opbouw],
      [Hoofdpunten duidelijk],
      [Vloeiende overgangen],
    ))
  ],
  [
    #opties((
      [Opbouw grotendeels logisch],
      [Hoofdpunten redelijk duidelijk],
      [Overgangen soms abrupt],
    ))
  ],
  [
    #opties((
      [Opbouw chaotisch],
      [Hoofdpunten onduidelijk],
      [Overgangen ontbreken],
    ))
  ],
  [],

  // Vormgeving
  [
    *Vormgeving (20%)*

    - Lay-out en consistentie
    - Tekst en leesbaarheid
    - Visuals en labels
    - Kleurgebruik en stijl
  ],
  [
    #opties((
      [Lay-out aantrekkelijk],
      [Tekst goed leesbaar],
      [Visuals duidelijk en correct, met eenheden, onderschriften en figuurnummers],
      [Kleurgebruik ondersteunt boodschap],
    ))
  ],
  [
    #opties((
      [Lay-out redelijk consistent],
      [Tekst soms te klein/te lang],
      [Meeste visuals duidelijk],
      [Kleuren soms storend],
    ))
  ],
  [
    #opties((
      [Lay-out rommelig],
      [Tekst slecht leesbaar],
      [Visuals fout/onzorgvuldig],
      [Kleuren belemmeren leesbaarheid],
    ))
  ],
  [],

  // Visuals en datavisualisatie
  [
    *Visuals & datavisualisatie (30%)*

    - Grafieken en figuren duidelijk gelabeld (met eenheden, onderschriften, figuurnummers)
    - Data overzichtelijk gepresenteerd
    - Visuals versterken boodschap
    - Juiste keuze in dataweergave en kwaliteit van de visualisatie
  ],
  [
    #opties((
      [Grafieken duidelijk en correct gelabeld],
      [Data overzichtelijk gepresenteerd],
      [Visuals versterken boodschap],
      [Juiste keuze en hoge kwaliteit visualisatie],
    ))
  ],
  [
    #opties((
      [Meeste grafieken duidelijk],
      [Data meestal overzichtelijk],
      [Visuals ondersteunen deels],
      [Visualisatiekeuze redelijk],
    ))
  ],
  [
    #opties((
      [Grafieken onduidelijk/fout],
      [Data onoverzichtelijk],
      [Visuals dragen niet bij],
      [Slechte keuze visualisatie],
    ))
  ],
  [],

  // Bonus
  [*Crea Bea bonus*],
  [#checkbox #h(4pt) +0],
  [#checkbox #h(4pt) +0,25],
  [#checkbox #h(4pt) +0,5],
  [],

  // Totaalscore
  [*Totaalscore*],
  table.cell(
    colspan: 4,
    [#box(
      width: 3cm,
      height: 1cm,
      stroke: 0.5pt,
    )],
  ),
)

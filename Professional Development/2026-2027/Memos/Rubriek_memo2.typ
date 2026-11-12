#import "../../Template Professional Development/template.typ": professional-development, kader, invulveld

#show: professional-development.with(
  titel: "Rubriek Memo 2",
  documenttype: "Beoordelingsformulier",
  liggend: true,
  tekstgrootte: 9pt,
  toon-header: false,
  titelruimte: 1mm,
  // lettertype: ("New Computer Modern", "Libertinus Serif"),
  opleiding: "Technische Natuurkunde",
  studiejaar: "2026-2027",
)

// Open invullijnen in plaats van omlijnde formuliervakken.
#let invullijn(label, hoogte: 10mm) = block(width: 100%, height: hoogte)[
  #text(size: 9pt, weight: "bold", label)
  #v(1fr)
  #line(length: 100%, stroke: 0.35pt + black)
]

#grid(columns: (1.5fr, 1fr, 1fr), gutter: 3mm,
  invullijn("Student / studentnummer:"),
  invullijn("Beoordelaar:"),
  invullijn("Datum:"),
)
// #v(2mm)
*Werkwijze:* geef per onderdeel een score van 1 tot 10. De niveaubeschrijvingen
ondersteunen de keuze; noteer onderaan concrete feedback. Elk onderdeel weegt
20%. Het eindcijfer is het gemiddelde van de vijf scores.
#v(1mm)

#table(
  columns: (24%, 22%, 22%, 22%, 10%),
  inset: (x: 7pt, y: 6pt),
  stroke: none,
  table.hline(y: 0, stroke: 0.8pt + black),
  table.hline(y: 1, stroke: 0.5pt + black),
  table.hline(y: 2, stroke: 0.3pt + black),
  table.hline(y: 3, stroke: 0.3pt + black),
  table.hline(y: 4, stroke: 0.3pt + black),
  table.hline(y: 5, stroke: 0.3pt + black),
  table.hline(y: 6, stroke: 0.8pt + black),

  table.header(
    [*Onderdeel*],
    [*Goed (8–10)*],
    [*Voldoende (6–7)*],
    [*Onvoldoende (1–5)*],
    [*Score*],
  ),

  // Voortgang en resultaten
  [
    *1. Voortgang en resultaten*

    #text(size: 8.5pt, style: "italic")[Weging: 20%]

    Voortgang; volledigheid van resultaten; onderbouwing van analyses; logische toelichting.
  ],
  [
    De memo geeft een volledig beeld van de voortgang binnen de stage. De resultaten zijn helder en volledig uitgewerkt, de analyses goed onderbouwd en correct uitgevoerd, en de toelichting is duidelijk en logisch opgebouwd.
  ],
  [
    De memo beschrijft de voortgang globaal. De resultaten zijn grotendeels duidelijk maar missen enkele details, de analyses zijn deels onderbouwd en niet overal correct, en de toelichting is wisselend gestructureerd.
  ],
  [
    De memo laat nauwelijks voortgang zien. De resultaten zijn onvolledig of onduidelijk, de analyses ontbreken of zijn foutief, en de toelichting is onsamenhangend of afwezig.
  ],
  table.cell(align: center + horizon)[........ / 10],

  // Discussie en volgende stappen
  [
    *2. Discussie en volgende stappen*

    #text(size: 8.5pt, style: "italic")[Weging: 20%]

    Interpretatie; relatie met stagedoel; inzichten en beperkingen; conclusies; haalbare vervolgstappen.
  ],
  [
    Resultaten helder en goed gekoppeld aan stagedoel. Inzichten en beperkingen benoemd, conclusies logisch, vervolgstappen concreet en haalbaar.
  ],
  [
    Resultaten deels helder, verband met stagedoel wisselend duidelijk. Enkele inzichten en beperkingen genoemd, conclusies grotendeels logisch, vervolgstappen globaal.
  ],
  [
    Resultaten onduidelijk, verband met stagedoel ontbreekt. Inzichten en beperkingen niet genoemd, conclusies onlogisch, vervolgstappen ontbreken of onhaalbaar.
  ],
  table.cell(align: center + horizon)[........ / 10],

  // Schematische tekening en toelichting
  [
    *3. Schematische tekening en toelichting*

    #text(size: 8.5pt, style: "italic")[Weging: 20%]

    Digitale en representatieve schets; begrijpelijke toelichting en onderschrift; uitvoering en beperkingen.
  ],
  [
    Schets is volledig, duidelijk en professioneel. Weergave van de opstelling klopt, toelichting en onderschrift zijn helder, beperkingen benoemd.
  ],
  [
    Schets is grotendeels duidelijk en professioneel, met enkele ontbrekende of onduidelijke elementen. Weergave herkenbaar, toelichting grotendeels begrijpelijk, enkele opmerkingen over beperkingen.
  ],
  [
    Schets is onduidelijk, incompleet of niet professioneel. Weergave klopt niet, toelichting ontbreekt of is onduidelijk, beperkingen niet genoemd.
  ],
  table.cell(align: center + horizon)[........ / 10],

  // Opmaak figuren
  [
    *4. Opmaak figuren*

    #text(size: 8.5pt, style: "italic")[Weging: 20%]

    Nummering, labels en onderschriften; relevante selectie; ondersteuning van de interpretatie.
  ],
  [
    Figuren zijn professioneel opgemaakt met correcte nummering, labels en onderschriften. De gekozen figuren zijn relevant en beknopt, zonder overbodige data. Ze ondersteunen de interpretatie van de resultaten volledig.
  ],
  [
    Figuren zijn redelijk opgemaakt maar missen soms duidelijke labels, onderschriften of consistente nummering. Er zijn enkele overbodige of minder relevante figuren opgenomen. Ze ondersteunen de interpretatie deels.
  ],
  [
    Figuren zijn slordig of onvolledig opgemaakt, zonder duidelijke labels, onderschriften of structuur. Er is overbodige of irrelevante data opgenomen en de interpretatie wordt nauwelijks ondersteund.
  ],
  table.cell(align: center + horizon)[........ / 10],

  // Algemeen
  [
    *5. Algemene criteria*

    #text(size: 8.5pt, style: "italic")[Weging: 20%]

    Maximaal 4 A4; taal en lay-out; op tijd; geen plagiaat; verwijzingen naar bronnen.
  ],
  [
    Verslag voldoet volledig aan de algemene eisen. Correcte taal, nette lay-out, op tijd ingeleverd, correcte referenties.
  ],
  [
    Verslag voldoet grotendeels aan de eisen. Kleine fouten of inconsistenties in taal, lay-out of referenties.
  ],
  [
    Verslag voldoet niet aan de algemene eisen. Veel fouten, slechte lay-out, ontbreken van referenties of plagiaat.
  ],
  table.cell(align: center + horizon)[........ / 10],
)

#v(3mm)
#grid(columns: (1fr, 1fr, 0.7fr), gutter: 3mm,
  invullijn("Sterke punten (met voorbeeld):", hoogte: 12mm),
  invullijn("Belangrijkste verbeteractie:", hoogte: 12mm),
  invullijn("Eindcijfer: totaal scores / 5", hoogte: 12mm),
)

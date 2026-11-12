#import "../../Template Professional Development/template.typ": professional-development, kader, invulveld

#show: professional-development.with(
  titel: "Rubriek Memo 1",
  documenttype: "Beoordelingsformulier",
  liggend: true,
  tekstgrootte: 9pt,
)

#table(
  columns: (3.5fr, 2.5fr, 2.5fr, 2.5fr, 0.7fr),

  table.header(
    [*Onderdeel*],
    [*Goed (8–10)*],
    [*Voldoende (6–7)*],
    [*Onvoldoende (1–5)*],
    [*Score*],
  ),

  // Introductie
  [
    *Introductie*

    - Is de context helder beschreven?
    - Is het werkingsprincipe helder beschreven?
    - Is duidelijk wat de enabling technology oplevert en welke uitdagingen er zijn?
  ],
  [
    Introductie is volledig en helder beschreven. Werkingsprincipe en technologie-uitdagingen zijn duidelijk en goed uitgelegd.
  ],
  [
    Introductie is grotendeels duidelijk, maar mist enkele details of toelichting.
  ],
  [
    Introductie is onduidelijk of onvolledig. Context en werkingsprincipe zijn niet duidelijk.
  ],
  [],

  // Doel
  [
    *Doel*

    - Is het doel van de stage duidelijk?
    - Is het doel goed afgebakend?
    - Is de rol van de student helder?
  ],
  [
    Doel is duidelijk geformuleerd en goed afgebakend. Rol van de student is helder.
  ],
  [
    Doel is grotendeels duidelijk, maar afbakening of rol is beperkt uitgelegd.
  ],
  [
    Doel is onduidelijk of slecht afgebakend. Rol van de student ontbreekt.
  ],
  [],

  // Planning, overdracht en labjournaal
  [
    *Planning, overdracht en labjournaal*

    - Is de planning helder? Kan er beoordeeld worden of er geen stappen missen?
    - Is er een verantwoording van data- en werkbeheer opgenomen (opslag, versiebeheer, overdraagbaarheid)?
    - Wordt er beschreven hoe experimenten worden vastgelegd in een (digitaal) labjournaal?
    - Is duidelijk hoe de werkzaamheden en resultaten overdraagbaar zijn voor de vakgroep?
  ],
  [
    Planning is volledig en overzichtelijk. Er is een duidelijke verantwoording hoe data en werkzaamheden worden opgeslagen en gedeeld (bijv. via OneNote, Overleaf, GitHub, Drive). Alle experimenten zijn gedocumenteerd in een labjournaal. Er is een goed plan voor overdracht naar de vakgroep.
  ],
  [
    Planning is grotendeels duidelijk, maar de verantwoording van data/werkbeheer of het gebruik van een labjournaal/overdracht is beperkt uitgewerkt.
  ],
  [
    Planning is onduidelijk, incompleet of bevat geen verantwoording van data- en werkbeheer. Labjournaal en overdracht ontbreken.
  ],
  [],

  // Opstelling en eerste resultaten
  [
    *Opstelling en eerste resultaten*

    - Kan de opstelling of het experiment begrepen worden uit de schets?
    - Wordt de opstelling duidelijk beschreven?
    - Is de beschrijving volledig en zonder onnodige details?
    - Zijn de eerste resultaten helder beschreven en passend bij de opstelling?
  ],
  [
    Opstelling is volledig en duidelijk beschreven, met schets en tekst. Eerste resultaten zijn helder en correct weergegeven.
  ],
  [
    Opstelling en resultaten zijn grotendeels duidelijk, maar missen enkele details of toelichting.
  ],
  [
    Opstelling en resultaten zijn onduidelijk of incompleet. Essentiële informatie ontbreekt.
  ],
  [],

  // Algemene criteria
  [
    *Algemeen*

    - Lengte: niet meer dan 4 A4
    - Grammaticaal en taalkundig correct
    - Nette en overzichtelijke lay-out
    - Op tijd ingeleverd
    - Geen plagiaat
    - Referenties naar gebruikte bronnen
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
  [],
)

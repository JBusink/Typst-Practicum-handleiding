#import "../../../Template Professional Development/template.typ": professional-development, kader, invulveld

#show: professional-development.with(
  titel: "Rubriek Presentatie 1",
  documenttype: "Beoordelingsformulier",
  subtitel: "Week 5 · context, doel en meetopstelling · ongeveer 8 minuten",
  liggend: true,
  tekstgrootte: 9pt,
)

#grid(columns: (1fr, 1fr, 1fr), gutter: 3mm,
  invulveld("Student / studentnummer:"), invulveld("Beoordelaar:"), invulveld("Datum / stageproject:"))
#v(3mm)
*Gebruik:* noteer per onderdeel een score van 1 tot 10, volgens dezelfde
niveaus als bij de memo's. Onderbouw je keuze met een observatie. Gebruik N/B
als beoordeling niet mogelijk was en licht dat toe. De weging en berekening
van een eindcijfer worden nog vastgesteld; bereken daarom nog geen totaalscore. Beoordeel inzicht en aanpak passend bij week 5; eindresultaten zijn nog niet vereist.

#table(
  columns: (1.6fr, 2.1fr, 2.1fr, 2.1fr, 1fr),
  inset: 5pt, stroke: 0.5pt, align: left + top,
  table.header([*Onderdeel*], [*Goed (8–10)*], [*Voldoende (6–7)*],
    [*Onvoldoende (1–5)*], [*Score*]),
  [*1. Context en werkingsprincipe*

Probleem en relevantie helder? Benodigde theorie correct?],
  [Context en relevantie zijn scherp uitgelegd. Het werkingsprincipe is correct en begrijpelijk gekoppeld aan het stageprobleem.],
  [Context, relevantie en het belangrijkste werkingsprincipe zijn grotendeels correct en begrijpelijk toegelicht.],
  [Context of relevantie blijft onduidelijk. Essentiële theorie ontbreekt of bevat wezenlijke fouten.],
  [Score: ............\ Observatie:\ \ ],
  [*2. Doel en aanpak*

Doel concreet? Eigen bijdrage en vervolgstappen duidelijk?],
  [Doel is concreet en afgebakend; eigen bijdrage en beoogde opbrengst zijn helder. Aanpak en succescriteria zijn passend en haalbaar.],
  [Doel, eigen bijdrage en beoogde opbrengst zijn herkenbaar. De aanpak en eerstvolgende stappen zijn grotendeels logisch.],
  [Doel is onduidelijk of onvoldoende afgebakend. Eigen bijdrage of aanpak ontbreekt; vervolgstappen sluiten niet aan.],
  [Score: ............\ Observatie:\ \ ],
  [*3. Meetopstelling en visual*

Wat wordt ingesteld en gemeten? Schema leesbaar? Koppeling met doel?],
  [Leesbare, correcte visual maakt de meetketen inzichtelijk. Keuzes en meetprincipe zijn onderbouwd; relevante beperkingen en ontwerpstatus zijn duidelijk.],
  [Opstelling en meetprincipe zijn begrijpelijk en passen bij het doel. Onderdelen, meetpunten, labels en onderschrift zijn grotendeels duidelijk. Ontwerpstatus is benoemd.],
  [Opstelling of meetprincipe is onduidelijk of onjuist. Visual mist essentiële informatie; de relatie met het doel of de ontwerpstatus blijft onduidelijk.],
  [Score: ............\ Observatie:\ \ ],
  [*4. Voorbereiding en verhaallijn*

Logische opbouw? Publiek meegenomen? Ongeveer 8 minuten?],
  [Goed geoefend, samenhangend verhaal van context via doel naar meting. Begrippen worden helder uitgelegd; visuals en tijd worden doelgericht benut.],
  [Verhaal is logisch te volgen, belangrijke begrippen worden uitgelegd en visuals ondersteunen de uitleg. Voorbereid en ongeveer 8 minuten.],
  [Verhaal is moeilijk te volgen of onvoldoende voorbereid. Begrippen blijven onduidelijk; visuals of tijd worden onvoldoende benut.],
  [Score: ............\ Observatie:\ \ ],
  [*5. Kritische vragen*

Antwoorden correct? Keuzes onderbouwd? Grenzen herkend?],
  [Antwoorden zijn correct en inhoudelijk onderbouwd. Benoemt aannames en grenzen en geeft aan hoe open vragen onderzocht kunnen worden.],
  [Beantwoordt de belangrijkste vragen correct en licht keuzes toe. Herkent wat nog onbekend is en benoemt een passende vervolgstap.],
  [Essentiële vragen worden onjuist of onvoldoende beantwoord. Keuzes kunnen niet worden toegelicht; grenzen van kennis blijven onbenoemd.],
  [Score: ............\ Observatie:\ \ ],
)
#v(3mm)
#grid(columns: (1fr, 1fr), gutter: 3mm,
  invulveld("Sterk punt (met voorbeeld):", hoogte: 12mm),
  invulveld("Belangrijkste verbeteractie:", hoogte: 12mm))
#v(3mm)
#grid(columns: (2fr, 1fr), gutter: 3mm,
  invulveld("Gestelde kritische vraag en kern van het antwoord:", hoogte: 12mm),
  invulveld("Eindoordeel / vervolgafspraak:", hoogte: 12mm))

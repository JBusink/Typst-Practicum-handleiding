// Printbare invulrubriek. Dit zijn nog geen interactieve PDF-formuliervelden.
#set document(title: "Rubriek Presentatie 2")
#set page(paper: "a4", flipped: true, margin: 15mm)
#set text(font: ("Arial", "Liberation Sans"), size: 8.5pt, lang: "nl")
#set par(leading: 0.5em)
#set heading(numbering: none)
#let veld(label, hoogte: 10mm) = block(width: 100%, height: hoogte,
  inset: 5pt, stroke: 0.4pt + luma(60%))[*#label*]

#text(size: 18pt, weight: "bold")[Rubriek Presentatie 2]
\ Stageproject in één figuur · pitch van ongeveer 5 minuten
#v(3mm)
#grid(columns: (1fr, 1fr, 1fr), gutter: 3mm,
  veld("Student / studentnummer:"), veld("Beoordelaar:"), veld("Datum / stageproject:"))
#v(3mm)
*Gebruik:* noteer per onderdeel een score van 1 tot 10, volgens dezelfde
niveaus als bij de memo's. Onderbouw je keuze met een observatie. Gebruik N/B
als beoordeling niet mogelijk was en licht dat toe. De weging en berekening
van een eindcijfer worden nog vastgesteld; bereken daarom nog geen totaalscore.

#table(
  columns: (1.6fr, 2.1fr, 2.1fr, 2.1fr, 1fr),
  inset: 5pt,
  stroke: 0.5pt,
  align: left + top,
  table.hline(stroke: 0.8pt),
  table.header([*Onderdeel*], [*Goed (8–10)*], [*Voldoende (6–7)*],
    [*Onvoldoende (1–5)*], [*Score*]),
  table.hline(stroke: 0.5pt),
  [*1. Voorbereiding en verhaallijn*

    Onderzoeksvraag en kernboodschap helder? Logische opbouw? Voorbereid en binnen de tijd?],
  [Doelgerichte, goed geoefende pitch met duidelijke samenhang tussen vraag,
    opstelling en meting. Uitleg sluit aan bij het publiek en benut de tijd effectief.],
  [Onderzoeksvraag en kernboodschap zijn herkenbaar. Uitleg volgt een logische
    lijn en gebruikt de figuur. De pitch duurt ongeveer 5 minuten.],
  [Onderzoeksvraag of kernboodschap ontbreekt. Uitleg is moeilijk te volgen;
    de figuur wordt nauwelijks gebruikt. Voorbereiding of tijdsbewaking schiet tekort.],
  [Score: ............\ Observatie:\ \ \ ],
  table.hline(stroke: 0.3pt + luma(70%)),
  [*2. Kwaliteit visual*

    Opstelling correct en begrijpelijk? Onderdelen en meetpunten herkenbaar? Labels en eenheden leesbaar?],
  [De visual maakt de werking en meetketen direct inzichtelijk. Selectie van
    details, labels, pijlen en contrast ondersteunt de kernboodschap zonder ruis.],
  [De opstelling is inhoudelijk correct en leesbaar. Belangrijkste onderdelen,
    verbindingen en meetpunten zijn aangegeven; labels en relevante eenheden ondersteunen de uitleg.],
  [De opstelling is onjuist, onvolledig of slecht leesbaar. Belangrijke
    onderdelen, verbindingen of meetpunten zijn niet herkenbaar.],
  [Score: ............\ Observatie:\ \ \ ],
  table.hline(stroke: 0.3pt + luma(70%)),
  [*3. Onderschrift*

    Zelfstandig begrijpelijk? Meetfunctie en afkortingen toegelicht? Bron vermeld waar nodig?],
  [Bondig en zelfstandig leesbaar. Verbindt de onderdelen en meetfunctie
    duidelijk met het onderzoeksdoel; termen en bronvermelding zijn zorgvuldig.],
  [Beschrijft wat te zien is en wat wordt gemeten. Belangrijke afkortingen
    worden verklaard; een bron staat vermeld indien van toepassing.],
  [Ontbreekt of geeft onvoldoende informatie om de figuur te begrijpen.
    Essentiële termen of gebruikte bronnen blijven onduidelijk.],
  [Score: ............\ Observatie:\ \ \ ],
  table.hline(stroke: 0.3pt + luma(70%)),
  [*4. Kritische vragen*

    Antwoorden correct en onderbouwd? Keuzes en beperkingen toegelicht?],
  [Onderbouwt antwoorden met fysische of meetkundige argumenten, weegt
    alternatieven af en bespreekt gevolgen van onzekerheden en beperkingen.],
  [Beantwoordt vragen inhoudelijk correct en licht belangrijke keuzes toe.
    Herkent beperkingen en geeft aan wat nog onbekend is.],
  [Antwoorden missen de kern of bevatten wezenlijke fouten. Keuzes en
    beperkingen kunnen onvoldoende worden toegelicht.],
  [Score: ............\ Observatie:\ \ \ ],
  table.hline(stroke: 0.8pt),
)
#v(3mm)
#grid(columns: (1fr, 1fr), gutter: 3mm,
  veld("Sterk punt (met voorbeeld):", hoogte: 12mm),
  veld("Belangrijkste verbeteractie:", hoogte: 12mm))
#v(3mm)
#grid(columns: (2fr, 1fr), gutter: 3mm,
  veld("Gestelde kritische vraag en kern van het antwoord:", hoogte: 12mm),
  veld("Eindoordeel / vervolgafspraak:", hoogte: 12mm))

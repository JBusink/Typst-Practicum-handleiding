
#set document(
  title: "Rubriek Presentatie 2",
)

#set page(
  paper: "a4",
  flipped: true,
  margin: (x: 13mm, y: 15mm),
  footer: context {
    align(right)[
      #text(size: 8pt, fill: gray)[
        Presentatie 2 — Pagina
        #counter(page).display("1")
      ]
    ]
  },
)

#set text(
  font: ("Arial", "Liberation Sans"),
  size: 8.5pt,
  lang: "nl",
)

#set par(leading: 0.45em)

// ==========================================
// OPMAAK
// ==========================================

#let accent = rgb("#000000")
#let licht = rgb("#E8EFF5")
#let rand = rgb("#494a4b")

// Aankruisvakje
#let vakje() = rect(
  width: 9pt,
  height: 9pt,
  stroke: 0.8pt + rgb("#1a1717"),
  radius: 0pt,
)

#let niveau(body) = grid(
  columns: (9pt, 1fr),
  column-gutter: 5pt,
  align: top,
  vakje(),
  body,
)


// Scorevak
#let score() = align(center)[
  ........
]

// Hoofdcategorie
#let categorie(titel, punten) = table.cell(
  colspan: 5,
  fill: licht,
  inset: (x: 8pt, y: 7pt),
)[
  #text(
    weight: "bold",
    fill: accent,
    size: 9.5pt,
  )[
    #titel
  ]
  #h(1fr)
  ... / *#punten punten*
]

// ==========================================
// TITEL
// ==========================================

#text(size: 18pt, weight: "bold")[
  Rubriek Presentatie 2
]


#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 15pt,
  [*Student:* ................................],
  [*Beoordelaar:* ...........................],
  [*Datum:* ................................],
)

// ==========================================
// BEOORDELINGSTABEL
// ==========================================

#table(
  columns: (14%, 24%, 24%, 24%, 8%),
  inset: (x: 7pt, y: 8pt),
  stroke: 0.5pt + rand,
  align: (left, left, left, left, center),

  table.header(
    table.cell(fill: accent)[
      #text(fill: white, weight: "bold")[
        Criterium
      ]
    ],
    table.cell(fill: accent)[
      #text(fill: white, weight: "bold")[
        Uitstekend (2)
      ]
    ],
    table.cell(fill: accent)[
      #text(fill: white, weight: "bold")[
        Voldoende (1)
      ]
    ],
    table.cell(fill: accent)[
      #text(fill: white, weight: "bold")[
        Onvoldoende (0)
      ]
    ],
    table.cell(fill: accent)[
      #text(fill: white, weight: "bold")[
        Score
      ]
    ],
  ),

  // ========================================
  // 1. VOORBEREIDING EN VERHAALLIJN
  // ========================================

  categorie(
    "1. Voorbereiding en verhaallijn", 8,
  ),

  [*1.1 Onderzoeksvraag en aanleiding*],
  niveau[
    Onderzoeksvraag en aanleiding zijn
    helder, concreet en overtuigend
    met elkaar verbonden.
  ],
  niveau[
    Onderzoeksvraag en aanleiding
    zijn duidelijk, maar de samenhang
    is beperkt toegelicht.
  ],
  niveau[
    Onderzoeksvraag of aanleiding
    ontbreekt of is onduidelijk.
  ],
  score(),

  [*1.2 Uitleg van de opstelling*],
  niveau[
    De werking wordt volledig en
    logisch uitgelegd met doelgerichte
    verwijzingen naar de figuur.
  ],
  niveau[
    De belangrijkste onderdelen
    worden uitgelegd, maar de
    samenhang is niet overal duidelijk.
  ],
  niveau[
    De werking blijft grotendeels
    onduidelijk of wordt onjuist
    uitgelegd.
  ],
  score(),


[*1.3 Relatie tussen figuur en metingen*],

niveau[
  Legt duidelijk uit waar en hoe
  metingen plaatsvinden in de figuur.
  Verbindt gemeten natuurkundige
  grootheden aan de relevante onderdelen
  en licht toe hoe de metingen bijdragen
  aan de opdracht.
],

niveau[
  Maakt grotendeels duidelijk waar
  en wat wordt gemeten, maar de
  koppeling met de figuur, natuurkundige
  grootheden of opdracht
  is niet volledig uitgewerkt.
],

niveau[
  Maakt onvoldoende duidelijk waar
  en wat wordt gemeten.
  De relatie tussen de figuur,
  de gemeten grootheden en de
  opdracht ontbreekt
  of is onjuist.
],

score(),


  [*1.4 Presentatie en tijdgebruik*],
  niveau[
    Vloeiende, goed voorbereide pitch
    met een duidelijke kernboodschap,
    gericht figuurgebruik en passend
    tijdgebruik (circa 5 minuten).
  ],
  niveau[
    Begrijpelijke presentatie met
    enkele onduidelijkheden in
    opbouw, figuurgebruik of timing. Minder dan 1 minuut afwijking
  ],
  niveau[
    Onsamenhangende of onvoldoende
    voorbereide presentatie met
    duidelijk ongeschikt tijdgebruik. Meer dan 1 minuut afwijking.
  ],
  score(),

  // ..subtotaal(),


  // ========================================
  // 2. KWALITEIT VAN DE VISUAL
  // ========================================

  categorie("2. Kwaliteit van de visual", 12),

  [*2.1 Technische correctheid*],
  niveau[
    De figuur geeft de opstelling
    of het model technisch correct
    en consistent weer.
  ],
  niveau[
    De figuur is grotendeels correct,
    met enkele kleine onnauwkeurigheden.
  ],
  niveau[
    De figuur bevat wezenlijke
    technische fouten.
  ],
  score(),

  [*2. Onderdelen en verbindingen*],
  niveau[
    Alle relevante onderdelen,
    verbindingen en hun onderlinge
    relaties zijn herkenbaar.
  ],
  niveau[
    De meeste onderdelen zijn
    herkenbaar, maar enkele
    verbindingen zijn onduidelijk.
  ],
  niveau[
    Essentiële onderdelen of
    verbindingen ontbreken
    of zijn incorrect.
  ],
  score(),

  // [*2.3 Meetpunten en labels*],
  // niveau[
  //   Meetpunten, grootheden,
  //   pijlen en relevante eenheden
  //   zijn volledig en correct.
  // ],
  // niveau[
  //   De belangrijkste meetpunten
  //   en labels zijn aanwezig,
  //   met enkele onvolkomenheden.
  // ],
  // niveau[
  //   Essentiële meetpunten
  //   ontbreken of labels en
  //   eenheden zijn incorrect.
  // ],
  // score(),

  [*2.3 Leesbaarheid en overzicht*],
  niveau[
    De figuur is overzichtelijk,
    goed leesbaar en bevat
    uitsluitend relevante details.
  ],
  niveau[
    De figuur is begrijpelijk,
    maar bevat onnodige details
    of minder leesbare onderdelen.
  ],
  niveau[
    De figuur is rommelig,
    slecht leesbaar of
    onvoldoende overzichtelijk.
  ],
  score(),

  // ..subtotaal(),


  
  // ========================================
  // 4. KRITISCHE VRAGEN
  // ========================================

  categorie("3. Kritische vragen", 8),

  [*3.1 Inzicht in ontwerpkeuzes*],
  niveau[
    Kan belangrijke ontwerpkeuzes
    correct en overtuigend
    onderbouwen.
  ],
  niveau[
    Kan ontwerpkeuzes deels
    toelichten, maar de
    onderbouwing blijft beperkt.
  ],
  niveau[
    Kan belangrijke ontwerpkeuzes
    niet verklaren of geeft
    incorrecte antwoorden.
  ],
  score(),

  [*3.2 Kalibratie en meetmethode*],
  niveau[
    Toont goed inzicht in
    de meetmethode, kalibratie
    en betrouwbaarheid
    van de metingen.
  ],
  niveau[
    Toont basisinzicht in
    de meetmethode en kalibratie,
    maar mist relevante details.
  ],
  niveau[
    Mist essentieel inzicht
    in de meetmethode of
    kalibratie.
  ],
  score(),

  [*3.3 Meetonzekerheid en beperkingen*],
  niveau[
    Herkent relevante
    onzekerheden en beperkingen
    en kan hun gevolgen
    goed toelichten.
  ],
  niveau[
    Benoemt enkele onzekerheden
    of beperkingen, maar kan
    hun gevolgen beperkt uitleggen.
  ],
  niveau[
    Herkent belangrijke
    onzekerheden of
    beperkingen niet.
  ],
  score(),

  // ..subtotaal(),

  // ========================================
  // 3. KWALITEIT VAN HET ONDERSCHRIFT
  // ========================================

  categorie(
    "4. Kwaliteit van het onderschrift", 8,
  ),

  [*4.1 Zelfstandige begrijpelijkheid*],
  niveau[
    Het onderschrift maakt de figuur
    volledig begrijpelijk zonder
    mondelinge toelichting.
  ],
  niveau[
    Het onderschrift geeft de
    hoofdlijn weer, maar enige
    toelichting blijft nodig.
  ],
  niveau[
    Het onderschrift ontbreekt
    of maakt de figuur niet
    zelfstandig begrijpelijk.
  ],
  score(),

  [*4.2 Beschrijving van onderdelen*],
  niveau[
    De belangrijkste onderdelen
    en hun functies worden
    correct en helder beschreven.
  ],
  niveau[
    De meeste onderdelen worden
    beschreven, maar functies
    zijn deels onduidelijk.
  ],
  niveau[
    Essentiële onderdelen
    of functies worden niet
    correct beschreven.
  ],
  score(),

  [*4.3 Beschrijving van metingen*],
  niveau[
    Het onderschrift beschrijft
    duidelijk wat wordt gemeten
    en hoe dit samenhangt
    met de opstelling.
  ],
  niveau[
    De metingen worden genoemd,
    maar hun betekenis wordt
    beperkt toegelicht.
  ],
  niveau[
    De gemeten grootheden
    of hun relatie met de
    opstelling ontbreken.
  ],
  score(),

  [*4.4 Taal, afkortingen en bronnen*],
  niveau[
    Beknopt en nauwkeurig
    geformuleerd. Afkortingen zijn
    verklaard en bronnen zijn
    waar nodig correct vermeld.
  ],
  niveau[
    Grotendeels duidelijk, maar
    enkele termen, afkortingen
    of brongegevens ontbreken.
  ],
  niveau[
    Onduidelijke formuleringen,
    onverklaarde afkortingen of
    ontbrekende noodzakelijke
    bronvermelding.
  ],
  score(),

  // ..subtotaal(),



)

// ==========================================
// TOTAALSCORE EN FEEDBACK
// ==========================================

#v(12pt)

#align(right)[
  #text(
    size: 13pt,
    weight: "bold",
    fill: accent,
  )[
    Totaalscore: ... /36
  ]
]


*Sterke punten en verbeterpunten:*


#for i in range(3) {
  line(
    length: 100%,
    stroke: 0.5pt + rand,
  )
  v(15pt)
}

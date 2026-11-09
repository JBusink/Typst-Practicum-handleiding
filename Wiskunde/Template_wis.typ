
////////////////////////////////////////////
// TEMPLATE — OPGAVEN EN UITWERKINGEN
////////////////////////////////////////////

// ==========================================
// 1. STIJLINSTELLINGEN
// ==========================================

#let stijl = (
  // Lettertype
  font: "Arial",
  font-size: 11pt,
  line-spacing: 0.65em,

  // Pagina
  papier: "a4",
  marge-links: 22mm,
  marge-rechts: 22mm,
  marge-boven: 22mm,
  marge-onder: 22mm,

  // Kleuren
  tekstkleur: rgb("#000000"),
  accentkleur: rgb("#000000"),
  lijnkleur: rgb("#000000"),

  // Uitwerkingen
  oplossing-achtergrond: rgb("#fdfdfd00"),
  oplossing-rand: rgb("#000000"),
  oplossing-randdikte: 0.3pt,
  oplossing-padding: 12pt,

  // Koppen
  titel-grootte: 18pt,
  kop1-grootte: 15pt,
  kop2-grootte: 12pt,

  // Header/footer
  header-grootte: 9pt,
  footer-grootte: 9pt,
)


// ==========================================
// 2. DOCUMENTSTIJL
// ==========================================

#let documentstijl(
  body,
  titel: "Opgaven",
  vak: "Natuurkunde",
  auteur: "",
  datum: "",
  toon-header: true,
  toon-footer: true,
  toon-paginanummer: true,
) = {

  // Header
  let koptekst = if toon-header {
    context {
      grid(
        columns: (1fr, 1fr),
        align(left)[
          #text(
            size: stijl.header-grootte,
            weight: "bold",
            fill: stijl.accentkleur,
          )[#titel]
        ],
        align(right)[
          #text(
            size: stijl.header-grootte,
            fill: stijl.tekstkleur,
          )[#vak]
        ],
      )

      v(3pt)
      line(
        length: 100%,
        stroke: 0.5pt + stijl.lijnkleur,
      )
    }
  } else {
    none
  }

  // Footer
  let voettekst = if toon-footer {
    context {
      line(
        length: 100%,
        stroke: 0.5pt + stijl.lijnkleur,
      )

      v(3pt)

      grid(
        columns: (1fr,  1fr),

        // align(left)[
        //   #text(size: stijl.footer-grootte)[
        //     #auteur
        //   ]
        // ],

        align(left)[
          #text(size: stijl.footer-grootte)[
            #datum
          ]
        ],

        align(right)[
          #if toon-paginanummer {
            text(size: stijl.footer-grootte)[
              Pagina #counter(page).display("1")
            ]
          }
        ],
      )
    }
  } else {
    none
  }

  // Pagina-instellingen
  set page(
    paper: stijl.papier,
    margin: (
      left: stijl.marge-links,
      right: stijl.marge-rechts,
      top: stijl.marge-boven,
      bottom: stijl.marge-onder,
    ),
    header: koptekst,
    footer: voettekst,
  )

  // Algemene typografie
  set text(
    font: stijl.font,
    size: stijl.font-size,
    fill: stijl.tekstkleur,
    lang: "nl",
  )

  set par(
    justify: true,
    leading: stijl.line-spacing,
  )

  // Koppen
  show heading.where(level: 1): set text(
    size: stijl.kop1-grootte,
    weight: "bold",
    fill: stijl.accentkleur,
  )

  show heading.where(level: 2): set text(
    size: stijl.kop2-grootte,
    weight: "bold",
    fill: stijl.tekstkleur,
  )

  // Documentinhoud
  body
}


// ==========================================
// 3. OPGAVEN EN UITWERKINGEN
// ==========================================

// Teller
#let opgave-teller = counter("opgave")

// Maak functies voor de gekozen modus.
// Beschikbare modi:
// "opgaven", "beide", "uitwerkingen"


#let maak-opgaven(modus: "beide") = {

  assert(
    modus in ("opgaven", "beide", "uitwerkingen"),
    message: "Ongeldige modus.",
  )

  // Opgavefunctie
  let exercise(body) = {
    opgave-teller.step()

    if modus == "opgaven" or modus == "beide" {
      block(
        width: 100%,
        breakable: true,
        above: 1em,
        below: 1em,
      )[
        #text(
          weight: "bold",
          fill: stijl.accentkleur,
        )[
          Opgave #context opgave-teller.display()
        ]

        #v(5pt)

        #body
      ]
    }
  }

  // Uitwerkingsfunctie
  let solution(body) = {
    if modus == "beide" or modus == "uitwerkingen" {
      block(
        width: 100%,
        breakable: true,
        fill: stijl.oplossing-achtergrond,
        stroke: (
          paint: stijl.oplossing-rand,
          thickness: stijl.oplossing-randdikte,
        ),
        radius: 0pt,
        inset: stijl.oplossing-padding,
        above: 0.5em,
        below: 1.2em,
      )[
        #text(
          weight: "bold",
          fill: stijl.accentkleur,
        )[
          Uitwerking opgave #context opgave-teller.display()
        ]

        #v(7pt)

        #body
      ]
    }
  }

  (exercise, solution)
}



// ==========================================
// 4. EXTRA OPMAAKFUNCTIES
// ==========================================

// Rechthoekig kader voor eindantwoorden
#let antwoord(body) = rect(
  stroke: 0.8pt + stijl.accentkleur,
  radius: 0pt,
  inset: (x: 7pt, y: 5pt),
  body,
)

// Opmerking zonder kader
#let opmerking(body) = block(
  width: 100%,
  inset: (left: 10pt, y: 6pt),
  stroke: (left: 2pt + stijl.accentkleur),
  body,
)

// Horizontale scheidingslijn
#let scheidingslijn() = {
  v(5pt)
  line(
    length: 100%,
    stroke: 0.5pt + stijl.lijnkleur,
  )
  v(5pt)
}

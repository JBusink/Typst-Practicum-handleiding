// Typst-versie van styl.sty. Gebruik: #import "styl.typ": *
// en vervolgens: #show: stijl.with()
#let HvARood = rgb("D52B1E")
#let HvAGrijs = rgb("4D4D4D")
#let HvABlauw = rgb("26146B")
#let DodgerBlue = rgb(30, 144, 255)

#let nederlandse-datum(datum) = {
  let maanden = (
    "januari",
    "februari",
    "maart",
    "april",
    "mei",
    "juni",
    "juli",
    "augustus",
    "september",
    "oktober",
    "november",
    "december",
  )
  str(datum.day()) + " " + maanden.at(datum.month() - 1) + " " + str(datum.year())
}

// Centrale lijststijl, toegepast door stijl().
// Markup-lijsten krijgen expliciet tight: true; overschrijf dit ook daar.
#let template(body) = [
  #show list: set block(above: 0.9em, below: 0.9em)
  #show enum: set block(above: 0.9em, below: 0.9em)
  #show list.where(tight: true): it => {
    let velden = it.fields()
    velden.tight = false
    let items = velden.remove("children")
    list(..velden, ..items)
  }
  #show enum.where(tight: true): it => {
    let velden = it.fields()
    velden.tight = false
    let items = velden.remove("children")
    enum(..velden, ..items)
  }
  // LaTeX-itemize: bolletje, streepje en sterretje per nestingniveau.
  #set list(
    marker: ([•], [–], [∗], [·]),
    indent: 1.5em,
    body-indent: 0.5em,
    tight: false,
    spacing: 0.6em,
  )

  // Zoals enumerate[label=\textbf{\arabic*}] in de practicumbronnen.
  #set enum(
    numbering: n => strong(str(n)),
    indent: 1.5em,
    body-indent: 0.5em,
    tight: false,
    spacing: 0.6em,
  )

  #body
]

#let stijl(
  body,
  titel: "Practicum",
  kop: none,
  studiejaar: "2026-2027",
  opleiding: "Technische Natuurkunde",
  datum: datetime.today(),
  lettertype: ("TeX Gyre Heros", "Helvetica", "Arial", "Liberation Sans"),
  oplossingen: true,
) = {
  set document(title: titel)
  set text(font: lettertype, size: 11pt, lang: "nl")
  set page(
    paper: "a4",
    margin: (top: 3.2cm, bottom: 3.2cm, left: 2cm, right: 2cm),
    header: if kop == none {
      line(length: 100%, stroke: 0.4pt)
    } else [
      #align(center, text(size: 9pt, kop))
      #v(2mm)
      #line(length: 100%, stroke: 0.4pt)
    ],
    header-ascent: 0.3cm,
    footer-descent: 0.6cm,
    footer: context {
      grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        [], [#nederlandse-datum(datum) — #studiejaar — #opleiding], counter(page).display("1"),
      )
    },
  )
  set par(first-line-indent: 0pt, justify: true, leading: 0.45em, spacing: 0.55em)
  // Pas de centrale lijstinstellingen hieronder ook echt toe.
  show: template
  // Alleen periode- en documenttitels staan in de inhoudsopgave.
  // tussentitelpagina en praktikumtitle schakelen outlined expliciet in.
  set heading(numbering: none, outlined: false)
  set outline(depth: 2, indent: 1em)
  show heading.where(level: 1): set text(size: 16pt)
  show heading.where(level: 2): set text(size: 13pt)
  show heading.where(level: 4): set heading(numbering: none)
  show figure.caption: set text(size: 10pt, weight: "bold")
  set figure(supplement: [Figuur])
  show figure: set block(above: 1.5em, below: 1.5em)
  show figure.where(kind: table): set figure(supplement: [Tabel])
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set block(breakable: false)
  show figure.where(kind: table): set text(size: 9pt)
  show table: it => block(breakable: false, text(size: 9pt, it))
  set table(
    // Zoals tabular in het LaTeX-origineel: dunne zwarte lijnen,
    // compacte cellen en een lichtgrijze kopregel zonder blauwe zebra-opmaak.
    align: center + horizon, inset: (x: 6pt, y: 4pt), stroke: 0.4pt + black,
    fill: (x, y) => if y == 0 { rgb("E6E6E6") } else { white },
  )
  show table.cell.where(y: 0): strong
  // Klassieke Python/Pygments-kleuren, zoals bij minted en Jupyter.
  show raw.where(lang: "python"): set raw(theme: "Practicum/themas/python.tmTheme")
  show raw.where(lang: "py"): set raw(theme: "Practicum/themas/python.tmTheme")
  show raw: set text(size: 9pt)
  // Raw schaalt met 0.8: dit geeft codeblokken van effectief 8pt.
  show raw.where(block: true): set text(size: 10pt)
  show raw.where(block: true, lang: ""): set text(size: 9.375pt)
  // Een wiskundelettertype blijft nodig voor volledige symboolondersteuning.
  show math.equation: set text(font: "New Computer Modern Math")
  show math.equation.where(block: true): set block(above: 1em, below: 1em)
  state("toon-oplossingen", true).update(oplossingen)
  body
}

#let hoofdtitelpagina(titel, subtitel, auteur, datum: datetime.today()) = {
  page(header: none, footer: none)[
    #v(28%)
    #align(center)[
      #line(length: 12cm - 20pt, stroke: 2.5pt + HvABlauw)
      #v(1.5cm)
      #text(size: 25pt, weight: "bold", titel)
      #v(0.4cm)
      #text(size: 17pt, weight: "bold", subtitel)
      #v(1.2cm)
      #text(size: 12pt, auteur)
    ]
    #v(1fr)
    #align(center)[
      *Hogeschool van Amsterdam* \
      #v(2mm)
      *Opleiding Technische Natuurkunde*
      #v(4mm)
      #text(size: 10pt, nederlandse-datum(datum))
      #v(1.5cm)
      #line(length: 12cm - 20pt, stroke: 2.5pt + HvABlauw)
    ]
  ]
}

#let tussentitelpagina(titel, subtitel) = {
  page(header: none, footer: none)[
    #v(35%)
    #align(center)[
      #line(length: 12cm - 20pt, stroke: 1.5pt + HvABlauw)
      #v(1.2cm)
      #show heading: it => text(size: 25pt, weight: "bold", fill: HvABlauw, it.body)
      #heading(level: 1, numbering: none, outlined: true, titel)
      #v(0.6cm)
      #text(size: 17pt, weight: "bold", fill: HvABlauw, subtitel)
      #v(1.5cm)
      #line(length: 12cm - 20pt, stroke: 1.5pt + HvABlauw)
    ]
  ]
}

#let praktikumtitle(titel) = {
  pagebreak(weak: true)
  align(center)[
    #show heading: it => text(size: 20pt, weight: "bold", it.body)
    #heading(level: 2, numbering: none, outlined: true, titel)
  ]
  v(0.5cm)
}


// Een gedeelde kaderfunctie; lange kaders mogen over pagina's doorlopen.
#let kader(
  body,
  title: none,
  achtergrond: white,
  rand: black,
  tekstkleur: black,
  titelgrootte: 11pt,
  inset: (x: 0.8em, y: 0.7em),
  titel-inset: (x: 0.8em, y: 0.4em),
  radius: 0pt,
) = block(
  width: 100%,
  breakable: true,
  fill: achtergrond,
  stroke: 0.8pt + rand,
  radius: radius,
  inset: 0pt,
  above: 1.4em,
  below: 1.4em,
)[
  #if title != none {
    block(
      width: 100%,
      fill: rand,
      radius: (top-left: radius, top-right: radius, bottom-left: 0pt, bottom-right: 0pt),
      inset: titel-inset,
      below: 0pt,
      sticky: true,
      text(fill: white, weight: "bold", size: titelgrootte, title),
    )
  }
  #block(inset: inset, above: 0pt)[
    #set text(fill: tekstkleur)
    #body
  ]
]

#let voorbereiding(body, title: [Voorbereiding]) = kader(
  body,
  title: title,
  achtergrond: rgb("FFF6EB"),
  rand: rgb("#eb6c2d"),
  titelgrootte: 13pt,
)
#let veiligheid(body, title: [Veiligheid]) = kader(
  body,
  title: title,
  achtergrond: rgb("FFF2F2"),
  rand: rgb("#c02626"),
  titelgrootte: 13pt,
)
#let methode(body, title: [Methode]) = kader(body, title: title, achtergrond: rgb("FAFAFA"), rand: rgb("#0f4b99"))
#let opdracht(body, title: [Opdracht]) = kader(body, title: title, achtergrond: rgb("FCFFFC"), rand: rgb("#038a03"),
  titelgrootte: 13pt,)
#let afronding(body, title: [Afronding]) = kader(
  body,
  title: title,
  achtergrond: rgb("F2F2F2"),
  rand: rgb("333333"),
  titelgrootte: 13pt,
)
#let AnacondaNavigator(title, body) = kader(
  body,
  title: title,
  achtergrond: black,
  rand: rgb("1A1A1A"),
  tekstkleur: white,
  titelgrootte: 11pt,
  radius: 0pt,
)
#let jupytercode(title, body) = block(breakable: false, above: 1.4em, below: 1.4em,
  kader(body, title: title, achtergrond: rgb("FBFBFB"), rand: rgb("737373"),
    titelgrootte: 11pt, radius: 0pt),
)
#let jupytercodesolutions(title, body) = kader(
  body,
  title: title,
  achtergrond: rgb("FBFBFB"),
  rand: rgb("737373"),
  titelgrootte: 11pt,
  radius: 0pt,
)

// Het geschaduwde open vierkant van LaTeX/Pifont: \ding{114}.
#let leerdoel-teken = box(width: 0.75em, height: 0.75em)[
  #place(top + left, dx: 0.1em, rect(width: 0.65em, height: 0.65em, fill: black, stroke: none))
  #place(top + left, dy: 0.1em, rect(width: 0.65em, height: 0.65em, fill: white, stroke: 0.7pt + black))
]
#let leerdoelen(..items) = list(marker: leerdoel-teken, ..items.pos())
#let vraagnummer = counter("practicum-vraag")
#let vraag(body) = block[
  #vraagnummer.step()
  #context strong[Q#vraagnummer.display("1")]
  #h(0.5em)#body
]
#let oplossing(body) = context {
  if state("toon-oplossingen", true).get() {
    block[*Oplossing:* #body]
  }
}

// Hulpfunctie voor naast elkaar getoonde deelafbeeldingen.
#let subfiguur(body) = {
  set image(width: 100%)
  block(width: 100%, body)
}


#let eqbox(body) = rect(
  stroke: 0.8pt,
  inset: 5pt,
  body,
)


#let intermezzo(titel, inhoud) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#f0efff"),
  stroke: (left: 3pt + rgb("#6f2ec4")),
  inset: (
    left: 14pt,
    right: 14pt,
    top: 12pt,
    bottom: 12pt,
  ),
  radius: (right: 5pt),
)[
  #text(
    fill: rgb("#651dd8"),
    weight: "bold",
    size: 11pt,
  )[Intermezzo — #titel]

  #v(7pt)

  #inhoud
]


#set math.equation(numbering: "(1)")
#set math.equation(block: true)



#let vergelijking_refs(body) = {
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      let eq = it.element
      [Eq. #numbering(
        eq.numbering,
        ..counter(math.equation).at(eq.location())
      )]
    } else {
      it
    }
  }
  body
}


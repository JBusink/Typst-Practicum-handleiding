// Gedeelde formulieropmaak. Gebruik Maak invulbare PDFs.cmd voor invulvelden.
#let formulier(body, interview: false) = {
  set page(paper: "a4",
    margin: (left: 22mm, right: 22mm, top: 16mm, bottom: 22mm),
    footer-descent: 12mm,
    footer: context {
      if interview {
        line(length: 100%, stroke: 0.4pt)
        v(2mm)
        grid(columns: (1fr, auto, 1fr), [],
          text(size: 10pt)[Werkveldbeoordeling stages],
          align(right, text(size: 10pt, counter(page).display("1"))))
      } else {
        align(center, text(size: 11pt, counter(page).display("1")))
      }
    })
  set text(font: ("TeX Gyre Heros", "Helvetica", "Arial", "Liberation Sans"), size: 11pt,
    lang: "nl", hyphenate: true)
  set par(justify: true, leading: 0.52em, spacing: 0.65em)
  set list(indent: 24pt, body-indent: 5pt, spacing: 8pt)
  set heading(numbering: none)
  show heading.where(level: 1): it => block(above: 5mm, below: 2mm,
    text(size: 17.2pt, weight: "bold", it.body))
  show heading.where(level: 2): it => block(above: 4mm, below: 1mm,
    text(size: 11pt, weight: "bold", it.body))
  body
}

// Alleen het bouwscript gebruikt tijdelijke markeringen. De gewone preview
// en een directe Typst-export hebben geen klikbare webkoppelingen in de vakken.
#let veldmarkering(kind, name, body) = {
  if sys.inputs.at("stage-form-build", default: "false") == "true" {
    link("https://typst-form.invalid/" + kind + "/" + name, body)
  } else {
    body
  }
}

#let veld(name, width: 100%, height: 8mm, multiline: false, score: "") = {
  let kind = if score != "" { "score/" + score } else if multiline { "multi" } else { "text" }
  veldmarkering(kind, name,
    box(width: width, height: height, stroke: 0.65pt, fill: white, inset: 0pt))
}
#let vink(name) = veldmarkering("check", name,
  box(width: 10pt, height: 10pt, stroke: 0.65pt, fill: white))

// Vaste kolommen en booktabs-achtige regels zoals in de LaTeX-originelen.
#let scores(names, label: [Score / Indicator]) = block(width: 100%, above: 4mm, below: 4mm,
  table(columns: (1fr, ..(17mm,) * 6),
    inset: (x: 4pt, y: 4pt), stroke: none, align: left + horizon,
    table.hline(stroke: 0.7pt),
    table.vline(x: 1, stroke: 0.35pt),
    table.vline(x: 6, stroke: 0.35pt),
    strong(label),
    ..names.enumerate().map(((i, name)) => [#("E", "G", "V", "M", "O", "NvT").at(i): #vink(name)]),
    table.hline(stroke: 0.4pt)))

#let indicatoren(body) = block(width: 100%,
  inset: (left: 7pt, right: 6pt, top: 2pt, bottom: 6pt),
  stroke: (bottom: 0.6pt), above: 0pt, below: 4mm, body)

#let toelichting(name, label: [Opmerkingen / toelichting], height: 3cm) = block(
  width: 100%, breakable: false, above: 3mm, below: 0pt)[
  #block(below: 1mm, strong(label))
  #veld(name, height: height, multiline: true)
]

#let titel(body) = block(width: 100%, below: 16mm)[
  #v(12mm)
  #align(center)[
    #text(size: 20.7pt, weight: "bold", body)
    #v(5mm)
    #text(size: 14.4pt)[
      Hogeschool van Amsterdam \
      Faculteit van Techniek \
      Technische Natuurkunde -- Jaar 3
    ]
  ]
]

#let persoonsgegevens(rows) = align(center, block(width: 146mm,
  grid(columns: (1fr, 80mm), row-gutter: 1.2mm, column-gutter: 4mm,
    align: left + horizon,
    ..rows.map(((label, name)) => (strong(label), veld(name, width: 80mm, height: 5mm))).flatten())))

#let slotgegevens(rows) = grid(columns: (1fr, 50mm),
  row-gutter: 1.2mm, column-gutter: 4mm, align: left + horizon,
  ..rows.map(((label, name)) => (strong(label), veld(name, width: 50mm, height: 5mm))).flatten())

#let beoordelingstabel(title, rows, score-name, bereik) = block(
  width: 100%, above: 5mm, below: 1mm, breakable: false)[
  #table(columns: (1fr, ..(14mm,) * 6),
    inset: (x: 4pt, y: 4pt), stroke: none,
    align: (x, y) => if x == 0 { left + horizon } else { center + horizon },
    table.vline(x: 1, stroke: 0.35pt),
    table.vline(x: 6, stroke: 0.35pt),
    strong(title), ..("E", "G", "V", "M", "O", "NvT"),
    table.hline(stroke: 0.5pt),
    ..rows.map(((label, n)) => (
      text(size: 10pt, weight: "bold", label),
      ..("E", "G", "V", "M", "O", "NVT").map(prefix => vink(prefix + str(n)))
    )).flatten(),
    table.hline(stroke: 0.5pt))
  #v(1.5mm)
  #grid(columns: (1fr, 15mm), align: left + horizon,
    text(size: 10pt, weight: "bold")[Subtotaal #lower(title):],
    veld(score-name, width: 15mm, height: 5mm, score: bereik))
]


#let scores-compact(names) = {
  grid(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    row-gutter: 3pt,
    column-gutter: 0pt,

    ..names.enumerate().map(((i, name)) => {
      box[
        #text(size: 10pt)[
          #("E:", "G:", "V:", "M:", "O:", "NvT:").at(i)
        ]
        #h(4pt)
        #vink(name)
      ]
    })
  )
}

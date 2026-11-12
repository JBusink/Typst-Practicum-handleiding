// Gebaseerd op de aangeleverde practicum-styl.typ.
// Alleen de gebruikte document-, lijst-, tabel- en kaderopmaak is overgenomen.
// Alle tekst en lijnen blijven zwart; achtergronden blijven wit.
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

#let lijststijl(body) = [
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

#let professional-development(
  titel: "Professional Development",
  subtitel: none,
  documenttype: "Opdrachtbeschrijving",
  opleiding: "Technische Natuurkunde",
  studiejaar: "2026-2027",
  auteur: none,
  datum: datetime.today(),
  liggend: false,
  tekstgrootte: 11pt,
  lettertype: ("TeX Gyre Heros", "Helvetica", "Arial", "Liberation Sans"),
  marges: none,
  toon-header: true,
  titelruimte: 5mm,
  body,
) = {
  set document(title: titel, author: if auteur == none { () } else { auteur })
  set text(
    font: lettertype,
    size: tekstgrootte, lang: "nl", fill: black,
  )
  set page(
    paper: "a4", flipped: liggend,
    margin: if marges != none { marges } else if liggend { 15mm } else {
      (top: 32mm, bottom: 32mm, left: 20mm, right: 20mm)
    },
    header: if toon-header { [
      #align(center, text(size: 9pt)[Hogeschool van Amsterdam - Technische stage: Professional Development])
      #v(2mm)
      #line(length: 100%, stroke: 0.4pt + black)
    ] } else { none },
    header-ascent: 3mm,
    footer-descent: 6mm,
    footer: context {
      set text(size: 9pt)
      grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        [], [
          #if datum != none {
            if type(datum) == datetime { nederlandse-datum(datum) } else { datum }
            [ — ]
          }
          #studiejaar — #opleiding
        ],
        counter(page).display("1"),
      )
    },
  )
  set par(first-line-indent: 0pt, justify: true, leading: 0.45em, spacing: 0.55em)
  show: lijststijl
  set heading(numbering: none, outlined: false)
  show heading.where(level: 1): set text(size: 16pt)
  show heading.where(level: 2): set text(size: 13pt)
  // De rubrieken bevatten uitsluitend tekst: linksboven uitlijnen voorkomt
  // onnatuurlijke woordspaties in de smalle beoordelingskolommen.
  show table: it => block(breakable: false)[
    #set text(size: 9pt)
    #set par(justify: false)
    #it
  ]
  set table(
    align: left + top,
    inset: (x: 6pt, y: 4pt),
    stroke: 0.4pt + black,
    fill: white,
  )
  show table.cell.where(y: 0): strong

  align(center)[
    #text(size: 20pt, weight: "bold", titel)
    #if subtitel != none {
      v(2mm)
      text(size: 11pt, subtitel)
    }
    #if auteur != none {
      v(2mm)
      text(size: 10pt, auteur)
    }
  ]
  v(titelruimte)
  body
}

// Alleen het gebruikte opdrachtkader, zonder ongebruikte kleurvarianten.
#let kader(titel, body) = block(
  width: 100%, breakable: true,
  fill: white, stroke: 0.8pt + black,
  radius: 0pt, inset: (x: 0.8em, y: 0.7em),
  above: 1.4em, below: 1.4em,
)[*#titel* #parbreak() #body]

// Nodig voor de bestaande beoordelingsformulieren; printbaar, niet interactief.
#let invulveld(label, hoogte: 10mm) = block(
  width: 100%, height: hoogte, inset: 5pt, stroke: 0.4pt + black,
)[#text(size: 9pt, weight: "bold", label)]

#let rubriektabel(..cellen) = table(
  columns: (1.6fr, 2.1fr, 2.1fr, 2.1fr, 1fr),
  table.header(
    [*Onderdeel*], [*Goed*], [*Voldoende*], [*Onvoldoende*], [*Score*],
  ),
  ..cellen.pos(),
)

// Gedeelde opmaak voor een memo voor de technische stage.
#let stage-memo(
  titel: "Memo ... - Technische Stage:",
  studenten: [Naam student],
  studentnummer: none,
  begeleiders: [Naam begeleider],
  studie: [Technische Natuurkunde - High-Tech Physics: Technical internship],
  datum: datetime.today(),
  logo: "figuren/HvA-logo.png",
  body,
) = {
  set document(title: titel)
  set text(font: ("Arial", "Liberation Sans"), size: 11pt, lang: "nl")
  set par(justify: true, leading: 0.55em, spacing: 0.8em)
  set page(
    paper: "a4",
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 25mm),
    numbering: "1",
    number-align: center,
    header: context {
      // Net als bij LaTeX maketitle: geen koplogo op de titelpagina.
      if counter(page).get().first() > 1 {
        align(right, image(logo, width: 45mm))
        v(2mm)
        line(length: 100%, stroke: 0.4pt)
      }
    },
  )
  set heading(numbering: none)
  show heading.where(level: 1): set text(size: 14pt, weight: "bold")
  show heading.where(level: 2): set text(size: 11pt, weight: "bold")
  show heading: set block(above: 1.3em, below: 0.6em)
  set math.equation(numbering: "(1)")
  set table(stroke: none, inset: (x: 8pt, y: 6pt))
  show table: set par(justify: false)
  show figure.caption: set text(size: 10pt)
  show figure.where(kind: table): set figure.caption(position: top)

  align(center)[
    #set par(justify: false)
    #image(logo, width: 50%)
    #v(8mm)
    #text(size: 22pt, titel)
    #v(6mm)
    *Studenten*: #studenten
    #if studentnummer != none [\ *Studentnummer*: #studentnummer]
    \ *Begeleiders*: #begeleiders
    \ *Studie*: #studie
    #v(4mm)
    #if type(datum) == datetime {
      let maanden = ("januari", "februari", "maart", "april", "mei", "juni",
        "juli", "augustus", "september", "oktober", "november", "december")
      [#datum.day() #maanden.at(datum.month() - 1) #datum.year()]
    } else { datum }
  ]
  v(5mm)
  line(length: 100%, stroke: 0.5pt)
  v(3mm)
  body
}

// Alle opmaak staat hier. Je inhoud schrijf je in start.typ.
// body is de inhoud die via de show-regel aan deze functie wordt meegegeven.
#let beginnersdocument(titel: "Mijn eerste document", auteur: "Jouw naam", studentnummer: "1234567", body) = {
  set document(title: titel, author: auteur)
  set page(paper: "a4", margin: 25mm, numbering: "1")
  set text(font: ("Arial", "Liberation Sans"), size: 10.5pt, lang: "nl")
  set math.equation(numbering: "(1)")
  set par(justify: true, leading: 0.55em, spacing: 0.65em)
  set heading(numbering: none)
  show heading.where(level: 1): set text(size: 15pt, weight: "bold")
  show heading.where(level: 2): set text(size: 11.5pt, weight: "bold")
  show heading: set block(above: 1.2em, below: 0.55em)
  set table(stroke: none, inset: (x: 9pt, y: 6pt))
  show table: set par(justify: false)
  show raw.where(block: true): set par(justify: false)
  show table.cell.where(y: 0): set text(weight: "bold")
  show figure.caption: set text(size: 9pt)
  show figure.where(kind: table): set figure.caption(position: top)
  show raw.where(block: true): it => block(
    width: 100%, inset: 8pt, fill: luma(96%), radius: 3pt, it,
  )

  text(size: 23pt, weight: "bold", titel)
  v(3mm)
  text(size: 10pt, fill: luma(40%), auteur)
  linebreak()
  text(size: 10pt, fill: luma(40%), studentnummer)
  v(3mm)
  line(length: 100%, stroke: 0.6pt + luma(70%))
  v(3mm)
  body
}

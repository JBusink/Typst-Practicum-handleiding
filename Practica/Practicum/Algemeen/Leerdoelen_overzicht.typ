#import "../../styl.typ": *
#show: stijl.with(titel: "Leerdoelen overzicht", kop: "Technische Natuurkunde — Practicum")

#page(flipped: true, margin: 1.5cm, header: none, footer: none)[
#set text(size: 9pt)
#figure(
  [
#table(
  columns: (1.5fr,1.5fr,2.5fr,3fr,4fr,8fr,),
  align: (center,center,center,left,left,left,),
  table.header(table.cell(x: 0, y: 0)[#strong[Week]], table.cell(x: 1, y: 0)[#strong[Dagdeel]], table.cell(x: 2, y: 0)[#strong[Datum]], table.cell(x: 3, y: 0)[#strong[Voorbereiding]], table.cell(x: 4, y: 0)[#strong[Af te ronden/inleveren]], table.cell(x: 5, y: 0)[#strong[Leerdoelen]]),
  table.cell(x: 0, y: 1, colspan: 6, align: center, fill: rgb("E6E6E6"))[#strong[Blok 1]],
  table.cell(x: 0, y: 2)[1],
  table.cell(x: 1, y: 2)[1],
  table.cell(x: 2, y: 2)[1-sep],
  table.cell(x: 3, y: 2)[Géén voorbereiding in verband met start collegejaar.],
  table.cell(x: 4, y: 2)[- Digitaal Labjournaal (DLJ) beschikbaar

- Geometrische optica experiment aanwezig & volledig in DLJ],
  table.cell(x: 5, y: 2)[],
  table.cell(x: 0, y: 3, fill: rgb("F2F2FF"))[2],
  table.cell(x: 1, y: 3, fill: rgb("F2F2FF"))[2],
  table.cell(x: 2, y: 3, fill: rgb("F2F2FF"))[8-sep],
  table.cell(x: 3, y: 3, fill: rgb("F2F2FF"))[Getekende opstelling in DLJ],
  table.cell(x: 4, y: 3, fill: rgb("F2F2FF"))[],
  table.cell(x: 5, y: 3, fill: rgb("F2F2FF"))[],
  table.cell(x: 0, y: 4, fill: rgb("F2F2FF"))[2],
  table.cell(x: 1, y: 4, fill: rgb("F2F2FF"))[3],
  table.cell(x: 2, y: 4, fill: rgb("F2F2FF"))[8-sep],
  table.cell(x: 3, y: 4, fill: rgb("F2F2FF"))[\-],
  table.cell(x: 4, y: 4, fill: rgb("F2F2FF"))[],
  table.cell(x: 5, y: 4, fill: rgb("F2F2FF"))[],
  table.cell(x: 0, y: 5)[2],
  table.cell(x: 1, y: 5)[4],
  table.cell(x: 2, y: 5)[10-sep],
  table.cell(x: 3, y: 5)[\-],
  table.cell(x: 4, y: 5)[],
  table.cell(x: 5, y: 5)[],
  table.cell(x: 0, y: 6, fill: rgb("F2F2FF"))[3],
  table.cell(x: 1, y: 6, fill: rgb("F2F2FF"))[5],
  table.cell(x: 2, y: 6, fill: rgb("F2F2FF"))[15-sep],
  table.cell(x: 3, y: 6, fill: rgb("F2F2FF"))[Kalibratie formules in DLJ],
  table.cell(x: 4, y: 6, fill: rgb("F2F2FF"))[],
  table.cell(x: 5, y: 6, rowspan: 3, fill: rgb("F2F2FF"))[+ 3

+ 3

+ 3],
  table.cell(x: 0, y: 7, fill: rgb("F2F2FF"))[3],
  table.cell(x: 1, y: 7, fill: rgb("F2F2FF"))[6],
  table.cell(x: 2, y: 7, fill: rgb("F2F2FF"))[15-sep],
  table.cell(x: 3, y: 7, fill: rgb("F2F2FF"))[\-],
  table.cell(x: 4, y: 7, fill: rgb("F2F2FF"))[],
  table.cell(x: 0, y: 8)[3],
  table.cell(x: 1, y: 8)[7],
  table.cell(x: 2, y: 8)[17-sep],
  table.cell(x: 3, y: 8)[\-],
  table.cell(x: 4, y: 8)[],
)
  ],
  caption: [Planning week, dagdeel en voorbereidingen voor eerste groep.],
  kind: table,
)

]

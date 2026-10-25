#import "../../styl.typ": *
#show: stijl.with(titel: "P2", kop: "Technische Natuurkunde — Planning")

#page(flipped: true, margin: 1.5cm, header: none, footer: none)[
#set text(size: 9pt)
#heading(level: 1, numbering: none)[Planning Periode 2]

#figure(
  [
#table(
  columns: (1.5fr,1.5fr,2fr,2fr,2fr,3fr,3fr,3fr,),
  align: (center,center,center,center,center,left,left,left,),
  table.header(table.cell(x: 0, y: 0)[#strong[kalender week]], table.cell(x: 1, y: 0)[#strong[Periode week]], table.cell(x: 2, y: 0)[#strong[Ma 12:00-14:30]], table.cell(x: 3, y: 0)[#strong[Ma 14:30-17:00]], table.cell(x: 4, y: 0)[#strong[Vrij 15:20-17:50]], table.cell(x: 5, y: 0)[#strong[Activiteit Bijeenkomst 1]], table.cell(x: 6, y: 0)[#strong[Activiteit Bijeenkomst 2]], table.cell(x: 7, y: 0)[#strong[Activiteit Bijeenkomst 3]]),
  table.cell(x: 0, y: 1, colspan: 8, align: center, fill: rgb("E6E6E6"))[#strong[Blok 2]],
  table.cell(x: 0, y: 2)[46],
  table.cell(x: 1, y: 2)[1],
  table.cell(x: 2, y: 2)[9-nov],
  table.cell(x: 3, y: 2)[9-nov],
  table.cell(x: 4, y: 2)[13-nov],
  table.cell(x: 5, y: 2, colspan: 2, align: center)[Aeropendulum (Open Loop) Gr. 1#super[1]],
  table.cell(x: 7, y: 2)[\-],
  table.cell(x: 0, y: 3)[47],
  table.cell(x: 1, y: 3)[2],
  table.cell(x: 2, y: 3)[16-nov],
  table.cell(x: 3, y: 3)[16-nov],
  table.cell(x: 4, y: 3)[20-nov],
  table.cell(x: 5, y: 3, colspan: 2, align: center)[Aeropendulum (Open Loop) Gr. 2#super[1]],
  table.cell(x: 7, y: 3)[\-],
  table.cell(x: 0, y: 4)[48],
  table.cell(x: 1, y: 4)[3],
  table.cell(x: 2, y: 4)[23-nov],
  table.cell(x: 3, y: 4)[23-nov],
  table.cell(x: 4, y: 4)[27-nov],
  table.cell(x: 5, y: 4, colspan: 2, align: center)[Aeropendulum (PID) Gr. 1],
  table.cell(x: 7, y: 4)[\-],
  table.cell(x: 0, y: 5)[49],
  table.cell(x: 1, y: 5)[4],
  table.cell(x: 2, y: 5)[30-nov],
  table.cell(x: 3, y: 5)[30-nov],
  table.cell(x: 4, y: 5)[4-dec],
  table.cell(x: 5, y: 5, colspan: 2, align: center)[Aeropendulum (PID) Gr. 2],
  table.cell(x: 7, y: 5)[\-],
  table.cell(x: 0, y: 6)[50],
  table.cell(x: 1, y: 6)[5],
  table.cell(x: 2, y: 6)[7-dec],
  table.cell(x: 3, y: 6)[7-dec],
  table.cell(x: 4, y: 6)[11-dec],
  table.cell(x: 5, y: 6, colspan: 2, align: center)[Constante van Planck Gr. 1],
  table.cell(x: 7, y: 6)[\-],
  table.cell(x: 0, y: 7)[51],
  table.cell(x: 1, y: 7)[6],
  table.cell(x: 2, y: 7)[14-dec],
  table.cell(x: 3, y: 7)[14-dec],
  table.cell(x: 4, y: 7)[18-dec],
  table.cell(x: 5, y: 7, colspan: 2, align: center)[Constante van Planck Gr. 2],
  table.cell(x: 7, y: 7)[\-],
  table.cell(x: 0, y: 8, fill: rgb("FFCCCC"))[52],
  table.cell(x: 1, y: 8, fill: rgb("FFCCCC"))[\-],
  table.cell(x: 2, y: 8, colspan: 6, align: center, fill: rgb("FFCCCC"))[#strong[Kerstvakantie (22--28 dec)]],
  table.cell(x: 0, y: 9, fill: rgb("FFCCCC"))[1],
  table.cell(x: 1, y: 9, fill: rgb("FFCCCC"))[\-],
  table.cell(x: 2, y: 9, colspan: 6, align: center, fill: rgb("FFCCCC"))[#strong[Kerstvakantie (29 dec--4 jan)]],
  table.cell(x: 0, y: 10)[2],
  table.cell(x: 1, y: 10)[7],
  table.cell(x: 2, y: 10)[4-jan],
  table.cell(x: 3, y: 10)[4-jan],
  table.cell(x: 4, y: 10)[8-jan],
  table.cell(x: 5, y: 10, colspan: 2, align: center)[Groep 1: zonnecel practicum#super[2]],
  table.cell(x: 7, y: 10)[\-],
  table.cell(x: 0, y: 11)[3],
  table.cell(x: 1, y: 11)[8],
  table.cell(x: 2, y: 11)[11-jan],
  table.cell(x: 3, y: 11)[11-jan],
  table.cell(x: 4, y: 11)[15-jan],
  table.cell(x: 5, y: 11, colspan: 2, align: center)[Groep 2: zonnecel practicum#super[2]],
  table.cell(x: 7, y: 11)[\-],
  table.cell(x: 0, y: 12)[4],
  table.cell(x: 1, y: 12)[9],
  table.cell(x: 2, y: 12, colspan: 6, align: center)[#strong[Herkansing op afspraak]],
  table.cell(x: 0, y: 13)[5],
  table.cell(x: 1, y: 13)[10],
  table.cell(x: 2, y: 13, colspan: 6, align: center)[#strong[Geen practicum / tentamens]],
)
  ],
  caption: [Planning practica blok 2.],
  kind: table,
)

#text(size: 8pt)[#super[1] Locatie op Nikola Tulphuis.]

#text(size: 8pt)[#super[2] Studenten worden geacht alle bijeenkomsten bij te wonen, geldt ook voor de PID, Constante van Planck & zonnecel practica.]

]

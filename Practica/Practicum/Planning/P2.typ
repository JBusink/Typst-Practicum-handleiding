#import "../../styl.typ": *
#show: stijl.with(titel: "P2", kop: "Technische Natuurkunde — Planning")

#page(flipped: true, margin: 1.5cm, header: none, footer: none)[
  #set text(size: 9pt)
  #heading(level: 1, numbering: none)[Planning Periode 2]

  #figure(
    [
      #table(
        columns: (1.5fr, 1.5fr, 2fr, 2fr, 2fr, 3fr, 3fr, 3fr),
        align: (center, center, center, center, center, left, left, left),

        table.header(
          [*Kalenderweek*],
          [*Periodeweek*],
          [*Ma 12:00-14:30*],
          [*Ma 14:30-17:00*],
          [*Vrij 15:20-17:50*],
          [*Activiteit Bijeenkomst 1*],
          [*Activiteit Bijeenkomst 2*],
          [*Activiteit Bijeenkomst 3*],
        ),

        table.cell(colspan: 8, align: center, fill: rgb("E6E6E6"))[*Blok 2*],

        // Week 1
        [46], [1], [9-nov], [9-nov], [13-nov],
        table.cell(colspan: 3, align: center)[-],

        // Week 2
        [47], [2], [16-nov], [16-nov], [20-nov],
        table.cell(colspan: 3, align: center)[-],

        // Week 3
        [48], [3], [23-nov], [23-nov], [27-nov],
        table.cell(colspan: 2, align: center)[Aeropendulum (Open Loop) Gr. 1#super[1]],
        [-],

        // Week 4
        [49], [4], [30-nov], [30-nov], [4-dec],
        table.cell(colspan: 2, align: center)[Aeropendulum (Open Loop) Gr. 2#super[1]],
        [-],

        // Week 5
        [50], [5], [7-dec], [7-dec], [11-dec],
        table.cell(colspan: 2, align: center)[Aeropendulum (PID) Gr. 1],
        [-],

        // Week 6
        [51], [6], [14-dec], [14-dec], [18-dec],
        table.cell(colspan: 2, align: center)[Aeropendulum (PID) Gr. 2],
        [-],

        // Kerstvakantie
        table.cell(fill: rgb("FFCCCC"))[52],
        table.cell(fill: rgb("FFCCCC"))[-],
        table.cell(colspan: 6, align: center, fill: rgb("FFCCCC"))[
          *Kerstvakantie (22--28 dec)*
        ],

        table.cell(fill: rgb("FFCCCC"))[1],
        table.cell(fill: rgb("FFCCCC"))[-],
        table.cell(colspan: 6, align: center, fill: rgb("FFCCCC"))[
          *Kerstvakantie (29 dec--4 jan)*
        ],

        // Week 7
        [2], [7], [4-jan], [4-jan], [8-jan],
        table.cell(colspan: 2, align: center)[Zonnecelpracticum Gr. 1#super[2]],
        [-],

        // Week 8
        [3], [8], [11-jan], [11-jan], [15-jan],
        table.cell(colspan: 2, align: center)[Zonnecelpracticum Gr. 2#super[2]],
        [-],

        // Week 9
        [4], [9],
        table.cell(colspan: 6, align: center)[*Herkansing op afspraak*],

        // Week 10
        [5], [10],
        table.cell(colspan: 6, align: center)[*Geen practicum / tentamens*],
      )
    ],
    caption: [Planning practica blok 2.],
    kind: table,
  )
  
  #text(size: 8pt)[#super[2] Studenten worden geacht de volledige practicumdag (12:00–17:00) aanwezig te zijn. Dit geldt voor alle practica.]
]
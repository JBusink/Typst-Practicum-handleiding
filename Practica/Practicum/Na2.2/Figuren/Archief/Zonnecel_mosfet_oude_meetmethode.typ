
#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

#let zonnecel-schakeling() = zap.circuit({
  import zap: *

  let kleur = rgb("#242424")
  let lijn = (paint: kleur, thickness: 1pt)

  // =========================================
  // 1. COORDINATEN
  // =========================================

  let drain = (1.15, 2.29)
  let source = (1.15, 1.61)
  let gate = (0.5, 2.0)

  let source-meetpunt = (1.15, 1.2)
  let rail-boven = 4.4
  let rail-onder = -1.3

  let deler-x = 4.6
  let deler-midden = 1.55
  let pv-x = 7.2

  // =========================================
  // 2. MOSFET (CeTZ)
  // =========================================

  // Gate, elektrisch geïsoleerd van kanaal
  draw.line(
    (0.5, 1.48),
    (0.5, 2.52),
    stroke: lijn,thickness: 2.5pt
  )

    // Gate, elektrisch geïsoleerd van kanaal
  draw.line(
    (0.7, 1.48),
    (0.7, 2.52),
    stroke: lijn,
  )

  // Drain en source
  draw.line(
    drain, (1.15, 4.4),
    stroke: lijn,
  )
  draw.line(
    source, source-meetpunt,
    stroke: lijn,
  )

  // Kleine verbinding tussen kanaalsegmenten
  draw.line(
    (1.15, 1.6), (.7, 1.6),
    stroke: lijn,
  )
    draw.line(
    (1.15, 2.3), (.7, 2.3),
    stroke: lijn,
  )
  // draw.content(
  //   (1.85, 2.1),
  //   text(size: 9pt)[Q1 (NMOS)],
  // )

  // =========================================
  // 3. GATEWEERSTAND EN U0
  // =========================================

  resistor(
    "Rg",
    (-1.7, 2.0),
    (-1.7, 4.0),
    label: [1 kΩ],
  )

  wire((-1.7, 2.0), gate)

  // Open aansluiting U0
  draw.circle(
    (-1.7, 4.0),
    radius: 0.085,
    fill: white,
    stroke: lijn,
  )
  draw.content((-1.7, 4.35), $U_0$)

  // =========================================
  // 4. SHUNTWEERSTAND EN U2
  // =========================================

  resistor(
    "Rsh",
    source-meetpunt,
    (1.15, rail-onder),
    label: [4,7 Ω],
  )

  wire(source-meetpunt, (-0.65, 1.2))

  draw.circle(
    (-0.65, 1.2),
    radius: 0.085,
    fill: white,
    stroke: lijn,
  )

  draw.content((-1.05, 1.2), $U_2$)

  // =========================================
  // 5. BOVENSTE EN ONDERSTE RAIL
  // =========================================

  wire((1.15, rail-boven), (pv-x, rail-boven))

  wire(
    (1.15, rail-onder),
    (pv-x, rail-onder),
  )

  // =========================================
  // 6. SPANNINGSDELER
  // =========================================

  resistor(
    "Rboven",
    (deler-x, rail-boven),
    (deler-x, deler-midden),
    label: [2 MΩ],
  )

  resistor(
    "Ronder",
    (deler-x, deler-midden),
    (deler-x, rail-onder),
    label: [1 MΩ],
  )

  // Meetpunt U1
  wire(
    (deler-x, deler-midden),
    (3.4, deler-midden),
  )

  draw.circle(
    (3.4, deler-midden),
    radius: 0.085,
    fill: white,
    stroke: lijn,
  )

  draw.content((3.05, deler-midden), $U_1$)

  // =========================================
  // 7. ZONNECELBRON (CeTZ)
  // =========================================

  let pv-y = 1.55
  let pv-r = 0.55

  // Draden naar de bron
  wire(
    (pv-x, rail-boven),
    (pv-x, pv-y + pv-r),
  )
  wire(
    (pv-x, pv-y - pv-r),
    (pv-x, rail-onder),
  )

  // Omlijning van PV-bron
  draw.circle(
    (pv-x, pv-y),
    radius: pv-r,
    fill: white,
    stroke: lijn,
  )

  // Gestileerde zonnecel in de bron
  draw.line(
  (7.2, 1.45),
  (7.2, 1.0),
  stroke: (paint: kleur, thickness: 1.0pt),
)


  // Gestileerde zonnecel in de bron
  draw.line(
  (7.2, 1.65),
  (7.2, 2.1),
  stroke: (paint: kleur, thickness: 1.0pt),
)

draw.line(
  (6.77, 1.65),
  (7.63, 1.65),
  stroke: (paint: kleur, thickness: 1.0pt),
)

draw.line(
  (6.90, 1.45),
  (7.45, 1.45),
  stroke: lijn, thickness: 1.0pt,
)

  // Lichtinval
  draw.line(
    (6.5, 2.5),
    (6.85, 2.15),
    stroke: lijn,
    mark: (end: ">", fill: kleur),
  )

  draw.line(
    (6.8, 2.65),
    (7.1, 2.35),
    stroke: lijn,
    mark: (end: ">", fill: kleur),
  )

  draw.content(
    (8.15, 1.65),
    text(size: 9pt)[PV],
  )

  draw.content((7.75, 2.15), [+])
  draw.content((7.75, 0.95), [−])

  // =========================================
  // 8. GROUND EN KNOOPPUNTEN
  // =========================================


  // Klassiek aardesymbool
  let gx = pv-x
  let gy = rail-onder

  draw.line((gx, gy), (gx, gy - 0.2), stroke: lijn)

  draw.line(
    (gx - 0.35, gy - 0.2),
    (gx + 0.35, gy - 0.2),
    stroke: lijn,
  )
  draw.line(
    (gx - 0.23, gy - 0.33),
    (gx + 0.23, gy - 0.33),
    stroke: lijn,
  )
  draw.line(
    (gx - 0.11, gy - 0.46),
    (gx + 0.11, gy - 0.46),
    stroke: lijn,
  )

  for p in (
    source-meetpunt,
    (deler-x, rail-boven),
    (deler-x, rail-onder),
    (deler-x, deler-midden),
    (1.15, rail-onder),
  ) {
    draw.circle(
      p,
      radius: 0.055,
      fill: kleur,
      stroke: none,
    )
  }
})

#figure(
  zonnecel-schakeling(),
  caption: [
    Zonnecelpracticum: MOSFET-belasting met
    stroommeting en spanningsdeler.
  ],
)

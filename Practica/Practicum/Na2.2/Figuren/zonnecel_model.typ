
#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

#let zonnecel-schema() = zap.circuit({
  import zap: *

  // ==========================================
  // 1. Blauwe achtergrond van de zonnecel
  // ==========================================

  draw.rect(
    (-0.6, -0.5),
    (3., 4.5),
    fill: rgb("#E8F2FC"),
    stroke: rgb("#666a6e") + 1pt,
  )

  // ==========================================
  // 2. Invallende lichtgolven
  // ==========================================

  // Twee sinusgolven, onder een hoek van -25 graden
  for j in range(2) {
    for k in range(48) {
      let x0 = -1.1 + k * 0.035
      let x1 = -1.1 + (k + 1) * 0.035

      let y0 = (
        3.5 + j * 0.35
        - 0.47 * (x0 + 1.1)
        + 0.085 * calc.sin(k * 18deg)
      )

      let y1 = (
        3.5 + j * 0.35
        - 0.47 * (x1 + 1.1)
        + 0.085 * calc.sin((k + 1) * 18deg)
      )

      draw.line(
        (x0, y0),
        (x1, y1),
        stroke: black + 0.7pt,
      )
    }
  }

  draw.content(
    (-1.3, 3.1),
    $lambda_"in"$,
  )

  draw.content(
    (1.2, 4.8),
    text(size: 11pt)[Zonnecel],
  )

  // ==========================================
  // 3. Fotostroombron
  // ==========================================

  isource(
    "Iph",
    (0, 0),
    (0, 4),
    label: $I_"ph"$,
  )

  // ==========================================
  // 4. Diode parallel aan stroombron
  // ==========================================

  wire((0, 4), (2, 4))
  wire((0, 0), (2, 0))

  diode(
    "D",
    (2, 4),
    (2, 0),
    label: $I_D$,
  )

  // ==========================================
  // 5. Ampèremeter
  // ==========================================

  ammeter(
    "A",
    (4, 2),
    (4, 4),
    label: $I$,
  )

  // ==========================================
  // 6. Variabele belastingsweerstand
  // ==========================================

  resistor(
    "R",
    (4, 0),
    (4, 2),
    variable: true,
    label: $R$,
  )

  // ==========================================
  // 7. Verbindingen
  // ==========================================

  wire((0, 4), (4, 4))
  wire((4, 4), (6, 4))

  wire((0, 0), (4, 0))
  wire((4, 0), (6, 0))

  // ==========================================
  // 8. Voltmeter parallel aan belasting
  // ==========================================

  voltmeter(
    "V",
    (6, 0),
    (6, 4),
    label: $V$,
  )
})

// Tekening invoegen
#zonnecel-schema()

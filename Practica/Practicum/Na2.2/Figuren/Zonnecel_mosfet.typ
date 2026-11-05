// Lineaire indeling naar Zonnecel_mosfet_raspberry_PI.pdf.
// Elektrische verbindingen volgens PCB_schema_V1; VBUS controleren op de module.
#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

#align(center, zap.circuit({
  import zap: *
  let txt(p, body, anchor: "center") = draw.content(p, text(size: 8pt, body), anchor: anchor)
  let dot(p) = draw.circle(p, radius: 0.07, fill: black)
  let supply(name, p) = {
    vcc(name, p)
    txt((rel: (0, 0.8), to: p), [3V3])
  }


  // Hoofdrij: Pico — DAC — INA226 — MOSFET — zonnecel.
  draw.rect((0, 4.1), (3, 6.8), fill: white)
  txt((1.5, 6.45), [*Pico*])
  txt((2.8, 6), [GP20 / SDA], anchor: "east")
  txt((2.8, 5.3), [GP21 / SCL], anchor: "east")
  txt((0.15, 5.3), [GND], anchor: "west")
  wire((0, 5.3), (-0.45, 5.3))
  wire((-0.45, 5.3), (-0.45, 1.8))
  /* ADC-poorten bij het uitgecommentarieerde NTC-netwerk.
  for (x, gp) in ((0.5, "28"), (1.5, "27"), (2.5, "26")) {
    txt((x, 4.25), gp)

  }
  */
  wire((1.5, 6.8), (1.5, 11.2), (8.6, 11.2))
  txt((1.7, 7.2), [3V3 OUT · 36], anchor: "west")
  txt((2.9, 11.45), [3,3 V])

  draw.rect((5, 4.8), (7.8, 6.8), fill: white)
  txt((6.4, 6.05), [*MCP4725*])
  txt((7.65, 5.4), [OUT], anchor: "east")
  txt((5.45, 6.75), [SDA], anchor: "north")
  txt((7.2, 6.75), [SCL], anchor: "north")
  wire((5.5, 4.8), (5.5, 4.35))
  txt((5.5, 4.95), [VDD], anchor: "south")
  wire((7.2, 4.8), (7.2, 1.8))

  draw.rect((9, 4.8), (11.8, 6.8), fill: white)
  txt((10.4, 6.05), [*INA226*])
  txt((9.45, 6.75), [SDA], anchor: "north")
  txt((11.2, 6.75), [SCL], anchor: "north")
  txt((11.65, 5.65), [IN+ / VBUS], anchor: "east")
  txt((11.65, 5.1), [IN−], anchor: "east")
  wire((9.5, 4.8), (9.5, 4.35))
  txt((9.5, 4.95), [VCC], anchor: "south")
  wire((11.2, 4.8), (11.2, 1.8))

  // Gemeenschappelijke I²C-bus, boven de modules.
  wire((3, 6), (3.6, 6), (3.6, 8.6), (9.45, 8.6), (9.45, 6.8))
  wire((3, 5.3), (4.2, 5.3), (4.2, 8), (11.2, 8), (11.2, 6.8))
  wire((5.45, 8.6), (5.45, 6.8))
  wire((7.2, 8), (7.2, 6.8))
  dot((5.45, 8.6)); dot((7.2, 8))
  txt((6.4, 8.85), [SDA])
  txt((10.3, 8.25), [SCL])

  nmos("Q1", (14, 5.8))
  txt((14, 7.1), [Q1\ IRLZ44N])
  wire((11.8, 5.1), (12.3, 5.1), (12.3, 6.65), (14, 6.65), "Q1.d")
  wire((7.8, 5.4), (8.2, 5.4), (8.2, 3.75), (12.7, 3.75),
    ("Q1.g", "|-", (12.7, 3.75)), "Q1.g")
  wire("Q1.s", (14, 1.8))

  draw.rect((15.8, 4.8), (17.8, 6.8), fill: white)
  txt((16.8, 6.35), [*SC1*])
  txt((16.8, 5.95), [Zonnecel])
  txt((16.3, 6.65), [+])
  txt((16.8, 5), [−])
  wire((11.8, 5.65), (12, 5.65), (12, 8.6), (16.3, 8.6), (16.3, 6.8))
  wire((16.8, 4.8), (16.8, 1.8))

  // Pull-ups rechtstreeks op de bus en de 3V3-rail van de Pico.
  resistor("R1", (5.45, 11.2), (5.45, 8.6))
  resistor("R2", (7.2, 11.2), (7.2, 8))
  txt((5.05, 10.1), [R1\ 4,7 kΩ], anchor: "east")
  txt((7.6, 10.1), [R2\ 4,7 kΩ], anchor: "west")
  dot((5.45, 11.2))

  // Beide modulevoedingen komen rechtstreeks van Pico-pin 36.
  wire((4.7, 11.2), (4.7, 4.35), (5.5, 4.35))
  wire((8.6, 11.2), (8.6, 4.35), (9.5, 4.35))
  for p in ((4.7, 11.2), (7.2, 11.2), (5.5, 4.35), (9.5, 4.35)) { dot(p) }

  // Ontkoppeling direct aan de voedingspin van iedere module.
  for (x, c) in ((5.5, "C1"), (9.5, "C2")) {
    wire((x, 4.35), (x, 3.6))
    capacitor(c, (x, 3.6), (x, 2.2))
    txt((x + 0.4, 2.9), [#c\ 100 nF], anchor: "west")
    wire((x, 2.2), (x, 1.8))
  }

  /* NTC-netwerk tijdelijk niet weergegeven.
  // ADC-bedrading boven de drie sensorkolommen, zonder kruisingen.
  for (pin-x, route-y, x, th, r) in (
    (0.5, 0, 5, "TH1", "R4"),
    (1.5, 0.6, 10, "TH2", "R3"),
    (2.5, 1.2, 15, "TH3", "R5"),
  ) {
    wire((pin-x, 4.1), (pin-x, route-y), (x - 1, route-y),
      (x - 1, -3), (x, -3))
    supply("v-" + th, (x, -1.2))
    resistor(r, (x, -1.2), (x, -3))
    txt((x + 0.4, -2.1), [#r\ 10 kΩ], anchor: "west")
    dot((x, -3))
    resistor(th, (x, -3), (x, -4.6))
    txt((x + 0.4, -3.8), [#th\ NTC], anchor: "west")
    draw.line((x - 0.3, -4.05), (x + 0.3, -3.55))
    wire((x, -4.6), (x, -5.3))
  }
  // Onderste massatak hoort bij dit netwerk.
  wire((17.5, 1.8), (17.5, -5.3), (5, -5.3))
  for x in (10, 15) { dot((x, -5.3)) }
  */
  // Eén doorlopende massaverbinding.
  wire((-0.45, 1.8), (17.5, 1.8))
  for x in (5.5, 7.2, 9.5, 11.2, 14, 16.8) { dot((x, 1.8)) }
  earth("gnd", (17.5, 1.8))
  txt((16.8, 1.4), [GND], anchor: "east")

  // Draadbrug: horizontale draad passeert de verticale zonder contact.
  let bridge(x, y) = {
    draw.line((x - 0.2, y), (x + 0.2, y), stroke: 3pt + white)
    wire((x, y - 0.32), (x, y + 0.32))
    draw.bezier((x - 0.2, y), (x + 0.2, y),
      (x - 0.2, y + 0.3), (x + 0.2, y + 0.3), stroke: 3pt + white)
    draw.bezier((x - 0.2, y), (x + 0.2, y),
      (x - 0.2, y + 0.3), (x + 0.2, y + 0.3), stroke: 0.6pt + black)
  }
  for (x, y) in ((7.2, 8.6), (5.45, 8), (9.45, 8),
      (9.5, 3.75), (11.2, 3.75),
      (4.7, 8.6), (4.7, 8), (8.6, 8.6), (8.6, 8)) {
    bridge(x, y)
  }
}, length: 0.88cm))

// PCB_schema_V1; module-interne VBUS-verbinding te controleren.
#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

#zap.circuit({
  import zap: *
  let txt(p, body, anchor: "center") = draw.content(p, text(size: 8pt, body), anchor: anchor)
  let dot(p) = draw.circle(p, radius: 0.045, fill: black)
  let supply(name, p) = {
    vcc(name, p)
    txt((rel: (0, 0.85), to: p), [3V3])
  }
  // Pico en moduleconnectoren; overige componenten en bedrading zijn Zap-symbolen.
  draw.rect((0, 5), (3.3, 10), fill: white)
  txt((1.65, 9.6), [*Raspberry Pi Pico*])
  for (y, label) in ((9, [GP20 / SDA]), (8.3, [GP21 / SCL]),
    (7.3, [GP26 / ADC0]), (6.6, [GP27 / ADC1]), (5.9, [GP28 / ADC2])) {
    txt((3.1, y), label, anchor: "east")
  }
  txt((0.2, 8.9), [USB], anchor: "west")
  txt((1.65, 5.25), [GND])
  wire((1.65, 5), (1.65, 4.7))
  ground("g-pico", (1.65, 4.7))
  txt((1.6, 10), [3V3], anchor: "south")
  supply("v-pico", (1.6, 10.5))
  wire((1.6, 10), (1.6, 10.5))

  draw.rect((7, 8), (10.3, 10.2), fill: white)
  txt((8.65, 9.9), [*J2 · INA226*])
  txt((7.15, 9), [SDA], anchor: "west")
  txt((7.15, 8.3), [SCL], anchor: "west")
  txt((10.15, 9.3), [IN+ / VBUS], anchor: "east")
  txt((10.15, 8.6), [IN−], anchor: "east")
  supply("v-ina", (8.6, 10.2))
  ground("g-ina", (8.6, 8))

  draw.rect((7, 5.4), (10.3, 7.3), fill: white)
  txt((8.65, 7), [*J1 · MCP4725*])
  txt((7.15, 6.4), [SDA], anchor: "west")
  txt((7.15, 5.7), [SCL], anchor: "west")
  txt((10.15, 6.1), [VOUT], anchor: "east")
  supply("v-dac", (9.7, 7.3))
  ground("g-dac", (8.6, 5.4))

  wire((3.3, 9), (7, 9))
  wire((3.3, 8.3), (7, 8.3))
  wire((4.4, 9), (4.4, 6.4), (7, 6.4))
  wire((5.7, 8.3), (5.7, 5.7), (7, 5.7))
  for p in ((4.4, 9), (5.7, 8.3)) { dot(p) }
  resistor("R1", (4.4, 9), (4.4, 11))
  txt((3.8, 10.45), [R1\ 4,7 kΩ], anchor: "east")
  resistor("R2", (5.7, 8.3), (5.7, 11))
  txt((6.1, 10.45), [R2\ 4,7 kΩ], anchor: "west")
  supply("v-r1", (4.4, 11))
  supply("v-r2", (5.7, 11))

  // Vermogenspad via de shunt op de INA226-module.
  draw.rect((12, 10.4), (14.2, 11.5), fill: white)
  txt((13.1, 11), [SC1 · zonnecel])
  txt((12.4, 10.6), [+])
  txt((13.8, 10.6), [−])
  wire((12.4, 10.4), (12.4, 9.3), (10.3, 9.3))
  ground("g-pv", (13.8, 10.4))
  nmos("Q1", (13, 6.5))
  wire((10.3, 8.6), (13, 8.6), "Q1.d")
  wire((10.3, 6.1), (11.2, 6.1), ("Q1.g", "|-", (11.2, 6.1)), "Q1.g")
  ground("g-q", "Q1.s")
  txt((14, 6.9), [Q1\ IRLZ44N])

  // Analoge kanalen: de bovenste verbinding loopt naar het verste kanaal.
  for (x, y, th, r) in ((13, 7.3, "TH3", "R5"), (9, 6.6, "TH2", "R3"), (5, 5.9, "TH1", "R4")) {
    let route = x - 1.4
    // Nets vermijden kruisingen met de I²C-bedrading boven de sensoren.
    txt((3.65, y), th, anchor: "west")
    wire((3.3, y), (3.55, y))
    supply("v-" + th, (x, 3.1))
    resistor(r, (x, 3.1), (x, 1.6))
    txt((x + 0.5, 2.35), [#r\ 10 kΩ], anchor: "west")
    dot((x, 1.6))
    wire((x, 1.6), (route, 1.6))
    txt((route - 0.1, 1.6), th, anchor: "east")
    resistor(th, (x, 1.6), (x, 0))
    txt((x + 0.5, 0.8), [#th\ NTC], anchor: "west")
    draw.line((x - 0.3, 0.55), (x + 0.3, 1.05))
    ground("g-" + th, (x, 0))
  }
  // Ontkoppeling.
  for (x, name) in ((0.5, "C1"), (2.5, "C2")) {
    supply("v-" + name, (x, 3.1))
    capacitor(name, (x, 3.1), (x, 0.8))
    txt((x + 0.4, 2.4), [#name\ 100 nF], anchor: "west")
    ground("g-" + name, (x, 0.8))
  }
})

// Gereconstrueerd uit foto’s van PCB Rev. 1.0, 5 november 2026.
// Pinfuncties Q1 veronderstellen G-D-S; controleer het werkelijk gemonteerde type.
// Waarden van module-shunt en overige onderdelen niet zichtbaar op de kale print.
#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

#zap.circuit({
  import zap: *
  let dot(p) = draw.circle(p, radius: 0.055, fill: black)
  let label(p, body) = draw.content(p, text(size: 9pt, body))
  // Vermogenspad. De cel is als bronblok getekend.
  draw.rect((0, 1.2), (1.5, 3), fill: white)
  label((0.75, 2.1), [Zonnecel])
  label((0.45, 2.75), [+])
  label((0.45, 1.45), [−])
  wire((0.75, 3), (0.75, 4.4))
  resistor("shunt", (2.5, 4.4), (5, 4.4), label: [$R_"shunt"$])
  wire((0.75, 4.4), (2.5, 4.4))
  wire((5, 4.4), (7.8, 4.4))
  wire((7.8, 4.4), (7.8, 2.8))
  // Gestileerde NMOS: geïsoleerde gate links, drain boven, source onder.
  draw.line((7.2, 1.8), (7.2, 2.8))
  draw.line((7.4, 1.8), (7.4, 2.8))
  draw.line((7.4, 2.8), (7.8, 2.8))
  draw.line((7.4, 1.8), (7.8, 1.8))
  label((8.7, 2.3), [Q1 / NMOS])
  label((8.2, 2.9), [D (2)])
  label((8.2, 1.7), [S (3)])
  label((6.8, 2.7), [G (1)])
  wire((7.8, 1.8), (7.8, 0.5))
  wire((7.8, 0.5), (0.75, 0.5))
  wire((0.75, 0.5), (0.75, 1.2))
  label((4, 0.15), [PV− / gemeenschappelijke GND])
  // Afzonderlijke shunt- en busspanningsmeting.
  draw.rect((2.2, 5.5), (5.3, 6.8), fill: white)
  label((3.75, 6.4), [INA226])
  label((3.75, 3.85), [Shunt op de module])
  label((2.6, 5.8), [IN+])
  label((4.8, 5.8), [IN−])
  label((1.65, 6.1), [VBUS])
  wire((2.5, 4.4), (2.5, 5.5))
  wire((5, 4.4), (5, 5.5))
  wire((0.75, 4.4), (0.75, 6.1))
  wire((0.75, 6.1), (2.2, 6.1))
  for p in ((0.75, 4.4), (2.5, 4.4), (5, 4.4)) { dot(p) }
  // Besturing; I²C weergegeven als functionele bus, niet als één draad.
  draw.rect((2.1, 1.7), (4.1, 2.9), fill: white)
  label((3.1, 2.3), [MCP4725])
  wire((4.1, 2.3), (7.2, 2.3))
  label((5.5, 2.7), [VOUT])
  label((4.8, 1.65), [$U_"DAC"$])
  label((4.4, -0.5), [Alle GND-aansluitingen horen bij dezelfde massa.])
})


#v(0.5em)
#align(center)[
  #text(size: 9pt)[Computer → USB → Pico → I²C → MCP4725 → gate van Q1]
  #linebreak()
  #text(size: 9pt)[Meetwaarden: INA226 → I²C → Pico → USB → computer]
]

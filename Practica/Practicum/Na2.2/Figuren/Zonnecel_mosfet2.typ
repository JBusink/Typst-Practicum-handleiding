
#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

#align(center, zap.circuit(
  {
    import zap: *

    let txt(p, body, anchor: "center") = {
      draw.content(
        p,
        text(size: 8pt, body),
        anchor: anchor,
      )
    }

    let dot(p) = {
      draw.circle(p, radius: 0.07, fill: black)
    }

    // =========================================
    // 1. Raspberry Pi Pico
    // =========================================

    draw.rect((0, 4.1), (3, 6.8), fill: white)

    txt((1.5, 6.45), [*Raspberry Pi Pico*])
    txt((2.8, 6), [SDA], anchor: "east")
    txt((2.8, 5.3), [SCL], anchor: "east")
    txt((1.5, 4.3), [GND])

    // =========================================
    // 2. MCP4725 DAC
    // =========================================

    draw.rect((5, 4.8), (7.8, 6.8), fill: white)

    txt((6.4, 6.05), [*MCP4725 DAC*])

    // I2C boven
    txt((5.45, 6.75), [SDA], anchor: "north")
    txt((7.2, 6.75), [SCL], anchor: "north")

    // Analoge uitgang rechts
    txt((7.65, 5.4), [OUT], anchor: "east")

    // Voeding onder
    txt((5.5, 4.95), [VDD], anchor: "south")
    txt((7.2, 4.95), [GND], anchor: "south")

    // =========================================
    // 3. I2C verbindingen
    // =========================================

    // SCL: Pico naar INA226
    wire(
      (3, 6.0),
      (4.5, 6.0),
      (4.5, 7.3),
      (5.4, 7.3),
      (5.4, 6.8),
    )

    // SDA: Pico naar INA226
    wire(
      (3, 6.5),
      (4., 6.5),
      (4, 7.5),
      (7.1, 7.5),
      (7.1, 6.8),
    )

    // =========================================
    // 4. Voeding DAC vanaf Pico
    // =========================================

    // 3V3 van Pico
    wire(
      (1.5, 6.8),
      (1.5, 8),
      (3.5, 8),
      (3.5, 4.35),
      (5.5, 4.35),
      (5.5, 4.8),
    )

// Draadbrug op kruising zonder elektrisch contact
    let bridge(x, y) = {
      // Onderliggende draad wit maken
      draw.line(
        (x - 0.2, y),
        (x + 0.2, y),
        stroke: 3pt + white,
      )
      wire((x, y - 0.32), (x, y + 0.32))


      // Boog over de kruising
      draw.bezier((x - 0.2, y), (x + 0.2, y), (x - 0.2, y + 0.3), (x + 0.2, y + 0.3), stroke: 3pt + white)
      draw.bezier((x - 0.2, y), (x + 0.2, y), (x - 0.2, y + 0.3), (x + 0.2, y + 0.3), stroke: 0.6pt + black)
    }

    // Twee kruisingen
    bridge(3.5, 6.5)
    bridge(3.5, 6)

    txt((1.8, 7.2), [3,3 V], anchor: "west")

    // =========================================
    // 5. IRLZ44N MOSFET
    // =========================================

    // N-kanaal enhancement MOSFET
    // Gate links, drain boven, source onder

    draw.circle((12, 4.3), radius: 0.9)

    // Gate
    draw.line((11.43, 3.8), (11.43, 4.78))

    // Kanaal
    for y in (3.97, 4.3, 4.63) {
      draw.line(
        (11.62, y - 0.1),
        (11.62, y + 0.1),
      )
    }

    // Drain
    wire(
      (11.62, 4.63),
      (12, 4.63),
      (12, 5.5),
    )

    // Source
    wire(
      (11.62, 3.97),
      (12, 3.97),
      (12, 3.1),
    )

    // Bulk/source
    wire((12, 3.97), (12, 4.3), (11.84, 4.3))

    draw.line(
      (11.64, 4.3),
      (11.84, 4.44),
      (11.84, 4.16),
      close: true,
      fill: black,
    )

    // Bodydiode
    wire(
      (12, 3.97),
      (12.45, 3.97),
      (12.45, 4.2),
    )

    draw.line(
      (12.3, 4.2),
      (12.6, 4.2),
      (12.45, 4.37),
      close: true,
      fill: black,
    )

    draw.line(
      (12.23, 4.28),
      (12.23, 4.4),
      (12.67, 4.4),
      (12.67, 4.48),
    )

    wire(
      (12.45, 4.4),
      (12.45, 4.63),
      (12, 4.63),
    )

    // Labels
    txt((13.05, 4.3), [*IRLZ44N*], anchor: "west")
    txt((12.2, 5.45), [Drain], anchor: "west")
    txt((10.5, 4.1), [Gate])
    txt((12.2, 3.15), [Source], anchor: "west")

    // =========================================
    // 6. DAC-uitgang naar MOSFET-gate
    // =========================================

    wire(
      (7.8, 5.4),
      (8.5, 5.4),
      (8.5, 4.3),
      // (10.8, 3.75),
      (10.8, 4.3),
      (11.45, 4.3),
    )

    // =========================================
    // 7. Zonnecel
    // =========================================

    draw.rect((15.8, 4.8), (17.8, 6.8), fill: white)

    txt((16.8, 5.95), [*Zonnecel*])
    txt((16.8, 6.65), [+])
    txt((16.8, 5), [−])

    // Plus zonnecel naar drain
    wire(
      (12, 5.5),
      (12, 7.5),
      (16.8, 7.5),
      (16.8, 6.8),
    )

    // Min zonnecel naar GND
    wire(
      (16.8, 4.8),
      (16.8, 2.4),
    )

    // Source MOSFET naar GND
    wire(
      (12, 3.1),
      (12, 2.4),
    )

    // =========================================
    // 8. Gemeenschappelijke GND
    // =========================================

    // Pico GND
    wire(
      (1.5, 4.1),
      (1.5, 2.4),
    )

    // DAC GND
    wire(
      (7.2, 4.8),
      (7.2, 2.4),
    )

    // Massarail
    wire(
      (1.5, 2.4),
      (17.5, 2.4),
    )

    // Knooppunten
    for x in (7.2, 12, 16.8) {
      dot((x, 2.4))
    }

    earth("gnd", (17.5, 2.4))
  },
  length: 0.88cm,
))

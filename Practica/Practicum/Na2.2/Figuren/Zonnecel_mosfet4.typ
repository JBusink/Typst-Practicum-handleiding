
#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

#align(center, zap.circuit(
  {
    import zap: *

    // ==========================================
    // Hulpfuncties
    // ==========================================

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

    // ==========================================
    // 1. Raspberry Pi Pico
    // ==========================================

    draw.rect((0, 4.1), (3, 6.8), fill: white)

    txt((1.5, 6.45), [*Raspberry Pi Pico*])
    txt((2.8, 6), [SDA], anchor: "east")
    txt((2.8, 5.3), [SCL], anchor: "east")
    txt((1.0, 4.3), [GND])

    // Voedingsrail 3,3 V
    wire(
      (1.5, 6.8),
      (1.5, 8.5),
      (8.6, 8.5),
    )

    txt((1.8, 7.2), [3,3 V], anchor: "west")

    // ==========================================
    // 2. MCP4725 DAC
    // ==========================================

    draw.rect((5, 4.8), (7.8, 6.8), fill: white)

    txt((6.4, 6.05), [*MCP4725*])

    txt((5.45, 6.75), [SDA], anchor: "north")
    txt((7.2, 6.75), [SCL], anchor: "north")

    txt((7.65, 5.4), [OUT], anchor: "east")

    txt((5.5, 4.95), [VDD], anchor: "south")
    txt((7.2, 4.95), [GND], anchor: "south")

    // ==========================================
    // 3. INA226
    // ==========================================

    draw.rect((9, 4.8), (11.8, 6.8), fill: white)

    txt((10.4, 6.05), [*INA226*])

    txt((9.45, 6.75), [SDA], anchor: "north")
    txt((10.5, 6.75), [SCL], anchor: "north")

    txt((11.65, 6.3), [IN+], anchor: "east")
    txt((11.65, 5.8), [IN−], anchor: "east")
    txt((11.65, 5.4), [VBUS], anchor: "east")

    txt((9.5, 4.95), [VCC], anchor: "south")
    txt((11.3, 4.90), [GND], anchor: "south")

    // ==========================================
    // 4. Gemeenschappelijke I2C-bus
    // ==========================================

    // SDA
    wire(
      (3, 6),
      (3.6, 6),
      (3.6, 8.),
      (9.45, 8.),
      (9.45, 6.8),
    )

    wire((5.45, 8.0), (5.45, 6.8))
    dot((5.45, 8.0))

    // SCL
    wire(
      (3, 5.3),
      (4.2, 5.3),
      (4.2, 7.5),
      (10.5, 7.5),
      (10.5, 6.8),
    )

    wire((7.2, 8), (7.2, 6.8))
    dot((7.2, 8))

    txt((6.4, 8.25), [SDA])
    txt((6.4, 7.7), [SCL])

    // ==========================================
    // 5. Voeding van beide modules
    // ==========================================

    // MCP4725 VDD
    wire(
      (4.6, 8.5),
      (4.6, 4.35),
      (5.5, 4.35),
      (5.5, 4.8),
    )

    // INA226 VCC
    wire(
      (8.6, 8.5),
      (8.6, 4.55),
      (9.5, 4.55),
      (9.5, 4.8),
    )

    dot((4.6, 8.5))
    
    // ==========================================
    // 6. IRLZ44N MOSFET
    // ==========================================

    // N-kanaal enhancement-MOSFET
    // Gate links, drain boven, source onder

    draw.circle((14, 4.3), radius: 0.9)

    // Gate-elektrode
    draw.line(
      (13.43, 3.8),
      (13.43, 4.78),
    )

    // Onderbroken kanaal
    for y in (3.97, 4.3, 4.63) {
      draw.line(
        (13.62, y - 0.1),
        (13.62, y + 0.1),
      )
    }

    // Drain
    wire(
      (13.62, 4.63),
      (14, 4.63),
      (14, 5.5),
    )

    // Source
    wire(
      (13.62, 3.97),
      (14, 3.97),
      (14, 3.1),
    )

    // Bulk/source
    wire(
      (14, 3.97),
      (14, 4.3),
      (13.84, 4.3),
    )

    draw.line(
      (13.64, 4.3),
      (13.84, 4.44),
      (13.84, 4.16),
      close: true,
      fill: black,
    )

    // Bodydiode
    wire(
      (14, 3.97),
      (14.45, 3.97),
      (14.45, 4.2),
    )

    draw.line(
      (14.3, 4.2),
      (14.6, 4.2),
      (14.45, 4.37),
      close: true,
      fill: black,
    )

    draw.line(
      (14.23, 4.28),
      (14.23, 4.4),
      (14.67, 4.4),
      (14.67, 4.48),
    )

    wire(
      (14.45, 4.4),
      (14.45, 4.63),
      (14, 4.63),
    )

    txt((15.05, 4.3), [*IRLZ44N*], anchor: "west")
    txt((14.2, 5.45), [Drain], anchor: "west")
    txt((12.5, 4.5), [Gate])
    txt((14.2, 3.15), [Source], anchor: "west")

    // ==========================================
    // 7. DAC naar MOSFET Gate
    // ==========================================

    wire(
      (7.8, 5.4),
      (8.2, 5.4),
      (8.2, 4.3),
      (12.7, 4.3),
      (12.7, 4.3),
      (13.43, 4.3),
    )

    // ==========================================
    // 8. Zonnecel
    // ==========================================

    draw.rect((15.8, 4.8), (17.8, 6.8), fill: white)

    txt((16.8, 5.95), [*Zonnecel*])
    txt((16.8, 6.65), [+])
    txt((16.8, 5), [−])

    // Zonnecel plus naar INA226 IN+
    wire(
      (11.8, 6.3),
      (12, 6.3),
      (12, 7.5),
      (16.8, 7.5),
      (16.8, 6.8),
    )

    // INA226 IN- naar MOSFET drain
    wire(
      (11.8, 5.8),
      (12.3, 5.8),
      // (12.3, 6),
      (14, 5.8),
      (14, 5.5),
    )

    // VBUS verbonden met IN-
    wire(
      (11.8, 5.4),
      (12.3, 5.4),
      (12.3, 5.8),
    )

    dot((12.3, 5.8))

    // ==========================================
    // 9. Gemeenschappelijke massa
    // ==========================================

    // Pico GND
    wire((1, 4.1), (1, 2.4))

    // MCP4725 GND
    wire((7.2, 4.8), (7.2, 2.4))

    // INA226 GND
    wire((11.2, 4.8), (11.2, 2.4))

    // MOSFET source
    wire((14, 3.1), (14, 2.4))

    // Zonnecel min
    wire((16.8, 4.8), (16.8, 2.4))

    // Massarail
    wire((1, 2.4), (17.5, 2.4))

    for x in (7.2, 11.2, 14, 16.8) {
      dot((x, 2.4))
    }

    earth("gnd", (17.5, 2.4))

    // ==========================================
    // 10. Draadbruggen zonder verbinding
    // ==========================================


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

    for (x, y) in (
      (4.6, 8.0),
      (4.6, 7.5),
      (5.45, 7.5),
      (8.6, 8.),
      (8.6, 7.5),
      (9.45, 7.5),
      (11.2, 4.25),
    ) {
      bridge(x, y)
    }
  },
  length: 0.88cm,
))

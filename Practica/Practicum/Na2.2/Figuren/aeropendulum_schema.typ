
#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

#align(center, zap.circuit(
  {
    import zap: *

    // Hulpfuncties
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

    // ========================================
    // 1. ARDUINO UNO R4 MINIMA
    // ========================================

    draw.rect(
      (0, 1.5), (4, 10),
      fill: white,
    )

    txt((2, 9.65), [*Arduino UNO R4*])
    txt((2, 9.3), [*Minima*])

    // I2C-pinnen
    txt((3.8, 8.5), [SDA], anchor: "east")
    txt((3.8, 7.8), [SCL], anchor: "east")

    // Voeding AS5600
    txt((3.8, 7.1), [3V3], anchor: "east")
    txt((3.8, 6.4), [GND], anchor: "east")

    // Logische voeding L298N
    txt((3.8, 2.3), [3.3V], anchor: "east")

    // Motorbesturing
    txt((3.8, 4.7), [D9 / PWM], anchor: "east")
    txt((3.8, 3.9), [D10], anchor: "east")
    txt((3.8, 3.1), [D11], anchor: "east")

    // txt((2, 2.1), [USB-C naar computer])

    // ========================================
    // 2. AS5600 HOEKSENSOR
    // ========================================

    draw.rect(
      (9, 6.1), (13, 9.2),
      fill: white,
    )

    txt((11, 8.9), [*AS5600*])
    // txt((11, 8.55), [Magnetische hoeksensor])

    txt((9.2, 8.5), [SDA], anchor: "west")
    txt((9.2, 7.8), [SCL], anchor: "west")
    txt((9.2, 7.1), [VCC], anchor: "west")
    txt((9.2, 6.4), [GND], anchor: "west")

    // I2C-verbindingen
    wire((4, 8.5), (9, 8.5))
    wire((4, 7.8), (9, 7.8))

    // Voeding en massa
    wire((4, 7.1), (9, 7.1))
    wire((4, 6.4), (9, 6.4))

    txt((6.5, 8.75), [I²C: SDA])
    txt((6.5, 8.05), [I²C: SCL])
    txt((6.5, 7.35), [3,3 V])

    // ========================================
    // 3. L298N H-BRUG
    // ========================================

    draw.rect(
      (9, 1.5), (13, 5.8),
      fill: white,
    )

    txt((11, 5.5), [*L298N H-brug*])

    // Ingangen vanaf Arduino
    txt((9.2, 4.7), [ENA], anchor: "west")
    txt((9.2, 3.9), [IN1], anchor: "west")
    txt((9.2, 3.1), [IN2], anchor: "west")
    txt((9.2, 2.3), [5V], anchor: "west")

    // Uitgangen motor
    txt((12.8, 3.2), [OUT1], anchor: "east")
    txt((12.8, 2.5), [OUT2], anchor: "east")

    // Uitgangen motor
    txt((12.8, 4.5), [GND], anchor: "east")
    txt((12.8, 5), [12V], anchor: "east")


    // Voeding
    txt((11, 1.8), [GND])

    // PWM en richting
    wire((4, 4.7), (9, 4.7))
    wire((4, 3.9), (9, 3.9))
    wire((4, 3.1), (9, 3.1))

    // 5V-logicavoeding:
    // jumper 5V-EN verwijderd.
    wire(
      (4, 2.3),
      // (6, 5.5),
      // (6, 2.3),
      (9, 2.3),
    )

    // ========================================
    // 4. ELEKTROMOTOR
    // ========================================

    draw.rect(
      (16, 1.8), (18.6, 4.1),
      fill: white,
    )

    txt((17.3, 3.55), [*DC-motor*])
    txt((17.3, 3.15), [Propeller])
    txt((16.2, 2.6), [+], anchor: "west")
    txt((16.2, 2.15), [−], anchor: "west")

    // Motoruitgangen
    wire(
      (13, 3.2),
      (15.7, 3.2),
      (15.7, 2.6),
      (16, 2.6),
    )

    wire(
      (13, 2.5),
      (15.2, 2.5),
      (15.2, 2.15),
      (16, 2.15),
    )

    // ========================================
    // 5. EXTERNE MOTORVOEDING
    // ========================================

    draw.rect(
      (15, 6.5), (18.6, 8.5),
      fill: white,
    )

    txt((16.8, 8.1), [*Externe voeding*])
    txt((16.8, 7.65), [12 V DC])
    txt((15.8, 6.75), [+], anchor: "west")
    txt((17.1, 6.75), [−], anchor: "east")

    // Positieve voedingslijn naar L298N
    wire(
      (16, 6.5),
      (16, 5.),
      (13., 5.),
      // (12.1, 5.),
      // (12.1, 5.5),
    )

         wire(
      (17, 6.5),
      (17, 4.5),
      (13., 4.5),
      // (12.1, 5.),
      // (12.1, 5.5),
    )

    // txt((12.3, 6.15), [5V / VS], anchor: "west")

    // ========================================
    // 6. GEMEENSCHAPPELIJKE MASSA
    // ========================================

    // Massa Arduino
    wire(
      (1, 1.5),
      (1, 0),
    )

    // Massa L298N
    wire(
      (11, 1.5),
      (11, 0),
    )

    // Massa externe voeding
    // wire(
    //   (18.6, 7.15),
    //   (19.4, 7.15),
    //   (19.4, 0),
    // )

    // Gemeenschappelijke GND-rail
    wire((1, 0), (11., 0))

    // dot((1, 0))
    // dot((11, 0))
    // dot((19.4, 0))

    earth("gnd", (11., 0))
    txt((6, -0.35), [ GND])

    // ========================================
    // OPMERKINGEN
    // ========================================

    // txt(
    //   (6.5, 1.15),
    //   [ENA-jumper verwijderen],
    // )

    // txt(
    //   (6.5, 0.7),
    //   [5V-regulatorjumper verwijderen],
    // )
  },
  length: 0.72cm,
))


#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

#align(center, zap.circuit(
  {
    import zap: *

    // ==========================================
    // HULPFUNCTIES
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
    // 1. RASPBERRY PI PICO
    // ==========================================

    draw.rect(
      (0, 4.0),
      (3, 7.0),
      fill: white,
    )

    txt((1.5, 6.75), [*Raspberry Pi Pico*])

    // I2C
    txt((2.8, 6.5), [SCL], anchor: "east")
    txt((2.8, 5.9), [SDA], anchor: "east")

    // Voeding
    txt((2.8, 5.1), [3V3], anchor: "east")
    txt((1.5, 4.2), [GND])

    // ==========================================
    // 2. INA226-MODULE
    // ==========================================

    draw.rect(
      (7, 4.5),
      (10, 7.0),
      fill: white,
    )

    txt((8.5, 6.15), [*INA226*])

    // I2C-pinnen boven
    txt((7.8, 6.9), [SDA], anchor: "north")
    txt((9.1, 6.9), [SCL], anchor: "north")

    // Stroom- en spanningsmeting rechts
    txt((9.85, 6.3), [IN+], anchor: "east")
    txt((9.85, 5.7), [IN−], anchor: "east")
    txt((9.85, 5.1), [VBUS], anchor: "east")

    // Voeding onder
    txt((7.6, 4.65), [VCC], anchor: "south")
    txt((9.0, 4.65), [GND], anchor: "south")

    // ==========================================
    // 3. I2C-VERBINDINGEN
    // ==========================================

    // SCL: Pico naar INA226
    wire(
      (3, 5.9),
      (6, 5.9),
      (6, 7.5),
      (7.8, 7.5),
      (7.8, 7),
    )

    // SDA: Pico naar INA226
    wire(
      (3, 6.5),
      (5, 6.5),
      (5, 8.),
      (9.1, 8.),
      (9.1, 7),
    )

    // Draadbrug op kruising SDA/SCL
    // SDA kruist SCL zonder elektrisch contact.


    // ==========================================
    // 4. VOEDING INA226
    // ==========================================

    // Pico 3V3 naar INA226 VCC
    wire(
      (3, 5.1),
      (6, 5.1),
      (6, 3.5),
      (7.6, 3.5),
      (7.6, 4.5),
    )

    // ==========================================
    // 5. ZONNECEL
    // ==========================================

    draw.rect(
      (16.8, 5.0),
      (19.2, 7.5),
      fill: white,
    )

    txt((18, 6.35), [*Zonnecel*])
    txt((18, 7.25), [+])
    txt((18, 5.25), [−])

    // ==========================================
    // 6. ZONNECEL+ NAAR INA226 IN+
    // ==========================================

    wire(
      (10, 6.3),
      (10.7, 6.3),
      (10.7, 8.2),
      (18, 8.2),
      (18, 7.5),
    )

    // ==========================================
    // 7. BELASTINGSWEERSTAND
    // ==========================================

    // IN- naar bovenkant belasting
    wire(
      (10, 5.7),
      (14, 5.7),
      (14, 4.6),
    )

    resistor(
      "RL",
      (14, 4.6),
      (14, 2.8),
    )

    txt(
      (14.5, 3.7),
      [$R_"variable"$],
      anchor: "west",
    )

    // ==========================================
    // 8. VBUS-METING
    // ==========================================

    // VBUS meet de spanning op IN-
    // en dus over de belastingsweerstand.

    wire(
      (10, 5.1),
      (11.5, 5.1),
      (11.5, 5.7),
    )

    // Elektrisch knooppunt
    dot((11.5, 5.7))

    // ==========================================
    // 9. GEMEENSCHAPPELIJKE MASSA
    // ==========================================

    // Pico GND
    wire(
      (1.5, 4.0),
      (1.5, 2.4),
    )

    // INA226 GND
    wire(
      (9, 4.5),
      (9, 2.4),
    )

    // Onderkant belastingsweerstand
    wire(
      (14, 2.8),
      (14, 2.4),
    )

    // Zonnecel min
    wire(
      (18, 5.0),
      (18, 2.4),
    )

    // Doorlopende massarail
    wire(
      (1.5, 2.4),
      (19, 2.4),
    )

    // Knooppunten
    for x in (9, 14, 18) {
      dot((x, 2.4))
    }

    // Massasymbool
    earth("gnd", (19, 2.4))
  },
  length: 0.88cm,
))

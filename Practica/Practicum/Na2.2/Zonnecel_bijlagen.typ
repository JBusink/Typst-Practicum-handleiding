#heading(level: 1, numbering: none)[Bijlage A — Pinverbindingen]

De nummers bij J1 en J2 zijn connectorpinnen uit PCB_schema_V1, niet de pinnummers van de losse IC’s. Controleer bij een andere module de opschriften en pinvolgorde. De Pico-kolom noemt de fysieke headerpin en waar nodig het GPIO-nummer.

#{
set text(size: 9pt)
set par(leading: 0.55em)
table(
columns: (1.05fr, 1.15fr, 1.35fr),
inset: 5pt,
stroke: 0.4pt + luma(180),
fill: (x, y) => if y == 0 { luma(235) } else { none },
table.header([*Van / aansluiting*], [*Naar / aansluiting*], [*Functie*]),
[Pico pin 36 (3V3)], [J1-1 (VDD), J2-8 (VCC)], [Voeding van beide modules: 3,3 V.],
[Pico GND (bijv. pin 38)], [J1-2, J1-5, J2-7, Q1-3 en PV−], [Gemeenschappelijke massa; J1-5 is A0.],
[Pico pin 26 (GPIO20)], [J1-4 (SDA), J2-6 (SDA)], [I²C-data; GPIO20 is niet fysieke pin 20.],
[Pico pin 27 (GPIO21)], [J1-3 (SCL), J2-5 (SCL)], [I²C-klok.],
[J1-6 (DAC OUT)], [Q1 pin 1 (gate)], [Analoge stuurspanning voor de belasting.],
[PV+ (zonnecel)], [J2-1 (IN+) en J2-3 (VBS)], [Positieve stroomingang en busspanningsmeting.],
[J2-2 (IN−)], [Q1 pin 2 (drain)], [Stroompad na de shunt op de module.],
[Q1 pin 3 (source)], [GND / PV−], [Retour van de belastingsstroom.],
[J2-4 (ALE / ALERT)], [Niet aangesloten], [Alarmuitgang niet gebruikt.],
[R1 (4,7 kΩ)], [Tussen 3V3 en SDA], [Pull-up voor de datalijn.],
[R2 (4,7 kΩ)], [Tussen 3V3 en SCL], [Pull-up voor de kloklijn.],
[C1 (100 nF)], [Tussen J1-1 (VDD) en GND], [Ontkoppeling van de DAC-voeding.],
[C2 (100 nF)], [Tussen J2-8 (VCC) en GND], [Ontkoppeling van de INA226-voeding.],
[Computer USB], [USB-aansluiting Pico], [Voeding en uitwisseling van opdrachten en meetwaarden.],
)
}

VBS is de moduleaansluiting voor VBUS. De tabel volgt de verbinding met IN+ aan PV+. Controleer deze verbinding op de gebruikte module; alleen dan geldt zonnecelspanning = gemeten busspanning. Bij Q1 gelden gate = 1, drain = 2 en source = 3; controleer de montagerichting met de datasheet.

#pagebreak(weak: true)
#heading(level: 1, numbering: none)[Bijlage B — Materialenlijst]

Benodigdheden per meetopstelling. Bij een reeds bestukte PCB zijn de Pico, modules en losse printonderdelen inbegrepen; deze worden niet dubbel uitgedeeld. Gebruik de door de begeleider vrijgegeven stroom- en vermogensgrenzen.

#{
set text(size: 9pt)
set par(leading: 0.55em)
table(
columns: (0.5fr, 1.6fr, 2fr),
inset: 5pt,
stroke: 0.4pt + luma(180),
fill: (x, y) => if y == 0 { luma(235) } else { none },
table.header([*Aantal*], [*Materiaal*], [*Toepassing*]),
[1], [Zonnecel of zonnecelmodule], [Met aansluitdraden naar PV+ en PV−.],
[1], [Lamp met voeding en houder], [Voor een vaste, zo homogeen mogelijke belichting.],
[1], [Zonnecel-PCB volgens PCB_schema_V1], [Bestukte print met de hieronder genoemde onderdelen.],
[1], [Raspberry Pi Pico], [Met passende headers en meetfirmware.],
[1], [MCP4725 DAC-module], [12-bit DAC op connector J1.],
[1], [INA226-meetmodule met shunt], [Op J2; noteer de werkelijke shuntwaarde voor de kalibratie.],
[1], [IRLZ44N MOSFET (Q1)], [Met koeling passend bij de vrijgegeven dissipatie.],
[2], [Weerstand 4,7 kΩ], [R1 en R2: I²C-pull-ups.],
[2], [Condensator 100 nF], [C1 en C2: voedingsontkoppeling.],
[1 set], [Headers, aansluitklemmen en bedrading], [Voor de modules en de zonnecelaansluiting.],
[1], [Computer met meet- en analysesoftware], [Voor instellen, opslaan en verwerken van de meetreeks.],
[1], [USB-datakabel voor de Pico], [Een kabel die ook data overdraagt.],
[1], [Multimeter], [Voor controle van verbindingen en spanning.],
[1 set], [Houders en liniaal of meetlint], [Voor vaste afstand en stand van lamp en zonnecel.],
[Optioneel], [Gekalibreerde instralingsmeter], [Nodig voor rendement uit instraling in W/m² en celoppervlak.],
)
}

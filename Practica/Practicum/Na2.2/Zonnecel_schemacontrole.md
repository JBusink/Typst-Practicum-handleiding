# Schemacontrole zonnecel — PCB_schema_V1

Bijgewerkt op 5 november 2026 op basis van `Figuren/PCB_schema_V1.png`.
Dit schema vervangt de eerdere reconstructie uit foto's als uitgangspunt van
de handleiding. Het is geen elektrische doormeting van de bestukte print.

## Verbindingen volgens het schema

| Onderdeel | Aansluiting / waarde |
|---|---|
| Q1 | IRLZ44N: gate 1, drain 2, source 3; source aan GND. |
| J1 | DAC-module MCP4725; uitgang rechtstreeks naar gate. Het opschrift MPC4725DAC bevat een typefout. |
| J2 | INA226-module in het vermogenspad van SC1+ naar drain; interne moduleschakeling niet getekend. |
| Voeding | Pico 3V3, fysieke pin 36; gemeenschappelijke GND met SC1−. |
| SDA | GPIO20, fysieke pin 26; R1 = 4,7 kΩ naar 3,3 V. |
| SCL | GPIO21, fysieke pin 27; R2 = 4,7 kΩ naar 3,3 V. |
| Ontkoppeling | C1 en C2: elk 100 nF tussen 3,3 V en GND. |
| TH1 | GPIO28 / ADC2, fysieke pin 34; R4 = 10 kΩ naar 3,3 V. |
| TH2 | GPIO27 / ADC1, fysieke pin 32; R3 = 10 kΩ naar 3,3 V. |
| TH3 | GPIO26 / ADC0, fysieke pin 31; R5 = 10 kΩ naar 3,3 V. |

Elke NTC is verbonden tussen het ADC-knooppunt en GND. Bij opwarming daalt
de knooppuntspanning. De vaste weerstanden van 10 kΩ bepalen niet het NTC-type.
Meetlocaties, NTC-karakteristieken en kalibratie moeten apart worden vastgelegd.

## Werking en resterende controles

Computer → USB → Pico → I²C → MCP4725 → gate van Q1.
De DAC-code bepaalt de gate-aansturing, niet rechtstreeks een stroom of een
weerstand. De INA226 meet spanning en stroom. De effectieve belasting is U_PV/I.

- Controleer de pinfuncties van de werkelijk gebruikte modules op J1 en J2,
  de shuntwaarde en tolerantie, de I²C-adressen en de bestukking.
- De eerdere printfoto's wezen op VBUS verbonden met IN+ aan PV+.
  Het nieuwe schema toont alleen de moduleconnector. Controleer die interne
  verbinding voordat U_PV = U_BUS wordt gebruikt. Bij deze aansluiting wordt
  de shuntspanning niet bij de busspanning opgeteld.
- Meet het vermogenspad SC1+ → moduleshunt → drain → source → SC1− en de
  gemeenschappelijke massa spanningsloos na.
- De IRLZ44N krijgt maximaal ongeveer 3,3 V gate-aansturing. De datasheet
  specificeert de lage aan-weerstand vanaf 4 V; volledige geleiding bij
  3,3 V is niet gegarandeerd. Beoordeel het bereik met gemeten werkpunten.
- Bepaal stroom-, spannings- en vermogensgrenzen voor de gehele opstelling,
  inclusief shunt, MOSFET, continue belasting en koeling. Componentmaxima
  zijn geen vrijgave van de PCB.
- Controleer opstarten, reset en verbindingsverlies. Een DAC kan zijn uitgang
  behouden bij een Pico-reset; een softwarematige eindinstructie garandeert
  dan geen uitschakeling. Het schema toont geen afzonderlijke gate-pulldown.

## Verwerking in de handleiding

`Zonnecel.typ` bevat het volledige nieuwe schema, de aansluitingen, een tabel
met de drie NTC-kanalen en de omzetting van ADC-spanning naar NTC-weerstand.
De opdrachten nemen NTC-controle en logging mee. `Figuren/Zonnecel_mosfet.typ`
toont het vermogenspad, de besturing en voeding en de drie NTC-spanningsdelers,
met expliciete controle van de interne INA226-moduleverbindingen.

## Componentbronnen

- [Microchip MCP4725](https://www.microchip.com/en-us/product/mcp4725)
- [TI INA226](https://www.ti.com/lit/ds/symlink/ina226.pdf)
- [Infineon IRLZ44N](https://www.infineon.com/assets/row/public/documents/24/49/infineon-irlz44n-datasheet-en.pdf)

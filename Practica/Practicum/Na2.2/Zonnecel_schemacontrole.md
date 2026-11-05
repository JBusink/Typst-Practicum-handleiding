# Schemacontrole zonnecel-PCB Rev. 1.0

Controle op 5 november 2026 op basis van `24349.jpg` (onderzijde),
`20261105_174838.jpg` (bovenzijde) en de bestaande PCB-illustratie.
De foto's tonen een onbestukte basisprint. Dit is een visuele reconstructie,
geen elektrische doormeting of vrijgave van een bestukte print.

## Werking

Computer → USB → Pico → I²C → MCP4725 → gate van MOSFET Q1.
De MOSFET is de variabele belasting. De computer varieert de DAC-code en
daarmee de geleiding. De INA226 meet spanning en stroom; de Pico stuurt deze
meetwaarden terug. De effectieve belastingweerstand is per werkpunt U_PV/I.
Een code is geen gekalibreerde weerstandinstelling in ohm.

## Uit de zichtbare sporen gereconstrueerd

| Verbinding | Bevinding |
|---|---|
| PV+ → INA226 IN+ | Spoor op onderzijde vanaf positieve aansluitpad naar IN+. |
| INA226 VBS → IN+ | Zichtbare lus op onderzijde; VBS is de aansluiting voor VBUS. |
| INA226 IN− → Q1 middelste pad | Zichtbaar spoor op onderzijde. Bij G-D-S-pinvolgorde is dit drain. |
| MCP4725 VOUT → Q1 eerste/vierkante pad | Zichtbaar spoor; geen serie-gateweerstand op de basisprint. |
| R1 en R2 | Sporen wijzen op I²C-pull-ups, niet op een spanningsdeler of belastingsweerstand. Waarden ontbreken. |
| Shunt | Hoort op de INA226-module tussen IN+ en IN−; niet zichtbaar op deze onbestukte print. |

Het gereconstrueerde vermogenspad is PV+ → moduleshunt → drain → source → PV−.
De retourverbinding van source, PV− en GND is in het schema als gemeenschappelijke
massa weergegeven en moet worden doorgemeten. De bronfoto's geven onvoldoende
zekerheid over alle verbindingen via kopervlakken.

VBUS ligt vóór de shunt. Daarom is U_PV = U_BUS; tel hier niet nogmaals
U_shunt bij op. De stroom is (U_IN+ − U_IN−)/R_shunt.
Bij een correcte kalibratie hoort het INA226-vermogen dan bij deze gemeten
busspanning. Kleine ingangsstromen en lekstromen blijven meetafwijkingen,
met name bij benadering van open klem.

## Nog aan de bestukte print vast te stellen

- Q1-typenummer, N-kanaal-uitvoering en daadwerkelijke pinvolgorde. Het schema
  neemt G-D-S aan. De foto toont alleen de footprint.
- Shuntopdruk en tolerantie. De bestaande illustratie toont R100 (0,1 Ω),
  maar dit bevestigt niet de werkelijk gemonteerde module. Bij 0,1 Ω is het
  INA226-shuntmeetbereik ongeveer 0,819 A; dat is geen toegestane PCB-stroom.
- Voedingsspanning van de modules, pull-upwaarden en I²C-adressen. Controleer
  dat de I²C-lijnen op Pico-geschikte logicaniveaus blijven.
- Continuïteit van source naar PV− en alle GND-aansluitingen; de verbindingen
  uit de tabel eveneens nameten met uitgeschakelde voeding.
- Geschiktheid van Q1 voor de beschikbare gatespanning en continue dissipatie:
  gebruik de DC safe operating area van het specifieke MOSFET-type.
- Gedrag bij opstarten, reset en verbindingverlies. Een DAC kan zijn laatste
  uitgang behouden terwijl de Pico reset; een softwarematige eindinstructie
  alleen garandeert dan niet dat de belasting uitschakelt.

De opschriftvolgorde “MPC4725DAC” op de print bevat een typefout; de component
heet **MCP4725**.

## Wijzigingen in de handleiding

`Figuren/Zonnecel_mosfet.typ` bevat nu het gereconstrueerde meetcircuit met
de MOSFET als belasting. De vorige tekening is bewaard in
`Figuren/Archief/Zonnecel_mosfet_oude_meetmethode.typ`.
De tijdelijke bestandsnaam `Zonnecel_principeschema.typ` verwijst naar het
actuele schema, zodat er geen twee verschillende versies worden onderhouden.

De oude Arduino-ADC, spanningsdeler, 4,7-Ω-sourceweerstand en 1-kΩ-gateweerstand
zijn uit het actuele schema verwijderd. De handleiding beschrijft de DAC-sweep,
I-V-, P-V- en P-R-analyse en het onderscheid tussen fill factor en rendement.

## Componentbronnen

- [Microchip MCP4725](https://www.microchip.com/en-us/product/mcp4725):
  digitaal-analoogomzetter en opstartinstelling.
- [TI INA226-datasheet](https://www.ti.com/lit/ds/symlink/ina226.pdf):
  afzonderlijke VBUS-meting, shuntmeting en kalibratie.

Een datasheet bevestigt de werking van een component, niet de bedrading of
bestukking van deze specifieke PCB.

#import "../../styl.typ": *

#heading(level: 2, numbering: none)[Meten vanuit de Arduino IDE]

Gebruik de CSV-sketch voor dit practicum in `Arduino/Openloop` of `Arduino/PID`. Open voor open-loopmetingen `Aero_pendulum_OL_CSV.ino` en voor PID-metingen `Aero_pendulum_PID_CSV.ino`, ieder in zijn eigen gelijknamige map. Het programma draait volledig op de Arduino. Python wordt pas achteraf gebruikt voor de analyse.

+ Selecteer in de Arduino IDE de Arduino Uno R4 Minima en de juiste poort. Installeer `AS5600` van Rob Tillaart. Alleen de PID-sketch heeft daarnaast de bibliotheek `PID` van Brett Beauregard nodig.

+ Controleer met de motorvoeding uit de bedrading en hoekconversie. Stel met de begeleider `MAX_PWM`, `MIN_ANGLE_DEG` en `MAX_ANGLE_DEG` vast. De meegeleverde waarden zijn voorlopig.

+ Wijzig voor open-loop `OPEN_LOOP_PWM`\; wijzig voor PID `setpoint`, `kp`, `ki` en `kd`. De proefduur staat in `MEASUREMENT_MS` en is standaard 30000 ms. Upload met uitgeschakelde motorvoeding.

+ Open Serial Monitor en kies 115200 baud. Schakel de weergave van extra tijdstempels uit: de sketch levert zelf de tijd. Sluit Serial Plotter en andere programma's op dezelfde poort.

+ Verstuur de hoofdletter `C` voor tien seconden sensorcontrole zonder motoraansturing. Controleer de hoek met alleen USB aangesloten. De uitvoer stopt daarna vanzelf. Een ongeldige sensorstatus of werkhoek levert een foutregel en beëindigt de opname.

+ Maak Serial Monitor leeg vóór de echte meting. Schakel de gecontroleerde motorvoeding in terwijl de sketch wacht. Houd afstand van arm en propeller en verstuur `S`. De Arduino start de motor en verstuurt een CSV-kop gevolgd door meetregels. Een eventuele regeleinde-instelling mag blijven staan; CR en LF worden genegeerd.

+ Na de ingestelde proefduur stopt de Arduino de motor en de uitvoer automatisch. Verstuur `X` om eerder te stoppen. Bij een sensorfout of een hoek buiten het ingestelde bereik stopt de motor eveneens. Schakel na afloop de motorvoeding uit.

Het sluiten van Serial Monitor is geen stopcommando. Gebruik `X` of schakel de motorvoeding uit. Houd de fysieke uitschakeling bereikbaar: de softwarematige stop werkt alleen zolang de microcontroller zijn programma blijft uitvoeren.

#heading(level: 2, numbering: none)[CSV-bestand bewaren]

De Arduino verstuurt CSV-tekst via USB; zonder opslagmodule schrijft hij geen bestand op de computer. Bewaar de meetgegevens als volgt:

+ Wacht totdat de uitvoer is gestopt. Selecteer en kopieer de volledige opname uit Serial Monitor, vanaf de regel die begint met `t_ms,setpoint_deg` tot en met de laatste volledige meetregel.

+ Plak deze tekst in een leeg tekstbestand, bijvoorbeeld in Kladblok. Sla op als `pid_run1.csv` of `ol_pwm60_run1.csv`. Kies bij opslaan zo nodig "Alle bestanden", zodat de naam niet eindigt op `.csv.txt`.

+ Gebruik een nieuwe bestandsnaam per proef. Neem geen meldingen van de IDE, geweigerde startmeldingen of een tweede CSV-kop op in hetzelfde bestand. Controleer bij langere proeven of het begin van de uitvoer nog aanwezig is; verkort de proef als de monitor oude regels niet bewaart.

De belangrijkste kolommen zijn `t_ms` (tijd sinds het startcommando), `angle_deg` (hoek), `pwm` (werkelijke PWM-telwaarde), `setpoint_deg` (leeg bij OL), `running` en `sensor_ok`. Noteer de gekozen PWM- of PID-instellingen en de maximale PWM zelf in het labjournaal. Een ongeldige hoek blijft leeg. Het scheidingsteken is een komma en het decimaalteken een punt. Noteer voedingsinstellingen en kalibratie apart in het labjournaal.

Meten, regelen en CSV-uitvoer gebeuren in dezelfde ronde, nominaal iedere 20~ms (50 Hz). Gebruik de tijdstempels voor de tijdas, met $t = 0$ bij het startcommando. De eerste meetregel volgt enkele milliseconden later. Controleer de werkelijke intervallen door opeenvolgende tijdstempels van elkaar af te trekken. Er is geen nulmeting vóór de motoraansturing; bepaal de beginhoek vooraf met `C`. Verdere instructies staan in `Arduino/README.md`.

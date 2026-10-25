#import "../../styl.typ": *
#show: stijl.with(titel: "Aero pendulum PID", kop: "Technische Natuurkunde — Na2.2")

#praktikumtitle[Practicum: PID-regeling van een aeropendulum]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kunt uitleggen hoe terugkoppeling de hoek van een aeropendulum regelt.

- Je kunt de invloed van de P-, I- en D-term experimenteel onderzoeken.

- Je kunt een regelaar stapsgewijs afstellen en beoordelen op insteltijd, overshoot en stationaire fout.

- Je kunt meetgegevens uit de Arduino verwerken in Python en de beperkingen van de regeling herkennen.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ Gebruik dezelfde gecontroleerde opstelling en voedingsinstellingen als bij het open-looppracticum. Laat het toegestane hoekbereik en de maximale motoruitgang vaststellen door de practicumbegeleider.

+ Schakel de motorvoeding uit voordat je bedrading, sensor of programma aanpast. De nieuwe CSV-sketch wacht na uploaden of resetten op een expliciet startcommando via Serial Monitor.

+ Houd handen, haar en losse voorwerpen buiten het bewegingsbereik van arm en propeller. Pak de arm niet vast terwijl de motorvoeding is ingeschakeld.

+ Houd de uitschakeling van de motorvoeding bereikbaar. Schakel direct uit bij toenemende oscillaties, een onjuiste hoekmeting of beweging richting een mechanische aanslag. Wacht tot de propeller stilstaat voordat je de opstelling benadert.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

In het open-looppracticum heb je onderzocht welke hoek ontstaat bij een ingestelde motoruitgang. Die hoek kan veranderen door bijvoorbeeld wrijving of een verandering van de belasting. De besturing merkt zo'n afwijking niet op.

In dit practicum koppelen we de gemeten hoek terug naar de Arduino. De Arduino vergelijkt de hoek met de gewenste waarde en past het PWM-signaal aan. Zo ontstaat een gesloten regelkring. Je onderzoekt eerst een proportionele regelaar, voegt vervolgens een integrerende term toe en onderzoekt ten slotte of een differentiërende term de respons verbetert.

#heading(level: 1, numbering: none)[Theorie]

#heading(level: 2, numbering: none)[Terugkoppeling en regelfout]

De gewenste hoek heet het #emph[setpoint], $r \( t \)$. De gemeten hoek is $theta \( t \)$. De regelfout is #math.equation(block: true, numbering: "(1)", $e \( t \) = r \( t \) - theta \( t \) .$) Bij een positieve fout staat de arm onder de gewenste hoek. Voor de gebruikte instelling `DIRECT` moet een grotere motoruitgang leiden tot een grotere gemeten hoek. Controle van dit teken is noodzakelijk voordat je de regeling inschakelt.

#figure(
  [
#include "Figuren/pid_regelkring.typ"
  ],
  caption: [Gesloten regelkring van het aeropendulum. De sensor levert de gemeten hoek voor de terugkoppeling.],
  kind: image,
) #label("aero_pendulum_pid--fig:aeropid_regelkring")

#heading(level: 2, numbering: none)[De drie bijdragen]

Een ideale PID-regelaar kan worden geschreven als #math.equation(block: true, numbering: "(1)", $u^(*) \( t \) = K_p e \( t \) + K_i integral_0^t e \( tau \) thin upright(d) tau + K_d frac(upright(d) e, upright(d) t) .$) Hier is $u^(*)$ de berekende uitgang vóór begrenzing. In deze opstelling drukken we de uitgang uit in PWM-telwaarden en de hoek in graden. De eenheden van $K_p$, $K_i$ en $K_d$ zijn daarom respectievelijk PWM-telwaarden per graad, per graad per seconde en maal seconde per graad.

- #strong[P: reactie op de huidige fout.] Een grotere $K_p$ geeft bij dezelfde fout meer motoruitgang. Dit kan de respons versnellen, maar ook overshoot of oscillaties veroorzaken. Omdat een niet-nul motoruitgang nodig is om de arm omhoog te houden, kan een P-regelaar zonder extra basisuitgang een blijvende fout hebben.

- #strong[I: reactie op de opgebouwde fout.] Een aanhoudende fout bouwt een extra bijdrage op. Hiermee kan de stationaire fout afnemen. Te veel integrerende werking kan leiden tot overshoot en langzaam herstel.

- #strong[D: reactie op snelle verandering.] Deze bijdrage kan de beweging afremmen en overshoot verminderen, maar is gevoelig voor meetruis.

De gebruikte bibliotheek `PID_v1` berekent de D-bijdrage uit de verandering van de #emph[gemeten hoek]: $- K_d thin upright(d) theta \/ upright(d) t$. Bij een constant setpoint komt dit overeen met de ideale formule. Bij een setpointsprong wordt zo een directe D-piek door die sprong vermeden. De bibliotheek begrenst ook de opgebouwde integratorbijdrage; langdurige verzadiging kan desondanks de respons beïnvloeden. Zie de #link("https://github.com/br3ttb/Arduino-PID-Library/blob/master/PID_v1.cpp")[broncode van PID\_v1] voor de implementatie.

#heading(level: 2, numbering: none)[Begrenzing en bemonstering]

Voor een maximale PWM-uitgang $u_max$ geldt #math.equation(block: true, numbering: "(1)", $u \( t \) = min #scale(x: 120%, y: 120%)[\(] u_max \, max \( 0 \, u^(*) \( t \) \) #scale(x: 120%, y: 120%)[\)] \, #h(2em) D approx u / 255 .$) De motoruitgang is een PWM-instelling, geen gemeten spanning of stuwkracht. De regelaar kan in deze sketch geen negatieve stuwkracht vragen. Om de arm te laten zakken, vermindert hij de motoruitgang en werkt de zwaartekracht mee. Daarom hoeven opgaande en neergaande responsen niet gelijk te zijn.

De ingestelde regelperiode is 20~ms, overeenkomend met een nominale frequentie van 50~Hz. Serieel versturen kost echter ook tijd. De nieuwe CSV-sketch verstuurt iedere 20 ms tekst op 115200 baud, in dezelfde ronde als de hoekmeting en regeling. Neem daarom niet zonder controle aan dat opeenvolgende meetpunten precies 20~ms uit elkaar liggen.

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Opstelling en Arduino-programma]

Gebruik dezelfde Arduino Uno R4 Minima, L298N, AS5600, motor, voeding en mechanische opstelling als bij het open-looppracticum. Houd de voedingsinstellingen tijdens de vergelijking van regelaars gelijk.

#block[
#table(
  columns: (auto,auto,),
  align: (left,left,),
  table.header(table.cell(x: 0, y: 0)[#strong[Arduino-aansluiting]], table.cell(x: 1, y: 0)[#strong[Component]]),
  table.cell(x: 0, y: 1)[D9],
  table.cell(x: 1, y: 1)[ENA van de L298N (PWM)],
  table.cell(x: 0, y: 2)[D10 en D11],
  table.cell(x: 1, y: 2)[IN1 en IN2 van de L298N],
  table.cell(x: 0, y: 3)[A4 en A5],
  table.cell(x: 1, y: 3)[SDA en SCL van de AS5600],
  table.cell(x: 0, y: 4)[GND],
  table.cell(x: 1, y: 4)[Gemeenschappelijke massa volgens het aansluitschema],
)

]
#figure(
  [
#box(image("Figuren/aeropendulum_aansluitschema.png", width: 65.0%))
  ],
  caption: [De aansluitingen blijven gelijk aan die van het open-looppracticum.],
  kind: image,
) #label("aero_pendulum_pid--fig:aeropid_aansluitingen")

Open `Aero_pendulum_PID_CSV.ino` in de gelijknamige submap van `Arduino/PID`. Gebruik de bibliotheken die `Wire.h`, `PID_v1.h` en `AS5600.h` leveren. Bewaar een eigen kopie in een sketchmap met dezelfde naam als het hoofd-`.ino`-bestand. Zet daarin alleen de sketch die je wilt uploaden; meerdere complete sketches met elk een `setup()` en `loop()` horen niet in dezelfde sketchmap.

#block[
#table(
  columns: (auto,auto,auto,),
  align: (left,left,left,),
  table.header(table.cell(x: 0, y: 0)[#strong[Instelling]], table.cell(x: 1, y: 0)[#strong[Beginwaarde in de code]], table.cell(x: 2, y: 0)[#strong[Betekenis]]),
  table.cell(x: 0, y: 1)[`setpoint`],
  table.cell(x: 1, y: 1)[40],
  table.cell(x: 2, y: 1)[Gewenste hoek in graden],
  table.cell(x: 0, y: 2)[`kp`],
  table.cell(x: 1, y: 2)[2],
  table.cell(x: 2, y: 2)[Proportionele versterking],
  table.cell(x: 0, y: 3)[`ki`],
  table.cell(x: 1, y: 3)[0.5],
  table.cell(x: 2, y: 3)[Integrerende versterking],
  table.cell(x: 0, y: 4)[`kd`],
  table.cell(x: 1, y: 4)[0],
  table.cell(x: 2, y: 4)[Differentiërende versterking],
  table.cell(x: 0, y: 5)[`SetSampleTime(20)`],
  table.cell(x: 1, y: 5)[20],
  table.cell(x: 2, y: 5)[Ingestelde regelperiode in ms],
  table.cell(x: 0, y: 6)[`MAX_PWM`],
  table.cell(x: 1, y: 6)[120 (voorlopig)],
  table.cell(x: 2, y: 6)[Grenzen van de motoruitgang],
)

]
De begininstelling is dus een #strong[PI-regelaar]. Deze waarden zijn geen garantie voor een veilige of goede afstelling van iedere opstelling. Je geeft in Serial Monitor de commando\'s `S` (start) en `X` (stop). Wijzig het setpoint en de versterkingen in de code en upload opnieuw met uitgeschakelde motorvoeding. Bij iedere start wordt de integrator gewist; tijdens wachten staat de regelaar uit.

De hoek wordt berekend als de ingestelde `ANGLE_OFFSET_DEG` minus de sensorhoek in graden. Dit veronderstelt een bepaalde montage en nulstand van de sensor. De ruwe sensorhoek loopt rond bij een volledige omwenteling. Controleer of de werkhoek correct is en binnen het gekozen bereik geen sprong vertoont.

#voorbereiding(title: [Voorbereiding])[
+ Teken de regelkring en benoem setpoint, meetwaarde, regelfout, regelaar, actuator en sensor.

+ Bereken voor $r = 40^compose$, $theta = 30^compose$ en $K_p = 2$ de P-bijdrage. Welke PWM-duty cycle hoort daarbij als de andere bijdragen nul zijn?

+ Gebruik je open-loopmetingen om een haalbare doelhoek en de benodigde stationaire motoruitgang te kiezen. Waarom kan een P-regelaar zonder basisuitgang daarvoor een niet-nul fout nodig hebben?

+ Voorspel wat er verandert wanneer je achtereenvolgens $K_p$, $K_i$ en $K_d$ verhoogt. Beschrijf ook een mogelijk nadeel per term.

+ Zoek in de sketch de hoekconversie, de uitgangsbegrenzing en het moment waarop de motor wordt aangestuurd. Wat gebeurt er na een reset?

+ Maak een meetplan voor een eerlijke vergelijking van P, PI en PID. Leg beginhoek, doelhoek, meetduur, herhalingen en criteria voor een goede regeling vooraf vast.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Uitvoering]

#opdracht(title: [Opdracht 1 --- Controle en eerste instelling])[
+ Controleer met uitgeschakelde motorvoeding de bedrading en bewegingsvrijheid. Lees via USB de sensor uit en beweeg de stilstaande arm voorzichtig. Controleer nulstand, teken en continuïteit van de hoekmeting.

+ Laat een eventuele correctie van de hoekconversie controleren. Een grotere motoruitgang moet binnen het werkgebied een grotere gemeten hoek geven, passend bij `DIRECT`.

+ Kies met de begeleider een haalbaar setpoint uit de open-loopmetingen en een toegestane bovengrens voor PWM. Pas hiervoor `MAX_PWM` aan.

+ Begin met een P-regelaar: zet `ki = 0` en `kd = 0`. Kies een kleine positieve `kp` in overleg met de begeleider. Gebruik niet automatisch de volledige oorspronkelijke PI-instelling.

+ Leg de instellingen en voedingswaarden vast. Upload met uitgeschakelde motorvoeding. Houd bij het inschakelen afstand en controleer of de regeling de afwijking in de juiste richting corrigeert.

]

#include "CSV_werkwijze.typ"

#opdracht(title: [Opdracht 2 --- P-regeling])[
+ Onderzoek minimaal drie stapsgewijs gekozen waarden van $K_p$, met $K_i = K_d = 0$. Verhoog niet verder bij toenemende oscillaties of overschrijding van het afgesproken bereik.

+ Gebruik per meting dezelfde ruststand en hetzelfde setpoint. Schakel de motorvoeding uit, wacht tot de arm stilstaat en upload of reset. Schakel de gecontroleerde motorvoeding in terwijl de sketch wacht. Verstuur `S` in Serial Monitor. De Arduino-tijd in de CSV begint bij dat startcommando.

+ Meet tot een stationaire toestand zichtbaar is, of tot de vooraf afgesproken maximale meetduur. Registreer ook wanneer de arm het setpoint niet bereikt.

+ Herhaal iedere instelling minimaal drie keer. Bewaar per proef de CSV en noteer $K_p$, $K_i$, $K_d$, setpoint, PWM-grens en voedingsinstellingen in je labjournaal.

+ Vergelijk snelheid, oscillaties en blijvende fout. Kies een bruikbare P-instelling als uitgangspunt voor de volgende opdracht.

]

#opdracht(title: [Opdracht 3 --- PI-regeling])[
+ Houd de gekozen $K_p$ gelijk en laat $K_d = 0$. Voeg een kleine positieve $K_i$ toe. Onderzoek minimaal drie waarden en herhaal het meetprotocol van opdracht 2.

+ Start voor iedere proef een nieuwe registratie. Het startcommando wist de integrator en activeert de regeling direct. Daardoor neemt de integrator de geschiedenis van de vorige proef niet mee.

+ Onderzoek of de stationaire fout kleiner wordt en welke invloed $K_i$ heeft op overshoot en insteltijd. Bekijk daarbij ook of de PWM-uitgang tegen een grens blijft staan.

+ Selecteer een PI-instelling en onderbouw de keuze met meetresultaten. Gebruik geen onhaalbaar setpoint om de integrator bewust te laten oplopen.

]

#opdracht(title: [Opdracht 4 --- PID-regeling])[
+ Houd de gekozen $K_p$ en $K_i$ gelijk. Vergelijk $K_d = 0$ met minimaal twee kleine positieve waarden van $K_d$ en herhaal iedere meting drie keer.

+ Bekijk zowel de hoek als de PWM-uitgang. Minder overshoot kan samengaan met een onrustiger stuursignaal. Verlaag $K_d$ wanneer meetruis de motoruitgang sterk laat fluctueren.

+ Kies op basis van de resultaten een eindinstelling. Als PI beter presteert dan PID, is $K_d = 0$ een geldige uitkomst; motiveer dit met je metingen.

+ Test deze instelling bij een tweede haalbare doelhoek met dezelfde begincondities. Onderzoek of de afstelling ook daar bruikbaar is.

]

#opdracht(title: [Verdieping --- Setpointsprong tijdens de regeling])[
Pas in een eigen kopie het setpoint na een vast tijdstip eenmalig aan naar een tweede goedgekeurde hoek. Dit vraagt een codewijziging; het kan niet via een commando in de oorspronkelijke sketch. Registreer het veranderende setpoint mee. Laat de wijziging vooraf controleren en test een opgaande en neergaande sprong. Raak de bewegende arm niet aan om een verstoring te maken. Vergelijk de responsen en verklaar de invloed van de eenzijdige aandrijving.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Verwerking in Python]

Het onderstaande voorbeeld leest de uit Serial Monitor opgeslagen CSV in. Gebruik een apart bestand per proef en neem de door de Arduino verstuurde kolomkop mee.

#jupytercode([Meetbestand inlezen en controleren])[
```python
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('pid_meting.csv')
df['t_s'] = df['t_ms'] / 1000
dt = df['t_ms'].diff().dropna()
print('Meetinterval [ms]:', dt.describe())
if (dt <= 0).any():
    raise ValueError('Controleer op reset of onjuiste tijdstempels.')

fig, ax = plt.subplots(2, 1, sharex=True, figsize=(8, 6))
ax[0].plot(df['t_s'], df['angle_deg'], label='Gemeten hoek')
ax[0].plot(df['t_s'], df['setpoint_deg'], '--', label='Setpoint')
ax[0].set_ylabel('Hoek [graden]')
ax[0].legend()
ax[1].plot(df['t_s'], df['pwm'])
ax[1].set_ylabel('PWM [telwaarden]')
ax[1].set_xlabel('Tijd sinds startcommando [s]')
for a in ax:
    a.grid()
fig.tight_layout()
plt.show()
```

]

Gebruik de geregistreerde tijdstempels voor de tijdas. Het meet- en regelinterval hoort ongeveer 20 ms te zijn. De bibliotheek schaalt de I- en D-term met die ingestelde periode; afwijkingen daarvan zijn relevant voor de regeling. Vergelijk daarom ook de spreiding van de tijdsintervallen.

#heading(level: 2, numbering: none)[Beoordelingscriteria]

Kies voor alle proeven dezelfde analysemethode. Neem $t_0 = 0$ bij het startcommando; bij de verdiepingsopdracht gebruik je het tijdstip van de setpointsprong. Een opstartrespons vanaf rust is niet hetzelfde experiment als een sprong vanuit een geregeld evenwicht.

- #strong[Stationaire fout:] $e_(upright(s s)) = r - overline(theta)$, met de gemiddelde hoek over een aantoonbaar stabiel eindinterval, bijvoorbeeld de laatste vijf seconden. Geef ook de standaarddeviatie en de lengte van dit interval. Bij blijvende drift of oscillatie rapporteer je dat geen stationaire toestand is bereikt.

- #strong[Overshoot bij een opgaande respons:] $O = max \( 0 \, theta_(upright(m a x)) - r \)$ in graden. Eventueel normaliseer je als $100 % thin O \/ \| r - theta_0 \|$, waarbij $theta_0$ de beginhoek is en $r eq.not theta_0$.

- #strong[Insteltijd:] tijd vanaf $t_0$ totdat de hoek binnen een vooraf gekozen band rond het setpoint blijft, bijvoorbeeld $r plus.minus 2^compose$, tot het einde van de registratie. Vereis daarna nog minimaal vijf seconden meettijd. Als dit niet gebeurt, rapporteer je "niet bereikt binnen de meetduur".

- #strong[Verzadiging:] geef aan of en hoelang de uitgang nabij nul of de ingestelde bovengrens blijft. Gebruik voor de tijdsduur de tijdstempels en noteer de gebruikte tolerantie.

#opdracht(title: [Opdracht 5 --- Vergelijken en verklaren])[
+ Controleer meetinterval, ontbrekende waarden en eventuele resets. Leg uit welke gegevens bruikbaar zijn en waarom.

+ Maak voor de gekozen P-, PI- en PID-instelling grafieken van hoek, setpoint en PWM. Gebruik dezelfde asschalen en lijn de proeven uit op $t_0$.

+ Maak een tabel met per instelling $K_p$, $K_i$, $K_d$, stationaire fout, overshoot en insteltijd. Rapporteer de spreiding over de drie herhalingen.

+ Verklaar de verschillen tussen P, PI en PID aan de hand van de drie regelbijdragen. Betrek de PWM-grafieken bij je verklaring.

+ Vergelijk de doelhoek en benodigde stationaire PWM met je open-loopmetingen. Bespreek waarom terugkoppeling kan corrigeren voor afwijkingen, maar geen onhaalbare hoek bereikbaar maakt.

+ Formuleer een conclusie: welke instelling voldoet het best aan jouw vooraf gekozen criteria? Bespreek de invloed van meetruis, timing, wrijving en uitgangsbegrenzing.

]

#afronding(title: [Afronding])[
+ Schakel de motorvoeding uit en wacht tot de propeller stilstaat.

+ Laat de gekozen afstelling en meetresultaten controleren door de practicumbegeleider.

+ Bewaar de gebruikte sketch, ruwe meetbestanden, instellingen en Python-analyse bij elkaar in je practicum-map.

+ Werk je labjournaal bij met de meetmethode, grafieken, vergelijkingstabel en onderbouwde conclusie.

]

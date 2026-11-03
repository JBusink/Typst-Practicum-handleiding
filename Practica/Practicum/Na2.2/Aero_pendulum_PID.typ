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

- Je kunt in stap 5 veiligheidsbegrenzingen toevoegen en hun werking aantonen.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ Gebruik dezelfde gecontroleerde opstelling en voedingsinstellingen als bij het open-looppracticum. Laat het toegestane hoekbereik en de maximale motoruitgang vaststellen door de practicumbegeleider.

+ Schakel de motorvoeding uit voordat je bedrading, sensor of programma aanpast. De sketch wacht na uploaden of resetten op configuratie en een expliciet startcommando vanuit Python.

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

De regelperiode wordt via Python ingesteld met `--interval` (standaard 100 ms, nominaal 10 Hz). De Arduino gebruikt dezelfde periode voor PID en meetuitvoer op 115200 baud. Controleer de werkelijke intervallen met de tijdstempels.

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Opstelling en bestanden]

In dit practicum voer je eerst de PID-regeling uit en stel je P, I en D af. Daarna onderzoek je met dezelfde Arduino-sketch en dezelfde Python-functie de invloed van een ingestelde maximale werkhoek.

Gebruik dezelfde gecontroleerde opstelling en aansluitingen als bij open-loop. D9 gaat naar ENA, D10 naar IN1 en D11 naar IN2; A4 en A5 gaan naar SDA en SCL. Gebruik de aansluittabel uit de open-loophandleiding voor de draadkleuren en sensorvoeding.

Alle programmabestanden staan onder `Arduino`:

```text
Arduino/
  OpenLoop/
    Stap_1_Sensor/Stap_1_Sensor.ino
    Stap_2_PWM_en_sensor/Stap_2_PWM_en_sensor.ino
    Stap_3_Python_aansturing/Stap_3_Python_aansturing.ino
  ClosedLoop/
    Stap_4_PID/Stap_4_PID.ino
    Stap_5_PWM_begrenzing/Stap_5_PWM_begrenzing.ino
  Python/
    open_loop.py
    closed_loop.py
```

Open iedere sketch vanuit de eigen gelijknamige map. Selecteer Arduino Uno R4 Minima en installeer `AS5600` van Rob Tillaart en `PID` van Brett Beauregard. Installeer in de gebruikte Python-omgeving `pyserial`, `pandas` en `matplotlib`. Sluit Serial Monitor en Serial Plotter voordat je Python start. De gevonden poort is `COM4`; controleer deze opnieuw wanneer je de opstelling op een andere computer aansluit.

#voorbereiding(title: [Voorbereiding])[
+ Teken de regelkring en benoem setpoint, meetwaarde, regelfout, regelaar, actuator en sensor.

+ Gebruik de open-loopmetingen om een haalbare doelhoek, voedingsinstellingen en een toegestane maximale PWM te kiezen. Bepaal de ruwe sensorhoek bij de verticale ruststand.

+ De Arduino berekent `werkhoek = sensorhoek - beginhoek` en vouwt deze terug naar het bereik van -180 tot 180 graden. Dit past bij de omgekeerde sensormontage: de sensorhoek neemt toe wanneer de arm omhoog beweegt. Controleer met de motorvoeding uit of nulstand, teken en verloop kloppen. Bij `DIRECT` moet meer motorvermogen een grotere werkhoek opleveren.

+ Voorspel de invloed van P, I en D op stationaire fout, overshoot en insteltijd. Maak een meetplan met gelijke begincondities en minimaal drie herhalingen per instelling.

]

#pagebreak(weak: true)
#heading(level: 1, numbering: none)[Deel 1 - Stap 4: PID uitvoeren]

In stap 4 staat het uitvoeren en afstellen van PID centraal. Gebruik `Stap_4_PID.ino` en de Python-functie `voer_pid_stap4_uit`.

#opdracht(title: [Stap 4: PID uitvoeren en afstellen])[
+ Open `Arduino/ClosedLoop/Stap_4_PID/Stap_4_PID.ino` en upload met uitgeschakelde motorvoeding. Lees de PID-variabelen, `SetTunings`, `SetOutputLimits`, `SetSampleTime` en `Compute`. Leg uit hoe de gemeten hoek de PWM-uitgang verandert.

+ Voer eerst een communicatieproef uit met `max_pwm=0` en de motorvoeding uit. Gebruik de hieronder beschreven Python-aanroep. Vul bij `beginhoek` de gemeten ruwe rusthoek in; 90 is alleen een voorbeeld.

+ Kies met de begeleider de maximale PWM en een haalbare doelhoek. Schakel de gecontroleerde motorvoeding in terwijl de Arduino wacht en start de proef vanuit Python. Python configureert de regelaar en verstuurt daarna `START`. De tijdstempels in het meetbestand beginnen bij dit commando.

+ Begin met P: houd `ki=0` en `kd=0`. Onderzoek minimaal drie kleine, stapsgewijs gekozen waarden van `kp`. Vergelijk de stationaire fout, oscillaties en snelheid. Stop bij toenemende oscillaties of beweging naar een aanslag.

+ Voeg bij een bruikbare P-instelling een kleine `ki` toe en vergelijk minimaal drie waarden. Onderzoek of de stationaire fout kleiner wordt en of overshoot of insteltijd toenemen.

+ Vergelijk vervolgens `kd=0` met minimaal twee kleine positieve D-instellingen. Bekijk ook het PWM-signaal: een lagere overshoot kan samengaan met meer gevoeligheid voor meetruis.

+ Herhaal iedere instelling minimaal drie keer, met dezelfde beginhoek en voeding. Gebruik per proef een nieuwe bestandsnaam. De integrator wordt bij een nieuwe start opnieuw ingesteld. Kies een eindinstelling en test die bij een tweede haalbare doelhoek. Een PI-instelling met `kd=0` is ook een geldige uitkomst.

]

#heading(level: 2, numbering: none)[PID uitvoeren vanuit Python]

Gebruik in de notebook `script.ipynb` de functie uit `closed_loop/meting.py`. Upload voor beide onderdelen dezelfde sketch `Stap_4_PID.ino`. Vul de gemeten beginhoek en de gekozen instellingen in:

#jupytercode([PID-meting])[
```python
from closed_loop.meting import voer_pid_stap4_uit

metingen, csv_pad = voer_pid_stap4_uit(
    com_poort=com_poort, beginhoek=beginhoek,
    doelhoek=doelhoek, kp=kp, ki=ki, kd=kd,
    max_pwm=max_pwm, meetduur=meetduur,
    delta_t=delta_t, mode="fixed", toon_metingen=True,
)
```
]

De meetfunctie slaat meetgegevens en instellingen op in een eigen CSV-bestand per proef. Bekijk de hoek, het setpoint en de motoruitgang en vergelijk P, PI en PID met dezelfde begincondities.

#pagebreak(weak: true)
#heading(level: 1, numbering: none)[Vervolgopdracht: de maximale hoek aanpassen]

Je gebruikt opnieuw `voer_pid_stap4_uit` en dezelfde geuploade Arduino-sketch. De functie gebruikt standaard `max_hoek=180`, ook wanneer dit argument niet in de aanroep staat. Python verstuurt deze grens bij iedere configuratie naar de Arduino. Je verlaagt de grens nu bijvoorbeeld naar 120 graden.

#opdracht(title: [Dezelfde PID-regeling met een lagere hoekgrens])[
+ Voeg `max_hoek=120` toe aan dezelfde Python-aanroep. Kies een doelhoek binnen het toegestane bereik en houd de overige instellingen gelijk voor een vergelijking.

+ Zoek in Python waar `max_hoek` wordt meegestuurd en in de Arduino waar de werkhoek wordt gecontroleerd. De controle vindt plaats voor het starten en voor iedere PID-aansturing. Alleen een werkhoek groter dan `max_hoek` veroorzaakt deze hoekstop; sensorstatus en een lagere werkhoek veroorzaken geen hoekstop.

+ Test met de motorvoeding uit en `max_pwm=0` een bewust klein gekozen grens, ruim voor een mechanische aanslag. Beweeg de arm voorzichtig over deze grens. Controleer dat de motoruitgang nul wordt, de meting stopt en `ERROR:HOEKBEREIK` wordt gemeld. Test ook een start buiten het bereik.

+ Controleer de foutvergrendeling: opnieuw `START` is na een fout niet voldoende. De Python-functie verstuurt bij een nieuwe proef opnieuw een configuratie; daarna wordt de maximale werkhoek opnieuw gecontroleerd.

+ Leg de grens, testsituatie, verwachte reactie en waargenomen reactie vast in een tabel. Herhaal na controle een gewone PID-proef met dezelfde afstelling als eerder. Lok geen overschrijding uit met draaiende propeller.

]

#jupytercode([Dezelfde functie met een grens van 120 graden])[
```python
metingen_begrensd, csv_pad_begrensd = voer_pid_stap4_uit(
    com_poort=com_poort, beginhoek=beginhoek,
    doelhoek=doelhoek, kp=kp, ki=ki, kd=kd,
    max_pwm=max_pwm, meetduur=meetduur,
    delta_t=delta_t, mode="fixed", toon_metingen=True,
    max_hoek=120,
)
```
]

De gezamenlijke sketch gebruikt de maximale werkhoek als hoekstop en behoudt de PWM-grens, heartbeat, eindige meetduur en `STOP`. De magneetstatus wordt niet als stopvoorwaarde gebruikt. Het sluiten van een venster is geen stopcommando. De Python-functie stuurt ook bij een fout of onderbreking `STOP`; houd de fysieke uitschakeling bereikbaar.

#pagebreak(weak: true)
#heading(level: 1, numbering: none)[Stap 5: de maximale PWM-sprong begrenzen]

Gebruik `Stap_5_PWM_begrenzing.ino` en `voer_pid_stap5_uit` in `script.ipynb`. Met `max_pwm_stap=20` verandert de werkelijk aangeboden PWM per regelstap maximaal 20 telwaarden omhoog. Dalende PWM wordt direct overgenomen, zonder stapbegrenzing. Kleinere veranderingen worden direct overgenomen. Zonder argument wordt geen begrenzer ingesteld. Een vraag van 0 naar 255 wordt zo bijvoorbeeld 0, 20, 40, 60, enzovoort.

#opdracht(title: [Stap 5: begrens grote PWM-sprongen])[
+ Neem dezelfde PID-instellingen, doelhoek en beginstand als bij stap 4. Maak een referentiemeting met `voer_pid_stap5_uit` zonder argument `max_pwm_stap`.

+ Herhaal met `max_pwm_stap=20` en vergelijk daarna bijvoorbeeld 10 en 40 telwaarden per regelstap. Houd het regelinterval en de overige instellingen gelijk en herhaal iedere instelling drie keer.

+ Plot de werkhoek en de werkelijk aangeboden PWM. Vergelijk de grootte van de PWM-sprongen, overshoot, insteltijd en stationaire fout. Onderzoek de extra vertraging bij een grote gevraagde verandering. Bij een ander regelinterval verandert ook de maximale verandering per seconde.

+ Controleer met de motorvoeding uit dat STOP, de maximale hoek, de meetduur en de heartbeat-stop de uitgang direct op nul zetten. Deze stops omzeilen de begrenzer.

]

#jupytercode([PID met een maximale PWM-sprong])[
```python
metingen, csv_pad = voer_pid_stap5_uit(
    com_poort=com_poort, beginhoek=beginhoek,
    doelhoek=doelhoek, kp=kp, ki=ki, kd=kd,
    max_pwm=max_pwm, meetduur=meetduur,
    delta_t=delta_t, mode="fixed", toon_metingen=True,
    max_pwm_stap=20,
)
```
]

Gebruik een geheel getal van 1 tot 255 voor de maximale sprong. Weglaten schakelt de begrenzer uit; 0 schakelt hem expliciet uit. `max_pwm` is de maximale uitgang en staat los van `max_pwm_stap`. Bij `max_pwm=0` blijft de motor uit. Python controleert of de bijgewerkte stap-5-sketch is aangesloten.

#heading(level: 1, numbering: none)[Meetgegevens verwerken]

De notebookfunctie bewaart instellingen als commentaarregels en daarna de kolommen `tijd_s,hoek_deg,pwm`. `hoek_deg` is de gecorrigeerde werkhoek; het setpoint staat in de instellingen. Er zijn geen kolommen `running` of `sensor_ok`; een fout stopt de proef en wordt als foutmelding getoond. Bewaar die foutmelding en de gebruikte instellingen bij de meetgegevens.

#jupytercode([Closed-loopmetingen bekijken])[
```python
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv(csv_pad, comment='#')
if df.empty:
    raise ValueError('Geen meetpunten opgeslagen')
df['t_s'] = df['tijd_s']
print(df['tijd_s'].diff().describe())
fig, ax = plt.subplots(2, 1, sharex=True)
ax[0].plot(df['t_s'], df['hoek_deg'], label='Werkhoek')
ax[0].axhline(doelhoek, linestyle='--', label='Setpoint')
ax[0].set_ylabel('Hoek (graden)')
ax[0].legend()
ax[1].plot(df['t_s'], df['pwm'])
ax[1].set_ylabel('PWM')
ax[1].set_xlabel('Tijd sinds START (s)')
for a in ax:
    a.grid()
plt.show()
```
]

Vergelijk P, PI en PID met dezelfde analysemethode: stationaire fout en standaarddeviatie over een stabiel eindinterval, maximale overshoot, insteltijd binnen een vooraf gekozen tolerantieband en tijd tegen de PWM-grens. Rapporteer wanneer geen stationaire toestand wordt bereikt. Geef de spreiding over de herhalingen. Leg voor de vervolgopdracht daarnaast in een testtabel de ingestelde grens, testsituatie, verwachte reactie en waargenomen reactie vast.

#afronding(title: [Afronding])[
+ Schakel de motorvoeding uit en wacht tot de propeller stilstaat.

+ Laat PID-afstelling en begrenzingstests controleren door de practicumbegeleider.

+ Bewaar de gebruikte sketches, instellingen, ruwe meetgegevens en Python-analyse bij elkaar. Beschrijf apart de resultaten van stap 4 (regelgedrag) en de vervolgopdracht (lagere hoekgrens).

]



#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix: Materialen Lijst Practica]
- Arduino Uno R4 Minima;
- L298N H-brug;
- AS5600 magnetische hoeksensor;
- Elektromotor met propeller;
- Externe voeding;
- USB-C kabel en koppelstuk;
- Platform met paal en 3D geprint aansluitstuk, arm met draaipunt en magneet;
- Diverse aansluitdraden (Male-Male, Male-Female, Female-Female);
- Laptop of computer met Arduino IDE en Python 3.11+;

#heading(level: 1, numbering: none)[Appendix: Afleiding bewegingsvergelijking]

== Bewegingsvergelijking van het aeropendulum (open loop)
We beschouwen een aeropendulum bestaande uit een roterende arm met een propeller. De propeller levert een stuwkracht waardoor de arm om zijn draaipunt roteert.

Volgens de tweede wet van Newton voor rotaties geldt:

#math.equation(block: true, numbering: "(1)", $sum tau = J dot.double(theta).$)

Hierin is $J$ het traagheidsmoment rond het draaipunt en $theta$ de hoek van de arm ten opzichte van de verticale evenwichtspositie.\
\
Op de arm werken drie koppels:

- Het motorkoppel door de stuwkracht van de propeller.
- Het zwaartekrachtsmoment.
- Het dempende koppel door wrijving.

Het motorkoppel schrijven we als $tau_m = l_T F_T$, waarbij $l_T$ de afstand tussen het draaipunt en de aangrijpingslijn van de stuwkracht is. Het zwaartekrachtsmoment is: $tau_g = -m g l sin(theta) $. Hierin is $l$ de afstand van het draaipunt tot het massamiddelpunt. We modelleren de wrijving als een krachtmoment dat evenredig is met de hoeksnelheid: $tau_w = -b dot(theta) $.

De bewegingsvergelijking wordt daarmee:

#math.equation(block: true,numbering: "(1)", $J dot.double(theta) = l_T F_T - b dot(theta) - m g l sin(theta)$)


Of, na herschikken:

#math.equation(block: true,numbering: "(1)", $J dot.double(theta) + b dot(theta) + m g l sin(theta)= l_T F_T $)


=== Relatie tussen PWM en stuwkracht

We nemen aan dat de stuwkracht direct en lineair afhangt van de PWM-waarde $u$:

#math.equation(block: true,numbering: "(1)", $ F_T = k_u u $) #footnote[De stuwkracht is in werkelijkheid een niet-lineaire functie van de PWM-waarde. Voor kleine afwijkingen rond het evenwicht kan deze relatie echter worden benaderd als lineair.].

Hierin is $k_u$ een evenredigheidsconstante. We defineren nu $A = l_T k_u $, zodat het motorkoppel kan worden geschreven als $tau_m = A u$.
Daarmee wordt de bewegingsvergelijking:

#math.equation(block: true,numbering: "(1)", eqbox[$J dot.double(theta) + b dot(theta) + m g l sin(theta) = A u$])

Dit is een niet-lineaire differentiaalvergelijking van de tweede orde.

#pagebreak(weak: true)

== De P-regelaar

We willen de pendulum stabiliseren rond een gewenste hoek $theta_r$. De fout tussen de gewenste en de gemeten hoek is:

#math.equation(block:true,numbering: "(1)", $ e(t) = theta_r - theta(t) $)

Een proportionele regelaar past de PWM-waarde aan op basis van deze fout:

#math.equation(block:true,numbering: "(1)", $ u(t) = u_0 + K_p e(t) $)

Hierin zijn:

- $u_0$: de PWM-waarde die nodig is om de gewenste hoek vast te houden.
- $K_p$: de proportionele versterking.

We nemen aan dat de gewenste hoek constant is.

Bij de gewenste hoek $theta_0 = theta_r$ is de pendulum in evenwicht. De hoeksnelheid en hoekversnelling zijn dan nul:

#math.equation(block:true,numbering: "(1)", $ dot(theta) = 0, quad dot.double(theta) = 0 $)

Uit de bewegingsvergelijking volgt:

#math.equation(block:true,numbering: "(1)", $ m g l sin(theta_0) = A u_0 $)

De PWM-waarde die nodig is om dit evenwicht te handhaven is dus:

#math.equation(block:true,numbering: "(1)", $ u_0 = (m g l sin(theta_0))/A $)

We combineren deze evenwichtsaansturing met de P-regelaar:

#math.equation(block:true,numbering: "(1)", $ u(t) = u_0 + K_p (theta_r - theta(t)) $)

== Kleine afwijkingen rond het evenwicht

We onderzoeken wat er gebeurt als de pendulum een kleine afwijking heeft ten opzichte van de gewenste hoek.

Schrijf de werkelijke hoek als:

#math.equation(block:true,numbering:"(1)",$ theta(t) = theta_0 + epsilon(t) $)

Hierin is $epsilon(t)$ de kleine afwijking van de evenwichtshoek.

Omdat $theta_r = theta_0$, geldt:

#math.equation(block:true,numbering:"(1)",$ e(t) = -epsilon(t) $)

De regelaar wordt daarmee:

#math.equation(block:true,numbering:"(1)",$ u(t) = u_0 - K_p epsilon(t) $)  

Vul dit in bij de bewegingsvergelijking:

#math.equation(block:true,numbering:"(1)",$ J dot.double(theta) + b dot(theta) + m g l sin(theta) = A (u_0 - K_p epsilon) $)

Omdat $theta = theta_0 + epsilon$ en $theta_0$ constant is, geldt:

#math.equation(
  block: true,
  numbering: "(1)",
  $
    dot(theta) &= dot(epsilon) \
    dot.double(theta) &= dot.double(epsilon)
  $
)
We krijgen:

#math.equation(block:true,numbering:"(1)",$ J dot.double(epsilon) + b dot(epsilon) + m g l sin(theta_0 + epsilon) = A u_0 - A K_p epsilon $)

=== Linearisatie

Voor kleine afwijkingen $epsilon$ kunnen we de sinusfunctie benaderen met een Taylorontwikkeling:

$ sin(theta_0 + epsilon) approx sin(theta_0) + epsilon cos(theta_0) $

Invullen geeft:

$
+ m g l sin(theta_0)
+ m g l cos(theta_0) epsilon
= A u_0 - A K_p epsilon
$

We weten dat in het evenwicht geldt:

$ m g l sin(theta_0) = A u_0 $

Deze constante termen vallen dus tegen elkaar weg.

Daarmee vinden we:

#math.equation(block:true,numbering:"(1)",$ J dot.double(epsilon) + b dot(epsilon) + m g l cos(theta_0) epsilon = -A K_p epsilon $)

Breng alle termen naar de linkerkant:

#math.equation(
  block: true,
  numbering: "(1)",
  eqbox[
    $ J dot.double(epsilon) + b dot(epsilon)
      + (m g l cos(theta_0) + A K_p) epsilon = 0 $
  ],
)

Dit is de gelineariseerde bewegingsvergelijking van de P-geregelde aeropendulum.


== Eigenfrequenties van aeropendulum
Om het frequentiegedrag van het systeem te analyseren, herschrijven we de bewegingsvergelijking in de standaardvorm van een gedempte harmonische oscillator:

#math.equation(
  block: true,
  numbering: "(1)",
      $ J dot.double(epsilon) + b dot(epsilon)
      + (m g l cos(theta_0) + A K_p) epsilon = 0 $
  ,
)
nu noteren we $k_"eff" = m g l cos(theta_0) + A K_p$ als de effectieve stijfheid van het systeem en delen we door $J$. De bewegingsvergelijking wordt dan:

$ dot.double(x) + b/J dot(x) + k_"eff"/J x = 0. $

Dit lijkt al bijna op de standaardvorm van een gedempte harmonische oscillator. We vergelijken dit met de algemene vorm:

$ dot.double(x) + 2 zeta omega_0 dot(x) + omega_0^2 x = 0 $


#intermezzo[De harmonische oscillator en stabiliteit][
  Een gedempte harmonische oscillator beschrijft een systeem waarin een herstellende kracht en een dempende kracht werkzaam zijn. Een bekend voorbeeld is een massa aan een veer.

  De bewegingsvergelijking luidt:

  $ m dot.double(x) + b dot(x) + k x = 0 $

  Hierin is $m$ de massa, $b$ de dempingscoëfficiënt en $k$ de veerconstante.

  De herstellende kracht $F = -k x$ werkt de uitwijking tegen, terwijl de dempende kracht $F = -b dot(x)$ de beweging tegenwerkt.

  == Eigenfrequentie en demping

  De ongedempte eigenhoekfrequentie wordt gegeven door:

  $ omega_0 = sqrt(k/m) $

  De dimensieloze dempingsratio is:

  $ zeta = b / (2 sqrt(m k)) $

  Voor $m > 0$ en $k > 0$ onderscheiden we drie situaties:

  - *Ondergedempt* ($0 < zeta < 1$): het systeem oscilleert rond de evenwichtspositie, waarbij de amplitude geleidelijk afneemt.
  - *Kritisch gedempt* ($zeta = 1$): het systeem keert zonder oscillaties zo snel mogelijk terug naar de evenwichtspositie.
  - *Overgedempt* ($zeta > 1$): het systeem keert zonder oscillaties terug naar de evenwichtspositie, maar langzamer dan bij kritische demping.

  == Stabiliteit

  Voor het ondergedempte geval is de oplossing:

  $ x(t) = X_0 e^(-b/(2m) t) cos(omega_d t + phi) $

  met de gedempte eigenhoekfrequentie:

  $ omega_d = sqrt(k/m - b^2/(4m^2)) $

  De exponentiële factor bepaalt hoe de amplitude zich ontwikkelt:

  $ X(t) = X_0 e^(-b/(2m) t) $

  Hieruit volgt:

  - Bij $b > 0$ neemt de amplitude af: de oscillaties doven uit.
  - Bij $b = 0$ blijft de amplitude constant: het systeem oscilleert zonder energieverlies.
  - Bij $b < 0$ neemt de amplitude toe: het systeem is instabiel.

  Deze uitspraken over de amplitude gelden voor oscillerende oplossingen. Voor $k > 0$ is het evenwicht bij $b > 0$ asymptotisch stabiel, ook wanneer het systeem niet oscilleert.

]

De frequentie van het p-geregelde aeropendulum wordt bepaald door de effectieve stijfheid $k_"eff"$ en het traagheidsmoment $J$:

$ eqbox(omega_0^2 = (m g l cos(theta_0) + A K_p)/J) $

De relatieve demping wordt bepaald door de dempingscoëfficiënt $b$ en het traagheidsmoment $J$:

$ eqbox(zeta = b/(2 sqrt(J (m g l cos(theta_0) + A K_p))).) $

=== Invloed van de proportionele versterking

Als we $K_p$ verhogen, neemt de effectieve stijfheid dus toe.

Hierdoor:

- Neemt de eigenfrequentie $omega_0$ toe.
- Neemt de relatieve demping $zeta$ af.
- Worden de oscillaties sneller.
- Kan de overshoot bij een verandering van het setpoint toenemen.

Een kleinere dempingsratio betekent echter niet automatisch dat het systeem instabiel wordt. Hoe kan het dan dat een te grote proportionele versterking in de praktijk toch instabiliteit kan veroorzaken?



=== Invloed van een vertraagde kracht

Tot nu toe hebben we aangenomen dat de stuwkracht van de motor onmiddellijk verandert wanneer de proportionele regelaar de PWM-waarde aanpast. In werkelijkheid heeft de motor echter een eindige reactietijd. Wanneer de regelaar de PWM-waarde verhoogt, duurt het enige tijd voordat de motor versnelt en de stuwkracht toeneemt.

Dit betekent dat de motor nog een relatief grote kracht kan leveren op het moment dat de pendulum de gewenste hoek al heeft bereikt. De regelaar probeert de motor dan af te remmen, maar de stuwkracht reageert vertraagd. Hierdoor kan de pendulum doorschieten.

Om dit effect te beschrijven, introduceren we een tijdconstante $tau_m$ voor de motor. We nemen aan dat de werkelijke stuwkracht $F_T$ de gewenste stuwkracht $F_"gewenst"$ volgt volgens:

#math.equation(block: true, numbering: "(1)",
  $ tau_m dot(F_T) + F_T = F_"gewenst" $
)

Dit is een eersteorde-differentiaalvergelijking. De tijdconstante $tau_m$ bepaalt hoe snel de motor reageert. Na één tijdconstante heeft de stuwkracht ongeveer 63% van een opgelegde stapverandering bereikt.

Bij een P-regelaar is de gewenste stuwkracht afhankelijk van de afwijking $epsilon$ ten opzichte van de evenwichtshoek:

#math.equation(block: true, numbering: "(1)",
  $ F_"gewenst" = F_0 - k_u K_p epsilon $
)

Hierin is $F_0$ de stuwkracht die nodig is om de pendulum in evenwicht te houden.

We schrijven de werkelijke stuwkracht als:

$ F_T = F_0 + f $

waarbij $f$ de afwijking van de evenwichtsstuwkracht is.

Invullen in het motormodel geeft:

#math.equation(block: true, numbering: "(1)",
  $ tau_m dot(f) + f = -k_u K_p epsilon $
)

Vermenigvuldig met de motorarm $l_T$ en gebruik $A = l_T k_u$. We definiëren bovendien het afwijkende motorkoppel $q = l_T f$.

Daarmee wordt:

#math.equation(block: true, numbering: "(1)",
  $ tau_m dot(q) + q = -A K_p epsilon $
)

=== De nieuwe bewegingsvergelijking

De bewegingsvergelijking van de gelineariseerde pendulum is:

#math.equation(block: true, numbering: "(1)",
  $ J dot.double(epsilon) + b dot(epsilon)
    + m g l cos(theta_0) epsilon = q $
)

Voor het gemak definiëren we:

$ B = m g l cos(theta_0) $

Daarmee krijgen we twee gekoppelde differentiaalvergelijkingen:


We hebben nu twee gekoppelde differentiaalvergelijkingen die samen de beweging van de pendulum en de respons van de motor beschrijven:

#math.equation(block: true, numbering: "(1)",
  $ J dot.double(epsilon) + b dot(epsilon) + B epsilon = q $
)

#math.equation(block: true, numbering: "(1)",
  $ tau_m dot(q) + q = -A K_p epsilon $
)

Om deze vergelijkingen samen te voegen, gebruiken we eliminatie door substitutie. Uit de eerste vergelijking drukken we het motorkoppel $q$ uit in termen van de hoek $epsilon$ en haar afgeleiden. Door deze uitdrukking naar de tijd te differentiëren, vinden we ook een uitdrukking voor $dot(q)$. \ 
\

Vervolgens substitueren we beide uitdrukkingen in de tweede vergelijking. Hiermee elimineren we de variabele $q$ en verkrijgen we één differentiaalvergelijking voor de hoekafwijking $epsilon$:

#math.equation(
  block: true,
  numbering: "(1)",
  $ eqbox(
    tau_m J dot.triple(epsilon)
    + (J + tau_m b) dot.double(epsilon)
    + (b + tau_m B) dot(epsilon)
    + (B + A K_p) epsilon = 0
  ) $
)

De resulterende vergelijking is van de derde orde, terwijl de oorspronkelijke bewegingsvergelijking van de pendulum van de tweede orde was. De extra orde ontstaat doordat de motor een eigen dynamische toestand heeft: de stuwkracht kan niet onmiddellijk veranderen, maar ontwikkelt zich in de tijd.

=== Wanneer ontstaat instabiliteit?

Om de stabiliteit te onderzoeken, gebruiken we het *Routh-Hurwitz-criterium*. Deze wiskundige methode bepaalt of een lineair systeem stabiel is aan de hand van de coëfficiënten van zijn karakteristieke vergelijking. We hoeven hiervoor de differentiaalvergelijking niet volledig op te lossen.

We zoeken oplossingen van de vorm:

#math.equation(block: true, numbering: "(1)",
  $ epsilon(t) = C e^(lambda t) $
)

Hierin bepaalt de exponent $lambda$ het gedrag van de beweging. In het algemeen kan $lambda$ complex zijn:

- Als alle oplossingen voor $lambda$ een negatief reëel deel hebben, doven verstoringen uit en is het systeem asymptotisch stabiel.
- Als minstens één oplossing een positief reëel deel heeft, groeit een verstoring en is het systeem instabiel.
- Als een oplossing een reëel deel gelijk aan nul heeft, bevindt het systeem zich mogelijk op een stabiliteitsgrens.

Door de exponentiële oplossing in de bewegingsvergelijking te substitueren en de gemeenschappelijke factor $C e^(lambda t)$ weg te delen, vinden we de karakteristieke vergelijking:

#math.equation(block: true, numbering: "(1)",
  $ tau_m J lambda^3
    + (J + tau_m b) lambda^2
    + (b + tau_m B) lambda
    + (B + A K_p) = 0 $
)


#intermezzo[Het Routh-Hurwitz-criterium][

  Het *Routh-Hurwitz-criterium* is een wiskundige methode waarmee we de stabiliteit van een lineair dynamisch systeem kunnen bepalen, zonder de bijbehorende differentiaalvergelijking expliciet op te lossen.

  We beschouwen een differentiaalvergelijking van de derde orde:

  #math.equation(block: true, numbering: "(1)",
    $ a_3 dot.triple(x) + a_2 dot.double(x)
      + a_1 dot(x) + a_0 x = 0 $
  )

  We zoeken oplossingen van de vorm $x(t) = C e^(lambda t)$. Substitutie levert de karakteristieke vergelijking:

  #math.equation(block: true, numbering: "(1)",
    $ a_3 lambda^3 + a_2 lambda^2
      + a_1 lambda + a_0 = 0 $
  )

  De oplossingen voor $lambda$ bepalen het gedrag van het systeem. Een systeem is asymptotisch stabiel wanneer alle oplossingen een negatief reëel deel hebben. In dat geval doven kleine verstoringen uiteindelijk uit.

  Het Routh-Hurwitz-criterium stelt dat voor een derdeorde-systeem met $a_3 > 0$ aan de volgende voorwaarden moet worden voldaan:

  #math.equation(block: true, numbering: "(1)",
    $ a_2 > 0, quad a_1 > 0, quad a_0 > 0 $
  )

  Daarnaast geldt de aanvullende voorwaarde:

  #math.equation(block: true, numbering: "(1)",
    $ eqbox(a_2 a_1 > a_3 a_0) $
  )

  Wanneer aan al deze voorwaarden wordt voldaan, liggen alle wortels van de karakteristieke vergelijking in het linkerhalfvlak van het complexe vlak. Het systeem is dan asymptotisch stabiel.\
\
  *Conclusie:* we kunnen de stabiliteit rechtstreeks uit de coëfficiënten bepalen, zonder de drie wortels van de karakteristieke vergelijking te berekenen.

]


=== Toepassing op de aeropendulum

Voor onze bewegingsvergelijking identificeren we de coëfficiënten:

$
a_3 = tau_m J, quad
a_2 = J + tau_m b
$

$
a_1 = b + tau_m B, quad
a_0 = B + A K_p
$

We nemen aan dat $J$, $b$, $B$, $A$ en $tau_m$ positief zijn en dat $K_p >= 0$. Daarmee zijn alle vier de coëfficiënten positief.

De stabiliteit wordt dus volledig bepaald door de aanvullende voorwaarde van het Routh-Hurwitz-criterium:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(
    (J + tau_m b)(b + tau_m B)
    > tau_m J (B + A K_p)
  ) $
)

Deze ongelijkheid laat zien dat een grotere proportionele versterking $K_p$ de stabiliteit kan verminderen. De rechterkant neemt immers toe met $K_p$, terwijl de linkerkant constant blijft.

Er bestaat daarom een kritische versterking waarbij de ongelijkheid overgaat in een gelijkheid. Dit is de grens tussen asymptotische stabiliteit en instabiliteit.


=== Kritische proportionele versterking

De stabiliteitsvoorwaarde laat zien dat een grotere proportionele versterking $K_p$ uiteindelijk tot instabiliteit kan leiden. De grens tussen stabiliteit en instabiliteit vinden we door de ongelijkheid te vervangen door een gelijkheid:

#math.equation(block: true, numbering: "(1)",
  $ (J + tau_m b)(b + tau_m B)
    = tau_m J (B + A K_(p,"krit")) $
)

Hierin is $K_(p,"krit")$ de *kritische proportionele versterking*: de waarde waarbij het systeem zich precies op de stabiliteitsgrens bevindt.

Door de vergelijking op te lossen naar $K_(p,"krit")$ vinden we:

#math.equation(block: true, numbering: "(1)",
  $ K_(p,"krit") =
    1/A (
      ((J + tau_m b)(b + tau_m B))/(tau_m J)
      - B
    ) $
)

Na vereenvoudiging volgt:


#math.equation(
  block: true,
  numbering: "(1)",
  $ eqbox(
    K_(p,"krit") = b/A
    (1/tau_m + b/J + (tau_m B)/J)
  ) $
) <eq:kritische-versterking>


Voor de eerder aangenomen positieve systeemparameters onderscheiden we drie situaties:

- *$K_p < K_(p,"krit")$*: het systeem is asymptotisch stabiel. Kleine verstoringen doven uiteindelijk uit.
- *$K_p = K_(p,"krit")$*: het systeem bevindt zich op de stabiliteitsgrens. Er kunnen oscillaties met constante amplitude optreden.
- *$K_p > K_(p,"krit")$*: het systeem is instabiel. Kleine verstoringen kunnen in de tijd groeien.

=== Fysische interpretatie

De kritische versterking hangt af van zowel de mechanische eigenschappen van de pendulum als de responstijd van de motor. Het is eigenlijk niet heel zinvol om  @eq:kritische-versterking in te vullen met alle constantens en parameters, dit weten we simpelweg niet. Echter, dat is ook niet het moraal van het verhaal: als de motor te traag reageert, kan een te grote proportionele versterking leiden tot instabiliteit. De motor kan dan op het verkeerde moment energie aan de beweging toevoegen, waardoor de oscillaties toenemen in plaats van afnemen.



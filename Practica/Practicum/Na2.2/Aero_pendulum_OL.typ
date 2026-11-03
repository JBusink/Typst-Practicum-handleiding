#import "../../styl.typ": *
#show: stijl.with(titel: "Aero pendulum OL", kop: "Technische Natuurkunde — Na2.2")

#show: vergelijking_refs

#praktikumtitle[Open-loop regeling van een aeropendulum]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kunt de dynamische respons van een simpel open-loop systeem experimenteel bepalen.

- Je kunt overweg met de Arduino IDE en begrijpt de werking van een H-brug, PWM en een hoeksensor.

- Je kunt vanuit Python de Arduino aansturen, meetgegevens opslaan en deze vervolgens analyseren en visualiseren.


]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ Houd tijdens de metingen voldoende afstand van de draaiende propeller en raak deze nooit aan wanneer de voeding is ingeschakeld.

+ Controleer vóór iedere meting of het aeropendulum vrij kan bewegen en of zich geen objecten binnen het bewegingsbereik bevinden.

+ De hoeksensor werkt op 3,3 V. Sluit deze nooit rechtstreeks aan op de 5 V van de Arduino.

+ Twijfel je over een handeling of apparaat? Vraag dit altijd aan de practicumbegeleider.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

Regeltechniek speelt een belangrijke rol binnen de technische natuurkunde. Veel technische systemen, zoals drones, robots, satellieten, productieprocessen en autonome voertuigen, moeten automatisch bestuurd worden om een gewenste positie of toestand te bereiken. Voordat een regelsysteem ontworpen kan worden, is het belangrijk om eerst het gedrag van het systeem zelf goed te begrijpen. Dit gebeurt vaak door het systeem in open-loop te bestuderen. \
\
Bij een open-loop systeem wordt een ingangssignaal aangeboden zonder dat de uitgang wordt teruggekoppeld naar de regeling. De besturing corrigeert dus niet voor verstoringen of afwijkingen. Hoewel deze manier van regelen relatief eenvoudig is, vormt zij de basis voor vrijwel alle moderne regelsystemen. Door de respons van een systeem op verschillende ingangssignalen te meten, kunnen eigenschappen zoals de gevoeligheid, tijdconstante, demping en niet-lineariteiten worden bepaald. \
\
Een eenvoudig voorbeeld van open-loop regeling is een magnetron. Je stelt bijvoorbeeld een vermogen van 800 W en een tijd van 2 minuten in. De magnetron voert deze instelling uit, maar meet niet of het eten daadwerkelijk de gewenste temperatuur heeft bereikt.
Is het eten na 2 minuten nog te koud? Dan corrigeert de magnetron dit niet automatisch. De uitgang (temperatuur van het eten) wordt namelijk niet teruggekoppeld naar de ingang (vermogen en verwarmingstijd). \
\
In dit practicum onderzoek je het dynamische gedrag van een aeropendulum. Dit systeem bestaat uit een arm die om een draaipunt kan roteren en wordt aangedreven door een elektrische propeller. De propeller levert een stuwkracht die de arm omhoog beweegt, terwijl de zwaartekracht de arm terug naar beneden probeert te brengen. Door de motorspanning stapsgewijs te variëren ontstaat een evenwicht tussen deze twee krachten, waardoor verschillende stationaire hoeken en dynamische responsen kunnen worden bestudeerd. \
\
Tijdens het practicum meet je de hoek van het aeropendulum als functie van de tijd voor verschillende motorspanningen. De meetgegevens worden vervolgens in geanalyseerd om de dynamische eigenschappen van het systeem te bepalen en te vergelijken met een eenvoudig fysisch model. De kennis die in dit practicum wordt opgedaan vormt de basis voor een vervolgpracticum, waarin hetzelfde systeem met behulp van terugkoppeling (#emph[closed-loop control]) automatisch zal worden geregeld.

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Theorie]

Een aeropendulum bestaat uit een draaibare arm met aan het uiteinde een elektromotor en propeller. De propeller levert een stuwkracht waardoor de arm omhoog beweegt. De zwaartekracht werkt deze beweging tegen. Door het vermogen van de motor te variëren kan de positie van het aeropendulum worden beïnvloed.

In dit practicum wordt het systeem in open-loop onderzocht. Dit betekent dat het vermogen van de motor vooraf wordt ingesteld en niet automatisch wordt aangepast op basis van de gemeten hoek. Voor iedere instelling wordt vervolgens onderzocht hoe het aeropendulum reageert.

De propeller levert een stuwkracht $F_T$ op een afstand $l_T$ van het draaipunt. Het bijbehorende moment is

#math.equation(block: true, numbering: "(1)", $M_T = l_T F_T .$)

Tegelijkertijd oefent de zwaartekracht een moment uit op het systeem. Wanneer het zwaartepunt zich op een afstand $l$ van het draaipunt bevindt, is dit moment

#math.equation(block: true, numbering: "(1)", $M_g = m g l sin theta \,$)

waarbij $m$ de massa van het bewegende systeem is, $g$ de zwaartekrachtsversnelling en $theta$ de hoek van de arm.

Volgens de tweede wet van Newton voor rotatie wordt de beweging bepaald door de som van deze momenten:

#math.equation(block: true, numbering: "(1)", $J dot.double(theta) = l_T F_T - m g l sin theta \,$)

waarbij $J$ het massatraagheidsmoment van het aeropendulum rond het draaipunt is.

#figure(
  [
#box(image("Figuren/aeropendulum.pdf", width: 55.0%))
  ],
  caption: [Schematische weergave van het aeropendulum en de relevante krachten.],
  kind: image,
)

De stuwkracht van de propeller wordt bepaald door het vermogen dat aan de motor wordt geleverd. Het elektrisch ingangsvermogen is

#math.equation(block: true, numbering: "(1)", $P_(upright(e l)) = U I \,$)

met $U$ de spanning over de motor en $I$ de stroom door de motor. Slechts een deel van dit vermogen wordt door de motor en propeller omgezet in mechanisch vermogen. Met een rendement $eta$ kan dit worden geschreven als

#math.equation(block: true, numbering: "(1)", $P_(upright(m o t o r)) = eta U I .$)

De stuwkracht kan daarom worden beschouwd als een functie van het geleverde vermogen,

#math.equation(block: true, numbering: "(1)", $F_T = f \( P_(upright(m o t o r)) \) .$)

De precieze vorm van deze relatie hangt af van onder andere de motor en de propeller en hoeft niet lineair te zijn.

Wanneer het aeropendulum uiteindelijk tot stilstand komt, is de hoekversnelling nul. Het moment van de propeller is dan gelijk aan het moment van de zwaartekracht:

#math.equation(block: true, numbering: "(1)", $l_T F_T = m g l sin theta .$)

Hieruit volgt

#math.equation(block: true, numbering: "(1)", $theta = arcsin (frac(l_T F_T, m g l)) .$)

Een groter motorvermogen leidt in het algemeen tot een grotere stuwkracht en daarmee tot een grotere evenwichtshoek. Tijdens het practicum wordt deze relatie experimenteel onderzocht door het motorvermogen te variëren en de resulterende hoek van het aeropendulum te meten.

#heading(level: 1, numbering: none)[Componenten]

Het aeropendulum bestaat uit verschillende elektronische en mechanische componenten. De Arduino stuurt de motor aan via een H-brug en leest tegelijkertijd de hoek van het pendulum uit met een magnetische hoeksensor. De aansluittabel bij opdracht 0 geeft een overzicht van de gebruikte aansluitingen.

#heading(level: 2, numbering: none)[Arduino Uno R4 Minima]

Een Arduino is een programmeerbaar microcontrollerbord waarmee elektronische componenten kunnen worden aangestuurd en sensoren kunnen worden uitgelezen. In dit practicum wordt een #strong[Arduino Uno R4 Minima] gebruikt.

De Arduino voert continu een programma uit waarin twee taken centraal staan: het aansturen van de elektromotor en het meten van de hoek van het aeropendulum. Hiervoor beschikt de Arduino onder andere over digitale aansluitingen, analoge ingangen en verschillende communicatieprotocollen.

In deze opstelling worden de digitale pinnen D9, D10 en D11 gebruikt voor de aansturing van de motor. De AS5600-hoeksensor communiceert via de pinnen A4 en A5 met de Arduino.

#heading(level: 2, numbering: none)[H-brug]

Een elektromotor kan niet rechtstreeks vanuit een digitale uitgang van de Arduino worden gevoed. De motor vraagt aanzienlijk meer stroom dan een uitgang van de microcontroller kan leveren. De Arduino levert daarom alleen het #emph[stuursignaal]\; het elektrische vermogen voor de motor wordt geleverd door de externe voeding.

Tussen de Arduino en de motor bevindt zich daarom een #strong[L298N H-brug]. Deze schakeling kan de externe voedingsspanning naar de motor schakelen. De naam H-brug komt van de configuratie van de interne schakelaars, die schematisch de vorm van de letter H heeft.

Door verschillende schakelaars te openen en sluiten kan de stroom door de motor in beide richtingen lopen. Daarmee kan ook de draairichting van de motor worden veranderd. Hiervoor gebruikt de L298N de ingangen IN1 en IN2. In onze opstelling worden deze aangestuurd door D10 en D11 van de Arduino.

#heading(level: 2, numbering: none)[Pulse Width Modulation]

Naast de draairichting willen we ook kunnen regelen hoeveel vermogen de motor ontvangt. Hiervoor wordt #strong[Pulse Width Modulation (PWM)] gebruikt.

Bij PWM wordt de voedingsspanning niet continu veranderd. In plaats daarvan wordt de spanning snel aan- en uitgeschakeld. De verhouding tussen de tijd dat het signaal aan staat en de totale periodetijd noemen we de #emph[duty cycle] $D$:

#math.equation(block: true, numbering: "(1)", $D = t_(upright(a a n)) / T .$)

Een duty cycle van $100 %$ betekent dat de motor continu wordt aangestuurd. Bij $50 %$ staat de spanning gedurende de helft van iedere periode aan en bij $0 %$ staat de motor volledig uit.

Voor een ideale PWM-schakeling is de gemiddelde spanning over één periode

#math.equation(block: true, numbering: "(1)", $U_(upright(g e m)) = D thin U_(upright(v o e d i n g)) .$)

De motor reageert door zijn mechanische en elektrische traagheid niet afzonderlijk op iedere snelle puls. Daardoor kan met de duty cycle het gedrag van de motor worden geregeld.

In onze opstelling genereert pin D9 van de Arduino het PWM-signaal. Dit signaal wordt aangesloten op de #strong[ENA]-ingang van de L298N. De Arduino bepaalt dus wanneer de H-brug de motor inschakelt, terwijl het daadwerkelijke motorvermogen uit de externe voeding komt.

#figure(
  [
#box(image("Figuren/PWM.png", width: 50.0%))
  ],
  caption: [Voorbeeld van PWM-signalen met verschillende duty cycles. De amplitude blijft gelijk, maar de verhouding tussen de aan- en uittijd verandert.],
  kind: image,
) #label("aero_pendulum_ol--fig:pwm")

#heading(level: 2, numbering: none)[AS5600-hoeksensor]

De hoek van het aeropendulum wordt gemeten met een #strong[AS5600 magnetische hoeksensor]. Op de draaiende as van het aeropendulum wordt een magneet geplaatst. De sensor meet de richting van het magnetische veld en kan daaruit de hoek van de as bepalen. Omdat er geen mechanisch contact nodig is tussen de sensor en de draaiende as, treedt hierbij vrijwel geen extra mechanische weerstand op.

De AS5600 heeft een resolutie van 12 bit. Eén volledige omwenteling wordt daardoor verdeeld in

#math.equation(block: true, numbering: "(1)", $2^12 = 4096$)

mogelijke waarden. Een ruwe sensorwaarde kan worden omgerekend naar een hoek volgens

#math.equation(block: true, numbering: "(1)", $theta = upright("sensorwaarde") / 4096 thin 360^compose .$)

De sensor wordt digitaal uitgelezen via het #strong[I#super[2]C-protocol]. Hiervoor zijn twee verbindingen nodig: SDA (#emph[Serial Data]) voor het versturen van gegevens en SCL (#emph[Serial Clock]) voor het kloksignaal. In deze opstelling is SDA aangesloten op A4 en SCL op A5 van de Arduino.

De positie van de magneet ten opzichte van de sensor is belangrijk. Wanneer de magneet te ver van de sensor staat of niet goed boven het midden van de sensor is geplaatst, kan de hoekmeting onbetrouwbaar worden. Controleer daarom voor iedere meting of de sensor correct functioneert. Wanneer de arm langzaam met de hand wordt bewogen, moet de gemeten hoek vloeiend veranderen. Een constante waarde, grote sprongen of een foutmelding kan betekenen dat de magneet niet correct ten opzichte van de sensor staat.

#voorbereiding(title: [Voorbereiding])[
+ Installeer de Arduino IDE en de Python-omgeving op je laptop. Controleer of de Arduino Uno R4 Minima wordt herkend en dat de juiste poort kan worden geselecteerd #link("https://www.arduino.cc/en/software/")[*Link naar Arduino IDE*]. 

+ Installeer de bibliotheek `AS5600` in de Arduino IDE. Controleer of de bibliotheek correct is geïnstalleerd door een voorbeeldsketch te openen en te uploaden naar de Arduino.

+ Clone or download the github repository of the practicum guide. Controleer of de bestanden correct zijn gedownload en dat je toegang hebt tot de arduino- en pythonbestanden in de map. #link("+ https://github.com/HvA-TN/Practica/tree/main
")[*Link naar github repository*]

+ Bekijk de geometrie van het aeropendulum. Onder welke voorwaarde geldt $l = l_T$? Leg in woorden uit wat deze aanname fysisch betekent.

+ In de stationaire toestand staat de arm stil en zijn de momenten rond het draaipunt in evenwicht. Laat zien dat dan geldt: #math.equation(block: true, numbering: "(1)", $l_T F_T = m g l sin theta .$)

+ De motor zet niet al het opgenomen elektrische vermogen om in mechanisch vermogen. Neem een rendement van $eta = 0.70$ aan: #math.equation(block: true, numbering: "(1)", $P_(upright(m e c h)) = eta U I .$) Bereken bij een voedingsspanning van $U = 5$ V het mechanisch vermogen voor een aantal verschillende motorstromen.

+ Neem aan dat de stuwkracht van de propeller evenredig is met het mechanisch vermogen: #math.equation(block: true, numbering: "(1)", $F_T = C P_(upright(m e c h)) \,$) waarbij $C$ een constante is die de eigenschappen van de motor en propeller beschrijft. Combineer de bovenstaande vergelijkingen en leid een uitdrukking af voor de stationaire hoek $theta$ als functie van de motorstroom $I$.

+ Kies realistische waarden voor $m$, $l$, $l_T$ en $C$. Licht kort toe waarom je deze waarden hebt gekozen. Maak vervolgens in Desmos een grafiek van $theta$ als functie van $I$.

+ Voorspel op basis van je grafiek wat er gebeurt wanneer de motorstroom wordt verhoogd. Verwacht je dat het eenvoudige model voor alle motorstromen even goed werkt? Leg kort uit.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Experiment]

Werk de opdrachten in onderstaande volgorde uit. Open iedere sketch vanuit zijn eigen gelijknamige map onder `Arduino/OpenLoop`. Selecteer in de Arduino IDE de Arduino Uno R4 Minima en de juiste poort. Installeer de bibliotheek `AS5600` van Rob Tillaart. Alle drie de scripts gebruiken 115200 baud.

#opdracht(title: [Opdracht 0: opbouw van de opstelling en aansluitschema])[
+ Zet de Arduino Uno R4 Minima, AS5600-hoeksensor, L298N H-brug, motor en externe voeding klaar. Bekijk hoe de arm en de magneet bij het draaipunt zijn gemonteerd. Controleer of de arm vrij kan bewegen.

+ Bouw de opstelling op met uitgeschakelde externe voeding en losgekoppelde USB-kabel. Sluit de hoeksensor aan volgens tabel~#ref(label("aero_pendulum_ol--tab:aansluitingen"), supplement: none). Controleer per draad de Arduino-pin, draadkleur en aansluiting op de component. De H-brug gaan we in de volgende opdracht aansluiten.

+ Laat de aansluiting van motor en de externe voeding op de H-brug aansluiting controleren door de practicumbegeleider. Spreek de voedingsspanning en stroomlimiet af en noteer deze in je labjournaal.

+ Laat de complete opstelling controleren voordat je USB aansluit. Houd de motorvoeding uitgeschakeld: in opdracht 1 test je eerst alleen de hoeksensor met `Stap_1_Sensor.ino`.

]

#figure(
  table(
    columns: (1.2fr, 0.8fr, 1fr, 0.8fr),
    align: left + horizon,
    inset: (x: 8pt, y: 5pt),
    stroke: none,
    fill: none,
    table.hline(y: 0, stroke: 0.8pt),
    table.header([*Van Arduino*], [*Draadkleur*], [*Naar component*], [*Aansluiting*]),
    table.hline(y: 1, stroke: 0.4pt),
    [GND (Analog)], [Zwart], [Hoeksensor], [GND],
    [3.3 V], [Rood], [Hoeksensor], [VCC],
    [A4], [Groen], [Hoeksensor], [SDA],
    [A5], [Wit], [Hoeksensor], [SCL],
    table.hline(y: 5, stroke: 0.4pt),

  ),
  caption: [Aansluitingen van de Arduino naar de AS5600-hoeksensor.],
  kind: table,
  supplement: [Tabel],
) #label("aero_pendulum_ol--tab:aansluitingen")

#pagebreak(weak: true)

#opdracht(title: [Opdracht 1: hoeksensor uittesten met stap 1])[
+ Gebruik de in opdracht 0 opgebouwde en gecontroleerde opstelling. Laat de motorvoeding uitgeschakeld en sluit alleen USB aan op de Arduino. Open `Arduino/OpenLoop/Stap_1_Sensor/Stap_1_Sensor.ino`: deze sketch leest uitsluitend de hoeksensor uit en stuurt de motor niet aan.

+ Upload het script en open Serial Monitor of Serial Plotter op 115200 baud. Het script geeft iedere 100 ms een regel zoals `Hoek:90.000` weer.

+ Bekijk de omzetting `sensor.readAngle() * 360.0 / 4096.0` in de code. Leg uit waarom door 4096 wordt gedeeld en bepaal hoeveel graden een sensorstap voorstelt.

+ Beweeg de arm langzaam met de hand. Controleer of de gemeten hoek vloeiend verandert en noteer de sensorhoek bij de verticale ruststand en bij enkele bekende armstanden. Onderzoek in welke richting de sensorhoek toeneemt en waar de overgang tussen 359 en 0 graden ligt.

+ Bewaar je waarnemingen in het labjournaal. Laat een constante waarde, onverwachte sprongen of een onjuiste hoek eerst controleren voordat je de motor aansluit. Deze scripts controleren de sensorstatus niet automatisch.

]


#pagebreak(weak: true)

#opdracht(title: [Opdracht 2: vaste PWM en stationaire hoek])[
+  Sluit de voeding en de H-brug aan volgens het schema @aero_pendulum_ol--tab:aansluitingen2. 

+ Open `Stap_2_PWM_en_sensor/Stap_2_PWM_en_sensor.ino`. Schakel de voeding uit en controleer de in opdracht 0 aangesloten H-brug en motor. Laat de motorvoeding en  de ENA-aansluiting controleren door de begeleider.

+ Zoek `pwm_waarde` en de drie motorpinnen op in de code. Leg uit hoe D9 het PWM-signaal levert en hoe D10 en D11 de draairichting vastleggen. Bereken de duty cycle bij de ingestelde waarde met $D = upright("pwm_waarde") / 255$.

+ Spreek met de begeleider een veilige voedingsspanning en stroomlimiet af. Het codebereik voor de PWM (0-255) is geen vastgesteld veilig werkbereik, dit hangt af van de voedingsspanning. Verder volgt de stroom uit de belasting van de motor en de propeller.  

+ Kies vervolgens een PWM-waarde en upload opnieuw met de motorvoeding uit. Schakel daarna de motorvoeding in. De sketch stuurt de motor direct na uploaden of resetten aan met `pwm_waarde` #footnote[Je kunt de Arduino resetten (bij bijvoorbeeld een storign) door de resetknop op de Arduino één keer in te drukken. Ook het openen van een seriele verbinding kan een reset veroorzaken.]. Er is geen startcommando, automatische meetduur of softwarematige stop in dit script; stop door de motorvoeding uit te schakelen.

+ Bekijk de hoek in Serial Monitor of Serial Plotter. Wacht tot de arm een stationaire positie bereikt, of noteer dat dit niet gebeurt. Noteer de PWM-waarde, duty cycle, stationaire werkhoek, voedingsspanning en motorstroom.

+ Herhaal dit voor meerdere PWM-waarden, noteer de maximale hoek en de bijbehorende motorstroom. 

+ Maak een grafiek van de gemiddelde stationaire werkhoek tegen de PWM-waarde, met foutbalken op basis van de herhalingen. Bepaal de dode zone en onderzoek of de relatie lineair is. Dit script verstuurt alleen `Hoek:`-regels, zonder tijdstempels of CSV-kop.

]

#figure(
  table(
    columns: (1.2fr, 0.8fr, 1fr, 0.8fr),
    align: left + horizon,
    inset: (x: 8pt, y: 5pt),
    stroke: none,
    fill: none,
    table.hline(y: 0, stroke: 0.8pt),
    table.header([*Van Arduino*], [*Draadkleur*], [*Naar component*], [*Aansluiting*]),
    table.hline(y: 1, stroke: 0.4pt),
    [D9 (digitaal, PWM)], [Paars], [H-brug], [ENA],
    [D10 (digitaal)], [Oranje], [H-brug], [IN1],
    [D11 (digitaal)], [Geel], [H-brug], [IN2],
    table.hline(y: 4, stroke: 0.8pt),
  ),
  caption: [Aansluitingen van de Arduino naar de L298N H-brug.],
  kind: table,
  supplement: [Tabel],
) #label("aero_pendulum_ol--tab:aansluitingen2")

#pagebreak(weak: true)

#opdracht(title: [Opdracht 3: aansturen en meten met Python])[
+ Open `Stap_3_Python_aansturing/Stap_3_Python_aansturing.ino` en upload met uitgeschakelde motorvoeding. De motor begint bij deze sketch met PWM 0. Sluit Serial Monitor en Serial Plotter voordat Python dezelfde poort opent.

+ Installeer in je Python-omgeving `pyserial`, `pandas` en `matplotlib`. 

+ Open Practicum2.2/open_loop/script.ipynb en controleer of je de eerste cel kunt runnen.

+ Test de nulhoek van de sensor bij PWM 0. Controleer of de gemeten hoek vloeiend verandert wanneer je de arm langzaam met de hand beweegt. Noteer de beginhoek in het labjournaal.

+ Sla iedere proef op onder een eigen bestandsnaam. De Arduino verstuurt meetregels als `tijd_in_ms,hoek_in_graden`, zonder kopregel. De tijd loopt vanaf het starten van de Arduino. 

+ Herhaal de metingen minimaal drie keer per PWM-instelling. Noteer de PWM-waarde, voedingsspanning, motorstroom, beginhoek en hoekconversie apart. Maak grafieken van de werkhoek tegen de tijd en bepaal per proef de gemiddelde stationaire hoek en standaarddeviatie over een onderbouwd gekozen tijdvenster.

+ Vergelijk de resultaten met de voorspellingen uit de voorbereiding. Bespreek eventuele afwijkingen en mogelijke oorzaken.

+ Maak een fit op basis van de voorbereiding, waarom lukt dat (niet)?

]


#afronding(title: [Afronding])[
+ Laat de meetresultaten controleren door de practicumbegeleider.

+ Voeg alle grafieken toe aan je digitale labjournaal en geef iedere figuur een duidelijk onderschrift.

+ Vul de sectie #strong[Resultaten en Discussie] aan. Beschrijf hierin de relatie tussen de Arduino-uitgang en de stationaire hoek en vergelijk de experimentele resultaten met het theoretische model.

+ Reflecteer op de beperkingen van een open-loop systeem en beschrijf waarom terugkoppeling in veel technische toepassingen gewenst is.

+Breek de opstelling af en ruim de werkplek op. Controleer of alle componenten compleet zijn en berg deze op in de daarvoor bestemde bakken.
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


=== Open-loop-evenwicht

Bij open-loop-aansturing wordt de PWM-waarde $u$ ingesteld zonder terugkoppeling van de gemeten hoek. We beschouwen een constante PWM-waarde $u_0$, waardoor ook het motorkoppel $A u_0$ constant is.

Als het systeem een stabiel evenwicht bereikt, verandert de hoek niet meer in de tijd. In deze stationaire toestand gelden:

#math.equation(block: true, numbering: "(1)",
  $ dot(theta) = 0, quad dot.double(theta) = 0 $
)

De bewegingsvergelijking vereenvoudigt hierdoor tot:

#math.equation(block: true, numbering: "(1)",
  $ m g l sin(theta_0) = A u_0 $
)

Hierin is $theta_0$ de evenwichtshoek die hoort bij de ingestelde PWM-waarde $u_0$.

Door de vergelijking op te lossen naar de evenwichtshoek vinden we:

#math.equation(block: true, numbering: "(1)",
  $ eqbox(
    theta_0 = arcsin((A u_0)/(m g l))
  ) $
)

Deze uitdrukking beschrijft de evenwichtshoek op de tak $-pi/2 <= theta_0 <= pi/2$ ($-90° <= theta_0 <= 90°$). Een dergelijk evenwicht bestaat alleen wanneer:

$ abs(A u_0) <= m g l $

Wanneer het motorkoppel groter wordt dan dit maximale zwaartekrachtsmoment,

#math.equation(block: true, numbering: "(1)",
  $ |A u_0| > m g l $
)

kan de zwaartekracht het motorkoppel niet meer compenseren. Er bestaat dan geen statische evenwichtshoek meer. De arm blijft in de richting van het motorkoppel versnellen zolang de hoeksnelheid voldoende klein is.

#pagebreak(weak: true)


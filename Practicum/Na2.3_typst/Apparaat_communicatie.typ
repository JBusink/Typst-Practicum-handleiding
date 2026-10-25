#import "../../styl.typ": *
#show: stijl.with(titel: "Apparaat communicatie", kop: "Technische Natuurkunde — Na2.3")

#praktikumtitle[Practicum: apparaat communicatie met Python]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Kan communiceren met basis labapparatuur via Python

- Kan uitleggen welke stappen nodig zijn voor communicatie met labapparatuur.

- Is bekend en kan overweg met de PyVisa-package van Python.

- De student kan een overzichtelijke map- en modulestuctuur gebruiken en opzetten voor instrumentcommunicatie, passend bij een groter Python-project.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ We werken deze practicumreeks met elektrische schakelingen. Zorg ervoor dat je deze goed aansluit voordat je verder gaat met experimenteren. Anders kan er kortsluiting ontstaan in de apparatuur. Laat je werk checken vooraf.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Historische ontwikkeling van apparaatuuraansturing]

Het betrouwbaar uitvoeren en registreren van metingen vormt het hart van elk experiment. De manier waarop meetinstrumenten worden aangestuurd, heeft de afgelopen decennia een sterke ontwikkeling doorgemaakt. Aanvankelijk gebeurde dit volledig handmatig: instellingen werden aangepast met draaiknoppen en schakelaars, en resultaten werden afgelezen op analoge meters of oscilloscopen. De eerste automatiseringsstappen kwamen met seriële communicatieprotocollen zoals #strong[RS-232] en later #strong[GPIB] (General Purpose Interface Bus), waarmee instrumenten centraal vanaf een computer konden worden aangestuurd. Programmeertalen als #emph[Fortran], #emph[C] en later #emph[LabVIEW] werden gebruikt voor het verzenden van commando's en het uitlezen van data, meestal via relatief laag-niveau communicatie die gebruikers handmatig moesten programmeren. \
Met de komst van microcontrollers veranderde de interne aansturing van apparaten ingrijpend. Deze compacte chips combineren processor, geheugen en I/O en voeren specifieke taken uit, zoals het regelen van spanningen of uitlezen van sensoren. Veel meetinstrumenten kregen interne microcontrollers, terwijl aan de buitenzijde seriële of GPIB-communicatie gehandhaafd bleef. Tegelijkertijd maakten goedkope ontwikkelplatforms zoals de #strong[Arduino] en #strong[Raspberry-Pi] het mogelijk om zelf eenvoudig meet- en regelsystemen te bouwen, wat vooral in onderwijs en kleinschalig onderzoek veel werd toegepast. \
Tegenwoordig is apparaatuuraansturing grotendeels gestandaardiseerd via de #strong[VISA]-standaard (Virtual Instrument Software Architecture), die zowel klassieke verbindingen (RS-232, GPIB) als moderne interfaces zoals #strong[USB] en #strong[Ethernet] ondersteunt. Hierdoor kan met één softwarelaag een breed scala aan instrumenten worden aangestuurd. Een belangrijke recente ontwikkeling is de opkomst van Python als universeel hulpmiddel. Met bibliotheken als `PyVISA` kunnen instrumenten direct via GPIB, USB of netwerk worden bestuurd. Waar vroeger dure propriëtaire software nodig was, volstaat nu vaak een korte Python-script en een standaardinterface. In deze practicumserie gaan we aan de slag met apparaat-communicatie via Python. De schakeling die wij gaan aansturen betreft een passief RC-filtersysteem.

#heading(level: 1, numbering: none)[Passieve RC-filtersystemen]

Een #strong[passief RC-filter] is een eenvoudig elektrisch netwerk van weerstanden en condensatoren waarmee de frequentierespons van een signaal kan worden aangepast, zonder actieve componenten zoals versterkers. Zulke filters worden veel toegepast om ongewenste frequenties te onderdrukken of juist door te laten, bijvoorbeeld om ruis te verwijderen of een meetsignaal te conditioneren voordat het naar een meetinstrument gaat. In figuur #ref(label("apparaat_communicatie--fig: lowpass_circuit"), supplement: none) staat een voorbeeld elektrische schakeling van een laagdoorlaatfilter.

#figure(
  [
#include "Figuren/Lowpass.typ"
  ],
  caption: [Laagdoorlaatfilter: R in serie, C naar massa; de uitgangsspanning wordt over C gemeten.],
  kind: image,
) #label("apparaat_communicatie--fig: lowpass_circuit")

Het gedrag van een RC-filter kan worden beschreven met behulp van de impedantie van een condensator, #math.equation(block: true, numbering: none, $Z_C \( omega \) = frac(1, i omega C) \,$) waarbij $omega = 2 pi f$ de hoekfrequentie is en $i$ de imaginaire eenheid. Voor een eenvoudig #strong[laagdoorlaatfilter], bestaande uit een weerstand $R$ in serie en een condensator $C$ naar massa, volgt voor de overdrachtsfunctie #math.equation(block: true, numbering: none, $H \( omega \) = V_(upright(u i t)) / V_(upright(i n)) = frac(1, 1 + i omega R C) .$) Bij lage frequenties ($omega lt.double 1 \/ R C$) is $\| H \| approx 1$ en wordt het signaal vrijwel ongehinderd doorgelaten. Bij hoge frequenties ($omega gt.double 1 \/ R C$) neemt de amplitude af als $1 \/ omega$, zodat snelle variaties en ruis worden onderdrukt. De overgangsfrequentie, of #strong[afsnijfrequentie], wordt gegeven door #math.equation(block: true, numbering: none, $f_c = frac(1, 2 pi R C) .$)

Om van de overdrachtsfunctie naar een #strong[Bode-plot] te gaan, splits je $H \( omega \)$ op in een amplitude- en fasegedeelte. De amplitude wordt uitgedrukt in decibel, #math.equation(block: true, numbering: none, $\| H \( omega \) \|_(upright(d B)) = 20 log_10 \| H \( omega \) \| \,$) en de fase als #math.equation(block: true, numbering: none, $phi.alt \( omega \) = arg #h(-1em) (H \( omega \)) .$) Voor het laagdoorlaatfilter hierboven volgt eenvoudig #math.equation(block: true, numbering: none, $\| H \( omega \) \| = 1 / sqrt(1 + \( omega R C \)^2) \, #h(2em) phi.alt \( omega \) = - arctan \( omega R C \) .$) Door deze twee functies uit te zetten tegen de logaritme van de frequentie ontstaat de Bode-plot: een amplitude-grafiek die de verzwakking per frequentie laat zien en een fase-grafiek die aangeeft hoe sterk het signaal wordt vertraagd. Helaas kunnen wij de fase-verschuiving niet meten met een #strong[Digitale Multi Meter (DMM)], hiervoor zouden wij een oscilloscoop moeten gebruiken. Deze grafische weergave maakt het filtergedrag bij lage, overgangs- en hoge frequenties direct zichtbaar. Naast #strong[laagdoorlaatfilters] bestaan er ook #strong[hoogdoorlaatfilters] door de positie van weerstand en condensator om te wisselen. In dat geval worden juist lage frequenties onderdrukt en hoge frequenties doorgelaten. Met combinaties van meerdere RC-netwerken kunnen #strong[banddoorlaat- of bandstopfilters] worden gerealiseerd.

#methode(title: [Laagdoorlaat en hoogdoorlaat onderscheiden])[
Meet de uitgangsspanning steeds tussen het knooppunt van R en C en massa.

- #strong[Laagdoorlaat:] R in serie met de ingang, C naar massa. Meet de uitgang over C.

- #strong[Hoogdoorlaat:] C in serie met de ingang, R naar massa. Meet de uitgang over R.

Voor het hoogdoorlaatfilter geldt #math.equation(block: true, numbering: none, $H_(upright(h o o g)) \( omega \) = frac(i omega R C, 1 + i omega R C) .$) Lage frequenties worden onderdrukt; hoge frequenties worden doorgelaten. Beide filters hebben een afsnijfrequentie $f_c = 1 \/ \( 2 pi R C \)$, waar de amplitudeverhouding $1 \/ sqrt(2)$ is (ongeveer $- 3$ dB). Deze formules veronderstellen een ideale spanningsbron en een uitgang die niet merkbaar wordt belast door het meetinstrument.

]

#v(1fr)

#voorbereiding(title: [Voorbereidingsopdracht 1])[
- Installeer #strong[NI-Max] op jouw laptop #link("https://www.ni.com/en/support/downloads/drivers/download.ni-visa.html#575764")[Link]#footnote[Je zult hiervoor een account moeten aanmaken. Dit is helaas de harde realiteit dat niet alles écht open-source is.].

- Maak een nieuwe virtuele omgeving in Anaconda en installeer hierop de volgende packages: \"pyvisa\", \"pyvisa-py\",\"numpy\", \"matplotlib\", \"ipykernel\" & \"Pyserial?\", gebruik Python versie 3.11.

- Download (of clone) de github repository voor de aansturing van de apparaten via #link("https://github.com/HvA-TN/Communicatie_Meetapparatuur/tree/main")[Link].

- Maak een schematische tekening van een zelfgekozen passief filterysteem.

- Schrijf een meetplan voor doormeten van een jouw filter (bode-plot).

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Practicum]

#opdracht(title: [Opdracht 1(a)])[
In deze eerste opdracht gaan we de het filter bouwen en deze handmatig doormeten. Voordat we gaan automatiseren moeten we immers zeker weten dat onze apparatuur goed aangesloten staat.

+ Bouw op het breadboard jouw gekozen filter en sluit de functiegenerator en digitale multimeter aan. Controleer bij jouw practicumbegeleider of deze goed aangesloten staan.

+ Meet, met de hand, bij enkele verschillende frequenties het in-en uitgangssignaal en bereken de overdrachtsfunctie $\| H \( omega \) \|$ op deze frequenties. Gebruik hiervoor een (RMS) voltage van $V_(r m s) = 2$ volt.

+ Schrijf jouw resultaten op in je digitale labjournaal.

]

#opdracht(title: [Opdracht 1(b)])[
Nu we zeker weten dat het filtersysteem werkt gaan we deze aansturen via Python.

+ Sluit de digitale multimeter en de functiegenerator aan via de USB-B kabel.

+ Open NI-MAX en zoek de bijbehorende apparaat ID'en van de apparatuur.

+ Maak een nieuwe Jupyter Notebook met de naam `rc_filter.ipynb` en plaats deze op de juiste locatie binnen jouw projectstructuur (zie Figuur~#ref(label("apparaat_communicatie--fig:communicatie_boomdiagram"), supplement: none)).#footnote[In professionele software-engineering wordt doorgaans niet met notebooks gewerkt, maar uitsluitend met `.py`-modules. Voor dit practicum maken we een uitzondering, omdat we zowel de meetcode als de gegenereerde data en visualisaties in één bestand willen kunnen bekijken.]

+ Controleer nu met onderstaande code of je kan communiceren met jouw apparatuur. #strong[Let op!] De functiegenerator (fg) en de digitale multimeter (dmm) kunnen omgewisseld zijn.

Met deze code controleer je of je kan communiceren met je meetapparatuur. Daarnaast zorgt deze code ervoor dat de communicatiepoorten geopend zijn. Dit is een belangrijk details, want, na gebruik moeten wij ook de apparatuur weer sluiten.

]

#jupytercode([Test communicatie meetapparatuur])[
```python
import pyvisa
rm = pyvisa.ResourceManager()  

fg = rm.open_resource(rm.list_resources()[0]) 
dmm = rm.open_resource(rm.list_resources()[1]) 

#Controleer of de functiegenerator (fg) en de digitale multimeter (dmm) niet omgewisseld zijn.
print("Instrument gevonden:", fg.query("*IDN?"))
print("Instrument gevonden:", dmm.query("*IDN?"))
```

]

Nu we zeker weten dat we kunnen communiceren met onze labapparatuur, is het belangrijk om de code duidelijk en onderhoudbaar te organiseren. Het doel is om niet telkens handmatig ieder instrument aan te sturen, maar gebruik te maken van herbruikbare functies en modules die dit voor ons afhandelen. \
Een overzichtelijke manier om dit te structureren is met een #emph[boomstructuur], waarbij elke map een duidelijke rol binnen het project heeft. Bovenin bevinden zich de algemene modules en documentatie; dieper in de structuur staan de instrument-drivers, hulpfuncties en mappen voor data-opslag. Deze indeling maakt het eenvoudiger om de code te begrijpen, te testen en later uit te breiden. In figuur~#ref(label("apparaat_communicatie--fig:communicatie_boomdiagram"), supplement: none) is te zien hoe deze onderdelen logisch zijn gegroepeerd. De map `instruments` bevat bijvoorbeeld de drivers voor verschillende meetinstrumenten, terwijl `utils` de ondersteunende functies bundelt die in meerdere modules worden gebruikt. De map `data` is gereserveerd voor ruwe meetdata en gegenereerde plots. Deze indeling maakt het eenvoudiger om onderdelen te vinden, te testen en uit te breiden, en zorgt ervoor dat de communicatiecode voor verschillende instrumenten consistent blijft opgebouwd.

#figure(
  [
#include "Figuren/comm_tree.typ"
  ],
  caption: [Boomdiagram voor apparaatcommunicatie.],
  kind: image,
) #label("apparaat_communicatie--fig:communicatie_boomdiagram")

#pagebreak(weak: true)

#opdracht(title: [Opdracht 1(c)])[
Nu we zeker weten dat we kunnen communiceren met onze labapparatuur via Python, kunnen we de eerste testmetingen gaan uitvoeren.

+ Stel #strong[via Python] een voltage in van 2 Volt (Root Mean Squared) bij de functiegenerator met een frequentie van 100 Hz. Controleer op de display van de functiegenerator of deze correct staat ingesteld. Gebruik hiervoor de onderstaande code. Zie je niets gebeuren? Dan kan het zijn dat jouw de functiegenerator en digitale multimeter omgewisseld zijn!

+ Leg uit wat iedere regel doet en schrijf dit op in je labjournaal.

]

#jupytercode([Functiegenerator aansturen met Python])[
```python
from instruments.hardware import open_instruments
from instruments.rigol_dg1022 import set_fixed_sine

rm, fg, dmm = open_instruments(message = 1)

#Aansturing functigenerator
f = 100 #Hz
vrms_output = 2.0 #Volt
set_fixed_sine(fg, freq=f, vrms=vrms_output)
```

]

#opdracht(title: [Opdracht 1(c)])[
De volgende stap is het doen van een meting via Python. Hiervoor gebruiken wij de digitale multimeter.

+ Meet het ingangsvoltage en het uitgangsvoltage 5 keer. Gebruik hiervoor als inspiratie onderstaande code.

+ Sla de data op in de dictionary `results`.

]

#jupytercode([Digitale multimeter aansturen met Python])[
```python
from instruments.rigol_dm3058e import measure_vrms, measure_vrms_n
from utils.functions import save_as_csv

#Start meting digitale multimeter
vals = measure_vrms_n(dmm,5)

#opslaan in een nette structuur
results = {}
results[f] = {
            "samples": vals,
            "mean": float(vals.mean()),
            "std": float(vals.std(ddof=1)),
            "n": len(vals)
        }
save_as_csv(results, "data/raw/input_voltage.csv")
```

]

#pagebreak(weak: true)

#opdracht(title: [Opdracht 1(c)])[
De laatste stap nu de data weer inladen.

+ Laad de data in. Gebruik hiervoor als inspiratie onderstaande code.

+ Schrijf de gemeten gemiddelde waarde en standaard fout in je labjournaal.

]

#jupytercode([Uitlezen data])[
```python
from utils.functions import load_from_csv
data = load_from_csv("data/raw/input_voltage.csv")

freqs_in  = list(data.keys())
V_mean    = [v["mean"]    for v in data.values()]
V_std     = [v["std"]     for v in data.values()]
samples   = [v["samples"] for v in data.values()]
```

]

#opdracht(title: [Opdracht 1(c)])[
+ Sluit de apparatuur nu weer af met Python. Zie onderstaande code.

]

#jupytercode([Afsluiten meetapparatuur])[
```python
from instruments.hardware import close_instruments
close_instruments(rm, fg, dmm, message=1)
```

]

#pagebreak(weak: true)

#opdracht(title: [Opdracht 1(d)])[
+ Maak een bode-plot van jouw gekozen filtersysteem.

+ Bepaal de afsnijfrequentie aan de hand van jouw #strong[bode-plot] en vergelijk deze met jouw gekozen waarde. Je hoeft hiervan alleen te kijken naar de amplitude en dus niet naar de fase#footnote[Dat kan ook niet in dit geval, daarvoor hebben we een oscilloscoop nodig.].

]

#pagebreak(weak: true)

#afronding(title: [Afronding])[
+ Zet de gevonden figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal. Hierin moet de uiteindelijke waarde van jouw experiment (met onzekerheid) staan en een korte discussie of deze waarde #strong[realistisch] en #strong[betrouwbaar] is.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 1: Drivers & virtuele omgeving]

Voor communicatie tussen Python en laboratoriumapparatuur (zoals oscilloscopen en functiegeneratoren) wordt gebruikgemaakt van de VISA-standaard (#emph[Virtual Instrument Software Architecture]). Deze standaard definieert een uniforme interface voor het aanspreken van meetinstrumenten via verschillende fysieke verbindingen, zoals USB, GPIB en LAN.

#heading(level: 2, numbering: none)[VISA, PyVISA en drivers]

- #strong[VISA-driver (bijv. NI-VISA, Keysight VISA, TekVISA, R&S VISA):] Dit is de onderliggende software die zorgt voor de fysieke communicatie met het instrument. Zie dit als de #emph[postdienst] die weet hoe een bericht (via USB, LAN, GPIB) op de juiste plek komt.

- #strong[PyVISA (Python package):] Dit is een Python-interface naar de VISA-driver. PyVISA stuurt geen data rechtstreeks naar de hardware, maar gebruikt de geïnstalleerde VISA-library (bijv. `visa64.dll`) als tussenlaag.

- #strong[SCPI (Standard Commands for Programmable Instruments):] Dit is de #emph[taal] waarin de instrumenten commando's ontvangen, zoals `MEAS:VOLT?` of `FREQ 1KHZ`. Vrijwel alle moderne meetinstrumenten ondersteunen SCPI.

- #strong[NI-MAX:] NI Measurement & Automation Explorer is een hulpmiddel om apparaten te detecteren en resource strings (zoals `USB0::0x1AB1::...::INSTR`) te achterhalen. PyVISA kan ook zonder NI-MAX werken, mits het juiste adres van het instrument bekend is.

Naast NI-VISA kunnen ook andere VISA-implementaties worden gebruikt (Keysight, Tektronix, Rohde & Schwarz, of Rigol UltraSigma).

#heading(level: 2, numbering: none)[NI-MAX]

#strong[NI Measurement & Automation Explorer (NI-MAX)] is een hulpprogramma van National Instruments waarmee je:

- Apparaten kunt detecteren en configureren die via GPIB, USB, LAN of andere bussen verbonden zijn.

- Resource strings kunt achterhalen die nodig zijn voor communicatie via `PyVISA`.

- Instrumenten kunt testen door eenvoudige SCPI-commando's te sturen.

NI-MAX wordt meestal geïnstalleerd samen met #link("https://www.ni.com/en-us/support/downloads/drivers/download.ni-visa.html")[NI-VISA], de driver die `PyVISA` gebruikt om daadwerkelijk met het instrument te communiceren.

#strong[Tip:] Na installatie kun je in NI-MAX je Rigol oscilloscoop vinden en de juiste USB-resource string kopiëren voor gebruik in Python.

#pagebreak(weak: true)

#heading(level: 2, numbering: none)[Installatie en virtuele omgeving]

Het is aan te raden om te werken in een virtuele Python-omgeving en de benodigde packages via `pip` of `conda-forge` te installeren:

#AnacondaNavigator([Anaconda Prompt: virtuele omgeving en installatie])[
```python
# Maak een nieuwe virtuele omgeving via Anaconda Prompt of Navigator
(base) C:\Users\student> conda create -n Practicum2_3 python=3.11
(base) C:\Users\student> conda activate Practicum2_3

# Installeer PyVISA en optioneel de pure Python backend
(Practicum2_3) C:\Users\student> pip install pyvisa pyvisa-py numpy
               matplotlib scipy ipykernel
```

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 2: Materialen en tips]

#figure(
  [
#box(image("Figuren/NIMAX.png", width: 95.0%))
  ],
  caption: [Startscherm van NI-Max software. Apparaat ID start met \"USB\".],
  kind: image,
) #label("apparaat_communicatie--fig:NIMAX")

#figure(
  [
#table(
  columns: (auto,auto,),
  align: (left,left,),
  table.header(table.cell(x: 0, y: 0)[#strong[Doel]], table.cell(x: 1, y: 0)[#strong[SCPI-commando]]),
  table.cell(x: 0, y: 1)[Selecteer kanaal],
  table.cell(x: 1, y: 1)[#raw("SOUR1"), #raw("SOUR2")],
  table.cell(x: 0, y: 2)[Golfvorm kiezen],
  table.cell(x: 1, y: 2)[#raw("SOUR1:FUNC SIN")],
  table.cell(x: 0, y: 3)[Amplitude in Vpp],
  table.cell(x: 1, y: 3)[#raw("SOUR1:VOLT <value>")],
  table.cell(x: 0, y: 4)[Amplitude in Vrms],
  table.cell(x: 1, y: 4)[#raw("SOUR1:VOLT:UNIT VRMS")],
  table.cell(x: 0, y: 5)[Offset instellen],
  table.cell(x: 1, y: 5)[#raw("SOUR1:VOLT:OFFS <value>")],
  table.cell(x: 0, y: 6)[Frequentie instellen],
  table.cell(x: 1, y: 6)[#raw("SOUR1:FREQ <value>")],
  table.cell(x: 0, y: 7)[Fase instellen],
  table.cell(x: 1, y: 7)[#raw("SOUR1:PHAS <deg>")],
  table.cell(x: 0, y: 8)[Output aan],
  table.cell(x: 1, y: 8)[#raw("OUTP1 ON")],
  table.cell(x: 0, y: 9)[Output uit],
  table.cell(x: 1, y: 9)[#raw("OUTP1 OFF")],
  table.cell(x: 0, y: 10)[Output laden instellen],
  table.cell(x: 1, y: 10)[#raw("OUTP1:LOAD <ohm>")],
  table.cell(x: 0, y: 11)[Bestaande instellingen uitlezen],
  table.cell(x: 1, y: 11)[#raw("SOUR1:VOLT?"), #raw("SOUR1:FREQ?")],
  table.cell(x: 0, y: 12)[Burst-mode aan/uit],
  table.cell(x: 1, y: 12)[#raw("SOUR1:BURS:STAT ON")],
  table.cell(x: 0, y: 13)[Modulatie AM/FM/PWM],
  table.cell(x: 1, y: 13)[#raw("SOUR1:AM:STAT ON"), #raw("SOUR1:FM:STAT ON")],
  table.cell(x: 0, y: 14)[Noise waveform],
  table.cell(x: 1, y: 14)[#raw("SOUR1:FUNC NOIS")],
  table.cell(x: 0, y: 15)[Square-wave duty cycle],
  table.cell(x: 1, y: 15)[#raw("SOUR1:PULS:DCYC <percent>")],
  table.cell(x: 0, y: 16)[Ramp symmetry],
  table.cell(x: 1, y: 16)[#raw("SOUR1:FUNC:RAMP:SYMM <0–100>")],
  table.cell(x: 0, y: 17)[Systeem reset],
  table.cell(x: 1, y: 17)[#raw("*RST")],
  table.cell(x: 0, y: 18)[Identificatie opvragen],
  table.cell(x: 1, y: 18)[#raw("*IDN?")],
)
  ],
  caption: [Veelgebruikte SCPI-commando's voor de Rigol DG1022 / DG1022Z functiegenerator.],
  kind: table,
)

#figure(
  [
#table(
  columns: (auto,auto,),
  align: (left,left,),
  table.header(table.cell(x: 0, y: 0)[#strong[Doel]], table.cell(x: 1, y: 0)[#strong[SCPI-commando]]),
  table.cell(x: 0, y: 1)[Identificatie opvragen],
  table.cell(x: 1, y: 1)[#raw("*IDN?")],
  table.cell(x: 0, y: 2)[Reset instrument],
  table.cell(x: 1, y: 2)[#raw("*RST")],
  table.cell(x: 0, y: 3)[Foutenbuffer leegmaken],
  table.cell(x: 1, y: 3)[#raw("*CLS")],
  table.cell(x: 0, y: 4)[Stop lopende metingen],
  table.cell(x: 1, y: 4)[#raw("ABORt")],
  table.cell(x: 0, y: 5)[AC-spanning meten (Vrms)],
  table.cell(x: 1, y: 5)[#raw("CONF:VOLT:AC")],
  table.cell(x: 0, y: 6)[DC-spanning meten],
  table.cell(x: 1, y: 6)[#raw("CONF:VOLT:DC")],
  table.cell(x: 0, y: 7)[Wisselspanning uitlezen (ad-hoc)],
  table.cell(x: 1, y: 7)[#raw("MEAS:VOLT:AC?")],
  table.cell(x: 0, y: 8)[Gespacificeerde meting uitlezen],
  table.cell(x: 1, y: 8)[#raw("READ?")],
  table.cell(x: 0, y: 9)[Frequentie meten],
  table.cell(x: 1, y: 9)[#raw("CONF:FREQ")],
  table.cell(x: 0, y: 10)[Weerstand meten],
  table.cell(x: 1, y: 10)[#raw("CONF:RES")],
  table.cell(x: 0, y: 11)[Stroom meten (AC/DC)],
  table.cell(x: 1, y: 11)[#raw("CONF:CURR:AC"), #raw("CONF:CURR:DC")],
  table.cell(x: 0, y: 12)[Triggerbron instellen],
  table.cell(x: 1, y: 12)[#raw("TRIG:SOUR IMM")],
  table.cell(x: 0, y: 13)[Aantal metingen per trigger],
  table.cell(x: 1, y: 13)[#raw("TRIG:COUN <n>")],
  table.cell(x: 0, y: 14)[Aantal samples instellen],
  table.cell(x: 1, y: 14)[#raw("SAMP:COUN <n>")],
  table.cell(x: 0, y: 15)[Acquisitie starten],
  table.cell(x: 1, y: 15)[#raw("INIT")],
  table.cell(x: 0, y: 16)[Buffer uitlezen],
  table.cell(x: 1, y: 16)[#raw("FETCh?")],
  table.cell(x: 0, y: 17)[NPLC instellen (integratietijd)],
  table.cell(x: 1, y: 17)[#raw("VOLT:AC:NPLC <x>")],
  table.cell(x: 0, y: 18)[Automatische bereikkeuze uit],
  table.cell(x: 1, y: 18)[#raw("VOLT:AC:RANG:AUTO OFF")],
  table.cell(x: 0, y: 19)[Bereik instellen],
  table.cell(x: 1, y: 19)[#raw("VOLT:AC:RANG <range>")],
  table.cell(x: 0, y: 20)[Auto-zero uit],
  table.cell(x: 1, y: 20)[#raw("ZERO:AUTO OFF")],
  table.cell(x: 0, y: 21)[Detectieband AC],
  table.cell(x: 1, y: 21)[#raw("VOLT:AC:DET:BAND 20") / #raw("100")],
  table.cell(x: 0, y: 22)[Display aan/uit],
  table.cell(x: 1, y: 22)[#raw("DISP:ENAB ON"), #raw("DISP:ENAB OFF")],
  table.cell(x: 0, y: 23)[Status opvragen],
  table.cell(x: 1, y: 23)[#raw("STAT:OPER:COND?")],
  table.cell(x: 0, y: 24)[Fouten opvragen],
  table.cell(x: 1, y: 24)[#raw("SYST:ERR?")],
)
  ],
  caption: [Veelgebruikte SCPI-commando's voor de Rigol DM3058E digitale multimeter.],
  kind: table,
)

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 3: Schematische tekeningen schakelingen]

#figure(
  [
#include "Figuren/Bandpass.typ"
  ],
  caption: [Schema van het banddoorlaatfilter (bandpass).],
  kind: image,
) #label("apparaat_communicatie--fig:bandpass_circuit")

#figure(
  [
#include "Figuren/Highpass.typ"
  ],
  caption: [Hoogdoorlaatfilter: C in serie, R naar massa; de uitgangsspanning wordt over R gemeten.],
  kind: image,
) #label("apparaat_communicatie--fig:highpass_circuit")

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 4: apparaataansturing]

#jupytercode([Voorbeeld: functiegenerator aansturen met Python])[
```python
def set_fixed_sine(gen, freq=100, vrms=5.0, channel=1):
    """
    Stel de functiegenerator in op een vaste sinusgolf.
    Inclusief expliciet aan- en uitzetten van de uitgang.
    """

    chan = f"SOUR{channel}"

    gen.write(f"{chan}:FUNC SIN")           # sinusgolf kiezen
    gen.write(f"{chan}:VOLT:UNIT VRMS")     # amplitude in Vrms
    gen.write(f"{chan}:VOLT {vrms}")        # waarde instellen
    gen.write(f"{chan}:FREQ {freq}")        # frequentie instellen

    gen.write(f"OUTP{channel} ON")          # uitgang inschakelen

    # Optioneel: gegevens teruggeven, maar NIET verplicht:
    # return {"freq": freq, "vrms": vrms, "channel": channel}

# ------------------------------------------------------------
# Voorbeeldgebruik:
# ------------------------------------------------------------
import pyvisa

rm = pyvisa.ResourceManager()
gen = rm.open_resource("USB0::0x1AB1::0x0642::DG1ZAxxxxxxx::INSTR")

set_fixed_sine(gen, freq=100, vrms=5.0, channel=1)

gen.close()
```

]

#import "../../Practica/styl.typ": *
#show: stijl.with(titel: "UV VIS", kop: "Technische Natuurkunde — Na2.2")

#praktikumtitle[Practicum: Molecuulspectrometrie (UV/Vis & Fluorescentie)]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kan metingen uitvoeren met moderne spectrometrie.

- Je kunt een dataset uitlezen via Python.

- Je kan met behulp van spectrometrie materialen karakteriseren.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ Draag altijd een labjas en veiligheidsbril als je werkt met chemische oplossingen.

+ Twijfel je over een handeling of apparaat? Vraag dit altijd aan de practicumbegeleider.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

In dit practicum maak je kennis met #strong[twee] belangrijke spectrometrische technieken die veel worden toegepast binnen de technische natuurkunde, beide experimenten hebben een aparte voorbereiding. UV/Vis-absorptiespectrometrie en fluorescentiespectroscopie worden gebruikt om optische eigenschappen van materialen te onderzoeken, zoals transmissie, absorptie en emissie. Deze technieken vormen de basis voor toepassingen in optische sensoren, materiaalcharacterisatie, en onderzoek naar energie- en lichtconversieprocessen, zoals in zonnecellen of fotonische structuren.

Je werkt in drietallen aan:

- Proef A --- UV/Vis-absorptie van kinine in tonic.

- Proef B --- Fluorescentie van fluoresceïne bij verschillende pH.

#figure(
  [
#box(image("Figuren/Moderne Spectrometer.png", width: 50.0%))
  ],
  caption: [Een moderne spectrometer.],
  kind: image,
)

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Proef A: UV/Vis absorptie van kinine in tonic]

#heading(level: 2, numbering: none)[Theorie]

UV/Vis-spectroscopie meet de absorptie van licht in het ultraviolet- en zichtbaar gebied. Moleculen met geconjugeerde $pi$-systemen (zoals kinine) absorberen bij specifieke golflengten. De Lambert-Beer-wet geeft het verband tussen extinctie (ookwel Absorbance A#footnote[Er zit een subtiel verschil tussen beiden begrippen. In dit practicum gaan wij niet in op het verschil hierin en nemen aan dat deze hetzelfde zijn.]) $E$, concentratie $c$, extinctiecoëfficiënt $epsilon$ en optische weglengte $l$:

#math.equation(block: true, numbering: none, $E = epsilon thin c thin l$)

Door een kalibratielijn te maken met bekende concentraties kinine kan de onbekende concentratie in tonic worden bepaald. Kinine is bovendien fluorescent: onder UV-licht zendt het blauw licht uit. \
Kinine in tonic is verantwoordelijk voor de bittere smaak, zie Fig #ref(label("uv_vis--figuur kinine_structuur"), supplement: none). Het is een organische base die voorkomt als wit kristallijn poeder en slecht oplosbaar is in water. Kinine heeft slechts een kleine geconjugeerde structuur en absorbeert nauwelijks zichtbaar licht, daarom gebruiken we een UV/vis spectrometer die ook in het UV-gebied meet. Volgens de Wet van Beer is de extinctie evenredig met de concentratie, wat het mogelijk maakt om concentraties nauwkeurig te bepalen via een kalibratiereeks.

#figure(
  [
#box(image("Figuren/Kinine_structuur.png", width: 50.0%))
  ],
  caption: [Structuurformule van kinine.],
  kind: image,
) #label("uv_vis--figuur kinine_structuur")

#v(1fr)

#voorbereiding(title: [Voorbereiding Proef A])[
+ Bekijk kennisclips UV/Vis en fluorescentie.

+ Zoek het absorptiespectrum van kinine en voeg toe aan je labjournaal.

+ Waarom gebruiken we kwarts cuvetten i.p.v.~glas bij UV/Vis?

+ Zoek spectrum fluoresceïne en noteer verwachte emissiekleur.

+ Bereid in Python een script voor voor het fitten van een kalibratielijn.

]

#pagebreak(weak: true)

#methode(title: [Methode Proef A])[
- Materialen:

  - UV/Vis spectrometer (Varian of Vernier)

  - Kinineoplossingen: 0, 2, 4, 6, 8 mg/L

  - Tonic + 0,05 M H$""_2$SO$""_4$

  - Kwarts cuvetten, UV-zaklamp

- Verdun tonic 10×: 1 mL tonic + 9 mL 0,05 M H$""_2$SO$""_4$

- Neem spectra van tonic en hoogste kinineconcentratie

- Bepaal optimale golflengte

- Meet kalibratiereeks + tonic bij die golflengte

- Observeer fluorescentie onder UV-lamp

]

#opdracht(title: [Uitvoering Proef A])[
+ Noteer observaties in je digitale labjournaal.

+ Neem spectra van de kalibratiereeks en tonic.

+ Kies analysegolflengte en bereken concentratie kinine.

+ Herhaal meting drie keer en neem de fout mee in je fit.

+ Observeer fluorescentie en noteer kleur en intensiteit.

]

#opdracht(title: [Verwerking Proef K])[
+ Verwerk alle meetdata in Python.

+ Bepaal de gemiddelde achtergrondactiviteit en corrigeer alle monstermetingen.

+ Bepaal de standaarddeviatie per monster.

+ Bepaal het 95%-betrouwbaarheidsinterval voor de activiteit.

+ Maak een ijkgrafiek (activiteit vs.~massapercentage KCl) en kies een passende regressie om de parameters van de ijkcurve te bepalen.

+ Bepaal het massapercentage KCL in het onbekende monster.

]

#afronding(title: [Afronding Proef A])[
+ Laat resultaten controleren door de practicum begeleider.

+ Zet de gevonden figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal. Bespreek conclusies en discussie over de kalibratie, concentratie en de fluorescentie.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Proef B: Fluorescentie van fluoresceïne]

Fluoresceïne is een molecuul dat vernoemd is naar zijn duidelijk fluorescente eigenschappen en wordt veel gebruikt in de oogheelkunde en optometrie om het oog beter te kunnen bestuderen. Het heeft een duidelijke absorptie in het blauwe deel van het spectrum, waardoor de stof rood-oranje is, zie figuur #ref(label("uv_vis--fig:fluoresceine_overview"), supplement: none). Deze kleuring, en vooral de fluorescentie die optreedt, neemt sterk af bij lagere pH, waardoor fluoresceïne ook als pH-indicator gebruikt wordt. De oorzaak is dat de structuur verandert bij verschillende pH's.

#figure(
  [
#grid(columns: (1fr, 1fr), gutter: 5mm, [#subfiguur[
#box(image("Figuren/Fluoriscine.png"))

]], [#subfiguur[
#box(image("Figuren/Fluoriscine_oplossing.png"))

]])
  ],
  caption: [Links: fluoriscine in poedervorm. Rechts: fluoriscine in opgeloste fase met UV-belichting.],
  kind: image,
) #label("uv_vis--fig:fluoresceine_overview")

#heading(level: 2, numbering: none)[Theorie]

Geconjugeerde moleculen bestaan uit moleculen die afwisselend enkele en dubbele koolstofbindingen hebben. Hieronder zie je twee voorbeelden van geconjugeerde moleculen. Scheikundigen laten vaak de waterstofatomen weg waardoor dezelfde moleculen ook als volgt weergegeven kunnen worden:

De absorptie en emissie van moleculen hangt sterk af van hun geconjugeerde lengte (het aantal afwisselende enkele en dubbele koolstofbindingen). In het algemeen geldt dat hoe groter de geconjugeerde lengte is, des te kleiner de energie van het licht dat ze absorberen.

Kenmerkend voor geconjugeerde moleculen is dat hun absorptie (en vaak ook hun emissie) uit meerdere pieken bestaat, zie een voorbeeld links in Fig. #ref(label("uv_vis--figuur Absotpie_emissie"), supplement: none). Deze pieken kunnen verklaard worden door aan te nemen dat de grondtoestand en de aangeslagen toestand van de moleculen in feite bestaan uit twee kwantum harmonische potentialen. Dit betekent dat naast de elektronische energietoestanden er ook vibrationele energietoestanden zijn. Dit heeft als gevolg dat bij de absorptie van licht een elektron naar verschillende vibrationele energietoestanden kan gaan, zie rechts in Fig. #ref(label("uv_vis--figuur Absotpie_emissie"), supplement: none) voor een schematische weergave, waardoor meerdere absorptiepieken ontstaan.

#figure(
  [
#box(image("Figuren/Excitatie.png", width: 75.0%))
  ],
  caption: [Absorptie- en emissieprofielen en energieniveauschema.],
  kind: image,
) #label("uv_vis--figuur Absotpie_emissie")

#v(1fr)

#voorbereiding(title: [Voorbereiding Proef B])[
+ Zoek absorptiespectrum fluoresceïne en voeg toe aan je labjournaal.

+ Bepaal geschikte excitatiewavelengte.

+ Hoe bepaal je vibratie-energie-afstand uit een spectrum?

+ Installeer Vernier Spectral Analysis® software #link("https://www.vernier.com/product/spectral-analysis/?srsltid=AfmBOooT9xG_7jOMBbDJQrb2oRdmSojW7unpmEYAgaHU5XGkrhaL81Lr")[Link].

]

#pagebreak(weak: true)

#methode(title: [Methode Proef B])[
- Maak drie oplossingen:

  - 5 mL fluoresceïne + 5 mL demiwater

  - 5 mL fluoresceïne + 5 mL pH 5 buffer

  - 5 mL fluoresceïne + 5 mL pH 3 buffer

- Meet absorptiespectra

- Meet emissiespectrum bij gekozen excitatiewavelengte

- Kies geschikte instellingen voor de integration time, smoothing 1 en het aantal middelingen (averages).

- Exporteer data

]

#opdracht(title: [Uitvoering Proef B])[
+ Noteer jouw observaties in het labjournaal.

+ Meet absorptie- en emissiespectra (\"Fluoriscentie\") van alle monsters.

+ Vergelijk effecten van pH.

]

#opdracht(title: [Verwerking Proef B])[
+ Laad de data in via Python, gebruik hiervoor onderstaande code.

+ Open je data in een kladblok en zoek op wat de #strong[footer], #strong[header], #strong[decimal] en #strong[separator] zijn. Voor extra informatie lees de API #link("https://pandas.pydata.org/docs/reference/api/pandas.read_csv.html")[Link]

+ print de kolom-namen, gebruik hiervoor de #strong[df.keys()] code.

]

#jupytercode([Importeer data])[
```python
import pandas as pd
df = pd.read_csv('filename', decimal = '...', sep = '...', header = '...', footer = '...')

print(df.keys())
```

]

#opdracht(title: [Verwerking Proef B])[
+ Plot zowel het absorptie- als het emissiespectrum in één figuur (X--YY-plot). Gebruik hierbij één gezamenlijke x-as (golflengte in nm) en twee afzonderlijke y-assen: één voor de absorptie en één voor de fluorescentie-intensiteit. In Appendix 1 staat hier een voorbeeld van.

+ Analyseer pH-effecten op piekpositie en intensiteit.

+ Bepaal vibratieniveauscheidingen.

]

#afronding(title: [Afronding Proef B])[
+ Laat resultaten controleren door de practicum begeleider.

+ Zet de gevonden figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal. Reflecteer op pH-afhankelijkheid en vibratie-spectroscopie.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix: Voorbereidingsformulier practicum Spectrometrie TN]

#heading(level: 2, numbering: none)[Proef A: Bepaling van kinine in tonic]

#heading(level: 3, numbering: none)[Chemicaliën]

- Kinine (50 mg)

- Tonic (50 mL)

- Zwavelzuur 0.05 M

- Zwavelzuur 0.5 M

#heading(level: 3, numbering: none)[Monster: tonic]

+ Ontgas tonic met ultrasoonbad.

+ Verdun 10× met 0.05 M H$""_2$SO$""_4$ voor UV-Vis meting.

#heading(level: 3, numbering: none)[Stockoplossing 100 mg/L]

+ Weeg 100 mg kinine af.

+ Voeg 50 mL 0.5 M H$""_2$SO$""_4$ toe.

+ Oplossen in ultrasoonbad (~1 min).

+ Overbrengen in 1000 mL maatkolf, aanvullen met demiwater.

#heading(level: 3, numbering: none)[IJkreeks UV-Vis]

- Meet bij 250 nm, gebruik kwarts cuvet.

#block[
#table(
  columns: (auto,auto,),
  align: (center,center,),
  table.header(table.cell(x: 0, y: 0)[#strong[Concentratie (mg/L)]], table.cell(x: 1, y: 0)[#strong[Volume stock (mL)]]),
  table.cell(x: 0, y: 1)[0],
  table.cell(x: 1, y: 1)[0],
  table.cell(x: 0, y: 2)[2],
  table.cell(x: 1, y: 2)[5],
  table.cell(x: 0, y: 3)[4],
  table.cell(x: 1, y: 3)[10],
  table.cell(x: 0, y: 4)[6],
  table.cell(x: 1, y: 4)[15],
  table.cell(x: 0, y: 5)[8],
  table.cell(x: 1, y: 5)[20],
)

]
Maak oplossingen in 250 mL maatkolven. Voeg per oplossing 10 mL 0.5 M H$""_2$SO$""_4$ toe en vul aan met demiwater.

#pagebreak(weak: true)

#heading(level: 2, numbering: none)[Proef B: Fluorescentie van fluoresceïne]

#heading(level: 3, numbering: none)[Fluoresceïne-oplossing]

- Voor 250 mL oplossing:

  + 7 mg fluoresceïne-natriumzout

  + + 25 mL 1 M NaOH

  + Aanvullen tot 250 mL

- Concentratie testen indien nodig.

#heading(level: 3, numbering: none)[Buffer pH 7 (250 mL)]

- 3.40 g KH$""_2$PO$""_4$

- 2.19 g Na$""_2$HPO$""_4$

#heading(level: 3, numbering: none)[Buffer pH 3 (250 mL)]

- 0.70 g natriumcitraat dihydraat

- 4.35 g citroenzuur

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 1:]

#jupytercode([Dubbele y-as])[
```python
import matplotlib.pyplot as plt
fig, ax1 = plt.subplots()
ax2 = ax1.twinx()  # tweede y-as (rechts)

ax1.plot(lambda_abs, absorbance, color='blue', label='Absorptie')
ax2.plot(lambda_em, fluorescence, color='red', label='Emissie')

ax1.set_xlabel('Golflengte (nm)')
ax1.set_ylabel('Absorptie (a.u.)', color='blue')
ax2.set_ylabel('Intensiteit (a.u.)', color='red')

fig.tight_layout()
plt.show()
```

]

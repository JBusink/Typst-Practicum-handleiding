#import "../../styl.typ": *
#show: stijl.with(titel: "Digitale Viscositeit", kop: "Technische Natuurkunde — Na2.4")

#praktikumtitle[Practicum: Digitale viscosimeter en niet-Newtoniaanse vloeistoffen]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kan de dynamische viscositeit meten met een digitale viscosimeter.

- Je kan het verschil tussen Newtoniaanse en niet-Newtoniaanse vloeistoffen bepalen.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ De rotor (spindle) en koppeling van de viscosimeter zijn fragiel. Ga hier voorzichtig mee om.

+ Zorg dat de rotor correct gemonteerd is voordat je de meting start.

+ Werk zorgvuldig met vloeistoffen en voorkom morsen.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

In het vorige practicum heb je de viscositeit bepaald met een Ubbelohde viscometer. In dit practicum gebruik je een digitale viscosimeter, zie Fig. #ref(label("digitale_viscositeit--fig: digitale_viscometer"), supplement: none), waarmee de viscositeit direct wordt bepaald via een koppelmeting.

#figure(
  [
#box(image("Figuren/Digitale_viscometer.png", width: 25.0%))
  ],
  caption: [Een digitale viscometer],
  kind: image,
) #label("digitale_viscositeit--fig: digitale_viscometer")

Het doel van dit practicum is tweeledig:

- het vergelijken van de precisie van beide meetmethodes,

- het bepalen van het vloeistofgedrag van een glycerine-oplossing en een zetmeeloplossing.

#v(1fr)

#voorbereiding(title: [Voorbereidingsopdracht])[
#strong[Experiment 1:]

+ Bekijk de video over het gebruik van de digitale viscosimeter #link("https://www.youtube.com/watch?v=FSid8a-MUCw")[Link].

+ Bepaal met behulp van de handleiding de juiste instellingen en rotor.

+ Schrijf een meetstrategie uit in je labjournaal.

+ Neem de data van het vorige practicum over in Python.

#strong[Experiment 2:]

+ Bepaal de waarde van $n$ voor verschillende vloeistoftypes.

+ Voer een dimensie-analyse uit voor $k$.

+ Zoek het verwachte gedrag van een maizena-oplossing.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Theorie]

De digitale viscosimeter die we in dit practicum gebruiken werkt anders dan de Ubbelohde-viscometer. De digitale viscosimeter maakt gebruik van een zogeheten spil (Engels: #emph[spindle]), een opzetstuk waarmee de vloeistof in beweging wordt gebracht. Hierbij wordt het koppel $M$ (Engels: #emph[torque]) gemeten. De viscositeit volgt dan uit: #math.equation(block: true, numbering: n => [1], $eta = M / K$)

Let op: voor Newtoniaanse vloeistoffen wordt de dynamische viscositeit vaak aangeduid met $mu$, terwijl voor niet-Newtoniaanse vloeistoffen $eta$ wordt gebruikt. In dat geval is de viscositeit afhankelijk van de shear-rate $dot(gamma)$ en wordt dit geschreven als $eta \( dot(gamma) \)$.

Hierbij is $eta$ de dynamische viscositeit, $M$ het koppel en $K$ de kalibratieconstante van de viscosimeter. Deze kalibratieconstante is afhankelijk van de geometrie (bijvoorbeeld cilindrisch) en de rotatiesnelheid van de spil.

Voor een cilindrische geometrie kan worden afgeleid dat: #math.equation(block: true, numbering: n => [2], $eta = frac(M, 2 pi (frac(R_i^3 L omega, R_0 - R_i)))$)

Hierbij is $R_i$ de straal van de binnenste cilinder, $R_0$ de straal van de buitenste cilinder (spil), $L$ de dompelhoogte van de spil en $omega$ de hoeksnelheid.

De viscosimeter gebruikt een koppelmeter om het moment $M$ te bepalen, waarna de dynamische viscositeit wordt berekend. \
#figure(
  [
#box(image("Figuren/Viscositeit_regimes.png", width: 35.0%))
  ],
  caption: [schuifspanning als functie van de vervormingssnelheid voor verschillende typen vloeitstoffen.],
  kind: image,
) #label("digitale_viscositeit--fig: viscositeit_regimes")

#strong[Newtoniaanse en niet-Newtoniaanse vloeistoffen]

Een fundamenteel onderscheid in de stromingsleer (reologie) is dat tussen Newtoniaanse en niet-Newtoniaanse vloeistoffen. Dit onderscheid is gebaseerd op het verband tussen de schuifspanning $tau$ en de afschuifsnelheid $dot(gamma)$ (shear-rate) van een vloeistof: #math.equation(block: true, numbering: n => [3], $tau \( dot(gamma) \) = eta \( dot(gamma) \) thin dot(gamma)$)

Newtoniaanse vloeistoffen, zoals water en lucht, worden gekenmerkt door een lineaire relatie tussen deze grootheden, waarbij de viscositeit constant is.

Echter, er zijn ook vloeistoffen die hier niet aan voldoen: de niet-Newtoniaanse vloeistoffen. In dit geval is de viscositeit $eta \( dot(gamma) \)$ niet-lineair afhankelijk van de shear-rate $dot(gamma)$, zie Fig. #ref(label("digitale_viscositeit--fig: viscositeit_regimes"), supplement: none). Er wordt onderscheid gemaakt tussen twee typen gedrag:

- #strong[Shear-thinning]: de viscositeit daalt bij toenemende shear-rate (bijvoorbeeld ketchup, verf, polymeeroplossingen). Deze worden ook wel pseudoplastisch genoemd.

- #strong[Shear-thickening]: de viscositeit stijgt bij toenemende shear-rate (bijvoorbeeld maizena-oplossingen, silicagel-oplossingen). Deze worden ook wel dilatant genoemd.

Dit gedrag kan worden gemodelleerd met een zogenaamd power-law model: #math.equation(block: true, numbering: n => [4], $eta \( dot(gamma) \) = k thin dot(gamma)^(thin n - 1)$)

Hierbij is $eta$ de schijnbare viscositeit, $k$ de consistentie-index (stroperigheidsindex), $dot(gamma)$ de shear-rate en $n$ de gedragscoëfficiënt van de vloeistof. De waarde van $n$ bepaalt het type vloeistof:

- $n = 1$: Newtoniaans gedrag

- $n < 1$: shear-thinning

- $n > 1$: shear-thickening

#heading(level: 1, numbering: none)[Practicum]

#methode(title: [Experiment deel I: Digitale viscosimeter])[
In dit practicum werken we met een digitale viscosimeter van Vevor. Let op: de rotor en de koppeling aan de viscosimeter zijn fragiel en kostbaar. Ga hier dus voorzichtig mee om.

Net als in het vorige practicum meet je de viscositeit van verschillende glycerol-oplossingen. Ditmaal wordt hiervoor echter een digitale viscosimeter gebruikt in plaats van een Ubbelohde-viscometer.

+ Meet de dynamische viscositeit $eta$ van dezelfde vloeistoffen als in het vorige practicum.

+ Maak een schatting van de bijbehorende meetfout. Bepaal daarbij welke foutbron waarschijnlijk de grootste bijdrage levert.

]

#opdracht(title: [Verwerking deel I])[
+ Maak een grafiek van de viscositeit van de water--glycerol oplossingen.

+ Voeg deze grafiek toe aan de grafiek uit het vorige practicum.

+ Komt dit verband overeen met de waarden die je hebt bepaald met de Ubbelohde-viscometer?

+ Welke viscometer heeft jullie voorkeur en waarom?

]

#methode(title: [Experiment deel II: Niet-Newtoniaanse vloeistoffen])[
Wij verwachten dat jullie zelfstandiger worden in het opstellen van een passende meetmethode. De methode hieronder is daarom bewust beknopt gehouden. Breng vooraf in kaart welke stappen nodig zijn.

+ Meet de dynamische viscositeit $eta$ van één van de water--glycerol oplossingen en bepaal het type vloeistof (bepaal $n$).

+ Meet de dynamische viscositeit $eta$ van de zetmeeloplossing en maak een inschatting van de bijbehorende meetfout.

+ Meet de dynamische viscositeit $eta$ van de zetmeeloplossing bij verschillende rotatiesnelheden en maak een inschatting van de bijbehorende meetfout.

]

#opdracht(title: [Verwerking deel II])[
Tijdens het practicum noteer je je observaties in je labjournaal.

+ Maak een grafiek van de dynamische viscositeit $eta$ als functie van de afschuifsnelheid $dot(gamma)$. Gebruik hiervoor: #math.equation(block: true, numbering: "(1)", $dot(gamma) = frac(2 pi C thin upright(R P M), 60)$) Hierbij is $C$ een apparaatconstante, die je gelijk aan 1 mag nemen.

+ Maak een fit met behulp van vergelijking~(4).

+ Bereken de waarde van $n$ met bijbehorende onzekerheid. Onder welk type vloeistof valt de water--glycerol oplossing? En hoe zit dit voor de maizena-oplossing?

]

#afronding(title: [Resultaten en discussie])[
+ Vergelijk de precisie van beide meetmethodes.

+ Bepaal het type vloeistof van de zetmeeloplossing.

+ Bespreek systematische fouten.

+ Verklaar verschillen met de verwachting.

]

#afronding(title: [Afronding])[
+ Werk je labjournaal volledig uit.

+ Laat je werk controleren door de begeleider.

]

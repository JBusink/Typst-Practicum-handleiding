#import "../../Practica/styl.typ": *
#show: stijl.with(titel: "Meetplan", kop: "Natuurkunde 2.1 Practicum — Meetplan")

#page(header: none, footer: none)[
#align(center)[
#v(2cm)
#text(size: 25pt, weight: "bold")[Meetplan]
#v(1.5cm)
#text(size: 17pt)[Hoe stel ik een meetplan op?]
#v(1cm)
#text(size: 17pt)[Een voorbeeld: bepaling van de valversnelling met de slingerproef]
#v(1cm)
#text(size: 12pt)[Opleiding: Technische Natuurkunde, 2e jaar]
#v(1fr)
#figure(image("Figuren/Pendulum.jpg", width: 70%), caption: [De slinger van Foucault, de aarde is niet het centrum van het universum.]) #label("meetplan--fig: Slinger")
#v(1fr)
Datum: #nederlandse-datum(datetime.today())
]
]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Inleiding]

In technisch-natuurkundig onderzoek begint een experiment altijd met een duidelijke focus: wat wil je eigenlijk weten? Dit wordt samengevat in de #strong[onderzoeksvraag]. Een goede onderzoeksvraag is concreet, meetbaar en geeft richting aan het experiment. Voorbeelden zijn: "Wat is de valversnelling zoals gemeten met een slinger?" of "Hoe verandert de weerstand van een halfgeleider met de temperatuur?". De notatie van een onderzoeksvraag wordt in de academische wereld vaak impliciet gedaan, echter, binnen de bedrijfswereld worden dit soort onderzoeksvragen wel vaker expliciet gelaten. Soms wordt er ook nog gekozen om het wel expliciet te benoemen, maar niet als vraag. In dit geval kun je dan eigenlijk eerder spreken van een #emph[onderzoeksdoel]. In het practicum zijn alle bovengenoemde opties goed. Kort samengevat wordt de onderzoeksvraag dus als volgt genoteerd:

- Impliciet (vaak in de academische wereld)

- Expliciet (vaak in het bedrijfsleven waar de nadruk op duidelijkheid ligt.)

- Expliciet, maar niet als vraag geformuleerd, maar als onderzoeksdoel.

Ook in jouw stage en/of afstudeeropdracht mag je dit zelf bepalen. \
Op basis van de onderzoeksvraag formuleer je vervolgens een #strong[verwachting] (of hypothese). Dit is een geïnformeerde voorspelling over het resultaat van het experiment, gebaseerd op theorie of eerder werk. Het kan kwantitatief zijn, bijvoorbeeld een geschatte waarde van een grootheid, of kwalitatief, bijvoorbeeld een trend of richting van verandering. Het doel van de verwachting is dat het experiment toetsbaar wordt: je weet welke resultaten je logisch acht en kunt deze vergelijken met je metingen. \
Ten slotte beschrijf je de #strong[meetstrategie]. Dit omvat hoe je het experiment concreet uitvoert, welke variabelen je meet en controleert, en hoe je de verzamelde data koppelt aan de theorie. Een academische meetstrategie benadrukt systematiek: meerdere herhalingen om spreiding te reduceren, het gebruik van meetonzekerheden, en directe koppeling van metingen aan theoretische relaties. \
Samen vormen deze elementen het #strong[Onderzoeksvoorstel/Meetplan]: de onderzoeksvraag definieert het doel, de verwachting geeft richting vanuit theorie, en de meetstrategie maakt het toetsbaar. Door dit gestructureerd op te schrijven, werk je zoals een echte onderzoeker en leg je een stevig fundament voor je experiment.

#pagebreak(weak: true)

= Onderzoeksvraag en verwachting

== Impliciet

In dit experiment willen we bepalen wat de waarde van de valversnelling $g$ is door gebruik te maken van een slinger van lengte $L$. De centrale vraag is dus: wat is de valversnelling zoals gemeten met een slinger, en hoe verhoudt deze zich tot de bekende waarde van $9 \, 81 thin upright(m \/ s^2)$? \
Op basis van de theorie van de eenvoudige slinger, die geldt voor kleine uitslagen, is de periode $T$ gegeven door $T = 2 pi sqrt(L \/ g)$. Hieruit volgt dat de periode van de slinger toeneemt met de wortel van de lengte. We verwachten daarom dat bij het meten van verschillende lengtes van de slinger de perioden kwadratisch lineair toenemen met de lengte, en dat we hieruit een waarde van $g$ kunnen afleiden die redelijk overeenkomt met de bekende waarde. Deze verwachting is theoretisch onderbouwd door de balans tussen de zwaartekracht en de centripetale kracht van de slinger, waarbij de kleine-hoekenbenadering van $sin \( theta \) approx theta$ wordt gebruikt. \
Om dit te testen, meten we systematisch de periode van de slinger voor meerdere bekende lengtes $L$. Voor iedere lengte worden meerdere metingen uitgevoerd om statistische spreiding en meetfouten te reduceren. Het kwadraat van de gemiddelde periode wordt uitgezet tegen de lengte, waarmee de theoretische relatie $T^2 = frac(4 pi^2, g) L$ direct wordt gecontroleerd. Uit de helling van deze lijn kan $g$ nauwkeurig worden afgeleid, waarbij onzekerheden in lengte en periode worden meegenomen in de foutanalyse. Zo wordt de experimentele waarde van $g$ direct gekoppeld aan de theoretische verwachting.

== Expliciet

#strong[Onderzoeksvraag] \
Wat is de waarde van de valversnelling $g$ zoals gemeten met een slinger van lengte $L$? \
#strong[Verwachting (theoretische onderbouwing)] \
Volgens de theorie van de eenvoudige slinger, die geldt voor kleine uitslagen, is de periode $T$ gegeven door: #math.equation(block: true, numbering: none, $T = 2 pi sqrt(L / g)$) Hieruit volgt dat de periode van de slinger toeneemt met de wortel van de lengte. We verwachten dat bij het meten van verschillende lengtes de perioden lineair toenemen in het kwadraat van de periode, en dat we hieruit een waarde van $g$ kunnen afleiden die redelijk overeenkomt met de bekende waarde van $9 \, 81 thin upright(m \/ s^2)$. Deze verwachting is theoretisch onderbouwd door de balans tussen zwaartekracht en centripetale kracht van de slinger, waarbij de kleine-hoekenbenadering $sin \( theta \) approx theta$ wordt gebruikt. \
#strong[Meetstrategie] \
De periode van de slinger wordt systematisch gemeten voor meerdere bekende lengtes $L$. Voor elke lengte worden meerdere metingen uitgevoerd om de statistische spreiding te verkleinen. Het kwadraat van de gemiddelde periode wordt vervolgens uitgezet tegen de lengte, waarmee de theoretische relatie $T^2 = frac(4 pi^2, g) L$ direct wordt gecontroleerd. Uit de helling van deze lijn kan $g$ worden berekend. Door de onzekerheden in lengte en periode mee te nemen in de analyse, wordt de experimentele waarde van $g$ gekoppeld aan de theoretische verwachting.

#import "../../styl.typ": *
#show: stijl.with(titel: "Zonnecel", kop: "Technische Natuurkunde — Na2.2")

#praktikumtitle[Practicum: efficiëntie en vermogen van zonnecellen]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- De student kan, aan de hand van een zelfstandig opgesteld meetplan, een experiment uitvoeren met een fotovoltaïsche (PV) cel, waarbij de student de opstelling aansluit en de metingen uitvoert.

- De student kan de stroom-voltage karakteristiek (I-V curve) van zonnecellen uitleggen en bepalen.

- De student kan het vermogen en de efficiëntie (FF) van een zonnecel bepalen.

- De student kan zelfstandig een experimentele verdieping opstellen en uitvoeren.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ In dit practicum werkt je elektriciteit, ga zorgvuldig om met de apparatuur en schakel bij twijfel de practicumbegeleider in.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

Zonnecellen vormen een belangrijk toepassingsgebied binnen de technische natuurkunde, waarin halfgeleiderfysica, optica en elektrische netwerkanalyse samenkomen. Een zonnecel, of fotovoltaïsche (PV) cel, zet invallend licht direct om in elektrische energie door middel van het fotovoltaïsche effect. Hierbij komen elektronen vrij wanneer fotonen met voldoende energie het halfgeleidermateriaal raken, meestal silicium. De vrijgekomen ladingsdragers worden vervolgens gescheiden door een intern elektrisch veld, waardoor een meetbare stroom ontstaat.

#figure(
  [
#box(image("Figuren/Zonnecel_foto.png", width: 75.0%))
  ],
  caption: [Een zonnecel module.],
  kind: image,
) #label("zonnecel--fig:zonnecel")

Zonnecellen spelen een steeds belangrijkere rol in de energietransitie, doordat zij zonlicht direct omzetten in elektrische energie zonder CO#sub[2]-uitstoot. Binnen de technische natuurkunde vormt het begrijpen van de werking, het rendement en het systeemgedrag van zonnecellen een essentieel onderdeel van duurzame technologieontwikkeling. De prestatie van een zonnecel hangt af van factoren zoals de bandkloof, de intensiteit van het licht en interne verliezen, en kan experimenteel worden onderzocht door spanning en stroom te meten bij verschillende belastingen.

#voorbereiding(title: [Voorbereidingsopdracht 1])[
+ Bekijk de volgende voorbereidingsfilmpjes (#link("https://www.youtube.com/watch?v=xKxrkht7CpY")[], #link("https://www.youtube.com/watch?v=4BX2mEQf09c&t=162s")[] en #link("https://www.youtube.com/watch?v=IkVLQALtdQw")[].)

+ Maak een meetplan voor bepalen van het vermogen van een zonnecel. #footnote[Zie Brightspace voor een korte uitleg over een meetplan.]. Formuleer het hoofddoel/onderzoeksvraag, geef een theoretische verwachting en maak een meetstrategie.

+ Maak een duidelijke opstelling voor het doormeten van een zonnecel.

+ Bedenk voor jezelf al wat voor verdiepend onderzoek je wilt doen bij de zonnecel.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Theorie]

Een fotovoltaïsche (PV) zonnecel is in essentie een belichte pn-junction. Een pn-junction wordt gemaakt door één stuk halfgeleidermateriaal aan de ene kant p-type te doteren (met acceptoren) en aan de andere kant n-type (met donoren). In het p-gebied is de ladingsdragerdichtheid van gaten hoog, terwijl in het n-gebied de elektronen domineren. Zodra deze twee regio's met elkaar in contact staan, diffunderen elektronen vanuit het n-gebied naar het p-gebied en diffunderen gaten de andere kant op. Hierdoor blijft in het grensvlak een gedepleteerde (#emph[depletion zone]) laag achter: een gebied waar vrijwel geen vrije ladingsdragers meer aanwezig zijn.

Deze depletion zone bevat wel vaste, geïoniseerde donoren (positief) en acceptoren (negatief), waardoor er een intern elektrisch veld ontstaat dat de diffusie stopt. Dit veld vormt de basis van de pn-juntion. In een zonnecel zorgt juist dit veld ervoor dat nieuw gegenereerde elektronen en gaten, door de absorptie van fotonen, uit elkaar worden getrokken en richting de n- en p-zijde bewegen. Wanneer er nu een extern draad tussen de n- en p-zijde wordt gelegd ontstaat er een stroom. Deze fotonen gegeneerde stroom is dus lichtafhankelijke stroom $I_(upright(p h))$.

#figure(
  [
#box(image("Figuren/Zonnecel_schematisch.png", width: 48.0%))
  ],
  caption: [Schematische weergave van een zonnecel.],
  kind: image,
) #label("zonnecel--fig:PV_schematisch")

Wanneer een externe belasting $R$ wordt aangesloten, ontstaan er een spanning $V$ en stroom $I$ waarvan de waarde afhankelijk is van het gekozen belasting $R$. Door $R$ te variëren kun je de stroomsterkte en voltage variëren en krijg je een volledige I-V-curve. Het maximale elektrische vermogen volgt uit #math.equation(block: true, numbering: none, $P = I V \,$) en het punt waarop dit vermogen maximaal is heet het #emph[maximum power point] ($P_(upright(m p p))$). In commerciële PV-systemen wordt dit punt automatisch gevolgd door de omvormer, die tevens de DC-uitgang omzet naar net-geschikte AC.

De interne kwaliteit van een zonnecel wordt gewoonlijk gekarakteriseerd met de #emph[fill factor] (FF): #math.equation(block: true, numbering: "(1)", $F F = frac(P_(upright(m p p)), V_(upright(o c)) I_(upright(s c))) times 100 % .$) Hierbij zijn $V_(upright(o c))$ de openklemspanning en $I_(upright(s c))$ de kortsluitstroom. De FF geeft aan hoe rechthoekig de I-V-curve is. De totale efficiëntie vereist daarnaast kennis van het aangeboden lichtvermogen $P_(upright(l a m p))$: #math.equation(block: true, numbering: "(1)", $eta = P_(upright(m p p)) / P_(upright(l a m p)) times 100 % .$)

#figure(
  [
#include "Figuren/zonnecel_model.typ"
  ],
  caption: [Equivalent elektrisch model van een zonnecel met fotostroombron $I_(upright(p h))$, diode $I_D$, uitgangsstroom $I$ en spanning $V$ over de variabele belasting $R$.],
  kind: image,
) #label("zonnecel--fig:zonnecel_schakeling")

Het elektrisch gedrag van een zonnecel wordt doorgaans beschreven met het één-diode-model (Figuur~#ref(label("zonnecel--fig:zonnecel_schakeling"), supplement: none)). De fotostroom $I_(upright(p h))$ werkt als een spanningsonafhankelijke lichtbron, terwijl de diode het spanningsafhankelijke recombinatiepad vormt. Uit de knooppuntvergelijking volgt: #math.equation(block: true, numbering: "(1)", $I = I_(upright(p h)) - I_D .$) De diodestroom wordt beschreven door de wet van Shockley#footnote[De benaming “de wet van Shockley'' verdient enige nuance. Hoewel William Shockley een belangrijke bijdrage leverde aan de halfgeleiderfysica, is hij later bekend geworden om zijn controversiële en onwetenschappelijke uitspraken over intelligentie en ras. Deze opvattingen staan haaks op de waarden van de academische gemeenschap. Om die reden kiezen sommige instellingen ervoor om de betreffende diodevergelijking neutraal te benoemen, bijvoorbeeld als de ideale diodevergelijking of de pn-overgangsvergelijking.]: #math.equation(block: true, numbering: "(1)", $I_D = I_0 (e^(frac(q V, n k T)) - 1) \,$) zodat de volledige I-V-relatie van de zonnecel wordt: #math.equation(block: true, numbering: "(1)", $I = I_(upright(p h)) - I_0 (e^(frac(q V, n k T)) - 1) .$)

De twee uiterste punten van de I-V-curve volgen direct uit dit model. Bij $V = 0$ is de diodestroom verwaarloosbaar en geldt: #math.equation(block: true, numbering: none, $I_(upright(s c)) = I_(upright(p h)) .$) Bij $I = 0$ verkrijgt men de openklemspanning: #math.equation(block: true, numbering: "(1)", $V_(upright(o c)) = frac(n k T, q) ln #h(-1em) (I_(upright(p h)) / I_0 + 1) .$)

Door de belasting $R$ systematisch te variëren kan de volledige I-V-curve experimenteel worden bepaald en daarmee het maximum power point, de fill factor en de efficiëntie van de zonnecel.

#heading(level: 1, numbering: none)[Practicum]

#opdracht(title: [Opdracht 1(a)])[
+ Plaats de zonnecel in de opstelling en richt de lamp zo dat het oppervlak zo homogeen mogelijk wordt belicht. Noteer hierbij de afstand van de zonnecel tot de lamp.

+ Controleer de lichtverdeling door de intensiteit in het midden, de vier hoeken en langs de randen te meten. Noteer deze in het digitale labjournaal.

]

#opdracht(title: [Opdracht 1(b)])[
+ Voer een volledige I--V-meting uit door de belasting systematisch te variëren.

+ Zorg voor een voldoende dichtheid aan meetpunten (minimaal 15--20) zodat zowel het kortsluitgebied als het openklemgebied goed wordt bemonsterd.

+ Registreer voor elk punt de stroom $I$, weerstand $R$ en spanning $V$.

]

#opdracht(title: [Opdracht 1(c)])[
+ Plot de I-V curve en bepaal aan de hand van een fit de kortsluitstroom en de open klem spanning plus de onzekerheid hierop.

+ Maak vervolgens de P-V-curve en bepaal het maximum power point ($P_(upright(m p p))$, $V_(upright(m p p))$, $I_(upright(m p p))$).

+ Bepaal de interne kwaliteit van de zonnecel.

+ Bepaal de efficiëntie van de zonnecel.

+ Maak een P-R-curve, kan je hier een fit op toepassen? Waarom wel en waarom niet?

]

Als je bovenstaande opdrachten hebt afgerond kun je in de basis een zonnecel doormeten. De volgende stap is om hier een klein onderzoek mee te doen. Misschien heb je tijdens het practicum wel iets bedacht wat je graag wilt onderzoek, dat kan!

#opdracht(title: [Opdracht 1(c)])[
+ Schrijf een kort projectvoorstel (Plan van Aanpak), van maximaal 10 regels, waarin je een voorstel doet voor een klein onderzoekje.

+ Voer het onderzoek uit en noteer jouw resultaten in het labjournaal.

]

#afronding(title: [Afronding])[
+ Zet de gevonden figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal. Hierin moet de uiteindelijke waarde van jouw experiment (met onzekerheid) staan en een korte discussie of deze waarde #strong[realistisch] en #strong[betrouwbaar] is.

]



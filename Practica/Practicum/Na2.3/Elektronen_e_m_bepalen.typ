#import "../../styl.typ": *
#show: stijl.with(titel: "Elektronen e m bepalen", kop: "Technische Natuurkunde — Na2.3")

#praktikumtitle[Practicum: bepaling van de verhouding $e \/ m_e$ met een elektronenbundel]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- De student kan de verhouding $e \/ m_e$ bepalen door de data te lineariseren en hierop een passende fit toe te passen.

- De student kan veilig werken met hoogspanningsbronnen.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ De elektronenbuis is kwetsbaar en duur; ga er altijd zorgvuldig mee om.

+ Sluit voedingen pas aan wanneer alle draaiknoppen op $0 thin upright(V)$ en $0 thin upright(A)$ staan.

+ Laat de opstelling controleren door een practicumbegeleider voordat je spanning toepast.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

De verhouding van de elementaire lading e over de elektron massa $m_e$ is in 1897 voor het eerst gemeten door Joseph John Thomson. Hiermee toonde hij aan dat het elektron een deeltje is met zowel een massa als een lading.

Een elektronenkanon is een van de meest eenvoudige deeltjesversnellers. Door een stroom door een gloeidraad te laten lopen wordt op macroscopisch niveau de gloeidraad warm. Op microscopisch niveau gebeuren er verschillende dingen. Één van deze dingen is dat de elektronen meer energie krijgen. Hierdoor hebben ze een grotere kans om te ontsnappen uit de vaste stof van de gloeidraad, een proces dat bestaat uit thermische emissie. Brengen we dit geheel in een uniform elektrisch veld door een spanningsverschil aan te leggen tussen de gloeidraad en een positieve anode, dan zullen de (bijna) vrije elektronen gaan versnellen. Zo krijg je elektronen die een redelijk uniforme snelheid krijgen in de richting van de anode.

In de opstelling zoals weergegeven in Fig. #ref(label("elektronen_e_m_bepalen--fig: elektronenkanon"), supplement: none) kun je deze elektronenbundel zichtbaar maken doordat er een verdund fluorescerend gas is aangebracht binnen het hermetisch afgesloten glaswerk. Dit maakt de bundel zichtbaar als een groene streep. Vervolgens kun je met zogenaamde Helmholtz spoelen een magnetisch veld aanleggen waardoor je de bundel kan afbuigen, dit volgt uit de wet van Lorentz. Het uiteindelijke doel van dit experiment is om de verhouding $e \/ m_e$ te bepalen.

#v(1fr)

#voorbereiding(title: [Voorbereidingsopdracht])[
+ Bereken vooraf de theoretische verhouding $e \/ m_e$.

+ Stel een hypothese op over de waarde die jij experimenteel zult meten.

+ Schrijf vergelijking (2) om zodat $r$ als functie van $B$ wordt geschreven.

+ Hoe kun je uit de richtingscoëfficiënt van jouw fit $e \/ m_e$ bepalen?

+ Bepaal vooraf hoeveel verschillende waarden van $I_H$ je wilt gebruiken.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Theorie]

Wanneer een elektron zich beweegt in een homogeen magnetisch veld, werkt er een Lorentzkracht op het deeltje. Voor een elektron dat loodrecht door een magnetisch veld beweegt geldt: #math.equation(block: true, numbering: "(1)", $F_L = e v B .$) De kracht staat altijd loodrecht op zowel de bewegingsrichting als het magnetisch veld. Hierdoor verricht het magnetisch veld geen arbeid op het elektron: het verandert niet de snelheid, maar uitsluitend de bewegingsrichting.

Een kracht loodrecht op de snelheid fungeert als centripetale kracht en veroorzaakt een kromlijnige, idealiter cirkelvormige, baan. Uit de krachtenbalans volgt de baanstraal: #math.equation(block: true, numbering: "(1)", $r = frac(m_e v, e B) .$)

#strong[Kinetische energie en versnelspanning] \
Elektronen worden versneld door de anodespanning $U$. De kinetische energie van het elektron wordt dan: #math.equation(block: true, numbering: "(1)", $e U = 1 / 2 m_e v^2 \,$) zodat de snelheid volgt als: #math.equation(block: true, numbering: "(1)", $v = sqrt(frac(2 e U, m_e)) .$)

Door deze snelheid in de straalvergelijking te substitueren en te elimineren ontstaat na herschrijven de klassieke uitdrukking: #math.equation(block: true, numbering: "(1)", $e / m_e = frac(2 U, B^2 r^2) .$) Deze formule vormt de kern van het experiment: met bekende $U$, en gemeten $B$ en $r$, kan de verhouding $e \/ m_e$ worden bepaald zonder directe snelheidsmeting.

#strong[Magnetisch veld van Helmholtz-spoelen] \
Voor twee spoelen met straal $R$, elk met $n$ windingen en spoelstroom $I_H$, is het magnetisch veld in het centrum: #math.equation(block: true, numbering: "(1)", $B = mu_0 H = (4 / 5)^(3 \/ 2) frac(mu_0 n, R) I_H .$) Voor $n = 320$ windingen en $R = 68 thin upright("mm")$ volgt numeriek: #math.equation(block: true, numbering: "(1)", $B approx 4.17 times 10^(- 3) I_H .$) Het veld is dus lineair evenredig met de spoelstroom $I_H$, wat experimentele controle en kalibratie eenvoudig maakt. De baanstraal kan niet rechtstreekt gemeten worden, maar volgt uit twee meetbare grootheden $x$ en $y$ binnen de buis, zie Fig. #ref(label("elektronen_e_m_bepalen--fig:elektronen_geometrie"), supplement: none): #math.equation(block: true, numbering: "(1)", $r = frac(x^2 + y^2, 2 y) .$)

#figure(
  [
#grid(columns: (1fr, 1fr), gutter: 5mm, [#subfiguur[
#box(image("Figuren/Geometrie_elektronenbuis1.png"))

]], [#subfiguur[
#box(image("Figuren/E_m_bepaling_stralen.png"))

]])
  ],
  caption: [Geometrie van de elektronenbuis en de straalbepaling.],
  kind: image,
) #label("elektronen_e_m_bepalen--fig:elektronen_geometrie")

#figure(
  [
#box(image("Figuren/E_m_bepaling_ZA.png", width: 95.0%))
  ],
  caption: [Opstelling elektronenkanon],
  kind: image,
) #label("elektronen_e_m_bepalen--fig: elektronenkanon")

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Practicum]

#methode(title: [Experiment])[
+ Stel de opstelling op zoals weergegeven in Figuur #ref(label("elektronen_e_m_bepalen--fig: opstelling"), supplement: none).

+ Sluit de minpool van de anodespanning aan op de 4 mm aansluiting met min-markering.

+ Plaats de Helmholtz-spoelen in de buishouder.

+ Sluit de verwarmingsspanning aan op de lamp (deze kan je niet varieren en is $U_F = 6.3 - 6.5 upright(V)$) en wacht enkele minuten tot de lamp brand.

+ Kies een anode spanning $U_A$ tussen 1000 en 5000 V en wacht tot de anodestroom stabiliseert.

+ Breng spanning aan op de Helmholtz-spoelen en observeer de afbuiging van de bundel.

+ Meet $x$ en $y$ voor verschillende waarden van spoelstroom $I_H$.

+ Indien tijd: herhaal voor andere waarden van $U_A$.

]

#figure(
  [
#box(image("Figuren/E_m_bepaling_BA.png", width: 95.0%))
  ],
  caption: [Opstelling elektronenkanon],
  kind: image,
) #label("elektronen_e_m_bepalen--fig: opstelling")

#opdracht(title: [Verwerking])[
+ Bepaal $U$, $r$ en $B$ voor alle metingen.

+ Plot $r$ versus $1 \/ B$ inclusief onzekerheden.

+ Pas een lineaire regressie toe en bepaal daaruit $e \/ m_e$.

+ Bepaal de standaardfout van $e \/ m_e$ via de regressie (en foutenpropagatie).

+ Visualiseer jouw meetwaarden in een histogram en observeer wat er gebeurt als je meer data toevoegt.

]

#opdracht(title: [Resultaten en Discussie])[
+ Laat de grafiek zien van $r$ tegen $1 \/ B$.

+ Bespreek of de trend overeenkomt met jouw theoretische verwachting.

+ Onderzoek systematische afwijkingen en hun invloed op de fit.

+ Verklaar eventuele verschillen tussen jouw gemeten waarde en de verwachting.

]

#afronding(title: [Afronding])[
+ Zet de gevonden figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal. Hierin moet de uiteindelijke waarde van jouw experiment (met onzekerheid) staan en een korte discussie of deze waarde #strong[realistisch] en #strong[betrouwbaar] is.

+ Ruim pas op na akkoord van de begeleider.

]

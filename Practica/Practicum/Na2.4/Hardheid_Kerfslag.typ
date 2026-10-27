#import "../../Practica/styl.typ": *
#show: stijl.with(titel: "Hardheid Kerfslag", kop: "Technische Natuurkunde — Na2.4")

#praktikumtitle[Practicum: Hardheid en Kerfslag]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kan een hardheidsmeting uitvoeren

- Je kan verschillende soorten hardheidsmetingen onderscheiden

- Je kan een kerfslagmeting uitvoeren

- Je kan de invloed van temperatuur op materiaalgedrag bepalen en beoordelen

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ We werken op een werktuigbouwkundige afdeling vandaag, volg de instructies van Jan-Willem (en/of collega's) op met betrekking tot veilig werken.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

Tijdens dit practicum maak je kennis met twee belangrijke materiaal-karakterisatietechnieken (zie Fig.~#ref(label("hardheid_kerfslag--fig:setups_hardheid"), supplement: none)): de hardheidsproef en de kerfslagproef. \
De hardheidsproef meet de weerstand van een materiaal tegen lokale plastische vervorming. Deze eigenschap hangt samen met fundamentele materiaaleigenschappen zoals de treksterkte, elasticiteitsgrens en elasticiteitsmodulus. In dit practicum bepaal je de hardheid van gelaste staalmonsters met behulp van micro- en macro-Vickers en Rockwell metingen. Hierbij wordt ook het verschil tussen basismateriaal, las en warmte-beïnvloede zone (HAZ) onderzocht. \
De kerfslagproef richt zich op een andere mechanische eigenschap, namelijk de taaiheid: het vermogen van een materiaal om energie te absorberen vóór breuk. Deze proef geeft inzicht in hoe een materiaal reageert op dynamische belasting (schokken of stoten). Volgens de ISO 148-1 standaard bepaal je de opgenomen energie bij breuk voor verschillende temperaturen, waarmee de overgang van taai naar bros gedrag (ductile-to-brittle transition) zichtbaar wordt.

#figure(
  [
#grid(columns: (1fr, 1fr), gutter: 5mm, [#subfiguur[
#box(image("Figuren/Kerfslag_proef.png", width: 75.0%))

#align(center)[#text(size: 9pt)[Setup voor de kerfslagproef]]
]], [#subfiguur[
#box(image("Figuren/Micro_vickers.png", width: 60.0%))

#align(center)[#text(size: 9pt)[Setup voor de micro Vickers proef]]
]])
  ],
  caption: [Overzicht van de gebruikte meetopstellingen],
  kind: image,
) #label("hardheid_kerfslag--fig:setups_hardheid")

#voorbereiding(title: [Voorbereidingsopdracht])[
+ Bekijk de kennisclips op Brightspace

+ Bekijk de volgende video: #link("https://www.youtube.com/watch?v=7Z90OZ7C2jI")[Link 1]

+ Beantwoord in je labjournaal:

  - Geef de formule voor de micro Vickers hardheid

  - Leid een formule af voor de fout in de hardheid

  - Welke fout (kracht of diameter) domineert?

  - Hoe herken je de heat affected zone (HAZ) in een las?

  - Hoe herken je een geslepen oppervlak bij breuk?

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Theorie]

#strong[Hardheid] \
Van verschillende materialen (onder andere staalsoorten) zijn de fabricage-hardheden bekend. De hardheid is belangrijk indien eigenschappen als slijtvastheid en vervorming van het oppervlak belangrijk zijn voor de gebruikte toepassing van het materiaal. De hardheid van een staal kan veranderen door een bewerkingsproces zoals: lassen en/of een warmtebehandeling.

De macro Vickers hardheidsmeter heeft een grotere indrukking en geeft daardoor een gemiddelde hardheid van het materiaal weer. Met de micro Vickers wordt op specifieke plaatsen zeer kleine indrukkingen gemaakt waardoor het verloop van hardheid in het materiaal duidelijk zichtbaar kan worden gemaakt. Je hebt in de reader gelezen dat de macro Vickers' hardheid te berekenen is met:

#math.equation(block: true, numbering: "(1)", $H = 0 \, 189 F / d^2$)

waarbij $F$ de kracht is en $d$ de gemiddelde indrukdiameter. De fout in de hardheid volgt uit de foutenpropagatie. \
#strong[Lassen] \
Lassen is een verbindingstechniek waarbij twee basismaterialen met elkaar verbonden worden door middel van smelten en het toevoegen van materiaal. Dit betekent dat er plaatselijk energie moet worden toegevoegd om het staal vloeibaar te maken. Een veel gebruikte methode is elektrisch booglassen. Door een hoge stroom wordt het materiaal verhit tot het smelt en hierdoor smelt ook het toevoegmateriaal (elektrode). Dit toevoegmateriaal wordt zo geselecteerd dat het nagenoeg uit hetzelfde materiaal bestaat als de te lassen basismaterialen. Het basismateriaal heeft bepaalde eigenschappen die ontstaan vanuit de microstructuur van het staal. Deze microstructuur kun je zichtbaar maken met behulp van een microscoop (bij vergroting van 200x-1500x). Koolstof komt in het basismateriaal voor in de vorm van vrije koolstofatomen of gebonden als carbide ($F e_3 C$). Door het staal opnieuw te verhitten zal koolstof diffunderen (verplaatsen) naar de plaats van de plek van de hogere temperatuur. Dit betekent praktisch dat er in de overgang tussen het basismateriaal en de las een overgangszone ontstaat waar de koolstof aan het materiaal wordt onttrokken doordat deze diffundeert naar het gedeelte waar de samensmelting van de materialen plaatsvindt. Deze overgangszone noemt men de warmte beïnvloedde zone of Heat Affected Zone (HAZ) (#ref(label("hardheid_kerfslag--Fig. lassen"), supplement: none)). Aangezien koolstof vrijwel de belangrijkste factor is voor het verkrijgen van mechanische eigenschappen van het staal, zal het gelaste materiaal dus plaatselijk verschillen in mechanische eigenschappen. \
#figure(
  [
#box(image("Figuren/Lassen_HAZ.png", width: 50.0%))
  ],
  caption: [Voorbeelde doorsnede las met HAZ.],
  kind: image,
) #label("hardheid_kerfslag--Fig. lassen")

#strong[Kerfslag] \
#figure(
  [
#box(image("Figuren/Kerfslag_preparaat.png", width: 75.0%))
  ],
  caption: [Twee verschillende typen breuken van preparaten in de kerfslagproef.],
  kind: image,
) #label("hardheid_kerfslag--Fig. kerfslagpreparaat")

Een van de eigenschappen om materialen te beschrijven is de taaiheid. De taaiheid komt duidelijk naar voren in de kerfslagwaarde. Hoe hoger de kerfslagwaarde, hoe taaier een materiaal zich zal gedragen, Fig. #ref(label("hardheid_kerfslag--Fig. kerfslagpreparaat"), supplement: none) illustreert twee verschillende typen breuken. Staal zal bij lagere temperaturen een meer brosse breuk vertonen. De overgang van taai naar bros gedrag wordt de ductile-to-brittle transitietemperatuur genoemd en ligt voor staal ergens tussen de −40~°C tot 20~°C. Als bij meerdere temperaturen proeven worden uitgevoerd kan een grafiek worden gemaakt die de overgang van bros naar taai gedrag weergeeft, afhankelijk van de temperatuur. Naast de kerfslagwaarde, kun je van elke proefstaaf de vervorming van de proefstaven en de breukvlakken beoordelen, zoals weergegeven in Figuur #ref(label("hardheid_kerfslag--Fig:kerfslag_beoordeling"), supplement: none) in de norm ISO 148. Het gaat hierbij om de zijdelingse, laterale vervorming (taaiheid) van de vierkante staaf en een beoordeling van het breukvlak op taai en bros uiterlijk. Je kan dit vergelijken met hetzelfde materiaal maar dan bij een andere temperatuur, zo zie je de invloed van temperatuur op de taaiheid van het materiaal. De hoeveelheid vervorming zegt iets over de taaiheid van het materiaal op bijbehorende temperatuur. \
Je meet de afstanden $A_1$, $A_2$, $A_3$ en $A_4$ van de proefstaaf met een meetklok of hoogteschuifmaat.

De laterale vervorming wordt vervolgens bepaald als som van de tegenoverliggende meetpunten:

#math.equation(block: true, numbering: "(1)", $delta_1 = A_1 + A_3 \, #h(2em) delta_2 = A_2 + A_4$)

Hierbij representeren $delta_1$ en $delta_2$ de vervorming in twee loodrechte richtingen van de doorsnede van de proefstaaf.

#figure(
  [
#grid(columns: (1fr, 1fr), gutter: 5mm, [#subfiguur[
#box(image("Figuren/Vervorming.png"))

#align(center)[#text(size: 9pt)[Beoordeling vervorming]]
]], [#subfiguur[
#box(image("Figuren/Percentage_breuk.png"))

#align(center)[#text(size: 9pt)[Beoordeling percentage breuk]]
]])
  ],
  caption: [Beoordeling van vervorming en breukgedrag],
  kind: image,
) #label("hardheid_kerfslag--Fig:kerfslag_beoordeling")

De bepaling van het percentage taaie breuk oppervlak kan door het oppervlak te bekijken en te vergelijken met de afbeelding in Fig. #ref(label("hardheid_kerfslag--Fig:kerfslag_beoordeling"), supplement: none)b. Een brosse breuk geeft een helder/glimmend en kristallijn uiterlijk en een taaie breuk een dof en vezelachtig uiterlijk. Op basis hiervan doet men een uitspraak over de hoeveelheid percentage taaie breuk in de doorsnede van de gebroken kerfslagstaaf.

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Practicum]

#methode(title: [Experiment 1: Hardheidsmetingen])[
Je gaat het verloop van hardheid vanuit het basismateriaal tot in de las bepalen. Hiervoor worden er minimaal 1 hardheidsmeting per gebied (basismateriaal, HAZ en las) uitgevoerd met de micro Vickers en 3-hardheidsmetingen per gebied met macro Vickers. Het aantal bij de micro Vickers is lager in verband met de complexiteit van de meting. Noteer de gemeten waarden en opmerkingen in een registratie tabel in het labjournaal. \
#strong[Let op:] Het is belangrijk dat je een inschatting van de fout in de diameter en de fout in de kracht bepaalt om de fout in de hardheid te kunnen berekenen. \

+ Voer 2--3 hardheidsmetingen uit voor:

  - Basismateriaal (macro Vickers)

  - HAZ (macro Vickers)

  - Las (macro Vickers)

+ Voer 1--2 micro Vickers metingen uit in dezelfde gebieden

+ Meet een referentiesample met macro Vickers én Rockwell (zo kunnen we deze schalen met elkaar vergelijken)

+ Noteer alle meetwaarden plus meetfouten in jouw labjournaal.

]

#methode(title: [Experiment 2: Kerfslagproef])[
Tijdens het practicum worden door elk team proefstaafjes bij verschillende temperaturen onderworpen aan de kerfslagproef. Er wordt een kleine instructie over het gebruik van de valhamer gegeven, waarna de staven zelfstandig worden getest. De proef wordt uitgevoerd met proefstaven volgens, in overeenstemming met ISO 148: L=55 mm, vierkant 10 mm, Kerf 3 mm. Deze norm is iets anders dan in de reader materiaalkunde staat.

+ Voer een nulmeting uit (zonder proefstaaf) om te bepalen hoeveel wrijving aanwezig is.

+ Bepaal de kerfslagwaarde voor het materiaal, compenseer voor de aanwezig wrijving.

+ Herhaal de kerfslagproef voor verschillende temperaturen.

+ Meet laterale vervorming en bepaal percentage taaie breuk.

]

#pagebreak(weak: true)

#opdracht(title: [Verwerking])[
+ Bepaal de fout in de macro Vickers' hardheid op twee verschillende manieren:

  - De algemene formule voor de foutenpropagatie.

  - De standaarddeviatie tussen de verschillen metingen.

+ Plot het verloop van de hardheid van de lasnaad voor de micro en macro Vickers' hardheid.

+ Maak voor de kerfslagproef een registratietabel, waarin je de kgm-waarde, hoeveelheid Joule, de laterale vervorming en taai/bros percentage noteert bij de verschillende temperaturen. Noteer ook de gegevens van de andere teams die de andere materialen hebben bepaald.

]

#opdracht(title: [Resultaten & Discussie])[
#strong[Hardheid]

- Welke van de twee fouten (doormiddel van foutenpropagatie of de standaardeviatie) is hoger? Leg uit waar dit verschil door ontstaat.

- Waar is de hardheid het hoogst in de lasnaad?

- Wat valt je op als je de micro Vickers en de macro Vickers verloop van de lasnaad bekijkt?

- Leg uit of er bij je metingen sprake is van systematische afwijking(en) en hoe dit je metingen beïnvloed.

- Verklaar eventuele verschillen tussen de gemeten resultaten.

#strong[Kerfslag]

- Hoe verandert de taaiheid bij verschillende temperaturen?

- Maak een schatting van de ductile-to-brittle transition temperatuur van het preparaat.

- Leg uit of er bij je metingen sprake is van systematische afwijking(en) en hoe dit je metingen beïnvloed.

- Verklaar eventuele verschillen tussen de gemeten resultaten.

]

#afronding(title: [Afronding])[
+ Zet alle figuren in je labjournaal met duidelijke onderschriften

+ Schrijf een resultaat en discussie sectie met onzekerheden

+ Laat je werk controleren door de begeleider

]

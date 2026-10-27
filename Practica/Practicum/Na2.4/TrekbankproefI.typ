#import "../../Practica/styl.typ": *
#show: stijl.with(titel: "TrekbankproefI", kop: "Technische Natuurkunde — Na2.4")

#praktikumtitle[Practicum: Trekbankproef I]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kan een trekbankproef uitvoeren en nauwkeurig kracht en verlenging meten

- Je kan spannings-rekdiagrammen opstellen en interpreteren

- Je kan een foutanalyse uitvoeren en de onzekerheid in de elasticiteitsmodulus afleiden en bepalen

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ Een trekbank werkt met hoge krachten en opgeslagen elastische energie. Bij breuk kan het monster plotseling losschieten of fragmenteren. Houd daarom altijd voldoende afstand en blijf buiten de directe lijn van het monster.

+ Raak het monster en de klemmen niet aan tijdens de meting. Wacht tot de machine volledig stilstaat voordat je iets aanpast of verwijdert.

+ We werken op een werktuigbouwkundige afdeling: volg altijd de instructies van Jan-Willem (en/of collega's) op met betrekking tot veilig werken.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

In dit practicum onderzoek je hoe een materiaal reageert op mechanische belasting door het gecontroleerd uit te rekken in een trekbankproef (zie Fig. #ref(label("trekbankproefi--fig:trekbank"), supplement: none)). Terwijl de kracht wordt opgevoerd, doorloopt het materiaal verschillende regimes: eerst elastisch gedrag (omkeerbare vervorming), daarna plastische vervorming en uiteindelijk breuk. \
Door de gemeten kracht en verlenging om te rekenen naar spanning en rek, stel je een spanning-rekdiagram op. Hieruit bepaal je fundamentele materiaaleigenschappen zoals de elasticiteitsmodulus, rekgrens en breukspanning. Deze grootheden beschrijven niet alleen hoe sterk een materiaal is, maar vooral hoe het zich gedraagt en faalt onder belasting. \
#figure(
  [
#box(image("Figuren/Trekbank.png", width: 55.0%))
  ],
  caption: [Een trekbank in het makerslab.],
  kind: image,
) #label("trekbankproefi--fig:trekbank")

#voorbereiding(title: [Voorbereidingsopdracht 1])[
+ Bekijk de video over de trekbankproef op Brightspace

+ Lees paragraaf 12.3 en 12.4 uit #emph[OpenStax University Physics I]

+ Neem een USB-stick mee om de data uit de trekbank op te kunnen slaan.

+ Beantwoord in je labjournaal:

  - Leid de foutpropagatieformule voor $E$ af

  - Welke meetfout heeft de grootste invloed op $E$?

  - Hoe bepaal je $E$ met een fit, welke vergelijking heb je hiervoor nodig?

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Theorie]

Tijdens de trekproef worden de kracht $F$ en de verlenging $Delta L$ van het monster gemeten als functie van de aangelegde belasting. Deze grootheden worden omgerekend naar spanning en rek via:

#math.equation(block: true, numbering: "(1)", $sigma = F / A \, #h(2em) epsilon = frac(Delta L, L_0)$)

Hierbij is $A$ de oorspronkelijke doorsnede van het monster en $L_0$ de beginlengte. In het lineair-elastische regime geldt een lineair verband tussen spanning en rek (de wet van Hooke), waarbij de elasticiteitsmodulus $E$ de helling van de spanning-rekcurve bepaalt:

#math.equation(block: true, numbering: "(1)", $E = sigma / epsilon = frac(F L_0, A Delta L)$)

In de praktijk wordt $E$ bepaald uit een lineaire fit van het elastische gedeelte van het spanning-rekdiagram, omdat individuele metingen ruis en meetonzekerheden bevatten. Aangezien alle gemeten grootheden ($F$, $Delta L$, $L_0$ en $A$) onzekerheden bevatten, moet ook de onzekerheid in de elasticiteitsmodulus worden bepaald met behulp van foutenpropagatie. Hierbij is het belangrijk om te beseffen dat $E$ relatief gevoelig is voor kleine fouten in $Delta L$, omdat deze grootheid in de noemer voorkomt. \
De doorsnede $A$ hangt af van de geometrie van het trekmonster. Twee veelgebruikte vormen zijn rechthoekige en cilindrische (ronde) monsters. Rechthoekige monsters zijn eenvoudig te vervaardigen en hebben een constante doorsnede, maar zijn gevoeliger voor spanningsconcentraties aan randen en hoeken. Dit kan leiden tot vroegtijdige lokale plastische vervorming en minder representatieve breukkarakteristieken. \
Cilindrische monsters daarentegen hebben een axiaal-symmetrische geometrie en worden doorgaans nauwkeuriger machinaal bewerkt. Door deze symmetrie is de spanningsverdeling homogener, wat resulteert in betrouwbaardere metingen van materiaaleigenschappen zoals elasticiteitsmodulus, vloeigrens en breukspanning.

#heading(level: 1, numbering: none)[Practicum]

#methode(title: [Experiment: Trekproef])[
Tijdens het practicum wordt met pennen een trekproef uitgevoerd. Er wordt een kleine introductie over de pennen en de trekbank gegeven. Gegevens noteer je in je labjournaal en op een logformulier die je bij het practicum zult krijgen, zie Brightspace. Na de trekproef vullen jullie de resterende gevraagde gegevens in voor de pen die je zelf onderzoekt. \
#strong[Let op:] Het is belangrijk dat je een inschatting van de fout in de oppervlak via de diameter of rechthoek, de lengte, en de fout in de kracht bepaalt om de fout in de elasticiteitsmodulus te kunnen berekenen. \

+ Voer een trekproef uit op het materiaal

+ Meet kracht en verlenging tijdens de proef

+ Noteer alle gegevens in je labjournaal of logformulier

+ Bepaal en noteer schattingen van de meetfouten in:

  - kracht $F$

  - lengte $L_0$

  - verlenging $Delta L$

  - oppervlak $A$

]

#opdracht(title: [Verwerking])[
+ Zet de kracht en uitrekking om naar spanning en rek.

+ Plot de spanning-rekdiagram.

+ Bepaal de elasticiteitsmodulus in het elastische gebied, welke eenheid hoort hierbij?

+ Bepaal de fout in $E$ via de lineaire fit in het elastische gebied.

+ Stel een tabel op met de waarden, zie logformulier:

  - maximale trekspanning

  - elasticiteitsgrens

  - breukspanning

  - breukrek

  - insnoering

]

#opdracht(title: [Resultaten en Discussie])[
- Welk materiaal heb je gemeten? Motiveer je antwoord en houd rekening met de onzekerheid op $E$.

- Zijn er systematische afwijkingen aanwezig? Was de correctie via de lineaire fit nodig?

]

#afronding(title: [Afronding])[
+ Verwerk alle figuren en resultaten in je labjournaal.

+ Schrijf een duidelijke resultaat- en discussiesectie.

+ Laat je werk controleren door de begeleider.

]

#import "../../styl.typ": *
#show: stijl.with(titel: "TrekbankproefII", kop: "Technische Natuurkunde — Na2.4")

#praktikumtitle[Practicum: Trekbankproef II]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kan een trekbankproef uitvoeren en nauwkeurig kracht en verlenging meten

- Je kan spannings-rekdiagrammen opstellen en interpreteren

- Je kunt energie-dissipatie tijdens een compressie experiment.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ Een trekbank werkt met hoge krachten en opgeslagen elastische energie. Bij breuk kan het monster plotseling losschieten of fragmenteren. Houd daarom altijd voldoende afstand en blijf buiten de directe lijn van het monster.

+ Raak het monster en de klemmen niet aan tijdens de meting. Wacht tot de machine volledig stilstaat voordat je iets aanpast of verwijdert.

+ We werken op een werktuigbouwkundige afdeling: volg altijd de instructies van Jan-Willem (en/of collega's) op met betrekking tot veilig werken.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

In dit vervolgexperiment onderzoek je het gedrag van visco-elastische materialen, zoals rubber, onder compressie. In tegenstelling tot metalen, die in eerste benadering elastisch en energiebehoudend gedrag vertonen, combineren deze materialen elastische respons met dissipatieve processen. Dit betekent dat een deel van de mechanische energie tijdens vervorming wordt omgezet in warmte. \
Wanneer een rubberen monster herhaaldelijk wordt samengedrukt en ontlast, volgt het kracht-verplaatsings diagram niet hetzelfde pad bij belasten en ontlasten. Er ontstaat een hysterese-lus, waarvan de oppervlakte direct overeenkomt met het energieverlies per cyclus. Dit energieverlies is een macroscopische manifestatie van interne processen, zoals ketenbewegingen en relaxatie in het polymeernetwerk. \
De mate van dissipatie hangt sterk af van factoren zoals vervormingssnelheid, temperatuur en de interne structuur van het materiaal. Bij hogere belastingssnelheden of grotere vervormingen wordt doorgaans meer energie gedissipeerd. \
Een herkenbaar voorbeeld hiervan is het opwarmen van autobanden tijdens het rijden. Terwijl de band continu vervormt bij contact met het wegdek, doorloopt het rubber steeds cycli van belasting en ontlasting. Door de hysterese in het materiaal gaat hierbij energie verloren, die wordt omgezet in warmte. Dit verklaart waarom banden warm worden tijdens gebruik en waarom materiaalkeuze een belangrijke rol speelt in rolweerstand, slijtage en energie-efficiëntie.

De compressieproef in dit practicum maakt het mogelijk om deze dissipatieve eigenschappen kwantitatief te karakteriseren via de oppervlakte van de hysterese-lus en zo inzicht te krijgen in het visco-elastisch gedrag van het materiaal.

#v(1fr)

#voorbereiding(title: [Voorbereidingsopdracht 1])[
+ Neem een USB-stick mee om de data uit de trekbank op te kunnen slaan.

+ Maak een schets de elasticiteit-modulus tegenover de tijd voor een viscoelastisch materiaal met twee tijdschalen (vergelijking 8, met i = 1,2). Je mag hiervoor zelf de waardes kiezen van $E_i$ en $tau_i$. Zet deze schets in jouw labjournaal. Gebruik hiervoor pen en papier óf Desmos #link("https://www.desmos.com/calculator?lang=nl")[Link].

+ Hoe haal ik uit deze schets de waarde van $E_oo$? Geef dit aan in je schets.

+ Hoe bepaal je $E_oo$ met een fit, welke vergelijking heb je hiervoor nodig?

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Theorie]

Tijdens de compressie meet je de kracht $F$ en de indrukking $Delta L$ van het rubbermonster. Analoog aan de trekproef definieer je de spanning en rek als:

#math.equation(block: true, numbering: "(1)", $sigma = F / A \, #h(2em) epsilon = frac(Delta L, L_0)$)

Hierbij is $A$ het contactoppervlak van het monster en $L_0$ de oorspronkelijke hoogte. Voor een ideaal elastisch materiaal zou de spanning op elk moment alleen afhangen van de actuele rek. In dat geval is er een eenduidig verband tussen $sigma$ en $epsilon$, en lopen belasten en ontlasten over hetzelfde pad.

Bij rubbers en andere visco-elastische materialen is dat anders. Daar hangt de spanning niet alleen af van de huidige vervorming, maar ook van de eerdere belastinggeschiedenis en van de snelheid waarmee het materiaal wordt belast. Een deel van de mechanische energie wordt tijdelijk opgeslagen, terwijl een ander deel wordt gedissipeerd. Daardoor vallen het belastingspad en ontlastingspad niet samen en ontstaat een hysterese-lus in het spanning-rekdiagram.

De energie die per cyclus verloren gaat is gegeven door:

#math.equation(block: true, numbering: "(1)", $E_(upright("verlies")) = integral.cont sigma thin d epsilon$)

Deze integraal is gelijk aan de oppervlakte binnen de hysterese-lus. Hoe groter deze oppervlakte, hoe meer energie per cyclus als warmte in het materiaal wordt omgezet. \
#strong[Maxwell-model] In het Maxwell-model is de totale rek de som van de rek in de veer en de demper:

#math.equation(block: true, numbering: "(1)", $epsilon = epsilon_(upright("veer")) + epsilon_(upright("demper"))$)

Voor de afzonderlijke elementen geldt:

#math.equation(block: true, numbering: "(1)", $sigma = E epsilon_(upright("veer")) \, #h(2em) sigma = eta frac(d epsilon_(upright("demper")), d t)$)

Combineren van deze relaties leidt tot de constitutieve vergelijking van het Maxwell-model:

#math.equation(block: true, numbering: "(1)", $frac(d epsilon, d t) = 1 / E frac(d sigma, d t) + sigma / eta$)

Hierin is $E$ de elastische modulus van de veer en $eta$ de viscositeit van de demper. \
#strong[Spanningsrelaxatie]

Beschouw een experiment waarbij het materiaal plots op een constante rek $epsilon_0$ wordt gebracht en vervolgens wordt vastgehouden:

#math.equation(block: true, numbering: "(1)", $epsilon \( t \) = epsilon_0$)

Bij een visco-elastisch materiaal zal de spanning in de tijd afnemen: het materiaal "ontspant". In het eenvoudige Maxwell-model gebeurt dit exponentieel:

#math.equation(block: true, numbering: "(1)", $sigma \( t \) = sigma_0 e^(- t \/ tau) \, #h(2em) tau = eta / E$)

Dit model beschrijft dat de spanning uiteindelijk volledig verdwijnt. Het materiaal gedraagt zich op lange tijdschalen dus vloeistofachtig.

Voor veel echte materialen, zoals rubbers, is dit echter te simpel. Daar blijft vaak een deel van de spanning behouden door een elastisch netwerk in het materiaal. In dat geval wordt het gedrag beter beschreven door een gegeneraliseerd Maxwell-model, zie Fig. #ref(label("trekbankproefii--fig: maxwel solid"), supplement: none):

#math.equation(block: true, numbering: "(1)", $E \( t \) = frac(sigma \( t \), epsilon_0) = (E_oo + sum_i E_i e^(- t \/ tau_i))$)

Hierin is $E_oo$ de blijvende (lange-tijd) elasticiteitsmodulus, en beschrijven de exponentiële termen relaxatieprocessen op verschillende tijdschalen $tau_i$.

#figure(
  [
#box(image("Figuren/GMWM.png", width: 75.0%))
  ],
  caption: [Generalized Maxwell-model.],
  kind: image,
) #label("trekbankproefii--fig: maxwel solid")

Hieruit volgt dat het materiaal op korte tijdschalen stijver is (hoge effectieve modulus), terwijl op langere tijdschalen relaxatie optreedt en de modulus afneemt naar een constante waarde $E_oo$.

Dit tijdsafhankelijke gedrag ligt ten grondslag aan hysterese en energieverlies bij cyclische belasting.

#heading(level: 2, numbering: none)[Interpretatie voor het experiment]

Bij cyclische belasting, zoals in dit practicum, wordt het materiaal voortdurend belast en ontlast. Door de tijdsafhankelijke respons ontstaat een faseverschil tussen spanning en rek, wat resulteert in een hysterese-lus in het spanning-rekdiagram. De oppervlakte van deze lus komt overeen met het energieverlies per cyclus:

#math.equation(block: true, numbering: "(1)", $E_(upright("verlies")) = integral.cont sigma thin d epsilon$)

Dit energieverlies is een directe maat voor de dissipatieve eigenschappen van het materiaal en hangt samen met de interne relaxatieprocessen zoals beschreven door het Maxwell-model. Het is dus niet een constant energieverlies, maar hangt af van de snelheid van o.a. (de)compressie.

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Practicum]

#methode(title: [Experiment 1: relaxatie rubber])[
+ Bepaal de elasticiteitsmodulus voor Shore A 10 & 30 samples.

+ Analyseer de uniforme rek $epsilon_0$ data. Hoeveel tijdschalen zie je? Welke waarde van $E_oo$ heb je gevonden?

]

#methode(title: [Experiment 2: energieverlies per cyclus])[
+ Plaats een rubber monster tussen de drukplaten.

+ Voer meerder laad-en ontlaadcycli uit.

+ Meet de kracht en verplaatsing continu.

+ Varieer eventueel de maximale compressie en snelheid van de belasting.

]

#opdracht(title: [Verwerking experiment 1])[
+ Maak een spanning-tijd diagram.

+ Bepaal $E_oo$ en onderzoek hoeveel tijdschalen je nodig hebt om deze rubber goed te kunnen modelleren.

+ Noteer het aantal tijdschalen, de tijdschalen $tau_i$ (in de juiste eenheid) en de visco-elasticiteit per tijdsschaal $E_i$.

]

#opdracht(title: [Verwerking experiment 2])[
+ Zet kracht en verplaatsing om naar spanning en rek

+ Plot het spanning-rekdiagram voor meerdere cycli

+ Bepaal de oppervlakte van de hysterese-lus (numeriek)

+ Vergelijk energieverlies tussen verschillende cycli

+ Onderzoek het effect van belastingssnelheid (indien gemeten)

]

#opdracht(title: [Resultaten en Discussie])[
- Hoe groot is het energieverlies per cyclus?

- Hoe verandert de hysterese bij herhaald belasten?

- Wat is het effect van de belastingssnelheid?

- Verklaar het energieverlies fysisch (denk aan interne wrijving / relaxatieprocessen)

]

#afronding(title: [Afronding])[
+ Verwerk alle figuren en resultaten in je labjournaal.

+ Schrijf een duidelijke resultaat- en discussiesectie.

+ Laat je werk controleren door de begeleider.

]

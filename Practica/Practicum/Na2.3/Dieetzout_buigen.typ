#import "../../Practica/styl.typ": *
#show: stijl.with(titel: "Dieetzout buigen", kop: "Technische Natuurkunde — Na2.3")

#praktikumtitle[Practicum: dieetzout & afbuiging $beta^(-)$-straling]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kan straling detecteren met een geigerteller.

- Je kunt een ijklijn opstellen en hieraan rekenen.

- Je kunt de onzekerheid van je fout bepalen met Poisson-verdeelde fouten.

- Je kan de richting van magneetveld bepalen doormiddel van afbuiging van bèta-straling.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ In dit practicum werken wij met ioniserende straling, was na afloop van het practicum goed je handen.

+ In dit practicum werken wij met sterke magneten. Wees voorzichtig met het gebruik van deze magneten, bij botsingen kunnen ze hele scherpe splinters creëren.

+ Wij werken met Geigertellers in dit practicum, raak het zwarte membraan van de Geigerteller met niets aan!

+ Twijfel je over een handeling of apparaat? Vraag dit altijd aan de practicumbegeleider.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

In dit practicum maak je kennis met #strong[twee] (historische) technieken van deeltjesdetectie. Beide experimenten hebben een aparte voorbereiding. In de eerste proef gaan we aan de slag met het bepalen van het Kaliumgehalte in dieetzout. In de tweede proef gaan we de straling manipuleren met een extern magneet veld.

Je werkt in tweetallen aan:

- Proef A --- KCL concentratie bepalen in dieetzout.

- Proef B --- Afbuigen van straling.

#figure(
  [
#box(image("Figuren/Beta-minus_Decay.svg.png", width: 50.0%))
  ],
  caption: [Een schematische weergave van $beta^(-)$-verval],
  kind: image,
)

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Proef A: KCL concentratie bepalen in dieetzout]

Dieetzout is bedoeld voor mensen met een verhoogde bloeddruk die minder natrium (Na) moeten consumeren, maar toch zout willen strooien over hun eten. Het bevat naast het gebruikelijke natriumchloride (NaCl, keukenzout) ook kaliumchloride (KCl). De smaak van KCl is wat bitterder dan van NaCl, maar ook minder sterk, vandaar dat het gebruik van dieetzout niet in alle gevallen gewenster is. Met chemische methoden is KCl lastig te detecteren, omdat het in veel eigenschappen overeenkomt met NaCl. Wat we in dit experiment gaan bekijken is of we met een geigerteller de concentratie van KCl in dieetzout kunnen bepalen. Dit doen we door een ijking uit te voeren middels zelf gemengde monsters met verschillende KCl/NaCl verhoudingen.

#heading(level: 2, numbering: none)[Theorie]

Kalium bevat van nature $0 \, 012 %$ van de isotoop $zws^40 upright(K)$ ("kalium-40"), deze vervalt volgens #math.equation(block: true, numbering: "(1)", $zws^40 upright(K) arrow.r zws^40 upright(C a) + e^(-) + macron(nu)_e .$) Merk op dat dit verval bètastraling ($e^(-)$, $beta$-straling) produceert die we kunnen meten met een geigerteller. Normaal gesproken moet je voor het bepalen van gehaltes van radioactieve stoffen rekening houden met een groot aantal variabelen: de activiteit van de straler, de isotopenverhouding en de efficiëntie van de detector, om maar eens wat te noemen. We kunnen echter al deze variabelen ondervangen door een ijklijn te meten met bekende monsterverhoudingen. Wij gebruiken hiervoor dus de literatuurwaardes voor de activiteit van bepaalde stoffen. Hiermee maak je een aantal aannamen die in de praktijk niet altijd op gaan.

#v(1fr)

#voorbereiding(title: [Voorbereiding Kalium-40 Meting])[
+ Bestudeer hoofdstuk #emph[10.3 Radioactive Decay] uit #emph[University Physics Volume 3 | OpenStax] #link("https://openstax.org/books/university-physics-volume-3/pages/10-3-radioactive-decay")[Link].

+ Zoek literatuurwaarden op voor de concentratie van KCl in verschillende soorten dieetzout en voeg de bron(nen) toe aan je journaal.

+ Welke relatie verwacht je tussen het KCl-gehalte van het monster en de gemeten activiteit met de geigerteller. Wat gebeurt er als je langer meet?

+ Bereken de vervalconstante $lambda$ voor $zws^40 upright(K)$ op basis van de bekende halfwaardetijd $t_(1 \/ 2)$.

+ Zoek de molmassa van KCl op en bereken hoeveel $zws^40 upright(K)$-atomen er aanwezig zijn in $1 \, 0 thin upright(g)$ KCl. #emph[Hint: gebruik $N = n N_(upright(A))$, waarbij $N_(upright(A))$ het getal van Avogadro is.]

+ Bereken de initiële activiteit $A_0 = lambda N_0$ van $1 \, 0 thin upright(g)$ KCl. Schat of dit niveau praktisch meetbaar is met een geigerteller.

+ Formuleer de onderzoeksvraag en jouw verwachting van dit experiment.

]

#pagebreak(weak: true)

#methode(title: [Methode & uitvoering Proef A])[
+ Bouw een meetopstelling om de activiteit systematisch te kunnen bepalen met de geigerteller.

+ Zet de geigerteller aan en kies: counts per minute (CPM), continue meting (vernieuwing elke 5 s). Wacht één minuut totdat het scherm stabiele waarden toont.

+ Meet achtergrondstraling en noteer de activiteit in intervallen van $lt.eq 30$ seconden.

+ Bepaal de fout in het massapercentage van ieder monster.

+ Meet de activiteit van alle ijkmonsters volgens je vaste meetmethode.

+ Meet de activiteit van $10 thin upright(g)$ dieetzout volgens dezelfde meetmethode.

]

#opdracht(title: [Verwerking Proef A])[
+ Verwerk alle meetdata in Python.

+ Bepaal de gemiddelde achtergrondactiviteit en corrigeer alle monstermetingen. Wat gebeurd er met je fout op jouw meting?

+ Bepaal de standaarddeviatie per monster.

+ Maak een ijkgrafiek (activiteit vs.~massapercentage KCl) en kies een passende fit om de parameters van de ijkcurve te bepalen.

+ Bepaal de activiteit van keukenzout met een 95%-betrouwbaarheidsinterval.

]

#opdracht(title: [Resultaten en Discussie Proef A])[
+ Toon grafieken van activiteit als functie van meettijd.

+ Bespreek of langere meetduur had geleid tot kleinere onzekerheden.

+ Toon de ijkgrafiek en bespreek de fitkwaliteit.

+ Onderzoek of er systematische afwijkingen zichtbaar zijn en hoe deze de regressie beïnvloeden.

+ Verklaar eventuele verschillen tussen jouw metingen en jouw verwachting. Komt jouw verwachting overeen?

]

#afronding(title: [Afronding Proef A])[
+ Laat resultaten controleren door de practicum begeleider.

+ Zet de gevonden figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal. Bespreek conclusies en discussie over de kalibratie, concentratie en de fluorescentie.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Proef B: Afbuigen van $beta^(-)$-straling]

Radioactiviteit werd aan het einde van de 19e eeuw ontdekt door Henri Becquerel, die spontaan straling uit uraniumverbindingen observeerde. Kort daarna karakteriseerden Pierre en Marie Curie de straling verder en introduceerden zij de termen $alpha$- en $beta$-straling. Ernest Rutherford liet zien dat $beta$-straling sterk wordt afgebogen in elektrische en magnetische velden, terwijl $alpha$-straling vrijwel onveranderlijk rechtdoor gaat. De richting en mate van de afbuiging maakten duidelijk dat $beta$-deeltjes licht en negatief geladen moeten zijn. J.J.~Thomson kon dit bevestigen door de lading-massa-verhouding te meten en identificeerde $beta$-straling als elektronen. Daarmee werd duidelijk dat radioactief verval een proces is waarin atoomkernen elektronen kunnen uitzenden (zogenoemd $beta^(-)$-verval). De studie van de afbuiging van $beta$-straling speelde een centrale rol bij het begrijpen van de aard van ioniserende straling en de eerste modellen van radioactieve kernen.

#heading(level: 2, numbering: none)[Theorie]

Radioactieve bèta-min ($beta^(-)$) straling ontstaat wanneer de instabiele isotoop #super[40]K in natuurlijk kalium vervalt. Slechts 0,012 % van al het kalium bestaat uit #super[40]K, maar dit is voldoende om een meetbare flux van elektronen te produceren. Het verval verloopt via #math.equation(block: true, numbering: "(1)", $zws^40 upright(K) #h(0em) arrow.r #h(0em) zws^40 upright(C a) + e^(-) + macron(nu)_e .$) Het uitgezonden $beta^(-)$-deeltje is een elektron met kinetische energie in de orde van enkele honderd keV. Omdat het elektron negatief geladen is, ondervindt het in een magnetisch veld een Lorentzkracht. Voor een elektron met snelheid $upright(bold(v))$ in een magnetisch veld $upright(bold(B))$ geldt #math.equation(block: true, numbering: "(1)", $upright(bold(F))_(upright(L)) = - e thin upright(bold(v)) times upright(bold(B)) \,$) waarbij het minteken de negatieve lading van het elektron aangeeft. De richting van de afbuiging is altijd loodrecht op zowel de bewegingsrichting als het magneetveld.

#figure(
  [
#include "Figuren/Magneetveld_tikz.typ"
  ],
  caption: [Lorentz-kracht op een bewegende negatieve lading met een magneet veld.],
  kind: image,
) #label("dieetzout_buigen--fig:dieetzout_opstelling")

Dit is een gevolg van de Lorentzkracht $arrow(F) = q thin arrow(v) times arrow(B)$: het vectorproduct garandeert dat er geen component van de kracht in de bewegingsrichting zit, zodat het deeltje niet versnelt of vertraagt, maar alleen van richting verandert. Hierdoor levert het magnetisch veld precies de centripetale kracht die nodig is voor een kromlijnige baan. Kwantitatief volgt voor de baanstraal uit

#math.equation(block: true, numbering: "(1)", $r = frac(m_e v_e, \| q \| B) \,$) waarbij $m_e$ en $v_e$ de massa en snelheid zijn van het elektron, $q$ is de lading van het elektron en $B$ is de sterkte van het magnetische veld. Dit resulteert in een cirkel- of spiraalvormig traject wanneer het veld homogeen genoeg is. Deze afbuiging vormt de basis van veel meet- en versnellertechnieken in de natuurkunde: in cyclotrons, synchrotrons en storage rings worden geladen deeltjes gecontroleerd geleid door zorgvuldig ingestelde magnetische veldconfiguraties.

In dit practicum onderzoek je dit verschijnsel op kleine schaal door een bron van $beta^(-)$-straling te combineren met ringmagneten en een Geiger--Müller detector. Door het stapelen en oriënteren van de magneten varieert de lokale veldsterkte en veldrichting. Hierdoor verandert de mate waarin de elektronenbundel afbuigt voordat deze de detector bereikt. In dit practicum ga je de oriëntatie van het magneetveld bepalen en bepaal je de optimale sterkte van het magneetveld voor jouw detector.

#figure(
  [
#box(image("Figuren/Opstelling_afbuigin.png", width: 70.0%))
  ],
  caption: [Voorbeeldopstelling voor detectie van $beta^(-)$-straling via een Geiger-Müller teller.],
  kind: image,
) #label("dieetzout_buigen--fig: afbuiging")

#v(1fr)

#voorbereiding(title: [Voorbereiding Proef B])[
+ Bereken de snelheid van het elektron als de energie enkele honderden KeV bedraagt.

+ Zoek op welke sterkte een typisch Neodynium magneet heeft.

+ Bereken de Lorentzkracht op het elektron vlak boven het oppervlakte van het magneet.

+ Wat is het gevolg van de Lorentzkracht op de bewegingsrichting van het elektron?

+ Geef een inschatting geven van de straal van de baan die het elektron aflegt hiermee.

]

#pagebreak(weak: true)

#methode(title: [Methode & Uitvoering Proef B])[
+ Zet de geigerteller aan en kies de #emph[Real-Time] meetmodus (datavernieuwing elke 5 s). Wacht 1--2 minuten tot stabiele waarden zichtbaar zijn.

+ Meet de achtergrondstraling en noteer de activiteit. Herhaal deze in tussenpozen van 1 minuut.

+ Maak de meetopstelling voor een nulmeting (meting zonder magneetveld) en meet de activiteit. Herhaal deze in tussenpozen van 1 minuut.

+ Bouw de opstelling weergegeven in Fig. #ref(label("dieetzout_buigen--fig: afbuiging"), supplement: none) 2 met 6 magneten (3 links en 3 rechts), waarbij het magnetisch veld aan beide zijden dezelfde richting heeft. Meet de activiteit.

+ Draai vervolgens de richting van het magnetisch veld om en meet opnieuw de activiteit.

+ Bepaal de richting van het magnetisch veld met behulp van de gemeten verschillen.

+ Bepaal experimenteel de optimale magneetveldsterkte, varieer hierbij het aantal magneten en noteer de activiteit. Wissel qua opstelling en ga niet zelf de magneten aanpassen!

]

#opdracht(title: [Verwerking Proef B])[
+ Verwerk alle meetgegevens in Python.

+ Bepaal de gemiddelde achtergrondactiviteit en de fout hierop.

+ Bepaal de gemiddelde activiteit van de nulmeting en de fout hierop.

+ Corrigeer de gemeten activiteiten met magneten voor de nulmeting.

+ Bepaal de standaarddeviatie van de gecorrigeerde activiteit.

+ Maak een figuur waarin de activiteit wordt uitgezet als functie van de richting van het magnetisch veld.

+ Maak een grafiek van de activiteit als functie van het aantal ringmagneten en kies een passende regressie om het optimum te bepalen.

]

#opdracht(title: [Resultaten en Discussie Proef B])[
+ Toon grafieken van de activiteit uitgezet tegen het aantal magneten.

+ Toon grafieken van de activiteit uitgezet tegen de richting.

+ Hoe zeker weet je welke kant het magneetveld op staat?

+ Wanneer is jouw gemeten activiteit maximaal, hoeveel magneten heb je hiervoor nodig?

]

#afronding(title: [Afronding Proef B])[
+ Laat resultaten controleren door de practicum begeleider.

+ Zet de gevonden figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix: Voorbereidingsformulier practicum proef A]

#strong[Materialen]

- Dieetzout

- Keukenzout (NaCl)

- Kaliumchloride (KCl)

- Weegschaal

- Afweegpapiertjes

- Vijzel

- Geigerteller (zie Safecast-documentatie en practicumhandleiding)

- 6 samples (0% - 20 % $dots.h$ - 100%) + onbekende concentratie. Studenten wegen de massa af. Practicumbegeleider zet potten klaar.

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix: Voorbereidingsformulier practicum proef B]

#strong[Materialen]

- Kaliumchloride (KCl)

- 8 ringmagneten

- 2 statieven

- 2 statiefklemmen

- 2 universele klemmen

- U-paalhouder

- Geigerteller (zie Safecast-documentatie en practicumhandleiding)

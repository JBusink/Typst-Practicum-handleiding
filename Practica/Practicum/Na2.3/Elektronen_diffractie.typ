#import "../../styl.typ": *
#show: stijl.with(titel: "Elektronen diffractie", kop: "Technische Natuurkunde — Na2.3")

#praktikumtitle[Practicum: Electronenbundel -- Elektronendiffractie op grafiet]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- De student kan diffractieringen meten en de bijbehorende golflengte van elektronen bepalen.

- De student kan de Bragg-vergelijking toepassen om uit diffractie op microkristallijne grafiet de roosterafstand te bepalen.

- De student kan de de Broglie-relatie experimenteel bevestigen.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ De elektronenbuis is dunwandig, sterk gevacueerd en kan imploderen. Ga uiterst voorzichtig om met de glasbuis. :contentReference\[oaicite:1\]index=1

+ Raak het glas niet aan met gereedschap; voorkom mechanische stress.

+ Laat de buis afkoelen voordat je demonteert; de buis kan warm worden tijdens gebruik. :contentReference\[oaicite:2\]index=2

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

Elektronen werden in de klassieke fysica lange tijd beschouwd als puntdeeltjes zonder golfkarakter. Aan het einde van de 19e eeuw werd echter steeds duidelijker dat licht een dubbel karakter heeft: het gedraagt zich zowel als golf (Young, Fresnel) als deeltje (Einstein, foto-elektrisch effect). In 1924 stelde Louis de Broglie een revolutionair idee voor: niet alleen licht, maar alle materiedeeltjes (waaronder elektronen) hebben een golflengte. Deze golflengte hangt af van het impuls van het deeltje en wordt beschreven door de de Broglie-relatie:

#math.equation(block: true, numbering: "(1)", $lambda = h / p \,$)

waarbij $h$ de constante van Planck is en $p$ het impuls van het elektron. Het bijzondere aan elektronen is dat hun golflengte experimenteel zichtbaar kan worden gemaakt. Dit idee was zó revolutionair, dat het de basis vormde van het atoommodel van Bohr. Het werd kort daarna werd dit bevestigd in experimenten van Davisson en Germer (1927), die diffractiepatronen van elektronen op nikkel observeerden, vergelijkbaar met röntgendiffractie. Dit was het eerste directe bewijs dat elektronen zich als materiegolven gedragen en markeerde een fundamentele stap in de ontwikkeling van de kwantummechanica.

In dit experiment gaan jullie aan de slag met elektronendiffractie. Het is historisch gezien een van de meest elegante experimenten: het visualiseert in één oogopslag dat een fundamenteel deeltje een golflengte heeft die groot genoeg is om interferentie te vertonen op atomair schaalniveau. In de opstelling van dit practicum wordt een elektronenbundel gericht op een dun polycrystallijn grafietlaagje, en de resulterende diffractieringen worden zichtbaar gemaakt op een fluorescerend scherm.

#v(1fr)

#voorbereiding(title: [Voorbereiding])[
+ Zoek op wat de verwachte roosterafstanden van grafiet zijn.

+ Leid de relatie af tussen $lambda$ en $U_A$ via vergelijking (1).

+ Leid af hoe je uit $D$ en $L$ de hoek $theta.alt$ bepaalt.

+ Formuleer een hypothese: hoe verandert $lambda$ als functie van $U_A$?

+ Noteer hoe je onzekerheden in $D$ gaat schatten.

]

#heading(level: 1, numbering: none)[Theorie]

Wanneer elektronen versneld worden door een versnellingsspanning $U_A$, krijgen ze een kinetische energie die gelijk is aan het elektrische energiewerk:

#math.equation(block: true, numbering: "(1)", $e U_A = 1 / 2 m v^2 .$) Daaruit volgt dat de snelheid, en dus het impuls, direct gekoppeld is aan de versnellingsspanning. Door dit te combineren met de de Broglie-relatie ontstaat een uitdrukking voor de golflengte als functie van de spanning: #math.equation(block: true, numbering: "(1)", $lambda = h / sqrt(2 m e U_A) .$)

Bij versnellingen van enkele kilovolt ligt de bijbehorende golflengte in het picometerbereik. Dit is van dezelfde orde als interatomaire afstanden in vaste stoffen. Daardoor kunnen elektronen, net als röntgenstraling, diffractie vertonen wanneer ze op kristalroosters vallen. Het waarnemen van interferentie- en diffractieringen vormt dus een directe experimentele bevestiging van de golfnatuur van elektronen. \
In een elektronen-diffractiebuis wordt een elektronenbundel gericht op een dunne polycrystalline grafietlaag. Het uitgewaaierde diffractiepatroon wordt zichtbaar gemaakt op een fluorescent scherm, zie Fig. #ref(label("elektronen_diffractie--fig: ED_weergave"), supplement: none). Hierbij verschijnen karakteristieke ringen: elke ring komt overeen met een groep kristalvlakken die precies voldoet aan de diffractievoorwaarde, afhankelijk van de golflengte van het elektron en de roosterafstand van het materiaal.

#figure(
  [
#box(image("Figuren/ED_tekening.png", width: 65.0%))
  ],
  caption: [Schematische weergave van het elektronen diffractie experiment.],
  kind: image,
) #label("elektronen_diffractie--fig: ED_weergave")

Wanneer een bundel elektronen een polycrystallijn materiaal raakt, treden diffractie-effecten op vanuit de vele willekeurig georiënteerde microkristallen. De conditionele reflectie van golven aan kristalvlakken wordt beschreven door de Bragg-voorwaarde:

#math.equation(block: true, numbering: "(1)", $2 d sin theta = n lambda \,$)

waarbij $d$ de afstand is tussen de kristalvlakken, $theta$ de Bragg-hoek, $lambda$ de golflengte van het elektron en $n$ de diffractieorde.

#figure(
  [
#box(image("Figuren/grafiet.png", width: 35.0%))
  ],
  caption: [Kristalstructuur van grafiek, met hierbij de twee kristralrooster constanten $d_1 approx 123 thin upright("pm")$ en $d_2 approx 213 thin upright("pm")$.],
  kind: image,
) #label("elektronen_diffractie--fig: grafiet")

Grafiet heeft twee dominante roosterafstanden in het hexagonale vlak $d_1 approx 123 thin upright("pm")$ en $d_2 approx 213 thin upright("pm")$, zie Fig. #ref(label("elektronen_diffractie--fig: grafiet"), supplement: none). Hierdoor ontstaan in het diffractiepatroon twee heldere ringen, één voor elk kristalvlak. De straal van de ring die zichtbaar is op het fluorescentiescherm hangt samen met de hoek $theta$. Voor een elektronen-diffractiebuis met afstand $L$ tussen grafiet en scherm volgt: #math.equation(block: true, numbering: "(1)", $D = 2 L tan \( 2 theta \) \,$) waarbij $D$ de diameter van een diffractiering is. Door $D$ te meten bij verschillende versnellingsspanningen $U_A$, kan men via de Bragg-vergelijking de golflengte reconstrueren. Door $lambda$ zowel via de Bragg-vergelijking als via de de Broglie-relatie te bepalen, kun je experimenteel aantonen dat elektronen zich gedragen als materiegolven.

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Practicum]

#methode(title: [Uitvoering])[
+ Monteer de diffractiebuis in de houder; zorg dat de pennen correct contact maken. Zie Fig. #ref(label("elektronen_diffractie--fig: elektronendiffractie opstelling"), supplement: none) voor de opstelling.

+ Sluit de gloeidraad aan op de heater-uitgangen van de hoogspanningsvoeding.

+ Sluit de negatieve hoogspanningsuitgang aan op het kathodecontact en de positieve kant op de anodecontacten volgens de buishouder.

+ Zet de hoogspanning op $U_A = 6000 thin upright(V)$ en observeer de diffractieringen.

+ Meet de diameter van beide ringen $D_1$ en $D_2$ op het fluorescentiescherm.

+ Verlaag $U_A$ telkens met $500 thin upright(V)$, herhaal de meting van $D_1$ en $D_2$.

+ Noteer systematisch alle meetwaarden in je logboek.

]

#figure(
  [
#box(image("Figuren/Elektronendiffractie.png", width: 95.0%))
  ],
  caption: [Elektronen diffractie opstelling.],
  kind: image,
) #label("elektronen_diffractie--fig: elektronendiffractie opstelling")

#opdracht(title: [Verwerking])[
+ Bepaal voor iedere spanning $U_A$ de verwachte de Broglie-golflengte via (3).

+ Bepaal voor iedere gemeten diameter $D$ de Bragg-hoek: #math.equation(block: true, numbering: none, $theta = arctan #h(-1em) (frac(D, 4 L)) .$)

+ Toets voor beide ringen de Bragg-vergelijking: #math.equation(block: true, numbering: none, $2 d sin theta = lambda .$)

+ Maak een grafiek van de Bragg-bepaalde golflengte vs. de de Broglie-golflengte.

+ Maak een fit. In het ideale geval heb je een 1:1 lijn wanneer beide metingen dezelfde overeenkomen.

]

#opdracht(title: [Resultaten & Discussie])[
+ Toon grafieken voor $D_1 \( U_A \)$ en $D_2 \( U_A \)$.

+ Toon de vergelijking tussen experimentele $lambda_(upright("Bragg"))$ en theoretische $lambda_(upright("de Broglie"))$.

+ Bespreek onzekerheden in $D$, invloed van schermkromming en afleesfouten.

+ Bespreek of de fit jouw verwachting ondersteunt.

+ Formuleer een conclusie: bevestigd jouw meting het golfkarakter van elektronen.

]

#afronding(title: [Afronding])[
+ Zet de gevonden figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal. Hierin moet de uiteindelijke waarde van jouw experiment (met onzekerheid) staan en een korte discussie of deze waarde #strong[realistisch] en #strong[betrouwbaar] is.

+ Ruim de opstelling pas op als de stroom UIT staat en de buis voldoende is afgekoeld.

]

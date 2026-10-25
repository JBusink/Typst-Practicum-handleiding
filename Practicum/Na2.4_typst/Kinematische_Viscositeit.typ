#import "../../styl.typ": *
#show: stijl.with(titel: "Kinematische Viscositeit", kop: "Technische Natuurkunde — Na2.4")

#praktikumtitle[Practicum: Viscositeit met de Ubbelohde viscometer]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kan de kinematische en dynamische viscositeit meten met een Ubbelohde viscosimeter.

- Je kan een foutanalyse uitvoeren met behulp van foutenpropagatie.

- Je kan de dynamische viscositeit van mengsels experimenteel bepalen.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ De Ubbelohde viscometer is gemaakt van dun glas en zeer breekbaar. Ga hier voorzichtig mee om.

+ Werk zorgvuldig met vloeistoffen en voorkom morsen. Ruim gemorste vloeistoffen direct op.

+ Gebruik de viscometer alleen volgens de instructies van de begeleider.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

In dit practicum onderzoek je de viscositeit van vloeistoffen met behulp van een Ubbelohde viscometer. Dit is een klassieke meetmethode waarbij de stroming van een vloeistof door een dunne capillair wordt gebruikt om de viscositeit te bepalen.

Hoewel moderne apparatuur vaak gebruik maakt van roterende systemen, biedt de Ubbelohde viscometer een eenvoudige en nauwkeurige manier om viscositeit te meten op basis van stromingstijd, #link("https://cannoninstrument.com/ubc-2-ubbelohde-visc-cal9721-r68.html")[Link]. In dit practicum bepaal je de dynamische viscositeit van water en vergelijk je verschillende methoden om de meetnauwkeurigheid te evalueren.

#figure(
  [
#box(image("Figuren/Ubbelohde.png", width: 25.0%))
  ],
  caption: [Een Ubbelohode viscometer.],
  kind: image,
) #label("kinematische_viscositeit--fig:placeholder")

In het tweede deel van het practicum onderzoek je mengsels van vloeistoffen en bestudeer je hoe moleculaire interacties de viscositeit beïnvloeden.

#v(1fr)

#voorbereiding(title: [Voorbereidingsopdracht 1])[
+ Bekijk de video over het gebruik van de Ubbelohde viscometer.

+ Lees de handleiding van de UBC-2 viscometer op Brightspace.

+ Noteer:

  - de dynamische en kinematische viscositeit van water.

  - de bijbehorende eenheden en dimensies.

+ Stel een foutpropagatieformule op voor $mu$.

+ Zoek viscositeiten van water en glycerol op.

+ Bereken $x_1$ en $x_2$ voor verschillende mengverhoudingen.

+ Bedenk een strategie om $G_12$ te bepalen.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Theorie]

#strong[Kinematische viscositeit van een vloeistof]

De tijd t die het vloeistofniveau nodig heeft om te dalen van positie $E$ naar positie $F$ heeft een direct verband met de zogenaamde kinematische viscositeit $nu$:

#math.equation(block: true, numbering: "(1)", $nu = k t$) Hierin is $k$ de kalibratieconstante van de specifieke Ubbelohde viscometer. Deze moet dus altijd gekalibreerd worden met een vloeistof waarvan de (kinematische) viscositeit bekend is.

Je kunt je waarschijnlijk voorstellen dat de dichtheid van invloed is op hoe snel een vloeistof als gevolg van de zwaartekracht door een buis naar beneden stroomt. De kinematische viscositeit $mu$ is dan ook niks anders dan de dynamische viscositeit gedeeld door de dichtheid van de vloeistof:

#math.equation(block: true, numbering: "(1)", $nu = mu / rho .$)

#strong[Mengels van oplossingen]

Voor mengsels (Engels: mixtures) van vloeistoffen kan de dynamische viscositeit ook bepaald worden. Een eerste-orde benadering hiervoor is de massa-gewogen som van de individuele viscositeiten: #math.equation(block: true, numbering: n => [3], $mu_(upright("mix")) = sum_i w_i mu_i = \( 1 - w \) thin mu_1 + w thin mu_2$) Hierbij is $w_i$ de massafractie van vloeistof $i$ met dynamische viscositeit $mu_i$. Voor twee vloeistoffen kan dit vereenvoudigd worden door te schrijven in termen van het massapercentage $w$ van het mengsel (bijvoorbeeld: $w = 0 . 1$ voor 10% glycerol in water). Echter, deze benadering werkt in het algemeen niet goed. \
De reden hiervoor is dat de individuele moleculen vaak complexe interacties met elkaar aangaan (sterke intermoleculaire interacties, zoals waterstofbruggen, zwavelbruggen, etc.). Voor mengsels (bijvoorbeeld water--glycerol) kan een betere benadering worden gemaakt door te corrigeren voor het molecuulgewicht $M_i$ en door een interactieparameter te introduceren.

De eerste correctie betreft het molecuulgewicht van de individuele vloeistoffen. Voor water geldt $M_w = 18.015 med g \/ m o l$ en voor glycerol $M_g = 92.093 med g \/ m o l$. De molfracties worden dan bepaald via: #math.equation(block: true, numbering: n => [4], $n_1 = frac(1 - w, M_w) \, #h(2em) n_2 = w / M_g$)

Vervolgens definiëren we de genormaliseerde fracties: #math.equation(block: true, numbering: n => [5], $x_1 = frac(n_1, n_1 + n_2) \, #h(2em) x_2 = 1 - x_1$)

De viscositeit kan vervolgens worden bepaald met de Grunberg--Nissan-formule: #math.equation(block: true, numbering: n => [6], $ln mu_(upright("mix")) = x_1 ln mu_w + x_2 ln mu_g + x_1 x_2 G_12$) Hierbij is $mu_w$ de viscositeit van water, $mu_g$ de viscositeit van glycerol en $G_12$ een maat voor de interactiesterkte tussen de moleculen.

#heading(level: 1, numbering: none)[Practicum]

#methode(title: [Experiment deel I: Water])[
In dit practicum wordt gewerkt met een UBC-2 Ubbelohde Calibrated viscometer. Let op: Ubbelohde-viscometers zijn fragiel en kostbaar, ga hier zorgvuldig mee om.

De onderstaande methode is bewust beknopt geformuleerd. Van jullie wordt verwacht dat je zelfstandig een geschikte meetstrategie opstelt en onderbouwt.

+ Meet de stromingstijd van water minimaal 20 keer en bepaal de kinematische viscositeit $nu$ voor elke meting.

+ Maak een schatting van de meetfouten. Identificeer de dominante foutbron (bijvoorbeeld timing, temperatuur, aflezen).

+ Bepaal de dynamische viscositeit $mu$ van water en bereken de bijbehorende onzekerheid via foutenpropagatie.

+ Spoel de Ubbelohde-viscometer zorgvuldig schoon na afloop van de metingen.

]

#opdracht(title: [Verwerking deel I])[
+ Maak een histogram van de gemeten waarden van $mu$. Kies een passende bin-grootte en bepaal:

  - het gemiddelde van $mu$

  - de fout op het gemiddelde

+ Onderzoek of de metingen normaal verdeeld zijn, bijvoorbeeld door een Gaussiaanse fit op het histogram toe te passen.

+ Vergelijk de spreiding tussen individuele metingen met de geschatte meetfouten. Welke bijdrage domineert?

+ Noteer de eindwaarde van de dynamische viscositeit van water inclusief onzekerheid.

]

#methode(title: [Experiment deel II: Mengsels])[
Iedere groep bepaalt de dynamische viscositeit van één mengsel (mixture). De verzamelde data wordt klassikaal gecombineerd voor verdere analyse.

+ Meet de kinematische viscositeit $nu$ van jullie mengsel. Herhaal de meting totdat je een betrouwbare schatting hebt van de gemiddelde waarde en de spreiding.

+ Bepaal de dynamische viscositeit $mu$ van het mengsel en bereken de bijbehorende onzekerheid.

+ Noteer jullie waarde van $mu$ (inclusief onzekerheid) op het bord, zodat deze beschikbaar is voor de gehele groep.

+ Verzamel de viscositeitsgegevens van de andere groepen.

+ Spoel de Ubbelohde-viscometer zorgvuldig schoon na afloop van de metingen.

]

#opdracht(title: [Verwerking deel II])[
+ Bepaal de interactieparameter $G_12$ (water--glycerol) met bijbehorende onzekerheid, gebruikmakend van de gecombineerde dataset.

+ Leg uit of er bij je metingen sprake is van systematische afwijking(en) en hoe dit je metingen beïnvloed.

+ Verklaar jouw gevonden waarde voor de interactiesterkte met de literatuurwaarde.

]

#afronding(title: [Afronding])[
+ Werk alle resultaten uit in je labjournaal

+ Laat je werk controleren door de begeleider.

]

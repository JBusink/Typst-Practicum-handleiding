// Stap 1: laad de opmaakfunctie uit het bestand naast dit document.
#import "template.typ": beginnersdocument
// Zap is een pakket voor het tekenen van elektrische schakelingen.
#import "@preview/zap:0.6.0"
#import "@preview/cetz:0.5.2": draw

// Stap 2: pas de template toe en vul je eigen gegevens in.
#show: beginnersdocument.with(
  titel: "Mijn eerste Typst-document",
  auteur: "Jouw naam",
  studentnummer: "1234567",
)

// Stap 3: vervang de voorbeeldtekst hieronder door je eigen inhoud.
// Regels die met // beginnen zijn opmerkingen en verschijnen niet in de PDF.

= Introductie

Typst is een systeem waarmee je documenten opmaakt vanuit tekst en code.
Je schrijft de inhoud in een `.typ`-bestand; de compiler zet die om in een
opgemaakt document. Dat is handig voor verslagen met formules, tabellen,
figuren en literatuurverwijzingen @typst-handleiding.

De ontwikkeling begon in 2019. De makers, Laurenz Mädje en Martin Haug,
wilden het schrijven en opmaken van documenten eenvoudiger maken en meer
ruimte bieden voor automatisering. Het project ontstond vanuit hun eigen
ervaringen met het schrijven van papers en studieopdrachten. In 2023 werd
het bedrijf Typst in Berlijn opgericht @typst-over @typst-geschiedenis.

De compiler is opensourcesoftware. Daarnaast biedt Typst een webeditor,
waarin je documenten in de browser kunt schrijven en samen bewerken.
Typst combineert tekstnotatie met functies voor opmaak en berekeningen.
Met een template kun je dezelfde vormgeving voor verschillende documenten
hergebruiken @typst-over.

Dit startdocument laat de belangrijkste onderdelen zien. Je schrijft de
inhoud in `start.typ`; de import- en show-regels laden de opmaak uit
`template.typ`. Bewaar deze bestanden bij elkaar, samen met de afbeeldingen
en het bestand met literatuurbronnen.

== Installatie en werken in VS Code

Je kunt Typst gebruiken in de browser via #link("https://typst.app")[typst.app],
of lokaal in Visual Studio Code (VS Code). Voor dit project volg je deze stappen:

+ Download en installeer #link("https://code.visualstudio.com/")[Visual Studio Code].
+ Open het extensievenster met `Ctrl+Shift+X`. Zoek naar *Tinymist Typst*
  van *Myriad-Dreamin* en installeer deze extensie. Deze verzorgt de preview
  en PDF-export @tinymist.
+ Download de bestanden van Brightspace en pak ze uit in een map `Professional Development` op je computer.
+ Kies *File > Open Folder* en open de map `Professional Development`,
  inclusief `start.typ`, `template.typ`, `referenties.bib` en de map `figuren`.
+ Open `start.typ`. Open het opdrachtenpalet met `Ctrl+Shift+P` en zoek
  naar *Typst Preview* om de voorbeeldweergave naast je tekst te openen.
+ Pas je naam en studentnummer aan en sla op met `Ctrl+S`.
  Zoek in het opdrachtenpalet naar *Export PDF* van Tinymist om een PDF
  te maken. Met *Typst Pin Main* kun je het geopende `start.typ` vastzetten
  als hoofddocument, ook wanneer je daarna de template bewerkt @tinymist.

Voor de preview en export via Tinymist is geen aparte Typst CLI nodig.
Bij de eerste compilatie is internet nodig om de pakketten Zap en CeTZ
op te halen als die nog niet lokaal beschikbaar zijn.

Wil je ook vanuit de terminal compileren? Installeer op Windows de Typst CLI
met deze opdracht in PowerShell @typst-installatie:

```powershell
winget install --id Typst.Typst
```

Open daarna een nieuwe terminal en controleer de installatie met
`typst --version`. Voer vanuit de map `Professional Development` de
opdracht `typst compile start.typ start.pdf` uit om een PDF te maken.

= Kopjes en lijsten

Een kop begint met `=`. Voor een subkop gebruik je `==`.
Hieronder staat een voorbeeld van de code:

```typ
= Mijn hoofdstuk
== Mijn subkop
Dit is een alinea met *vette* en _cursieve_ tekst.
```

== Voorbeeld van een subkop

Dit is een voorbeeldalinea met *vette* en _cursieve_ tekst.
Met een lege regel in de broncode begin je een nieuwe alinea.

Een opsomming maak je met een minteken:
- Vul bovenaan je naam en de titel in.
- Pas de tekst aan en bekijk het resultaat in de preview.
- Exporteer je document als PDF.

Een genummerde lijst maak je met een plusteken:
+ Beschrijf je onderzoeksvraag.
+ Voer je metingen uit.
+ Bespreek je resultaten.

= Formules

Zet een formule tussen dollartekens. Een formule in een zin ziet er zo uit:
$v = s / t$. Met spaties direct na en voor de dollartekens krijgt de formule
een eigen regel:

$ v = s / t $ <eq-snelheid>

Hierin is $v$ de snelheid, $s$ de afstand en $t$ de tijd.

== Vergelijkingen nummeren

In de template staat `set math.equation(numbering: "(1)")`.
Daardoor krijgen alle formules op een eigen regel automatisch een nummer
tussen haakjes. Formules in een zin blijven ongenummerd.
Zonder template zet je de volgende regel boven je formules:

```typ
#set math.equation(numbering: "(1)")
```

Geef een vergelijking een label met `<...>` en verwijs ernaar met `@...`:

```typ
$ v = s / t $ <eq-snelheid>
Zie @eq-snelheid.
```

Het resultaat van die verwijzing is: zie @eq-snelheid.
Gebruik voor elke vergelijking een uniek label; de nummering past zich
automatisch aan als je een vergelijking toevoegt.

Wil je alleen een bepaalde vergelijking nummeren, gebruik dan
`#math.equation(block: true, numbering: "(1)")[$v = s / t$]`.
Een enkele formule zonder nummer maak je met
`#math.equation(block: true, numbering: none)[$v = s / t$]`.

= Van LaTeX naar Typst

Deze tabel vergelijkt veelgebruikte LaTeX-syntax met Typst.
Typst gebruikt een eigen syntax: neem de voorbeelden uit de rechterkolom over.

#table(
  columns: (0.8fr, 1.6fr, 1.6fr),
  table.hline(stroke: 0.9pt),
  table.header([*Doel*], [*LaTeX*], [*Typst*]),
  table.hline(stroke: 0.5pt),
  [Kop], [`\section{Titel}`], [`= Titel`],
  [Subkop], [`\subsection{Titel}`], [`== Titel`],
  [Vet], [`\textbf{tekst}`], [`*tekst*`],
  [Cursief], [`\textit{tekst}`], [`_tekst_`],
  [Formule in tekst], [`$v = s/t$`], [`$v = s / t$`],
  [Breuk], [`\frac{s}{t}`], [`s / t`],
  [Wortel], [`\sqrt{x}`], [`sqrt(x)`],
  [Griekse letter], [`\alpha`], [`alpha`],
  [Index en macht], [`x_{max}^{2}`], [`x_("max")^2`],
  [Vergelijking met nummer],
  [`\begin{equation}` #linebreak() `v = s/t` #linebreak() `\end{equation}`],
  [`$ v = s / t $` #linebreak() Met de nummeringsregel uit de template.],
  [Label], [`\label{eq:snelheid}`], [`<eq-snelheid>`],
  [Verwijzing], [`\eqref{eq:snelheid}`], [`@eq-snelheid`],
  table.hline(stroke: 0.9pt),
)

De voorbeelden voor breuken, wortels, Griekse letters, indices en machten
gebruik je binnen dollartekens. Voorbeeld: `$sqrt(x)$` geeft $sqrt(x)$.

= Een tabel

Met een `#` roep je een Typst-functie aan. De functie `table` maakt hier
een tabel met drie kolommen. Tekst tussen vierkante haken is de celinhoud.

#figure(
  table(
    columns: 3,
    align: (left, right, right),
    table.hline(stroke: 0.9pt),
    table.header([Meting], [Afstand (m)], [Tijd (s)]),
    table.hline(stroke: 0.5pt),
    [1], [10], [2],
    [2], [20], [4],
    table.hline(stroke: 0.9pt),
  ),
  caption: [Voorbeeld van meetgegevens.],
) <metingen>

Met een label en een apenstaartje verwijs je automatisch naar een tabel:
zie @metingen.

Deze tabellen gebruiken de booktabs-stijl uit LaTeX: een bovenlijn,
een dunne lijn onder de kolomkoppen en een onderlijn, zonder verticale lijnen.
In Typst voeg je deze lijnen toe met `table.hline(stroke: 0.9pt)`;
de template schakelt de overige tabelranden uit met `set table(stroke: none)`.

= Een RC-filter tekenen met Zap

In @rc-filter staat een RC-laagdoorlaatfilter. De weerstand $R$ staat in
serie met de ingang; de condensator $C$ verbindt de uitgang met massa.
De uitgangsspanning wordt over de condensator gemeten.

// Elk onderdeel krijgt een unieke naam, een beginpunt en een eindpunt.
// De coordinaten (x, y) bepalen de plaats van de onderdelen.
#figure(
  zap.circuit({
    import zap: *

    // Signaalpad: ingang, weerstand en uitgang.
    resistor("R", (0, 2.5), (3, 2.5), label: $R = 1 "k" Omega$)
    wire((3, 2.5), (5, 2.5))
    capacitor("C", (3, 2.5), (3, 0), label: $C = 100 "nF"$)

    // Gemeenschappelijke massa voor ingang en uitgang.
    wire((0, 0), (5, 0))
    ground("massa", (3, 0))
    for p in ((3, 2.5), (3, 0)) {
      draw.circle(p, radius: 0.05, fill: black)
    }
    for p in ((0, 2.5), (0, 0), (5, 2.5), (5, 0)) {
      draw.circle(p, radius: 0.07, fill: white)
    }
    draw.content((-0.3, 1.25), $V_"in"$, anchor: "east")
    draw.content((6.3, 1.25), $V_"uit"$, anchor: "west")
  }),
  caption: [RC-laagdoorlaatfilter met de uitgang over de condensator.],
) <rc-filter>

Bij een onbelaste uitgang en een ideale spanningsbron is de afsnijfrequentie:

$ f_c = 1 / (2 pi R C) approx 1.59 "kHz" $

Lage frequenties worden vrijwel doorgelaten; hoge frequenties worden verzwakt.
Pas de labels en coordinaten in de code aan om met de tekening te oefenen.
De afsnijfrequentie hierboven is als tekst ingevuld: reken die opnieuw uit
als je de componentwaarden verandert.

= Een testfiguur invoegen

Een losse afbeelding laad je met `image`. In @fig-test zie je een
schematische meetopstelling. Dit is een testafbeelding, geen bedradingsschema.

#figure(
  image("figuren/testfiguur.svg", width: 75%),
  caption: [Schematische meetopstelling met een signaalbron, RC-filter en oscilloscoop. Eigen illustratie.],
) <fig-test>

Zo voeg je de afbeelding met onderschrift en label in:

```typ
#figure(
  image("figuren/testfiguur.svg", width: 90%),
  caption: [Schematische meetopstelling.],
) <fig-test>

Zie @fig-test.
```

Vervang het bestandspad door je eigen afbeelding. Bewaar de map `figuren`
bij het document. Het label `<fig-test>` moet uniek zijn; met `@fig-test`
verwijst de tekst automatisch naar het juiste figuurnummer.

= Bronnen citeren

De Typst-handleiding laat zien hoe je tekst, figuren en bronverwijzingen
combineert @typst-handleiding. De documentatie over literatuurlijsten
beschrijft het gebruik van een BibLaTeX-bestand @typst-literatuur.

Deze bronnen staan in `referenties.bib`. Citeer een bron met de sleutel
uit dat bestand, bijvoorbeeld `@typst-handleiding`. Dit lijkt op een
figuurverwijzing, maar de sleutel verwijst nu naar een literatuurbron.
In LaTeX gebruik je hiervoor doorgaans `\cite{typst-handleiding}`.

Onderaan dit document staat de opdracht die de literatuurlijst invoegt:

```typ
#bibliography("referenties.bib", title: [Referenties], style: "ieee")
```

Typst neemt de geciteerde bronnen automatisch op en nummert ze.
Voeg voor je eigen bronnen nieuwe vermeldingen met unieke sleutels toe
aan `referenties.bib`, en citeer die sleutels in je tekst.


#bibliography("referenties.bib", title: [Referenties], style: "ieee")

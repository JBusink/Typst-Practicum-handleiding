#import "@preview/lilaq:0.6.0" as lq
#import "Template_wis.typ": *

#show: documentstijl.with(
  titel: "Grafieken met Lilaq",
  vak: "Wiskunde | Voorbeeldengids",
  auteur: "Joris Busink",
  datum: "November 2026",
)
#set text(size: 11pt)
#set par(justify: false, leading: 0.55em)
#set figure(supplement: [Figuur])
#show figure: set align(center)
#show figure.caption: set text(size: 9pt, fill: rgb("526174"))
#show raw.where(block: true): it => block(
  width: 100%, fill: rgb("f3f6fa"), radius: 4pt,
  inset: 11pt, above: 8pt, below: 8pt,
  text(size: 9pt, it),
)
// #show heading: set text(fill: rgb("183b56"))

// Gedeelde instellingen voor alle voorbeelden.
#let blauw = rgb("#0f73df")
#let oranje = rgb("#f0791f")
#let groen = rgb("#16a71d")
#let grijs = rgb("7a8795")
#let diagram = lq.diagram.with(
  width: 0% + 14cm, height: 7cm,
  grid: (stroke: 0.35pt + rgb("e1e7ee")),
  xaxis: (mirror: false), yaxis: (mirror: false),
  legend: (position: top + right, stroke: none, fill: white),
)
#let lijn = lq.plot.with(mark: none, stroke: 1.5pt)

// Dezelfde broncode wordt uitgevoerd en afgedrukt: code en figuur blijven gelijk.
#let voorbeeld(titel, uitleg, code, bijschrift, tip) = {
  pagebreak()
  heading(titel)
  uitleg
  figure(
    eval(code, mode: "code", scope: (
      lq: lq, diagram: diagram, lijn: lijn,
      blauw: blauw, oranje: oranje, groen: groen, grijs: grijs,
    )),
    caption: bijschrift,
  )
  text(weight: "bold")[Zo maak je deze grafiek]
  raw(code, lang: "typc", block: true)
  block(inset: (left: 9pt, y: 4pt), stroke: (left: 2pt + groen))[
    *Opmaakkeuze.* #tip
  ]
}

#text(size: 26pt, weight: "bold")[Grafieken met Lilaq]
= Een vaste basis
Gebruik bovenaan je eigen document onderstaande instellingen. De code op
de volgende pagina’s gebruikt deze namen. Plaats de voorbeeldcode in een
Typst-codeblok `#{ ... }`; zo blijven de lokale variabelen bij de figuur.

```typ
#import "@preview/lilaq:0.6.0" as lq
#let blauw = rgb("2563a6")
#let oranje = rgb("c56a26")
#let groen = rgb("168278")
#let grijs = rgb("7a8795")
#let diagram = lq.diagram.with(
  width: 0% + 14cm, height: 7cm,
  grid: (stroke: 0.35pt + rgb("e1e7ee")),
  xaxis: (mirror: false), yaxis: (mirror: false),
  legend: (position: top + right, stroke: none, fill: white),
)
#let lijn = lq.plot.with(mark: none, stroke: 1.5pt)
#set figure(supplement: [Figuur])
#show figure: set align(center)
```

= Figuren centreren
Verpak een grafiek in `figure` voor een nummer en een bijschrift. De
show-regel hierboven centreert alle figuren. Een losse grafiek zonder
bijschrift centreer je met `align(center)`.

```typ
#figure(
  diagram(lijn(lq.linspace(-2, 2), x => x*x, color: blauw)),
  caption: [De parabool.],
)
// Zonder bijschrift:
#align(center)[#diagram(lijn((0, 1, 2), (0, 1, 4)))]
```

*Waarom deze basis?* Een lichte rasterlijn houdt de gegevens leesbaar.
Blauw, oranje en groen geven rust en contrast; streepjes en markeringen
helpen om reeksen ook zonder kleur te onderscheiden. `0% + 14cm` begrenst
de totale breedte inclusief aslabels; `height: 7cm` bepaalt de hoogte
van het tekengebied.

#text(size: 9pt)[
  Naslag: #link("https://lilaq.org/docs/quickstart")[Lilaq-handleiding],
  #link("https://lilaq.org/docs/reference/diagram")[diagram] en
  #link("https://lilaq.org/docs/reference/plot")[plot].
  Alle voorbeelden gebruiken versie 0.6.0.
]

#voorbeeld(
  [01 / Twee periodieke functies],
  [Je eerste voorbeeld, met meer tekenpunten, duidelijke labels en verschillende
  lijnstijlen. De horizontale nul-lijn helpt bij het aflezen van nulpunten.],
  ```typc
  let x = lq.linspace(-7, 7, num: 401)
  diagram(
    xlabel: $x$, ylabel: $y$,
    xlim: (-7, 7), ylim: (-1.4, 1.8),
    lq.hlines(0, stroke: 0.6pt + grijs),
    lijn(x, x => calc.sin(0.5*x + 0.541),
      color: blauw, label: $sin(0.5x + 0.541)$),
    lijn(x, x => calc.cos(2*x), color: oranje,
      stroke: (thickness: 1.4pt, dash: "dashed"),
      label: $cos(2x)$),
  )
  ```.text,
  [Twee trillingen met verschillende perioden; hoeken in radialen.],
  [Reserveer boven de curves ruimte voor de legenda. Gebruik bij continue
  functies geen markering op ieder tekenpunt.],
)

#voorbeeld(
  [02 / Parabool met raaklijn],
  [Voor $f(x)=x^2$ is de helling bij $x=1$ gelijk aan $2$. De raaklijn
  is dus $y=2x-1$. Eén opvallend punt is voldoende om de aanraking te tonen.],
  ```typc
  let x = lq.linspace(-2.2, 2.2, num: 201)
  diagram(
    xlabel: $x$, ylabel: $y$,
    xlim: (-2.2, 2.2), ylim: (-2, 5.5),
    legend: (position: top + left),
    lq.hlines(0, stroke: 0.6pt + grijs),
    lq.vlines(0, stroke: 0.6pt + grijs),
    lijn(x, x => x*x, color: blauw, label: $f(x)=x^2$),
    lijn(x, x => 2*x - 1, color: oranje,
      stroke: (thickness: 1.3pt, dash: "dashed"),
      label: [Raaklijn]),
    lq.plot((1,), (1,), stroke: none, mark: "o",
      mark-size: 5pt, color: groen, label: $P(1,1)$),
  )
  ```.text,
  [Functie, raaklijn en raakpunt in één assenstelsel.],
  [Maak hulplijnen dunner dan de functie. Kies de asgrenzen bewust:
  de raaklijn hoeft niet over zijn volledige bereik zichtbaar te zijn.],
)

#voorbeeld(
  [03 / Een integraal als oppervlakte],
  [De gekleurde oppervlakte onder $f(x)=1+x^2/4$ loopt van $x=0$ tot $x=2$.
  Omdat de functie daar positief is, is de oppervlakte gelijk aan
  $integral_0^2 (1+x^2/4) dif x = 8/3$.],
  ```typc
  let f(x) = 1 + x*x/4
  let x = lq.linspace(-1, 3, num: 201)
  let gebied = lq.linspace(0, 2, num: 101)
  diagram(
    xlabel: $x$, ylabel: $f(x)$,
    xlim: (-1, 3), ylim: (0, 3.8),
    legend: (position: top + left),
    lq.fill-between(gebied, gebied.map(f),
      y2: gebied.map(x => 0),
      fill: blauw.lighten(78%)),
    lijn(x, f, color: blauw, label: $1+x^2/4$),
    lq.plot((2, 2), (0, f(2)), mark: none,
      stroke: (paint: oranje, dash: "dashed")),
  )
  ```.text,
  [De lichte vulling markeert uitsluitend het integratie-interval.],
  [Teken de vulling vóór de curve, zodat de functielijn scherp blijft.
  Gebruik een eigen reeks x-waarden voor het integratiegebied.],
)

#voorbeeld(
  [04 / Meetpunten met onzekerheid],
  [Fictieve meetgegevens voor een beweging met ongeveer constante snelheid.
  De lijn $s=0.8t+0.2$ is een gekozen referentiemodel, geen berekende fit.
  De foutbalken tonen hier een opgegeven onzekerheid van ±0.25 m.],
  ```typc
  let t = (0, 1, 2, 3, 4, 5, 6)
  let s = (0.25, 0.9, 1.95, 2.5, 3.5, 4.1, 5.15)
  diagram(
    xlabel: $t thin ("s")$, ylabel: $s thin ("m")$,
    xlim: (-0.4, 6.4), ylim: (-0.4, 6.3),
    legend: (position: top + left),
    lijn(lq.linspace(0, 6), t => 0.8*t + 0.2,
      color: oranje, label: [Referentiemodel]),
    lq.plot(t, s, yerr: 0.25, stroke: none,
      mark: "o", mark-size: 4pt, color: blauw,
      label: [Meetpunten ±0.25 m]),
  )
  ```.text,
  [Losse meetpunten met verticale foutbalken en een modelcurve.],
  [Verbind meetpunten alleen als dat inhoudelijk zinvol is. Vermeld altijd
  de eenheden en leg uit wat de foutbalken voorstellen.],
)

#voorbeeld(
  [05 / Exponentieel verval op een logaritmische as],
  [Een exponentiële functie wordt een rechte lijn als de verticale as
  logaritmisch is. Hier daalt de genormaliseerde amplitude volgens
  $A(t)/A_0 = e^(-0.8t)$.],
  ```typc
  let t = lq.linspace(0, 8, num: 201)
  diagram(
    xlabel: $t thin ("s")$, ylabel: $A(t)/A_0$,
    xlim: (0, 8), ylim: (0.001, 2),
    yscale: "log",
    lijn(t, t => calc.exp(-0.8*t), color: blauw,
      label: $e^(-0.8t)$),
  )
  ```.text,
  [Exponentieel verval op een semilogaritmische schaal.],
  [Een gewone logaritmische as kan alleen positieve waarden weergeven.
  Gelijke verticale afstanden stellen gelijke verhoudingen voor;
  voeg daarom nooit een nulgrens toe.],
)

#voorbeeld(
  [06 / Een parametrische kromme],
  [Bij $x(t)=cos(t)$ en $y(t)=sin(t)$ beschrijven de coördinaten samen een
  eenheidscirkel. De parameter loopt van $0$ tot $2pi$.],
  ```typc
  let t = lq.linspace(0, 2*calc.pi, num: 361)
  diagram(
    width: 7cm, height: 7cm,
    xlabel: $x(t)$, ylabel: $y(t)$,
    xlim: (-1.25, 1.25), ylim: (-1.25, 1.25),
    legend: none,
    lq.hlines(0, stroke: 0.6pt + grijs),
    lq.vlines(0, stroke: 0.6pt + grijs),
    lijn(t.map(calc.cos), t.map(calc.sin), color: blauw),
    lq.plot((1,), (0,), stroke: none,
      mark: "o", mark-size: 5pt, color: oranje),
  )
  ```.text,
  [De eenheidscirkel met het beginpunt bij t = 0 in oranje.],
  [Gebruik gelijke tekenafmetingen én gelijke asbereiken. Zo hebben
  x en y dezelfde schaal en wordt een cirkel geen ellips.],
)

#voorbeeld(
  [07 / Een functie met een asymptoot],
  [De functie $f(x)=1/x$ is niet gedefinieerd bij $x=0$. Teken de twee
  takken apart; anders kan een onterechte verbindingslijn ontstaan.],
  ```typc
  let links = lq.linspace(-4, -0.15, num: 251)
  let rechts = lq.linspace(0.15, 4, num: 251)
  diagram(
    xlabel: $x$, ylabel: $y$,
    xlim: (-4, 4), ylim: (-4, 4),
    lq.vlines(0, stroke: (paint: grijs, dash: "dashed")),
    lq.hlines(0, stroke: (paint: grijs, dash: "dashed")),
    lijn(links, x => 1/x, color: blauw, label: $1/x$),
    lijn(rechts, x => 1/x, color: blauw),
  )
  ```.text,
  [Twee losse takken; de gestreepte lijnen zijn de asymptoten.],
  [Laat ongedefinieerde punten uit de gegevens. Geef beide takken dezelfde
  kleur en slechts één legendalabel: het is één functie.],
)

#voorbeeld(
  [08 / Contourplot met kleurenschaal],
  [Je tweede voorbeeld toont $z=x y$ als een vlak met hoogtelijnen.
  Een kleurenschaal maakt zichtbaar welke z-waarde bij elke kleur hoort;
  de dunne nul-lijnen scheiden de vier kwadranten.],
  ```typc
  let r = lq.linspace(-5, 5, num: 81)
  let veld = lq.contour(r, r, (x, y) => x*y,
    levels: range(-25, 26, step: 5),
    fill: true, map: color.map.icefire, min: -25, max: 25)
  stack(dir: ltr, spacing: 8pt,
    diagram(
      width: 7cm, height: 7cm,
      xlabel: $x$, ylabel: $y$,
      xlim: (-5, 5), ylim: (-5, 5), grid: none,
      veld,
      lq.hlines(0, stroke: 0.6pt + white),
      lq.vlines(0, stroke: 0.6pt + white),
    ),
    lq.colorbar(veld, height: 7cm, label: $z=x y$),
  )
  ```.text,
  [Een zadeloppervlak van bovenaf, met symmetrische kleurgrenzen.],
  [Een divergerende kleurenschaal past bij negatieve en positieve waarden.
  Zet het raster uit: de kleurvlakken bevatten al voldoende informatie.],
)


#voorbeeld(
  [09 / Normaalverdeling en sigma-gebieden],
  [Bij een normaalverdeling ligt ongeveer 68,27% binnen $mu plus.minus sigma$,
  95,45% binnen $mu plus.minus 2sigma$ en 99,73% binnen $mu plus.minus 3sigma$.
  Hieronder zijn $mu=0$ en $sigma=1$. De kleuren tonen afzonderlijke banden;
  de percentages in de legenda tellen steeds de linker- en rechterkant samen.],
  ```typc
  let f(x) = calc.exp(-x*x/2) / calc.sqrt(2*calc.pi)
  let band(a, kleur, naam) = {
    let x = lq.linspace(-a, a, num: 241)
    lq.fill-between(x, x.map(f), y2: x.map(x => 0),
      fill: kleur, label: naam)
  }
  diagram(
    xlabel: $x$, ylabel: [Kansdichtheid],
    xlim: (-3.8, 3.8), ylim: (0, 0.53),
    xaxis: (mirror: false, ticks: ((-3, $mu-3sigma$), (-2, $mu-2sigma$),
      (-1, $mu-sigma$), (0, $mu$), (1, $mu+sigma$),
      (2, $mu+2sigma$), (3, $mu+3sigma$)), subticks: none),
    band(3.8, grijs.lighten(75%), none),
    band(3, oranje.lighten(42%), [2 tot $3sigma$: 4,28%]),
    band(2, groen.lighten(43%), [1 tot $2sigma$: 27,18%]),
    band(1, blauw.lighten(40%), [Binnen $1sigma$: 68,27%]),
    ..range(-3, 4).map(k => lq.plot((k, k), (0, f(k)),
      mark: none, stroke: 0.7pt + white)),
    lijn(lq.linspace(-3.8, 3.8, num: 401), f,
      color: blauw),
  )
  ```.text,
  [Blauw: binnen $1sigma$; groen: $1$ tot $2sigma$; oranje: $2$ tot $3sigma$. Buiten $plus.minus 3sigma$ ligt samen circa 0,27%.],
  [Vul eerst het breedste gebied en daarna de smallere gebieden. Zo ontstaan
  symmetrische kleurbanden zonder gaten. De oppervlakte geeft de kans weer,
  niet de hoogte van de curve. De grijze staarten lopen door buiten het beeld.],
)

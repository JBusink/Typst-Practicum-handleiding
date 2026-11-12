// Omzetting van het aangeleverde LaTeX-oefententamen naar Typst.
// Zet deze schakelaar op true om de uitwerkingen en beoordelingscriteria te tonen.
#let toon-oplossingen = false

#let datum = "31-01-2025"
#let begintijd = "12:00"
#let vakcode = "2200WISK23"
#let totaalpunten = 50
#let aantal-opgaven = 6
#let diff = sym.partial
#set page(
  paper: "a4",
  margin: (x: 15mm, y: 18mm),
  header: context [#h(1fr) #text(size: 9pt)[Pagina #counter(page).display() van #counter(page).final().first()]],
  footer: none,
)
#set text(font: "New Computer Modern", size: 11pt, lang: "nl")
#set par(justify: false, leading: 0.65em, spacing: 0.7em)
#set heading(numbering: none)
#set math.equation(numbering: none)

#let opgave(n, punten, inhoud) = [
  #block(above: 1.2em, below: 0.8em)[
    #text(size: 17pt, weight: "bold")[Opgave #n]
    #h(1fr)
    #text(weight: "bold")[(#punten p)]
    #line(length: 100%, stroke: 0.5pt + gray)
  ]
  #inhoud
]

#let uitwerking(inhoud) = if toon-oplossingen {
  block(
    width: 100%,
    fill: rgb("#F0F4F8"),
    inset: 12pt,
    radius: 4pt,
    stroke: 0.4pt + rgb("#9AAEBF"),
    breakable: true,
  )[
    *Uitwerking en beoordelingscriteria*

    #inhoud
  ]
}

#let score-regels(regels) = table(
  columns: (1fr, 54pt),
  inset: 5pt,
  stroke: 0.4pt + rgb("#B8B8B8"),
  ..regels.flatten(),
)

#let infoveld(naam, waarde) = (strong(naam), waarde)

// VOORBLAD
#align(center)[
  #v(10mm)
  #text(size: 19pt, weight: "bold")[Dynamische systemen en Regeltechniek]

  #text(size: 17pt, weight: "bold")[Oefententamen]

  #v(4mm)
  *TENTAMENVOORBLAD*

  *Voor aanvang van het tentamen de tentamengegevens goed doorlezen.*
]
#v(8mm)

#table(
  columns: (36%, 64%),
  stroke: 0.6pt,
  inset: 7pt,
  table.cell(colspan: 2, fill: rgb("#D0D0D0"))[#align(center)[*IN TE VULLEN DOOR STUDENT*]],
  [*NAAM STUDENT*], [#v(11mm)],
  [*STUDENTNUMMER*], [#v(11mm)],
)
#v(4mm)
#table(
  columns: (36%, 64%),
  stroke: 0.6pt,
  inset: 5pt,
  table.cell(colspan: 2, fill: rgb("#D0D0D0"))[#align(center)[*IN TE VULLEN DOOR EXAMINATOR*]],
  [*OPLEIDING*], [Technische Natuurkunde],
  [*LESVORM*], [Voltijd],
  [*STUDIEGIDSNR.*], [#vakcode],
  [*OMSCHRIJVING*], [Dynamische systemen en Regeltechniek: Tentamen],
  [*SOORT TENTAMEN*], [Tentamen],
  [*WERKVORM*], [Tentamen Schriftelijk (TS)],
  [*NAAM EXAMINATOREN*], [Rik van Breukelen en Joris Busink],
  [*AANTAL OPGAVEN*], [#aantal-opgaven],
  [*AANTAL BLADZIJDES*], [#context counter(page).final().first()],
  [*BIJLAGEN*], [Geen],
  [*MEERDERE VERSIES*], [Nee],
  [*TENTAMENPAPIER*], [Ruitjes; kladpapier wordt meegegeven],
  [*NORMERING*], [Zoals aangegeven op het tentamen; cijfer = totaal punten / 5],
  [*HULPMIDDELEN*], [Rekenmachine: ja; grafische rekenmachine: nee; aantekeningen: nee; boek: nee; woordenboek: ja; eigen formuleblad: nee],
  [*INLEVEREN*], [Tentamenblad: ja. Alles inleveren!],
  [*DATUM TENTAMEN*], [#datum],
  [*TIJDSDUUR*], [100 minuten],
  [*BEGINTIJD*], [#begintijd],
  [*OPMERKINGEN*], [Bij toetstijdverlenging: 100 minuten + 25 minuten],
)

#pagebreak()
#align(center)[#text(size: 18pt, weight: "bold")[Instructies]]

- Het tentamen bestaat uit #aantal-opgaven opgaven. Hiermee kun je #totaalpunten punten verdienen. Het cijfer wordt berekend met $10 dot ("totaal behaalde punten") / #totaalpunten$.
- Dit tentamen bepaalt 50% van je eindcijfer; de andere 50% wordt bepaald door de projecten.
- *Nummer elke pagina* die je inlevert. Schrijf je naam en studentnummer *op elk blad*.
- Je mag een *simpele* rekenmachine gebruiken, geen grafische rekenmachine.
- Licht je antwoord *altijd* toe. Zonder toelichting, berekening of redenering worden *geen punten* toegekend.
- Succes en veel plezier!

== Formuleoverzicht

*State-space-representatie*
$
  dot(bold(x)) &= A bold(x) + B bold(u) \
  bold(y) &= C bold(x) + D bold(u)
$

*Jacobiaan*
$
  J_f = mat(
    (diff f_1)/(diff x_1), (diff f_1)/(diff x_2), dots.h, (diff f_1)/(diff x_n);
    (diff f_2)/(diff x_1), (diff f_2)/(diff x_2), dots.h, (diff f_2)/(diff x_n);
    dots.v, dots.v, dots.down, dots.v;
    (diff f_n)/(diff x_1), (diff f_n)/(diff x_2), dots.h, (diff f_n)/(diff x_n)
  )
$

*Kostenfunctie*
$
 J_T &= J_x + J_u = integral (bold(x)^T Q bold(x) + bold(u)^T R bold(u)) dif t \
 Delta J &= (bold(x)^T Q bold(x) + bold(u)^T R bold(u)) Delta t
$

*Controleerbaarheids- en observeerbaarheidsmatrix*
$
 "Con" &= mat(B, A B, dots.h, A^(n-1) B) \
 "Obs" &= mat(C; C A; dots.v; C A^(n-1))
$

*Hautus-testmatrices*
$
 mat(A - lambda I, B) quad "en" quad mat(A - lambda I; C)
$

#pagebreak()


#v(8mm)
#align(right)[*Einde $square$*]

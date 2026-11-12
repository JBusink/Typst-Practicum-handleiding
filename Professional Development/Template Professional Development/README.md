# Template Professional Development

Kopieer deze hele map voor een nieuwe opdracht. Bewerk `main.typ` voor de inhoud en `rubriek.typ` voor een beoordelingsformulier. Alle gedeelde instellingen staan in `template.typ`.

## Basis: aangeleverde practicumstijl

Overgenomen zijn:

- lettertypen TeX Gyre Heros, Helvetica, Arial en Liberation Sans als alternatieven; standaard 11 pt en Nederlands;
- A4 met 20 mm zijmarges en 32 mm boven- en ondermarge;
- een kopregel met een dunne zwarte lijn, een gecentreerde voettekst met Nederlandse datum, studiejaar en opleiding, en rechts het paginanummer;
- uitgevulde alinea's zonder eerste-regelinspringing, regelafstand van 0,45 em en alinea-afstand van 0,55 em;
- kopgroottes van 16 pt en 13 pt, en een gecentreerde documenttitel van 20 pt;
- de lijststijl inclusief de omzetting van impliciet compacte markup-lijsten naar ruime lijsten, met 0,6 em tussen items;
- dunne zwarte tabellijnen, compacte cellen en vetgedrukte kolomkoppen;
- het gebruikte opdrachtkader, met een witte achtergrond en zwarte omlijning.

In tegenstelling tot de practicumbron blijven alle achtergronden wit. De tekstcellen van beoordelingsrubrieken zijn linksboven uitgelijnd. Liggende rubrieken gebruiken 15 mm marges en 9 pt tekst. Dit houdt de bestaande formulieren bruikbaar.

Niet overgenomen: kleurpaletten, titel- en tussentitelpagina's, inhoudsopgaven, code- en Python-thema's, oplossingen en vragen, leerdoelsymbolen, figuur- en formuleopmaak, subfiguren en ongebruikte kadervarianten. Deze komen niet voor in de huidige documenten.

## Instellingen en bouwstenen

Gebruik `professional-development.with(titel: "...", subtitel: "...", ...)`. Optioneel zijn `auteur`, `datum`, `opleiding`, `studiejaar`, `liggend`, `tekstgrootte` en `marges`. De datum is standaard de compilatiedatum; geef een vaste Typst-datum mee om een vaste publicatiedatum te gebruiken. `documenttype` blijft beschikbaar voor bestaande aanroepen.

De gebruikte bouwstenen zijn `kader(titel)[inhoud]`, `invulveld(label, hoogte: 10mm)` en `rubriektabel(...)`. Invulvelden zijn printbaar, niet interactief in PDF. De bestaande memo-opdrachten hebben een expliciete paginaovergang bij een sectie, zodat lijsten en toelichtingen niet los over pagina's worden verdeeld.

## Compileren

Omdat de import buiten de jaarmap staat, moet de projectroot bij compilatie de map `Professional Development` zijn. Vanuit die map bijvoorbeeld:

```powershell
typst compile --root . "2026-2027/Memos/memo1.typ"
```

Stel in een editor dezelfde projectroot in. Kopieer voor een zelfstandig nieuw document de hele templatemap en gebruik `main.typ`.

De oude versies en het lokale LaTeX-bestand van presentatie 2 zijn verwijderd uit de jaarmap. De oorspronkelijke LaTeX-bronnen in `Latex bestanden` en het losse Typst-leervoorbeeld zijn behouden.

Alle tekst, koppen, lijnen en kaders zijn zwart; de achtergronden zijn wit.

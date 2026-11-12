from pathlib import Path
for name,heading in [('memo1','Opstelling en eerste resultaten'),('memo2','Algemene criteria')]:
 p=Path('2026-2027/Memos')/(name+'.typ');s=p.read_text(encoding='utf-8');needle='#heading(level: 2, numbering: none)[\n  '+heading;s=s.replace(needle,'// Begin de volgende sectie op een nieuwe pagina; houd tekst en lijst bij elkaar.\n#pagebreak()\n\n'+needle);p.write_text(s,encoding='utf-8')
p=Path('2026-2027/README.md');s=p.read_text(encoding='utf-8');a=s.index('Alle actieve documenten');b=s.index('| Onderdeel',a)
s=s[:a]+'''Alle actieve documenten gebruiken het gedeelde [Professional Development-template](../Template%20Professional%20Development/template.typ), gebaseerd op de aangeleverde practicumstijl. Inhoud, beoordelingscriteria en wegingen zijn behouden. De memo-opdrachten beslaan elk twee pagina's; de overige actieve documenten elk één A4.

Overgenomen zijn de schreefloze lettertypen, Nederlandse tekst, uitgevulde alinea's, kopgroottes, ruimere opsommingen, kopregel en Nederlandse datum in de voettekst. Opdrachten blijven in één kolom. Tekst en lijnen zijn zwart en achtergronden wit. Rubrieken behouden liggend A4 en links uitgelijnde tekst in de tabelcellen.

'''+s[b:];p.write_text(s,encoding='utf-8')
p=Path('Template Professional Development/README.md');s=p.read_text(encoding='utf-8');a=s.index('Omdat de import');tail=s[a:]
s='''# Template Professional Development

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

'''+tail
p.write_text(s,encoding='utf-8')
p=Path('CONTROLE-OMZETTING.md');s=p.read_text(encoding='utf-8');s=s.replace("Na herstel van de enkele tekstkolom beslaat Memo 1 twee pagina's; de overige documenten elk één A4.","Met de aangeleverde practicumstijl beslaan de memo-opdrachten elk twee pagina's; de overige actieve documenten elk één A4.");p.write_text(s,encoding='utf-8')

from pathlib import Path
import json,typst
p=Path('Template Professional Development/README.md');s=p.read_text(encoding='utf-8');a=s.index('De basis volgt');b=s.index('Instellingen wijzigen',a)
s=s[:a]+'''Standaard: A4 staand, Arial (Liberation Sans als alternatief), 11 pt en Nederlandse tekst. Zij- en bovenmarges zijn 16 mm, de ondermarge 18 mm. Koppen hebben 5,5 mm ruimte erboven en 2,3 mm eronder. Een dunne zwarte lijn scheidt de titel van de inhoud. De voettekst toont Professional Development, studiejaar en paginanummer.

'''+s[b:]
s=s.replace('| `marges` | `none`: automatisch 20/25 mm voor staand of 15 mm voor liggend; desgewenst overschrijven |','| `marges` | `(x: 16mm, top: 16mm, bottom: 18mm)`; voor rubrieken `(x: 12mm, top: 12mm, bottom: 15mm)` |')
s=s.replace('`kader` is een eenvoudig tekstblok met een vetgedrukte titel, zonder omlijning.','`kader` is een tekstblok met een vetgedrukte titel en dunne zwarte omlijning.')
a=s.index('De negen actieve opdrachten en rubrieken');b=s.index('Omdat de import',a)
s=s[:a]+'''De negen actieve opdrachten en rubrieken in `2026-2027` importeren dit template rechtstreeks. Presentatieopdrachten gebruiken 11 pt en marges van 16 mm; memo-opdrachten 10,5 pt en marges van 14 mm. Alle opdrachten gebruiken één tekstkolom. Memo 1 beslaat twee pagina's met een bewuste paginaovergang vóór de sectie over de opstelling. Rubrieken gebruiken liggend A4 met 8,5 pt en zijmarges van 12 mm. Inhoud, kolombreedtes en beoordelingsonderdelen staan in de documenten zelf.

'''+s[b:];p.write_text(s,encoding='utf-8')
p=Path('2026-2027/README.md');s=p.read_text(encoding='utf-8').replace('elk document past op één A4.',"Memo 1 beslaat twee pagina's; de overige documenten elk één A4.")
a=s.index('De opmaak volgt');b=s.index('\n\n',a)
s=s[:a]+'''De opmaak gebruikt Arial, zwarte tekst, ruime afstanden rond koppen en dunne zwarte lijnen. Alle opdrachten hebben één tekstkolom. Memo 1 heeft een bewuste paginaovergang vóór de sectie over de opstelling.'''+s[b:];p.write_text(s,encoding='utf-8')
p=Path('CONTROLE-OMZETTING.md');s=p.read_text(encoding='utf-8').replace('Met de uiteindelijke LaTeX-artikelopmaak passen alle negen actieve documenten op één A4, in één tekstkolom.',"Na herstel van de enkele tekstkolom beslaat Memo 1 twee pagina's; de overige documenten elk één A4.");p.write_text(s,encoding='utf-8')
for filename in json.loads(Path('tmp/controle/gemigreerd.json').read_text()):
 p=Path(filename);p.with_suffix('.pdf').write_bytes((Path('tmp/controle/migratie')/(p.stem+'.pdf')).read_bytes())
for name in ['main','rubriek']:typst.compile(str(Path('Template Professional Development')/(name+'.typ')))
print('Vorige opmaak en negen PDFs hersteld; templates compileren.')

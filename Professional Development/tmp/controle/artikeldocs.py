from pathlib import Path
p=Path('Template Professional Development/README.md');s=p.read_text(encoding='utf-8');a=s.index('Standaard:');b=s.index('Instellingen wijzigen',a)
s=s[:a]+'''De basis volgt de bestaande LaTeX-bronnen met `article` en `geometry`: een enkele tekstkolom, New Computer Modern (Libertinus Serif als alternatief), 11 pt, zwarte tekst, uitgevulde alinea's zonder eerste-regelinspringing en eenvoudige vetgedrukte koppen. De staande documenten hebben marges van 20 mm links/rechts en 25 mm boven/onder. Liggende rubrieken gebruiken 15 mm rondom. Er zijn geen decoratieve titelbanners, gekleurde vlakken of lijnen onder de titel. De voettekst toont Professional Development, het studiejaar en het paginanummer.

'''+s[b:]
s=s.replace('| `marges` | `(x: 16mm, top: 16mm, bottom: 18mm)`; voor een rubriek bijvoorbeeld `(x: 12mm, top: 12mm, bottom: 15mm)` |','| `marges` | `none`: automatisch 20/25 mm voor staand of 15 mm voor liggend; desgewenst overschrijven |')
s=s.replace('Liggende documenten gebruiken een compactere titel, tabelopmaak met witte achtergronden en kleinere alinea-afstanden.','Liggende documenten gebruiken witte tabelachtergronden en zwarte lijnen. `kader` is een eenvoudig tekstblok met een vetgedrukte titel, zonder omlijning.')
a=s.index('De negen actieve opdrachten en rubrieken');b=s.index('Omdat de import',a)
s=s[:a]+'''De negen actieve opdrachten en rubrieken in `2026-2027` importeren dit template rechtstreeks. Alle opdrachten gebruiken één kolom en 11 pt. Rubrieken gebruiken liggend A4 en 9 pt. Inhoud, kolombreedtes en specifieke beoordelingsonderdelen staan in de documenten zelf. Alle negen documenten passen met deze artikelopmaak op één A4.

'''+s[b:]
p.write_text(s,encoding='utf-8')
p=Path('2026-2027/README.md');s=p.read_text(encoding='utf-8');s=s.replace("Memo 1 beslaat twee pagina's; de overige documenten elk één A4.",'elk document past op één A4.')
a=s.index('De opmaak is verruimd:');b=s.index('\n\n',a)
s=s[:a]+'''De opmaak volgt de bestaande LaTeX-artikelen: New Computer Modern, één kolom, zwarte tekst, eenvoudige koppen, uitgevulde alinea's en een sobere titel. Staande documenten gebruiken marges van 20 mm links/rechts en 25 mm boven/onder; liggende rubrieken 15 mm rondom.'''+s[b:]
p.write_text(s,encoding='utf-8')
p=Path('CONTROLE-OMZETTING.md');s=p.read_text(encoding='utf-8');s=s.replace("Na herstel van de enkele tekstkolom beslaat Memo 1 twee pagina's; de overige documenten elk één A4.",'Met de uiteindelijke LaTeX-artikelopmaak passen alle negen actieve documenten op één A4, in één tekstkolom.')
p.write_text(s,encoding='utf-8')

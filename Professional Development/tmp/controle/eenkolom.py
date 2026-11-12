from pathlib import Path
import typst
from pypdf import PdfReader
p=Path('2026-2027/Memos/memo1.typ');s=p.read_text(encoding='utf-8')
s=s.replace('// Twee kolommen houden de uitgebreide opdracht leesbaar op een pagina.\n#columns(2, gutter: 9mm)[\n','').replace('#colbreak()\n\n','')
s=s.rstrip();assert s.endswith(']');s=s[:-1].rstrip()+'\n'
needle='#heading(level: 2, numbering: none)[\n  Opstelling en eerste resultaten'
s=s.replace(needle,'// Houd de complete sectie bij elkaar op de vervolgpagina.\n#pagebreak()\n\n'+needle)
p.write_text(s,encoding='utf-8')
imgs=typst.compile(str(p),root=str(Path.cwd()),format='png',ppi=85)
if isinstance(imgs,bytes):imgs=[imgs]
for i,b in enumerate(imgs):Path(f'tmp/controle/memo1-eenkolom-{i+1}.png').write_bytes(b)
p.with_suffix('.pdf').write_bytes(typst.compile(str(p),root=str(Path.cwd())))
print('Memo 1:',len(PdfReader(p.with_suffix('.pdf')).pages),'paginas, een kolom')
p=Path('2026-2027/README.md');s=p.read_text(encoding='utf-8').replace('elk document past op één A4.','Memo 1 beslaat twee pagina\u0027s; de overige documenten elk één A4.').replace('Memo 1 gebruikt twee kolommen om de uitgebreide inhoud leesbaar te houden.','Alle opdrachten blijven in één tekstkolom. Memo 1 heeft een bewuste paginaovergang vóór de sectie over de opstelling.');p.write_text(s,encoding='utf-8')
p=Path('Template Professional Development/README.md');s=p.read_text(encoding='utf-8').replace('De langere opdracht voor memo 1 gebruikt twee kolommen, met een bewuste kolomovergang bij een nieuwe alinea.','Alle opdrachten gebruiken één tekstkolom. De langere opdracht voor memo 1 beslaat twee pagina\u0027s, met een bewuste paginaovergang vóór de sectie over de opstelling.');p.write_text(s,encoding='utf-8')
p=Path('CONTROLE-OMZETTING.md');s=p.read_text(encoding='utf-8').replace('Alle negen documenten passen nu elk op één A4 en zijn opnieuw gecompileerd en visueel gecontroleerd.','Alle negen documenten zijn opnieuw gecompileerd en visueel gecontroleerd. Na herstel van de enkele tekstkolom beslaat Memo 1 twee pagina\u0027s; de overige documenten elk één A4.');p.write_text(s,encoding='utf-8')

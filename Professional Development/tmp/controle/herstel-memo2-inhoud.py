from pathlib import Path
import subprocess,typst
from pypdf import PdfReader
base='Professional Development/2026-2027/Memos/'
p=Path('2026-2027/Memos/memo2.typ')
old=subprocess.check_output(['git','show','HEAD:'+base+p.name]).decode('utf-8')
s=p.read_text(encoding='utf-8')
a=s.index('Deze memo beschrijft');b=s.index('#heading',a);s=s[:a]+s[b:]
start='#heading(level: 2, numbering: none)[\n  Schematische tekening'
end='#heading(level: 2, numbering: none)[\n  Algemene criteria'
a=s.index(start);b=s.index(end,a);oa=old.index(start);ob=old.index(end,oa)
section=old[oa:ob].rstrip()+'\n\n// Begin de volgende sectie op een nieuwe pagina; houd tekst en lijst bij elkaar.\n#pagebreak()\n\n'
s=s[:a]+section+s[b:];p.write_text(s,encoding='utf-8')
p=Path('2026-2027/Memos/Rubriek_memo2.typ')
old=subprocess.check_output(['git','show','HEAD:'+base+p.name]).decode('utf-8')
s=p.read_text(encoding='utf-8').replace('// Compactere criteria binnen de tabel; de documentstijl blijft ongewijzigd.\n#show table: set list(spacing: 0.25em)\n\n','')
a=s.index('  // Schematische tekening');b=s.index('  // Algemeen',a);oa=old.index('  // Schematische tekening');ob=old.index('  // Algemeen',oa)
s=s[:a]+old[oa:ob]+s[b:];p.write_text(s,encoding='utf-8')
for name in ['memo2','Rubriek_memo2']:
 p=Path('2026-2027/Memos')/(name+'.typ');p.with_suffix('.pdf').write_bytes(typst.compile(str(p),root=str(Path.cwd())))
 print(name,len(PdfReader(p.with_suffix('.pdf')).pages),'pagina(s)')

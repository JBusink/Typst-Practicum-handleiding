from pathlib import Path
import typst
from pypdf import PdfReader
p=Path('2026-2027/Memos/Rubriek_memo2.typ');s=p.read_text(encoding='utf-8')
s=s.replace('  tekstgrootte: 9pt,','  tekstgrootte: 9pt,\n  lettertype: ("New Computer Modern", "Libertinus Serif"),').replace('    opleiding:', '  opleiding:')
pos=s.index('#grid(')
s=s[:pos]+'''// Open invullijnen in plaats van omlijnde formuliervakken.
#let invullijn(label, hoogte: 10mm) = block(width: 100%, height: hoogte)[
  #text(size: 9pt, weight: "bold", label)
  #v(1fr)
  #line(length: 100%, stroke: 0.35pt + black)
]

'''+s[pos:]
s=s.replace('invulveld(', 'invullijn(')
s=s.replace('  inset: (x: 6pt, y: 4pt),','''  inset: (x: 7pt, y: 6pt),
  stroke: none,
  table.hline(y: 0, stroke: 0.8pt + black),
  table.hline(y: 1, stroke: 0.5pt + black),
  table.hline(y: 2, stroke: 0.3pt + black),
  table.hline(y: 3, stroke: 0.3pt + black),
  table.hline(y: 4, stroke: 0.3pt + black),
  table.hline(y: 5, stroke: 0.3pt + black),
  table.hline(y: 6, stroke: 0.8pt + black),''')
s=s.replace('*Weging: 20%*','#text(size: 8.5pt, style: "italic")[Weging: 20%]')
s=s.replace('[Score:\\ \\ ........ / 10]','table.cell(align: center + horizon)[........ / 10]')
p.write_text(s,encoding='utf-8')
out=Path('tmp/controle/rubriek-memo2-latex.pdf');out.write_bytes(typst.compile(str(p),root=str(Path.cwd())));print('Paginas:',len(PdfReader(out).pages))
imgs=typst.compile(str(p),root=str(Path.cwd()),format='png',ppi=100)
if isinstance(imgs,bytes):imgs=[imgs]
for i,b in enumerate(imgs):Path(f'tmp/controle/rubriek-memo2-latex-{i+1}.png').write_bytes(b)

from pathlib import Path
import typst,json
from pypdf import PdfReader
out=Path('tmp/controle/migratie'); out.mkdir(parents=True,exist_ok=True)
for filename in json.loads(Path('tmp/controle/gemigreerd.json').read_text()):
 p=Path(filename)
 try:
  pdf=typst.compile(str(p),root=str(Path.cwd()))
  dest=out/(p.stem+'.pdf'); dest.write_bytes(pdf)
  print(p.stem, len(PdfReader(dest).pages), 'paginas')
  imgs=typst.compile(str(p),root=str(Path.cwd()),format='png',ppi=85)
  if isinstance(imgs,bytes): imgs=[imgs]
  for i,b in enumerate(imgs): (out/f'{p.stem}-{i+1}.png').write_bytes(b)
 except Exception as e: print('FOUT',p,e)

from pathlib import Path
import re
p=Path('Template Professional Development/template.typ');s=p.read_text(encoding='utf-8')
s=s.replace('let inkt = rgb("25384a")','let inkt = black')
s=re.sub(r'fill: \(x, y\) => if liggend and y == 0 \{.*?\},','fill: white,',s)
s=re.sub(r'fill: \(x, y\) => if y == 0 \{.*?\},','fill: white,',s)
s=re.sub(r'fill: luma\(\d+%\)', 'fill: black',s)
s=s.replace('inset: 10pt, fill: black, radius: 3pt','inset: 10pt, fill: white, stroke: 0.5pt + black, radius: 3pt')
s=re.sub(r'luma\(\d+%\)|rgb\("[0-9a-fA-F]+"\)', 'black',s)
s=s.replace('size: tekstgrootte, lang: "nl"','size: tekstgrootte, lang: "nl", fill: black')
p.write_text(s,encoding='utf-8')
for p in Path('2026-2027').rglob('*.typ'):
 s=p.read_text(encoding='utf-8')
 s=re.sub(r'fill: \(x, y\) => if calc.even\(y\) \{ luma\(95%\) \},','fill: white,',s)
 s=re.sub(r'luma\(\d+%\)|rgb\("#[0-9a-fA-F]+"\)|\bgray\b','black',s)
 if p.stem=='Presentatie2_V2':
  s=s.replace('#let licht = black','#let licht = white').replace('table.cell(fill: accent)','table.cell(fill: white)').replace('text(fill: white','text(fill: black')
 p.write_text(s,encoding='utf-8')
for filename in ['Template Professional Development/README.md','2026-2027/README.md']:
 p=Path(filename);s=p.read_text(encoding='utf-8').replace('met een donkerblauwgrijze kleur','in zwart').replace('zachtere tabellijnen','dunne zwarte tabellijnen').replace('tabelopmaak met afwisselende rijachtergronden','tabelopmaak met witte achtergronden')
 s+='\nAlle tekst, koppen, lijnen en kaders zijn zwart; de achtergronden zijn wit.\n'
 p.write_text(s,encoding='utf-8')

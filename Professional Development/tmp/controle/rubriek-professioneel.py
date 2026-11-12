from pathlib import Path
import re
p=Path('2026-2027/Memos/Rubriek_memo2.typ');s=p.read_text(encoding='utf-8')
a=s.index('#table(')
s=s[:a]+'''#grid(columns: (1.5fr, 1fr, 1fr), gutter: 3mm,
  invulveld("Student / studentnummer:"),
  invulveld("Beoordelaar:"),
  invulveld("Datum:"),
)
#v(2mm)
*Werkwijze:* geef per onderdeel een score van 1 tot 10. De niveaubeschrijvingen
ondersteunen de keuze; noteer onderaan concrete feedback. Elk onderdeel weegt
20%. Het eindcijfer is het gemiddelde van de vijf scores.
#v(1mm)

'''+s[a:]
s=s.replace('columns: (3.5fr, 2.5fr, 2.5fr, 2.5fr, 0.7fr),','columns: (24%, 22%, 22%, 22%, 10%),\n  inset: (x: 6pt, y: 6pt),')
items=[
('Voortgang en resultaten','1. Voortgang en resultaten','Voortgang; volledigheid van resultaten; onderbouwing van analyses; logische toelichting.'),
('Discussie en volgende stappen','2. Discussie en volgende stappen','Interpretatie; relatie met stagedoel; inzichten en beperkingen; conclusies; haalbare vervolgstappen.'),
('Schematische tekening en toelichting','3. Schematische tekening en toelichting','Digitale en representatieve schets; begrijpelijke toelichting en onderschrift; uitvoering en beperkingen.'),
('Opmaak figuren','4. Opmaak figuren','Nummering, labels en onderschriften; relevante selectie; ondersteuning van de interpretatie.'),
('Algemeen','5. Algemene criteria','Maximaal 4 A4; taal en lay-out; op tijd; geen plagiaat; verwijzingen naar bronnen.'),
]
for old,title,criteria in items:
 pattern=r'\[\s*\*'+re.escape(old)+r'\*\s*\n.*?\n  \],'
 replacement='[\n    *'+title+'*\n\n    *Weging: 20%*\n\n    '+criteria+'\n  ],'
 s,n=re.subn(pattern,lambda m:replacement,s,count=1,flags=re.S)
 assert n==1,old
s=s.replace('  [],','  [Score:\\ \\ ........ / 10],')
s+='''
#v(3mm)
#grid(columns: (1fr, 1fr, 0.7fr), gutter: 3mm,
  invulveld("Sterke punten (met voorbeeld):", hoogte: 15mm),
  invulveld("Belangrijkste verbeteractie:", hoogte: 15mm),
  invulveld("Eindcijfer: totaal scores / 5", hoogte: 15mm),
)
'''
p.write_text(s,encoding='utf-8')
import typst
from pypdf import PdfReader
out=Path('tmp/controle/memo2-rubriek-professioneel.pdf');out.write_bytes(typst.compile(str(p),root=str(Path.cwd())));print('Paginas:',len(PdfReader(out).pages))
imgs=typst.compile(str(p),root=str(Path.cwd()),format='png',ppi=100)
if isinstance(imgs,bytes):imgs=[imgs]
for i,b in enumerate(imgs):Path(f'tmp/controle/memo2-rubriek-professioneel-{i+1}.png').write_bytes(b)

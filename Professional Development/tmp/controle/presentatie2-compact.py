from pathlib import Path
p=Path('2026-2027/Presentaties/presentatie2/Presentatie2.typ');s=p.read_text(encoding='utf-8')
a=s.index('= Doel van de visual');b=s.index('= Beoordeling',a)
s=s[:a]+'''= Doel en inhoud
Ontwerp een *TOC-graphic* of *graphical abstract*: een compacte visuele
samenvatting van je project. Een medestudent die jouw stage niet kent,
moet de kernboodschap en de samenhang tussen de volgende onderdelen begrijpen:

- *Aanleiding en doel:* welk probleem onderzoek je en wat wil je bereiken?
- *Technische aanpak:* hoe werkt de technologie, opstelling of het model?
  Wat stel je in, meet, bereken of ontwerp je, en waarom?
- *Tussenstand en betekenis:* welk resultaat, inzicht of ontwerp heb je
  bereikt en wat betekent dit voor het doel? Onderscheid aangetoonde
  resultaten, voorlopige bevindingen en geplande stappen.

Eindresultaten zijn in week 13 nog niet vereist. Ook een test,
ontwerpvergelijking of simulatie kan een relevant tussenresultaat zijn.

= Vormgeving en onderschrift
Gebruik één centrale dia met de overzichtsvisual. Samenhangende deelfiguren
zijn mogelijk, bijvoorbeeld een werkingsprincipe, opstellingsschema en
resultaatgrafiek. Maak hiervan één geheel met een duidelijke leesrichting,
visuele hiërarchie en functionele verbindingen.

- Selecteer wat de kernboodschap ondersteunt. Vermijd tekstblokken en
  onnodige details; gebruik consistente symbolen, labels en lijnstijlen.
- Controleer de leesbaarheid op presentatieschermformaat, ook zonder kleur.
  Vermeld relevante grootheden en eenheden. Maak bij grafieken assen,
  datasets en eventuele foutbalken begrijpelijk.
- Voeg een beknopt onderschrift toe dat de samenhang en kernboodschap
  zelfstandig begrijpelijk maakt. Verklaar afkortingen en vermeld bronnen
  bij overgenomen of bewerkt materiaal.

Houd rekening met vertrouwelijke bedrijfsinformatie.

= Presentatie en voorbereiding
Gebruik de visual als leidraad. Wijs onderdelen aan, leg hun relaties uit
en licht vaktermen toe. Bereid vragen voor over het werkingsprincipe,
technische keuzes, de tussenstand en beperkingen. Benoem wat nog onbekend is.

Oefen met een timer. Richtlijn: *2 minuten probleem en doel*, *3 minuten
technische aanpak*, *2 minuten tussenstand en betekenis* en *1 minuut
kernboodschap en vervolgstap*.

'''+s[b:]
p.write_text(s,encoding='utf-8')
p=Path('2026-2027/Presentaties/presentatie2/Rubriek_Presentatie2.typ');s=p.read_text(encoding='utf-8')
s=s.replace('inset: (x: 7pt, y: 5pt)','inset: (x: 7pt, y: 4pt)')
s=s.replace('in de 8 minuten.','in de 8 minuten.\n*Eindcijfer:* 0,3 × S1 + 0,3 × S2 + 0,2 × S3 + 0,1 × S4 + 0,1 × S5.')
s=s.replace('Eindcijfer: 0,3 × S1 + 0,3 × S2 + 0,2 × S3 + 0,1 × S4 + 0,1 × S5','Eindcijfer (gewogen):')
p.write_text(s,encoding='utf-8')
import typst
from pypdf import PdfReader
for name in ['Presentatie2','Rubriek_Presentatie2']:
 p=Path('2026-2027/Presentaties/presentatie2')/(name+'.typ');out=Path('tmp/controle')/(name+'-week13.pdf');out.write_bytes(typst.compile(str(p),root=str(Path.cwd())));print(name,len(PdfReader(out).pages))
 imgs=typst.compile(str(p),root=str(Path.cwd()),format='png',ppi=95)
 if isinstance(imgs,bytes):imgs=[imgs]
 for i,b in enumerate(imgs):Path(f'tmp/controle/{name}-week13-{i+1}.png').write_bytes(b)

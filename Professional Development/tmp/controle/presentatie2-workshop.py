from pathlib import Path
import re,typst
from pypdf import PdfReader
folder=Path('2026-2027/Presentaties/presentatie2')
p=folder/'Presentatie2.typ';s=p.read_text(encoding='utf-8');head=s[:s.index('Maak een professionele')];head=re.sub(r'subtitel: ".*?",','subtitel: "Rond week 13 · Wetenschappelijke illustratie op één slide · 6 minuten",',head)
body=s[s.index('Tijdens de workshop heb je kennisgemaakt'):]
body=body.replace('verschillende technieken en programma\u0027s, zoals Inkscape,','technieken en programma\u0027s, zoals Inkscape,')
body=re.sub(r'^== \d\. ', '= ',body,flags=re.M).replace('=== Eén slide met onderschrift','== Eén slide met onderschrift')
body=body.replace('Het is niet de bedoeling om je volledige stageproject te presenteren. *Je doel is om één technisch onderwerp zo helder te visualiseren dat een medestudent begrijpt hoe het werkt en waarom het relevant is.*','*Visualiseer één technisch onderwerp zo helder dat een medestudent begrijpt hoe het werkt en waarom het relevant is.* Een overzicht van het volledige stageproject is niet nodig.')
body=body.replace('= Vormgeving en technische uitwerking','// Begin de uitwerking op een nieuwe pagina.\n#pagebreak()\n\n= Vormgeving en technische uitwerking')
body=body.replace('Planning en inleverafspraken volgen','Planning en inleverafspraken volgen.')
p.write_text(head+body,encoding='utf-8')
p=folder/'Rubriek_Presentatie2.typ';s=p.read_text(encoding='utf-8').replace('circa 8 minuten','6 minuten').replace('de 8 minuten','de 6 minuten').replace('ongeveer 8 minuten','6 minuten')
s=s.replace('Digitale visual op één slide','Wetenschappelijke illustratie op één slide')
s=s.replace('*1. Inhoud en samenhang visual*','*1. Technische inhoud en samenhang*').replace('*2. Professionele vormgeving*','*2. Vormgeving en visuele communicatie*').replace('*4. Onderschrift en bronnen*','*4. Onderschrift en bronvermelding*')
s=s.replace('Digitaal gemaakt, op één slide; leesrichting, hiërarchie, consistentie','Eigen digitale illustratie, op één slide; leesrichting, hiërarchie, consistentie')
s=s.replace('De digitale visual vormt op één slide een verzorgd geheel.','De eigen digitale illustratie vormt op één slide een verzorgd geheel.')
s=s.replace('De visual is digitaal gemaakt en staat met titel, onderschrift en bronnen','De eigen digitale illustratie staat met titel, onderschrift en bronnen')
s=s.replace('begrippen. De kernboodschap is herkenbaar en de presentatie duurt\n    6 minuten.','begrippen die specifiek zijn voor het project. De kernboodschap is herkenbaar\n    en de presentatie duurt 6 minuten.')
s=s.replace('kernboodschap en vervolgstap, binnen 6 minuten.','kernboodschap en eventuele beperking of vervolgstap, in 6 minuten.')
p.write_text(s,encoding='utf-8')
for name in ['Presentatie2','Rubriek_Presentatie2']:
 p=folder/(name+'.typ');out=Path('tmp/controle')/(name+'-workshop.pdf');out.write_bytes(typst.compile(str(p),root=str(Path.cwd())));print(name,len(PdfReader(out).pages))
 imgs=typst.compile(str(p),root=str(Path.cwd()),format='png',ppi=85)
 if isinstance(imgs,bytes):imgs=[imgs]
 for i,b in enumerate(imgs):Path(f'tmp/controle/{name}-workshop-{i+1}.png').write_bytes(b)

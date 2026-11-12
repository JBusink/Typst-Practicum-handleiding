from pathlib import Path
import re, json, os
root=Path.cwd()
template=root/'Template Professional Development/template.typ'
def header(p,title,subtitle=None,rubric=False,compact=False):
 rel=os.path.relpath(template,p.parent).replace('\\','/')
 args=[f'  titel: {json.dumps(title,ensure_ascii=False)},',f'  documenttype: "'+('Beoordelingsformulier' if rubric else 'Opdrachtbeschrijving')+'",']
 if subtitle: args += [f'  subtitel: {json.dumps(subtitle,ensure_ascii=False)},']
 if rubric: args += ['  liggend: true,','  tekstgrootte: 8.5pt,','  marges: 15mm,']
 if compact: args += ['  compact: true,','  tekstgrootte: 10.5pt,','  marges: (x: 22mm, y: 18mm),']
 return f'#import "{rel}": professional-development, kader, invulveld\n\n#show: professional-development.with(\n'+ '\n'.join(args)+'\n)\n\n'
changed=[]
for p in sorted(Path('2026-2027').rglob('*.typ')):
 if '_V2' in p.stem or '_V3' in p.stem: continue
 s=p.read_text(encoding='utf-8')
 if p.stem in ['memo1','memo2']:
  title='Memo '+p.stem[-1]+' - Technische Stage'
  body=s[s.index('#heading(level: 2'):]
  p.write_text(header(p,title)+body,encoding='utf-8')
 elif p.stem in ['Presentatie1','Presentatie2']:
  n=p.stem[-1]
  if n=='1':
   sub=re.search(r'#text\(size: 14pt\)\[(.*?)\]',s).group(1)
   body=s[s.index('= Opdracht'):]
  else:
   sub=re.search(r'#text\(size: 15pt\)\[(.*?)\]',s).group(1)
   body=s[s.index('#block(width: 100%'):]
   body=re.sub(r'#block\(width: 100%, inset: 10pt, fill: luma\(95%\), radius: 3pt\)\[\s*\*De opdracht in het kort\*\s*\\', '#kader("De opdracht in het kort")[',body,count=1)
  p.write_text(header(p,'Presentatie '+n,sub,compact=True)+body,encoding='utf-8')
 elif 'Rubriek_Presentatie' in p.stem:
  title=re.search(r'#text\(size: 18pt, weight: "bold"\)\[(.*?)\]',s).group(1)
  sub=re.search(r'\n\\ (.*?)\n',s).group(1)
  body=s[s.index('#grid('):]
  body=re.sub(r'\bveld\(', 'invulveld(',body)
  p.write_text(header(p,title,sub,rubric=True)+body,encoding='utf-8')
 elif p.stem.startswith('Rubriek_memo'):
  title='Rubriek Memo '+p.stem[-1]
  body=s[s.index('#table('):]
  # Use the shared alternating row shading while preserving all criteria.
  body=body.replace('#table(', '#table(\n  fill: (x, y) => if y == 0 { luma(90%) } else if calc.odd(y) { luma(97%) },',1)
  p.write_text(header(p,title,rubric=True)+body,encoding='utf-8')
 elif p.stem=='Rubriek_poster':
  body=s[s.index('#let checkbox'):]
  body=re.sub(r'#heading\(level: 1, numbering: none\)\[\s*Rubriek Wetenschappelijke Poster\s*\]\s*','',body)
  p.write_text(header(p,'Rubriek Wetenschappelijke Poster',rubric=True)+body,encoding='utf-8')
 else: continue
 changed.append(str(p))
Path('tmp/controle/gemigreerd.json').write_text(json.dumps(changed),encoding='utf-8')
print('\n'.join(changed))

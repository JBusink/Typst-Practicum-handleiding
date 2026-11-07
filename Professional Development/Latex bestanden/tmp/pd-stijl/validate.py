import pathlib,zipfile,xml.etree.ElementTree as E,re,hashlib,json,posixpath
ns={'a':'http://schemas.openxmlformats.org/drawingml/2006/main','p':'http://schemas.openxmlformats.org/presentationml/2006/main'}
reports=[]
for p in pathlib.Path('Nieuw_format_2026-2027').rglob('*_2026-2027.pptx'):
 src=p.with_name(p.name.replace('_2026-2027',''));a=zipfile.ZipFile(src);b=zipfile.ZipFile(p)
 slides=lambda z:sorted([n for n in z.namelist() if re.match(r'ppt/slides/slide\d+.xml$',n)],key=lambda n:int(re.search(r'(\d+)\.xml',n)[1]))
 sa,sb=slides(a),slides(b);assert len(sa)==len(sb)
 for na,nb in zip(sa[1:],sb[1:]):
  tx=lambda z,n:[t.text for s in E.fromstring(z.read(n)).findall('.//p:sp',ns) if (s.find('p:nvSpPr/p:nvPr/p:ph',ns) is None or s.find('p:nvSpPr/p:nvPr/p:ph',ns).get('type')!='sldNum') for t in s.findall('.//a:t',ns) if t.text]
  assert tx(a,na)==tx(b,nb),(p,na)
 ha={hashlib.sha256(a.read(n)).hexdigest() for n in a.namelist() if n.startswith('ppt/media/')};hb={hashlib.sha256(b.read(n)).hexdigest() for n in b.namelist() if n.startswith('ppt/media/')}
 missing=[n for n in a.namelist() if n.startswith('ppt/media/') and hashlib.sha256(a.read(n)).hexdigest() not in hb]
 # Office removes redundant PNG fallbacks of retained SVG originals and the old logo.
 fallbacks=set()
 for sn in sa:
  rn=posixpath.join(posixpath.dirname(sn),'_rels',posixpath.basename(sn)+'.rels')
  rel={r.get('Id'):posixpath.normpath(posixpath.join('ppt/slides',r.get('Target'))) for r in E.fromstring(a.read(rn))}
  for blip in E.fromstring(a.read(sn)).findall('.//a:blip',ns):
   embeds=[e.get('{http://schemas.openxmlformats.org/officeDocument/2006/relationships}embed') for e in blip.iter()]
   paths=[rel[v] for v in embeds if v in rel]
   if any(v.endswith('.svg') and hashlib.sha256(a.read(v)).hexdigest() in hb for v in paths):fallbacks.update(v for v in paths if v.endswith('.png'))
 allowed=[n for n in missing if n.endswith('.emf') or n in fallbacks]
 assert set(missing)==set(allowed),(p,missing)
 errors=[]
 for n in b.namelist():
  if n.endswith('.xml') or n.endswith('.rels'):E.fromstring(b.read(n))
  if n.endswith('.rels'):
   for r in E.fromstring(b.read(n)):
    if r.get('TargetMode')=='External':continue
    parent=posixpath.dirname(posixpath.dirname(n)) if n!='_rels/.rels' else ''
    target=posixpath.normpath(posixpath.join(parent,r.get('Target'))).lstrip('/')
    if target not in b.namelist():errors.append((n,target))
 assert not errors,errors
 reports.append({'file':str(p),'slides':len(sb),'content_preserved':True,'original_visual_assets_preserved':True,'package_relationships_valid':True})
print(json.dumps(reports,indent=2));pathlib.Path('tmp/pd-stijl/validation.json').write_text(json.dumps(reports,indent=2))



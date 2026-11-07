import pathlib,zipfile,xml.etree.ElementTree as E,posixpath,hashlib,json,re
ns={'a':'http://schemas.openxmlformats.org/drawingml/2006/main','p':'http://schemas.openxmlformats.org/presentationml/2006/main','r':'http://schemas.openxmlformats.org/officeDocument/2006/relationships'}
results=[]
for f in pathlib.Path('Nieuw_format_2026-2027').rglob('*_v2.pptx'):
 z=zipfile.ZipFile(f);src=zipfile.ZipFile(f.with_name(f.name.replace('_2026-2027_v2','')))
 slides=[n for n in z.namelist() if re.match(r'ppt/slides/slide\d+.xml$',n)]
 assert len(slides)==len([n for n in src.namelist() if re.match(r'ppt/slides/slide\d+.xml$',n)])
 for n in z.namelist():
  if n.endswith(('.xml','.rels')): E.fromstring(z.read(n))
  if n.startswith('ppt/media/'): assert z.read(n)==src.read(n)
  if n.endswith('.rels'):
   for rel in E.fromstring(z.read(n)):
    if rel.get('TargetMode')=='External':continue
    parent=posixpath.dirname(posixpath.dirname(n)) if n!='_rels/.rels' else ''
    target=posixpath.normpath(posixpath.join(parent,rel.get('Target'))).lstrip('/')
    assert target in z.namelist(),(n,target)
 for n in slides:
  r=E.fromstring(z.read(n));ids=[e.get('id') for e in r.findall('.//p:cNvPr',ns)];assert len(ids)==len(set(ids)),(f,n,'duplicate IDs')
  rp='ppt/slides/_rels/'+posixpath.basename(n)+'.rels';rels={e.get('Id') for e in E.fromstring(z.read(rp))}
  for e in r.iter():
   for key,value in e.attrib.items():
    if key.startswith('{'+ns['r']+'}'):assert value in rels,(n,value)
 results.append({'file':str(f),'slides':len(slides),'package_valid':True,'all_original_media_bytes_preserved':True})
pathlib.Path('tmp/pd-stijl/v2-validation.json').write_text(json.dumps(results,indent=2));print(json.dumps(results,indent=2))

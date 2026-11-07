import pathlib,zipfile,xml.etree.ElementTree as E,io
ns={'a':'http://schemas.openxmlformats.org/drawingml/2006/main','p':'http://schemas.openxmlformats.org/presentationml/2006/main'}
for path in pathlib.Path('Nieuw_format_2026-2027').rglob('*_2026-2027.pptx'):
 z=zipfile.ZipFile(path);data={n:z.read(n) for n in z.namelist()};z.close()
 for n in data:
  if not __import__('re').match(r'ppt/slides/slide\d+.xml$',n):continue
  [E.register_namespace(prefix, uri) for _,(prefix,uri) in E.iterparse(io.BytesIO(data[n]),events=['start-ns']) if prefix != 'xml']
  rt=E.fromstring(data[n])
  for s in rt.findall('.//p:sp',ns):
   t=''.join(t.text or '' for t in s.findall('.//a:t',ns))
   if n=='ppt/slides/slide1.xml' and t.startswith('Woensdag'):
    s.find('p:spPr/a:xfrm/a:off',ns).set('y',str(210*12700))
   ph=s.find('p:nvSpPr/p:nvPr/p:ph',ns)
   if n!='ppt/slides/slide1.xml' and ph is not None and ph.get('type') in ['title','ctrTitle']:
    b=s.find('p:txBody/a:bodyPr',ns)
    for k,v in {'lIns':'91440','rIns':'91440','tIns':'45720','bIns':'45720','anchor':'t','anchorCtr':'0'}.items():b.set(k,v)
    for p in s.findall('p:txBody/a:p',ns):
     pp=p.find('a:pPr',ns)
     if pp is None:pp=E.Element('{'+ns['a']+'}pPr');p.insert(0,pp)
     for tag in ['spcBef','spcAft','lnSpc']:
      old=pp.find('a:'+tag,ns)
      if old is not None:pp.remove(old)
      el=E.SubElement(pp,'{'+ns['a']+'}'+tag)
      E.SubElement(el,'{'+ns['a']+'}'+('spcPct' if tag=='lnSpc' else 'spcPts'),val='100000' if tag=='lnSpc' else '0')
  data[n]=E.tostring(rt,xml_declaration=True,encoding='UTF-8')
 with zipfile.ZipFile(path,'w',zipfile.ZIP_DEFLATED) as out:
  for n,b in data.items():out.writestr(n,b)
 print(path)


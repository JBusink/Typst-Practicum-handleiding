import pathlib,zipfile,xml.etree.ElementTree as E,io
A='http://schemas.openxmlformats.org/drawingml/2006/main';P='http://schemas.openxmlformats.org/presentationml/2006/main';ns={'a':A,'p':P}
for f in pathlib.Path('Nieuw_format_2026-2027').rglob('*_2026-2027.pptx'):
 targets={22:6} if f.name.startswith('Experimentele') else ({10:6,11:8,12:6} if f.name.startswith('Figuren') else {13:4})
 z=zipfile.ZipFile(f);d={n:z.read(n) for n in z.namelist()};z.close()
 for slide,sid in targets.items():
  n=f'ppt/slides/slide{slide}.xml'
  for _,(pr,uri) in E.iterparse(io.BytesIO(d[n]),events=['start-ns']):
   if pr!='xml':E.register_namespace(pr,uri)
  rt=E.fromstring(d[n]);s=next(s for s in rt.findall('.//p:sp',ns) if s.find('p:nvSpPr/p:cNvPr',ns).get('id')==str(sid))
  xf=s.find('p:spPr/a:xfrm',ns);xf.find('a:off',ns).attrib.update(x='445770',y='240030');xf.find('a:ext',ns).attrib.update(cx='8255000',cy='825500')
  bp=s.find('p:txBody/a:bodyPr',ns);bp.attrib.update(lIns='91440',rIns='91440',tIns='45720',bIns='45720',anchor='t',wrap='square')
  for r in s.findall('.//a:r',ns):
   rp=r.find('a:rPr',ns)
   if rp is None:rp=E.Element('{'+A+'}rPr');r.insert(0,rp)
   rp.attrib.update(sz='2100',b='1')
   for tag in ['solidFill','latin']:
    old=rp.find('a:'+tag,ns)
    if old is not None:rp.remove(old)
   E.SubElement(E.SubElement(rp,'{'+A+'}solidFill'),'{'+A+'}srgbClr',val='1E263A');E.SubElement(rp,'{'+A+'}latin',typeface='Calibri')
  d[n]=E.tostring(rt,encoding='UTF-8',xml_declaration=True)
 with zipfile.ZipFile(f,'w',zipfile.ZIP_DEFLATED) as out:
  for n,b in d.items():out.writestr(n,b)
 print(f.name,targets)

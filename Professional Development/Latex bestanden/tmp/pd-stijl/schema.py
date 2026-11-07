import pathlib,zipfile,xml.etree.ElementTree as E,io,re
A='http://schemas.openxmlformats.org/drawingml/2006/main'
orders={'rPr':'ln noFill solidFill gradFill blipFill pattFill grpFill effectLst effectDag highlight uLnTx uLn uFillTx uFill latin ea cs sym hlinkClick hlinkMouseOver rtl extLst'.split(),'pPr':'lnSpc spcBef spcAft buClrTx buClr buSzTx buSzPct buSzPts buFontTx buFont buNone buAutoNum buChar buBlip tabLst defRPr extLst'.split()}
for f in pathlib.Path('Nieuw_format_2026-2027').rglob('*_2026-2027.pptx'):
 z=zipfile.ZipFile(f);d={n:z.read(n) for n in z.namelist()};z.close()
 for n in d:
  if not re.match(r'ppt/slides/slide\d+.xml$',n):continue
  for _,(p,u) in E.iterparse(io.BytesIO(d[n]),events=['start-ns']):
   if p!='xml':E.register_namespace(p,u)
  rt=E.fromstring(d[n])
  for tag,order in orders.items():
   for el in rt.iter('{'+A+'}'+tag):el[:]=sorted(el,key=lambda c:order.index(c.tag.split('}')[-1]) if c.tag.split('}')[-1] in order else 999)
  d[n]=E.tostring(rt,encoding='UTF-8',xml_declaration=True)
 with zipfile.ZipFile(f,'w',zipfile.ZIP_DEFLATED) as o:
  for n,b in d.items():o.writestr(n,b)

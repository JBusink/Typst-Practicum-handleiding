from pathlib import Path
import json
p=Path('Template Professional Development/template.typ');s=p.read_text(encoding='utf-8')
s=s.replace('marges: none','marges: (x: 16mm, top: 16mm, bottom: 18mm)')
s=s.replace('font: ("New Computer Modern", "Libertinus Serif")','font: ("Arial", "Liberation Sans")')
s=s.replace('  set par(justify: not liggend, first-line-indent: 0pt, leading: 0.45em, spacing: 0.55em)','  let inkt = black\n  set par(justify: false, leading: 0.5em, spacing: if liggend { 0.5em } else { 0.7em })')
s=s.replace('margin: if marges != none { marges } else if liggend { 15mm } else { (x: 20mm, y: 25mm) },','margin: marges,')
s=s.replace('below: 2.5mm','below: 2.3mm').replace('if liggend { 12pt } else { 14.4pt }','if it.level == 1 { 13pt } else { 11.5pt }')
s=s.replace('set list(indent: if liggend { 10pt } else { 1.5cm }, body-indent: 0.5em, spacing: 2pt)','set list(indent: 12pt, body-indent: 5pt, spacing: if liggend { 3pt } else { 4pt })')
s=s.replace('set enum(indent: if liggend { 10pt } else { 1.5cm }, body-indent: 0.5em, spacing: 2pt)','set enum(indent: 12pt, body-indent: 5pt, spacing: if liggend { 3pt } else { 4pt })')
a=s.index('  // Artikelstijl:');b=s.index('  body\n}',a)
s=s[:a]+'''  text(size: 8pt, fill: black)[
    #opleiding · Professional Development · #studiejaar
  ]
  v(3mm)
  text(size: if liggend { 20pt } else { 25pt }, weight: "bold", fill: inkt, titel)
  if subtitel != none {
    v(2mm)
    text(size: if liggend { 10pt } else { 13pt }, fill: inkt, subtitel)
  }
  v(2mm)
  if not liggend { text(size: 9pt, fill: black)[
    #documenttype
    #if auteur != none [ · #auteur]
    #if datum != none [ · #if type(datum) == datetime {
      datum.display("[day]-[month]-[year]")
    } else { datum }]
  ] }
  v(3mm)
  line(length: 100%, stroke: 0.7pt + black)
  v(if liggend { 4mm } else { 5mm })
'''+s[b:]
s=s.replace('width: 100%, above: 0pt, below: 3mm,','width: 100%, inset: 10pt, fill: white, stroke: 0.5pt + black, radius: 3pt,')
p.write_text(s,encoding='utf-8')
for filename in json.loads(Path('tmp/controle/gemigreerd.json').read_text()):
 p=Path(filename);s=p.read_text(encoding='utf-8')
 if 'liggend: true' in s:
  s=s.replace('tekstgrootte: 9pt,','tekstgrootte: 8.5pt,\n  marges: (x: 12mm, top: 12mm, bottom: 15mm),')
 else:
  at=s.index('\n)',s.index('#show:'))
  settings='  tekstgrootte: '+('10.5pt' if p.stem.startswith('memo') else '11pt')+',\n  marges: '+('(x: 14mm, top: 14mm, bottom: 16mm)' if p.stem.startswith('memo') else '(x: 16mm, top: 16mm, bottom: 18mm)')+',\n'
  s=s[:at]+'\n'+settings+s[at:]
 if p.stem=='memo1':
  needle='#heading(level: 2, numbering: none)[\n  Opstelling en eerste resultaten'
  s=s.replace(needle,'// Houd de complete sectie bij elkaar op de vervolgpagina.\n#pagebreak()\n\n'+needle)
 p.write_text(s,encoding='utf-8')

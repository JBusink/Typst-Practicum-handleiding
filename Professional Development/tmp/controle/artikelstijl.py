from pathlib import Path
p=Path('Template Professional Development/template.typ');s=p.read_text(encoding='utf-8')
s=s.replace('marges: (x: 16mm, top: 16mm, bottom: 18mm)','marges: none')
s=s.replace('font: ("Arial", "Liberation Sans")','font: ("New Computer Modern", "Libertinus Serif")')
s=s.replace('  let inkt = black\n','')
s=s.replace('set par(justify: false, leading: 0.5em, spacing: if liggend { 0.5em } else { 0.7em })','set par(justify: not liggend, first-line-indent: 0pt, leading: 0.45em, spacing: 0.55em)')
s=s.replace('margin: marges,','margin: if marges != none { marges } else if liggend { 15mm } else { (x: 20mm, y: 25mm) },')
s=s.replace('below: 2.3mm','below: 2.5mm').replace('if it.level == 1 { 13pt } else { 11.5pt }','if liggend { 12pt } else { 14.4pt }').replace('fill: inkt','fill: black')
s=s.replace('set list(indent: 12pt, body-indent: 5pt, spacing: if liggend { 3pt } else { 4pt })','set list(indent: if liggend { 10pt } else { 1.5cm }, body-indent: 0.5em, spacing: 2pt)')
s=s.replace('set enum(indent: 12pt, body-indent: 5pt, spacing: if liggend { 3pt } else { 4pt })','set enum(indent: if liggend { 10pt } else { 1.5cm }, body-indent: 0.5em, spacing: 2pt)')
a=s.index('  text(size: 8pt, fill: black)[\n    #opleiding')
b=s.index('  body\n}',a)
s=s[:a]+'''  // Artikelstijl: een sobere titel, zonder banner, kader of scheidingslijn.
  block(below: 5mm)[
    #text(size: 17.28pt, weight: "bold", titel)
    #if subtitel != none {
      v(2mm)
      text(size: 11pt, subtitel)
    }
    #if auteur != none or datum != none {
      v(2mm)
      text(size: 10pt)[
        #if auteur != none { auteur }
        #if auteur != none and datum != none [ · ]
        #if datum != none {
          if type(datum) == datetime { datum.display("[day]-[month]-[year]") } else { datum }
        }
      ]
    }
  ]
'''+s[b:]
s=s.replace('width: 100%, inset: 10pt, fill: white, stroke: 0.5pt + black, radius: 3pt,','width: 100%, above: 0pt, below: 3mm,')
p.write_text(s,encoding='utf-8')
import json,re
for filename in json.loads(Path('tmp/controle/gemigreerd.json').read_text()):
 p=Path(filename);s=p.read_text(encoding='utf-8')
 s=re.sub(r'^  marges: .*\n','',s,flags=re.M)
 s=re.sub(r'  tekstgrootte: (?:10.5|11)pt,\n','',s)
 s=s.replace('tekstgrootte: 8.5pt','tekstgrootte: 9pt')
 s=s.replace('// Houd de complete sectie bij elkaar op de vervolgpagina.\n#pagebreak()\n\n','')
 p.write_text(s,encoding='utf-8')

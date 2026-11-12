from pathlib import Path
p=Path('Template Professional Development/template.typ')
src=Path('C:/Users/jbusink1/.codex/attachments/10ffd867-6c33-4266-bc88-1ca7540bf86a/Pasted text.txt').read_text(encoding='utf-8')
date=src[src.index('#let nederlandse-datum'):src.index('// Centrale lijststijl')]
lists=src[src.index('#let template(body)'):src.index('#let stijl(')].replace('#let template(body)', '#let lijststijl(body)')
head='''// Gebaseerd op de aangeleverde practicum-styl.typ.
// Alleen de gebruikte document-, lijst-, tabel- en kaderopmaak is overgenomen.
// Alle tekst en lijnen blijven zwart; achtergronden blijven wit.
'''
body='''#let professional-development(
  titel: "Professional Development",
  subtitel: none,
  documenttype: "Opdrachtbeschrijving",
  opleiding: "Technische Natuurkunde",
  studiejaar: "2026-2027",
  auteur: none,
  datum: datetime.today(),
  liggend: false,
  tekstgrootte: 11pt,
  marges: none,
  body,
) = {
  set document(title: titel, author: if auteur == none { () } else { auteur })
  set text(
    font: ("TeX Gyre Heros", "Helvetica", "Arial", "Liberation Sans"),
    size: tekstgrootte, lang: "nl", fill: black,
  )
  set page(
    paper: "a4", flipped: liggend,
    margin: if marges != none { marges } else if liggend { 15mm } else {
      (top: 32mm, bottom: 32mm, left: 20mm, right: 20mm)
    },
    header: [
      #align(center, text(size: 9pt)[Professional Development])
      #v(2mm)
      #line(length: 100%, stroke: 0.4pt + black)
    ],
    header-ascent: 3mm,
    footer-descent: 6mm,
    footer: context {
      set text(size: 9pt)
      grid(
        columns: (1fr, auto, 1fr),
        align: (left, center, right),
        [], [
          #if datum != none {
            if type(datum) == datetime { nederlandse-datum(datum) } else { datum }
            [ — ]
          }
          #studiejaar — #opleiding
        ],
        counter(page).display("1"),
      )
    },
  )
  set par(first-line-indent: 0pt, justify: true, leading: 0.45em, spacing: 0.55em)
  show: lijststijl
  set heading(numbering: none, outlined: false)
  show heading.where(level: 1): set text(size: 16pt)
  show heading.where(level: 2): set text(size: 13pt)
  // De rubrieken bevatten uitsluitend tekst: linksboven uitlijnen voorkomt
  // onnatuurlijke woordspaties in de smalle beoordelingskolommen.
  show table: it => block(breakable: false)[
    #set text(size: 9pt)
    #set par(justify: false)
    #it
  ]
  set table(
    align: left + top,
    inset: (x: 6pt, y: 4pt),
    stroke: 0.4pt + black,
    fill: white,
  )
  show table.cell.where(y: 0): strong

  align(center)[
    #text(size: 20pt, weight: "bold", titel)
    #if subtitel != none {
      v(2mm)
      text(size: 11pt, subtitel)
    }
    #if auteur != none {
      v(2mm)
      text(size: 10pt, auteur)
    }
  ]
  v(5mm)
  body
}

// Alleen het gebruikte opdrachtkader, zonder ongebruikte kleurvarianten.
#let kader(titel, body) = block(
  width: 100%, breakable: true,
  fill: white, stroke: 0.8pt + black,
  radius: 0pt, inset: (x: 0.8em, y: 0.7em),
  above: 1.4em, below: 1.4em,
)[*#titel* #parbreak() #body]

// Nodig voor de bestaande beoordelingsformulieren; printbaar, niet interactief.
#let invulveld(label, hoogte: 10mm) = block(
  width: 100%, height: hoogte, inset: 5pt, stroke: 0.4pt + black,
)[#text(size: 9pt, weight: "bold", label)]

#let rubriektabel(..cellen) = table(
  columns: (1.6fr, 2.1fr, 2.1fr, 2.1fr, 1fr),
  table.header(
    [*Onderdeel*], [*Goed*], [*Voldoende*], [*Onvoldoende*], [*Score*],
  ),
  ..cellen.pos(),
)
'''
p.write_text(head+date+lists+body,encoding='utf-8')
import json,re
for filename in json.loads(Path('tmp/controle/gemigreerd.json').read_text()):
 p=Path(filename);s=p.read_text(encoding='utf-8')
 s=re.sub(r'^  marges: .*\n','',s,flags=re.M)
 s=re.sub(r'^  tekstgrootte: .*\n','',s,flags=re.M)
 if 'liggend: true' in s:s=s.replace('  liggend: true,','  liggend: true,\n  tekstgrootte: 9pt,')
 s=s.replace('// Houd de complete sectie bij elkaar op de vervolgpagina.\n#pagebreak()\n\n','')
 s=s.replace(',\n\n)',',\n)')
 p.write_text(s,encoding='utf-8')

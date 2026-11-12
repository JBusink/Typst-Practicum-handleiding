from pathlib import Path
p=Path('2026-2027/Presentaties/presentatie2/Rubriek_Presentatie2.typ')
s='''#import "../../../Template Professional Development/template.typ": professional-development

#show: professional-development.with(
  titel: "Rubriek Presentatie 2",
  subtitel: "Rond week 13 · Wetenschappelijke illustratie op één slide · 6 minuten",
  documenttype: "Beoordelingsformulier",
  liggend: true,
  tekstgrootte: 9pt,
  toon-header: false,
  titelruimte: 1mm,
)

// Printbare vakjes; per subcriterium wordt één niveau aangekruist.
#let niveau(body) = grid(
  columns: (8pt, 1fr), column-gutter: 5pt, align: left + top,
  box(width: 7.5pt, height: 7.5pt, stroke: 0.6pt + black), body,
)
#let invullijn(label, hoogte: 10mm) = block(width: 100%, height: hoogte)[
  #text(size: 9pt, weight: "bold", label)
  #v(1fr)
  #line(length: 100%, stroke: 0.35pt + black)
]
#let onderdeel(titel, weging) = table.cell(colspan: 4, inset: (x: 6pt, y: 7pt))[
  *#titel* #h(0.7em) _Weging: #weging%_
  #h(1fr) *Score: ........ / 10*
]
#let criterium(titel, uitstekend, voldoende, onvoldoende) = (
  [*#titel*], niveau(uitstekend), niveau(voldoende), niveau(onvoldoende),
)
#let beoordeling(..rijen) = table(
  columns: (23%, 26%, 26%, 25%),
  inset: (x: 6pt, y: 6pt),
  stroke: (x: none, y: 0.3pt + black),
  table.hline(y: 0, stroke: 0.8pt + black),
  table.header(
    [*Subcriterium*], [*Uitstekend (8–10)*],
    [*Voldoende (6–7)*], [*Onvoldoende (1–5)*],
  ),
  table.hline(y: 1, stroke: 0.5pt + black),
  ..rijen.pos(),
  table.hline(stroke: 0.8pt + black),
)

#grid(columns: (1.5fr, 1fr, 1fr), gutter: 3mm,
  invullijn("Student / studentnummer:"),
  invullijn("Beoordelaar:"),
  invullijn("Datum / gekozen onderwerp:"),
)
*Gebruik:* kruis per subcriterium één niveau aan. Geef op basis daarvan per
hoofdonderdeel een score van 1 tot 10; onderbouw de keuze met feedback op
pagina 2. De vakjes ondersteunen de beoordeling en leveren geen losse punten op.
Een projectoverzicht of onderzoeksresultaten zijn niet vereist.

#beoordeling(
  onderdeel("1. Technische inhoud en samenhang", 30),
  ..criterium([1.1 Afbakening en context],
    [Eén scherp afgebakend technisch onderwerp; functie binnen de stage direct duidelijk.],
    [Onderwerp afgebakend; functie binnen de stage voldoende duidelijk.],
    [Onderwerp te breed of onduidelijk; functie binnen de stage niet herkenbaar.]),
  ..criterium([1.2 Technische werking en relaties],
    [Werking en relevante fysische principes correct; relaties tussen onderdelen helder zichtbaar.],
    [Werking grotendeels correct; belangrijkste onderdelen en relaties herkenbaar.],
    [Essentiële technische fouten of ontbrekende onderdelen; werking blijft onduidelijk.]),
  ..criterium([1.3 Technische kernboodschap],
    [Belangrijkste technische inzicht en relevantie direct herkenbaar in de illustratie.],
    [Technisch inzicht herkenbaar, maar vraagt enige mondelinge toelichting.],
    [Geen duidelijke technische kernboodschap of onvoldoende verband met het onderwerp.]),

  onderdeel("2. Vormgeving en visuele communicatie", 30),
  ..criterium([2.1 Eigen digitale illustratie; één slide],
    [Eigen digitaal uitgewerkte illustratie; titel, onderschrift en eventuele bronnen vormen één geheel op één slide.],
    [Eigen digitale illustratie met titel, onderschrift en eventuele bronnen op één slide.],
    [Geen eigen digitale uitwerking, of presentatie verspreid over meerdere slides.]),
  ..criterium([2.2 Visuele structuur en selectie],
    [Heldere leesrichting en hiërarchie; visuele elementen verklaren de werking zonder overbodige details.],
    [Logische indeling en herkenbare verbanden; weinig overbodige tekst of details.],
    [Rommelige of onduidelijke structuur; tekstblokken of details overheersen de illustratie.]),
  ..criterium([2.3 Consistentie en technische notatie],
    [Symbolen, lijnen en typografie consequent; grootheden, eenheden en benamingen correct waar relevant.],
    [Vormgeving grotendeels consistent; notatie correct met kleine onvolkomenheden.],
    [Inconsistente vormgeving of ontbrekende of onjuiste essentiële labels, symbolen of eenheden.]),
  ..criterium([2.4 Leesbaarheid op schermformaat],
    [Alle relevante details en labels duidelijk leesbaar; deelfiguren en eventuele grafieken doelgericht gekozen.],
    [Belangrijkste onderdelen en labels leesbaar; eventuele grafieken voldoende begrijpelijk.],
    [Essentiële onderdelen, labels of eventuele grafieken onvoldoende leesbaar of begrijpelijk.]),
)

#pagebreak()
#text(size: 13pt, weight: "bold")[Rubriek Presentatie 2 — vervolg]
#v(2mm)
*Student:* ...........................................................
#h(1fr) *Onderwerp:* ...........................................................
#v(2mm)

#beoordeling(
  onderdeel("3. Mondelinge uitleg en tijdgebruik", 20),
  ..criterium([3.1 Verhaallijn en gebruik van de visual],
    [Goed voorbereide uitleg; gerichte verwijzingen naar de illustratie; heldere afsluitende kernboodschap.],
    [Logische uitleg die de illustratie benut; kernboodschap herkenbaar.],
    [Uitleg moeilijk te volgen of nauwelijks verbonden met de illustratie; kernboodschap ontbreekt.]),
  ..criterium([3.2 Aansluiting bij medestudenten],
    [Projectspecifieke begrippen helder verklaard; uitleg sluit doelgericht aan op natuurkundige basiskennis.],
    [Belangrijke projectspecifieke begrippen uitgelegd; verhaal begrijpelijk voor medestudenten.],
    [Jargon of onverklaarde technieken belemmeren het begrip bij medestudenten.]),
  ..criterium([3.3 Tijdgebruik: 6 minuten],
    [Evenwichtige verdeling tussen context, technische uitleg en kernboodschap; afgerond in circa 6 minuten.],
    [Presentatie duurt circa 6 minuten; verdeling tussen onderdelen kan beter.],
    [Duidelijk te kort of te lang, of essentiële uitleg wordt door gebrekkige planning afgebroken.]),

  onderdeel("4. Onderschrift en bronvermelding", 10),
  ..criterium([4.1 Zelfstandig begrijpelijk onderschrift],
    [Bondig onderschrift verklaart wat wordt getoond, symbolen, afkortingen en technische kernboodschap.],
    [Onderschrift verklaart de inhoud en belangrijkste symbolen en afkortingen; kleine onduidelijkheden.],
    [Onderschrift ontbreekt of geeft onvoldoende uitleg om de illustratie te begrijpen.]),
  ..criterium([4.2 Herkomst van materiaal],
    [Bronnen zorgvuldig vermeld; eigen uitwerking en overgenomen of bewerkte onderdelen duidelijk onderscheiden.],
    [Noodzakelijke bronnen vermeld; herkomst van gebruikt materiaal voldoende duidelijk.],
    [Noodzakelijke bronvermeldingen ontbreken of overgenomen materiaal wordt als eigen werk gepresenteerd.]),

  onderdeel("5. Beantwoording van vragen", 10),
  ..criterium([5.1 Technisch inzicht en onderbouwing],
    [Antwoorden correct; technische werking en gemaakte keuzes overtuigend onderbouwd.],
    [Belangrijkste vragen correct beantwoord; werking en technische keuzes voldoende toegelicht.],
    [Essentiële vragen onjuist of onvoldoende beantwoord; werking of keuzes niet uit te leggen.]),
  ..criterium([5.2 Grenzen van kennis en aanpak],
    [Herkent aannames en beperkingen; benoemt gericht hoe open vragen kunnen worden onderzocht.],
    [Herkent belangrijke beperkingen en geeft eerlijk aan wat nog onbekend is.],
    [Herkent belangrijke beperkingen niet of presenteert onbekende zaken als vaststaand.]),
)
#v(2mm)
*Eindcijfer:* 0,3 × S1 + 0,3 × S2 + 0,2 × S3 + 0,1 × S4 + 0,1 × S5.
De vragenronde valt buiten de 6 minuten presentatietijd.
#grid(columns: (1fr, 1fr, 0.6fr), gutter: 3mm,
  invullijn("Sterke punten (met voorbeeld):", hoogte: 13mm),
  invullijn("Belangrijkste verbeteractie:", hoogte: 13mm),
  invullijn("Eindcijfer:", hoogte: 13mm),
)
'''
p.write_text(s,encoding='utf-8')
import typst
from pypdf import PdfReader
out=Path('tmp/controle/rubriek-presentatie2-vakjes.pdf');out.write_bytes(typst.compile(str(p),root=str(Path.cwd())));print('Paginas:',len(PdfReader(out).pages))
imgs=typst.compile(str(p),root=str(Path.cwd()),format='png',ppi=95)
if isinstance(imgs,bytes):imgs=[imgs]
for i,b in enumerate(imgs):Path(f'tmp/controle/rubriek-presentatie2-vakjes-{i+1}.png').write_bytes(b)

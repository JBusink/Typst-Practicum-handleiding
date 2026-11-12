from pathlib import Path
p=Path('2026-2027/Presentaties/presentatie2/Presentatie2.typ')
p.write_text('''#import "../../../Template Professional Development/template.typ": professional-development, kader

#show: professional-development.with(
  titel: "Presentatie 2",
  documenttype: "Opdrachtbeschrijving",
  subtitel: "Week 13 · Je technische stage in één overzichtsvisual · circa 8 minuten",
)

#kader("De opdracht in het kort")[
  Maak een professionele overzichtsvisual die de kern van je technische stage
  uitlegt. Gebruik deze als basis voor een presentatie van *ongeveer 8 minuten*
  rond *week 13*. Daarna beantwoord je vragen; de vragenronde staat los van
  de presentatietijd.
]

= Doel van de visual
Ontwerp een *TOC-graphic* of *graphical abstract*: een compacte visuele
samenvatting van je project. Een medestudent die jouw stage niet kent, moet
kunnen begrijpen welk probleem je onderzoekt, hoe je dit technisch aanpakt
en wat je tot nu toe hebt bereikt. Kies één duidelijke kernboodschap en
laat zien hoe de onderdelen van je project met elkaar samenhangen.

= Wat laat je zien?
Verbind in de visual de volgende onderdelen:
- *Aanleiding en doel:* welk probleem of welke behoefte staat centraal,
  en wat wil je met jouw stage bereiken?
- *Technische aanpak:* hoe werkt de technologie, opstelling of het model?
  Maak zichtbaar wat je instelt, meet, berekent of ontwerpt en waarom.
- *Tussenstand en betekenis:* toon een relevant tussenresultaat, inzicht of
  ontwerp en leg de relatie met het doel. Maak duidelijk wat al is aangetoond,
  wat voorlopig is en wat je nog gaat onderzoeken.

Afgeronde eindresultaten zijn in week 13 nog niet vereist. Ook een test,
ontwerpvergelijking of simulatie kan een relevant tussenresultaat zijn.

= Hoe maak je een professionele visual?
Gebruik één centrale dia met de overzichtsvisual. Deze mag uit samenhangende
deelfiguren bestaan, bijvoorbeeld een werkingsprincipe, een opstellingsschema
en een kleine resultaatgrafiek. Maak er één geheel van met een duidelijke
leesrichting, hiërarchie en functionele verbindingen.

- Selecteer wat nodig is voor de kernboodschap; vermijd tekstblokken en
  details die je uitleg niet ondersteunen.
- Gebruik consistente symbolen, lijnstijlen en labels. Zorg dat tekst en
  figuren op presentatieschermformaat leesbaar zijn, ook zonder kleur.
- Geef grootheden en eenheden aan waar relevant. Maak bij grafieken assen,
  datasets en de betekenis van eventuele foutbalken duidelijk.
- Voeg een beknopt onderschrift toe dat de samenhang en kernboodschap
  begrijpelijk maakt. Verklaar afkortingen en vermeld bronnen bij overgenomen
  of bewerkt materiaal. Houd rekening met vertrouwelijke bedrijfsinformatie.

= Presentatie en voorbereiding
Gebruik de visual als leidraad: wijs relevante onderdelen aan en leg hun
onderlinge relatie uit. Licht vaktermen toe en onderbouw technische keuzes.
Bereid vragen voor over het werkingsprincipe, je aanpak, de betekenis van
het tussenresultaat en relevante beperkingen. Geef aan wat je nog niet weet.

Oefen met een timer. Verdeel de 8 minuten bijvoorbeeld over *2 minuten
probleem en doel*, *3 minuten technische aanpak*, *2 minuten tussenstand en
betekenis* en *1 minuut kernboodschap en vervolgstap*.

= Beoordeling
De rubriek beoordeelt *inhoud en samenhang van de visual (30%)*,
*professionele vormgeving (30%)*, *mondelinge uitleg en tijdgebruik (20%)*,
*onderschrift en bronnen (10%)* en *beantwoording van vragen (10%)*.
Praktische afspraken over planning en inleveren volgen.
''',encoding='utf-8')
p=Path('2026-2027/Presentaties/presentatie2/Rubriek_Presentatie2.typ')
p.write_text('''#import "../../../Template Professional Development/template.typ": professional-development

#show: professional-development.with(
  titel: "Rubriek Presentatie 2",
  documenttype: "Beoordelingsformulier",
  subtitel: "Week 13 · Professionele overzichtsvisual · circa 8 minuten",
  liggend: true,
  tekstgrootte: 9pt,
  toon-header: false,
  titelruimte: 1mm,
)

#let invullijn(label, hoogte: 9mm) = block(width: 100%, height: hoogte)[
  #text(size: 9pt, weight: "bold", label)
  #v(1fr)
  #line(length: 100%, stroke: 0.35pt + black)
]

#grid(columns: (1.5fr, 1fr, 1fr), gutter: 3mm,
  invullijn("Student / studentnummer:"),
  invullijn("Beoordelaar:"),
  invullijn("Datum / stageproject:"),
)
*Werkwijze:* geef per onderdeel een score van 1 tot 10 en onderbouw de
beoordeling met concrete feedback. Beoordeel de tussenstand passend bij
week 13; eindresultaten zijn nog niet vereist. De vragenronde telt niet mee
in de 8 minuten.

#table(
  columns: (24%, 22%, 22%, 22%, 10%),
  inset: (x: 7pt, y: 5pt),
  stroke: none,
  table.hline(y: 0, stroke: 0.8pt + black),
  table.hline(y: 1, stroke: 0.5pt + black),
  table.hline(y: 2, stroke: 0.3pt + black),
  table.hline(y: 3, stroke: 0.3pt + black),
  table.hline(y: 4, stroke: 0.3pt + black),
  table.hline(y: 5, stroke: 0.3pt + black),
  table.hline(y: 6, stroke: 0.8pt + black),
  table.header([*Onderdeel*], [*Goed (8–10)*], [*Voldoende (6–7)*],
    [*Onvoldoende (1–5)*], [*Score*]),

  [*1. Inhoud en samenhang visual* \\ _Weging: 30%_

    Probleem, doel, technische aanpak en tussenstand; kernboodschap;
    technische correctheid.],
  [De visual verbindt probleem, doel, aanpak en tussenstand tot een technisch
    correct en zelfstandig begrijpelijk geheel. De kernboodschap en betekenis
    voor het stageproject zijn direct herkenbaar.],
  [De visual toont probleem, doel, aanpak en een relevante tussenstand
    grotendeels correct. Hun samenhang en de kernboodschap zijn herkenbaar,
    maar vragen enige mondelinge toelichting.],
  [Essentiële onderdelen of verbanden ontbreken of zijn technisch onjuist.
    De visual geeft onvoldoende inzicht in het stageproject of de status
    van het getoonde resultaat.],
  table.cell(align: center + horizon)[........ / 10],

  [*2. Professionele vormgeving* \\ _Weging: 30%_

    Leesrichting, hiërarchie, selectie, consistentie en leesbaarheid;
    correcte labels en eventuele grafieken.],
  [Een duidelijke visuele hiërarchie en leesrichting maken de samenhang
    direct zichtbaar. Labels, symbolen en lijnstijlen zijn consistent.
    Deelfiguren en eventuele grafieken zijn leesbaar, correct en doelgericht.],
  [De visual is op schermformaat leesbaar en overzichtelijk. Deelfiguren
    passen bij de boodschap. Labels, grootheden, eenheden en eventuele
    grafieken zijn grotendeels correct, met kleine onvolkomenheden.],
  [De visual is slecht leesbaar, onsamenhangend of overvol. Essentiële labels
    of eenheden ontbreken, of de weergave is misleidend. De vormgeving maakt
    de samenhang moeilijk te volgen.],
  table.cell(align: center + horizon)[........ / 10],

  [*3. Mondelinge uitleg en tijdgebruik* \\ _Weging: 20%_

    Logische verhaallijn; gerichte verwijzingen naar de visual;
    begrijpelijke uitleg; circa 8 minuten.],
  [Een goed voorbereide uitleg benut de visual doelgericht. Verbindt de
    onderdelen overtuigend, verklaart vaktermen en sluit af met een duidelijke
    kernboodschap en vervolgstap, binnen ongeveer 8 minuten.],
  [De uitleg is logisch te volgen, gebruikt de visual en verklaart belangrijke
    begrippen. De kernboodschap is herkenbaar en de presentatie duurt
    ongeveer 8 minuten.],
  [De uitleg is moeilijk te volgen of benut de visual nauwelijks. Belangrijke
    begrippen blijven onduidelijk; voorbereiding of tijdsbewaking schiet
    duidelijk tekort.],
  table.cell(align: center + horizon)[........ / 10],

  [*4. Onderschrift en bronnen* \\ _Weging: 10%_

    Samenhang en kernboodschap begrijpelijk; afkortingen verklaard;
    bronnen waar nodig.],
  [Een bondig onderschrift maakt de samenhang en kernboodschap zelfstandig
    begrijpelijk. Termen en afkortingen zijn verklaard en overgenomen of
    bewerkt materiaal is zorgvuldig verantwoord.],
  [Het onderschrift beschrijft de inhoud en belangrijkste samenhang.
    Essentiële afkortingen zijn verklaard en noodzakelijke bronnen zijn
    vermeld. Kleine onduidelijkheden blijven bestaan.],
  [Het onderschrift ontbreekt of verklaart de visual onvoldoende.
    Essentiële afkortingen blijven onduidelijk of noodzakelijke
    bronvermeldingen ontbreken.],
  table.cell(align: center + horizon)[........ / 10],

  [*5. Beantwoording van vragen* \\ _Weging: 10%_

    Inzicht in werkingsprincipe, technische keuzes, tussenresultaat
    en beperkingen.],
  [Beantwoordt vragen correct en onderbouwt keuzes en interpretaties met
    technische argumenten. Herkent aannames en beperkingen en benoemt hoe
    open vragen onderzocht kunnen worden.],
  [Beantwoordt de belangrijkste vragen correct en licht technische keuzes
    en het tussenresultaat toe. Herkent beperkingen en geeft aan wat nog
    onbekend is.],
  [Essentiële vragen worden onjuist of onvoldoende beantwoord. Technische
    keuzes of de betekenis van het tussenresultaat kunnen onvoldoende
    worden toegelicht.],
  table.cell(align: center + horizon)[........ / 10],
)
#v(2mm)
#grid(columns: (1fr, 1fr, 0.8fr), gutter: 3mm,
  invullijn("Sterk punt (met voorbeeld):", hoogte: 12mm),
  invullijn("Belangrijkste verbeteractie:", hoogte: 12mm),
  invullijn("Eindcijfer: 0,3 × S1 + 0,3 × S2 + 0,2 × S3 + 0,1 × S4 + 0,1 × S5", hoogte: 12mm),
)
''',encoding='utf-8')
import typst
from pypdf import PdfReader
for name in ['Presentatie2','Rubriek_Presentatie2']:
 p=Path('2026-2027/Presentaties/presentatie2')/(name+'.typ')
 out=Path('tmp/controle')/(name+'-week13.pdf');out.write_bytes(typst.compile(str(p),root=str(Path.cwd())));print(name,len(PdfReader(out).pages))
 imgs=typst.compile(str(p),root=str(Path.cwd()),format='png',ppi=95)
 if isinstance(imgs,bytes):imgs=[imgs]
 for i,b in enumerate(imgs):Path(f'tmp/controle/{name}-week13-{i+1}.png').write_bytes(b)

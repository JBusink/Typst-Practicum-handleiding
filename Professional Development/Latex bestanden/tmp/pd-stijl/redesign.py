import copy, io, json, pathlib, re, zipfile
import xml.etree.ElementTree as E

ROOT=pathlib.Path.cwd()
BASE=ROOT/'Nieuw_format_2026-2027'
REF=zipfile.ZipFile(BASE/'Bijeenkomst 2/Startbijeenkomst_PD_20262027.pptx')
A='http://schemas.openxmlformats.org/drawingml/2006/main'
P='http://schemas.openxmlformats.org/presentationml/2006/main'
R='http://schemas.openxmlformats.org/officeDocument/2006/relationships'
NS={'a':A,'p':P,'r':R}
def q(t): return '{'+(A if t.startswith('a:') else P)+'}'+t.split(':')[1]
def parse(b):
    for _,(prefix,uri) in E.iterparse(io.BytesIO(b),events=['start-ns']):
        if prefix!='xml': E.register_namespace(prefix,uri)
    return E.fromstring(b)
def refslide(n): return parse(REF.read(f'ppt/slides/slide{n}.xml'))
def shapeid(s):
    e=s.find('.//p:cNvPr',NS)
    return int(e.get('id')) if e is not None else -1
def findshape(rt,i):
    return next(s for s in rt.iter() if s.tag in [q('p:sp'),q('p:pic'),q('p:grpSp'),q('p:graphicFrame'),q('p:cxnSp')] and shapeid(s)==i)
TITLE=findshape(refslide(23),2)
SUB=findshape(refslide(23),3)
CARD=findshape(refslide(23),4)
FOOT=findshape(refslide(23),8)
SECTION=findshape(refslide(30),2)
def xf(s):
    return s.find('p:grpSpPr/a:xfrm',NS) if s.tag==q('p:grpSp') else (s.find('p:xfrm',NS) if s.tag==q('p:graphicFrame') else s.find('p:spPr/a:xfrm',NS))
def box(s):
    x=xf(s);o=x.find('a:off',NS);e=x.find('a:ext',NS)
    return tuple(int(v)/12700 for v in [o.get('x'),o.get('y'),e.get('cx'),e.get('cy')])
def place(s,x,y,w,h):
    t=xf(s);t.find('a:off',NS).attrib.update(x=str(round(x*12700)),y=str(round(y*12700)))
    t.find('a:ext',NS).attrib.update(cx=str(round(w*12700)),cy=str(round(h*12700)))
def run(text,size,font='Calibri',bold=False,color='232328'):
    r=E.Element(q('a:r'));rp=E.SubElement(r,q('a:rPr'),lang='nl-NL',sz=str(round(size*100)),b='1' if bold else '0')
    E.SubElement(E.SubElement(rp,q('a:solidFill')),q('a:srgbClr'),val=color)
    E.SubElement(rp,q('a:latin'),typeface=font)
    E.SubElement(r,q('a:t')).text=text
    return r
def paragraph(text,size,font='Calibri',bold=False,color='232328',align='l',before=0):
    p=E.Element(q('a:p'));pp=E.SubElement(p,q('a:pPr'),algn=align)
    E.SubElement(E.SubElement(pp,q('a:lnSpc')),q('a:spcPct'),val='110000')
    E.SubElement(E.SubElement(pp,q('a:spcBef')),q('a:spcPts'),val=str(round(before*100)))
    E.SubElement(E.SubElement(pp,q('a:spcAft')),q('a:spcPts'),val='0')
    E.SubElement(pp,q('a:buNone'))
    p.append(run(text,size,font,bold,color));return p
def resettext(s,paras,anchor='t',margins=(7.2,3.6,7.2,3.6)):
    tb=s.find('p:txBody',NS)
    for el in list(tb):tb.remove(el)
    l,t,r,b=margins
    bp=E.SubElement(tb,q('a:bodyPr'),wrap='square',lIns=str(round(l*12700)),tIns=str(round(t*12700)),rIns=str(round(r*12700)),bIns=str(round(b*12700)),anchor=anchor)
    E.SubElement(bp,q('a:noAutofit'));E.SubElement(tb,q('a:lstStyle'))
    tb.extend(paras)
    return s
def textshape(template,text,rect,size,font='Arial',bold=False,color='1E263A',align='l'):
    s=copy.deepcopy(template);place(s,*rect);resettext(s,[paragraph(text,size,font,bold,color,align)])
    return s
def card(head,body,rect,rich=None,body_size=10.5):
    s=copy.deepcopy(CARD);place(s,*rect)
    # Keep the reference corner radius when resizing the original template shape.
    av=s.find('p:spPr/a:prstGeom/a:avLst',NS)
    if av is not None:
        for e in list(av):av.remove(e)
        E.SubElement(av,q('a:gd'),name='adj',fmla='val '+str(round(18/min(rect[2],rect[3])*100000)))
    ps=[paragraph(head,12.75,bold=True,color='1E263A',align='ctr')]
    if rich is None:
        for i,line in enumerate(body.split('\n')):
            if line.strip(): ps.append(paragraph(line,body_size,before=6 if i==0 else 3))
    else:
        for old in rich.findall('p:txBody/a:p',NS):
            if not ''.join(old.itertext()).strip():continue
            literal=''.join(t.text or '' for t in old.findall('.//a:t',NS)).strip()
            if literal in ['Templates:','Een paar nuttige bronnen met principes over visueel ontwerp']:continue
            p=copy.deepcopy(old)
            pp=p.find('a:pPr',NS)
            if pp is not None:p.remove(pp)
            pp=paragraph('',body_size,before=3).find('a:pPr',NS);p.insert(0,pp)
            for rp in p.findall('.//a:rPr',NS)+p.findall('.//a:endParaRPr',NS):
                rp.set('sz',str(round(body_size*100)));rp.set('b','0')
                for tag in ['solidFill','latin','ea','cs']:
                    oldrp=rp.find('a:'+tag,NS)
                    if oldrp is not None:rp.remove(oldrp)
                fill=E.Element(q('a:solidFill'));E.SubElement(fill,q('a:srgbClr'),val='232328');rp.insert(0,fill)
                latin=E.Element(q('a:latin'),typeface='Calibri');rp.insert(1,latin)
            ps.append(p)
    resettext(s,ps,anchor='ctr',margins=(13.5,9,13.5,9))
    return s
def grids(n):
    if n==1:return [(64.8,115,588.6,195)]
    if n==2:return [(45.9,99,305.1,215),(369.9,99,305.1,215)]
    if n==3:return [(43.2+i*216,108,199.8,150) for i in range(3)]
    if n==4:return [(45.9+(i%2)*324,83.7+(i//2)*140,305.1,121.5) for i in range(4)]
    if n in [5,6]:return [(43.2+(i%2)*326.7,81+(i//2)*94.5,305.1,78.3) for i in range(n)]
def fit(shapes,rect):
    shapes=[copy.deepcopy(s) for s in shapes]
    boxes=[box(s) for s in shapes]
    left=min(b[0] for b in boxes);top=min(b[1] for b in boxes)
    right=max(b[0]+b[2] for b in boxes);bottom=max(b[1]+b[3] for b in boxes)
    x,y,w,h=rect;scale=min(w/max(right-left,.1),h/max(bottom-top,.1))
    dx=x+(w-(right-left)*scale)/2;dy=y+(h-(bottom-top)*scale)/2
    for s,(sx,sy,sw,sh) in zip(shapes,boxes):
        place(s,dx+(sx-left)*scale,dy+(sy-top)*scale,sw*scale,sh*scale)
        if s.tag!=q('p:grpSp'):
            for rp in list(s.iter(q('a:rPr')))+list(s.iter(q('a:defRPr')))+list(s.iter(q('a:endParaRPr'))):
                if rp.get('sz'):rp.set('sz',str(round(int(rp.get('sz'))*scale)))
    return shapes
def C(title,subtitle,cards,**kw):return dict(kind='cards',title=title,sub=subtitle,cards=cards,**kw)
def V(title,subtitle,ids,**kw):return dict(kind='visual',title=title,sub=subtitle,ids=ids,**kw)
def S(title,subtitle,ids,cards,**kw):return dict(kind='split',title=title,sub=subtitle,ids=ids,cards=cards,**kw)

def common(topic,workshop,figure=False):
    return {
      1:dict(kind='cover',subject=topic),
      2:C('Programma','Professional Development — Technische Stage',[
        ('Check-in','Hoe gaat de stage?'),('Planning & beoordeling','Planning, deadlines en de beoordeling van de stage.'),(topic,workshop)]),
      3:dict(kind='checkin',title='Hoe gaat de stage?',sub='Verwachting en praktijk',ids=[1032,1026]),
      4:V('Planning','Overzicht van de bijeenkomsten en deadlines',[12,2]),
      5:C('Gastsprekers','Planning van de gastbijdragen',[
        ('Nadia Haider — QuTech','8 oktober · 15:20–16:00\nAfgerond'),
        ('Dima Bederak — QDI systems','8 oktober · 16:20–17:00\nOnline · Afgerond'),
        ('Jasper Franse — TNO','19 november · 15:20–16:00'+ ('\nAfgerond' if figure else '')),
        ('Gideon Langedijk — PhotonFirst','19 november · 16:20–17:00'+ ('\nAfgerond' if figure else ''))]),
      6:C('Beoordeling','Onderdelen en deadlines uit de bestaande presentatie',[
        ('Technische stage I','Presentatie I — 25%\nMemo I — 25%\nMemo II — 25%\nDeadline Memo II: 19 december'),
        ('Technische stage II','Presentatie II — 25% · 26 november\nPosterpresentatie — 25% · 16 januari\nFeedbackformulier / experimenteel werk — 25%\nDeadline: 16 januari')]),
      7:V('Rubriek — Memo 2','Beoordelingscriteria voor het schriftelijke werk',[7,9],rect=[75,70,570,305]),
    }

EXP=common('Experimentele opstellingen','Voorbeelden bekijken en tekenen met Inkscape.')
EXP.update({
8:V('Rubriek — Presentatie','Methode, resultaten en visualisatie',[7,8],rect=[75,70,570,305]),
9:C('Experimentele opstellingen','Een goede tekening maken kost tijd.',[
 ('Verhaal','Een duidelijke opstelling helpt je verhaal te structureren en maakt impact.'),
 ('Gebruik','Gebruik de tekening in presentaties en rapporten, en bij de overdracht van je werk.'),
 ('Oefenen','Oefening baart kunst. Reserveer tijd om de tekening te verbeteren.')]),
10:V('Voorbeelden van experimentele opstellingen','Optica en mechanische metamaterialen',[9,4,13,14],foot_id=15,rect=[43,81,632,285]),
11:S('SVG versus PNG','Schaalbare objecten of pixels',[4],[
 ('SVG','Wiskundig gedefinieerde objecten. Schalen zonder resolutieverlies en afzonderlijke objecten aanpassen.'),
 ('PNG','Opgebouwd uit pixels. Bij vergroten wordt de beperkte resolutie zichtbaar.'),
 ('Bewerken','Software uit de voorbeelden: Photoshop, PowerPoint en Inkscape.')],foot_id=6),
12:V('Voorbeelden — Photoshop','Illustraties voor grotere projecten',[8194,8196],rect=[43,83,632,205],bottom=[('Organisatie','Vaak uitgevoerd door gespecialiseerde afdelingen, op projectmanager- of PI-niveau.')],foot_id=3),
13:V('Voorbeelden — PowerPoint','Twee manieren om een experimentele opstelling weer te geven',[340,26],foot_id=28),
14:V('Voorbeelden — Inkscape','Van instrumenten naar een schematische weergave',[216,342],foot_id=348),
15:C('Tekenen — aanpak en tips','Selecteer wat nodig is om je verhaal te vertellen.',[
 ('1. Selectie','Wat moet de lezer begrijpen? Laat onderdelen weg die daar niet aan bijdragen.'),
 ('2. Dimensies','3D is mooi, maar complex. Een duidelijke 2D-weergave is vaak voldoende.'),
 ('3. Opbouw','Verdeel de opstelling in onderdelen en groepeer objecten die bij elkaar horen.'),
 ('4. Parameters','Voeg de relevante fysische parameters toe.'),
 ('5. Export','Sla op als PDF of SVG. Converteer waar nodig naar vormen in PowerPoint.')]),
16:V('Opstelling — losse onderdelen','Groepeer de onderdelen die samen één functie hebben.',[3750,3752,30,31,32,10,33,34,29],rect=[43,81,632,285]),
17:V('Opstelling — stap voor stap','Dezelfde opstelling in verschillende fasen',[42,40,41,39,35,36],rect=[43,81,632,285]),
18:S('Inkscape — werken met objecten','Sneltoetsen en gereedschappen',[12],[
 ('Tekenen','Lijnen: gebruik Shift of Ctrl en de hulppunten.\nVormen: gebruik Ctrl om verhoudingen te behouden.'),
 ('Structuur','Groeperen: Ctrl + G\nGroepering opheffen: Ctrl + Shift + G\nGebruik lagen.'),
 ('Selectie & opmaak','Selecteren: F1 of S\nOpmaak: dubbelklik of gebruik de rechtermuisknop.')]),
19:V('Inkscape — kleur en diepte','Gebruik vervaging, dekking en kleurverlopen om een figuur levendiger te maken.',[7,11,18,16],rect=[43,95,632,270]),
20:V('Uitgewerkt voorbeeld — opbouw','Losse onderdelen samenbrengen in één figuur',[7,9,11,15,1276,1275],rect=[43,85,632,280]),
21:V('Uitgewerkt voorbeeld — maskers','Selecteer het witte maskeroppervlak en het object. Kies Object → Masker instellen.',[7,8,17,10,18,19,20],rect=[43,86,632,278]),
22:V('Uitgewerkt voorbeeld — eindresultaat','Een overzichtelijke figuur met uitvergrote details',[10],rect=[100,82,520,287]),
23:C('Opdracht — je eigen opstelling','Werk van een eerste schets naar een bewerkbare figuur.',[
 ('1. Schets — 5 minuten','Bepaal met pen en papier wat nodig is om je verhaal te vertellen.'),
 ('2. Vereenvoudig','Converteer de opstelling naar een duidelijke 2D-weergave.'),
 ('3. Werk uit','Ga aan de slag met Inkscape. Werk door in de resterende tijd, tot uiterlijk 18:40.')]),
24:dict(kind='section',title='Vragen?',sub='Experimentele opstellingen'),
25:C('Bibliotheken & gereedschappen','Kies hulpmiddelen die passen bij je opstelling.',[
 ('Optica','Optical Table Library'),('Elektrische schakelingen','TikZ, Fritzing of Electric Symbols Library'),
 ('Druk, vacuüm & pompen','P&ID: Piping and Instrumentation Diagram. Gebruik gestandaardiseerde symbolen.'),
 ('Engineering','CAD voor technische bouwtekeningen.'),('Andere opstellingen','Bouw een eigen bibliotheek met herbruikbare onderdelen.')]),
26:V('Meer voorbeelden — opstellingen','Verschillende manieren om onderdelen en verbindingen te tonen',[4,9,1026,1028]),
27:V('Meer voorbeelden — figuren','Opstelling, meetresultaten en detailbeelden',[7,1030,1032]),
})

FIG=common('Figuren met Python & Inkscape','Figuren tekenen, de workflow en praktische tips.',True)
FIG.update({
8:V('Rubriek — Wetenschappelijke poster','Beoordelingscriteria voor de poster',[3,8],rect=[43,83,632,285]),
9:V('Figuren optimaliseren met Inkscape','Voorbeelden van verschillende typen visualisaties',[7,10,12,14],rect=[100,83,520,282]),
10:C('Professionele figuren','Een goede figuur maken kost tijd.',[
 ('Verhaal','Een figuur helpt het verhaal te structureren en maakt je boodschap duidelijk.'),
 ('Gebruik','Dezelfde figuur kan terugkomen in presentaties, rapporten en de overdracht.'),
 ('Oefenen','Oefening baart kunst. Werk de figuur stap voor stap uit.')]),
11:S('Welk type figuur past bij je data?','Kies de vorm op basis van de gegevens en je boodschap.',[6],[
 ('1D & 2D','1D: histogram, density, ridgeline.\n2D: scatter, lijn en bubble.'),
 ('3D','Surface, heatmap, 2D-density, 3D-scatter en hexbin.'),
 ('Andere vormen','Kaarten, netwerken en verbindingen.\npython-graph-gallery.com')]),
12:V('Voorbeeld — methode','De figuur verbindt de experimentele stappen met de meting.',[12],rect=[80,82,560,290]),
13:V('Voorbeeld — resultaten','Aan het einde van de bijeenkomst kunnen jullie dit zelf.',[6],rect=[80,82,560,287]),
14:S('Informatiedichtheid','Gebruik details die de boodschap van de figuur ondersteunen.',[3,8,9,12,13],[
 ('Details','Voeg een inset toe om een relevant deel uit te vergroten.'),
 ('Vergelijking','Gebruik kleur, fits en referentiedata om verbanden zichtbaar te maken.')],visual_left=True),
15:C('Figuren — aanpak','Maak bewuste keuzes in data, vorm en export.',[
 ('1. Selectie','Welke data zijn nodig voor het verhaal? Laat de rest weg.'),
 ('2. Dimensies','Gebruik waar mogelijk 2D. Een extra dimensie kan met kleur zichtbaar worden.'),
 ('3. Parameters','Vermeld fysische parameters in het bijschrift of als label.'),
 ('4. Labels','Vermijd een extra titel in de grafiek. Gebruik korte labels en duidelijke ticks.'),
 ('5. Export','Bewaar als PDF of SVG voor verdere bewerking.\nplt.savefig("filename.svg")')]),
16:S('SVG — van Python naar Inkscape','Een vectorbestand houdt de onderdelen van je figuur bewerkbaar.',[4],[
 ('Schaalbaar','SVG bestaat uit wiskundig gedefinieerde objecten en behoudt de resolutie.'),
 ('Bewerkbaar','Pas afzonderlijke objecten aan.'),
 ('Workflow','Exporteer vanuit Matplotlib als SVG. Open het bestand daarna in Inkscape.')],foot_id=6),
17:dict(kind='links',title='Alternatieven voor Matplotlib',sub='Andere bibliotheken voor data-analyse en visualisatie',cards=[('Julia & Python',3744)],rects=[(43.2,83.7,440,270)],assets=[(1026,(510,100,165,110)),(3,(510,260,165,65))]),
18:dict(kind='links',title='Opdracht — een figuur bespreken',sub='Tijd: 5 minuten',cards=[('Verken de voorbeelden',6)],rects=[(64.8,83.7,588.6,250)]),
19:V('Opdracht — wat kan beter?','Bekijk de figuur en bespreek welke aanpassingen de boodschap duidelijker maken.',[240,9,241,242],rect=[100,83,520,285]),
20:S('Inkscape — praktische tips','Een consistente opmaak maakt de figuur beter leesbaar.',[12],[
 ('Samenhang','Gebruik eenvoudige lettertypen, zoals Calibri of Cambria. Combineer opstelling en data tot één geheel.'),
 ('Uitlijnen & groeperen','Uitlijnen en verdelen: Ctrl + Shift + A\nGroeperen: Ctrl + G\nGroepering opheffen: Ctrl + Shift + G'),
 ('Selectie & opmaak','Selecteren: F1 of S\nOpmaak: dubbelklik of rechtermuisknop.')]),
21:C('Inkscape — details verbeteren','Stuur de aandacht naar wat de lezer moet zien.',[
 ('Boodschap','Gebruik insets, kleur en referentiedata.'),
 ('Uitlijning','Lijn ticks en labels uit via Object → Uitlijnen en verdelen.'),
 ('Symbolen','Pas symbolen als groep aan via Object → Transformeren.')]),
22:S('Opdracht — een figuur namaken','Tijd: 1 uur',[3],[
 ('Openen','Open de aangeleverde SVG-figuren in Inkscape.'),
 ('Uitwerken','Maak de voorbeeldfiguur zo goed mogelijk na.')],visual_left=True),
23:dict(kind='section',title='Vragen?',sub='Figuren met Python & Inkscape'),
})

POST={
1:dict(kind='cover',subject='Posterpresentaties'),
2:C('Programma','Professional Development — Technische Stage',[
 ('Check-in','Hoe gaat de stage?'),('Planning & beoordeling','Deadlines en de beoordeling van de poster.'),('Posterpresentaties','Opbouw, voorbeelden en praktische tips.')]),
3:dict(kind='checkin',title='Hoe gaat de stage?',sub='Verwachting en praktijk',ids=[1032,1026]),
4:V('Planning','Overzicht van de bijeenkomsten en deadlines',[12,2]),
5:C('Beoordeling','Onderdelen en deadlines uit de bestaande presentatie',[
 ('Technische stage I','Presentatie I — 25%\nMemo I — 25%\nMemo II — 25%\nBeoordeling volgt snel.'),
 ('Technische stage II','Presentatie II — 25% · 26 november\nPosterpresentatie — 25% · 16 januari\nFeedbackformulier / experimenteel werk — 25%\nBeoordeling aan het einde van de stage.')]),
6:V('Rubriek — Wetenschappelijke poster','Beoordelingscriteria voor de poster',[3],rect=[43,83,632,285]),
7:C('Posterpresentatie — praktische afspraken','Planning en organisatie uit de bestaande presentatie',[
 ('Inleveren','16 januari, 17:00. Te laat inleveren kan betekenen dat de poster niet op tijd geprint is.'),
 ('Ophalen','Haal de poster zelf op. Locatie en datum volgen.'),
 ('Presentatiedag','Donderdag 22 januari, 9:00–circa 13:00. Gezamenlijke start bij Nikhef. Schema volgt later deze week.'),
 ('Taal & publiek','Nederlands of Engels. Begeleiders zijn welkom.'),
 ('Beoordeling','De vorm en inhoud van de poster tellen mee, niet de presentatie.'),
 ('Duur','De posterpresentatie duurt ongeveer 10–15 minuten.')]),
8:C('Postervereisten — inhoud en vorm','Gebaseerd op de genoemde NWO Physics @ Veldhoven-richtlijnen',[
 ('Resultaten','Toon wetenschappelijke resultaten uit je memo’s en presentaties.'),
 ('Formaat','Maximaal A0 in portretstand volgens de richtlijn. Het definitieve formaat bepalen wij.'),
 ('Personen','Neem een foto van jezelf of jullie groep op. Vermeld iedereen die aan het project heeft bijgedragen.'),
 ('Organisaties','Vermeld instellingen, acknowledgements en de bijbehorende logo’s, zoals UvA, HvA en Nikhef.')],banner=('Controle','Laat de poster controleren door je (wetenschappelijke) begeleider.')),
9:C('Waarom een poster?','Een toegankelijke manier om je project en resultaten te bespreken.',[
 ('Overzicht','Laat je project en resultaten efficiënt zien, ook bij grotere bijeenkomsten.'),
 ('Gesprek','Een informele, laagdrempelige manier om over het werk te praten.'),
 ('Keuze','De bezoeker kiest zelf welk onderwerp interessant is.')]),
10:dict(kind='gallery',title='Voorbeelden van wetenschappelijke posters',sub='Bekijk de structuur, de figuren en de verhouding tussen tekst en beeld.',ids=[7,9,11]),
11:C('Opbouw van een poster','Gebruik herkenbare secties om het verhaal te ordenen.',[
 ('Abstract','Soms aanwezig: een korte samenvatting.'),
 ('Inleiding','Probleemstelling, motivatie en doel.'),
 ('Theorie','Projecttitel en de belangrijkste vergelijking.'),
 ('Opstelling & methode','De experimentele aanpak.'),
 ('Resultaten','Benoem het behaalde resultaat waar mogelijk al in de titel.'),
 ('Afsluiting','Conclusies, vooruitblik en samenvatting.')]),
12:C('Wat valt op aan de voorbeelden?','Bespreek de keuzes in inhoud en vormgeving.',[
 ('Visueel verhaal','Gebruik figuren om het verhaal te vertellen.'),
 ('Weinig tekst','De spreker licht de poster mondeling toe.'),
 ('Structuur','Dezelfde herkenbare onderdelen, met duidelijke secties.'),
 ('Creativiteit','Gebruik vormgeving om de inhoud zichtbaar te maken. Wat valt jullie nog meer op?')]),
13:dict(kind='links',title='Voorbeelden, templates & ontwerptips',sub='Bronnen om verder te kijken',cards=[('Voorbeelden',7),('Templates',8),('Ontwerpprincipes',9)],rects=[(43.2,78,631.8,92),(43.2,181,631.8,68),(43.2,260,631.8,108)]),
14:C('Feedback op het themasemester','Schrijf eerst 5 minuten voor jezelf. Bespreek daarna je ideeën.',[
 ('Wat moet anders?','Welke onderdelen van het themasemester zouden moeten veranderen?'),
 ('Wat heb je nodig?','Waar heb jij of heeft jullie groep meer behoefte aan?'),
 ('Andere feedback','Welke opmerkingen of ideeën wil je verder meegeven?')]),
15:dict(kind='section',title='Vragen?',sub='Posterpresentaties'),
}

def rebuild(src,plan):
    z=zipfile.ZipFile(src);parts={n:z.read(n) for n in z.namelist()};z.close()
    for number,spec in plan.items():
        name=f'ppt/slides/slide{number}.xml';old=parse(parts[name]);rt=copy.deepcopy(old)
        rt.set('showMasterSp','0')
        cs=rt.find('p:cSld',NS);tree=cs.find('p:spTree',NS)
        for ch in list(tree)[2:]:tree.remove(ch)
        bg=cs.find('p:bg',NS)
        if bg is not None:cs.remove(bg)
        bg=E.Element(q('p:bg'));pr=E.SubElement(bg,q('p:bgPr'));E.SubElement(E.SubElement(pr,q('a:solidFill')),q('a:srgbClr'),val='FFFFFF');cs.insert(0,bg)
        for tag in ['timing','transition']:
            for el in rt.findall('p:'+tag,NS):rt.remove(el)
        def add(s):tree.append(s)
        def assets(ids,rect):
            for s in fit([findshape(old,i) for i in ids],rect):
                for e in s.findall('.//p:cNvPr',NS):e.set('_source_id',e.get('id'))
                add(s)
        kind=spec['kind']
        if kind=='cover':
            rt=copy.deepcopy(refslide(1));rt.set('showMasterSp','1')
            tree=rt.find('p:cSld/p:spTree',NS)
            for s in list(tree)[2:]:
                if s.tag==q('p:sp'):
                    text=''.join(s.itertext())
                    if 'Professional Development' in text:
                        resettext(s,[paragraph('Professional Development',28,'Arial',True,'1E263A','ctr')])
                        place(s,65,100,420,50)
                    elif 'Startbijeenkomst' in text:
                        resettext(s,[paragraph('Technische Stage',18,'Arial',False,'232328','ctr'),paragraph(spec['subject'],18,'Arial',False,'232328','ctr',before=4)])
                        place(s,48,145,454,65)
                    elif 'Woensdag' in text:
                        resettext(s,[paragraph('Studiejaar 2026–2027',14,'Calibri Light',False,'5A5F69','ctr')]);place(s,110,216,330,30)
        elif kind=='section':
            add(textshape(SECTION,spec['title'],(70,156.6,580,60),33,bold=True,align='ctr'))
            add(textshape(SUB,spec['sub'],(100,218,520,35),12,color='5A5F69',align='ctr'))
        else:
            add(textshape(TITLE,spec['title'],(35.1,18.9,650,33),21,bold=True))
            add(textshape(SUB,spec['sub'],(36.2,54,650,26),9.75,color='5A5F69'))
            if kind=='cards':
                rects=grids(len(spec['cards']))
                if spec.get('banner'):
                    rects=[(45.9+(i%2)*324,83.7+(i//2)*111,305.1,96) for i in range(4)]
                for (head,body),rect in zip(spec['cards'],rects):add(card(head,body,rect))
                if spec.get('banner'):add(card(*spec['banner'],(72.9,315,572.4,54),body_size=10.5))
            elif kind=='visual':
                assets(spec['ids'],spec.get('rect',(43.2,83.7,631.8,285)))
                for head,body in spec.get('bottom',[]):add(card(head,body,(64.8,303,588.6,62),body_size=10.5))
            elif kind=='split':
                left=spec.get('visual_left',False)
                visual=(43.2,85,370,278) if left else (370,85,305,278)
                col=(435,83.7,240) if left else (43.2,83.7,305.1)
                assets(spec['ids'],visual)
                count=len(spec['cards']);h=(279-(count-1)*15)/count
                for i,(head,body) in enumerate(spec['cards']):add(card(head,body,(col[0],col[1]+i*(h+15),col[2],h),body_size=10.5))
            elif kind=='checkin':
                for i,(label,sid) in enumerate(zip(['Verwachting','Praktijk'],spec['ids'])):
                    add(card(label,'',(45.9+i*324,83.7,305.1,42)))
                    assets([sid],(45.9+i*324,143,305.1,204))
            elif kind=='gallery':
                for i,sid in enumerate(spec['ids']):assets([sid],(43.2+i*216,86,199.8,280))
            elif kind=='links':
                for (head,sid),rect in zip(spec['cards'],spec['rects']):add(card(head,'',rect,rich=findshape(old,sid),body_size=9.75))
                for sid,rect in spec.get('assets',[]):assets([sid],rect)
            if spec.get('foot_id'):
                source=findshape(old,spec['foot_id'])
                txt=' '.join(t.text or '' for t in source.findall('.//a:t',NS))
                add(textshape(FOOT,txt,(36.7,380,647,22),6,color='737378'))
        # Unique IDs also for source groups copied from different positions.
        idmap={}
        for i,e in enumerate(tree.findall('.//p:cNvPr',NS),1):
            if e.get('_source_id') is not None:idmap[e.attrib.pop('_source_id')]=str(i)
            e.set('id',str(i))
        for tag in ['stCxn','endCxn']:
            for e in tree.findall('.//a:'+tag,NS):
                if e.get('id') in idmap:e.set('id',idmap[e.get('id')])
        # Preserve original slide relationships, graphics, tables, notes, and source assets.
        parts[name]=E.tostring(rt,encoding='UTF-8',xml_declaration=True)
    dest=src.with_name(src.stem+'_2026-2027_v2.pptx')
    with zipfile.ZipFile(dest,'w',zipfile.ZIP_DEFLATED) as out:
        for n,b in parts.items():out.writestr(n,b)
    return str(dest)

if __name__=='__main__':
    outputs=[]
    for folder,name,plan in [('Bijeenkomst 5','Experimentele opstellingen',EXP),('Bijeenkomst 7','Figuren Python',FIG),('Bijeenkomst 8','Posterpresentatie',POST)]:
        outputs.append(rebuild(BASE/folder/(name+'.pptx'),plan))
    (ROOT/'tmp/pd-stijl/v2-outputs.json').write_text(json.dumps(outputs,indent=2),encoding='utf-8')
    print('\n'.join(outputs))

#import "../../styl.typ": *
#show: stijl.with(titel: "Spectrometer", kop: "Natuurkunde 2.1 Practicum — Week 2 \\& 3")

#praktikumtitle[Practicum: Spectrometer bouwen]

#heading(level: 1, numbering: none)[Leerdoelen]

#leerdoelen(
  [Je kunt zelfstandig een onderzoeksvraag en (onderbouwde) verwachting opstellen over jouw experiment.],
  [Je bent in staat om een meetplan en experimentele opstelling te ontwerpen voor een relatief eenvoudig optica experiment (spectrometer).],
  [Je kunt zelfstandig een optische opstelling bouwen vanuit een gegeven ontwerp.],
  [Basisvaardigheid in datamanipulatie, visualisatie én model toetsen in Python.],
)

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ We werken dit practicum met spectraallampen, deze worden heet en kunnen niet warm opgeborgen worden.

+ De lensen, spiegeltjes en overige optische onderdelen zijn erg duur & kwetsbaar! Ga hier voorzichtig mee om.

+ Dit practicum duurt twee weken, je hoeft de opstelling dus niet tussentijds af te breken.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Practicum week 1]

#heading(level: 1, numbering: none)[Introductie]

De oorsprong van de spectroscopie ligt in het begin van de 19e eeuw. Isaac Newton had in de 17e eeuw al laten zien dat wit licht met behulp van een prisma in een spectrum uiteenvalt, maar pas veel later werd dit verschijnsel systematisch onderzocht. In 1802 beschreef William Hyde Wollaston donkere lijnen in het zonnespectrum, die hij met een eenvoudig prisma waarnam. Enkele jaren later, in 1814, maakte Joseph von Fraunhofer nauwkeurige waarnemingen van deze lijnen. Hij ontwikkelde een verbeterde spectroscoop waarin een smalle spleet, een collimator en een prisma waren gecombineerd, waardoor een veel scherper spectrum zichtbaar werd. Fraunhofer kon hiermee honderden absorptielijnen in het zonlicht vastleggen, de later zogenoemde Fraunhoferlijnen. Deze uitvinding markeerde het begin van de spectroscopie als onderzoeksinstrument. \
In bredere zin is een spectrometer een instrument waarmee het spectrum van een natuurkundige grootheid kan worden bepaald. Naast optische spectrometers bestaan er bijvoorbeeld massaspectrometers, NMR-spectrometers en Auger-elektronspectrometers. In dit experiment richten we ons op een optische spectrometer (spectrofotometer), waarmee zichtbaar licht kan worden geanalyseerd. Het principe berust erop dat licht in componenten van verschillende golflengtes wordt gescheiden, zie Fig. #ref(label("spectrometer--fig: reflectie_spectrometer"), supplement: none). Op die manier kan informatie worden verkregen over de samenstelling en eigenschappen van materialen. Toepassingen zijn er in tal van vakgebieden: in de chemie om stoffen te identificeren, in de astronomie om de atmosfeer van verre planeten te onderzoeken, in de natuurkunde om energieniveaus van atomen en moleculen te bepalen, en in de materiaalkunde om de zuiverheid van materialen te testen.

#figure(
  [
#box(image("Figuren/Spectrometer.jpg", width: 65.0%))
  ],
  caption: [Schematische weergave van een reflectiespectrometer: licht gaat door een spleet, wordt via een holle spiegel parallel gemaakt, gescheiden door een tralie en opgevangen door een detector.],
  kind: image,
) #label("spectrometer--fig: reflectie_spectrometer")

In deze vierdelige practicumreeks gaan jullie aan de slag met het opbouwen van een #strong[transmissie] spectrometer, het kalibreren en doormeten van twee onbekende (spectraal)lampen (week 1). In week 2 gaan jullie de spectrometer gebruiken voor het doen van een experiment: het bepalen van de concentratie van een onbekende Cu(II)sulfaat oplossing.

#v(1fr)

#voorbereiding(title: [Voorbereidingsopdracht week 1])[
+ Maak een meetplan voor het bouwen van een #strong[transmissie] spectrometer van maximaal 1 pagina#footnote[Zie Brightspace voor een korte uitleg over een meetplan.]. Formuleer een hoofddoel voor deze week en geef een korte theoretische onderbouwing over hoe je controleert of deze spectrometer dient te werken.

+ Maak een schets van de #strong[transmissie] spectrometer in Powerpoint of Inkscape#footnote[Inkscape is bijzonder geschikt voor het tekenen van optische opstellingen. Via Inkscape kun je een Optical-Table Library openen, waarna je de onderdelen op de juiste plek kan zetten. Zie hiervoor #link("https://www.gwoptics.org/ComponentLibrary/")[deze link].] en zet deze in jouw labjournaal.

+ Maak een Jupyter notebook waarin je het Python script van de video-analyse klaar staat. Je kunt de code van deze Github-pagina gebruiken #link("https://github.com/HvA-TN/natuurkunde_2.2")[link.]

]

#heading(level: 1, numbering: none)[Theoretische achtergrond]

Licht kan worden beschreven als een golf met een bepaalde golflengte $lambda$. Voor zichtbaar licht liggen deze golflengtes tussen ongeveer $380$ en $780 thin upright("nm")$. Een detector, zoals een camera, meet de intensiteit van dit licht: hoeveel licht er van een bepaalde golflengte aanwezig is.

Om wit licht te ontleden in zijn afzonderlijke golflengtes maken we gebruik van een tralie (grating). Dit is een plaatje met zeer veel fijne, evenwijdige lijntjes. Door diffractie en interferentie wordt licht daarbij onder een hoek afgebogen die afhangt van de golflengte. De relatie tussen de golflengte $lambda$, de spleetafstand $d$ van de tralie en de afbuighoek $theta$ is gegeven door: #math.equation(block: true, numbering: "(1)", $sin \( theta \) = frac(n lambda, d) \,$) Hier is $n$ de orde van diffractie en $d$ de afstand tussen twee tralielijnen. Deze vorm geldt bij loodrechte inval; $theta$ wordt gemeten ten opzichte van de normaal op het tralie. Ditzelfde principe zorgt er ook voor dat je op een cd of dvd regenboogkleuren ziet verschijnen. \
In de spectrometer wordt het uitgespreide licht door de tralie op een camera geprojecteerd. Door de posities op de detector te koppelen aan bekende golflengtes (ijking), kan de gemeten intensiteit worden weergegeven als functie van de golflengte: $I \( lambda \)$. Het resultaat noemen we een spectrum: een overzicht van welke golflengtes in de lichtbron aanwezig zijn en met welke relatieve sterkte. \
#opdracht(title: [Opdracht 1(a)])[
+ Ga aan de slag met het bouwen van de spectrometer.

+ Gebruik als lichtbron een LED licht.

+ Houd je voortgang bij in het labjournaal.

]

#heading(level: 1, numbering: none)[Het ijken van de spectrometer]

Bij het analyseren van lichtbronnen wordt vaak gebruikgemaakt van spectraallampen. Dit zijn lampen die bij opwarming of excitatie licht uitzenden met karakteristieke spectraallijnen, bijvoorbeeld van kwik, natrium of waterstof. Elke lijn correspondeert met een specifieke elektronische overgang in het atoom of molecuul van het gebruikte gas, zie Fig. #ref(label("spectrometer--Fig: Bohr"), supplement: none). Het spectrum van zo'n lamp bestaat daarom uit een aantal scherpe pieken op vaste golflengtes, in plaats van een doorlopend kleurverloop.

#figure(
  [
#box(image("Figuren/Borh.png", width: 50.0%))
  ],
  caption: [Het Borh model. Bij transititie van een electron naar een andere baan komt er een specifieke kleur licht vrij: de spectraallijn.],
  kind: image,
) #label("spectrometer--Fig: Bohr")

Om deze lijnen kwantitatief te analyseren, kan men de gemeten intensiteit van een spectraallijn bepalen aan de hand van een Lorentz-functie#footnote[Een Lorentz-profiel verschijnt bij resonanties doordat een aangeslagen toestand een beperkte levensduur heeft, wat wiskundig de karakteristieke Lorentz-vorm oplevert, zie vergelijking #ref(label("spectrometer--Eq: lorentzian"), supplement: none). Meer informatie is te vinden #link("https://chem.libretexts.org/Bookshelves/Physical_and_Theoretical_Chemistry_Textbook_Maps/Supplemental_Modules_(Physical_and_Theoretical_Chemistry)/Spectroscopy/Fundamentals_of_Spectroscopy/Lineshape_Functions")[hier.]]:

#math.equation(block: true, numbering: "(1)", $I \( lambda \) = I_0 thin frac(gamma^2, \( lambda - lambda_0 \)^2 + gamma^2)$) #label("spectrometer--Eq: lorentzian")

waarbij $lambda_0$ de centrale golflengte van de lijn is, $gamma$ de halve breedte op halve hoogte van de piek, en $I_0$ de maximale intensiteit. Door een Lorentz-fit uit te voeren, kan men nauwkeurig de centrale golflengte en breedte van een spectraallijn bepalen. Deze #emph[formele] methode is echter vrij lastig en het succes hiervan hangt af van de kwaliteit van de data. Een eenvoudigere methode is gebruik te maken van een peak-detection algorithme van Python.

#jupytercode([Eenvoudige piekdetectie])[
```python
import numpy as np
from scipy.signal import find_peaks

# x en y zijn numpy arrays
peaks, _ = find_peaks(y, height=0)
peak_x = x[peaks]
peak_y = y[peaks]

print("Gevonden pieken:")
for xi, yi in zip(peak_x, peak_y):
    print(xi, yi)
```

]

Spectraallampen worden ook gebruikt om spectrometers te ijken. Wanneer we een lamp met bekende golflengtes meten, verschijnen de karakteristieke intensiteitspieken op specifieke posities op de detector. Bijvoorbeeld, een blauwe lijn van $450 thin upright("nm")$ kan helemaal links op de detector verschijnen, terwijl een gele lijn van $600 thin upright("nm")$ in het midden zichtbaar is. Met deze referentielijnen kunnen we alle posities op de detector koppelen aan hun bijbehorende golflengte. Door de bekende pieken als uitgangspunt te nemen, kunnen we de golflengtes van de tussenliggende punten nauwkeurig bepalen. Dit proces, het ijken van de spectrometer, is essentieel om betrouwbare en reproduceerbare metingen van onbekende spectra te kunnen uitvoeren. In appendix 2, tabel #ref(label("spectrometer--table: spectraallijnen_Na_He_Ne_Hg"), supplement: none), staat de lijst van spectraallijnen van helium, natrium, neon en kwik. Gebruik deze lijst om een tabel te maken voor de kalibratie, zie tabel #ref(label("spectrometer--table: calibratie_pixel_lambda"), supplement: none).

#figure(
  [
#align(center)[#table(
    columns: 2,
    align: (center,center,),
    table.header([x-pixel], [Golflengte (nm)],),
    table.hline(),
    [100], [430.3],
    [500], [589.0],
    [900], [706.5],
    [⋮], [⋮],
    [⋮], [⋮],
  )]
  ],
  caption: [Calibratiepunten: pixelwaarde vs. golflengte],
  kind: table,
) #label("spectrometer--table: calibratie_pixel_lambda")

Deze tabel is een fictief rekenvoorbeeld; gebruik voor de ijking je eigen gemeten pixelposities en bekende lijnen van de referentielamp. Een lineaire kalibratie is een benadering: controleer met meerdere lijnen of deze in het gebruikte bereik voldoende nauwkeurig is. Het model is:

#math.equation(block: true, numbering: "(1)", $upright("Golflengte (nm)") = a med upright("x-pixel") + b \,$) hierbij zijn $a$ en $b$ fitparameters die we moeten bepalen. Mocht ik nu een spectraallijn vinden die niet in tabel #ref(label("spectrometer--table: spectraallijnen_Na_He_Ne_Hg"), supplement: none) staat, dan kan ik met een gegeven $a$ en $b$ de golflengte toch netjes bepalen.

#opdracht(title: [Opdracht 1(b)])[
+ Ga aan de slag met het ijken van de spectrometer.

+ Meet het spectrum van een bekende lamp. Zet deze in je labjournaal.

+ Bepaal van iedere emissielijn de pixelpositie van de piek met behulp van het peak-detection-algoritme van SciPy. Koppel deze posities aan bekende referentiegolflengten om de ijklijn te bepalen. Mocht dit te lastig zijn en kom je hier niet uit, probeer de locaties (x-pixels) te schatten op het oog.

+ Houd je voortgang bij in het labjournaal.

]

Als je de spectrometer hebt geijkt, dan kan je jouw spectrometer gebruiken om ook van een onbekende lamp het spectrum te analyseren. Misschien lukt het jullie ook wel om op basis van de gemeten golflengten én tabel #ref(label("spectrometer--table: spectraallijnen_Na_He_Ne_Hg"), supplement: none) om de juiste lamp te vinden.

#opdracht(title: [Opdracht 1(c)])[
+ Meet de golflengten van de nieuwe lamp.

+ Welke lamp(en) komen overeen met jouw gevonden golflengten?

+ Houd je voortgang bij in het labjournaal.

]

#afronding(title: [Afronding week 1])[
+ Zet de gemaakte figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal. Hierin moet de uiteindelijke waarde van jouw experiment (met onzekerheid) staan en een korte discussie of deze waarde #strong[realistisch] en #strong[betrouwbaar] is.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Practicum week 2]

#heading(level: 1, numbering: none)[Absorptie en transmissie van licht]

In deze week gaan jullie metingen doen aan oplossingen van koper(II)sulfaat (CuSO#sub[4]). Dit zout geeft in oplossing een heldere blauwe kleur. Wanneer we een oplossing van CuSO#sub[4] voor een witte lichtbron (LED) plaatsen, wordt een deel van het spectrum van het licht geabsorbeerd. Omdat de oplossing blauw van kleur is, kan het absorptiespectrum van CuSO#sub[4] voorspeld worden op basis van de complementaire kleur (zie tabel.~#ref(label("spectrometer--table: complementaire_kleur"), supplement: none)).

Wanneer licht door een materiaal gaat, kan het worden gereflecteerd, geabsorbeerd of doorgelaten. De hoeveelheid doorgelaten licht drukken we uit met de #emph[transmissie] $T$, gedefinieerd als de verhouding tussen de doorgelaten intensiteit $I$ en de oorspronkelijke intensiteit $I_0$: #math.equation(block: true, numbering: "(1)", $T = I / I_0 .$)

De #emph[absorbantie] $A$ wordt gedefinieerd met de logaritme met grondtal 10: #math.equation(block: true, numbering: "(1)", $A = - log_10 \( T \) = - log_10 (I / I_0) .$)

Meet $I_0$ met een blanco (dezelfde cuvet met oplosmiddel) en $I$ met de oplossing, bij dezelfde golflengte en instellingen. Corrigeer beide signalen voor de donkerachtergrond. Volgens de wet van Beer--Lambert is de absorbantie bij een vaste golflengte en weglengte evenredig met de concentratie, zolang de wet toepasbaar is.

In het practicum zullen jullie verschillende concentraties CuSO#sub[4]-oplossingen meten en het verband tussen concentratie en absorbantie onderzoeken. Met behulp van een door jullie opgestelde ijklijn kunnen jullie uiteindelijk de concentratie bepalen van een onbekende oplossing.

#v(1fr)

#voorbereiding(title: [Voorbereidingsopdracht week 2])[
+ Maak een meetplan voor het meten van een Cu(II)sulfaat oplossing met behulp van door jullie gemaakte spectrometer. Het meetplan moet maximaal 1 pagina zijn & aanwezig in het labjournaal#footnote[Zie Brightspace voor een korte uitleg over een meetplan.]. Formuleer het hoofddoel/onderzoeksvraag, geef een theoretische verwachting en maak een meetstrategie.

+ Hoe gaat je ijklijn eruit zien? Wat staat er op de x-as en wat staat er op de y-as?

+ Maak een Jupyter notebook waarin je een voorbeeld analyse hebt uitgewerkt.

]

#pagebreak(weak: true)

#opdracht(title: [Opdracht 2(a)])[
+ Bepaal het absorptiespectrum van (CuSO#sub[4]). Zet dit figuur in je labjournaal.

+ Wat is de concentratie van de onbekende oplossing. Denk aan eenheden en de onzekerheid! Zet de bijbehorende ijklijnen ook in je labjournaal.

+ Houd je voortgang bij in het labjournaal.

]

#afronding(title: [Afronding week 2])[
+ Zet de gemaakte figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.

+ Vul de #strong[Resultaat- en Discussie]-sectie aan in je labjournaal. Hierin moet de uiteindelijke waarde van jouw experiment (met onzekerheid) staan en een korte discussie of deze waarde #strong[realistisch] en #strong[betrouwbaar] is.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 1: Materialen en tips]

#heading(level: 2, numbering: none)[Materialenlijst]

Voor dit practicum zijn de volgende componenten nodig:

- 1× verstelbare dunne spleet

- 1× concaaf spiegel, f = 15 cm

- 1× concaaf spiegel, f = 10 cm

- 1× transmissie tralie

- 1× camera (fotodetector)

- 1× lichtbron (LED of spectraallamp)

#heading(level: 2, numbering: none)[Tips]

- Bepaal de onderlinge afstanden van alle componenten, beginnend bij de entree-spleet en de eerste concaaf spiegel. Let hierbij op de parallelle terugkaatsing van de stralen.

- Onderzoek op welke afstand de spiegels geplaatst moeten worden en hoe het licht optimaal op de tralie valt.

- Maak een schets van de stralengang door de opstelling.

- Zorg dat de opstelling op een breadboard van 45~cm bij 60~cm past.

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 2: Spectraallijnen gasontladingslampen]

#figure(
  [
#box(image("Figuren/g4.png", width: 95.0%))
  ],
  caption: [De (sterke) spectraallijnen van helium, neon, natrium en kwik.],
  kind: image,
) #label("spectrometer--fig:spectrallines")

#figure(
  [
#align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([Na], [He], [Ne], [Hg],),
    table.hline(),
    [497.7~nm], [388.9~nm], [585.2~nm], [404.7~nm],
    [568.8~nm], [447.1~nm], [588.2~nm], [435.8~nm],
    [589.0~nm], [471.3~nm], [603.0~nm], [546.1~nm],
    [589.6~nm], [492.2~nm], [614.3~nm], [577.0~nm],
    [615.4~nm], [501.6~nm], [640.2~nm], [579.1~nm],
    [819.5~nm], [587.6~nm], [650.7~nm], [623.4~nm],
    [], [667.8~nm], [659.9~nm], [690.8~nm],
    [], [706.5~nm], [703.2~nm], [706.5~nm],
    [], [], [717.4~nm], [],
    [], [], [724.5~nm], [],
    [], [], [743.9~nm], [],
    [], [], [748.9~nm], [],
    [], [], [753.6~nm], [],
    [], [], [837.8~nm], [],
  )]
  ],
  caption: [De golflengte van de belangrijkste spectraallijnen van natrium (Na), helium (He), neon (Ne) en kwik (Hg) in nanometer.],
  kind: table,
) #label("spectrometer--table: spectraallijnen_Na_He_Ne_Hg")

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 3: Data fitten]

#jupytercode([Voorbeeld: fitten met `curve_fit`])[
```python
import numpy as np
from scipy.optimize import curve_fit

# Lineair model
def linear(x, a, b):
    return a * x + b

# Voorbeelddata met fouten
xdata = np.array([1,2,3,4,5])
ydata = np.array([1.1,1.9,3.2,3.9,5.1])
yerr  = np.array([0.1]*5)

# Initiële schatting van parameters a,b
p0 = [1, 0]

# Fit uitvoeren
popt, pcov = curve_fit(linear, xdata, ydata, sigma=yerr, p0=p0,
                       absolute_sigma=True)

# Resultaten en onzekerheden
perr = np.sqrt(np.diag(pcov))
print("a =", popt[0], "+-", perr[0])
print("b =", popt[1], "+-", perr[1])
```

]

#heading(level: 1, numbering: none)[Appendix 4: Complementaire kleuren]

#figure(
  [
#align(center)[#table(
    columns: 4,
    align: (center,center,center,center,),
    table.header([$lambda$ geabsorbeerd], [$E$ (eV)], [Geabsorbeerde kleur], [Waargenomen kleur],),
    table.hline(),
    [$> 700 med upright("n") upright("m")$], [$< 1.77$], [Infrarood], [Niet waarneembaar],
    [700~nm--635~nm], [1.77--1.95], [Rood], [Groen],
    [635~nm--590~nm], [1.95--2.10], [Oranje], [Blauw],
    [590~nm--560~nm], [2.10--2.21], [Geel], [Violet],
    [560~nm--520~nm], [2.21--2.38], [Groen], [Rood],
    [520~nm--490~nm], [2.38--2.53], [Cyaan], [Rood--oranje],
    [490~nm--450~nm], [2.53--2.76], [Blauw], [Oranje],
    [450~nm--400~nm], [2.76--3.10], [Violet], [Geel],
    [$< 400 med upright("n") upright("m")$], [$> 3.10$], [Ultraviolet (UV)], [Niet waarneembaar],
  )]
  ],
  caption: [Relatie tussen geabsorbeerde golflengte, energie en waargenomen complementaire kleur.],
  kind: table,
) #label("spectrometer--table: complementaire_kleur")

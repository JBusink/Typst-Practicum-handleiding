#import "../styl.typ": *
#show: stijl.with(titel: "Python tips", kop: "Python voor het practicum")

#praktikumtitle[Python-tips]

In dit onderdeel staan veelgebruikte voorbeelden voor het verwerken, analyseren en visualiseren van meetgegevens met Python. De voorbeelden zijn bedoeld als naslag tijdens de practica.

Wil je direct beginnen? Bij #link("Code_snippets.pdf")[Code snippets] staan volledige, zelfstandig uitvoerbare voorbeelden. In dit onderdeel bouwen de korte codefragmenten binnen een onderwerp op elkaar voort.

De belangrijkste packages die we gebruiken zijn:

#align(center)[#table(
    columns: (25%, 39%, 27%),
    align: (left,left,left,),
    table.header([#strong[Package]], [#strong[Veelgebruikt voor]], [#strong[Documentatie]],),
    table.hline(),
    [NumPy], [Arrays, rekenen en statistiek], [#link("https://numpy.org/doc/stable/")[NumPy] \[1\]],
    [Matplotlib], [Figuren en grafieken], [#link("https://matplotlib.org/stable/")[Matplotlib] \[2\]],
    [SciPy], [Fits en wetenschappelijke berekeningen], [#link("https://docs.scipy.org/doc/scipy/")[SciPy] \[3\]],
    [Pandas], [Tabellen, CSV- en databestanden], [#link("https://pandas.pydata.org/docs/")[Pandas] \[4\]],
  )]

#heading(level: 1, numbering: none)[Packages]

Packages worden meestal bovenaan een Python-script of notebook geïmporteerd.

#jupytercode([Python])[
```python
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

from scipy.optimize import curve_fit
```

]

Voor NumPy, Matplotlib en Pandas worden vrijwel altijd de vaste afkortingen `np`, `plt` en `pd` gebruikt. Hierdoor kunnen functies kort worden aangeroepen:

#jupytercode([Python])[
```python
x = np.array([1, 2, 3, 4, 5])

gemiddelde = np.mean(x)

print(gemiddelde)
```

]

Je hoeft niet altijd een volledig package te importeren. Met

#jupytercode([Python])[
```python
from scipy.optimize import curve_fit
```

]

wordt bijvoorbeeld alleen de functie `curve_fit` uit de module `scipy.optimize` geïmporteerd. Deze kan daarna direct worden aangeroepen:

#jupytercode([Python])[
```python
popt, pcov = curve_fit(model, xdata, ydata)
```

]

#heading(level: 2, numbering: none)[Versie controleren]

Soms is het handig om te controleren welke versie van een package wordt gebruikt:

#jupytercode([Python])[
```python
print(np.__version__)
print(pd.__version__)
```

]

Voor een overzicht van de geïnstalleerde packages in de actieve conda-environment kun je in de terminal gebruiken:

#jupytercode([Terminal / uitvoer])[
```text
conda list
```

]

#methode(title: [ModuleNotFoundError])[
Krijg je een foutmelding zoals `ModuleNotFoundError`? Controleer dan eerst of in VS Code de juiste Python-environment of Jupyter-kernel is geselecteerd en of het betreffende package daarin is geïnstalleerd.

]

#heading(level: 1, numbering: none)[Datatypes, lijsten & arrays]

Python kent verschillende datatypes. Voor het werken met meetgegevens zijn vooral #strong[lijsten] (`list`) en #strong[NumPy-arrays] (`ndarray`) belangrijk.

Een gewone Python-lijst maak je bijvoorbeeld zo:

#jupytercode([Python])[
```python
tijd = [0, 1, 2, 3, 4]
spanning = [0.2, 1.1, 2.0, 3.2, 4.1]
```

]

Voor numerieke berekeningen gebruiken we meestal een NumPy-array:

#jupytercode([Python])[
```python
import numpy as np

tijd = np.array([0, 1, 2, 3, 4])
spanning = np.array([0.2, 1.1, 2.0, 3.2, 4.1])
```

]

Het grote voordeel van arrays is dat berekeningen direct op alle waarden kunnen worden uitgevoerd:

#jupytercode([Python])[
```python
spanning = np.array([1.0, 2.0, 3.0])

spanning_kwadraat = spanning**2

print(spanning_kwadraat)
```

]

Dit geeft:

#jupytercode([Terminal / uitvoer])[
```text
[1. 4. 9.]
```

]

Bij een Python-lijst werkt een vermenigvuldiging anders:

#jupytercode([Python])[
```python
x = [1, 2, 3]

print(x * 2)
```

]

Dit geeft:

#jupytercode([Terminal / uitvoer])[
```text
[1, 2, 3, 1, 2, 3]
```

]

Terwijl bij een NumPy-array:

#jupytercode([Python])[
```python
x = np.array([1, 2, 3])

print(x * 2)
```

]

het resultaat is:

#jupytercode([Terminal / uitvoer])[
```text
[2 4 6]
```

]

Voor het rekenen met meetdata gebruiken we daarom meestal #strong[NumPy-arrays].

#heading(level: 2, numbering: none)[Veelgebruikte datatypes]

#align(center)[#table(
    columns: (25%, 39%, 27%),
    align: (left,left,left,),
    table.header([#strong[Type]], [#strong[Voorbeeld]], [#strong[Gebruik]],),
    table.hline(),
    [Integer `int`], [`5`], [Gehele getallen],
    [Float `float`], [`5.2`], [Getallen met decimalen],
    [Boolean `bool`], [`True`, `False`], [Logische voorwaarden],
    [String `str`], [`"spanning"`], [Tekst],
    [List `list`], [`[1, 2, 3]`], [Verzameling Python-objecten],
    [NumPy-array `ndarray`], [`np.array([1, 2, 3])`], [Numerieke data en berekeningen],
  )]

Het datatype van een variabele kun je controleren met:

#jupytercode([Python])[
```python
print(type(spanning))
```

]

Bij NumPy-arrays kun je daarnaast het datatype van de #strong[elementen] bekijken:

#jupytercode([Python])[
```python
print(spanning.dtype)
```

]

#methode(title: [Efficiënte numerieke berekeningen])[
Gebruik voor numerieke meetgegevens bij voorkeur NumPy-arrays. Hiermee kun je berekeningen direct op volledige datasets uitvoeren zonder voor iedere bewerking een `for`-loop te schrijven.

]

#heading(level: 1, numbering: none)[Functies]

Een #strong[functie] is een stukje code dat een bepaalde bewerking uitvoert. Je geeft een functie één of meerdere waarden mee als #strong[argumenten] en de functie geeft meestal een resultaat terug.

Een eenvoudig voorbeeld is:

#jupytercode([Python])[
```python
x = np.sqrt(9)

print(x)
```

]

Hier is `np.sqrt()` de functie, `9` het argument en `3` de waarde die de functie teruggeeft.

Een functie kan ook meerdere argumenten hebben:

#jupytercode([Python])[
```python
x = np.round(3.14159, 2)

print(x)
```

]

Hier krijgt `np.round()` twee argumenten mee: het getal `3.14159` en het gewenste aantal decimalen `2`. NumPy bevat daarnaast veel wiskundige functies die op dezelfde manier direct op arrays kunnen worden toegepast:

#align(center)[#table(
    columns: (25%, 39%, 27%),
    align: (left,left,left,),
    table.header([#strong[Berekening]], [#strong[Python]], [#strong[Documentatie]],),
    table.hline(),
    [Wortel], [`np.sqrt(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.sqrt.html")[numpy.sqrt] \[5\]],
    [Macht], [`np.power(x, n)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.power.html")[numpy.power] \[6\]],
    [Exponentiële functie $e^x$], [`np.exp(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.exp.html")[numpy.exp] \[7\]],
    [Natuurlijke logaritme $ln \( x \)$], [`np.log(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.log.html")[numpy.log] \[8\]],
    [Logaritme $log_10 \( x \)$], [`np.log10(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.log10.html")[numpy.log10] \[9\]],
    [Sinus], [`np.sin(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.sin.html")[numpy.sin] \[10\]],
    [Cosinus], [`np.cos(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.cos.html")[numpy.cos] \[11\]],
    [Tangens], [`np.tan(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.tan.html")[numpy.tan] \[12\]],
    [Arcsinus], [`np.arcsin(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.arcsin.html")[numpy.arcsin] \[13\]],
    [Arccosinus], [`np.arccos(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.arccos.html")[numpy.arccos] \[14\]],
    [Arctangens], [`np.arctan(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.arctan.html")[numpy.arctan] \[15\]],
    [Absolute waarde], [`np.abs(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.absolute.html")[numpy.absolute] \[16\]],
    [Afronden], [`np.round(x, n)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.round.html")[numpy.round] \[17\]],
    [Graden $arrow.r$ radialen], [`np.deg2rad(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.deg2rad.html")[numpy.deg2rad] \[18\]],
    [Radialen $arrow.r$ graden], [`np.rad2deg(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.rad2deg.html")[numpy.rad2deg] \[19\]],
  )]

#veiligheid(title: [Radialen & graden])[
De goniometrische functies van NumPy gebruiken hoeken in #strong[radialen], niet in graden.

Dit gaat dus #strong[niet goed] wanneer `hoek` in graden staat:

#jupytercode([Python])[
```python
hoek = 30
y = np.sin(hoek)       # 30 wordt geïnterpreteerd als 30 radialen
```

]

Zet de hoek eerst om naar radialen:

#jupytercode([Python])[
```python
hoek = 30
hoek_rad = np.deg2rad(hoek)

y = np.sin(hoek_rad)   # sin(30°) = 0.5
```

]

Dit kan ook direct:

#jupytercode([Python])[
```python
y = np.sin(np.deg2rad(30))
```

]

]

Een volledig overzicht is te vinden in de #link("https://numpy.org/doc/stable/reference/routines.math.html")[NumPy Mathematical functions-documentatie] \[20\].

#heading(level: 1, numbering: none)[Indexeren, slicen & filteren]

Een enkele waarde uit een array kan worden geselecteerd met een #strong[index]:

#jupytercode([Python])[
```python
x = np.array([10, 20, 30, 40])

print(x[0])
print(x[2])
```

]

Python begint met tellen bij #strong[0]. `x[0]` is dus de eerste waarde en `x[2]` de derde waarde.

Met negatieve indices kun je vanaf het einde van een array tellen:

#jupytercode([Python])[
```python
print(x[-1])   # laatste waarde
print(x[-2])   # voorlaatste waarde
```

]

#heading(level: 2, numbering: none)[Een deel van een array selecteren]

Met een #strong[slice] kun je meerdere opeenvolgende waarden selecteren:

#jupytercode([Python])[
```python
x = np.array([10, 20, 30, 40, 50])

print(x[1:4])
```

]

Dit geeft:

#jupytercode([Terminal / uitvoer])[
```text
[20 30 40]
```

]

Bij `x[1:4]` wordt index `1` #strong[wel] meegenomen, maar index `4` #strong[niet].

De algemene notatie is:

#jupytercode([Terminal / uitvoer])[
```text
x[start:stop:stap]
```

]

Bijvoorbeeld:

#jupytercode([Python])[
```python
print(x[:3])     # eerste drie waarden
print(x[2:])     # vanaf index 2
print(x[::2])    # iedere tweede waarde
print(x[::-1])   # omgekeerde volgorde
```

]

#heading(level: 2, numbering: none)[Selecteren met een voorwaarde]

NumPy kan ook waarden selecteren die aan een bepaalde voorwaarde voldoen:

#jupytercode([Python])[
```python
x = np.array([1, 2, 3, 4, 5])

selectie = x[x > 3]

print(selectie)
```

]

Dit geeft:

#jupytercode([Terminal / uitvoer])[
```text
[4 5]
```

]

Ook meerdere voorwaarden kunnen worden gecombineerd:

#jupytercode([Python])[
```python
selectie = x[(x >= 2) & (x <= 4)]

print(selectie)
```

]

Dit geeft:

#jupytercode([Terminal / uitvoer])[
```text
[2 3 4]
```

]

Gebruik bij NumPy-arrays `&` voor #strong[en] en `|` voor #strong[of]. Zet de afzonderlijke voorwaarden tussen haakjes.

#heading(level: 2, numbering: none)[Veelgebruikte selecties en vergelijkingen]

#align(center)[#table(
    columns: (25%, 39%, 27%),
    align: (left,left,left,),
    table.header([#strong[Bewerking]], [#strong[Python]], [#strong[Betekenis]],),
    table.hline(),
    [Eerste waarde], [`x[0]`], [Element met index 0],
    [Derde waarde], [`x[2]`], [Element met index 2],
    [Laatste waarde], [`x[-1]`], [Laatste element],
    [Eerste drie waarden], [`x[:3]`], [Index 0 t/m 2],
    [Vanaf derde waarde], [`x[2:]`], [Vanaf index 2],
    [Deel van array], [`x[1:4]`], [Index 1 t/m 3],
    [Iedere tweede waarde], [`x[::2]`], [Stapgrootte 2],
    [Array omkeren], [`x[::-1]`], [Omgekeerde volgorde],
    [Groter dan], [`x[x > 3]`], [Waarden groter dan 3],
    [Kleiner dan], [`x[x < 3]`], [Waarden kleiner dan 3],
    [Groter of gelijk], [`x[x >= 3]`], [Waarden groter dan of gelijk aan 3],
    [Gelijk aan], [`x[x == 3]`], [Waarden gelijk aan 3],
    [Niet gelijk aan], [`x[x != 3]`], [Waarden ongelijk aan 3],
    [Tussen twee waarden], [`x[(x >= 2) & (x <= 4)]`], [Waarden tussen 2 en 4],
    [Aan één van twee voorwaarden], [`x[(x < 2) \| (x > 4)]`], [Logische OF],
  )]

#methode(title: [Vaste selectie])[
Dezelfde selectie kan ook op een tweede array worden toegepast. Dit is erg handig bij het verwerken van meetdata.

#jupytercode([Python])[
```python
tijd = np.array([0, 1, 2, 3, 4])
spanning = np.array([0.1, 1.2, 2.1, 3.2, 4.1])

selectie = tijd >= 2

tijd_selectie = tijd[selectie]
spanning_selectie = spanning[selectie]
```

]

Zo blijven de bij elkaar horende waarden van `tijd` en `spanning` gekoppeld wanneer je een deel van de meetdata selecteert.

Meer informatie is te vinden in de #link("https://numpy.org/doc/stable/user/basics.indexing.html")[NumPy-documentatie over indexing] \[21\].

]

#heading(level: 1, numbering: none)[Beschrijvende statistiek]

NumPy bevat functies voor veelgebruikte statistische berekeningen. Bijvoorbeeld voor een serie herhaalde metingen:

#jupytercode([Python])[
```python
import numpy as np

metingen = np.array([4.9, 5.1, 5.0, 5.2, 4.8])

gemiddelde = np.mean(metingen)
mediaan = np.median(metingen)
standaardafwijking = np.std(metingen, ddof=1)

N = len(metingen)
standaardfout = standaardafwijking / np.sqrt(N)

print("Gemiddelde:", gemiddelde)
print("Mediaan:", mediaan)
print("Standaardafwijking:", standaardafwijking)
print("Standaardfout:", standaardfout)
```

]

Bij experimentele meetreeksen gebruiken we voor de standaardafwijking meestal `ddof=1`, met minimaal twee metingen. Voor onafhankelijke herhaalde metingen onder dezelfde omstandigheden geeft de standaardfout de statistische onzekerheid in het gemiddelde. Systematische onzekerheden, zoals een kalibratiefout, zijn hierin niet opgenomen. De standaardfout wordt berekend met

#math.equation(block: true, numbering: none, $s_(macron(x)) = s / sqrt(N) .$)

#heading(level: 2, numbering: none)[Handige statistische functies]

#align(center)[#table(
    columns: (25%, 39%, 27%),
    align: (left,left,left,),
    table.header([#strong[Berekening]], [#strong[Python]], [#strong[Documentatie]],),
    table.hline(),
    [Gemiddelde], [`np.mean(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.mean.html")[numpy.mean] \[22\]],
    [Mediaan], [`np.median(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.median.html")[numpy.median] \[23\]],
    [Standaardafwijking], [`np.std(x, ddof=1)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.std.html")[numpy.std] \[24\]],
    [Variantie], [`np.var(x, ddof=1)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.var.html")[numpy.var] \[25\]],
    [Standaardfout], [`np.std(x, ddof=1) / np.sqrt(len(x))`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.std.html")[numpy.std] \[24\]],
    [Minimum], [`np.min(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.min.html")[numpy.min] \[26\]],
    [Maximum], [`np.max(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.max.html")[numpy.max] \[27\]],
    [Bereik], [`np.ptp(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.ptp.html")[numpy.ptp] \[28\]],
    [Som], [`np.sum(x)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.sum.html")[numpy.sum] \[29\]],
    [Aantal waarden], [`len(x)`], [#link("https://docs.python.org/3/library/functions.html#len")[Python len] \[30\]],
    [Percentiel], [`np.percentile(x, p)`], [#link("https://numpy.org/doc/stable/reference/generated/numpy.percentile.html")[numpy.percentile] \[31\]],
  )]

Een volledig overzicht van de beschikbare statistische functies is te vinden in de #link("https://numpy.org/doc/stable/reference/routines.statistics.html")[NumPy Statistics-documentatie] \[32\].

#heading(level: 1, numbering: none)[Figuren maken]

Voor het maken van figuren gebruiken we #strong[Matplotlib]. Een figuur bestaat uit een `figure` en één of meerdere assen (`ax`). De meeste instellingen van de grafiek worden vervolgens via `ax` aangepast.

#heading(level: 2, numbering: none)[Eenvoudige lijnplot]

Een eenvoudige lijnplot maak je met `ax.plot()`:

#jupytercode([Python])[
```python
import numpy as np
import matplotlib.pyplot as plt

x = np.array([0, 1, 2, 3, 4])
y = np.array([0, 1, 4, 9, 16])

fig, ax = plt.subplots(figsize=(6, 4))

ax.plot(x, y)

ax.set_xlabel("Tijd (s)")
ax.set_ylabel("Afstand (m)")

fig.tight_layout()
plt.show()
```

]

Gebruik bij de assen altijd de #strong[grootheid en eenheid]. Gebruik dus bijvoorbeeld `"Tijd (s)"` en `"Spanning (V)"` in plaats van alleen `"x"` en `"y"`.

#heading(level: 2, numbering: none)[Meetdata met foutbalken]

Voor experimentele meetdata gebruiken we meestal `ax.errorbar()`. Hiermee kunnen de meetonzekerheden direct als foutbalken worden weergegeven.

#jupytercode([Python])[
```python
import numpy as np
import matplotlib.pyplot as plt

xdata = np.array([1, 2, 3, 4, 5])
ydata = np.array([1.1, 1.9, 3.2, 3.9, 5.1])
yerr = np.array([0.1] * 5)

fig, ax = plt.subplots(figsize=(6, 4))

ax.errorbar(
    xdata,
    ydata,
    yerr=yerr,
    fmt="o",
    capsize=3
)

ax.set_xlabel("Tijd (s)")
ax.set_ylabel("Positie (m)")

fig.tight_layout()
plt.show()
```

]

Als ook de $x$-waarden een onzekerheid hebben, kan `xerr` worden toegevoegd:

#jupytercode([Python])[
```python
xerr = np.array([0.05] * 5)

ax.errorbar(
    xdata,
    ydata,
    xerr=xerr,
    yerr=yerr,
    fmt="o",
    capsize=3
)
```

]

#veiligheid(title: [Lijn versus scatter!])[
Verbind losse meetpunten niet automatisch met lijnen. Een lijn tussen meetpunten suggereert dat je ook iets weet over de waarden tussen de meetpunten. Gebruik voor experimentele meetdata daarom meestal losse punten met foutbalken. Een theoretisch model of fit kan wel als lijn worden weergegeven.

]

#heading(level: 2, numbering: none)[Veelgebruikte soorten plots]

Matplotlib bevat verschillende functies voor het visualiseren van data.

#align(center)[#table(
    columns: (15%, 29%, 25%, 19%),
    align: (left,left,left,left,),
    table.header([#strong[Type]], [#strong[Python]], [#strong[Gebruik]], [#strong[Documentatie]],),
    table.hline(),
    [Lijnplot], [`ax.plot(x, y)`], [Continue functie of model], [#link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.plot.html")[plot] \[33\]],
    [Meetpunten], [`ax.plot(x, y, "o")`], [Losse datapunten], [#link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.plot.html")[plot] \[33\]],
    [Foutbalken], [`ax.errorbar(x, y, yerr=dy, fmt="o")`], [Meetdata met onzekerheden], [#link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.errorbar.html")[errorbar] \[34\]],
    [Scatterplot], [`ax.scatter(x, y)`], [Relatie tussen twee variabelen], [#link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.scatter.html")[scatter] \[35\]],
    [Histogram], [`ax.hist(x)`], [Verdeling van meetwaarden], [#link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.hist.html")[hist] \[36\]],
    [Staafdiagram], [`ax.bar(x, y)`], [Vergelijken van categorieën], [#link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.bar.html")[bar] \[37\]],
    [Horizontale lijn], [`ax.axhline(y)`], [Referentiewaarde aangeven], [#link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.axhline.html")[axhline] \[38\]],
    [Verticale lijn], [`ax.axvline(x)`], [Referentiewaarde aangeven], [#link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.axvline.html")[axvline] \[39\]],
  )]

Een volledig overzicht van de mogelijkheden is te vinden in de #link("https://matplotlib.org/stable/plot_types/index.html")[Matplotlib-documentatie] \[40\].

#heading(level: 2, numbering: none)[Veelgebruikte instellingen]

De eigenschappen van een figuur kunnen via `ax` worden aangepast:

#align(center)[#table(
    columns: (44%, 50%),
    align: (left,left,),
    table.header([#strong[Instelling]], [#strong[Python]],),
    table.hline(),
    [Label x-as], [`ax.set_xlabel("Tijd (s)")`],
    [Label y-as], [`ax.set_ylabel("Spanning (V)")`],
    [Titel], [`ax.set_title("Meting")`],
    [Legenda], [`ax.legend()`],
    [Raster], [`ax.grid()`],
    [x-bereik], [`ax.set_xlim(xmin, xmax)`],
    [y-bereik], [`ax.set_ylim(ymin, ymax)`],
    [Logaritmische x-as], [`ax.set_xscale("log")`],
    [Logaritmische y-as], [`ax.set_yscale("log")`],
    [Minor ticks], [`ax.minorticks_on()`],
    [Figuur netjes uitlijnen], [`fig.tight_layout()`],
  )]

Bij meerdere datasets of een combinatie van meetdata en een model kan met `label` een legenda worden gemaakt:

#jupytercode([Python])[
```python
ax.errorbar(
    xdata,
    ydata,
    yerr=yerr,
    fmt="o",
    capsize=3,
    label="Meetdata"
)

ax.plot(x, y, label="Model")

ax.legend()
```

]

#heading(level: 1, numbering: none)[Een publicatiewaardige figuur]

Een figuur voor een verslag, poster of presentatie moet #strong[zelfstandig leesbaar] zijn. De lezer moet kunnen zien welke grootheden zijn weergegeven, welke onzekerheden bij de metingen horen en welke onderdelen meetdata of modelresultaten zijn.

Een goed uitgangspunt is:

#jupytercode([Python])[
```python
import numpy as np
import matplotlib.pyplot as plt

xdata = np.array([1, 2, 3, 4, 5])
ydata = np.array([1.1, 1.9, 3.2, 3.9, 5.1])
yerr = np.array([0.1] * 5)

fig, ax = plt.subplots(figsize=(6, 4))

ax.errorbar(
    xdata,
    ydata,
    yerr=yerr,
    fmt="o",
    markersize=5,
    capsize=3,
    linewidth=1,
    label="Meetdata"
)

ax.set_xlabel("Tijd (s)")
ax.set_ylabel("Positie (m)")

ax.tick_params(
    direction="in",
    top=True,
    right=True
)

ax.minorticks_on()

ax.legend(frameon=False)

fig.tight_layout()
plt.show()
```

]

#heading(level: 2, numbering: none)[Aanbevolen instellingen]

#align(center)[#table(
    columns: (25%, 39%, 27%),
    align: (left,left,left,),
    table.header([#strong[Onderdeel]], [#strong[Instelling]], [#strong[Opmerking]],),
    table.hline(),
    [Figuurgrootte], [`figsize=(6, 4)`], [Goed uitgangspunt voor een losse figuur],
    [Meetpunten], [`fmt="o"`], [Duidelijke losse meetpunten],
    [Puntgrootte], [`markersize=5`], [Niet te groot en niet te klein],
    [Foutbalken], [`capsize=3`], [Maakt foutbalken beter leesbaar],
    [Lijndikte], [`linewidth=1`], [Rustige, duidelijke lijnen],
    [Assenlabels], [`set_xlabel()`, `set_ylabel()`], [Altijd grootheid én eenheid],
    [Tickrichting], [`direction="in"`], [Veelgebruikt in wetenschappelijke figuren],
    [Ticks boven/rechts], [`top=True`, `right=True`], [Geeft een rustig afgesloten assenstelsel],
    [Minor ticks], [`minorticks_on()`], [Handig voor nauwkeurig aflezen],
    [Legenda], [`legend(frameon=False)`], [Alleen nodig bij meerdere datasets of modellen],
    [Uitlijning], [`tight_layout()`], [Voorkomt afgesneden labels],
  )]

#heading(level: 2, numbering: none)[Lettergrootte instellen]

Voor een verslag is het handig om de lettergroottes expliciet in te stellen:

#jupytercode([Python])[
```python
plt.rcParams.update({
    "font.size": 11,
    "axes.labelsize": 12,
    "xtick.labelsize": 10,
    "ytick.labelsize": 10,
    "legend.fontsize": 10
})
```

]

Zet dit bij voorkeur bovenaan het script, vóór het maken van de figuur.

#heading(level: 2, numbering: none)[Figuur opslaan]

Voor een verslag heeft een vectorformaat zoals PDF meestal de voorkeur:

#jupytercode([Python])[
```python
fig.savefig(
    "figuur.pdf",
    bbox_inches="tight"
)
```

]

Voor PNG:

#jupytercode([Python])[
```python
fig.savefig(
    "figuur.png",
    dpi=300,
    bbox_inches="tight"
)
```

]

Gebruik voor een publicatiewaardige rasterafbeelding bij voorkeur minimaal `dpi=300`.

#methode(title: [Goede figuren])[
Een goede wetenschappelijke figuur bevat alleen informatie die nodig is om de data te begrijpen. Gebruik dus geen decoratieve achtergronden, overmatige kleuren, dikke rasterlijnen of 3D-effecten.

]

Een goede figuur bevat in ieder geval:

+ duidelijk leesbare assen;

+ grootheden en eenheden bij de assen;

+ foutbalken wanneer meetonzekerheden bekend zijn;

+ een legenda wanneer meerdere datasets of modellen worden weergegeven;

+ voldoende grote tekst en symbolen;

+ geen onnodige visuele elementen.

#methode(title: [Titels, legenda's en onderschriften])[
Gebruik een onderschrift om de meting, het model en de betekenis van de foutbalken toe te lichten. Een titel is vaak overbodig wanneer het onderschrift dezelfde informatie geeft. Een legenda is wel nuttig om meerdere datasets of modellen te onderscheiden. Houd assenlabels en eenheden in de figuur zelf.

]

#heading(level: 1, numbering: none)[Een model fitten]

Wanneer uit de theorie een wiskundig model volgt voor het verband tussen twee grootheden, kunnen we de onbekende parameters van dat model bepalen door het model aan de meetdata te #strong[fitten].

Bij een fit zoekt Python naar de waarden van de modelparameters waarvoor het model zo goed mogelijk overeenkomt met de meetgegevens, rekening houdend met de opgegeven meetonzekerheden.

Stel dat we op basis van de theorie een lineair verband verwachten:

#math.equation(block: true, numbering: none, $y = a x + b .$)

Hierbij zijn:

- $x$ en $y$ de gemeten grootheden;

- $a$ de richtingscoëfficiënt;

- $b$ het snijpunt met de $y$-as.

De parameters $a$ en $b$ zijn dus de onbekende grootheden die we met de fit willen bepalen.

#heading(level: 2, numbering: none)[Stap 1 --- Het model definiëren]

We schrijven het theoretische model eerst als Python-functie:

#jupytercode([Python])[
```python
def linear(x, a, b):
    return a * x + b
```

]

De eerste invoer `x` is de onafhankelijke variabele. De overige invoeren, hier `a` en `b`, zijn de parameters die door de fit moeten worden bepaald.

#heading(level: 2, numbering: none)[Stap 2 --- Meetdata invoeren]

We gebruiken als voorbeeld de volgende meetgegevens:

#jupytercode([Python])[
```python
import numpy as np
from scipy.optimize import curve_fit

xdata = np.array([1, 2, 3, 4, 5])
ydata = np.array([1.1, 1.9, 3.2, 3.9, 5.1])

yerr = np.array([0.1] * 5)
```

]

Hier bevat `yerr` de positieve standaardonzekerheid (één sigma) van iedere gemeten $y$-waarde. We nemen onafhankelijke meetfouten aan. `curve_fit` neemt onzekerheden in de $x$-waarden niet mee: ook het tekenen van `xerr` verandert dat niet.

#heading(level: 2, numbering: none)[Stap 3 --- De fit uitvoeren]

De fit voeren we uit met `curve_fit()` uit SciPy:

#jupytercode([Python])[
```python
p0 = [1, 0]

popt, pcov = curve_fit(
    linear,
    xdata,
    ydata,
    sigma=yerr,
    p0=p0,
    absolute_sigma=True
)
```

]

De belangrijkste argumenten zijn:

#align(center)[#table(
    columns: (44%, 50%),
    align: (left,left,),
    table.header([#strong[Argument]], [#strong[Betekenis]],),
    table.hline(),
    [`linear`], [het model dat wordt gefit],
    [`xdata`], [de gemeten waarden van $x$],
    [`ydata`], [de gemeten waarden van $y$],
    [`sigma=yerr`], [de onzekerheden van de $y$-metingen],
    [`p0=[1, 0]`], [eerste schatting van de parameters $a$ en $b$],
    [`absolute_sigma=True`], [zorgt ervoor dat `yerr` als absolute meetonzekerheid wordt gebruikt],
  )]

De functie geeft twee resultaten terug:

#jupytercode([Python])[
```python
popt
pcov
```

]

`popt` bevat de gevonden optimale waarden van de fitparameters. In dit voorbeeld geldt:

#jupytercode([Python])[
```python
a = popt[0]
b = popt[1]
```

]

`pcov` is de covariantiematrix van de fitparameters. Hieruit kunnen we de onzekerheden van $a$ en $b$ bepalen.

Bij een niet-lineair model is deze onzekerheidsschatting gebaseerd op een lokale lineaire benadering. Zonder `absolute_sigma=True` schaalt SciPy de covariantiematrix met de gereduceerde chi-kwadraat. Zie de #link("https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.curve_fit.html")[documentatie van curve\_fit] \[41\].

#methode(title: [Volgorde van de parameters])[
De volgorde in `popt` is dezelfde als de volgorde van de parameters in de modeldefinitie.

Bij

#jupytercode([Python])[
```python
def linear(x, a, b):
    return a * x + b
```

]

geldt dus:

#jupytercode([Python])[
```python
popt[0]   # a
popt[1]   # b
```

]

]

#heading(level: 2, numbering: none)[Onzekerheid van de fitparameters]

Een fit levert niet alleen de beste waarden van de parameters op, maar ook informatie over hun onzekerheid.

De standaardonzekerheden van de fitparameters volgen uit de diagonaalelementen van `pcov`:

#jupytercode([Python])[
```python
perr = np.sqrt(np.diag(pcov))

a = popt[0]
b = popt[1]

a_err = perr[0]
b_err = perr[1]

print("a =", a, "+-", a_err)
print("b =", b, "+-", b_err)
```

]

Voor deze meetdata vinden we ongeveer:

#math.equation(block: true, numbering: none, $a = 1.000 plus.minus 0.032$)

en

#math.equation(block: true, numbering: none, $b = 0.040 plus.minus 0.105 .$)

Het resultaat van de fit rapporteer je dus inclusief de onzekerheid van de gevonden parameters.

#veiligheid(title: [Onzekerheid in x])[
`curve_fit()` verwerkt met `sigma=` alleen onzekerheden in de $y$-waarden.

Als de onzekerheid in $x$ niet verwaarloosbaar is, is deze eenvoudige aanpak niet voldoende.

]

#heading(level: 2, numbering: none)[Fit en meetdata samen plotten]

Om de fit te beoordelen is het belangrijk om zowel de meetdata als het gefitte model te bekijken.

De meetdata tekenen we als losse punten met foutbalken. Voor het model maken we een fijn verdeelde reeks $x$-waarden, zodat de fit als een vloeiende lijn wordt weergegeven.

#jupytercode([Python])[
```python
import matplotlib.pyplot as plt

xfit = np.linspace(
    np.min(xdata),
    np.max(xdata),
    200
)

yfit = linear(xfit, *popt)

fig, ax = plt.subplots(figsize=(6, 4))

ax.errorbar(
    xdata,
    ydata,
    yerr=yerr,
    fmt="o",
    capsize=3,
    label="Meetdata"
)

ax.plot(
    xfit,
    yfit,
    label="Lineaire fit"
)

ax.set_xlabel("Tijd (s)")
ax.set_ylabel("Positie (m)")

ax.tick_params(
    direction="in",
    top=True,
    right=True
)

ax.minorticks_on()
ax.legend(frameon=False)

fig.tight_layout()
plt.show()
```

]

De uitdrukking

#jupytercode([Python])[
```python
linear(xfit, *popt)
```

]

is een korte schrijfwijze voor:

#jupytercode([Python])[
```python
linear(xfit, popt[0], popt[1])
```

]

Het sterretje `*` pakt de waarden uit `popt` uit en geeft ze afzonderlijk door aan de functie.

#methode(title: [Meetpunten en fitlijn])[
De 200 waarden in `xfit` zijn #strong[geen extra meetpunten].

Ze worden alleen gebruikt om het wiskundige model als een vloeiende lijn weer te geven.

]

#heading(level: 2, numbering: none)[De kwaliteit van een fit beoordelen]

Het feit dat Python een fit kan uitvoeren betekent nog niet automatisch dat het gekozen model de meetdata goed beschrijft.

Een eerste stap is daarom altijd:

+ bekijk de meetpunten en foutbalken;

+ bekijk de fitlijn;

+ controleer of er systematische afwijkingen zichtbaar zijn;

+ bereken eventueel de chi-kwadraat en bekijk de residuen.

#heading(level: 2, numbering: none)[Chi-kwadraat]

De chi-kwadraat vergelijkt de afwijking tussen iedere meetwaarde en het model met de onzekerheid van die meting:

#math.equation(block: true, numbering: none, $chi^2 = sum_i (frac(y_i - y_(upright(m o d e l) \, i), sigma_i))^2 .$)

Voor ieder meetpunt wordt dus gekeken naar:

#math.equation(block: true, numbering: none, $frac(y_i - y_(upright(m o d e l) \, i), sigma_i) = upright("afwijking tussen meting en model") / upright("onzekerheid van de meting") .$)

Een afwijking van bijvoorbeeld $0.2$ is veel belangrijker wanneer de meetonzekerheid $0.01$ is dan wanneer de meetonzekerheid $0.5$ is.

In Python:

#jupytercode([Python])[
```python
y_model = linear(xdata, *popt)

chi2 = np.sum(
    ((ydata - y_model) / yerr)**2
)

print("chi^2 =", chi2)
```

]

#heading(level: 2, numbering: none)[Gereduceerde chi-kwadraat]

De gewone $chi^2$ hangt onder andere af van het aantal meetpunten. Daarom gebruiken we vaak de #strong[gereduceerde chi-kwadraat]:

#math.equation(block: true, numbering: none, $chi_(upright(r e d))^2 = frac(chi^2, N - p) .$)

Hierbij is:

- $N$ het aantal meetpunten;

- $p$ het aantal vrije fitparameters;

- $N - p$ het aantal vrijheidsgraden.

Voor het lineaire model zijn er twee fitparameters, namelijk $a$ en $b$. Bij vijf meetpunten geldt dus:

#math.equation(block: true, numbering: none, $N - p = 5 - 2 = 3 .$)

In Python:

#jupytercode([Python])[
```python
dof = len(xdata) - len(popt)

chi2_red = chi2 / dof

print("Vrijheidsgraden =", dof)
print("chi^2_red =", chi2_red)
```

]

Voor de voorbeelddata vinden we ongeveer:

#align(center)[#table(
    columns: (44%, 50%),
    align: (left,left,),
    table.header([#strong[Grootheid]], [#strong[Waarde]],),
    table.hline(),
    [$a$], [$1.000 plus.minus 0.032$],
    [$b$], [$0.040 plus.minus 0.105$],
    [$chi^2$], [$7.20$],
    [Vrijheidsgraden $N - p$], [$3$],
    [$chi_(upright(r e d))^2$], [$2.40$],
  )]

Bij onafhankelijke, normaal verdeelde meetfouten met correct opgegeven standaardonzekerheden en een geschikt model verwachten we een waarde van $chi_(upright(r e d))^2$ van #strong[orde 1]. Hiervoor moet $N > p$ gelden. Bij weinig vrijheidsgraden kan de waarde sterk fluctueren; voor een lineair model is de standaardafwijking van deze grootheid $sqrt(2 \/ \( N - p \))$.

Een veel grotere waarde kan bijvoorbeeld betekenen dat:

- het gekozen model de meetdata niet goed beschrijft;

- de meetonzekerheden te klein zijn geschat;

- er systematische effecten aanwezig zijn die niet in het model zijn opgenomen.

Een veel kleinere waarde kan bijvoorbeeld betekenen dat de meetonzekerheden ruim zijn geschat.

#veiligheid(title: [Geen automatische goed/fout-test])[
Gebruik $chi_(upright(r e d))^2$ niet als automatische grens tussen een goede en slechte fit.

Bekijk altijd ook de meetpunten, foutbalken, fitlijn en residuen.

]

#heading(level: 2, numbering: none)[Residuen bekijken]

De #strong[residuen] zijn de verschillen tussen de gemeten waarden en de waarden die het model voorspelt:

#math.equation(block: true, numbering: none, $epsilon.alt_i = y_i - y_(upright(m o d e l) \, i) .$)

In Python:

#jupytercode([Python])[
```python
y_model = linear(xdata, *popt)

residuen = ydata - y_model

print(residuen)
```

]

Een positief residu betekent dat de meetwaarde #strong[boven] het model ligt. Een negatief residu betekent dat de meetwaarde #strong[onder] het model ligt.

De residuen kunnen ook worden geplot:

#jupytercode([Python])[
```python
fig, ax = plt.subplots(figsize=(6, 3))

ax.errorbar(
    xdata,
    residuen,
    yerr=yerr,
    fmt="o",
    capsize=3
)

ax.axhline(
    0,
    linewidth=1
)

ax.set_xlabel("Tijd (s)")
ax.set_ylabel("Residu (m)")

ax.tick_params(
    direction="in",
    top=True,
    right=True
)

ax.minorticks_on()

fig.tight_layout()
plt.show()
```

]

Bij een geschikt model verwacht je dat de residuen zonder duidelijk systematisch patroon rond nul verspreid liggen.

Bijvoorbeeld:

- willekeurig boven en onder nul $arrow.r$ model kan geschikt zijn;

- een kromming in de residuen $arrow.r$ mogelijk is het gekozen model te eenvoudig;

- residuen steeds aan één kant van nul $arrow.r$ mogelijk is er een systematische afwijking.

#methode(title: [Een fit beoordelen])[
Kijk bij het beoordelen van een fit dus niet alleen naar de gevonden fitparameters.

Gebruik in ieder geval:

#strong[meetdata + foutbalken $arrow.r$ fitlijn $arrow.r$ residuen $arrow.r$ $chi_(upright(r e d))^2$].

]

#heading(level: 1, numbering: none)[Data inlezen uit een CSV-bestand]

Meetgegevens worden vaak opgeslagen in een #strong[CSV-bestand]. Met Pandas kan zo'n bestand eenvoudig worden ingelezen:

#jupytercode([Python])[
```python
import pandas as pd

data = pd.read_csv("metingen.csv")
```

]

Een kolom kan vervolgens worden geselecteerd met:

#jupytercode([Python])[
```python
tijd = data["tijd"]
spanning = data["spanning"]
```

]

#heading(level: 2, numbering: none)[Instellingen voor `read_csv()`]

Met onderstaande instellingen geef je aan #strong[hoe het bestand is opgebouwd]:

#align(center)[#table(
    columns: (25%, 39%, 27%),
    align: (left,left,left,),
    table.header([#strong[Instelling]], [#strong[Betekenis]], [#strong[Voorbeeld]],),
    table.hline(),
    [`sep`], [Scheidingsteken tussen kolommen], [`sep=";"`],
    [`decimal`], [Decimaalteken], [`decimal=","`],
    [`header`], [Welke regel de kolomnamen bevat], [`header=0`],
    [`names`], [Zelf kolomnamen opgeven], [`names=["tijd", "spanning"]`],
    [`skiprows`], [Aantal regels bovenaan overslaan], [`skiprows=2`],
    [`usecols`], [Alleen bepaalde kolommen inlezen], [`usecols=["tijd", "spanning"]`],
    [`na_values`], [Waarden die als ontbrekende data moeten worden gezien], [`na_values=["-", "N/A"]`],
    [`comment`], [Teken waarmee commentaarregels beginnen], [`comment="#"`],
  )]

Bekijk voor alle beschikbare instellingen de documentatie van #link("https://pandas.pydata.org/docs/reference/api/pandas.read_csv.html")[Pandas] \[42\].

Een CSV-bestand uit Nederlandse software gebruikt bijvoorbeeld vaak een #strong[puntkomma als scheidingsteken] en een #strong[komma als decimaalteken]:

#jupytercode([Terminal / uitvoer])[
```text
tijd;spanning;onzekerheid
0;0,12;0,02
1;1,05;0,02
2;2,08;0,03
```

]

Dit lees je in met:

#jupytercode([Python])[
```python
data = pd.read_csv(
    "metingen.csv",
    sep=";",
    decimal=","
)
```

]

#methode(title: [Controleer de data])[
Controleer na het inlezen altijd kort of de kolommen en getallen correct zijn ingelezen:

#jupytercode([Python])[
```python
print(data.head())
print(data.dtypes)
```

]

Worden getallen niet als numerieke waarden herkend? Controleer dan eerst `sep` en `decimal`.

]

#heading(level: 1, numbering: none)[Veelvoorkomende fouten]

Een foutmelding in Python bevat meestal informatie over #strong[wat er fout gaat en waar de fout optreedt]. Kijk daarom altijd eerst naar de laatste regel van de foutmelding. Hier staat meestal het type fout, bijvoorbeeld `NameError`, `ValueError` of `FileNotFoundError`.

#heading(level: 2, numbering: none)[`NameError`]

Bijvoorbeeld:

#jupytercode([Terminal / uitvoer])[
```text
NameError: name 'np' is not defined
```

]

Python kent de naam `np` niet. Waarschijnlijk is NumPy nog niet geïmporteerd:

#jupytercode([Python])[
```python
import numpy as np
```

]

Een `NameError` kan ook ontstaan door een typefout in een variabelenaam:

#jupytercode([Python])[
```python
spanning = 5.0

print(spaning)  # typefout
```

]

#methode(title: [NameError])[
Controleer bij een `NameError` of de variabele of functie al is gedefinieerd en of de naam correct is gespeld.

]

#heading(level: 2, numbering: none)[`ModuleNotFoundError`]

Bijvoorbeeld:

#jupytercode([Terminal / uitvoer])[
```text
ModuleNotFoundError: No module named 'scipy'
```

]

Python kan het package niet vinden. Controleer eerst of in VS Code de juiste #strong[Python-environment of Jupyter-kernel] is geselecteerd.

Wanneer SciPy nog niet in de gebruikte conda-environment staat, installeer je het vanuit de terminal met:

#jupytercode([Terminal / uitvoer])[
```text
conda install scipy
```

]

Je kunt controleren welke packages in de actieve environment zijn geïnstalleerd met:

#jupytercode([Terminal / uitvoer])[
```text
conda list
```

]

#heading(level: 2, numbering: none)[`FileNotFoundError`]

Bijvoorbeeld:

#jupytercode([Terminal / uitvoer])[
```text
FileNotFoundError: [Errno 2] No such file or directory: 'metingen.csv'
```

]

Python kan het opgegeven bestand niet vinden.

Controleer:

- of de bestandsnaam correct is;

- of de extensie klopt, bijvoorbeeld `.csv`\;

- of het bestand in de juiste map staat;

- of het juiste bestandspad is opgegeven.

Een relatief bestandspad wordt geïnterpreteerd ten opzichte van de #strong[huidige werkmap], niet automatisch de map van je script. Bekijk deze met `from pathlib import Path` en `print(Path.cwd())`.

Staat het bestand in de huidige werkmap:

#jupytercode([Python])[
```python
data = pd.read_csv("metingen.csv")
```

]

Staat het bestand in een submap `data`:

#jupytercode([Python])[
```python
data = pd.read_csv("data/metingen.csv")
```

]

#heading(level: 2, numbering: none)[`KeyError`]

Bijvoorbeeld:

#jupytercode([Terminal / uitvoer])[
```text
KeyError: 'spanning'
```

]

Dit komt bij Pandas vaak voor wanneer je een kolom probeert te selecteren die niet bestaat:

#jupytercode([Python])[
```python
spanning = data["spanning"]
```

]

Bekijk de beschikbare kolomnamen met:

#jupytercode([Python])[
```python
print(data.columns)
```

]

Controleer daarbij ook op hoofdletters en spaties. `"Spanning"` en `"spanning"` zijn voor Python verschillende namen.

#heading(level: 2, numbering: none)[`TypeError`]

Bijvoorbeeld:

#jupytercode([Terminal / uitvoer])[
```text
TypeError: can't multiply sequence by non-int of type 'float'
```

]

Een `TypeError` betekent dat een bewerking wordt uitgevoerd op een datatype waarvoor die bewerking niet is toegestaan.

Controleer het datatype met:

#jupytercode([Python])[
```python
print(type(x))
```

]

Bij meetgegevens kan het bijvoorbeeld nodig zijn om gegevens om te zetten naar een numeriek datatype:

#jupytercode([Python])[
```python
x = np.array(x, dtype=float)
```

]

#heading(level: 2, numbering: none)[`ValueError`]

Bijvoorbeeld:

#jupytercode([Terminal / uitvoer])[
```text
ValueError: could not convert string to float
```

]

Python verwacht een getal, maar vindt bijvoorbeeld tekst.

Dit komt bij meetbestanden onder andere voor wanneer getallen verkeerd worden ingelezen. Controleer dan bijvoorbeeld het #strong[decimaalteken] en #strong[scheidingsteken]:

#jupytercode([Python])[
```python
data = pd.read_csv(
    "metingen.csv",
    sep=";",
    decimal=","
)
```

]

Controleer eventueel de datatypes:

#jupytercode([Python])[
```python
print(data.dtypes)
```

]

#heading(level: 2, numbering: none)[`IndexError`]

Bijvoorbeeld:

#jupytercode([Terminal / uitvoer])[
```text
IndexError: index 5 is out of bounds
```

]

Je probeert een element uit een array op te vragen dat niet bestaat.

Bijvoorbeeld:

#jupytercode([Python])[
```python
x = np.array([10, 20, 30])

print(x[3])
```

]

Deze array heeft drie elementen, maar de indices zijn:

#jupytercode([Terminal / uitvoer])[
```text
0, 1, 2
```

]

Python begint bij index `0`.

#heading(level: 2, numbering: none)[Arrays hebben verschillende lengtes]

Bij het maken van een figuur kan bijvoorbeeld de volgende fout optreden:

#jupytercode([Terminal / uitvoer])[
```text
ValueError: x and y must have same first dimension
```

]

De arrays met $x$- en $y$-waarden hebben dan niet hetzelfde aantal elementen.

Controleer dit met:

#jupytercode([Python])[
```python
print(len(xdata))
print(len(ydata))
```

]

Voor iedere $x$-waarde moet er een bijbehorende $y$-waarde zijn.

Als je per meetpunt een foutbalk opgeeft, controleer dan ook:

#jupytercode([Python])[
```python
print(len(xdata))
print(len(ydata))
print(len(yerr))
```

]

Voor gelijke foutbalken mag `yerr` ook één getal zijn, bijvoorbeeld `yerr=0.1`. In dat geval is `len(yerr)` niet van toepassing.

#heading(level: 2, numbering: none)[`SyntaxError`]

Bijvoorbeeld:

#jupytercode([Terminal / uitvoer])[
```text
SyntaxError: invalid syntax
```

]

Python kan de geschreven code niet interpreteren. Veelvoorkomende oorzaken zijn:

#jupytercode([Python])[
```python
print("Hallo"       # haakje ontbreekt

x = [1, 2, 3       # blokhaakje ontbreekt

if x > 2           # dubbele punt ontbreekt
```

]

Controleer bij een `SyntaxError` vooral de regel die Python aanwijst én de regel direct daarvoor.

#methode(title: [Foutmeldingen lezen])[
Kijk bij een foutmelding eerst naar de #strong[laatste regel]. Daar staat meestal de belangrijkste informatie.

Bijvoorbeeld:

#jupytercode([Terminal / uitvoer])[
```text
FileNotFoundError: [Errno 2] No such file or directory: 'metingen.csv'
```

]

Hier vertelt Python zowel #strong[welk type fout] optreedt (`FileNotFoundError`) als #strong[wat het probleem is] (`metingen.csv` kan niet worden gevonden).

]

#heading(level: 1, numbering: none)[Documentatie voor op papier]

De nummers bij de links verwijzen naar onderstaande webadressen.

+ #link("https://numpy.org/doc/stable/")

+ #link("https://matplotlib.org/stable/")

+ #link("https://docs.scipy.org/doc/scipy/")

+ #link("https://pandas.pydata.org/docs/")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.sqrt.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.power.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.exp.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.log.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.log10.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.sin.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.cos.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.tan.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.arcsin.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.arccos.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.arctan.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.absolute.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.round.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.deg2rad.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.rad2deg.html")

+ #link("https://numpy.org/doc/stable/reference/routines.math.html")

+ #link("https://numpy.org/doc/stable/user/basics.indexing.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.mean.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.median.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.std.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.var.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.min.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.max.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.ptp.html")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.sum.html")

+ #link("https://docs.python.org/3/library/functions.html#len")

+ #link("https://numpy.org/doc/stable/reference/generated/numpy.percentile.html")

+ #link("https://numpy.org/doc/stable/reference/routines.statistics.html")

+ #link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.plot.html")

+ #link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.errorbar.html")

+ #link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.scatter.html")

+ #link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.hist.html")

+ #link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.bar.html")

+ #link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.axhline.html")

+ #link("https://matplotlib.org/stable/api/_as_gen/matplotlib.axes.Axes.axvline.html")

+ #link("https://matplotlib.org/stable/plot_types/index.html")

+ #link("https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.curve_fit.html")

+ #link("https://pandas.pydata.org/docs/reference/api/pandas.read_csv.html")

#pagebreak(weak: true)

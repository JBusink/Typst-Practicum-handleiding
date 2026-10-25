#import "../styl.typ": *
#show: stijl.with(titel: "Week4", kop: "Natuurkunde 2.1 Practicum — Week 4")

#praktikumtitle[Python Cursus: Week 4]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- CSV- en Excelbestanden inlezen en bewerken.

- Basis datacleaning: NaNs verwijderen, outliers detecteren.

- Interpolaties & Filter technieken (moving average) toepassen.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
We gaan programmeren, hier zijn geen veiligheidskwesties aan gebonden. Probeer alleen zoveel mogelijk zelfstandig te programmeren. Gebruik ChatGPT verstandig:

+ Gebruik het als uitlegmachine, niet als codegenerator

+ Gebruik het om eigen code te laten verbeteren, maar niet herschrijven

+ Gebruik het niet voor volledige oplossingen, snap je iets niet? Vraag het de docent.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Bijeenkomst 4: Functies, modules en herbruikbare code]

#heading(level: 2, numbering: none)[Leerdoelen]

- Classes & Methods.

- Object.

- API-handleidingen.

- Standaard fout codes.

#heading(level: 2, numbering: none)[Inhoud]

Hier leren studenten kleine, herbruikbare bouwstenen schrijven. Dit verkleint fouten, verhoogt transparantie en bereidt voor op grotere projecten.

```python
# utils.py
import numpy as np

def moving_average(x, N=20):
    return np.convolve(x, np.ones(N)/N, mode="same")

def lorentzian(x, A, x0, gamma):
    return A * gamma**2 / ((x - x0)**2 + gamma**2)
```

```python
# plotting.py
import matplotlib.pyplot as plt

def plot_with_fit(x, y, yfit):
    plt.plot(x, y, ".", label="data")
    plt.plot(x, yfit, "-", label="fit")
    plt.xlabel("x")
    plt.ylabel("y")
    plt.legend()
    plt.grid()
    plt.show()
```

#heading(level: 2, numbering: none)[Korte opdracht]

Maak een klein modulepakket dat:

- een moving average bevat;

- een Lorentz-profielfunctie bevat;

- een plotfunctie bevat die ruwe data en fit samen visualiseert.

#pagebreak(weak: true)

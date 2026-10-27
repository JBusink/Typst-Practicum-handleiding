#import "Practica/styl.typ": *

#show: stijl.with(studiejaar: "2026-2027")

#praktikumtitle[Practicum: Template]

= Leerdoelen
#leerdoelen(
  [Een meting uitvoeren en de onzekerheid schatten.],
  [Meetgegevens verwerken met Python.],
  [Resultaten presenteren in een tabel en grafiek.],
)

= Introductie

#voorbereiding(title: [Voorbereidingsopdracht 1])[
  Dit practicum vereist geen voorbereiding.
]

= Practicum

#opdracht(title: [Opdracht 1(a)])[
  + Meet de voorwerpafstand en de beeldafstand.
  + Noteer bij elke meting de onzekerheid.
    - Herhaal de meting minstens drie keer.
    - Gebruik steeds dezelfde eenheden.
]

#afronding[
  + Zet de gevonden figuren in je digitaal labjournaal en maak een duidelijk onderschrift waarin je uitlegt wat de figuren laten zien.
  + Vul de *Resultaat- en Discussie*-sectie aan in je labjournaal. Hierin moet de uiteindelijke waarde van jouw experiment (met onzekerheid) staan en een korte discussie of deze waarde *realistisch* en *betrouwbaar* is.
]

#pagebreak()
= Voorbeelden van code en tabellen

#jupytercode([Voorbeeld: fitten met #raw("curve_fit")])[
  ```python
  import numpy as np
  from scipy.optimize import curve_fit

  # Lineair model voor de meetgegevens
  def lineair(x, a, b):
      return a * x + b

  x = np.array([1.0, 2.0, 3.0, 4.0])
  y = np.array([1.1, 1.9, 3.2, 3.9])
  sigma = np.full(4, 0.1)
  popt, pcov = curve_fit(lineair, x, y, sigma=sigma,
                         absolute_sigma=True)
  print("Helling en intercept:", popt)
  ```
]

#figure(
  table(
    columns: (auto, auto, auto),
    table.header([Meting], [$v$ (cm)], [$b$ (cm)]),
    [1], [20,0 ± 0,1], [60,0 ± 0,2],
    [2], [25,0 ± 0,1], [37,5 ± 0,2],
    [3], [30,0 ± 0,1], [30,0 ± 0,2],
  ),
  kind: table,
  caption: [Voorbeeldmetingen met hun onzekerheden.],
) <tabel-voorbeeld>


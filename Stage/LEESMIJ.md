# Stageformulieren gebruiken

1. Bewerk de tekst in het gewenste `.typ`-bestand. De Typst-preview toont de opmaak.
2. Dubbelklik op **Maak invulbare PDFs.cmd**.
3. Open de gemaakte PDF in **PDF/** om deze in te vullen. Gebruik voor de automatische cijfers een PDF-lezer met JavaScript-ondersteuning, zoals Acrobat Reader.

Een gewone Typst-export bevat alleen de zichtbare vakken. Het startbestand
voegt de echte invulvelden, gekoppelde beoordelingen en cijferberekeningen toe.
Je blijft dus in `.typ` werken, maar hebt die bouwstap nodig voor een invulbare PDF.

De eerste keer kan de lokale bouwomgeving Python-pakketten downloaden.
Er is geen LaTeX-installatie nodig. De bouwcontrole verschijnt in het venster;
er worden geen JSON-rapporten gemaakt.

- **PDF/**: de vier actuele, invulbare formulieren.
- **ondersteuning/**: gedeelde opmaak, logo en technische bouwbestanden.
- **Archief/**: oorspronkelijke documenten en het competentieoverzicht.

Het lettertype en de lettergrootte volgen de practica: 11 pt, met de reeks
TeX Gyre Heros, Helvetica, Arial en Liberation Sans. Er zijn geen extra fonts
meegeleverd.

Een eventuele PDF die de editor naast een `.typ`-bestand exporteert is een
statische preview. Gebruik voor invullen steeds de versie uit **PDF/**.

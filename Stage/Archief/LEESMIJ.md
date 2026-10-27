# Stageformulieren in Typst

De vijf `.typ`-bestanden zijn de bewerkbare versies van de oorspronkelijke
LaTeX-documenten. De nieuwe PDF's staan in **PDF/**. De oorspronkelijke `.tex`
en `.pdf`-bestanden zijn bewaard in **Archief/**.

| Document | Nieuwe PDF |
| --- | --- |
| Feedback week 5, inclusief zelfreflectie | [Openen](PDF/Feedback_NLD_week5.pdf) |
| Feedback week 15 | [Openen](PDF/Feedback_NLD_week15.pdf) |
| Zelfreflectie week 15 | [Openen](PDF/Zelfreflectie_NLD_week15.pdf) |
| Criteriumgericht interview, inclusief berekeningen | [Openen](PDF/Criterium_Gericht_Interview.pdf) |
| Competentieoverzicht | [Openen](PDF/Das_Competenties.pdf) |

## Bewerken en bouwen

Pas tekst en indeling aan in het bijbehorende `.typ`-bestand. `formulier.typ`
bevat de gedeelde opmaak en de functies `veld`, `vink` en `scores`.

Voer vanuit de hoofdmap van de repository uit:

```powershell
python -m pip install -r Stage/requirements.txt
python Stage/build_stage.py
```

Een enkel document bouwen, eventueel in een andere uitvoermap:

```powershell
python Stage/build_stage.py --output Stage/PDF Criterium_Gericht_Interview
```

De Typst-preview toont de opmaak en de lege invulvakken. **Gebruik het
bouwscript voor de uiteindelijke interactieve PDF.** Het script compileert
Typst en zet de veldmarkeringen om naar echte AcroForm-velden. De posities
komen uit de Typst-uitvoer, zodat de velden bij gewijzigde tekst meeschuiven.
Er is bij het bouwen geen LaTeX-installatie of oorspronkelijke PDF nodig.

## Invullen en berekeningen

- De formulieren bevatten tekstvelden, meerregelige reflectievelden en
  selectievakjes. Het competentieoverzicht is een gewone PDF.
- De beoordelingen en persoonsgegevens die het interview op de slotpagina
  herhaalt, delen hetzelfde PDF-veld: invoer blijft op beide plekken gekoppeld.
- Het interview bevat het eindcijfer en drie alleen-lezen subtotalen. De
  berekening gebruikt de oorspronkelijke schaal: E = 10, G = 7,5, V = 5,5,
  M = 3,5 en O = 1. NvT telt niet mee. Zoals in het origineel tellen nog niet
  ingevulde onderdelen als 0; bij uitsluitend NvT blijft het cijfer leeg.
- PDF JavaScript laat per competentie één beoordeling toe en werkt de
  berekeningen bij. De code staat in `beoordeling.js` en wordt ingebed.
- Voor de PDF JavaScript-functies is een PDF-lezer met ondersteuning hiervoor
  nodig. Gebruik Adobe Acrobat Reader met JavaScript ingeschakeld. Andere
  lezers en browservoorbeelden kunnen de berekeningen of keuzeacties beperken.

De hergebruikte veldnamen voor **Project opleveren** en **Reflectie & feedback**
in de oorspronkelijke week-15-formulieren zijn uit elkaar gehaald. Deze
verschillende competenties beïnvloeden elkaars vinkjes daardoor niet meer.

## Controle

```powershell
python -m unittest discover -s Stage -p test_stage.py
```

De controles verifiëren de veldstructuur, gekoppelde velden, bewaarde invoer na
opslaan/heropenen, alle oorspronkelijke handelingsindicatoren en de
rekenregels. Voor de JavaScript-test is Node.js nodig op PATH, of via de
omgevingsvariabele `STAGE_NODE`. Zonder Node wordt alleen die test overgeslagen.
De PDF's zijn ook als afbeeldingen gecontroleerd. De JavaScript-tests draaien
met een nagebootste Acrobat-API; er is geen interactieve Acrobat-test uitgevoerd.

De uitvoermap bevat `bouwcontrole.json` met aantallen pagina's, velden en
veldweergaven per document. Het interview heeft meer veldweergaven dan unieke
velden vanwege de gekoppelde herhalingen.

Technische achtergrond: [Typst-links](https://typst.app/docs/reference/model/link/)
en [AcroForm-velden in pypdf](https://pypdf.readthedocs.io/en/stable/user/forms.html).

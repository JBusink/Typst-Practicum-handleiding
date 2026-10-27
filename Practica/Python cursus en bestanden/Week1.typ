#import "../Practica/styl.typ": *
#show: stijl.with(titel: "Week1", kop: "Natuurkunde 2.1 Practicum — Week 1")

#praktikumtitle[Python Cursus: Week 1]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Pythonontwikkelomgeving opzetten in VSCode.

- Leren werken met virtuele omgevingen in Python.

- Basis van projectstructuur.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
We gaan programmeren, hier zijn geen veiligheidskwesties aan gebonden. Probeer alleen zoveel mogelijk zelfstandig te programmeren. Gebruik ChatGPT verstandig:

+ Gebruik het als uitlegmachine, niet als codegenerator

+ Gebruik het om eigen code te laten verbeteren, maar niet herschrijven

+ Gebruik het niet voor volledige oplossingen, snap je iets niet? Vraag het de docent.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Bijeenkomst 1: Werken met VSCode en professionele workflow]

#heading(level: 2, numbering: none)[Deel 1: Installeer Python en VSCode-extensies.]

+ #strong[Installeer Python en VSCode-extensies.] \
  Controleer of Python is geïnstalleerd (`python --version`). Installeer in VSCode de extensies #strong[Python] en #strong[Pylance].

#methode(title: [Tips & Tricks: Conda verschijnt niet in de VSCode-terminal])[
- Zie je geen `(base)` in VSCode? Dan is conda niet geïnitialiseerd voor deze shell.

- Gebruik je PowerShell? Initialiseer conda via: `conda init powershell` (in Anaconda Prompt).

- Gebruik je Command Prompt (cmd)? Initialiseer conda via: `conda init cmd.exe`.

- Na initialisatie: sluit VSCode volledig af en open opnieuw.

- Open een #emph[nieuwe] terminal in VSCode --- oude terminals laden conda niet in.

]

#pagebreak(weak: true)

#heading(level: 2, numbering: none)[Deel 2: Projectmap en eerste bestanden]

+ Maak een nieuwe map aan, bijvoorbeeld `python_intro`, en open deze map in VSCode.

+ Maak in deze map (optioneel) een submap voor je scripts.

+ Maak een nieuw Pythonbestand `helloworld.py` in de projectmap met de volgende inhoud:

#jupytercode([helloworld.py])[
```python
import numpy as np

print("Hello world")

a = np.array([1, 2, 3, 4])
print("Array a:", a)
print("Array a^2:", a**2)
```

]

+ Maak in dezelfde map een nieuw Jupyter Notebook `helloworld.ipynb`. Voeg in de eerste cel dezelfde code toe als in `helloworld.py`:

#jupytercode([helloworld.ipynb -- eerste cel])[
```python
import numpy as np

print("Hello world from notebook")

a = np.array([1, 2, 3, 4])
print("Array a:", a)
print("Array a^2:", a**2)
```

]

#pagebreak(weak: true)

#heading(level: 2, numbering: none)[Deel 3: Virtuele omgeving aanmaken via Anaconda Prompt]

Open de #strong[Anaconda Prompt] en voer de onderstaande stappen uit:

#AnacondaNavigator([Anaconda Prompt: virtuele omgeving en installatie])[
```python
# Maak een nieuwe virtuele omgeving via Anaconda Prompt
(base) C:\Users\student> conda create -n python_cursus python=3.11
(base) C:\Users\student> conda activate python_cursus

# Installeer de benodigde pakketten
(python_cursus) C:\Users\student> pip install numpy ipykernel
```

]

#pagebreak(weak: true)

#heading(level: 2, numbering: none)[Deel 4: Test `helloworld.py` in de virtuele omgeving]

+ Zorg dat de omgeving `python_cursus` actief is in VSCode. \
  Kies rechtsboven in VSCode bij "Interpreter" voor: `python_cursus`.

+ Controleer in de terminal (onderin VSCode) of de omgeving actief is: \
  `conda activate python_cursus`

+ Navigeer in de terminal naar jouw projectmap, bijvoorbeeld:

#AnacondaNavigator([VSCode Terminal: navigeren naar projectmap])[
```python
(python_cursus) PS C:\Users\student> cd Documents\python_intro
```

]

+ Voer nu het script `helloworld.py` uit. Dit kan op twee manieren:

  - #strong[Via de Run-knop] in VSCode (rechtsboven in het editor-venster).

  - #strong[Via de terminal]:

#AnacondaNavigator([VSCode Terminal: uitvoeren van het script])[
```python
(python_cursus) PS C:\Users\student\python_intro> python helloworld.py
```

]

+ Controleer of de volgende output verschijnt:

  - De tekst `Hello world`

  - De NumPy-array en de gekwadrateerde waarden

#methode(title: [Veelvoorkomende fouten en tips])[
#strong[Veelvoorkomende fouten]

- Script wordt uitgevoerd met de verkeerde interpreter (bijv. `base`).

- Interpreter in VSCode staat niet op `python_cursus`, ondanks de Run-knop.

- Terminal in VSCode gebruikt PowerShell zonder geactiveerde omgeving.

- Pakketten (zoals NumPy) ontbreken omdat ze in de verkeerde omgeving zijn geïnstalleerd.

- Vekeerde map geopend.

- Terminal toont: `ModuleNotFoundError: No module named ’numpy’`.

#strong[Tips & tricks]

- Controleer in VSCode rechtsboven: interpreter moet `python_cursus` zijn.

- Open een nieuwe terminal in VSCode → omgeving wordt meestal automatisch geactiveerd.

- Check actief Python-pad met: `where python`.

- Voordat je runt: controleer dat je in de juiste projectmap staat.

- Installeer pakketten altijd ná `conda activate python_cursus`.

- Bij foutmeldingen: terminal sluiten, opnieuw openen, interpreter opnieuw kiezen.

]

#pagebreak(weak: true)

#heading(level: 2, numbering: none)[Deel 5: Test `helloworld.ipynb` in de virtuele omgeving]

+ Zorg dat de omgeving `python_cursus` een Jupyter-kernel heeft (eenmalig nodig):

#AnacondaNavigator([Anaconda Prompt: kernel installeren])[
```python
(python_cursus) C:\Users\student> python -m ipykernel install --user ^
    --name python_cursus --display-name "python_cursus"
```

]

+ Open VSCode, en open daarin `helloworld.ipynb`.

+ Selecteer bovenin het notebook als kernel/interpreter: `python_cursus`.

+ Run alle cellen van het notebook.

+ Controleer of de uitvoer overeenkomt met de uitvoer van `helloworld.py` (tekst en NumPy-array).

#methode(title: [Veelvoorkomende fouten en tips])[
#strong[Veelvoorkomende fouten]

- Notebook gebruikt een verkeerde kernel (meest voorkomend).

- De omgeving verschijnt niet als kernel omdat `ipykernel` ontbreekt.

- VSCode valt terug op de `base`-omgeving.

- Cell blijft hangen op "busy" door verkeerde kernelselectie.

- Packages ontbreken doordat ze in de verkeerde omgeving zijn geïnstalleerd.

#strong[Tips & tricks]

- Controleer rechtsboven in VSCode: staat de kernel op `python_cursus`?

- Herstart VSCode als de kernel niet zichtbaar is.

- Controleer welke Python gebruikt wordt met `where python`.

- Voer `pip list` uit in een cell om te checken dat NumPy in de juiste omgeving zit.

- Los notebookproblemen op via: #emph[Kernel → Restart kernel].

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 1:]

#AnacondaNavigator([Anaconda Prompt: handige standaardcommando's])[
```python
# Toon alle conda-omgevingen
(base) C:\Users\student> conda env list

# Nieuwe omgeving aanmaken
(base) C:\Users\student> conda create -n python_cursus python=3.11

# Een omgeving activeren / deactiveren
(base) C:\Users\student> conda activate python_cursus
(python_cursus) C:\Users\student> conda deactivate

# Installeer pakketten in de actieve omgeving
(python_cursus) C:\Users\student> pip install numpy matplotlib scipy

# Toon alle geïnstalleerde pakketten (conda)
(python_cursus) C:\Users\student> conda list

# Update een pakket
(python_cursus) C:\Users\student> conda install --upgrade numpy

# Verwijder een pakket
(python_cursus) C:\Users\student> conda uninstall numpy

# Verwijder een volledige omgeving
(base) C:\Users\student> conda remove -n python_cursus --all
```

]

#heading(level: 1, numbering: none)[Appendix 2:]

#methode(title: [Handige VSCode-extensies voor Python])[
- #strong[Python] --- officiële extensie voor Python-ondersteuning.

- #strong[Pylance] --- snelle en slimme taalserver (typechecking, foutdetectie).

- #strong[Jupyter] --- notebooks openen en uitvoeren in VSCode.

- #strong[Jupyter Keymap] --- handige notebook-sneltoetsen (zoals in JupyterLab).

- #strong[Jupyter Cell Tags] --- tags voor complexe notebooks.

- #strong[GitLens] --- versiebeheer, commits bekijken, file history.

- #strong[EditorConfig] --- consistente code-stijl binnen projecten.

- #strong[Indent Rainbow] --- kleurcodering van inspringing (minder fouten).

- #strong[Better Comments] --- TODO/FIXME/NOTE visueel markeren.

- #strong[Material Icon Theme] --- duidelijke iconen voor Python-projectstructuur.

]

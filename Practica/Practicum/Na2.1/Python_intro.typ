#import "../../Practica/styl.typ": *


#show: stijl.with(titel: "Python intro", kop: "Natuurkunde 2.1 Practicum — Week 1")

#praktikumtitle[Opzetten Python voor practicum]

#heading(level: 1, numbering: none)[Leerdoelen]

#leerdoelen(
  [Pythonontwikkelomgeving opzetten in VSCode.],
  [Leren werken met virtuele omgevingen in Python.],
  [Basis van projectstructuur.],
)

#v(1fr)

#veiligheid(title: [Veiligheid])[
We gaan programmeren, hier zijn geen veiligheidskwesties aan gebonden. Probeer alleen zoveel mogelijk zelfstandig te programmeren. Het is toegestaan om in dit practicum generatieve AI te gebruiken, gebruik het verstandig:

+ Gebruik het als uitlegmachine, niet als codegenerator

+ Gebruik het om eigen code te laten verbeteren, maar niet herschrijven

+ Gebruik het niet voor volledige oplossingen, snap je iets niet? Vraag het de docent.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

Python is een van de meest gebruikte programmeertalen binnen de natuurkunde en andere technische vakgebieden. Het wordt gebruikt voor het verwerken en visualiseren van meetgegevens, het uitvoeren van numerieke berekeningen en het aansturen van experimenten. Tijdens de opleiding zullen we Python daarom regelmatig gebruiken, bijvoorbeeld om meetdata te analyseren en grafieken te maken. Python zelf is echter alleen de programmeertaal. Voor praktisch gebruik zijn daarnaast verschillende #emph[packages] nodig. Zo gebruiken we `NumPy` voor numerieke berekeningen, `Matplotlib` voor het maken van grafieken en `SciPy` voor wetenschappelijke berekeningen. Naarmate je meer projecten uitvoert, zul je steeds meer van dergelijke packages tegenkomen.

Hierbij ontstaat een praktisch probleem: niet ieder project gebruikt dezelfde packages of dezelfde versies daarvan. Een nieuwere versie van een package kan bijvoorbeeld anders werken dan een oudere versie. Om te voorkomen dat verschillende projecten elkaar in de weg zitten, werken we daarom met #emph[virtuele omgevingen] (#emph[environments]). Een environment kun je zien als een afzonderlijke Python-installatie met zijn eigen verzameling packages. Voor ieder project kan zo een geschikte en reproduceerbare werkomgeving worden gemaakt.

In dit practicum gebruiken we #strong[Miniforge] om Python, environments en packages te beheren. Miniforge is een relatief compacte Python-distributie die gebruikmaakt van het `conda`-systeem. Miniforge gebruikt standaard packages uit het `conda-forge`-ecosysteem. Hierdoor hoeven packages en hun onderlinge afhankelijkheden niet handmatig geïnstalleerd en bijgehouden te worden.

Voor het daadwerkelijk schrijven en uitvoeren van Python-code gebruiken we #strong[Visual Studio Code (VS Code)]. VS Code is een programmeeromgeving waarin je onder andere Python-scripts en Jupyter notebooks kunt schrijven, uitvoeren en beheren. VS Code bevat daarbij niet zelf "de Python": we koppelen VS Code aan de Python-interpreter uit de environment die we met Miniforge hebben gemaakt.

In dit practicum ga je daarom stap voor stap een complete Python-werkomgeving opzetten. Je installeert Miniforge en VS Code, maakt vanuit de opdrachtprompt een eigen environment aan, installeert hierin enkele veelgebruikte wetenschappelijke packages en koppelt deze environment vervolgens aan VS Code. Tot slot controleer je met een eenvoudig Python-programma of alles correct is geïnstalleerd.

#v(1fr)

#voorbereiding(title: [Voorbereidingsopdracht])[
+ Neem een laptop mee.

+ Zorg voor een stabiele wifi-verbinding met de HvA.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Python installatie]

#opdracht(title: [Opdracht 1 --- Oude Anaconda-installatie verwijderen])[
Voordat we een nieuwe Python-omgeving installeren, verwijderen we eerst eventuele oude installaties van Anaconda. Hiermee voorkomen we dat Windows of VS Code later per ongeluk een oude Python-installatie gebruikt.

+ Open in Windows #strong[Instellingen] $arrow.r$ #strong[Apps] $arrow.r$ #strong[Geïnstalleerde apps].

+ Zoek naar #strong[Anaconda] of #strong[Anaconda3]. Indien Anaconda geïnstalleerd is, verwijder deze installatie.

+ Open vervolgens de Verkenner en ga naar je gebruikersmap:

  ```
  C:\Users\<gebruikersnaam>\
  ```

+ Controleer of hier nog een map `anaconda3` aanwezig is. Verwijder deze map indien deze na het verwijderen van Anaconda is achtergebleven.

+ Controleer ook of de volgende verborgen map aanwezig is:

  ```
  C:\Users\<jouw_naam>\anaconda3
  C:\Users\<jouw_naam>\miniconda3
  C:\Users\<jouw_naam>\.conda
  C:\Users\<jouw_naam>\.anaconda
  C:\Users\<jouw_naam>\.condarc
  C:\ProgramData\Anaconda3
  ```

  Verwijder deze mappen indien deze uitsluitend afkomstig zijn van je oude Anaconda-installatie.

+ Start de computer opnieuw op.

#strong[Let op!] Heb je eerder zelf environments gemaakt met bestanden die je nog nodig hebt? Verwijder deze dan niet voordat je hebt gecontroleerd of je de bestanden hebt opgeslagen.

]

#opdracht(title: [Opdracht 2 --- Controleren of Anaconda verwijderd is])[
We controleren nu of Windows niet meer naar de oude Anaconda-installatie verwijst.

+ Open de Windows #strong[Opdrachtprompt]. Zoek hiervoor in het startmenu naar `cmd` (Command Prompt/Opdrachtenprompt).

+ Voer het volgende commando uit:

  ```
  where conda
  ```

+ Voer vervolgens uit:

  ```
  where python
  ```

+ Controleer de uitvoer. Er mag geen pad meer zichtbaar zijn waarin `Anaconda` of `anaconda3` staat.

Het is geen probleem als Windows meldt dat `conda` niet kan worden gevonden. Op dit moment hebben we immers nog geen nieuwe conda-installatie geïnstalleerd.

]

#opdracht(title: [Opdracht 3 --- Miniforge installeren])[
We gebruiken #strong[Miniforge] voor het installeren en beheren van Python en de benodigde packages.

+ Ga naar de officiële Miniforge-pagina op GitHub:

  #link("https://conda-forge.org/download/")

+ Download de meest recente #strong[Miniforge3]-installer voor jouw besturingssysteem.

+ Kies de installer die past bij je computer. Voor de meeste Windows-computers is dit:

  ```
  Miniforge3-Windows-x86_64.exe
  ```

+ Start het installatiebestand en doorloop de installatie, zie Fig. #ref(label("python_intro--Fig: miniforge"), supplement: none).

+ Gebruik de standaard installatiemap, tenzij je een goede reden hebt om hiervan af te wijken.

+ Rond de installatie af en open daarna vanuit het startmenu de #strong[Miniforge Prompt].

]

#figure(
  [
#box(image("Figuren/Miniforge.png", width: 50.0%))
  ],
  caption: [Miniforge installatie.],
  kind: image,
) #label("python_intro--Fig: miniforge")

#opdracht(title: [Opdracht 4 --- Miniforge controleren])[
We controleren of Miniforge en het programma `conda` correct zijn geïnstalleerd.

+ Open de #strong[Miniforge Prompt].

+ Voer het volgende commando uit:

  ```
  conda --version
  ```

+ Als de installatie correct is verlopen, verschijnt een versienummer van conda.

+ Controleer vervolgens welke Python-installatie op dit moment wordt gebruikt:

  ```
  where python
  ```

+ Bekijk het weergegeven pad. Dit pad hoort nu naar je installatie van #strong[Miniforge3] te verwijzen.

]

#opdracht(title: [Opdracht 5 --- Miniforge toevoegen aan PowerShell])[
Om Conda-commando's rechtstreeks vanuit PowerShell en de terminal van VS Code te kunnen gebruiken, moet Miniforge eenmalig aan PowerShell worden toegevoegd.

+ Open via het Windows-startmenu de #strong[Miniforge Prompt].

+ Voer het volgende commando uit:

  ```
  conda init powershell
      
  ```

  Hiermee wordt PowerShell zo ingesteld dat het commando `conda` beschikbaar is.

+ Sluit de Miniforge Prompt en open vervolgens #strong[PowerShell].

+ PowerShell kan het uitvoeren van het Conda-script blokkeren vanwege de ingestelde beveiliging. Krijg je een melding dat het uitvoeren van scripts is uitgeschakeld (#emph[running scripts is disabled on this system])? Voer dan in PowerShell het volgende commando uit:

  ```
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
      
  ```

  Bevestig de wijziging wanneer daarom wordt gevraagd door `Y` te typen en op #emph[Enter] te drukken. Door `CurrentUser` te gebruiken is hiervoor geen administratoraccount nodig.

+ Sluit vervolgens alle geopende PowerShell-vensters en #strong[VS Code volledig af]. Start daarna PowerShell opnieuw.

+ Controleer of Conda nu beschikbaar is:

  ```
  conda --version
      
  ```

  Wanneer een versienummer wordt weergegeven, bijvoorbeeld `conda 25.x.x`, is Miniforge correct aan PowerShell toegevoegd.

]

#opdracht(title: [Opdracht 6 --- Een Python-environment maken])[
We installeren Python niet rechtstreeks als één algemene installatie voor alle projecten. In plaats daarvan maken we binnen Miniforge een afzonderlijke #emph[environment]. Hierdoor kunnen verschillende projecten ieder hun eigen Python-versie en packages gebruiken.

In de vorige opdracht hebben we Conda beschikbaar gemaakt in PowerShell. We gebruiken daarom vanaf nu #strong[PowerShell] voor het uitvoeren van Conda-commando's. De #strong[Miniforge Prompt] kan hiervoor eventueel ook worden gebruikt.

+ Open #strong[PowerShell].

+ Maak een nieuwe environment met de naam `practicum`:

  ```
  conda create -n practicum python
      
  ```

+ Bevestig de installatie wanneer daarom wordt gevraagd. Dit doe je door `y` te typen en vervolgens op #emph[Enter] te drukken.

+ Activeer vervolgens de nieuwe environment:

  ```
  conda activate practicum
      
  ```

+ Controleer de geïnstalleerde Python-versie:

  ```
  python --version
      
  ```

  Je ziet nu aan het begin van de opdrachtregel `(practicum)` staan. Dit betekent dat de environment `practicum` actief is.

+ Bekijk vervolgens welke environments op je computer aanwezig zijn:

  ```
  conda env list
      
  ```

  Naast `practicum` zou op dit moment in ieder geval de `base`-environment aanwezig moeten zijn. De actieve environment wordt aangegeven met een sterretje (`*`). De uitvoer ziet er bijvoorbeeld als volgt uit:

  ```
  # conda environments:
  #
  # * -> active
  # + -> frozen
  base                   C:\Users\<jouw_naam>\AppData\Local\miniforge3
  practicum          *   C:\Users\<jouw_naam>\AppData\Local\miniforge3\envs\practicum
      
  ```

]

#opdracht(title: [Opdracht 7 --- Wetenschappelijke packages installeren])[
Een nieuwe Python-environment bevat nog niet automatisch alle packages die we tijdens de practica nodig hebben. We installeren daarom een aantal veelgebruikte wetenschappelijke packages.

Ga verder in #strong[PowerShell] vanuit de vorige opdracht. De #strong[Miniforge Prompt] kan eventueel ook worden gebruikt.

+ Controleer eerst of de environment `practicum` actief is. Aan het begin van de opdrachtregel moet `(practicum)` staan.

  Is dit niet het geval, activeer de environment dan met:

  ```
  conda activate practicum
      
  ```

+ Installeer vervolgens NumPy, SciPy, Matplotlib, Pandas en Jupyter (ipykernel):

  ```
  conda install numpy scipy matplotlib pandas ipykernel
      
  ```

+ Bevestig de installatie wanneer daarom wordt gevraagd door `y` te typen en op #emph[Enter] te drukken.

+ Bekijk na de installatie welke packages in de actieve environment aanwezig zijn:

  ```
  conda list
      
  ```

#strong[Vraag:] Zoek in de lijst de packages `numpy`, `scipy` en `matplotlib`. Welke versies zijn geïnstalleerd?

]

#opdracht(title: [Opdracht 8 --- Visual Studio Code installeren])[
Tot nu toe hebben we Python en de benodigde packages geïnstalleerd. We hebben echter nog geen programma waarin we gemakkelijk Python-code kunnen schrijven. Hiervoor gebruiken we #strong[Visual Studio Code (VS Code)].

+ Ga naar de officiële website van Visual Studio Code: #link("https://code.visualstudio.com/")

+ Download en installeer de Windows-versie van VS Code, zie Fig. #ref(label("python_intro--Fig: vscode"), supplement: none).

+ Start VS Code na de installatie.

+ Open links in VS Code het onderdeel #strong[Extensions].

+ Zoek naar de extensies #strong[Python, Jupyter, Prettier, Rainbow CSV, Spreadsheet Viewer] en installeer deze.

]

#figure(
  [
#box(image("Figuren/VSCode.png", width: 50.0%))
  ],
  caption: [VScode installatie.],
  kind: image,
) #label("python_intro--Fig: vscode")

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Mappenstructuur]

#heading(level: 2, numbering: none)[Mappenstructuur]

Tijdens practica verzamel je verschillende bestanden, zoals Python-scripts, meetdata en figuren. Het is daarom belangrijk om vanaf het begin een duidelijke #strong[mappenstructuur] te gebruiken. Zo blijven bestanden makkelijk terug te vinden en voorkom je dat verschillende projecten of versies door elkaar raken.

Maak voor ieder practicumserie of project een #strong[aparte hoofdmap] en verdeel deze onder per practicum. Een goede mappenstructuur is een belangrijk onderdeel van zorgvuldig en reproduceerbaar werken.

#opdracht(title: [Opdracht 9 --- mappenstructuur])[
In deze opdrachtg aan we aan de slag om een goede structuur neer te zetten en deze te laden vanuit VScode.

+ Open in VScode #strong[File] $arrow.r$ #strong[Open Folder...] $arrow.r$ #strong[Documenten].

+ Creëer een nieuwe map op de locatie die handig is bijvoorbeeld op de #strong[one-drive].

+ Maak de mappenstructuur na uit Fig. #ref(label("python_intro--fig:boomdiagram"), supplement: none).

]

Ieder practicum dat je start zal je beginnen met #strong[Open Folder...] en dan de juiste practica kiezen. Zo zorg je ervoor dat je altijd je data, figuren en gebruikte scripts kunt terugvinden.

#figure(
  [
#include "Figuren/mappenstructuur.typ"
  ],
  caption: [Boomdiagram voor apparaatcommunicatie.],
  kind: image,
) #label("python_intro--fig:boomdiagram")

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Test Python]

Een #strong[Jupyter Notebook] is een document waarin Python-code in afzonderlijke blokken, zogenaamde #emph[cellen], kan worden uitgevoerd. Je kunt ze herkennen aan de extensie #strong[.ipynb]#footnote[Zorg ervoor dat extensies zichtbaar zijn bij bestanden. Kun je dit niet zien, spreek dan even de practicumbegeleider aan.]. Het grote voordeel hiervan is dat je code stap voor stap kunt uitvoeren en het resultaat direct onder de betreffende cel verschijnt. Naast code kunnen notebooks ook tekst, formules en figuren bevatten.

Dit maakt notebooks bijzonder geschikt voor practica en data-analyse: je kunt meetgegevens inlezen, berekeningen uitvoeren en grafieken maken zonder telkens het volledige programma opnieuw uit te voeren. Tijdens de practica zullen we Jupyter Notebooks daarom regelmatig gebruiken.

#opdracht(title: [Opdracht 10 --- Test Jupyter Notebook (.ipynb)])[
In de vorige opdrachten hebben we de basis gelegd voor een overzichtelijke mappenstructuur en hebben we de benodigde software geïnstalleerd. Nu gaan we controleren of alles correct werkt.

+ Open in VS Code via #strong[File] $arrow.r$ #strong[Open Folder...] de map #strong[Practicum Python Intro].

+ Open het bestand `script.ipynb` en voeg met `+ Code` een nieuwe codecel toe.

+ Neem de onderstaande code over en voer de cel uit met `Shift+Enter`.

+ Als er nog geen Python-omgeving is geselecteerd, vraagt VS Code om een #emph[kernel] te kiezen. Selecteer hier de eerder aangemaakte `practicum_omgeving`. Deze kan soms wat verstopt zitten.

+ Je kunt de actieve omgeving ook controleren of wijzigen via `Select Kernel` rechtsboven in het notebook. Controleer of hier `practicum_omgeving` is geselecteerd.

+ Controleer of de uitvoer van de code overeenkomt met wat je verwacht.

]

#jupytercode([script.ipynb])[
```python
print("Hello world")

import numpy as np

a = np.array([1, 2, 3, 4])

print("Array a:", a)
print("Array a^2:", a**2)
```

]

Naast Jupyter Notebooks wordt Python veel gebruikt in de vorm van #strong[Python-scripts]. Dit zijn tekstbestanden met de extensie #strong[.py]. In tegenstelling tot een Jupyter Notebook bestaat een Python-script niet uit losse cellen: bij het uitvoeren wordt het programma in principe van boven naar beneden uitgevoerd.

Bij een Jupyter Notebook hebben we hiervoor een #emph[kernel] geselecteerd. Voor een Python-script moet VS Code weten welke #strong[Python-interpreter] gebruikt moet worden. Het is belangrijk om hier onze eerder gemaakte `practicum_omgeving` te kiezen. Anders kan het gebeuren dat het script met een andere Python-installatie wordt uitgevoerd waarin bijvoorbeeld onze packages niet zijn geïnstalleerd.

#opdracht(title: [Opdracht 11 --- Test Python-script (.py)])[
+ Zorg dat de map #strong[Practicum Python Intro] nog geopend is in VS Code.

+ Open het bestand met de naam `script.py`.

+ Selecteer de juiste Python-interpreter. Druk hiervoor op `Ctrl+Shift+P` en zoek naar:

  ```
  Python: Select Interpreter
      
  ```

+ Selecteer de eerder gemaakte `practicum_omgeving`. Als deze niet direct zichtbaar is, kijk dan bij de overige beschikbare Python-omgevingen.

+ Neem onderstaande code over in `script.py` en sla het bestand op.

+ Voer het programma uit met de knop #strong[Run Python File] rechtsboven in VS Code.

+ Onderaan VS Code wordt nu een #strong[Terminal] geopend. Controleer of het programma zonder foutmeldingen wordt uitgevoerd.

]

#jupytercode([script.py])[
```python
import sys
import numpy as np

print("Hello world")

a = np.array([1, 2, 3, 4])

print("Array a:", a)
print("Array a^2:", a**2)

print("\nPython wordt uitgevoerd vanuit:")
print(sys.executable)
```

]

#opdracht(title: [Opdracht 12 --- Controleer de Python-omgeving])[
Bekijk de laatste regel van de uitvoer van je programma. Hier staat het pad naar het bestand `python.exe` waarmee het programma is uitgevoerd.

+ Controleer of in dit pad de naam `practicum_omgeving` voorkomt.

+ Controleer ook linksonder in VS Code welke Python-versie en environment geselecteerd zijn.

+ Staat hier niet `practicum_omgeving`? Selecteer dan opnieuw de juiste interpreter via `Python: Select Interpreter` en voer `script.py` opnieuw uit.

]

#afronding(title: [Afronding])[
+ Heb je alle opdrachten afgerond? Laat dit dan controleren door de practicumbegeleider.

+ Lukt het niet om alles op tijd af te ronden, zorg ervoor dat je dit dan thuis afrond! Mocht je er thuis niet uitkomen, spreek dan de practicumbegeleider even aan, diegene zal dan met je meekijken.

]

#heading(level: 1, numbering: none)[Appendix: Materialen Lijst Practica]

- Laptop met stabiele internetverbinding.

#import "formulier.typ": *
#show: body => formulier(body, interview: true)
#titel[Praktijkgericht interview Stages -- Week 15]

#persoonsgegevens((
  ([Student:], "namefield0"),
  ([Student nummer:], "namefield1"),
  ([Stagebegeleider:], "namefield2"),
  ([Examinator:], "namefield3"),
  ([Datum:], "namefield4"),
))

#v(1fr)

#strong[Instructie]

Dit document is bedoeld voor de praktijkbeoordeling (Criterium Gericht Interview) van de stage (week 15) en heeft betrekking op het functioneren van de student gedurende de, tot dan toe afgelegde, stageperiode. De beoordeling is gebaseerd op de competenties van de opleiding Technische Natuurkunde en wordt gegeven op een schaal van Excellent (#strong[E]) tot Onvoldoende (#strong[O]).

Bespreek de beoordeling met de student en zorg ervoor dat dit formulier #strong[vóór] het eindgesprek of stagebezoek is ingevuld.

#v(8mm)

#align(center)[
#image("HvA_logo.png", height: 13mm)
]

#pagebreak(weak: true)

= Onderzoeksvaardigheden

== b. Modelleervaardigheden

#strong[Doel:] De student kan relatief zelfstandig, met losse sturing, een relatief complex model selecteren, de vergelijkingen afleiden en indien nodig een model te verfijnen en aanpassen aan specifieke situaties.

#list([Uit aangereikte vakspecifieke modellen de geschikte te selecteren, te controleren, toe te passen en ze te valideren binnen het project.],
[Zelfstandig (de vergelijkingen van) een eenvoudig model op hoofdlijnen (zonder details)op te stellen.],
[Een eenvoudig aangereikt model zelfstandig aan te passen en toe te passen aan een specifieke situatie binnen de stageopdracht.])

#scores(("E2", "G2", "V2", "M2", "O2", "NVT2",), label: [Eindoordeel examinator])

== c. Experimentele vaardigheden

#strong[Doel:] De student kan een plan opstellen of een bestaand voorschrift aanpassen voor de opgestelde onderzoeksvraag en tijdens het uitvoeren van een experiment nauwkeurig de resultaten bijhouden.

#list([Een aanpak te kiezen en uit te leggen waarom deze geschikt is om het doel te bereiken.],
[Over voldoende kennis en inzicht beschikken van beschikbare methoden en technieken om deze op geschiktheid te beoordelen en de juiste apparatuur en/of apparaat instellingen te kiezen.],
[Bij de proefopzet rekening te houden met milieu- en veiligheidsaspecten],
[Een planning te maken voor het uitvoeren van experimenteel werk binnen een (afgebakend) project dat qua tijdsduur van beperkte omvang is (maximaal 20 weken).],
[Te motiveren of de aanpak van het experiment verbeteringen nodig heeft en advies voor mogelijke oplossingen kunnen onderbouwen.])

#scores(("E3", "G3", "V3", "M3", "O3", "NVT3",), label: [Eindoordeel examinator])

#toelichting("opmerkingen_o", label: [Opmerkingen / toelichting], height: 6cm)

#pagebreak(weak: true)

= Projectvaardigheden

== a. Project opzetten

#strong[Doel:] De student kan de wensen van de opdrachtgever vertalen naar een haalbaar projectplan met een duidelijk tijdspad en taakverdeling.

#list([De wens van de stageverlener te identificeren.],
[In overleg een werkplan (PvA) te maken, zelfstandig de planning op te stellen, rekening houdend met randvoorwaarden binnen het project.],
[In overleg met de opdrachtgever de doelen, beoogd(e) eindproduct(en) en criteria aan eindproduct(en)van het project aan te scherpen.])

#scores(("E4", "G4", "V4", "M4", "O4", "NVT4",), label: [Eindoordeel examinator])

== b. project uitvoeren

#strong[Doel:] De student kan het projectplan uitvoeren en indien nodig, in overleg met het team en opdrachtgever, tussentijds aanpassen.

#list([Bij uitvoering van de opdracht te werken conform werkplan. Het werkplan efficiënt uit te voeren en zo nodig tussentijds aan te passen.],
[Verantwoordelijkheid te nemen voor de uitvoering van de eigen activiteiten en hierover pro-actief te communiceren met oog op de voortgang van het project.],
[Verantwoordelijkheid te nemen bij het monitoren van de voortgang van het project, signaleren van knelpunten in de voortgang van het project en deze bespreekbaar maken en zo nodig de planning of activiteiten bij te stellen binnen de gestelde randvoorwaarden.],
[Te functioneren als volwaardig teamlid in de eigen werkomgeving waarbij feedback en reflectie leiden tot betere resultaten, beargumenteerde keuzes en goede afstemming in het uitvoeren van het onderzoek. De communicatie over de voortgang te kunnen afstemmen op de situatie.])

#scores(("E5", "G5", "V5", "M5", "O5", "NVT5",), label: [Eindoordeel examinator])

#toelichting("opmerkingen_pr", label: [Opmerkingen / toelichting], height: 6cm)

#pagebreak(weak: true)

= Data vaardigheden

== a. Data verzamelen \& bewerken

#strong[Doel:] De student kan een passende methode kiezen voor het genereren of verzamelen en bewerken van data.

#list([Met behulp van een model of een experiment zelfstandig data te genereren.],
[Meetresultaten zelfstanding adequaat en correct te bewerken en in te schatten of een gevonden uitkomst realistisch is.],
[Data op een reproduceerbare en gestructureerde manier te verwerken (bijvoorbeeld via scripts, versiebeheer of een duidelijke workflow).],
[Data en metadata (instellingen, meetcondities, kalibraties) overzichtelijk te documenteren zodat metingen herleidbaar en herhaalbaar zijn.])

#scores(("E6", "G6", "V6", "M6", "O6", "NVT6",), label: [Eindoordeel examinator])

#toelichting("opmerkingen_data", label: [Opmerkingen / toelichting], height: 6cm)

#pagebreak(weak: true)

#grid(columns: (1fr, auto), align: left + horizon,
  text(size: 24pt, weight: "bold")[Evaluatie Totaal],
  [*Eindcijfer:* #h(2mm) #veld("scoreinhoud", width: 15mm, height: 5mm, score: "2-6")])
#v(2mm)
#line(length: 100%, stroke: 0.5pt)

#toelichting("opmerkingen_final", label: [Toelichting beoordeling (tips / tops)], height: 6cm)

#beoordelingstabel([Onderzoeksvaardigheden], (
  ([b. Modelleervaardigheden], 2),
  ([c. Experimentele vaardigheden], 3),
), "score_onderzoek", "2-3")

#beoordelingstabel([Projectvaardigheden], (
  ([a. Project opzetten], 4),
  ([b. Project uitvoeren], 5),
), "score_project", "4-5")

#beoordelingstabel([Datavaardigheden], (
  ([a. Data verzamelen & bewerken], 6),
), "score_data", "6-6")

#v(1fr)
#slotgegevens((
  ([Student:], "namefield0"),
  ([Datum:], "namefield4"),
  ([Beoordeeld door examinator:], "namefield3"),
))

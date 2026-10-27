#import "../../Practica/styl.typ": *
#show: stijl.with(titel: "SEMEDX", kop: "Technische Natuurkunde — Na2.2")

#praktikumtitle[Practicum: SEM-EDX]

#heading(level: 1, numbering: none)[Leerdoelen]

#[
#set list(marker: leerdoel-teken)
- Je kan een beeld vormen met een SEM.

- Je kan elementen in een monster bepalen met EDX.

]

#v(1fr)

#veiligheid(title: [Veiligheid])[
+ Dit practicum heeft een verplichte interactieve training, geen voorbereiding = geen deelname! Kom daarnaast ook 15 minuten voor de start van jouw tijdslot!

+ Een SEM-EDX is een zeer kostbaar apparaat. Twijfel je over stappen die je moet zetten? Vraag dit dan aan Pieter-Paul Hooijschuur.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Introductie]

In dit practicum maak je kennis met de Scanning Elektronen Microscopie (SEM) en Energy Dispersive X-ray Spectroscopy (EDX), twee krachtige technieken voor materiaalonderzoek. SEM biedt de mogelijkheid om oppervlakken met een hoge resolutie te bestuderen, terwijl EDX de chemische samenstelling van een monster kan analyseren. Tijdens het practicum leer je de basisprincipes van beide methoden en voer je metingen uit om hun praktische toepassingen te verkennen. Tijdens dit practicum zal door elke student met de SEM-EDX gewerkt worden, te vinden in het Nicolaas Tulphuis D2.11.

Ter voorbereiding is er een #strong[verplichte interactieve training met een Virtual SEM]. De interactieve site is modulair opgebouwd en geeft uitleg over de werking en instellingen die nodig zijn om een juist beeld te krijgen.

#figure(
  [
#box(image("Figuren/Sem_EDX.png", width: 75.0%))
  ],
  caption: [Moderne SEM-EDX apparatuur.],
  kind: image,
) #label("semedx--fig: SEM")

In dit practicum ga je een analyse van morfologie en elementsamenstelling van een aantal stubs doen met objecten waarmee de onderzoeksvraag per stub moet worden beantwoord.

#heading(level: 1, numbering: none)[Theorie]

In de kennisclips op Brightspace worden verschillende imaging technieken uitgelegd met de elektronenmicroscoop. Gebruik die informatie samen met de simulatie om de voorbereidingsvragen uit de box hierboven te beantwoorden in je labjournaal.

Een scanning elektronenmicroscoop (SEM) vormt beelden door een dunne, gefocusseerde elektronenbundel lijn voor lijn over het oppervlak van een monster te scannen. In tegenstelling tot een lichtmicroscoop worden hier geen fotonen gebruikt, maar hoogenergetische elektronen die typisch tussen 1 en 30 kV versneld worden. Wanneer deze elektronen het monster binnendringen ontstaat een interactievolume op micrometerschaal, waarin de elektronen elastisch en inelastisch verstrooien. Deze interacties leveren verschillende signaaltypen op die informatie geven over topografie, materiaalcontrast en chemische samenstelling.

De meest gebruikte signalen in SEM zijn secundaire elektronen (SE) en backscattered elektronen (BSE). SE hebben een lage energie en ontsnappen alleen vanuit de bovenste nanometers van het oppervlak, waardoor zij uiterst geschikt zijn voor het in kaart brengen van fijne topografische details. BSE hebben een hogere energie en ontstaan diepere in het monster; zware elementen (hoger atoomnummer) verstrooien elektronen sterker terug en verschijnen daarom helderder, wat compositiecontrast mogelijk maakt. Daarnaast ontstaan karakteristieke röntgenfotonen wanneer een invallend elektron een binnenste schil ioniseert en een elektron van een hogere schil terugvalt. De energie van dit röntgensignaal (EDX/EDS) is element-specifiek, waardoor lokale chemische analyse uitgevoerd kan worden.

Een SEM bestaat uit een elektronenkanon, elektromagnetische lenzen die de bundel focussen, afbuigspoelen die het beeld scannen, een vacuümkamer met monsterhouder (stub), en verschillende detectoren. Omdat elektronen interactie hebben met lucht is hoog vacuüm essentieel. Veel materialen moeten geleidbaar zijn om ladingopbouw te vermijden; niet-geleidende monsters worden vaak voorzien van een ultra­dunne geleidende coating (bijvoorbeeld goud, platina of koolstof).

Tijdens het experiment zijn meerdere instelparameters van belang. De versnellingsspanning bepaalt de penetratiediepte en daarmee het contrast en de ruimtelijke resolutie. De werkafstand beïnvloedt de scherpte, vooral bij hoge vergrotingen. Verder spelen de bundelspotsize (probe current), de monstervoorbereiding (droog, gefixeerd, geleidbaar) en de vacuümcondities een cruciale rol. Door een geschikte keuze van instellingen kan men variëren tussen oppervlaktedetail, compositiecontrast en maximale EDX-signaalopbrengst. Hierdoor vormt SEM--EDX een veelzijdige techniek voor materiaalonderzoek op micro­ tot nanometerschaal.

#heading(level: 2, numbering: none)[Belangrijke variabelen tijdens SEM--EDX]

#figure(
  [
#table(
  columns: (auto,9fr,),
  align: (left,left,),
  table.header(table.cell(x: 0, y: 0)[#strong[Parameter]], table.cell(x: 1, y: 0)[#strong[Effect]]),
  table.cell(x: 0, y: 1)[Versnellingsspanning (kV)],
  table.cell(x: 1, y: 1)[Bepaalt penetratiediepte en interactievolume; hogere kV verhoogt signaal (BSE/EDX) maar kan resolutie verminderen en lading op isolatoren versterken.],
  table.cell(x: 0, y: 2)[Spotsize / probe current],
  table.cell(x: 1, y: 2)[Grotere spotsize geeft meer signaal (voor EDX) maar lagere resolutie.],
  table.cell(x: 0, y: 3)[Working distance],
  table.cell(x: 1, y: 3)[Kortere afstand geeft hogere resolutie; langere afstand kan nuttig zijn voor EDX-geometrie.],
  table.cell(x: 0, y: 4)[Vergroting],
  table.cell(x: 1, y: 4)[Wordt bepaald door het scanveld, niet door optiek zoals in lichtmicroscopie.],
  table.cell(x: 0, y: 5)[Monstervoorbereiding],
  table.cell(x: 1, y: 5)[Monster moet droog zijn; vaak geleidende coating voor isolatoren om ladingopbouw te voorkomen.],
  table.cell(x: 0, y: 6)[Vacuum],
  table.cell(x: 1, y: 6)[Nodig om elektronenverstrooiing door lucht te minimaliseren en detectorgevoeligheid te waarborgen.],
)
  ],
  caption: none,
  kind: table,
)

#voorbereiding(title: [Voorbereidingsopdracht week 1])[
+ Bestudeer voorafgaand aan de interactieve training de kennisclips op Brightspace.

+ Doorloop zelfstandig de interactieve training: \
  #link("http://www.ammrf.org.au/myscope/sem/introduction/")

+ Voer de SEM- en EDX-simulaties uit via het tabblad #emph[practical].

+ Noteer de antwoorden op de vragen in je digitale labjournaal:

  - Welke instellingen zijn er bij de SEM simulatie en wat betekenen ze?

  - Welke elementen zitten er in messing, 14K goud en witgoud?

  - Waar heb je deze elementen voor nodig binnen het practicum?

+ Beantwoord de voorbereidende theorievragen en noteer deze in je labjournaal:

  - SEM: Leg uit wat SE en BSE detectie is. Wanneer gebruik je SE, en wanneer BSE?

  - EDX: Waarom is de gedetecteerde röntgenstraling in de EDX-machine afhankelijk van het acceleratievoltage?

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Uitvoering]

Vanwege de complexiteit van de SEM krijg je een korte instructie, waarna je zelfstandig een analyse uitvoert met de SEM-EDX.

Voer onderstaande oefeningen uit om kennis te maken met de SEM-EDX in het lab. Wissel daarbij de bediener bij de verschillende oefeningen af zodat iedereen de SEM heeft bediend.

#veiligheid(title: [Let op!])[
Je mag diverse instellingen wijzigen, de enige die je absoluut niet mag variëren is de "FIL I Target" (stroom door het filament)!

]

#heading(level: 2, numbering: none)[Opdrachten SEM]

#opdracht(title: [Opdracht 1: SE- en BSE-beeldvorming])[
#strong[Doel:] leren scherpstellen, contrast optimaliseren en verschillen tussen SE- en BSE-detectie waarnemen.

+ Selecteer de referentiestub (positie 9) en kies de #strong[SE-detector].

+ Stel het #strong[acceleratie-voltage] in op #strong[15 kV].

+ Druk op #emph[reduced], focus en vergroot tot een duidelijk beeld ontstaat.

+ Houd #strong[brightness] op $tilde.op$50% en optimaliseer het beeld met #strong[contrast].

+ Stel de #strong[working distance] in op $tilde.op$7,5 mm (verplaats Z-as en herfocus).

+ Wissel naar de #strong[BSE-detector] en herhaal bovenstaande stappen.

+ Noteer voor beide detectoren de optimale instellingen (EHT en WD) en licht toe wat je als "optimaal" beoordeelt (bijv. spreiding grijswaarden, scherpte, contrast).

]

#opdracht(title: [Opdracht 2: Effect van acceleratiespanning])[
#strong[Doel:] inzicht krijgen in penetratiediepte, contrast en resolutie bij verschillende voltages.

+ Selecteer de referentiestub (positie 9) en kies de #strong[BSE-detector].

+ Stel WD in op $tilde.op$7,5 mm en begin bij #strong[1--3 kV] (eventueel 5 kV).

+ Zoek een gebied met lichte bolletjes, focus en zoom in.

+ Verhoog het acceleratie-voltage naar #strong[10 kV]\; optimaliseer focus en contrast.

+ Verhoog naar #strong[25 kV]\; optimaliseer opnieuw.

+ Noteer voor elk voltage je observaties (helderheid, contrast, ruis, resolutie, doordringen van bundel).

+ Herhaal bovenstaande stappen bij de #strong[SE-detector].

+ Bespreek de waargenomen verschillen tussen lage, middelhoge en hoge kV-instellingen (voordelen/nadelen voor beeldkwaliteit).

]

#opdracht(title: [Opdracht 3: Effect van spot size])[
#strong[Doel:] onderzoeken hoe bundelstroom en resolutie afhangen van spot size.

+ Selecteer de referentiestub (positie 9).

+ Stel acceleratiespanning in op #strong[5 kV] en WD op $tilde.op$7,5 mm.

+ Kies de #strong[SE-detector], focus en zoom.

+ Stel #strong[spot size $tilde.op$400] in en optimaliseer scherpte en contrast.

+ Verhoog naar #strong[spot size $tilde.op$600] en optimaliseer opnieuw.

+ Noteer verschillen in ruis, helderheid, resolutie en detailweergave.

+ Herhaal dezelfde procedure met de #strong[BSE-detector].

]

#pagebreak(weak: true)

#heading(level: 2, numbering: none)[Opdrachten EDX]

Zet de EDX computer aan. Start Esprit1.9. Start programma RComm32 op (bureublad SEM computer!). De SEM maakt middels het communicatieprogramma RComm32 connectie met Esprit1.9.

#opdracht(title: [Opdracht 4: Elementanalyse (EDX)])[
#strong[Doel:] spectrumverwerving en interpretatie van karakteristieke röntgenpieken (Sn/C monster).

+ Selecteer referentiestub (positie 9; Sn/C).

+ Kies de #strong[BSE-detector].

+ Stel zelf een geschikt #strong[acceleratievoltage] in en houd de #strong[working distance] op $tilde.op$7,5 mm (focus na elke Z-aanpassing).

+ Stel #strong[spot size $tilde.op$300--400] in.

+ Open de EDX-software, kies #emph[New] en start #emph[Preview].

+ Zoom in op een deeltje en selecteer #strong[Point analysis]\; plaats het analyse-kruis op het deeltje.

+ Controleer de signaalopbrengst (kcps); pas spot size aan totdat $gt.tilde 1$ kcps wordt bereikt.

+ Start de acquisitie (#emph[Acquire]) en bekijk het spectrum.

+ Schakel relevante lijnen (bijv.~Sn en C) zichtbaar en noteer observaties.

+ Controleer:

  - herkenbare karakteristieke lijnen van Sn en C;

  - eventuele extra elementen in het spectrum;

  - aanwezigheid van som-/pile-up peaks.

+ Herhaal de meting bij aangepast acceleratievoltage (bijv.~5 of 10 kV) en interpreteer verschillen in piekintensiteit, achtergrond en detecteerbare lijnen.

]

#opdracht(title: [Opdracht 5: Elementmapping (EDX-mapping)])[
#strong[Doel:] ruimtelijke spreiding van elementen visualiseren via mapping.

+ Selecteer de #strong[BSE-detector] en plaats de referentiestub (positie 9).

+ Kies een passend #strong[acceleratievoltage] en stel de #strong[WD] in op $tilde.op$7,5 mm (herfocus tijdens Z-correcties).

+ Zoek een gebied met bolvormige deeltjes en stel scherp.

+ Start de EDX-software, kies #emph[New] en #emph[Preview].

+ Zoom in binnen de EDX-interface indien gewenst.

+ Pas spot size aan zodat de input $approx 1$ kcps bedraagt.

+ Kies #strong[Mapping] en selecteer maximaal vijf te analyseren elementen.

+ Observeer de elementverdeling: welke elementen tonen duidelijke aanwezigheid, welke ontbreken waarschijnlijk?

+ Rapporteer je waarnemingen en interpreteer het materiaalcontrast en de ruimtelijke relatie tussen de gedetecteerde elementen.

]

#afronding(title: [Afronding])[
+ Noteer je observaties, resultaten en conclusie/discussie in je digitale labjournaal.

+ Laat je resultaten controleren door een practicumbegeleider.

+ Werk openstaande vragen uit en vraag goedkeuring aan de practicumbegeleiders.

]

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 1: bindingsenergie]

#figure(
  [
#box(image("Figuren/Bindings_energien.png", width: 95.0%))
  ],
  caption: [De bindingsenergie van elektronen in verschillende atomen.],
  kind: image,
) #label("semedx--fig:sem-bindingsenergie")

#pagebreak(weak: true)

#heading(level: 1, numbering: none)[Appendix 2: bindingsenergie]

#figure(
  [
#box(image("Figuren/Emissie_energien.png", width: 95.0%))
  ],
  caption: [De X-ray energieën van verschillende overgangen bij verschillende atomen.],
  kind: image,
) #label("semedx--fig:sem-emissieenergie")

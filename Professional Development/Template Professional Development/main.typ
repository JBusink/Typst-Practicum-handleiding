#import "template.typ": professional-development, kader, invulveld

// Pas deze gegevens aan. De datum blijft vast totdat je hem zelf wijzigt.
#show: professional-development.with(
  titel: "Titel van de opdracht",
  subtitel: "Onderwerp of korte toelichting",
  documenttype: "Opdrachtbeschrijving",
  studiejaar: "2026-2027",
  auteur: "Naam docent",
  datum: datetime(year: 2026, month: 11, day: 11),
)

#kader("De opdracht in het kort")[
  Beschrijf hier wat de student maakt, met welk doel en in welke vorm.
]

= Doel
Beschrijf wat de student na deze opdracht kan laten zien of uitleggen.

= Opdracht
+ Beschrijf de inhoud en de gewenste aanpak.
+ Benoem welke figuren, onderbouwing of resultaten nodig zijn.
+ Geef aan wat de student moet inleveren.

= Vorm en voorbereiding
Vul hier de omvang, presentatieduur, voorbereiding en inleverafspraken in.
Stem deze af op de bijbehorende rubriek.

= Beoordeling
Benoem de beoordelingsonderdelen en verwijs naar de rubriek. Leg eventuele
wegingen en de berekening van het eindcijfer vast voordat de opdracht wordt gebruikt.

// Voor een studentenmemo: vervang bovenstaande secties door je inhoud en
// voeg desgewenst onderstaande onderdelen toe.
// = Referenties
// Gebruik #bibliography("sources.bib") in plaats van een losse kop.
// Verwijs in de tekst naar een eigen bron met @bronsleutel.
// = AI-verantwoording
// Vermeld hulpmiddel, doel, relevante prompts en controle van de uitkomst.
// Geef ook aan als je geen AI hebt gebruikt.

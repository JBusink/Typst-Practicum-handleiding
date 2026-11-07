#import "template.typ": stage-memo

// Vul hier de gegevens voor jouw memo in.
#show: stage-memo.with(
  titel: "Memo ... - Technische Stage:",
  studenten: [Naam student],
  studentnummer: "1234567",
  begeleiders: [Naam begeleider],
  studie: [Technische Natuurkunde - High-Tech Physics: Technical internship],
  datum: datetime.today(),
)

= Introductie

// Schrijf hier de aanleiding, het doel en de context van je memo.

// Voeg hier de verdere inhoud toe met = Kop en == Subkop.
// Verwijs naar een bron met bijvoorbeeld @Guinier_BioXTAS.
// Alleen geciteerde bronnen verschijnen in de literatuurlijst.
#bibliography("sources.bib", title: [Referenties], style: "ieee")

= AI verantwoording

// Vermeld welke AI-hulpmiddelen je hebt gebruikt, waarvoor je die hebt
// ingezet en hoe je de resultaten hebt gecontroleerd. Geef het ook aan
// als je geen AI hebt gebruikt.

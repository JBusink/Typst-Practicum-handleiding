#import "../styl.typ": *
#show: stijl.with(titel: "Leerjaar2", kop: "Technische Natuurkunde")

#hoofdtitelpagina([Practicumhandleiding Technische Natuurkunde], [Leerjaar 2], [])

#outline(title: [Inhoudsopgave])

#pagebreak(weak: true)

#tussentitelpagina([Practica periode 1], [Optica])

#include "Algemeen/Regels_Veiligheid.typ"

#include "Planning/P1.typ"

#include "Na2.1_typst/Python_intro.typ"

#include "Na2.1_typst/Lenzen.typ"

#include "Na2.1_typst/Spectrometer.typ"

#tussentitelpagina([Practica periode 2], [Materie en Kwantumfenomenen])

#include "Na2.2_typst/Aero_pendulum_OL.typ"

#include "Na2.2_typst/Aero_pendulum_PID.typ"

#include "Na2.2_typst/Zonnecel.typ"

#tussentitelpagina([Practica periode 3], [Straling en (medische) Detectietechnieken])

#include "Na2.2_typst/SEMEDX.typ"

#include "Na2.3_typst/Elektronen_e_m_bepalen.typ"

#include "Na2.3_typst/Elektronen_diffractie.typ"

#include "Na2.3_typst/Apparaat_communicatie.typ"

#tussentitelpagina([Practica periode 4], [Materiaalkunde en Stromingsleer])

#include "Na2.4_typst/TrekbankproefI.typ"

#include "Na2.4_typst/TrekbankproefII.typ"

#include "Na2.4_typst/Hardheid_Kerfslag.typ"

#include "Na2.4_typst/Kinematische_Viscositeit.typ"

#include "Na2.4_typst/Digitale_Viscositeit.typ"

#tussentitelpagina([Python voor het practicum], [Tips en code snippets])

#include "../Python cursus en bestanden/Python_tips.typ"

#include "../Python cursus en bestanden/Code_snippets.typ"

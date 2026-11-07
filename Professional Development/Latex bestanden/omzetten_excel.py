import pandas as pd

# Data van de rubriek
data = [
    {
        "Onderdeel": "Voortgang en resultaten\n• Memo dekt de gemaakte voortgang binnen de stage\n• Resultaten helder en volledig beschreven\n• Analyses beargumenteerd en correct uitgevoerd\n• Toelichting van resultaten duidelijk en gestructureerd",
        "Goed (8–10)": "De memo geeft een volledig beeld van de voortgang binnen de stage. De resultaten zijn helder en volledig uitgewerkt, de analyses goed onderbouwd en correct uitgevoerd, en de toelichting is duidelijk en logisch opgebouwd.",
        "Voldoende (6–7)": "De memo beschrijft de voortgang globaal. De resultaten zijn grotendeels duidelijk maar missen enkele details, de analyses zijn deels onderbouwd en niet overal correct, en de toelichting is wisselend gestructureerd.",
        "Onvoldoende (1–5)": "De memo laat nauwelijks voortgang zien. De resultaten zijn onvolledig of onduidelijk, de analyses ontbreken of zijn foutief, en de toelichting is onsamenhangend of afwezig."
    },
    {
        "Onderdeel": "Discussie en volgende stappen\n• Resultaten uitgelegd\n• Verband met stagedoel duidelijk\n• Inzichten en beperkingen benoemd\n• Conclusies onderbouwd\n• Vervolgstappen haalbaar",
        "Goed (8–10)": "Resultaten helder en goed gekoppeld aan stagedoel. Inzichten en beperkingen benoemd, conclusies logisch, vervolgstappen concreet en haalbaar.",
        "Voldoende (6–7)": "Resultaten deels helder, verband met stagedoel wisselend duidelijk. Enkele inzichten en beperkingen genoemd, conclusies grotendeels logisch, vervolgstappen globaal.",
        "Onvoldoende (1–5)": "Resultaten onduidelijk, verband met stagedoel ontbreekt. Inzichten en beperkingen niet genoemd, conclusies onlogisch, vervolgstappen ontbreken of onhaalbaar."
    },
    {
        "Onderdeel": "Schematische tekening en toelichting\n• Duidelijke, overzichtelijke en digitale schets\n• Professionele en representatieve weergave van de opstelling\n• Toelichting en onderschrift volledig en begrijpelijk\n• Belangrijke opmerkingen over uitvoering of beperkingen",
        "Goed (8–10)": "Schets is volledig, duidelijk en professioneel. Weergave van de opstelling klopt, toelichting en onderschrift zijn helder, beperkingen benoemd.",
        "Voldoende (6–7)": "Schets is grotendeels duidelijk en professioneel, met enkele ontbrekende of onduidelijke elementen. Weergave herkenbaar, toelichting grotendeels begrijpelijk, enkele opmerkingen over beperkingen.",
        "Onvoldoende (1–5)": "Schets is onduidelijk, incompleet of niet professioneel. Weergave klopt niet, toelichting ontbreekt of is onduidelijk, beperkingen niet genoemd."
    },
    {
        "Onderdeel": "Opmaak figuren\n• Figuren professioneel opgemaakt (figuurnummers, labels, onderschrift, etc.)\n• Goede keuze in figuren en beknopt, geen overbodige data gevisualiseerd\n• Figuren en onderschriften ondersteunen interpretatie van resultaten",
        "Goed (8–10)": "Figuren zijn professioneel opgemaakt met correcte nummering, labels en onderschriften. De gekozen figuren zijn relevant en beknopt, zonder overbodige data. Ze ondersteunen de interpretatie van de resultaten volledig.",
        "Voldoende (6–7)": "Figuren zijn redelijk opgemaakt maar missen soms duidelijke labels, onderschriften of consistente nummering. Er zijn enkele overbodige of minder relevante figuren opgenomen. Ze ondersteunen de interpretatie deels.",
        "Onvoldoende (1–5)": "Figuren zijn slordig of onvolledig opgemaakt, zonder duidelijke labels, onderschriften of structuur. Er is overbodige of irrelevante data opgenomen en de interpretatie wordt nauwelijks ondersteund."
    },
    {
        "Onderdeel": "Algemeen\n• Lengte: niet meer dan 4 A4\n• Grammaticaal en taalkundig correct\n• Nette en overzichtelijke lay-out\n• Op tijd ingeleverd\n• Geen plagiaat\n• Referenties naar gebruikte bronnen",
        "Goed (8–10)": "Verslag voldoet volledig aan de algemene eisen. Correcte taal, nette lay-out, op tijd ingeleverd, correcte referenties.",
        "Voldoende (6–7)": "Verslag voldoet grotendeels aan de eisen. Kleine fouten of inconsistenties in taal, lay-out of referenties.",
        "Onvoldoende (1–5)": "Verslag voldoet niet aan de algemene eisen. Veel fouten, slechte lay-out, ontbreken van referenties of plagiaat."
    }
]

# Maak DataFrame
df = pd.DataFrame(data)

# Voeg lege Score-kolom toe
df["Score"] = ""

# Schrijf naar Excel
df.to_excel("Rubriek_Memo2.xlsx", index=False)

print("Excel-bestand 'Rubriek_Memo2.xlsx' is aangemaakt.")

# Typst voor beginners

Open **start.typ** als hoofddocument. Dit bestand laadt de opmaak uit
**template.typ**. Houd beide bestanden bij elkaar.

1. Open de map in je Typst-editor, of upload de `.typ`-bestanden, `referenties.bib` en de map `figuren` naar een Typst-project.
2. Open `start.typ` en start de preview.
3. Vul je naam en titel in en pas de voorbeeldinhoud aan.
4. Exporteer `start.typ` als PDF.

Het startdocument bevat voorbeelden van kopjes, lijsten, formules, een tabel
en een verwijzing. Ook bevat het een RC-laagdoorlaatfilter getekend met
[Zap 0.6.0](https://typst.app/universe/package/zap/). Hiervoor worden Zap en
CeTZ bij de eerste compilatie opgehaald; daarvoor is internet nodig als de
pakketten nog niet lokaal beschikbaar zijn.
De testafbeelding staat in `figuren/testfiguur.svg`. Het document toont hoe
je die invoegt en ernaar verwijst. `referenties.bib` bevat twee voorbeeldbronnen
die in de tekst worden geciteerd en in de literatuurlijst verschijnen.

Pas voor andere marges of lettergrootte `template.typ` aan. Voor alleen
nieuwe inhoud hoef je uitsluitend `start.typ` te bewerken.

Als de Typst CLI is geïnstalleerd, kun je vanuit deze map compileren met:

```sh
typst compile start.typ start.pdf
```

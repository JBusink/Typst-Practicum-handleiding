/* PDF JavaScript: Acrobat API. Keuzes en rekenregels van de stageformulieren. */
function stageScore(doc, begin, einde) {
    var som = 0, nvt = 0;
    var letters = ["E", "G", "V", "M", "O", "NVT"];
    var punten = [10, 7.5, 5.5, 3.5, 1, 0];
    for (var i = begin; i <= einde; i++) {
        for (var j = 0; j < letters.length; j++) {
            var veld = doc.getField(letters[j] + i);
            if (veld && veld.isBoxChecked(0)) {
                if (letters[j] === "NVT") nvt++;
                else som += punten[j];
                break;
            }
        }
    }
    // Zoals in het origineel tellen lege onderdelen als 0 en telt NvT niet mee.
    var aantal = (einde - begin + 1) - nvt;
    return aantal > 0 ? (som / aantal).toFixed(1) : "";
}

function stageKies(doc, naam, groep) {
    var gekozen = doc.getField(naam);
    if (gekozen && gekozen.value !== "Off") {
        for (var i = 0; i < groep.length; i++) {
            if (groep[i] !== naam) {
                var ander = doc.getField(groep[i]);
                if (ander) ander.value = "Off";
            }
        }
    }
    doc.calculateNow();
}

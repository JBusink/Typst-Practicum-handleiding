# Aeropendulum: twee practica

```text
Arduino/
  Openloop/
    Aero_pendulum_OL_CSV/Aero_pendulum_OL_CSV.ino  <- gebruiken
    Archief/Aero_pendulum_basic/Aero_pendulum_basic.ino
  PID/
    Aero_pendulum_PID_CSV/Aero_pendulum_PID_CSV.ino <- gebruiken
    Archief/Aero_pendulum_PID/Aero_pendulum_PID.ino
```

De archieven bewaren de oorspronkelijke voorbeelden. De basic-sketch leest alleen
de sensor uit; de oude PID-sketch kan na reset automatisch de motor starten.
Gebruik voor het practicum de **CSV-sketches**. Iedere sketch staat in een eigen
Arduino-map. Zet geen meerdere sketches met setup/loop in dezelfde map.

## Eenvoudige meetcode

Beide sketches hebben dezelfde opbouw: instellingen, hoek uitlezen, setup, loop.
Openloop heeft geen PID-bibliotheek of PID-code. Meten, aansturen en loggen gebeurt
nominaal iedere 20 ms. De CSV heeft alleen de zes kolommen die nodig zijn voor de
meting. De grenzen en automatische stop blijven aanwezig.

## Gebruik vanuit Arduino IDE

1. Kies **Arduino Uno R4 Minima** en de juiste poort. Installeer **AS5600 van Rob
   Tillaart**; voor PID ook **PID van Brett Beauregard**.
2. Controleer de aansluitingen: D9 naar ENA, D10/11 naar IN1/IN2, A4/A5 naar
   SDA/SCL, gemeenschappelijke massa volgens het practicum.
3. Pas bovenaan de sketch de instellingen aan: bij Openloop `OPEN_LOOP_PWM`,
   bij PID `setpoint`, `kp`, `ki`, `kd`. Controleer `MAX_PWM`, hoekoffset en
   hoekgrenzen met de begeleider. De standaardwaarden zijn voorlopig.
4. Upload met de motorvoeding uit. Open Serial Monitor op **115200 baud**.
5. Verstuur **C** voor 10 seconden sensorcontrole met de motor uit.
6. Wis de monitoruitvoer, schakel de gecontroleerde motorvoeding in en houd
   afstand. Verstuur **S** voor de proef. Die stopt vanzelf na `MEASUREMENT_MS`
   (standaard 30 seconden). Verstuur **X** om eerder te stoppen.
7. Schakel de motorvoeding uit. Kopieer de volledige CSV-uitvoer naar een leeg
   tekstbestand en sla op als `.csv` (in Kladblok: bestandstype Alle bestanden).

Sluiten van Serial Monitor is geen stopcommando. Houd de fysieke uitschakeling
bereikbaar. Een ongeldige sensorstatus of werkhoek stopt de motor; softwarematige
stops vereisen dat de microcontroller zijn programma blijft uitvoeren.

Bij S of C moet de vorige opname gestopt zijn. Een geweigerde start geeft een
melding met `#`: controleer de opstelling en neem die melding niet op in de CSV.

## CSV

`t_ms,setpoint_deg,angle_deg,pwm,running,sensor_ok`

- `t_ms`: tijd sinds S of C, in ms; nul begint bij het commando.
- `setpoint_deg`: doelhoek; leeg bij Openloop.
- `angle_deg`: gemeten werkhoek; leeg bij sensorfout.
- `pwm`: daadwerkelijk aangeboden gehele PWM-telwaarde (geen spanning).
- `running`: 1 bij aandrijving, 0 bij sensorcontrole of fout.
- `sensor_ok`: 1 bij geldige sensorstatus en werkhoek.

Bewaar één opname per bestand, inclusief één kopregel. Controleer of de monitor
bij langere proeven het begin nog bewaart. Geen SD-kaart nodig: opslaan op de
computer gebeurt via kopiëren/plakken. Python is alleen voor analyse achteraf.
Leg de PWM-/PID-instellingen, voeding en kalibratie apart vast in het labjournaal.

```python
import pandas as pd
df = pd.read_csv('pid_run1.csv')
df['t_s'] = df.t_ms / 1000
print(df.t_ms.diff().describe())
```

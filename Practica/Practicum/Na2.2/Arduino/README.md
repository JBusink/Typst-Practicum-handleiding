# Aeropendulum: stappen 1-5

De bestanden zijn per practicum en stap geordend. Iedere Arduino-map bevat precies
een hoofdsketch met dezelfde naam als de map.

```text
Arduino/
  README.md
  OpenLoop/
    Stap_1_Sensor/Stap_1_Sensor.ino
    Stap_2_PWM_en_sensor/Stap_2_PWM_en_sensor.ino
    Stap_3_Python_aansturing/Stap_3_Python_aansturing.ino
  ClosedLoop/
    Stap_4_PID/Stap_4_PID.ino
    Stap_5_PWM_begrenzing/Stap_5_PWM_begrenzing.ino
  Python/
    open_loop.py
    closed_loop.py
```

## Open-loop: stappen 1-3

1. Sensor uitlezen; geen motoraansturing.
2. Vaste PWM; de motor start direct bij inschakelen/resetten.
3. Python-aansturing met PWM, meetinterval, START, STOP en heartbeat.

Zie `../Aero_pendulum_OL.typ`. `Python/open_loop.py` is het voorbeeld uit die
handleiding. Pas poort, PWM en bestandsnaam bovenaan aan. De standaard-PWM is 0.
Stap 3 verstuurt twee velden: tijd sinds Arduino-start en ruwe sensorhoek.

## Closed-loop: een sketch en een functie

Gebruik `ClosedLoop/Stap_4_PID/Stap_4_PID.ino` voor PID en voor de vervolgopdracht
met een lagere hoekgrens. De oude aparte stap-5-sketch staat in `Archief`.

In Practica HvA Github: gebruik `voer_pid_stap4_uit(...)` uit
`closed_loop/meting.py`. Zonder argument `max_hoek` wordt 180 graden meegestuurd.
Dezelfde aanroep met `max_hoek=120` gebruikt een lagere grens. Beide aanroepen
gebruiken hetzelfde CONFIG-formaat met negen velden en dezelfde Arduino-sketch.

Het losse CLI-voorbeeld in deze map gebruikt dezelfde sketch:

```text
python Python/closed_loop.py --poort COM4 --beginhoek 90 --doelhoek 20 --kp 2 --ki 0 --kd 0 --max-pwm 0 --bestand Metingen/pid_test.csv
```

Ook hier is de standaardgrens 180 graden; voeg `--max-hoek 120` toe om die te
verlagen. De ondergrens `minHoek` staat in de Arduino-code (standaard -10).
Het CLI-voorbeeld schrijft `t_ms,setpoint_deg,angle_deg,pwm`; de notebookfunctie
schrijft instellingen en `tijd_s,hoek_deg,pwm`. Gebruik de bijbehorende analyse.

## Aansluiten en starten

- Arduino Uno R4 Minima; AS5600 van Rob Tillaart; voor stappen 4-5 ook PID van
  Brett Beauregard. Python: `python -m pip install pyserial pandas matplotlib`.
- COM4 was de gevonden poort; controleer de poort opnieuw bij een andere computer.
  Alle scripts gebruiken 115200 baud. Sluit Serial Monitor/Plotter voor Python.
- Upload en wijzig bedrading met uitgeschakelde motorvoeding. De volledige
  aansluittabel staat in de open-loophandleiding.
- De gezamenlijke sketch heeft een PWM-grens, STOP, eindige proefduur en heartbeat.
  Alleen overschrijding van maxHoek veroorzaakt de hoekstop; magneetstatus niet. Zonder heartbeat stopt de regeling
  na ruim 3 seconden. Houd de fysieke uitschakeling bereikbaar.
- `Metingen/` wordt bij de eerste closed-loopproef aangemaakt. Bewaar instellingen
  en testresultaten bij de CSV-bestanden in je eigen practicum-map.

## Sensorrichting

Bij deze montage neemt de sensorhoek toe bij optillen van de arm. De werkhoek
is daarom `sensorhoek - beginhoek`, teruggevouwen naar -180 tot 180 graden.
Stappen 1-3 leveren ruwe sensorhoeken; stappen 4-5 passen deze omzetting op de
Arduino toe, zowel bij START als tijdens PID en hoekbewaking.

## Stap 5: PWM-veranderingssnelheid

Upload `ClosedLoop/Stap_5_PWM_begrenzing/Stap_5_PWM_begrenzing.ino`.
In Practica HvA Github staat de opdracht in `stap_5.ipynb`:
`voer_pid_stap5_uit(..., max_pwm_stap=20)`.
Dit begrenst stijgen en dalen tot 20 PWM-telwaarden per regelstap. Gebruik 0 voor
een vergelijkingsproef zonder limiter. Laat het argument in stap 4 weg.
Voor het CLI-voorbeeld: voeg `--max-pwm-stap 20` toe.
De instelling gaat via `PWMSTAP:20` en moet met `PWMSTAP_OK` bevestigd worden voor START.
STOP, hoekstop, watchdog en meetduur schakelen direct uit en wissen de limiter.
De bestaande gain-schedulingnotebook is bewaard als `verdieping_pid_afstellen.ipynb`.

De Python-functies zijn expliciet gescheiden: `voer_pid_stap4_uit` en
`voer_pid_stap5_uit`. Upload de bijbehorende bijgewerkte sketch: Python controleert
`VERSIE` voor START. Stap 5 verstuurt PWMSTAP alleen als max_pwm_stap expliciet is opgegeven. Zonder argument is de limiter uit; vorige instellingen worden bij een nieuwe proef gewist.
`max_pwm` bepaalt de maximale uitgang; bij 0 blijft de motor uit, ook als de
veranderingssnelheid niet nul is. Het stap-5-voorbeeld gebruikt max_pwm=120;
neem je eigen gekozen grens uit stap 4 over.

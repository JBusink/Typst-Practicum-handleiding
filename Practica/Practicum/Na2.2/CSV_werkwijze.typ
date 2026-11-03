#import "../../styl.typ": *

#heading(level: 2, numbering: none)[Meetgegevens opslaan]

De meetprocedure verschilt per stap. Gebruik voor open-loop de instructies in `Aero_pendulum_OL.typ` en `Arduino/Python/open_loop.py`. Gebruik voor closed-loop de twee delen in `Aero_pendulum_PID.typ` en `Arduino/Python/closed_loop.py`.

Stap 3 levert ruwe sensorhoek en tijd sinds Arduino-start. Stappen 4 en 5 leveren tijd sinds START, setpoint, werkhoek en PWM. De Python-scripts schrijven de CSV-kop. Bewaar per proef een apart bestand en noteer de gebruikte instellingen in je labjournaal. Zie `Arduino/README.md` voor de mappenstructuur.

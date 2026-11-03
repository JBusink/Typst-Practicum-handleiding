import csv
import time
import serial

from serial.tools import list_ports

print('Beschikbare poorten:', [(p.device, p.description) for p in list_ports.comports()])
poort = 'COM4'  # Vul de poort uit de Arduino IDE in.
pwm = 0         # Eerst testen op 0; daarna afgesproken waarde.
meetduur_s = 30
bestandsnaam = f'ol_pwm{pwm}_run1.csv'

with serial.Serial(poort, 115200, timeout=0.1) as arduino:
    try:
        time.sleep(2)  # Wacht op een eventuele reset.
        arduino.reset_input_buffer()
        print(f'Verbonden met {poort}; ingestelde PWM: {pwm}')
        if pwm == 0:
            print('PWM is 0: de motor blijft uit tijdens deze communicatieproef.')

        def stuur(tekst):
            arduino.write((tekst + '\n').encode('ascii'))
            arduino.flush()

        stuur('PWM:0')
        stuur('DT:100')
        with open(bestandsnaam, 'w', newline='') as bestand:
            schrijver = csv.writer(bestand)
            schrijver.writerow(['t_ms', 'angle_deg'])
            stuur('START')
            stuur(f'PWM:{pwm}')
            begin = time.monotonic()
            laatste_ping = begin
            laatste_meetpunt = begin
            aantal = 0
            print('Meting gestart; onderbreek met Ctrl+C om te stoppen.')
            while time.monotonic() - begin < meetduur_s:
                nu = time.monotonic()
                if nu - laatste_ping >= 0.5:
                    stuur('PING')
                    laatste_ping = nu
                regel = arduino.readline().decode('ascii').strip()
                if not regel:
                    if time.monotonic() - laatste_meetpunt > 3:
                        raise TimeoutError(
                            'Geen meetgegevens: controleer poort, baudrate en of '
                            'Stap_3_Python_aansturing is geupload. Sluit Serial Monitor.'
                        )
                    continue
                if regel.startswith('DEBUG_'):
                    print(regel)
                    if regel == 'DEBUG_WATCHDOG':
                        raise RuntimeError('Watchdog: proef gestopt')
                    continue
                velden = regel.split(',')
                if len(velden) == 2:
                    tijd_ms, hoek = int(velden[0]), float(velden[1])
                    schrijver.writerow([tijd_ms, hoek])
                    laatste_meetpunt = time.monotonic()
                    aantal += 1
                    if aantal == 1 or aantal % 10 == 0:
                        print(f'{aantal} meetpunten; sensorhoek: {hoek:.3f} graden')
                else:
                    raise ValueError(f'Onverwachte Arduino-uitvoer: {regel!r}')
            print(f'{aantal} meetpunten opgeslagen in {bestandsnaam}')
    finally:
        arduino.write(b'STOP\n')
        arduino.flush()

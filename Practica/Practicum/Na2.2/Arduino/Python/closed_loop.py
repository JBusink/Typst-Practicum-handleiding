"""PID uitvoeren. Upload Stap_4_PID.ino; max-hoek is standaard 180 graden."""
import argparse
import csv
import math
from pathlib import Path
import time

import serial


def uitvoeren(args):
    args.bestand.parent.mkdir(parents=True, exist_ok=True)
    with serial.Serial(args.poort, 115200, timeout=0.1, write_timeout=1) as arduino:
        def stuur(tekst):
            arduino.write((tekst + '\n').encode('ascii'))
            arduino.flush()

        def verwacht(commando, antwoord):
            stuur(commando)
            einde = time.monotonic() + 3
            while time.monotonic() < einde:
                regel = arduino.readline().decode('ascii').strip()
                if regel == antwoord:
                    return
                if regel.startswith('ERROR:'):
                    raise RuntimeError(regel)
            raise TimeoutError(f'Geen {antwoord}: controleer poort en geuploade stap.')

        try:
            time.sleep(2)
            arduino.reset_input_buffer()
            verwacht('HELLO', 'PID_READY')
            stap = 4 if args.max_pwm_stap is None else 5
            verwacht('VERSIE', f'PID_STAP{stap}')
            verwacht(f'OFFSET:{args.beginhoek}', 'OFFSET_OK')
            velden = [args.doelhoek, args.kp, args.ki, args.kd, args.max_pwm,
                      int(args.duur * 1000), args.interval, 0]
            velden.append(args.max_hoek)
            verwacht('CONFIG:' + ','.join(map(str, velden)), 'CONFIG_OK')
            if args.max_pwm_stap is not None:
                verwacht(f'PWMSTAP:{args.max_pwm_stap}', 'PWMSTAP_OK')
            # 'x' voorkomt dat een eerdere proef per ongeluk wordt overschreven.
            with args.bestand.open('x', newline='', encoding='utf-8') as bestand:
                schrijver = csv.writer(bestand)
                schrijver.writerow(['t_ms', 'setpoint_deg', 'angle_deg', 'pwm'])
                verwacht('START', 'STARTED')
                begin = laatste_data = laatste_ping = time.monotonic()
                aantal = 0
                while time.monotonic() - begin < args.duur + 3:
                    nu = time.monotonic()
                    if nu - laatste_ping >= 0.5:
                        stuur('PING')
                        laatste_ping = nu
                    regel = arduino.readline().decode('ascii').strip()
                    if regel == 'DONE':
                        print(f'Klaar: {aantal} meetpunten in {args.bestand}')
                        return
                    if regel.startswith('ERROR:') or regel == 'DEBUG_WATCHDOG':
                        raise RuntimeError(regel)
                    if regel.startswith('DEBUG_'):
                        continue
                    if regel:
                        waarden = regel.split(',')
                        if len(waarden) != 4:
                            raise ValueError(f'Onverwachte uitvoer: {regel!r}')
                        schrijver.writerow([int(waarden[0]), float(waarden[1]),
                                             float(waarden[2]), int(waarden[3])])
                        laatste_data = time.monotonic()
                        aantal += 1
                        if aantal == 1 or aantal % 10 == 0:
                            print(f'{aantal} meetpunten; hoek {waarden[2]}; PWM {waarden[3]}')
                    if time.monotonic() - laatste_data > 3:
                        raise TimeoutError('Geen meetgegevens ontvangen.')
                raise TimeoutError('Arduino heeft geen DONE verstuurd.')
        finally:
            stuur('STOP')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--poort', default='COM4')
    parser.add_argument('--beginhoek', type=float, required=True,
                        help='Ruwe sensorhoek bij verticale ruststand, in graden.')
    parser.add_argument('--doelhoek', type=float, default=20)
    parser.add_argument('--kp', type=float, default=2)
    parser.add_argument('--ki', type=float, default=0)
    parser.add_argument('--kd', type=float, default=0)
    parser.add_argument('--max-pwm', type=int, required=True)
    parser.add_argument('--max-hoek', type=float, default=180)
    parser.add_argument('--max-pwm-stap', type=int, default=None,
                        help='Stap 5: maximale PWM-sprong per regelstap; 0 schakelt de limiter uit.')
    parser.add_argument('--duur', type=float, default=30)
    parser.add_argument('--interval', type=int, default=100)
    parser.add_argument('--bestand', type=Path, required=True)
    args = parser.parse_args()
    if not (0 <= args.max_pwm <= 255 and 20 <= args.interval <= 1000
            and args.interval <= args.duur * 1000 <= 600000):
        parser.error('Controleer PWM (0-255), interval (20-1000 ms) en duur (max. 600 s).')
    if args.max_pwm_stap is not None and (
            not 0 <= args.max_pwm_stap <= 255):
        parser.error("De maximale PWM-stap moet tussen 0 en 255 liggen.")
    uitvoeren(args)


if __name__ == '__main__':
    main()

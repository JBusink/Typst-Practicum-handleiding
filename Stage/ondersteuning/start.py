"""Start de PDF-bouw met een eigen, lokale Python-omgeving."""
from pathlib import Path
import subprocess
import sys
import venv


def main():
    support=Path(__file__).resolve().parent
    environment=support/'.venv'
    python=environment/('Scripts/python.exe' if sys.platform=='win32' else 'bin/python')
    if not python.exists():
        print('Eenmalig de lokale bouwomgeving voorbereiden...',flush=True)
        venv.EnvBuilder(with_pip=True).create(environment)
    check=subprocess.run([str(python),'-c','import typst, pypdf'],capture_output=True)
    if check.returncode:
        print('Eenmalig de benodigde Python-pakketten installeren...',flush=True)
        subprocess.run([str(python),'-m','pip','install','-r',str(support/'requirements.txt')],check=True)
    subprocess.run([str(python),'-B',str(support/'build_stage.py'),*sys.argv[1:]],check=True)
    print('\nKlaar. Open de invulbare bestanden in: '+str(support.parent/'PDF'),flush=True)


if __name__=='__main__':
    try:
        main()
    except (OSError,subprocess.CalledProcessError) as error:
        print(f'Bouwen is niet gelukt: {error}',file=sys.stderr)
        sys.exit(1)

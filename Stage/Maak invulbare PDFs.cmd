@echo off
python "%~dp0ondersteuning\start.py" %*
if errorlevel 1 (
  echo.
  echo Het bouwen is mislukt. Zie de melding hierboven.
  pause
  exit /b 1
)
echo.
pause

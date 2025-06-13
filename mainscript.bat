@echo off
setlocal enabledelayedexpansion

:LOGIN
cls
echo ==========================================
echo           STEALTH LOADER V2
echo ==========================================
echo.
set /p "userpass=Enter Password: "

:: Check password '1' for PC Optimization
if "%userpass%"=="1" (
    echo Launching PC Optimization Menu...
    timeout /t 2 >nul
    goto :EOF
)

:: Check secret password from GitHub
echo Verifying secret password...
curl -s -o "%temp%\remote_pass.txt" "https://raw.githubusercontent.com/maxyprime/stealthloaderv2/refs/heads/main/password.txt"
set /p secret=<"%temp%\remote_pass.txt"
del "%temp%\remote_pass.txt" >nul 2>&1

if /i "%userpass%"=="%secret%" (
    goto :STEALTH_MENU
) else (
    echo Incorrect password. Try again.
    timeout /t 2 >nul
    goto :LOGIN
)

:STEALTH_MENU
cls
echo.
echo ========== STEALTH MENU ==========
echo 1. Setup
echo 2. Run
echo 3. Bypass
echo 4. Exit
echo ==================================
set /p "choice=Choose an option: "

if "%choice%"=="1" goto :SETUP
if "%choice%"=="2" goto :RUN
if "%choice%"=="3" goto :BYPASS
if "%choice%"=="4" exit

echo Invalid choice.
timeout /t 2 >nul
goto :STEALTH_MENU

:SETUP
echo Downloading EXE...
curl -L -o "%TEMP_EXE%" "%EXE_URL%"
if exist "%TEMP_EXE%" (
    echo Setup completed.
) else (
    echo Download failed.
)
pause
goto :STEALTH_MENU

:RUN
echo Running EXE as disguised .dat...
start "" "%TEMP_EXE%"
pause
goto :STEALTH_MENU

:BYPASS
echo Cleaning up...
del /f /q "%TEMP_EXE%" >nul 2>&1
echo Done.
pause
goto :STEALTH_MENU


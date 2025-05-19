@echo off
REM === CONFIG ===
set "MOD_DIR=%USERPROFILE%\fabric-smp-server\mods"

REM === MOD LIST DEFINITIONS ===
REM To keep things readable, each mod list is a single variable with space-separated URLs

set SMPMODS=https://cdn.modrinth.com/data/AANobbMI/versions/1.10.0/origins-1.10.0.jar https://cdn.modrinth.com/data/4P9FNjpb/versions/4.1.0/extra-origins-4.1.0.jar https://cdn.modrinth.com/data/zL7V1slW/versions/13.0.708/roughly-enough-items-13.0.708.jar https://cdn.modrinth.com/data/3gvlM4W2/versions/2.5.1/better-combat-fabric-1.21.5-2.5.1.jar
set PVPMODS=https://cdn.modrinth.com/data/jarfile1.jar https://cdn.modrinth.com/data/jarfile2.jar
set VANILLAMODS=
set ENHANCEDVANILLAMODS=https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar
set OPTIMIZEDSMPMODS=https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar
set OPTIMIZEDPVPMODS=https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar https://cdn.modrinth.com/data/jarfile1.jar
set CREATIVEMODS=https://cdn.modrinth.com/data/jarfile3.jar https://cdn.modrinth.com/data/jarfile4.jar
set OPTIMIZEDCREATIVEMODS=https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar https://cdn.modrinth.com/data/jarfile3.jar

REM === MENU SYSTEM ===
echo Available mod lists:
echo - SMPMODS
echo - PVPMODS
echo - VANILLAMODS
echo - ENHANCEDVANILLAMODS
echo - OPTIMIZEDSMPMODS
echo - OPTIMIZEDPVPMODS
echo - CREATIVEMODS
echo - OPTIMIZEDCREATIVEMODS
echo.

set /p chosen_mod_list="Type the name of the mod list you want to install: "

REM === VALIDATE AND RUN ===
call set "mods=%%%chosen_mod_list%%%"
if "%mods%"=="" (
    echo [!] Invalid mod list name. Please choose from the available options.
    exit /b 1
)

REM === CREATE MOD DIR ===
if not exist "%MOD_DIR%" (
    mkdir "%MOD_DIR%"
)

REM === DOWNLOAD MODS ===
echo Downloading mods to %MOD_DIR% ...
for %%u in (%mods%) do (
    set "mod_url=%%u"
    call :download_mod "%%u"
)
echo All mods updated successfully.
exit /b 0

:download_mod
REM %1 = mod URL
setlocal
set "mod_url=%~1"
for %%f in ("%mod_url%") do set "mod_file=%MOD_DIR%\%%~nxf"
echo Downloading %mod_url% ...
powershell -Command "try { Invoke-WebRequest -Uri '%mod_url%' -OutFile '%mod_file%' -UseBasicParsing } catch { Write-Host 'Failed to download %mod_url%. Skipping...' }"
endlocal
exit /b

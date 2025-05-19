@echo off
setlocal enabledelayedexpansion

echo Welcome to the Minecraft Server Setup!
echo Select server type to install:
echo 1^> Fabric (for mods)
echo 2^> Forge (for mods)
echo 3^> PaperMC (for plugins)
set /p CHOICE=Enter the number of your choice [1-3]: 

if "%CHOICE%"=="1" (
    echo Setting up Fabric server...
    if not exist fabric-installer.jar (
        curl -L -o fabric-installer.jar https://meta.fabricmc.net/v2/versions/installer/fabric-installer-1.0.0.jar
    )
    java -jar fabric-installer.jar server -downloadMinecraft
    if not exist mods (
        mkdir mods
    )
    REM === Add your Fabric mod URLs below ===
    set MODS=https://example.com/mod1-fabric.jar https://example.com/mod2-fabric.jar
    for %%M in (%MODS%) do (
        curl -L -o mods/%%~nxM %%M
    )
    echo eula=true > eula.txt
    echo Fabric server setup complete.
    goto :end
)

if "%CHOICE%"=="2" (
    echo Setting up Forge server...
    set FORGE_VERSION=1.21.1-47.0.0
    set FORGE_INSTALLER=forge-%FORGE_VERSION%-installer.jar
    set FORGE_URL=https://maven.minecraftforge.net/net/minecraftforge/forge/%FORGE_VERSION%/%FORGE_INSTALLER%
    if not exist %FORGE_INSTALLER% (
        curl -L -o %FORGE_INSTALLER% %FORGE_URL%
    )
    java -jar %FORGE_INSTALLER% --installServer
    if not exist mods (
        mkdir mods
    )
    REM === Add your Forge mod URLs below ===
    set MODS=https://example.com/mod1-forge.jar https://example.com/mod2-forge.jar
    for %%M in (%MODS%) do (
        curl -L -o mods/%%~nxM %%M
    )
    echo eula=true > eula.txt
    echo Forge server setup complete.
    goto :end
)

if "%CHOICE%"=="3" (
    echo Setting up PaperMC server...
    REM Automatically get the latest PaperMC version and build using PowerShell
    for /f "tokens=*" %%a in ('powershell -Command "$v=(Invoke-RestMethod https://api.papermc.io/v2/projects/paper).versions[-1]; $b=(Invoke-RestMethod ""https://api.papermc.io/v2/projects/paper/versions/$v"").builds[-1]; Write-Output $v $b"') do (
        set PAPER_VER=%%a
        goto :gotver
    )
    :gotver
    for /f "tokens=1,2" %%a in ("%PAPER_VER%") do (
        set PV=%%a
        set PB=%%b
    )
    set PAPER_JAR=paper-%PV%-%PB%.jar
    set PAPER_URL=https://api.papermc.io/v2/projects/paper/versions/%PV%/builds/%PB%/downloads/paper-%PV%-%PB%.jar
    curl -L -o %PAPER_JAR% %PAPER_URL%
    if not exist plugins (
        mkdir plugins
    )
    echo eula=true > eula.txt
    echo PaperMC server setup complete.
    goto :end
)

echo Invalid choice. Exiting.
goto :eof

:end
echo Setup finished! Use the start-server.bat file to launch your server.
pause

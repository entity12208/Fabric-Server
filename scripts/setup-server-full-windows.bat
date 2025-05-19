@echo off
REM === CONFIGURATION ===
set "INSTALL_DIR=%USERPROFILE%\minecraft-server"
set "BACKUP_DIR=%INSTALL_DIR%\backups"
set "MODS_SCRIPT=%~dp0update-mods.bat"
set "SERVER_JAR="
set "JAVA_CMD=java"

REM === CHECK FOR DEPENDENCIES ===
echo Checking for required dependencies...

REM Check for Java
where %JAVA_CMD% >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Java is not installed or not in PATH.
    echo Please install Java (e.g., OpenJDK 21+) and re-run this script.
    pause
    exit /b 1
)

REM Check for curl
where curl >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] curl is not installed or not in PATH.
    echo Please install curl or use Windows 10+ where curl is included.
    pause
    exit /b 1
)

REM === PROMPT FOR SERVER CONFIGURATION ===
set /p MC_VERSION="Enter Minecraft version (e.g., 1.21.5): "
echo Available server types: fabric, paper, forge, vanilla
set /p SERVER_TYPE="Enter server type: "

if "%MC_VERSION%"=="" (
    echo [ERROR] Minecraft version cannot be empty.
    pause
    exit /b 1
)
if "%SERVER_TYPE%"=="" (
    echo [ERROR] Server type cannot be empty.
    pause
    exit /b 1
)

REM === FETCH SERVER JAR ===
set "SERVER_JAR_URL=https://mcutils.com/api/server-jars/%SERVER_TYPE%/%MC_VERSION%/download"
echo Fetching server JAR from %SERVER_JAR_URL%...

REM Test if URL is reachable
curl -s -o nul -w "%%{http_code}" "%SERVER_JAR_URL%" > tmp_status.txt
set /p HTTP_STATUS=<tmp_status.txt
del tmp_status.txt

if not "%HTTP_STATUS%"=="200" (
    echo [ERROR] Failed to fetch server JAR URL. HTTP status: %HTTP_STATUS%
    pause
    exit /b 1
)

REM === SETUP DIRECTORY STRUCTURE ===
echo Creating server folder structure at %INSTALL_DIR%...
mkdir "%INSTALL_DIR%"
mkdir "%BACKUP_DIR%"
cd /d "%INSTALL_DIR%" || (
    echo [ERROR] Failed to enter %INSTALL_DIR%. Check permissions.
    pause
    exit /b 1
)

REM === DOWNLOAD SERVER JAR ===
set "SERVER_JAR=server-%MC_VERSION%-%SERVER_TYPE%.jar"
echo Downloading server JAR as %SERVER_JAR%...
curl -L -o "%SERVER_JAR%" "%SERVER_JAR_URL%"
if not exist "%SERVER_JAR%" (
    echo [ERROR] Failed to download server JAR.
    pause
    exit /b 1
)

REM === ACCEPT EULA ===
echo eula=true > eula.txt
echo Accepted Minecraft EULA.

REM === INSTALL MODS ===
if exist "%MODS_SCRIPT%" (
    echo Running Mod Installer...
    call "%MODS_SCRIPT%"
) else (
    echo [WARNING] Mod Installer script not found at %MODS_SCRIPT%. Skipping mod installation.
)

REM === CREATE START SCRIPT ===
set "START_SCRIPT=%INSTALL_DIR%\start-server.bat"
echo Creating start script at %START_SCRIPT%...
(
echo @echo off
echo cd /d "%INSTALL_DIR%"
echo echo Updating mods before starting the server...
echo call "%MODS_SCRIPT%"
echo echo Starting Minecraft server...
echo java -Xms2G -Xmx4G -jar "%SERVER_JAR%" nogui
) > "%START_SCRIPT%"
attrib +x "%START_SCRIPT%"

REM === CREATE BACKUP SCRIPT ===
set "BACKUP_SCRIPT=%INSTALL_DIR%\backup.bat"
echo Creating backup script at %BACKUP_SCRIPT%...
(
echo @echo off
echo cd /d "%INSTALL_DIR%"
echo powershell -Command "Compress-Archive -Path world -DestinationPath \"%BACKUP_DIR%\world-$(Get-Date -Format yyyy-MM-dd).zip\""
echo REM Clean backups older than 7 days
echo powershell -Command "Get-ChildItem -Path \"%BACKUP_DIR%\" -Filter *.zip ^| Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } ^| Remove-Item"
) > "%BACKUP_SCRIPT%"
attrib +x "%BACKUP_SCRIPT%"

REM === INSTRUCTION FOR TASK SCHEDULER ===
echo.
echo [INFO] To run the server and backups automatically on Windows:
echo 1. Add start-server.bat to Task Scheduler with "At log on" or "At startup" trigger.
echo 2. Add backup.bat to Task Scheduler with a "Daily" trigger (e.g., 3 AM).
echo.
echo [INFO] See https://learn.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-start-page for Task Scheduler usage.
echo.

REM === START THE SERVER ===
echo Starting the server...
call "%START_SCRIPT%"

echo Minecraft server %MC_VERSION% (%SERVER_TYPE%) is up and running.
echo World backups will be created in: %BACKUP_DIR%
pause

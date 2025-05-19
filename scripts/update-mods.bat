@echo off
setlocal

REM Attempt to determine server type and update mods/plugins
if exist fabric-server-launch.jar (
    echo Updating Fabric mods...
    if not exist mods (
        mkdir mods
    )
    REM === Add your Fabric mod URLs below ===
    set MODS=https://example.com/mod1-fabric-latest.jar https://example.com/mod2-fabric-latest.jar
    for %%M in (%MODS%) do (
        curl -L -o mods/%%~nxM %%M
    )
    echo Fabric mods updated.
    goto :end
)

for %%f in (forge-*-universal.jar) do (
    echo Updating Forge mods...
    if not exist mods (
        mkdir mods
    )
    REM === Add your Forge mod URLs below ===
    set MODS=https://example.com/mod1-forge-latest.jar https://example.com/mod2-forge-latest.jar
    for %%M in (%MODS%) do (
        curl -L -o mods/%%~nxM %%M
    )
    echo Forge mods updated.
    goto :end
)

for %%f in (paper-*.jar) do (
    echo Updating PaperMC plugins...
    if not exist plugins (
        mkdir plugins
    )
    REM === Add your PaperMC plugin URLs below ===
    set PLUGINS=https://example.com/plugin1-latest.jar https://example.com/plugin2-latest.jar
    for %%P in (%PLUGINS%) do (
        curl -L -o plugins/%%~nxP %%P
    )
    echo PaperMC plugins updated.
    goto :end
)

echo No server type detected.
goto :eof

:end
pause

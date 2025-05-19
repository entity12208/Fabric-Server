#!/bin/bash
set -e

# Attempt to determine server type
if [ -f fabric-server-launch.jar ]; then
    echo "Updating Fabric mods..."
    MODS=(
        "https://example.com/mod1-fabric-latest.jar"
        "https://example.com/mod2-fabric-latest.jar"
    )
    mkdir -p mods
    for mod in "${MODS[@]}"; do
        curl -L -o "mods/$(basename $mod)" "$mod"
    done
    echo "Fabric mods updated."
elif ls forge-*-universal.jar 1> /dev/null 2>&1; then
    echo "Updating Forge mods..."
    MODS=(
        "https://example.com/mod1-forge-latest.jar"
        "https://example.com/mod2-forge-latest.jar"
    )
    mkdir -p mods
    for mod in "${MODS[@]}"; do
        curl -L -o "mods/$(basename $mod)" "$mod"
    done
    echo "Forge mods updated."
elif ls paper-*.jar 1> /dev/null 2>&1; then
    echo "Updating PaperMC plugins..."
    PLUGINS=(
        "https://example.com/plugin1.jar"
        "https://example.com/plugin2.jar"
    )
    mkdir -p plugins
    for plugin in "${PLUGINS[@]}"; do
        curl -L -o "plugins/$(basename $plugin)" "$plugin"
    done
    echo "PaperMC plugins updated."
else
    echo "No server type detected."
    exit 1
fi

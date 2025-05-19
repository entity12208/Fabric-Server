#!/bin/bash
set -e

echo "Welcome to the Minecraft Server Setup!"
echo "Select server type to install:"
echo "1) Fabric (for mods)"
echo "2) Forge (for mods)"
echo "3) PaperMC (for plugins)"
read -p "Enter the number of your choice [1-3]: " CHOICE

case "$CHOICE" in
    1)
        echo "Setting up Fabric server..."
        if [ ! -f fabric-installer.jar ]; then
            curl -O https://meta.fabricmc.net/v2/versions/installer/fabric-installer-1.0.0.jar
            mv fabric-installer-1.0.0.jar fabric-installer.jar
        fi
        java -jar fabric-installer.jar server -downloadMinecraft
        MODS=(
            "https://example.com/mod1-fabric.jar"
            "https://example.com/mod2-fabric.jar"
        )
        mkdir -p mods
        for mod in "${MODS[@]}"; do
            curl -L -o "mods/$(basename $mod)" "$mod"
        done
        echo "eula=true" > eula.txt
        echo "Fabric server setup complete."
        ;;
    2)
        echo "Setting up Forge server..."
        FORGE_VERSION="1.21.1-47.0.0"
        FORGE_INSTALLER="forge-$FORGE_VERSION-installer.jar"
        FORGE_URL="https://maven.minecraftforge.net/net/minecraftforge/forge/$FORGE_VERSION/$FORGE_INSTALLER"
        if [ ! -f $FORGE_INSTALLER ]; then
            curl -O "$FORGE_URL"
        fi
        java -jar $FORGE_INSTALLER --installServer
        MODS=(
            "https://example.com/mod1-forge.jar"
            "https://example.com/mod2-forge.jar"
        )
        mkdir -p mods
        for mod in "${MODS[@]}"; do
            curl -L -o "mods/$(basename $mod)" "$mod"
        done
        echo "eula=true" > eula.txt
        echo "Forge server setup complete."
        ;;
    3)
        echo "Setting up PaperMC server..."
        PAPER_VERSION=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r '.versions[-1]')
        PAPER_BUILD=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/$PAPER_VERSION" | jq -r '.builds[-1]')
        PAPER_JAR="paper-$PAPER_VERSION-$PAPER_BUILD.jar"
        PAPER_URL="https://api.papermc.io/v2/projects/paper/versions/$PAPER_VERSION/builds/$PAPER_BUILD/downloads/paper-$PAPER_VERSION-$PAPER_BUILD.jar"
        curl -o "$PAPER_JAR" "$PAPER_URL"
        mkdir -p plugins
        echo "eula=true" > eula.txt
        echo "PaperMC server setup complete."
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Setup finished! Use the appropriate start script to launch your server."

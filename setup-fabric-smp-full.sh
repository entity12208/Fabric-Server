#!/bin/bash

# === CONFIG ===
MC_VERSION="1.21.5"
FABRIC_INSTALLER_VERSION="0.11.2"
FABRIC_LOADER_VERSION="0.15.7"
INSTALL_DIR="$HOME/fabric-smp-server"
MOD_DIR="$INSTALL_DIR/mods"
BACKUP_DIR="$INSTALL_DIR/backups"

# === DEPENDENCIES ===
sudo apt update && sudo apt install -y openjdk-21-jre-headless screen curl unzip

# === CREATE SERVER FOLDER ===
mkdir -p "$MOD_DIR"
cd "$INSTALL_DIR"

# === INSTALL FABRIC SERVER ===
curl -O "https://maven.fabricmc.net/net/fabricmc/fabric-installer/$FABRIC_INSTALLER_VERSION/fabric-installer-$FABRIC_INSTALLER_VERSION.jar"
java -jar fabric-installer-$FABRIC_INSTALLER_VERSION.jar server -mcversion $MC_VERSION -loader $FABRIC_LOADER_VERSION -downloadMinecraft
rm "fabric-installer-$FABRIC_INSTALLER_VERSION.jar"

# === ACCEPT EULA ===
echo "eula=true" > eula.txt

# === DOWNLOAD MODS ===
echo "⬇️ Downloading mods..."

MODS=(
  # Gameplay Mods
  "https://cdn.modrinth.com/data/AANobbMI/versions/1.10.0/origins-1.10.0.jar"
  "https://cdn.modrinth.com/data/4P9FNjpb/versions/4.1.0/extra-origins-4.1.0.jar"
  "https://cdn.modrinth.com/data/3gvlM4W2/versions/2.5.1/better-combat-fabric-1.21.5-2.5.1.jar"
  "https://cdn.modrinth.com/data/zL7V1slW/versions/13.0.708/roughly-enough-items-13.0.708.jar"

  # Required Libraries
  "https://cdn.modrinth.com/data/9s6osm5g/versions/14.1.134/cloth-config-14.1.134-fabric.jar"
  "https://cdn.modrinth.com/data/bVYH1m1m/versions/5.3.1/cardinal-components-api-5.3.1.jar"

  # Performance Mods
  "https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar"
  "https://cdn.modrinth.com/data/1eAoo2KR/versions/1.7.2.2/fabric-api-1.7.2.2.jar"
  "https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar"
  "https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar"
  "https://cdn.modrinth.com/data/P7dR8mSH/versions/2.3.0/modernfix-fabric-2.3.0-mc1.21.5.jar"
  "https://cdn.modrinth.com/data/gvQqBUqZ/versions/1.21.5-1.1.3/dashloader-fabric-1.21.5-1.1.3.jar"
)

for mod_url in "${MODS[@]}"; do
  curl -L -o "$MOD_DIR/$(basename "$mod_url")" "$mod_url"
done

# === CREATE START SCRIPT (with auto-restart) ===
cat <<EOF > start-server.sh
#!/bin/bash
cd "$INSTALL_DIR"
while true; do
  echo "🟢 Starting Minecraft server..."
  screen -S smpserver -dm java -Xms1G -Xmx2G -jar fabric-server-launch.jar nogui
  wait \$!
  echo "🔁 Server crashed. Restarting in 10s..."
  sleep 10
done
EOF
chmod +x start-server.sh

# === CREATE DAILY BACKUP SCRIPT ===
mkdir -p "$BACKUP_DIR"
cat <<EOF > backup.sh
#!/bin/bash
cd "$INSTALL_DIR"
tar -czf "$BACKUP_DIR/world-\$(date +%F).tar.gz" world
find "$BACKUP_DIR" -type f -mtime +7 -delete
EOF
chmod +x backup.sh

# Add to crontab: auto-start and daily backup
(crontab -l 2>/dev/null; echo "@reboot $INSTALL_DIR/start-server.sh") | crontab -
(crontab -l 2>/dev/null; echo "0 3 * * * $INSTALL_DIR/backup.sh") | crontab -

# === WHITELIST SETUP ===
cat <<EOF > whitelist.json
[
  {
    "uuid": "00000000-0000-0000-0000-000000000000",
    "name": "YourNameHere"
  }
]
EOF

echo 'white-list=true' >> server.properties
echo 'enable-command-block=true' >> server.properties

# === START THE SERVER ===
./start-server.sh

echo "✅ Fabric SMP 1.21.5 server is up with Origins, REI, Better Combat, and performance mods."
echo "📂 Mods directory: $MOD_DIR"
echo "🌍 World backups daily at 3 AM in: $BACKUP_DIR"
echo "🔐 Add your name to whitelist.json to join!"

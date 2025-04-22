#!/bin/bash

# === CONFIG ===
MC_VERSION="1.21.5"
FABRIC_INSTALLER_VERSION="0.11.2"
FABRIC_LOADER_VERSION="0.15.7"
INSTALL_DIR="$HOME/fabric-smp-server"
MOD_DIR="$INSTALL_DIR/mods"
BACKUP_DIR="$INSTALL_DIR/backups"

# === DEPENDENCY CHECK ===
echo "🔍 Checking for required dependencies..."
for cmd in java curl screen unzip; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ Error: $cmd is not installed. Please install it and re-run the script."
    exit 1
  fi
done

# Update system packages and install dependencies
sudo apt update && sudo apt install -y openjdk-24-jre-headless screen curl unzip || {
  echo "❌ Error: Failed to install dependencies. Check your internet connection and try again."
  exit 1
}

# === CREATE SERVER FOLDER ===
echo "📂 Creating server folder structure..."
mkdir -p "$MOD_DIR"
mkdir -p "$BACKUP_DIR"
cd "$INSTALL_DIR" || {
  echo "❌ Error: Failed to enter $INSTALL_DIR. Check permissions."
  exit 1
}

# === INSTALL FABRIC SERVER ===
echo "⬇️ Downloading and installing Fabric server..."
curl -O "https://maven.fabricmc.net/net/fabricmc/fabric-installer/$FABRIC_INSTALLER_VERSION/fabric-installer-$FABRIC_INSTALLER_VERSION.jar" || {
  echo "❌ Error: Failed to download Fabric installer. Check your internet connection."
  exit 1
}

java -jar fabric-installer-$FABRIC_INSTALLER_VERSION.jar server -mcversion $MC_VERSION -loader $FABRIC_LOADER_VERSION -downloadMinecraft || {
  echo "❌ Error: Failed to install Fabric server. Ensure Java is installed and try again."
  exit 1
}
rm "fabric-installer-$FABRIC_INSTALLER_VERSION.jar"

# === ACCEPT EULA ===
echo "✅ Accepting Minecraft EULA..."
echo "eula=true" > eula.txt

# === DOWNLOAD MODS ===
echo "⬇️ Downloading mods..."
SMPMODS=(
  # Default SMP Mods
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
)

# Example alternate mod list
EXAMPLEMODS=(
  "https://cdn.modrinth.com/data/EXAMPLE/versions/1.0.0/example-mod-1.0.0.jar"
  "https://cdn.modrinth.com/data/EXAMPLE/versions/1.2.3/another-example-mod-1.2.3.jar"
)

# Use SMPMODS by default; change to EXAMPLEMODS to switch
MODLIST=SMPMODS

for mod_url in "${!MODLIST}"; do
  curl -L -o "$MOD_DIR/$(basename "$mod_url")" "$mod_url" || {
    echo "⚠️ Warning: Failed to download mod from $mod_url. Skipping..."
  }
done

# === CREATE START SCRIPT (with auto-restart) ===
echo "⚙️ Creating start script..."
cat <<EOF > start-server.sh
#!/bin/bash
cd "$INSTALL_DIR"
while true; do
#  echo "🟢 Starting Minecraft server..."
  screen -S smpserver -dm java -Xms2G -Xmx4G -jar fabric-server-launch.jar nogui
#  wait \$!
#  echo "🔁 Server crashed. Restarting in 10s..."
#  sleep 10
done
EOF
chmod +x start-server.sh

# === CREATE DAILY BACKUP SCRIPT ===
echo "⚙️ Creating backup script..."
cat <<EOF > backup.sh
#!/bin/bash
cd "$INSTALL_DIR"
tar -czf "$BACKUP_DIR/world-\$(date +%F).tar.gz" world || {
  echo "⚠️ Warning: Failed to create backup. Check permissions."
  exit 1
}
find "$BACKUP_DIR" -type f -mtime +7 -delete || {
  echo "⚠️ Warning: Failed to clean old backups. Check permissions."
}
EOF
chmod +x backup.sh

# === ADD TO CRONTAB ===
echo "📅 Adding scripts to crontab..."
(crontab -l 2>/dev/null; echo "@reboot $INSTALL_DIR/start-server.sh") | crontab -
(crontab -l 2>/dev/null; echo "0 3 * * * $INSTALL_DIR/backup.sh") | crontab -

# === WHITELIST SETUP ===
echo "⚙️ Setting up whitelist..."
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
echo "🚀 Starting the server..."
./start-server.sh || {
  echo "❌ Error: Failed to start the server. Check the logs for more details."
  exit 1
}

echo "✅ Fabric SMP 1.21.5 server is up with Origins, REI, Better Combat, and performance mods."
echo "📂 Mods directory: $MOD_DIR"
echo "🌍 World backups daily at 3 AM in: $BACKUP_DIR"
echo "🔐 Add your name to whitelist.json to join!"

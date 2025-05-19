#!/bin/bash

# === CONFIGURATION ===
INSTALL_DIR="$HOME/minecraft-server"
BACKUP_DIR="$INSTALL_DIR/backups"
MODS_SCRIPT="./update-mods.sh" # Relative to the current directory (scripts)
SERVER_JAR=""
CRONTAB_USER=$(whoami)

# === CHECK FOR DEPENDENCIES ===
echo "🔍 Checking for required dependencies..."
for cmd in java curl jq; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "❌ Error: $cmd is not installed. Please install it and re-run the script."
    exit 1
  fi
done

# Install missing system dependencies
echo "⬇️ Updating system packages and ensuring dependencies..."
sudo apt update && sudo apt install -y openjdk-21-jre-headless curl jq || {
  echo "❌ Error: Failed to install dependencies. Check your internet connection and try again."
  exit 1
}

# === PROMPT FOR SERVER CONFIGURATION ===
echo "🌐 Select the Minecraft version and server type:"
read -rp "Enter Minecraft version (e.g., 1.21.5): " MC_VERSION
echo "Available server types: fabric, paper, forge, vanilla"
read -rp "Enter server type: " SERVER_TYPE

# Validate user input
if [[ -z "$MC_VERSION" || -z "$SERVER_TYPE" ]]; then
  echo "❌ Error: Minecraft version or server type cannot be empty."
  exit 1
fi

# === FETCH SERVER JAR ===
SERVER_JAR_URL="https://mcutils.com/api/server-jars/$SERVER_TYPE/$MC_VERSION/download"
echo "🌐 Fetching server JAR URL: $SERVER_JAR_URL"

HTTP_STATUS=$(curl -L -o /dev/null -s -w "%{http_code}" "$SERVER_JAR_URL")
if [ "$HTTP_STATUS" != "200" ]; then
  echo "❌ Error: Failed to fetch server JAR URL. HTTP status: $HTTP_STATUS"
  exit 1
fi

# === SETUP DIRECTORY STRUCTURE ===
echo "📂 Creating server folder structure at $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR" "$BACKUP_DIR"
cd "$INSTALL_DIR" || {
  echo "❌ Error: Failed to enter $INSTALL_DIR. Check permissions."
  exit 1
}

# === DOWNLOAD SERVER JAR ===
SERVER_JAR="server-$MC_VERSION-$SERVER_TYPE.jar"
echo "⬇️ Downloading server JAR as $SERVER_JAR..."
curl -L -o "$SERVER_JAR" "$SERVER_JAR_URL" || {
  echo "❌ Error: Failed to download server JAR. Check your internet connection."
  exit 1
}

# === ACCEPT EULA ===
echo "✅ Accepting Minecraft EULA..."
echo "eula=true" > eula.txt

# === INSTALL MODS ===
if [ -f "$MODS_SCRIPT" ]; then
  echo "⬇️ Running Mod Installer..."
  chmod +x "$MODS_SCRIPT"
  "$MODS_SCRIPT"
else
  echo "⚠️ Warning: Mod Installer script not found at $MODS_SCRIPT. Skipping mod installation."
fi

# === CREATE START SCRIPT ===
START_SCRIPT="$INSTALL_DIR/start-server.sh"
echo "⚙️ Creating start script at $START_SCRIPT..."
cat <<EOF > "$START_SCRIPT"
#!/bin/bash
cd "$INSTALL_DIR"
echo "⬇️ Updating mods before starting the server..."
bash "$MODS_SCRIPT"
echo "🟢 Starting Minecraft server..."
java -Xms2G -Xmx4G -jar "$SERVER_JAR" nogui
EOF
chmod +x "$START_SCRIPT"

# === CREATE BACKUP SCRIPT ===
BACKUP_SCRIPT="$INSTALL_DIR/backup.sh"
echo "⚙️ Creating backup script at $BACKUP_SCRIPT..."
cat <<EOF > "$BACKUP_SCRIPT"
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
chmod +x "$BACKUP_SCRIPT"

# === ADD TO CRONTAB ===
echo "📅 Adding start and backup scripts to crontab..."
(crontab -l 2>/dev/null; echo "@reboot $START_SCRIPT") | crontab -
(crontab -l 2>/dev/null; echo "0 3 * * * $BACKUP_SCRIPT") | crontab -

# === START THE SERVER ===
echo "🚀 Starting the server..."
"$START_SCRIPT" || {
  echo "❌ Error: Failed to start the server. Check the logs for more details."
  exit 1
}

echo "✅ Minecraft server $MC_VERSION ($SERVER_TYPE) is up and running."
echo "🌍 World backups will be created daily at 3 AM in: $BACKUP_DIR"

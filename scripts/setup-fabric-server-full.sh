#!/bin/bash

# === CONFIG ===
INSTALL_DIR="$HOME/minecraft-server"
BACKUP_DIR="$INSTALL_DIR/backups"

# === DEPENDENCY CHECK ===
echo "🔍 Checking for required dependencies..."
for cmd in java curl jq; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ Error: $cmd is not installed. Please install it and re-run the script."
    exit 1
  fi
done

# Update system packages and install dependencies
sudo apt update && sudo apt install -y openjdk-21-jre-headless curl jq || {
  echo "❌ Error: Failed to install dependencies. Check your internet connection and try again."
  exit 1
}

# === USER INPUT FOR SERVER JAR ===
echo "🌐 Select the Minecraft version and server type:"
read -rp "Enter Minecraft version (e.g., 1.21.5): " MC_VERSION
echo "Available server types: fabric, paper, forge, vanilla"
read -rp "Enter server type: " SERVER_TYPE

# === FETCH SERVER JAR URL ===
echo "🌐 Fetching server JAR URL from mcutils.com..."
API_URL="https://mcutils.com/api/v1/jars?version=$MC_VERSION&type=$SERVER_TYPE"
RAW_RESPONSE=$(curl -s "$API_URL")

echo "Raw API Response: $RAW_RESPONSE"

SERVER_JAR_URL=$(echo "$RAW_RESPONSE" | jq -r '.url')

if [ "$SERVER_JAR_URL" == "null" ] || [ -z "$SERVER_JAR_URL" ]; then
  echo "❌ Error: Could not find a server JAR for version $MC_VERSION and type $SERVER_TYPE. Please check your inputs and try again."
  exit 1
fi

# === CREATE SERVER FOLDER ===
echo "📂 Creating server folder structure at $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$BACKUP_DIR"
cd "$INSTALL_DIR" || {
  echo "❌ Error: Failed to enter $INSTALL_DIR. Check permissions."
  exit 1
}

# === DOWNLOAD SERVER JAR ===
echo "⬇️ Downloading server JAR..."
SERVER_JAR="server-$MC_VERSION-$SERVER_TYPE.jar"
curl -L -o "$SERVER_JAR" "$SERVER_JAR_URL" || {
  echo "❌ Error: Failed to download server JAR. Check your internet connection."
  exit 1
}

# === ACCEPT EULA ===
echo "✅ Accepting Minecraft EULA..."
echo "eula=true" > eula.txt

# === CREATE START SCRIPT (with auto-restart) ===
echo "⚙️ Creating start script..."
cat <<EOF > start-server.sh
#!/bin/bash
cd "$INSTALL_DIR"
while true; do
  echo "🟢 Starting Minecraft server..."
  java -Xms2G -Xmx4G -jar "$SERVER_JAR" nogui
  wait \$!
  echo "🔁 Server crashed. Restarting in 10s..."
  sleep 10
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

# === START THE SERVER ===
echo "🚀 Starting the server..."
./start-server.sh || {
  echo "❌ Error: Failed to start the server. Check the logs for more details."
  exit 1
}

echo "✅ Minecraft server $MC_VERSION ($SERVER_TYPE) is up and running."
echo "🌍 World backups daily at 3 AM in: $BACKUP_DIR"

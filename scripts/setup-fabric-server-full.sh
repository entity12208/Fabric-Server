#!/bin/bash

# === CONFIG ===
INSTALL_DIR="$HOME/minecraft-server"
BACKUP_DIR="$INSTALL_DIR/backups"

# === DEPENDENCY CHECK ===
echo "🔍 Checking for required dependencies..."
for cmd in java curl jq; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ Error: $cmd is not installed. Ensure dependencies are pre-installed in the workflow environment."
    exit 1
  fi
done

# === INPUT FROM ENVIRONMENT VARIABLES ===
MC_VERSION=${MC_VERSION:-"1.21.5"} # Default to 1.21.5 if not set
SERVER_TYPE=${SERVER_TYPE:-"fabric"} # Default to fabric if not set

echo "🌐 Minecraft Version: $MC_VERSION"
echo "🛠️  Server Type: $SERVER_TYPE"

# === FETCH SERVER JAR URL ===
echo "🌐 Fetching server JAR URL from mcutils.com..."
API_URL="https://mcutils.com/api/v1/jars?version=$MC_VERSION&type=$SERVER_TYPE"
RAW_RESPONSE=$(curl -s "$API_URL")

# Log the raw API response for debugging
echo "Raw API Response: $RAW_RESPONSE"

# Parse the response using jq
SERVER_JAR_URL=$(echo "$RAW_RESPONSE" | jq -r '.url' 2>/dev/null)

if [[ "$SERVER_JAR_URL" == "null" || -z "$SERVER_JAR_URL" ]]; then
  echo "❌ Error: Could not find a server JAR for version $MC_VERSION and type $SERVER_TYPE. Please check your inputs and try again."
  echo "Debug Info: The response from the server API was: $RAW_RESPONSE"
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

# === START SERVER ===
echo "⚙️ Starting Minecraft server..."
java -Xms2G -Xmx4G -jar "$SERVER_JAR" nogui &
SERVER_PID=$!

echo "⏳ Waiting for the server to start..."
sleep 30

if ps -p $SERVER_PID > /dev/null; then
  echo "✅ Server for version $MC_VERSION and type $SERVER_TYPE started successfully."
  kill $SERVER_PID
  wait $SERVER_PID || true
else
  echo "❌ Error: Server for version $MC_VERSION and type $SERVER_TYPE failed to start."
  exit 1
fi

# === CLEANUP ===
echo "🧹 Cleaning up server files..."
rm -rf "$INSTALL_DIR"

echo "✅ Successfully tested server for version $MC_VERSION and type $SERVER_TYPE."

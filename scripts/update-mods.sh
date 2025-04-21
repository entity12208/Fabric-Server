#!/bin/bash

# === CONFIG ===
MOD_DIR="$HOME/fabric-smp-server/mods" # Directory where mods are stored

# === MOD LIST ===
# Add your mod URLs below. You can switch between different mod lists as needed.
SMPMODS=(
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
)

# === FUNCTION TO UPDATE MODS ===
update_mods() {
  echo "⬇️ Updating mods in $MOD_DIR..."
  
  # Create the mods directory if it doesn't exist
  mkdir -p "$MOD_DIR"

  # Loop through each mod URL and download the latest version
  for mod_url in "${SMPMODS[@]}"; do
    mod_file="$MOD_DIR/$(basename "$mod_url")"
    echo "🔄 Updating $(basename "$mod_url")..."
    
    # Download the mod file, overwrite if it exists
    curl -L -o "$mod_file" "$mod_url" || {
      echo "⚠️ Failed to download $mod_url. Skipping..."
    }
  done

  echo "✅ All mods updated successfully."
}

# === EXECUTE THE UPDATE ===
update_mods

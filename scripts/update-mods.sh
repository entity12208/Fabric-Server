#!/bin/bash

# === CONFIG ===
MOD_DIR="$HOME/fabric-smp-server/mods" # Directory where mods are stored

# === PREMADE MOD LISTS ===

# Survival Multiplayer (SMP) Mods
SMPMODS=(
  "https://cdn.modrinth.com/data/AANobbMI/versions/1.10.0/origins-1.10.0.jar"
  "https://cdn.modrinth.com/data/4P9FNjpb/versions/4.1.0/extra-origins-4.1.0.jar"
  "https://cdn.modrinth.com/data/zL7V1slW/versions/13.0.708/roughly-enough-items-13.0.708.jar"
  "https://cdn.modrinth.com/data/3gvlM4W2/versions/2.5.1/better-combat-fabric-1.21.5-2.5.1.jar"
)

# PvP Mods
PVPMODS=(
  "https://cdn.modrinth.com/data/jarfile1.jar" # Example PvP mod
  "https://cdn.modrinth.com/data/jarfile2.jar" # Example PvP mod
)

# Vanilla (No Mods)
VANILLAMODS=(
  # Empty array for a pure vanilla experience
)

# Enhanced Vanilla (Light Mods)
ENHANCEDVANILLAMODS=(
  "https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar"
  "https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar"
)

# Optimized SMP (Performance Mods)
OPTIMIZEDSMPMODS=(
  "https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar"
  "https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar"
  "https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar"
)

# Optimized PvP (Performance Mods + PvP Enhancements)
OPTIMIZEDPVPMODS=(
  "https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar"
  "https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar"
  "https://cdn.modrinth.com/data/jarfile1.jar" # Example PvP mod
)

# Creative Mods (Mods like "Create")
CREATIVEMODS=(
  "https://cdn.modrinth.com/data/jarfile3.jar" # Example Creative mod
  "https://cdn.modrinth.com/data/jarfile4.jar" # Example Creative mod
)

# Optimized Creative (Performance Mods + Creative Enhancements)
OPTIMIZEDCREATIVEMODS=(
  "https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar"
  "https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar"
  "https://cdn.modrinth.com/data/jarfile3.jar" # Example Creative mod
)

# === FUNCTION TO UPDATE MODS ===
update_mods() {
  local mod_list=("${!1}") # Dynamically access the mod list passed as an argument

  echo "⬇️ Updating mods in $MOD_DIR..."
  
  # Create the mods directory if it doesn't exist
  mkdir -p "$MOD_DIR"

  # Loop through each mod URL and download the latest version
  for mod_url in "${mod_list[@]}"; do
    mod_file="$MOD_DIR/$(basename "$mod_url")"
    echo "🔄 Updating $(basename "$mod_url")..."
    
    # Download the mod file, overwrite if it exists
    curl -L -o "$mod_file" "$mod_url" || {
      echo "⚠️ Failed to download $mod_url. Skipping..."
    }
  done

  echo "✅ All mods updated successfully."
}

# === MAIN MENU ===
echo "Choose a mod list to install:"
echo "1. SMP Mods"
echo "2. PvP Mods"
echo "3. Vanilla (No Mods)"
echo "4. Enhanced Vanilla (Light Mods)"
echo "5. Optimized SMP"
echo "6. Optimized PvP"
echo "7. Creative Mods"
echo "8. Optimized Creative"
read -rp "Enter the number (1-8): " choice

case $choice in
  1) update_mods SMPMODS[@] ;;
  2) update_mods PVPMODS[@] ;;
  3) update_mods VANILLAMODS[@] ;;
  4) update_mods ENHANCEDVANILLAMODS[@] ;;
  5) update_mods OPTIMIZEDSMPMODS[@] ;;
  6) update_mods OPTIMIZEDPVPMODS[@] ;;
  7) update_mods CREATIVEMODS[@] ;;
  8) update_mods OPTIMIZEDCREATIVEMODS[@] ;;
  *) echo "❌ Invalid choice. Exiting..." ;;
esac

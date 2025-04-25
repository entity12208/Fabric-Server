#!/bin/bash

# === CONFIG ===
MOD_DIR="$HOME/fabric-smp-server/mods" # Directory where mods are stored

# === MOD LIST DEFINITIONS ===
declare -A MOD_LISTS=(
  [SMPMODS]="https://cdn.modrinth.com/data/AANobbMI/versions/1.10.0/origins-1.10.0.jar
             https://cdn.modrinth.com/data/4P9FNjpb/versions/4.1.0/extra-origins-4.1.0.jar
             https://cdn.modrinth.com/data/zL7V1slW/versions/13.0.708/roughly-enough-items-13.0.708.jar
             https://cdn.modrinth.com/data/3gvlM4W2/versions/2.5.1/better-combat-fabric-1.21.5-2.5.1.jar"
  [PVPMODS]="https://cdn.modrinth.com/data/jarfile1.jar
             https://cdn.modrinth.com/data/jarfile2.jar"
  [VANILLAMODS]="" # Empty for a pure vanilla experience
  [ENHANCEDVANILLAMODS]="https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar
                         https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar"
  [OPTIMIZEDSMPMODS]="https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar
                      https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar
                      https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar"
  [OPTIMIZEDPVPMODS]="https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar
                      https://cdn.modrinth.com/data/f7cKXWnU/versions/1.5.2/starlight-1.5.2-fabric.jar
                      https://cdn.modrinth.com/data/jarfile1.jar"
  [CREATIVEMODS]="https://cdn.modrinth.com/data/jarfile3.jar
                  https://cdn.modrinth.com/data/jarfile4.jar"
  [OPTIMIZEDCREATIVEMODS]="https://cdn.modrinth.com/data/X8VZfWKA/versions/3.1.1/ferritecore-3.1.1-fabric.jar
                          https://cdn.modrinth.com/data/LQm6jbCE/versions/1.21.5-0.4.7/lithium-fabric-mc1.21.5-0.4.7.jar
                          https://cdn.modrinth.com/data/jarfile3.jar"
)

# === FUNCTION TO UPDATE MODS ===
update_mods() {
  local mods="$1"

  echo "⬇️ Updating mods in $MOD_DIR..."
  
  # Create the mods directory if it doesn't exist
  mkdir -p "$MOD_DIR"

  # Loop through each mod URL and download the latest version
  while IFS= read -r mod_url; do
    if [[ -n "$mod_url" ]]; then
      local mod_file="$MOD_DIR/$(basename "$mod_url")"
      echo "🔄 Updating $(basename "$mod_url")..."
      
      # Download the mod file, overwrite if it exists
      curl -L -o "$mod_file" "$mod_url" || {
        echo "⚠️ Failed to download $mod_url. Skipping..."
      }
    fi
  done <<< "$mods"

  echo "✅ All mods updated successfully."
}

# === MENU SYSTEM ===
echo "Available mod lists:"
for mod_list in "${!MOD_LISTS[@]}"; do
  echo "- $mod_list"
done

read -rp "Type the name of the mod list you want to install: " chosen_mod_list

# Validate user's choice and execute the update
if [[ -n "${MOD_LISTS[$chosen_mod_list]}" ]]; then
  update_mods "${MOD_LISTS[$chosen_mod_list]}"
else
  echo "❌ Invalid mod list name. Please choose from the available options."
  exit 1
fi
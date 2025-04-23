# Customizable Minecraft Server
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Minecraft Version](https://img.shields.io/badge/Minecraft-1.21.5-blue)](https://www.minecraft.net)
[![Stars](https://img.shields.io/github/stars/entity12208/Fabric-Server)](https://github.com/entity12208/Fabric-Server/stargazers)

A Linux-based Minecraft server setup script. Supports modded gameplay with performance and quality-of-life enhancements.

## Features
- **Mod Support**: Pre-configured with SMP mods like Origins, REI, and Better Combat.
- **Performance Optimized**: Includes mods like Lithium, Starlight, and FerriteCore for smooth gameplay.
- **Automated Backups**: Daily backup system to ensure your world is safe.
- **Whitelist Management**: Easily manage server access with a whitelist.
- **Cross-Platform Ready**: Add GeyserMC for Bedrock support.

## Prerequisites
Before setting up the server, ensure you have the following installed on your Linux system:
- **Java 21**: OpenJDK 21 or equivalent.
- **screen**: For running the server in the background.
- **curl** and **unzip**: For fetching and extracting files.

Install dependencies with:
```bash
sudo apt update && sudo apt install -y openjdk-21-jre-headless screen curl unzip
```

## Setup
1. Clone this repository:
   ```bash
   git clone https://github.com/entity12208/Fabric-Server.git
   cd Fabric-Server
   ```
2. Make the setup script executable and run it:
   ```bash
   chmod +x setup-fabric-server-full.sh
   ./setup-fabric-server-full.sh
   ```
   This will create the necessary server files and folders.

3. **Important**: The setup script is **one-time use**. Re-running it may overwrite your existing server files.

## Starting the Server
Run the server with:
```bash
./start-server.sh
```
This will open the server console in your terminal.

## Updating Mods
To update all mods, use the `update-mods.sh` script:
```bash
chmod +x update-mods.sh
./update-mods.sh
```

## Backups
Daily backups are created automatically at **3 AM**. You can also manually back up the server by running:
```bash
./backup.sh
```

## Whitelist
To join the server, add your Minecraft username and UUID to `whitelist.json`. Find your UUID at [MinecraftUUID.com](https://minecraftuuid.com).

If you want a public server, disable the whitelist in `server.properties`:
```properties
white-list=false
```

## Adding Mods
1. By default, the server installs a set of SMP mods. To change this:
   - Edit the `SMPMODS` array in `setup-fabric-server-full.sh` or `update-mods.sh`.
   - Replace it with a list of mod URLs.

2. Alternatively, add `.jar` mod files directly to the `mods` folder.

## Troubleshooting
- **Server Crashes**: The server auto-restarts. Check the logs in `logs/latest.log` for details.
- **Port Forwarding**: Ensure port `25565` is open on your router for others to connect.
- **Whitelist Issues**: Verify usernames and UUIDs are correct in `whitelist.json`.

## Notes
- Works with **Java Edition** only. For Bedrock support, add [GeyserMC](https://geysermc.org).
- Recommended for 24/7 uptime: Use a Raspberry Pi (Pi 5 suggested).
- Keep your mods and server files updated for the best experience.

## Contributing
Contributions are welcome! Please follow the [CONTRIBUTING.md](CONTRIBUTING.md) guidelines to get started.

## License
This project is licensed under the [MIT License](LICENSE).

# Customizable Minecraft Server
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Minecraft Version](https://img.shields.io/badge/Minecraft-1.21.5-blue)](https://www.minecraft.net)
[![Stars](https://img.shields.io/github/stars/entity12208/Fabric-Server)](https://github.com/entity12208/Fabric-Server/stargazers)

A Linux-based Minecraft server setup script, designed for modded gameplay with performance and quality-of-life enhancements. Perfect for those who want a fully customizable Minecraft server experience.

---

## ⚡ Features
- **Mod Support**: Pre-configured with popular SMP mods like Origins, REI, and Better Combat.
- **Performance Optimized**: Includes Lithium, Starlight, and FerriteCore for smooth gameplay.
- **Automated Backups**: Daily backups to ensure your world is safe.
- **Whitelist Management**: Easily control server access with a whitelist.
- **Cross-Platform Ready**: Add GeyserMC for Bedrock support.
- **One-Time Setup**: Simplified installation process with minimal manual configurations.

---

## 📋 Prerequisites
Before setting up the server, ensure your Linux system has the following:
- **Java 21**: OpenJDK 21 or equivalent.
- **screen**: To run the server in the background.
- **curl** and **unzip**: For downloading and extracting files.

### Install Dependencies
Run the following command to install all necessary dependencies:
```bash
sudo apt update && sudo apt install -y openjdk-21-jre-headless screen curl unzip
```

---

## 🚀 Setup Instructions
1. **Clone this repository:**
   ```bash
   git clone https://github.com/entity12208/Fabric-Server.git
   cd Fabric-Server
   ```

2. **Make the setup script executable and run it:**
   ```bash
   chmod +x setup-fabric-server-full.sh
   ./setup-fabric-server-full.sh
   ```
   This will download and configure the necessary server files and folders.

3. **Important:**
   - The setup script is **one-time use**. Re-running it may overwrite your existing server files.

---

## ▶️ Starting the Server
Run the server using:
```bash
./start-server.sh
```
This will launch the server console in your terminal.

---

## 🔄 Updating Mods
To update all installed mods, use the provided script:
```bash
chmod +x update-mods.sh
./update-mods.sh
```

---

## 🗄️ Backups
- Automated daily backups are created at **3 AM**.
- To manually create a backup, run:
  ```bash
  ./backup.sh
  ```

---

## 🔒 Whitelist Management
To control who can join the server:
1. Add player usernames and UUIDs to `whitelist.json`. You can find your UUID at [MinecraftUUID.com](https://minecraftuuid.com).
2. For a public server, disable the whitelist by editing `server.properties`:
   ```properties
   white-list=false
   ```

---

## 🛠️ Adding Mods
- To customize the mods:
  - Edit the `SMPMODS` array in `setup-fabric-server-full.sh` or `update-mods.sh` to include mod URLs.
- Alternatively, add `.jar` files directly to the `mods` folder.

---

## ❓ Troubleshooting
- **Server Crashes**: The server auto-restarts. Check `logs/latest.log` for details.
- **Port Forwarding**: Ensure port `25565` is open on your router.
- **Whitelist Issues**: Verify usernames and UUIDs in `whitelist.json`.

---

## 📄 Additional Notes
- **Java Edition Only**: This setup is exclusively for Java Edition. For Bedrock support, add [GeyserMC](https://geysermc.org).
- **24/7 Uptime**: Recommended hardware includes Raspberry Pi 5 or equivalent.
- **Regular Updates**: Keep mods and server files up-to-date for the best performance and experience.

---

## 🤝 Contributing
Contributions are welcome! Please review the [CONTRIBUTING.md](CONTRIBUTING.md) guidelines before submitting your pull requests.

---

## 📜 License
This project is licensed under the [MIT License](LICENSE).

---

## 💬 Support
For questions or issues, feel free to open an [issue](https://github.com/entity12208/Fabric-Server/issues) or contact the repository maintainer.

---

Enjoy your fully customizable Minecraft server!

# Windows Setup Instructions

> **Note:** Scripts are written for Linux but can be adapted for Windows. See below for details.

## 📋 Prerequisites

- **Java 21**: Download and install [OpenJDK 21](https://jdk.java.net/21/).
- **Git**: Download and install [Git for Windows](https://git-scm.com/download/win).
- **7-Zip** or similar tool for extracting files.
- **curl**, **jq**: Download Windows versions or use WSL for Bash scripts.

---

## 🚀 Setup Instructions

1. Clone the repository using Git Bash:
   ```bash
   git clone https://github.com/entity12208/Fabric-Server.git
   cd Fabric-Server
   ```

2. Run the setup script with [WSL](https://docs.microsoft.com/en-us/windows/wsl/) or adapt to `.bat`/PowerShell:
   ```bash
   chmod +x setup-server.sh
   ./setup-server.sh
   ```

   The script will prompt you to choose Fabric, Forge, or PaperMC.

3. If not using WSL, manually follow the logic in `setup-server.sh` to set up the server and mods/plugins.

---

## ▶️ Starting the Server

Use the provided script under WSL, or in CMD:
```cmd
java -Xmx4G -jar [server-jar-name].jar nogui
```
Replace `[server-jar-name]` with the correct jar for Fabric, Forge, or PaperMC.

---

## 🔄 Updating Mods/Plugins

- **Fabric/Forge:** Download latest mod `.jar` files and replace them in the `mods` folder, or use `update-mods.sh` in WSL.
- **PaperMC:** Download latest plugin `.jar` files and replace them in the `plugins` folder, or use `update-mods.sh` in WSL.

---

## 🗄️ Backups & Whitelist

- **Backups:** Manually copy the `world` folder or write a batch script.
- **Whitelist:** Edit `whitelist.json` as described in the Linux guide.

---

For best compatibility, consider running your server on Linux or WSL.

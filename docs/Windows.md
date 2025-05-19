# Windows Setup Instructions

> **Note:** This project is primarily designed for Linux. However, you can adapt it for Windows with the following steps.

## 📋 Prerequisites

- **Java 21**: Download and install [OpenJDK 21](https://jdk.java.net/21/).
- **Git**: Download and install [Git for Windows](https://git-scm.com/download/win).
- **7-Zip** or similar tool for extracting files.

---

## 🚀 Setup Instructions

1. **Clone the repository using Git Bash:**
   ```bash
   git clone https://github.com/entity12208/Fabric-Server.git
   cd Fabric-Server
   ```

2. **Download and install dependencies manually:**
   - Ensure Java is added to your PATH.
   - Download `curl` and `unzip` for Windows, or manually download mods and server jars referenced in `setup-fabric-server-full.sh`.

3. **Setup scripts:**
   - The setup and management scripts (`setup-fabric-server-full.sh`, `start-server.sh`, `update-mods.sh`, `backup.sh`) are written for Linux (Bash). To use them on Windows:
     - Use [WSL](https://docs.microsoft.com/en-us/windows/wsl/) (Windows Subsystem for Linux), or
     - Adapt the logic into `.bat` or `.ps1` scripts for native Windows support.

4. **Manual Setup (if not using WSL):**
   - Download and extract the required server files (Fabric loader, mods, etc.).
   - Configure `server.properties`, `eula.txt`, and other configuration files as described in the Linux instructions.

5. **Start the Server:**
   - Use:
     ```cmd
     java -Xmx4G -jar fabric-server-launch.jar nogui
     ```
   - Or run the equivalent Windows batch script if you created one.

---

## 🗄️ Backups, Mod Updates, and Whitelist

- **Backups:** Use manual copying or write a `.bat` script to back up the `world` folder.
- **Updating Mods:** Download latest mod `.jar` files and replace them in the `mods` folder.
- **Whitelist:** Edit `whitelist.json` as described in the Linux guide.

---

## ❓ Troubleshooting

- **Server Crashes:** Check the `logs/latest.log` file for errors.
- **Port Forwarding:** Make sure port `25565` is open in your Windows firewall and router.
- **Java Issues:** Verify Java is properly installed and added to PATH.

---

For a smoother experience, consider running your server on Linux or WSL.

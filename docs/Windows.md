# Windows Setup Instructions

> **Note:** Scripts are provided for Windows (`.bat`) and Linux (`.sh`). You do **not** need WSL for the Windows scripts.

---

## 📋 Prerequisites

- **Java 21**: Download and install [OpenJDK 21](https://jdk.java.net/21/). Ensure `java` is in your PATH.
- **curl**: Download [curl for Windows](https://curl.se/windows/) and ensure it is in your PATH.
- **PowerShell**: Needed for automatic PaperMC version/build detection (default on modern Windows).
- **Git (optional)**: Download [Git for Windows](https://git-scm.com/download/win) if you want to clone this repository.

---

## 🚀 Setup Instructions

1. **Download or Clone the Repository:**
   - Download from GitHub as a ZIP and extract, or use Git Bash:
     ```bash
     git clone https://github.com/entity12208/Fabric-Server.git
     cd Fabric-Server
     ```

2. **Run the Setup Script:**
   - Double-click or execute in Command Prompt:
     ```cmd
     setup-server.bat
     ```
   - Follow the on-screen prompt to select **Fabric**, **Forge**, or **PaperMC**.
   - The script will download the chosen server, mods, or plugins (edit URLs in the script as needed).

---

## ▶️ Starting the Server

- Double-click or run in Command Prompt:
  ```cmd
  start-server.bat
  ```
- The script auto-detects the server type and starts the correct `.jar`.

---

## 🔄 Updating Mods or Plugins

- Double-click or run in Command Prompt:
  ```cmd
  update-mods.bat
  ```
- The script will download updated mods/plugins based on URLs you set in the script.

---

## 🗄️ Backups & Whitelist

- **Backups:** Manually copy the `world` folder or create a backup batch script.
- **Whitelist:** Edit `whitelist.json` with player usernames/UUIDs as described in the Linux guide.

---

## 📝 Customizing Mods/Plugins

- **Fabric/Forge:** Edit the `MODS` variable in `setup-server.bat` and `update-mods.bat` to include your desired mod URLs.
- **PaperMC:** Edit the `PLUGINS` variable in `update-mods.bat` for plugin URLs, or manually place `.jar` files in the `plugins` folder.

---

## ❓ Troubleshooting

- **Server Crashes:** Check the `logs/latest.log` file for errors.
- **Port Forwarding:** Make sure port `25565` is open in both your Windows firewall and router.
- **Java Issues:** Ensure Java is installed and the `java` command works from your Command Prompt.
- **curl Not Found:** Make sure `curl.exe` is in your PATH. You can test by running `curl --version` in Command Prompt.

---

## 💡 Pro Tips

- These scripts are compatible with Windows 10/11.
- For advanced automation, you can expand or chain these batch files.
- For best compatibility and performance, run your server from a dedicated folder (not from Desktop/Downloads).

---

Enjoy your Minecraft server on Windows!

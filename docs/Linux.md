# Linux Setup Instructions

## 📋 Prerequisites

- **Java 21**: OpenJDK 21 or equivalent.
- **screen**: To run the server in the background.
- **curl** and **unzip**: For downloading and extracting files.
- **jq**: For JSON parsing (PaperMC setup).

Install dependencies:
```bash
sudo apt update && sudo apt install -y openjdk-21-jre-headless screen curl unzip jq
```

---

## 🚀 Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/entity12208/Fabric-Server.git
   cd Fabric-Server
   ```

2. Run the setup script and follow the prompts:
   ```bash
   chmod +x setup-server.sh
   ./setup-server.sh
   ```

   The script will guide you to select Fabric, Forge, or PaperMC, and set up everything automatically.

---

## ▶️ Starting the Server

Run:
```bash
./start-server.sh
```
This will auto-detect your server type and start the correct jar.

---

## 🔄 Updating Mods/Plugins

To update mods or plugins:
```bash
./update-mods.sh
```
Edits may be needed in the script to add custom mods/plugins.

---

## 🗄️ Backups

- Automated daily backups are created at 3 AM (see `backup.sh`).
- To manually create a backup:
  ```bash
  ./backup.sh
  ```

---

## 🔒 Whitelist Management

1. Add player usernames and UUIDs to `whitelist.json`. Find UUIDs at [MinecraftUUID.com](https://minecraftuuid.com).
2. For a public server, set `white-list=false` in `server.properties`.

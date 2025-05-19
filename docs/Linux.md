# Linux Setup Instructions

## 📋 Prerequisites

Ensure your Linux system has the following installed:
- **Java 21**: OpenJDK 21 or equivalent.
- **screen**: To run the server in the background.
- **curl** and **unzip**: For downloading and extracting files.

### Install Dependencies

Run the following command:
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
   The setup script is **one-time use**. Re-running it may overwrite your existing server files.

---

## ▶️ Starting the Server

Run the server with:
```bash
./start-server.sh
```
This will launch the server console in your terminal.

---

## 🔄 Updating Mods

To update all installed mods:
```bash
chmod +x update-mods.sh
./update-mods.sh
```

---

## 🗄️ Backups

- Automated daily backups are created at 3 AM.
- To manually create a backup:
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

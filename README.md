# Fabric SMP
An SMP fabric server for linux.

## Setup
To set up the server, run:
```
chmod +x setup-fabric-smp-full.sh
./setup-fabric-smp-full.sh
```
This will create a folder for the server with **some** of the files needed. To make the rest, start the server.
## Starting the server
To start the server, run:
```
./start-server.sh
```
This will make the terminal into the server **console**.
## Backing up the server
To back up the server and all its files, run:
```
./backup.sh
```
This will be run automatically every day at **3 AM**(if the device is on).
## Whitelist
To join the server, you must first add your username and UUID to the Whitelist file, `whitelist.json` (find your UUID at `minecraftuuid.com`). If you would like your server to be public, remove this file entirely.
## Things to remember
* This server works on Java edition *only*. For bedrock support, add geyser (`geysermc.org`).
* For the best 24/7 support, run this on a **Raspberry Pie** (Pi 5 recommended), a type of mini-computer.
* Make sure to forward port `25565` on your router.

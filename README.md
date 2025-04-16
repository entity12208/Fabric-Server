# Fabric Server
A fabric Minecraft server for Linux.

## Setup
To set up the server, first clone this repository using:
```
git clone https://github.com/entity12208/fabric-server/
cd fabric-server
```
Then, set up the server with:
```
chmod +x setup-fabric-server-full.sh
./setup-fabric-server-full.sh
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
## Adding mods
By default, SMP mods are installed. To change this, edit line 49 of `setup-fabric-server-full.sh` and change `SMPMODS` to another list of mod URLs you have created. You can also start the server and change the mods manually.
## Things to remember
* This server works on Java edition *only*. For bedrock support, add geyser (`geysermc.org`).
* For the best 24/7 support, run this on a **Raspberry Pie** (Pi 5 recommended), a type of mini-computer.
* Make sure to forward port `25565` on your router.

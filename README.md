# Fabric SMP
An SMP fabric server for linux.

## Setup
To set up the server, run:
```
chmod +x setup-fabric-smp-full.sh
./setup-fabric-smp-full.sh
```
## Starting the server
To start the server, run:
```
start-server.sh
```
## Backing up the server
To backup the server and all its files, run:
```
backup.sh
```
This will be run automatically every day at 3AM.
## Whitelist
To join the server, you must first add your username and UUID to the Whitelist file, `whitelist.json` (find your UUID at `minecraftuuid.com`). If you would like your server to be public, remove this file entirely.

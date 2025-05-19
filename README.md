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

## 📋 Setup Guides

- [Linux Setup Instructions](Linux.md)
- [Windows Setup Instructions](Windows.md)

---

## 🛠️ Adding Mods

- To customize the mods, edit the `SMPMODS` array in `setup-fabric-server-full.sh` or `update-mods.sh` to include additional mod URLs.
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

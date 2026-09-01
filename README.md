# Parch Linux Calamares Configuration & Branding

This repository contains the installer configuration, branding assets, and custom QML interface modules for the [Calamares](https://calamares.io) installer used by **Parch Linux**.


## Overview

The Parch Linux installer experience features a modern, responsive interface built with QML and KDE Kirigami components, providing a clean and intuitive system setup flow.

Key features include:
- **Responsive QML Installer Modules**: Redesigned views for Welcome, Language & Locale, Keyboard configuration, User Account creation, and Installation Summary.
- **Custom UI System**: Component layout templates, tokens, and navigation controls tailored for Parch Linux.
- **Branding Assets**: Parch Linux custom slideshow, logos, icons, and styling.
- **System Integration**: Module configuration files tuned for Arch/Parch Linux system installation, initcpio configuration, live media cleanup, and package management.

## Acknowledgments & Upstream Attribution

Portions of this configuration, particularly the modern QML modules, responsive UI design patterns, and layout components, are derived from and inspired by:

- **Nitrux Linux**: [calamares-settings-nitrux](https://github.com/Nitrux/calamares-settings-nitrux) (GPL Licensed). Special thanks to the Nitrux Linux team for their innovative work on QML-based Calamares installer views.
- **Calamares Installer**: The upstream [Calamares](https://calamares.io) project.
- **KaOS Linux**: [KaOS Calamares branding and modules](https://github.com/KaOSx/calamares-branding) by Anke Boersma (`demm@kaosx.us`).
- **Pierre-Yves Siret**: Fade behavior implementation (`FadeBehavior.qml`).

## License

This repository is free software and is distributed under the terms of the **GNU General Public License Version 3** (GPL-3.0-or-later).

See the [LICENSE](./LICENSE) file for the full license text.

Individual third-party components included or adapted herein retain their respective copyright notices and permissive/compatible licenses (e.g., MIT License for `FadeBehavior.qml`) as indicated in their source headers.

# Changelog

All notable changes to the Parch Linux Calamares installer configuration are documented in this file.

## [Unreleased] - 2026-05-18

### Added
- Added a new QML-driven installer flow with dedicated view modules:
  - `welcomeq`, `localeq`, `keyboardq`, `usersq`, `summaryq`
  - New module configs: `etc/calamares/modules/welcomeq.conf`, `localeq.conf`, `usersq.conf`
- Added reusable UI components and tokens for the redesigned interface:
  - `ResponsiveBase.qml`, `UiTokens.qml`, `ListViewTemplate.qml`, `ListItemDelegate.qml`, `ViewStepsBar.qml`, `ItemSection.qml`, `FadeBehavior.qml`, `Map.qml`
- Added redesigned page implementations:
  - `welcomeq.qml`, `localeq.qml`, `keyboardq.qml`, `usersq.qml`, `summaryq.qml`, `finishedq.qml`, `Offline.qml`
- Added a custom sidebar implementation with `calamares-sidebar.qml`.

### Changed
- Switched installer sequence in `settings.conf` from classic modules to the new QML-backed modules in both `show` and `exec` phases where applicable.
- Updated `welcome.conf` internet check endpoint from `http://example.com` to `https://parchlinux.com`.
- Refreshed slideshow behavior/content via `show.qml` and updated branding assets (including `idioma.png`).
- Updated launcher environment handling in `launch.sh` to improve input reliability:
  - Force `QT_QPA_PLATFORM=xcb` under Wayland when not explicitly set.
  - Set `QT_IM_MODULE=ibus` when unset and export matching `XMODIFIERS`.

### UX Improvements
- Introduced a more structured and responsive onboarding flow for language, locale/timezone, keyboard selection, account setup, and installation summary.
- Added clearer in-page validation and inline feedback in user/account forms.
- Standardized screen titles, subtitles, and contextual guidance across the redesigned installer pages.

### Notes
- `launch.sh` executable bit changed from `100755` to `100644` in the current tree.
- `Offline_orig.qml` is currently present alongside `Offline.qml`, likely as a backup/reference copy.

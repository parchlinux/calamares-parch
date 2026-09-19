#!/usr/bin/env bash
# calamares helper: write the LUKS kernel cmdline ONLY when the installed
# root actually lives on an encrypted (LUKS) device — i.e. only when the
# user enabled "Encrypt system" during partitioning. On a normal,
# unencrypted install this script finds no LUKS-mapped root and exits
# without touching anything, so plain installs never get cryptdevice=.
#
# Runs inside the target after grubcfg, before the final grub-mkconfig.
# Plain file — the calamares variable guard only inspects module configs,
# not this script.
set -euo pipefail

luks_dev=""
root_src=$(findmnt -n -o SOURCE /)
case "$root_src" in
  /dev/mapper/*)
    # Root is a device-mapper target; resolve back to its backing device.
    sub=$(lsblk -no PKNAME "$root_src" 2>/dev/null | head -1)
    [ -n "$sub" ] && luks_dev="/dev/$sub"
    ;;
esac

# Fall back: root may itself be a LUKS node under /dev/mapper.
if [ -z "$luks_dev" ] &&
   [ "$(blkid -s TYPE -o value "$root_src" 2>/dev/null)" = "crypto_LUKS" ]; then
  luks_dev="$root_src"
fi

# Only proceed when the backing device is really LUKS-encrypted.
if [ -z "$luks_dev" ] ||
   [ "$(blkid -s TYPE -o value "$luks_dev" 2>/dev/null)" != "crypto_LUKS" ]; then
  echo "crypt-root: root is not on an encrypted device — nothing to do" >&2
  exit 0
fi

luks_uuid=$(blkid -s UUID -o value "$luks_dev")
cryptdev="cryptdevice=UUID=$luks_uuid:root root=/dev/mapper/root"

if [ -f /etc/default/grub ]; then
  grep -v '^GRUB_CMDLINE_LINUX' /etc/default/grub > /etc/default/grub.tmp || true
  printf 'GRUB_CMDLINE_LINUX="%s"\n' "$cryptdev" >> /etc/default/grub.tmp
  mv -f /etc/default/grub.tmp /etc/default/grub
else
  printf 'GRUB_CMDLINE_LINUX="%s"\n' "$cryptdev" > /etc/default/grub
fi
echo "crypt-root: GRUB_CMDLINE_LINUX=\"$cryptdev\""
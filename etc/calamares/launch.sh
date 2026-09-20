#!/usr/bin/bash

DIR="/etc/calamares"
KERNEL=`uname -r`

# In Qt 6, native Wayland keyboard input is handled properly with QQuickWidget.
# Prefer Wayland if available, falling back to xcb if needed.
if [[ -n "${WAYLAND_DISPLAY}" && -z "${QT_QPA_PLATFORM}" ]]; then
	export QT_QPA_PLATFORM="wayland;xcb"
fi

if [[ -d "/run/archiso/copytoram" ]]; then
	sudo sed -i -e 's|/run/archiso/bootmnt/arch/x86_64/airootfs.sfs|/run/archiso/copytoram/airootfs.sfs|g' "$DIR"/modules/unpackfs.conf
	sudo sed -i -e "s|/run/archiso/bootmnt/arch/boot/x86_64/vmlinuz-linux|/usr/lib/modules/$KERNEL/vmlinuz|g" "$DIR"/modules/unpackfs.conf
	sudo sed -i -e "s|/run/archiso/bootmnt/arch/boot/x86_64/vmlinuz-linux|/usr/lib/modules/$KERNEL/vmlinuz|g" "$DIR"/modules/shellprocess_copy_kernel.conf
fi

exec sudo -E calamares "$@"

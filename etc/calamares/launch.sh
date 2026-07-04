#!/usr/bin/bash

DIR="/etc/calamares"
KERNEL=`uname -r`

# Qt input on native Wayland can fail for Calamares/root sessions on some stacks.
# Prefer XWayland backend for reliable keyboard input in installer text fields.
if [[ -n "${WAYLAND_DISPLAY}" && -z "${QT_QPA_PLATFORM}" ]]; then
	export QT_QPA_PLATFORM="xcb"
fi

# Keep input method selection explicit to avoid dead keyboard state.
if [[ -z "${QT_IM_MODULE}" ]]; then
	export QT_IM_MODULE="ibus"
fi
export XMODIFIERS="@im=${QT_IM_MODULE}"

if [[ -d "/run/archiso/copytoram" ]]; then
	sudo sed -i -e 's|/run/archiso/bootmnt/arch/x86_64/airootfs.sfs|/run/archiso/copytoram/airootfs.sfs|g' "$DIR"/modules/unpackfs.conf
	sudo sed -i -e "s|/run/archiso/bootmnt/arch/boot/x86_64/vmlinuz-linux|/usr/lib/modules/$KERNEL/vmlinuz|g" "$DIR"/modules/unpackfs.conf
fi

sudo -E calamares 

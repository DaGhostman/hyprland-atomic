#!/usr/bin/bash

set -eoux pipefail

source /etc/os-release

IMPORTANT_PACKAGES=(
    systemd
    pipewire
    wireplumber
    hyprland
    uwsm
    waybar-git
    ghostty
    btop
    neovim
)

for package in "${IMPORTANT_PACKAGES[@]}"; do
    rpm -q "$package" >/dev/null || { echo "Missing package: $package... Exiting"; exit 1 ; }
done


readarray -t INVALID_FILENAMES < <(find / -name '*[![:print:]]*' 2>/dev/null)
if [[ "${#INVALID_FILENAMES[@]}" -gt 0 ]]; then
    echo -e "Found invalid (non-UTF8 filenames, ostree doesn't like them\n"
    echo -e $INVALID_FILENAMES
    exit 127;
fi



#!/usr/bin/bash

set -eoux pipefail

source /etc/os-release

IMPORTANT_PACKAGES=(
    systemd
    pipewire
    wireplumber
    hyprland
    uwsm
    waybar
    ghostty
    btop
    neovim
)

for package in "${IMPORTANT_PACKAGES[@]}"; do
    rpm -q "$package" >/dev/null || { echo "Missing package: $package... Exiting"; exit 1 ; }
done


# Guard against non-UTF8 characters in filesnames
# because ostree doesn't currently support unpacking them
# i.e the installer didn't work because of `just` package 
# having a non-ascii characters in a single filename.
# See:
#   - https://github.com/bootc-dev/bootc/pull/983 (for somereason it doesn't work properly althoug it should be implemented?)
#   - https://github.com/ostreedev/ostree/issues/2568
#
readarray -t INVALID_FILENAMES < <(find / -name '*[![:print:]]*' 2>/dev/null)
if [[ "${#INVALID_FILENAMES[@]}" -gt 0 ]]; then
    echo -e "Found ${#INVALID_FILENAMES[@]} invalid (non-UTF8 filenames, ostree doesn't like them). Offending files: \n"
    echo -e $INVALID_FILENAMES

    exit 127;
fi

#!/usr/bin/bash

set -eoux pipefail

source /etc/os-release

IMPORTANT_PACKAGES=(
    systemd
    # pipewire
    # wireplumber
    # hyprland
)

for package in "${IMPORTANT_PACKAGES[@]}"; do
    rpm -q "$package" >/dev/null || { echo "Missing package: $package... Exiting"; exit 1 ; }
done

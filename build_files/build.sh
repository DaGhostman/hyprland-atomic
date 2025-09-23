#!/bin/bash

set -ouex pipefail


### Install packages

# Install plugins repo so we can `copr enable` repos
dnf5 -y install dnf5-plugins

# RPMFusion setup
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
## Suggested step from their docs
dnf5 config-manager setopt fedora-cisco-openh264.enabled=1

# Enable variouls coprs for external packages
dnf5 -y copr enable solopasha/hyprland
dnf5 -y copr enable scottames/ghostty
dnf5 -y copr enable codifryed/CoolerControl
dnf5 -y copr enable ilyaz/LACT

# Enable 1Password repo
rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'


dnf5 -y remove dnf5-plugins

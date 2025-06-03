#!/usr/bin/bash
set -ouex pipefail

# Download & apply cursor from https://gitlab.com/Pummelfisch/future-cyan-hyprcursor
curl https://gitlab.com/Pummelfisch/future-cyan-hyprcursor/-/archive/main/future-cyan-hyprcursor-main.tar.gz?path=Future-Cyan-Hyprcursor_Theme \
    --output future-cursor.tar.gz


mkdir -p /usr/share/icons/Future-Cyan
tar -xzf future-cursor.tar.gz -C /usr/share/icons/Future-Cyan/

#
# Expose cursor to flatpak packages
#
flatpak override --filesystem=/usr/share/icons/:ro

#
# Bootstrap location for spotlight wallpapers
#
mkdir -p /var/local/wallpaper/spotlight

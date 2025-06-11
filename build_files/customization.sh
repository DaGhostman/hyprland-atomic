#!/usr/bin/bash
set -ouex pipefail

# Download & apply cursor from https://gitlab.com/Pummelfisch/future-cyan-hyprcursor
curl https://gitlab.com/Pummelfisch/future-cyan-hyprcursor/-/archive/main/future-cyan-hyprcursor-main.tar.gz?path=Future-Cyan-Hyprcursor_Theme \
    --output future-cursor.tar.gz


mkdir -p /usr/share/icons/Future-Cyan
tar -xzvf future-cursor.tar.gz --strip-components=2 -C /usr/share/icons/Future-Cyan/ future-cyan-hyprcursor-main-Future-Cyan-Hyprcursor_Theme/Future-Cyan-Hyprcursor_Theme
rm future-cursor.tar.gz

#
# Expose cursor to flatpak packages
#
flatpak override --filesystem=/usr/share/icons/:ro

# 
# Create symlink to `ghostty` executable as `kitty` to enable default shortcuts to work (at least be able to open a terminal)
#
ln -sf "$(which ghostty)" /usr/local/bin/kitty

#
# Create a `atomic` user that can be used for various system scripts
#
useradd --system atomic

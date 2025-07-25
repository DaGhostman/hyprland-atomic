#!/usr/bin/bash
set -ouex pipefail

# Download & apply cursor from https://gitlab.com/Pummelfisch/future-cyan-hyprcursor
curl https://gitlab.com/Pummelfisch/future-cyan-hyprcursor/-/archive/main/future-cyan-hyprcursor-main.tar.gz?path=Future-Cyan-Hyprcursor_Theme \
    -L \
    --output future-cursor.tar.gz


mkdir -p /usr/share/icons/Future-Cyan
tar -xzvf future-cursor.tar.gz --strip-components=2 -C /usr/share/icons/Future-Cyan/ future-cyan-hyprcursor-main-Future-Cyan-Hyprcursor_Theme/Future-Cyan-Hyprcursor_Theme
rm future-cursor.tar.gz


curl https://github.com/adi1090x/plymouth-themes/releases/download/v1.0/sphere.tar.gz \
    -L \
    --output sphere.tar.gz

tar -xzvf sphere.tar.gz -C /usr/share/plymouth/themes/

plymouth-set-default-theme -l
plymouth-set-default-theme sphere

rm sphere.tar.gz

#
# Download Monaspace fonts v1.200 (https://monaspace.githubnext.com/)
# curl https://github.com/githubnext/monaspace/releases/download/v1.200/monaspace-v1.200.zip \
#     -L \
#     --output monaspace.zip
#
# mkdir -p /usr/share/fonts/Monaspace
# unzip -jo monaspace.zip "monaspace-v1.200/fonts/*" -d /usr/share/fonts/Monaspace
# fc-cache -f
# rm monaspace.zip


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

#
# Customize shells
#

# QoL tweaks for zsh
echo "source /etc/extra/00-history-zsh.sh" >> /etc/zshrc
echo "source /etc/extra/00-key-bindings-zsh.sh" >> /etc/zshrc

# Handle minimal customizations
cat /ctx/shell_config.sh >> /etc/bashrc
cat /ctx/shell_config.sh >> /etc/zshrc


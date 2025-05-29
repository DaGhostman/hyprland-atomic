#!/usr/bin/bash

set -ouex pipefail

# Enable getty on tty1 for image with no Display Manager
if [[ "$IMAGE_NAME" == "base" ]]; then
    systemctl enable getty@tty1
fi

dnf5 -y remove rsync

# Workaround: Rename just's CN readme to README.zh-cn.md 
# mv '/usr/share/doc/just/README.中文.md' '/usr/share/doc/just/README.zh-cn.md'

# Remove dnf5 versionlocks
dnf5 versionlock clear

# Enable Update Timers
systemctl enable rpm-ostreed-automatic.timer
systemctl set-default graphical.target


# Configure staged updates for rpm-ostree
# cp /usr/share/ublue-os/update-services/etc/rpm-ostreed.conf /etc/rpm-ostreed.conf

# Fix cjk fonts
# ln -s "/usr/share/fonts/google-noto-sans-cjk-fonts" "/usr/share/fonts/noto-cjk"

# Remove coprs
# dnf5 -y copr remove ublue-os/staging
# dnf5 -y copr remove ublue-os/packages
# dnf5 -y copr remove kylegospo/oversteer

# Disable Negativo17 Fedora Multimedia
# This needs to be a whole organiztion change
# dnf5 config-manager setopt fedora-multimedia.enabled=0

# Cleanup
# Remove tmp files and everything in dirs that make bootc unhappy
dnf5 clean all

rm -rf /tmp/* || true
rm -rf /usr/etc
rm -rf /sys_files
rm -rf /boot && mkdir /boot

shopt -s extglob
rm -rf /var/!(cache)
rm -rf /var/cache/!(libdnf5)

# Make sure /var/tmp is properly created
mkdir -p /var/tmp
chmod -R 1777 /var/tmp

restorecon /

# Check to make sure important packages are present
/ctx/check-build.sh


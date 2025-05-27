#!/usr/bin/bash

set -ouex pipefail

# Copy System Files onto root
rsync -rvKIc /ctx/sys_files/ /
rsync -rvKIc /ctx/sys_files/ /usr
cat /etc/greetd/config.toml
cat /usr/etc/greetd/config.toml


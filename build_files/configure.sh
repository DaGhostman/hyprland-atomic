#!/usr/bin/bash

set -ouex pipefail

dnf5 -y install rsync

# Copy System Files onto root
rsync -rvKIc /ctx/sys_files/ /
rsync -rvKIc /ctx/sys_files/ /usr

dnf5 -y remove rsync

#!/bin/bash

set -ouex pipefail

if [[ "$(/usr/share/doc/just/README.*.md)" != null ]]; then
    rm /usr/share/doc/just/README.*.md
fi

# if file exists
# /usr/share/doc/just/README.*.md
# remove it

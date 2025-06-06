# Load brew
BREW_PREFIX=/home/linuxbrew/.linuxbrew
if [[ ! -f ${BREW_PREFIX}/bin/brew ]]; then
    eval "\$(${BREW_PREFIX}/bin/brew shellenv)"
fi

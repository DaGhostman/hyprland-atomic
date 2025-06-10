# Load brew
BREW_PREFIX=/home/linuxbrew/.linuxbrew
if [[ ! -f ${BREW_PREFIX}/bin/brew ]]; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    if [[ -z "$(cmd_or brew)" ]]; then
        eval "$(${BREW_PREFIX}/bin/brew shellenv)"
    fi
fi

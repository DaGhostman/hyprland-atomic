# Load brew
BREW_PREFIX=/home/linuxbrew/.linuxbrew
if [[ ! -f ${BREW_PREFIX}/bin/brew ]]; then
    eval "\$(${BREW_PREFIX}/bin/brew shellenv)"
else
    # Attempt to install brew inside the container
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    chmod +x /home/.linuxbrew/bin/brew
    eval "\$(${BREW_PREFIX}/bin/brew shellenv)"
fi

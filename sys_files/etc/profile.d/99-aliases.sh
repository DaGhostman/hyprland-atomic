function atomic() {
    if [[ -f "/home/linuxbrew/.linuxbrew/bin/just" ]]; then
        /home/linuxbrew/.linuxbrew/bin/just -f /etc/Justfile $@
    else
	echo "It appears your system hasn't been setup with the internal/extra tooling, consider running \`/usr/local/bin/__post_install\` to ensure the defaults have been setup and try again."
    fi
}

function ls() {
    if [[ -f "/home/linuxbrew/.linuxbrew/bin/eza" ]]; then
        /home/linuxbrew/.linuxbrew/bin/eza --icons --group-directories-first --git $@
    else
        /bin/ls $@
    fi
}

function grep() {
    if [[ -f "/usr/bin/rg" ]]; then
        /usr/bin/rg $@
    else
        /usr/bin/grep --color=auto $@
    fi
}

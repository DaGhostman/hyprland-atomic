function atomic() {
    just -f /etc/Justfile $@
}

if [[ ! -z $(which eza) ]]; then
    function ls() {
        eza --icons --group-directories-first --git $@
    }

    function tree() {
        eza --icons --group-directories-first --tree $@
    }
fi

if [[ ! -z $(which fzf) ]]; then
    eval "$(fzf --$(basename $SHELL))"
fi

if [[ "$0" -eq "$SHELL" ]]; then
    function atomic() {
        if [[ ! -z "$(cmd_or just)" ]]; then
            just -f /etc/Justfile $@
        else
    	echo "It appears your system hasn't been setup with the internal/extra tooling, consider running \`/usr/local/bin/__post_install\` to ensure the defaults have been setup and try again."
        fi
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
        eval "$(fzf --$(basename $(file_or $0 $SHELL)))"
    fi
fi

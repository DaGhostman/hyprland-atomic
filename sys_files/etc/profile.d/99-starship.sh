if [[ ! -z "$(cmd_or starship)" ]]; then
    var_or_run STARSHIP_SHELL \
        "eval $(/home/linuxbrew/.linuxbrew/bin/starship init $(basename $(file_or $0 $SHELL)))"
fi

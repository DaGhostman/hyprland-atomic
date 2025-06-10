if [[ ! -z $(which starship) ]]; then
    var_or_run STARSHIP_SHELL \
        eval "export ZSH_VERSION=\"$(value_or $ZSH_VERSION 5.0)\"; $(starship init $(file_or $0 $SHELL))" 2>/dev/null
fi

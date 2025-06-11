if [[ ! -z "$(cmd_or starship)" ]]; then
    var_or_run STARSHIP_SHELL \
        "ZSH_VERSION=$(value_or $ZSH_VERSION \"$(dnf list --installed | grep $(basename \"$(value_or $0 $SHELL).$(arch)\") | awk '{print $2}' | split -t '-' -n 1/4 -)\") eval $(/home/linuxbrew/.linuxbrew/bin/starship init $(basename $(file_or $0 $SHELL)))"
fi

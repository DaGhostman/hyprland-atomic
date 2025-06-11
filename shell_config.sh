#!/usr/bin/env bash


PATH=${HOME}/.local/bin:$PATH


BREW_PREFIX=${BREW_PREFIX:=/home/linuxbrew/.linuxbrew}

if [[ -f ${BREW_PREFIX}/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [[ -f ${BREW_PREFIX}/bin/fzf ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/fzf --$(basename ${SHELL}))"
fi

if [[ -f ${BREW_PREFIX}/bin/starship ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/starship init $(basename ${SHELL}))"
fi


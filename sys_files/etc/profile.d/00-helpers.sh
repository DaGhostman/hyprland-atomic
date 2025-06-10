function eprint() {
    echo "$@" 1>&2 
}

function value_or() {
    if [[ $# -lt 1 ]]; then
        eprint "Expected at least 1 argument for retrieval"
	return;
    fi

    if [[ $# -gt 2 ]]; then
        eprint "Function does not support more than 2 arguments"
	return;
    fi

    _DEFAULT="$2"
    _ACTUAL="$1"

    if [[ ! -z "${_ACTUAL}" ]]; then
        echo $_ACTUAL;
    else
        echo $_DEFAULT;
    fi

    unset _ACTUAL _DEFAULT
}

function value_or_run() {
    if [[ ! $# -gt 1 ]]; then
        eprint "Expected a value and a callback to execute if it is empty"
	return;
    fi

    _CONDITION=$1
    _CALLBACK=${@:2}

    if [[ -z $(value_or $_CONDITION) ]]; then
        eval "${_CALLBACK}"
    else
        echo $_CONDITION
    fi

}

function var_or_run() {
    if [[ ! $# -gt 2 ]]; then
        eprint "Expected a value and a callback to execute if it is empty"
	return;
    fi

    _CONDITION="$1"
    _CALLBACK=${@:2}

    if [[ -z $(value_or $_CONDITION) ]]; then
        eval "${_CALLBACK}"
    fi

    echo "${!1}"
}

function file_or() {
    _FILE="$1"
    _DEFAULT="$2"


    value_or "$(ls \"${_FILE}\" 2>/dev/null)" "${_DEFAULT}"
    unset _FILE _DEFAULT
}

function cmd_or() {
    _CMD="$1"
    _DEFAULT="$2"

    value_or "$(which \"${_FILE}\" 2>/dev/null)" "${_DEFAULT}"
    unset _CMD _DEFAULT
}


use-pythonz() {
    # try to load pythonz
    [[ -s "$HOME/.pythonz/etc/bashrc" ]] && . "$HOME/.pythonz/etc/bashrc"
}

use-venv() {
    # try to load virtualenvwrapper
    [[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && . "/usr/local/bin/virtualenvwrapper.sh"
}

prompt_on() {
    if [ -n "$PSBAK" ]; then
        PS1=$PSBAK
    fi
}

prompt_off() {
    PSBAK=$PS1
    PS1="\$ "
}

=() {
    calc="${@//p/+}"
    calc="${calc//x/*}"
    bc -l <<<"scale=10;$calc"
}

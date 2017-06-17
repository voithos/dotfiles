## .bashrc

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# global constants
#==================
export PROJDIR=$HOME/Projects/Programming
export PROJACTIVE=$PROJDIR/Active

#======================
# main configuration ##
#======================
export EDITOR=vim

# disable terminal scroll lock (Ctrl+S)
stty -ixon

# don't try to complete an empty command
shopt -s no_empty_cmd_completion

# default to emacs-style command editing
set -o emacs

# cd into directories by typing their name
shopt -s autocd

# don't put duplicate lines in the history
export HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=5000
export HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# if this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored man
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# display ls output as weighted
export LC_COLLATE="C"

# set a fancy prompt
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
else
    color_prompt=
fi

export PS1="[\u@\H] \w \$ "
if [ "$color_prompt" = yes ]; then
    if [ -f ~/.bash/bash_prompt.sh ]; then
        . ~/.bash/bash_prompt.sh
    fi
fi
unset color_prompt

# alias definitions
if [ -f ~/.bash/bash_aliases.sh ]; then
    . ~/.bash/bash_aliases.sh
fi

# path additions
if [ -f ~/.bash/bash_paths.sh ]; then
    . ~/.bash/bash_paths.sh
fi

# bash functions
if [ -f ~/.bash/bash_functions.sh ]; then
    . ~/.bash/bash_functions.sh
fi

# third party
if [ -f ~/.bash/bash_third_party.sh ]; then
  . ~/.bash/bash_third_party.sh
fi

# non-work-specific
if [ ! -f ~/.atwork ]; then
    # bash-preexec
    if [ -f ~/.bash/bash-preexec.sh ]; then
        . ~/.bash/bash-preexec.sh
    fi
fi

# machine-specific overrides
if [ -f ~/.bashlocal ]; then
    . ~/.bashlocal
fi

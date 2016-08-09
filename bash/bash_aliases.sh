# ls
alias ll='ls -alhF --group-directories-first'
alias la='ls -A'
alias l='ls -CF'
alias lln='ls -alhFv --group-directories-first' # natural sort

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# directory aliases
alias pd='cd $PROJDIR'
alias pa='cd $PROJACTIVE'

# utility aliases
alias timestamp='date "+%Y-%m-%d_%H.%M.%S"'
alias tmux='TERM=screen-256color-bce tmux'
alias tmuxa='tmux attach -t default || tmux new -s default'

if command -v hub &>/dev/null; then
    alias git='hub'
fi

if command -v xdg-open &>/dev/null; then
    alias open='xdg-open'
fi

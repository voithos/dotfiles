# ls
if [[ $OSTYPE == linux-gnu ]]; then
    alias ll='ls -alhF --group-directories-first'
    alias lln='ls -alhFv --group-directories-first' # natural sort
else
    export CLICOLOR=1
    alias ll='ls -alhF'
    alias lln='ls -alhFv' # natural sort
fi
alias la='ls -A'
alias l='ls -CF'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# directory aliases
alias pd='cd $PROJDIR'
alias pa='cd $PROJACTIVE'
alias pc='cd $PROJCONTRIB'

# utility aliases
alias timestamp='date "+%Y-%m-%d_%H.%M.%S"'
alias tmux='TERM=screen-256color-bce tmux'
alias tmuxa='tmux attach -t default || tmux new -s default'

if command -v xdg-open &>/dev/null; then
    alias open='xdg-open'
fi

# non-work-specific
if [ ! -f ~/.atwork ]; then
    alias blaze='bazel'
    alias iblaze='ibazel'
fi

# ---------------------------

# Generates a completer for a command alias based on a completer of the
# underlying command. Takes three arguments:
# $1: The name of the alias
# $2: The command used in the alias
# $3: The arguments in the alias all in one string
wrap_alias() {
    [[ "$#" == 3 ]] || return 1

    local alias_name="$1"
    local aliased_command="$2"
    local aliase_arguments="$3"
    local num_alias_arguments=$(echo "$alias_arguments" | wc -w)

    # The completion currently being used for the aliased command.
    local completion=$(complete -p "$aliased_command" 2> /dev/null)

    # Only a completer based on a function can be wrapped so look for -F
    # in the current completion. This check will also catch commands
    # with no completer for which $completion will be empty.
    echo "$completion" | grep -q -- -F || return 0

    local namespace="alias_completion::"

    # Extract the name of the completion function from a string that
    # looks like: something -F function_name something
    # First strip the beginning of the string up to the function name by
    # removing "* -F " from the front.
    local completion_function="${completion##* -F }"
    # Then strip " *" from the end, leaving only the function name.
    completion_function="${completion_function%% *}"

    # Try to prevent an infinite loop by not wrapping a function
    # generated by this function. This can happen when the user runs
    # this twice for an alias like ls='ls --color=auto' or alias l='ls'
    # and alias ls='l foo'
    [[ "${completion_function#$namespace}" != "$completion_function" ]] && return 0

    local wrapper_name="${namespace}${alias_name}"

    eval "
${wrapper_name}() {
    let COMP_CWORD+=$num_alias_arguments
    args=( \"${alias_arguments}\" )
    COMP_WORDS=( $aliased_command \${args[@]} \${COMP_WORDS[@]:1} )
    $completion_function
}
"

    # To create the new completion we use the old one with two
    # replacements:
    # 1) Replace the function with the wrapper.
    local new_completion="${completion/-F * /-F $wrapper_name }"
    # 2) Replace the command being completed with the alias.
    new_completion="${new_completion% *} $alias_name"

    eval "$new_completion"
}


# non-work-specific
if [ ! -f ~/.atwork ]; then
    wrap_alias blaze bazel ''
fi

unset wrap_alias

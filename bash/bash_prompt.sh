__powerline() {

    # Unicode symbols
    readonly PS_SYMBOL_DARWIN=''
    readonly PS_SYMBOL_LINUX='$'
    readonly PS_SYMBOL_OTHER='%'
    readonly GIT_BRANCH_SYMBOL='⑂ '
    readonly GIT_BRANCH_CHANGED_SYMBOL='⚡'
    readonly GIT_NEED_PUSH_SYMBOL='⇡'
    readonly GIT_NEED_PULL_SYMBOL='⇣'

    # Solarized colorscheme
    readonly FG_BASE03="\[$(tput setaf 8)\]"
    readonly FG_BASE02="\[$(tput setaf 0)\]"
    readonly FG_BASE01="\[$(tput setaf 10)\]"
    readonly FG_BASE00="\[$(tput setaf 11)\]"
    readonly FG_BASE0="\[$(tput setaf 12)\]"
    readonly FG_BASE1="\[$(tput setaf 14)\]"
    readonly FG_BASE2="\[$(tput setaf 7)\]"
    readonly FG_BASE3="\[$(tput setaf 15)\]"

    readonly BG_BASE03="\[$(tput setab 8)\]"
    readonly BG_BASE02="\[$(tput setab 0)\]"
    readonly BG_BASE01="\[$(tput setab 10)\]"
    readonly BG_BASE00="\[$(tput setab 11)\]"
    readonly BG_BASE0="\[$(tput setab 12)\]"
    readonly BG_BASE1="\[$(tput setab 14)\]"
    readonly BG_BASE2="\[$(tput setab 7)\]"
    readonly BG_BASE3="\[$(tput setab 15)\]"

    readonly FG_YELLOW="\[$(tput setaf 3)\]"
    readonly FG_ORANGE="\[$(tput setaf 9)\]"
    readonly FG_RED="\[$(tput setaf 1)\]"
    readonly FG_MAGENTA="\[$(tput setaf 5)\]"
    readonly FG_VIOLET="\[$(tput setaf 13)\]"
    readonly FG_BLUE="\[$(tput setaf 4)\]"
    readonly FG_CYAN="\[$(tput setaf 6)\]"
    readonly FG_GREEN="\[$(tput setaf 2)\]"

    readonly BG_YELLOW="\[$(tput setab 3)\]"
    readonly BG_ORANGE="\[$(tput setab 9)\]"
    readonly BG_RED="\[$(tput setab 1)\]"
    readonly BG_MAGENTA="\[$(tput setab 5)\]"
    readonly BG_VIOLET="\[$(tput setab 13)\]"
    readonly BG_BLUE="\[$(tput setab 4)\]"
    readonly BG_CYAN="\[$(tput setab 6)\]"
    readonly BG_GREEN="\[$(tput setab 2)\]"

    readonly DIM="\[$(tput dim)\]"
    readonly REVERSE="\[$(tput rev)\]"
    readonly RESET="\[$(tput sgr0)\]"
    readonly BOLD="\[$(tput bold)\]"

    # what OS?
    case "$(uname)" in
        Darwin)
            readonly PS_SYMBOL=$PS_SYMBOL_DARWIN
            ;;
        Linux)
            readonly PS_SYMBOL=$PS_SYMBOL_LINUX
            ;;
        *)
            readonly PS_SYMBOL=$PS_SYMBOL_OTHER
    esac

    __git_info() {
        command -v git &>/dev/null || return # git not found

        local marks
        local branch

        local git_status="$(git status 2>/dev/null)"
        local pattern="On branch ([^${IFS}]*)"
        local detached="HEAD detached"
        local rebase="interactive rebase"

        if [[ ! ${git_status} =~ working\ (directory|tree)\ clean ]]; then
            marks+=" $GIT_BRANCH_CHANGED_SYMBOL"
        fi

        if [[ ${git_status} =~ ${pattern} ]]; then
            branch=${BASH_REMATCH[1]}
        elif [[ ${git_status} =~ ${detached} ]]; then
            branch="($(git describe --always --contains HEAD))"
        elif [[ ${git_status} =~ ${rebase} ]]; then
            branch="(rebase)"
        else
            return
        fi

        # print the git branch segment without a trailing newline
        printf " $GIT_BRANCH_SYMBOL$branch$marks "
    }

    __venv_info() {
        if [[ -n $VIRTUAL_ENV ]]; then
            printf "($(basename $VIRTUAL_ENV))"
        fi
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly.
        if [ $? -eq 0 ]; then
            local BG_EXIT="$BG_GREEN"
        else
            local BG_EXIT="$BG_RED"
        fi

        PS1="$BG_BLUE$FG_BASE3$(__venv_info)$RESET"
        PS1+="$BG_MAGENTA$FG_BASE3|\u@\H|$RESET"
        PS1+="$BG_CYAN$FG_BASE3 \w $RESET"
        PS1+="$BG_BLUE$FG_BASE3$(__git_info)$RESET"
        PS1+="$BG_EXIT$FG_BASE3 $PS_SYMBOL $RESET "
    }

    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline

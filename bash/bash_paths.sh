# installed and external projects bin path
export PATH=$PATH:$HOME/.local/bin:$HOME/.bin

# virtualenv configuration
export WORKON_HOME=$HOME/.virtualenvs

# non-work-specific
if [ ! -f ~/.atwork ]; then
    # GOPATH
    if command -v go &>/dev/null; then
        export GOPATH="$HOME/Software/go"
        export PATH=$PATH:$(go env GOPATH)/bin
    fi
fi

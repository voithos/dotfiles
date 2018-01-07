# installed and external projects bin path
export PATH=$PATH:$HOME/.local/bin:$HOME/.bin

# virtualenv configuration
export WORKON_HOME=$HOME/.virtualenvs

# rust/cargo
export PATH="$HOME/.cargo/bin:$PATH"

# non-work-specific
if [ ! -f ~/.atwork ]; then
    export PATH="$PATH:/usr/local/go/bin"

    # GOPATH
    if command -v go &>/dev/null; then
        export GOPATH="$HOME/Software/go"
        export PATH=$PATH:$(go env GOPATH)/bin
    fi
fi

#!/bin/bash

# Fix SSH auth socket location so agent forwarding works with tmux.
if [ -S "$SSH_AUTH_SOCK" ]; then
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock.$(hostname)
fi

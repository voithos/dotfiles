dotfiles
========

An organic configuration.

Installing
----------

This configuration relies on Ansible. Install it:

    sudo apt-get install software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install ansible

Then, clone the project:

    cd
    git clone --recursive https://github.com/voithos/dotfiles.git .dotfiles

Finally, execute the Ansible playbook (use `common.yml` if it's not a personal machine):

    cd .dotfiles/ansible
    ansible-playbook personal.yml

Most things should be set-up after that - all you have to do now is just start
up Vim, and NeoBundle will prompt you to install the plugins.

Success!

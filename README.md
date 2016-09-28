dotfiles
========

An organic configuration.

Installing
----------

This configuration relies on Ansible. Install it via pip. To get pip:

    curl --silent --show-error https://bootstrap.pypa.io/get-pip.py | sudo python2.7

Install Ansible:

    sudo pip install ansible

Clone the project:

    cd
    git clone --recursive https://github.com/voithos/dotfiles.git .dotfiles

Finally, execute the Ansible playbook (use `common.yml` if it's not a personal machine):

    cd .dotfiles/ansible
    sudo ansible-playbook personal.yml

Most things should be set-up after that - all you have to do now is just start
up Vim, and NeoBundle will prompt you to install the plugins.

Success!

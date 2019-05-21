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
    git clone --recursive git@github.com:voithos/dotfiles.git .dotfiles

Finally, execute the Ansible playbook (use `mac.yml` without `sudo` if on a Mac):

    cd .dotfiles/ansible
    sudo ansible-playbook linux.yml

You can also select subsets of the playbook roles using `--tags` (look in the
playbook file to see them):

    sudo ansible-playbook linux.yml --tags "common,shortnames"

Most things should be set-up after that - all you have to do now is just start
up Vim, and NeoBundle will prompt you to install the plugins.

Success!

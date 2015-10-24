# Dotfiles
Just another dotfiles repo. Because that's what the world needs right now.

## Requirements
You’ll need to install Xcode from the AppStore before you can run
the playbook. After installing Xcode, go to usage.

## Usage
```
curl -s https://github.com/johnpneumann/dotfiles/dotfiles_install.sh
```

## Alternate Usage
Clone the repo. Symlink the files/directories from aforementioned
cloned directory to the respective files in your $HOME directory.

Run `create_symlinks.sh` to do that when we’re installing vim plugins
we know what we’re trying to install and what we’re configuring. Next,
run `dotfiles_install.sh` which will help install some pre-requisites,
clone ansible and the dotfiles and some other stuff. Read the file if
you’re curious about it. You'll be prompted for your GitHub username,
which will just be used to create some directories.

## Ansible
After you’ve symlinked everything and gotten ansible installed
and sourced simply cd into the dotfiles directory and run:
```
cd ~/repos/foss/ansible
source ./hacking/env-setup
cd ~/repos/
ansible-playbook playbooks/site.yml -i hosts
```

That's all there is to it now.

## Notices and Licenses
I'm not responsible for your derpness. Please derp responsibly.

Licensed under the 3 Clause BSD license. The license has been
included for your reference.

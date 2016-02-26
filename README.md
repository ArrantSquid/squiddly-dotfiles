# neumann does dotfiles
The inner workings of every developers brain lies in their
dotfiles. Madness ensues when others attempt to understand
them. Then someone creates a Singleton Factory class and
you scratch your head wondering whether or not this is real
life or if you're stuck in that Shrek video on YouTube.
Just then, you wake up to the AWS alarms going off on your
phone so you rush to your laptop to fix whatever CloudWatch
alarm just went off, except that you stumble into your spirit
animal along the way. You have a chat and some tea, and it's
then that you finally realize that you've just been a part of
this half-inception, half-matrix experiment and that the government
is using your dotfiles.

You should fork this repo or it might get out of control with this
kind of thing. I am not to be encouraged.

## assumptions
You're running on OSX. Most of this could be tweaked to be run on
Linux, but I haven't had the need or time to quite yet. If someone
does, please send a pull request my way. I'd be more than happy to
merge it.

## requirements
You’ll need to install Xcode from the AppStore before you can run
things. After installing Xcode, go to the installation section.

## installation
We use a basic script that installs homebrew, python and ansible
to provision the system. Why? Because I like ansible.

```
git clone https://github.com/johnpneumann/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sh script/bootstrap.sh
```

This will symlink all the files we need, install homebrew,
install python, upgrade pip and setuptools and then install
virtualenv. Then it will create a virtualenv, install ansible
and all it's pre-requisites and run the playbook. If you'd
like to configure the packages that are installed, go to the
`ansible/playbooks/group_vars/all` file and modify the packages
within there.

## extras
[extras](extras)

## if there was a problem
Yo I'll solve it. Just file an issue, while my DJ revolves it.

## credits
After spending some time exploring the world wide web (and github
specifically) I found that there were really smart people doing some
cool stuff. So I copied some of it. Most of the new ideas came from
[Zach Holman's dotfiles repo](https://github.com/holman/dotfiles).
Specifically the bootstrap and the directory layout (though I
haven't gone as far as he has with his).

## license
Licensed under the 3 Clause BSD license. The license has been
included for your reference.

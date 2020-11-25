# ubuntu-setup

Simple configurations for post Ubuntu installation

Currently specific for 20.04 LTS

## XX Things to do After Installing Ubuntu

There are many websites that offer advice and steps to finish tweaking and setting up a new Ubuntu installation.
This repo does *NOT* replace them. In fact, we recommend you read them and tweak to your heart's content.

This repo is for specific post install configs and setup that I like on my Ubuntu desktop.
And it serves as a way for me to store these configs so that its easy for me to re-install Ubuntu with a clean slate.

Very similar to the `gitops` philosophy of configuration management

## Directory Structure

### OPT

If I download some binaries (software) and its a tarball. Then I'll extract it to the `/opt` directory.

* `packages.list`

list of software packages to download, extract, and add to the appropriate PATH variables

Some people prefer to use `/usr/local` directory for these binaries. In some cases, maybe
using linux brew or finding the appropriate ubuntu ppa makes sense.

### HOME

The files under `home` are should be placed in your home directory (`~/`)

If a file start with `_` it should start with `.`  
This wwas changed to that the files are easily visiable within source control, etc.

* `_bashrc`  
Append this to the end of your `~/.bashrc`
* `_emacs`  
Append this to your `./emacs`
* `apps.list`  
software tarballs that I extract to `~/app`  
Similar to `/opt` packages except these are specific to my user and I'm testing them out
* `debs.list`  
debian packages to install
* `snaps.list`  
Ubuntu snap apps to install via `sudo snap install slack`

### ETC

The files under `etc` system wide configurations. Please be careful when you modify them

* `fstab`  
I have `/tmp` mounted in memory (opposed to hard disk) to save wear and tear on SSD. This is also faster performance when temp files are required.  
I also have a network file system server that I store all of my photos, videos, and other content to be shared with all of my computers.  
* `profile`  
Some environment variables that are set in `.bashrc` could be set here. The difference is that if set here in `profile` then it applies to all users. Need to consider if all users need those env vars, etc
* `sources.list`  
Contains additional apt repositories (PPA) of other software that I like to install and use.

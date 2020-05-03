# Applications

These are 3rd party applications that I like to install for my uses

# Apt packages

I install the below from the ubuntu apt repositories.
In some case, I use a PPA to install a newer version of the software.

I prefer to use the linux distro package manager whenever possible

## Basics

These are the basic apps that I use all the time and expect to be there.
The future apps and workflows defined here will rely upon them.

### zsh

new shell that is much more customizable than bash.
use (ohmyzsh)[https://ohmyz.sh] to customize it.

### git 

version control system. Can't run a `gitops` system without git.

### aptitude

a TUI apt package manager

### emacs

my preferred text editor

#### init.el 

- configure emacs to load the init.el provided

#### emacsclient 

- use systemctl to start the emacs daemon for emacsclient
- set editor to emacsclient

### vim

another amazing text editor

## Command Line Input

very helpful CLI tools

### hunspell
one of the best spell checkers arounds

NB: may also need to include the US english dictionary

### markdown

markdown engine

### grip

markdown engine, specific to github

### hugo

static site generator

### silversearcher-ag

patter based file searcher
code search tool

### ripgrep

pattern based file searchers
code search tool

rg is better than ag

### neofetch 

flashy way to display your system info

## Utilities

### gnome-tweaks

I run the Gnome 3 desktop environment.
This is a must to tweak it to my liking

### virtualbox

run a local VM for whatever purpose

### imagemagick

used by pdf-tools and many other ubuntu apps

### AirVPN

VPN and openvpn so that one may browse the internet anonymously.

Go to their website and download the deb file for Eddie UI
This will also add an apt-repo to keep it updated

https://www.airvpn.org

### peek

Peek is a simple screen recorder to generate gifs

Install the ubuntu apt-repo as per:
https://github.com/phw/peek#installation

### gimp

image manipulation (kinda like photoshop)

### lollypop

Music manager for local mp3 files.
Spotify has replaced local music management for the most part.

### vlc

It plays everything. It is also available as a snap

### mpv

It plays everything. Pretty neat support for streaming services too

### obs studio

Excellent software for recording your desktop and screen.
Can also be used for streaming.

### audacity

sound editor

### kdenlive

video editor

### ckb-next

I use the corsair RGK K70 Vengeance keyboard.
This is the driver that makes it work on linux, and lets me customize the colors

https://launchpad.net/~tatokis/+archive/ubuntu/ckb-next

## Gaming

### steam

Steam is Valve's game store and launcher

Steam is available in the ubuntu repo

### controller support (steam)

you'll also need to install `steam-devices`

### retroarch

emulator framework

Find their ubuntu ppa and add it according to their instructions
https://www.retroarch.com/index.php?page=linux-instructions

### wine

Wine is not an emulator

wine is available in the ubuntu repo. However it usually is an older version.
Follow the instructions here: https://wiki.winehq.org/Ubuntu

### lutris

lutris makes installing wine, winecfg, etc simpler and straight-forward for many games and windows applications

Follow the instructions here: https://lutris.net/downloads/

### game hub

This is kinda interesting
https://tkashkin.tk/projects/gamehub/

## Snaps

Snaps are ways to bundle and ship applications. 
They will keep themselves updated and will not cause requirements/ dependencies to clash

There is a snapstore where you can "shop" and install them: 
https://snapcraft.io/store

### spotify

online streaming music manager/ player

### slack

modern and popular IRC

### discord

modern and popular IRC

### dbeaver

universal database client

# Deb packages

The following apps are installed to the apt package manager via deb file.
When the deb file is installed, they also provide a PPA to keep the software up to date.

### google-chrome

Web browser

Get the deb file and install. It will also add itself to apt to keep itself up to date
https://www.google.com/chrome/

### code

Visual Studio Code is a code editor, made by microsoft.

Find the downloadable debian and install it. It will also add itselfs to
your apt repo to keep itself up to date.

https://code.visualstudio.com/download

There is a snap as well, but I prefer deb+apt solutions

# Engineering

Follow the steps here to setup your local environment.

Please read [Engineering](../engineering.md)

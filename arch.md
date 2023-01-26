# Another arch linux customization

I no longer use Ubuntu as my linux operating system. I moved to arch linux in order to have further up to date software and to be using the latest versions available. Arch linux uses a rolling release methodology opposed to Ubuntu's every 6 months releases. I found with Ubuntu, I had to manage some of my own packages in order to have the latest version of software (programming tools, etc). Or I had to use a package manager outside of the OS package manager (linux brew vs apt). This felt silly to me, I should have only one package manager for the system and use that one.

This are items to install or modify after a standard arch linux install is completed
There is some overlap with the official post-install [General Recommendations](https://wiki.archlinux.org/title/General_recommendations).

Other arch linux specific items are within the `arch` directory.
Yet Another [arch.md](arch/arch.md)

## AUR helper

[yay](https://aur.archlinux.org/packages/yay)

## Stop repeated pings
[ping.archlinux.org](https://wiki.archlinux.org/title/NetworkManager#Configuration)

## Enable parallel downloads
This is a config in `/etc/pacman.conf`

## Better CPU use
Install `intel-ucode` or `amd-ucode`

## Better laptop battery life
Install the one of the following:
- `tlp` 
- `autocpu-freq`
- `powertop` or power-profiles-daemon

## install noto-fonts
This includes a good number of compatible fonts

`noto-fonts`
`ttf-ubuntu-font-family`
`ttf-roboto`
`ttf-roboto-mono`

## nas

`nfsutils`
/etc/fstab edits

## open vpn

- From airvpn (my vpn provider), use their client generator to generate the configuration files needed.
- Then change the *.ovpn file extension to *.conf
- Then copy it to the `/etc/openvpn/client directory`
- Start the systemd service as per the wiki

If using an older client conf, might need to add this line

```
tls-cipher "DEFAULT:@SECLEVEL=0"
```

[Relevant Wiki page](https://wiki.archlinux.org/title/OpenVPN#Starting_OpenVPN)

## firewall

- install ufw (uncomplicated fire wall)
  - install iptables (if you don't already have it)
- Follow the [basic configuration](https://wiki.archlinux.org/title/Uncomplicated_Firewall) steps

## qbittorrent

install the `-nox` package
setup a systemd service following these two sites:
- https://github.com/qbittorrent/qBittorrent/wiki/Running-qBittorrent-without-X-server-(WebUI-only,-systemd-service-set-up,-Ubuntu-15.04-or-newer)
- https://blog.raw.pm/en/archlinux-install-qbittorrent-nox-setup-webui/

Configure to run as a user not root.
Once started, use the WebUI to configure it
- download directory
- network interface

## pihole
I run it via [docker-compose](https://github.com/pi-hole/docker-pi-hole#quick-start) and map the port

use networkmanager conf to provide a static ip so that it is easily found as a DNS service

Or set your local networkmanager to point to the local host for DNS (pi-hole)

## nvidia drivers

After installing the `nvidia` drivers, also install the following software

- `nvidia prime`, which provides prime-run
- `switcheroo-central`, which lets you decide on launch to use the discrete graphics card
  you'll need to start the systemd service for switcheroo. Switcheroo is not compatible with optimus software.

## Enable paccache.timer
This cleans up package cache weekly
See `paccache` under [pacman-contrib](https://wiki.archlinux.org/title/Pacman)

## Enable fstrim.timer
This is used to maintain good health with SSD
See `util-linux` under [blah](https://wiki.archlinux.org/title/Solid_state_drive)

# Recommendations

I haven't done all of these yet but I will when I need theme

## Install reflector
Frequenct updates to mirrorlist automatically


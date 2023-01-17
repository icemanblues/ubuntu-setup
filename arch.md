# Another arch linux customization

## AUR helper

yay

## Stop repeated pings
ping.archlinux.org

https://wiki.archlinux.org/title/NetworkManager#Configuration

## nas

nfsutils
/etc/fstab edits


## open vpn

- From airvpn (my vpn provider), use their client generator to generate the configuration files needed.
- Then change the *.ovpn file extension to *.conf
- Then copy it to the `/etc/openvpn/client directory`
- Start the systemd service as per the wiki

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
I run it via docker-compose and map the port

use networkmanager conf to provide a static ip so that it is easily found as a DNS service

Or set your local networkmanager to point to the local host for DNS (pi-hole)

## nvidia drivers

After installing the nvidia drivers, also install the following software

- nvidia prime, which provides prime-run
- switcheroo-central, which lets you decide on launch to use the discrete graphics card
  you'll need to start the systemd service for switcheroo
  

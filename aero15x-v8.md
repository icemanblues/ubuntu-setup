# Gigabyte Aero 15x v8

This is my laptop and I'll keep track of any one-off commands specific to its configurations here.
Hopefully there will not be that many.

Excellent collection of tuning tricks
http://forum.notebookreview.com/threads/tuning-the-aero-15-w-x-v7-v8-common-problems-solutions.816143/


## External display

edit this file ` /lib/modprobe.d/nvidia-kms.conf`

comment out this line:
```
#options nvidia-drm modeset=1
```

## Keyboard RGB controller

https://github.com/guillaumesalagnac/fusion-kbd-controller

git clone this. compile it. follow the usage instructions

## Undervolt

global install of the undervolt package

```
sudo pip3 install undervolt
```

Follow the systemd service and timer setup here:
https://github.com/georgewhewell/undervolt

These are the configurations that work best for my laptop:
```
/usr/local/bin/undervolt -v --core -160 --cache -160 --gpu -150
```


## Laptop battery life

Install

* tlp
* powertop

Calibrate powertop by being on battery as the power source

```
powertop --calibrate
```

```
sudo systemctl enable tlp
sudo systemctl start tlp
```

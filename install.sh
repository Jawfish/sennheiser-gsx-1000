#!/bin/bash

set -e

echo "Installing GSX-1000"

echo "Installing X11 config"
if [ ! -d /etc/X11/xorg.conf.d ]; then
  sudo mkdir -p /etc/X11/xorg.conf.d;
fi
  sudo cp usr/share/X11/xorg.conf.d/40-sennheiser-gsx-1000.conf /etc/X11/xorg.conf.d/

echo "Installing udev rule"
if [ -d /lib/udev/rules.d/ ]; then
  echo "Udev located in /lib"
  sudo cp lib/udev/rules.d/91-pulseaudio-gsx1000.rules /lib/udev/rules.d/
elif [ -d /etc/udev/rules.d/ ]; then
  echo "Udev located in /etc"
  sudo cp lib/udev/rules.d/91-pulseaudio-gsx1000.rules /etc/udev/rules.d/
else
  echo "Udev rules route not found, hence cancelling installation"
  echo "Expected locations: /etc/udev/rules.d/ OR /lib/udev/rules.d/"
fi

echo "Installing udev hwdb"
sudo cp etc/udev/hwdb.d/sennheiser-gsx.hwdb /etc/udev/hwdb.d/

echo "Installing pulsaudio profiles"

sudo cp -r usr/share/pulseaudio/alsa-mixer/profile-sets/sennheiser-gsx-1000.conf /usr/share/pulseaudio/alsa-mixer/profile-sets/


if [ -d /usr/share/alsa-card-profile/mixer/profile-sets ]; then
  sudo ln -s /usr/share/pulseaudio/alsa-mixer/profile-sets/sennheiser-gsx-1000.conf /usr/share/alsa-card-profile/mixer/profile-sets/
fi

echo "Reloading udev rules"
sudo systemd-hwdb update
sudo udevadm control -R
sudo udevadm trigger


echo "Restarting pulse audio"
# ignore errors if we restart too often / to fast .. we just ensure to nuke it
pulseaudio -k > /dev/null 2>&1 || true
pulseaudio -k > /dev/null 2>&1 || true
pulseaudio -k > /dev/null 2>&1 || true

echo "Ensure pulseaudio is started"
sleep 2
pulseaudio -D

#!/bin/bash

# Regenerate grub configuration
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Rebuild initrd image
sudo mkinitcpio -p linux

# Enable ssh-agent on boot
systemctl enable ~/.config/systemd/user/ssh-agent.service

# Make git use ssh by default
git config --global url.ssh://git@github.com/.insteadOf https://github.com/

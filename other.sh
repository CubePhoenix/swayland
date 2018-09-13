#!/bin/bash

# Regenerate grub configuration
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Rebuild initrd image
sudo mkinitcpio -p linux

# Make git use ssh by default
git config --global url.ssh://git@github.com/.insteadOf https://github.com/

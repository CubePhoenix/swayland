#!/bin/bash

# Regenerate grub configuration
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Rebuild initrd image
sudo mkinitcpio -p linux

#!/bin/bash

# Regenerate grub configuration
grub-mkconfig -o /boot/grub/grub.cfg

# Rebuild initrd image
mkinitcpio -p linux

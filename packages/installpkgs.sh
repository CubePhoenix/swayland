#!/bin/bash

echo "Installing Packages..."

chmod +x $basedir/packages/scripts/*

while read line; do
	if [[ "$line" == @* ]]; then
        echo "Unconventional install, calling install script."
		$basedir/packages/scripts/`echo "$line.sh" | cut -d "@" -f 2`
    elif [[ "$line" == \&* ]]; then
        echo "AUR Install using yaourt"
        yaourt -S --noconfirm --needed `echo "$line" | cut -d "&" -f 2`
	elif [[ ! -z "$line" ]] && [[ "$line" != \#* ]]; then
        echo "Installing $line"
		sudo pacman -S --noconfirm --needed $line
	fi

done <$basedir/packages/packages.txt

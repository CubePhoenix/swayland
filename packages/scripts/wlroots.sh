#!/bin/bash

echo "Base Directory: $basedir"

git clone https://github.com/swaywm/wlroots $basedir/packages/scripts/workdir/
cd $basedir/packages/scripts/workdir
meson build
ninja -C build
sudo ninja -C build install

rm -rf $basedir/packages/scripts/workdir

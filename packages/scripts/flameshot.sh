#!/bin/bash

git clone https://github.com/lupoDharkael/flameshot $basedir/packages/scripts/workdir/
cd $basedir/packages/scripts/workdir
qmake && make
sudo make install
sudo rm -rf $basedir/packages/scripts/workdir

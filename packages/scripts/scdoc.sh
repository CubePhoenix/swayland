#!/bin/bash

git clone https://git.sr.ht/~sircmpwn/scdoc $basedir/packages/scripts/workdir/
cd $basedir/packages/scripts/workdir
sudo make install
sudo rm -rf $basedir/packages/scripts/workdir

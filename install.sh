#!/bin/bash

export basedir=`pwd`
echo "Base Directory: $basedir"

./packages/installpkgs.sh # install all needed packages
./files/movefiles.sh # move configuration files
./other.sh # do other stuff

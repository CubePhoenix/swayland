#!/bin/bash

export basedir=`pwd`
echo "Base Directory: $basedir"

./packages/installpkgs.sh
./files/movefiles.sh

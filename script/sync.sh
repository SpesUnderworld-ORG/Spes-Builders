#!/usr/bin/env bash

set -exv
name_rom=$(grep init $CIRCLE_WORKING_DIRECTORY/build.sh -m 1 | cut -d / -f 4)
mkdir -p "$HOME/$WORKDIR/rom/$name_rom"
cd $HOME/$WORKDIR/rom/$name_rom
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)


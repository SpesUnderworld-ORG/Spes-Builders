#!/usr/bin/env bash

set -exv
name_rom=$(grep init $CIRCLE_WORKING_DIRECTORY/build.sh -m 1 | cut -d / -f 4)
mkdir -p "$HOME/$WORKDIR/rom/$name_rom"
cd $HOME/$WORKDIR/rom/$name_rom
repo init --depth=1 --no-repo-verify -u https://github.com/RiceDroid/android -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/donboruza/local_manifests.git --depth 1 -b sweet-13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
export USE_CCACHE=1
export CCACHE_COMPRESS=true
which ccache
ccache -M 10
ccache -z
. build/envsetup.sh
lunch lineage_sweet-userdebug
export TZ=Asia/Jakarta
export KBUILD_BUILD_USER=RooGhz720
export KBUILD_BUILD_HOST=android-runner
#export SKIP_API_CHECKS=true
#export SELINUX_IGNORE_NEVERALLOWS=true
m bacon -j8
# end


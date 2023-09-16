#!/usr/bin/env bash


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
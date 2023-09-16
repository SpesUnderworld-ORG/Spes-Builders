#!/usr/bin/env bash

set -e
name_rom=$(grep init $CIRCLE_WORKING_DIRECTORY/build.sh -m 1 
--cut -d / -f 4)
device=$(grep unch $CIRCLE_WORKING_DIRECTORY/build.sh -m 1 
--cut -d ' ' -f 2 
--cut -d _ -f 2 
--cut -d - -f 1)
cd $WORKDIR/rom/$name_rom
export PATH="/usr/lib/ccache:$PATH"
export CCACHE_DIR=$WORKDIR/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
export CCACHE_COMPRESS=true
which ccache
ccache -M 10
ccache -z
command=$(tail $CIRCLE_WORKING_DIRECTORY/build.sh -n +$(expr $(grep '# build rom' $CIRCLE_WORKING_DIRECTORY/build.sh -n | cut -f1 -d:) - 1)| head -n -1 | grep -v '# end')
bash -c "$command" |& tee -a $WORKDIR/rom/$name_rom/build.log || true #& sleep 95m
bash $CIRCLE_WORKING_DIRECTORY/script/check_build.sh

#!/bin/bash

set -x
set -e

if [ -z "$SOURCE_DIR" ] ; then
    echo "Expected SOURCE_DIR in environment"
    exit 1
fi
if [ -z "$BUILD_DIR" ] ; then
    echo "Expected BUILD_DIR in environment"
    exit 1
fi

if test -d $BUILD_DIR ; then
    rm -rf $BUILD_DIR/*
fi

pushd $SOURCE_DIR/MobiPerf/measurementserver
    ./compile.sh
popd

mkdir -p $BUILD_DIR/mobiperf
cp -r $SOURCE_DIR/MobiPerf/measurementserver/mlab/*  $BUILD_DIR/mobiperf/
install -D -m 0755 $SOURCE_DIR/MobiPerf/measurementserver/initialize.sh $BUILD_DIR/init/initialize.sh
install -D -m 0755 $SOURCE_DIR/MobiPerf/measurementserver/start.sh $BUILD_DIR/init/start.sh
install -D -m 0755 $SOURCE_DIR/MobiPerf/measurementserver/stop.sh $BUILD_DIR/init/stop.sh

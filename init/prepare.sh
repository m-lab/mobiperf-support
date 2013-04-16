#!/bin/bash

set -x
set -e

if [ -z "$SOURCE_DIR" ] ; then
    echo "Expected SOURCE_DIR in environment"
    exit 1
fi
if [ -z "$BUILD_DIR" ] ; then
    echo "Expected BIULD_DIR in environment"
    exit 1
fi

if test -d $BUILD_DIR ; then
    rm -rf $BUILD_DIR/*
fi

pushd MobiPerf/tcpserver
    ./compile.sh
popd

mkdir -p $BUILD_DIR/mobiperf
cp -r MobiPerf/tcpserver/mlab/*  $BUILD_DIR/mobiperf/
install -D -m 0755 MobiPerf/tcpserver/initialize.sh $BUILD_DIR/init/initialize.sh
install -D -m 0755 MobiPerf/tcpserver/start.sh $BUILD_DIR/init/start.sh
install -D -m 0755 MobiPerf/tcpserver/stop.sh $BUILD_DIR/init/stop.sh

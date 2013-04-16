#!/bin/bash

set -x
set -e

export TOPDIR=/home/michigan_1
mkdir -p $TOPDIR

rm -rf $TOPDIR/*
rm -rf MobiPerf

[ -d MobiPerf ] || \
    git clone -b master https://github.com/Mobiperf/MobiPerf.git 

pushd MobiPerf
    git checkout f9e8cd23b542cd04a7f0c412e6588d8ce884bb1a
popd

pushd MobiPerf/tcpserver
    ([ -f mlab/Uplink.jar ] && \
     [ -f mlab/Downlink.jar ] && \
     [ -f mlab/ServerConfig.jar ] ) || \
        ./compile.sh
    git show --quiet > $TOPDIR/version || :   # git returns non-zero here.
popd

mkdir -p $TOPDIR/mobiperf
cp -r MobiPerf/tcpserver/mlab/*  $TOPDIR/mobiperf/
install -D -m 0755 MobiPerf/tcpserver/initialize.sh $TOPDIR/init/initialize.sh
install -D -m 0755 MobiPerf/tcpserver/start.sh $TOPDIR/init/start.sh
install -D -m 0755 MobiPerf/tcpserver/stop.sh $TOPDIR/init/stop.sh

tar -C $TOPDIR -cvf michigan_1.tar .

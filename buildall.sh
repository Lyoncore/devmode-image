#!/bin/sh

TODAY=$(date +%Y%m%d)
MINOR_RELEASE=$1
PROJECT=$2
CHANNEL=$3

sudo ./build.sh $MINOR_RELEASE $PROJECT $CHANNEL && sudo ./hack-udf.sh $PROJECT-$TODAY-$MINOR_RELEASE.img

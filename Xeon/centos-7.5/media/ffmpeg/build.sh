#!/bin/bash -e

IMAGE="xeon-centos75-media-ffmpeg"
VERSION="1.2"
DIR=$(dirname $(readlink -f "$0"))

. "${DIR}/../../../../script/build.sh"

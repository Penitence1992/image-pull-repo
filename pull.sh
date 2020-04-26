#!/bin/bash


set -xue
ECHO_IMAGES=$IMAGES
IFS=' '
imgs=($ECHO_IMAGES)
for i in ${!imgs[@]} ; do
    echo "$i=>${imgs[i]}"
done
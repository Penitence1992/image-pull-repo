#!/bin/bash


set -xue
ECHO_IMAGES=$IMAGES
IFS=' '
imgs=($ECHO_IMAGES)
docker login -u="$USERNAME" -p="$PASSWORD"
for i in ${!imgs[@]} ; do
    echo "$i=>${imgs[i]}"
    docker pull ${imgs[i]}
    echo "${imgs[i]}" | sed -e 's|registry.gitlab.com/gitlab-org/build/cng|penitence|g' | xargs -i docker push {}
done
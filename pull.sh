#!/bin/bash
set -xue
ECHO_IMAGES=$IMAGES
IFS=' '
imgs=($ECHO_IMAGES)
startWith="quay.io/fluentd_elasticsearch"
docker login -u="$USERNAME" -p="$PASSWORD"
for i in ${!imgs[@]} ; do
    echo "$i=>${imgs[i]}"
    docker pull ${imgs[i]}
    fullname=$(echo "${imgs[i]}" | sed -e 's|${startWith}|penitence|g')
    docker tag ${imgs[i]} $fullname
    docker push $fullname
done
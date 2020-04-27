#!/bin/bash


set -xue
ECHO_IMAGES=$IMAGES
IFS=' '
imgs=($ECHO_IMAGES)
docker login -u="$USERNAME" -p="$PASSWORD" registry.cn-hangzhou.aliyuncs.com
for i in ${!imgs[@]} ; do
    echo "$i=>${imgs[i]}"
    docker pull ${imgs[i]}
    fullname=$(echo "${imgs[i]}" | sed -e 's|registry.gitlab.com/gitlab-org/build/cng|registry.cn-hangzhou.aliyuncs.com/penitence|g')
    docker tag ${imgs[i]} $fullname
    docker push $fullname
done
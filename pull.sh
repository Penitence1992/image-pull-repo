#!/bin/bash
set -xue
ECHO_IMAGES=$IMAGES
SYNC_HOST=$REGISTRY
SOURCE_NAME=$SOURCE_NAME
TARGET_NAME=$TARGET_NAME
# change image name $SOURCE_NAME/<image_name>:<tag> to $SYNC_HOST/$TARGET_NAME/<image_name>:<tag>
# eg registry.gitlab.com/gitlab-org/build/cng/abc:latest registry.cn-hangzhou.aliyuncs.com/penitence/abc:latest
IFS=' '
imgs=($ECHO_IMAGES)

if [ -z "$REGISTRY" ]; then
 echo "param REGISTRY must set"
 exit 1
fi

if [ ! -z "$USERNAME" ]; then
    docker login -u="$USERNAME" -p="$PASSWORD" $SYNC_HOST
fi

for i in ${!imgs[@]} ; do
    echo "$i=>${imgs[i]}"
    docker pull ${imgs[i]}
    fullname=$(echo "${imgs[i]}" | sed -e "s|$SOURCE_NAME|$SYNC_HOST/$TARGET_NAME|g")
    docker tag ${imgs[i]} $fullname
    docker push $fullname
done
#!/bin/bash

IMAGE_NAME=$1
DEPTH=$2


echo "About to show sizes of all layers in image=$IMAGE_NAME until Depth of $DEPTH"

LAYERS_PATHS=$(podman image inspect $IMAGE_NAME | jq .[0].GraphDriver.Data.LowerDir |  awk -F '"' '{print $2}' | awk '{ split($0,chars,":")
for (i=1 ; i <= length(chars); i++){
 printf("%s\n", chars[i])
}
}
')


echo $LAYERS_PATHS

for LAYER in $LAYERS_PATHS
do
LAYER_PATH=$(echo $LAYER | awk -F "/diff" '{print $1}')
echo "Showing Layer $LAYER_PATH File System and sizes:"
echo
du --all --max-depth=$DEPTH -h $LAYER
echo
done


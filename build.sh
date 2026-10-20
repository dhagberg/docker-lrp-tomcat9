#!/bin/bash
set -xe
PLAIN_NAME=lrp-u-tomcat9
HUB_NAME=dhagberg/$PLAIN_NAME
CI_NAME=cga-ci:5000/$PLAIN_NAME
export BUILDKIT_PROGRESS=plain

docker build --pull --progress=plain -t $HUB_NAME .

# Tag and push if given
if [ $# -ge 1 ]; then
  if [ "$1" = "push" ]; then
    docker push $HUB_NAME
    docker tag  $HUB_NAME $CI_NAME
    docker push $CI_NAME
  fi
fi

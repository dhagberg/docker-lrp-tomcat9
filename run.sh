#!/bin/bash
set -xe
exec docker run --rm -ti dhagberg/lrp-u-tomcat9 ${1+"$@"}

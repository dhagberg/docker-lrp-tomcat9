#!/bin/bash
set -xe
exec docker run --rm -ti dhagberg/lrp-tomcat9 ${1+"$@"}

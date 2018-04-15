#!/bin/bash
set -xe
exec docker run --rm -ti dhagberg/co811-tomcat7 ${1+"$@"}

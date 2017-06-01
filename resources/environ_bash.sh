#!/bin/bash

set -o allexport
source /tmp/environ
set +o allexport

#remove first parameter as fcron lauch this shell wrapper with the -c option
shift

exec "$@"
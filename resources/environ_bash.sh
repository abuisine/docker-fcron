#!/bin/bash

set -o allexport
source /tmp/environ
set +o allexport

exec /bin/bash "$@"

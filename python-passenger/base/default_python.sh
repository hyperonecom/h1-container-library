#!/bin/sh
if [ -f /data/env/bin/python ]; then
    exec /data/env/bin/python "$@"
else
    exec python "$@"
fi

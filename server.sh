#!/usr/bin/env sh

python3 -m http.server 1313 -d output &

./watch.sh

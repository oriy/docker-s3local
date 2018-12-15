#!/usr/bin/env bash
set -eo pipefail
shopt -s nullglob

fakes3=/usr/local/bin/fakes3
echo $fakes3 $@

exec $fakes3 $@ &
pid=$!

echo "initializing s3local"
./init_s3.sh

if ! kill -s TERM "$pid" || ! wait "$pid"; then
    echo >&2 's3local initialization failed'
    exit 1
fi

exec $fakes3 $@
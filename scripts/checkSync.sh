#!/bin/bash
PORT=$(cat /var/ton-work/db/config.json | grep port | awk  'FNR == 4 {print $3}'| tr -d ',')
TON_BUILD_DIR="/usr/bin/ton"
KEYS_DIR="/var/ton-work/keys"

TIME_DIFF=0

"${TON_BUILD_DIR}/validator-engine-console/validator-engine-console" \
    -a "127.0.0.1:$PORT"  \
    -k "${KEYS_DIR}/client" \
    -p "${KEYS_DIR}/server.pub" \
    -c "getstats" -c "quit"

for i in $("${TON_BUILD_DIR}/validator-engine-console/validator-engine-console" \
    -a "127.0.0.1:$PORT" \
    -k "${KEYS_DIR}/client" \
    -p "${KEYS_DIR}/server.pub" \
    -c "getstats" -c "quit" 2>&1 | grep time | awk '{print $2}'); do
    TIME_DIFF=$((i - TIME_DIFF))
done

echo "INFO: TIME_DIFF = ${TIME_DIFF}"

#!/bin/bash

# Arbitrary UIDs (eg: OpenShift) have no passwd entry, roswell segfaults without one
if ! whoami >/dev/null 2>&1 && [ -w /etc/passwd ]; then
  echo "sparql-parser:x:$(id -u):0::/root:/sbin/nologin" >> /etc/passwd
fi
export HOME=/root

mkdir -p /config
cp /config/*.lisp /app/config/ 2>/dev/null

exec /usr/src/startup.sh

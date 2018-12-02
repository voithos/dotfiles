#!/bin/bash

exec </dev/null >/tmp/setup-tablet.log 2>&1
set -x
cd /home/daisy/.setup-tablet || exit
su daisy -c "nohup bash -c '_unlock() { rm -f /tmp/setup-tablet.lock; }; trap _unlock EXIT; sleep 5; lockfile -r 0 /tmp/setup-tablet.lock || exit 1; /home/daisy/.setup-tablet/setup-tablet.sh; sleep 2' &"

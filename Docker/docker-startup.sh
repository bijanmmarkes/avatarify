#!/bin/bash

set -exu
# start the ssh daemon
/usr/sbin/sshd -D
# Run the avatarify
/bin/bash -x run.sh
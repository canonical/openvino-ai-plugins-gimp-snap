#!/bin/bash -e
# 
# Set non-root access to NPU device nodes.
#

if [ "${UID}" -ne 0 ]; then
  >&2 echo "
Please re-run the command with sudo:

sudo $(basename "${BASH_SOURCE[0]}")
  "
  exit 1
fi

usermod -a -G render ubuntu
# Newer versions of Ubuntu ship Udev rules which handle this,
# but 22.04 does not
chown root:render /dev/accel/accel0
chmod g+rw /dev/accel/accel0
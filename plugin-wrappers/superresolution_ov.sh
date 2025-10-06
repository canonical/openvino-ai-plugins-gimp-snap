#!/bin/bash

export GIMP_OPENVINO_CONFIG_PATH="${SNAP_USER_COMMON}"
export GIMP_OPENVINO_MODELS_PATH="${SNAP_USER_COMMON}"
CONTENT_PATH="${SNAP}/gimp-plugins/openvino-gimp"
export LD_LIBRARY_PATH="${CONTENT_PATH}/usr/lib/x86_64-linux-gnu":$LD_LIBRARY_PATH
export PATH="${PATH}":"${CONTENT_PATH}/usr/bin":"${CONTENT_PATH}/bin"
export PYTHONPATH="${CONTENT_PATH}/lib/python3.12/site-packages":"${CONTENT_PATH}/usr/lib/python3/dist-packages":"${PYTHONPATH}"
export OCL_ICD_VENDORS="${CONTENT_PATH}/etc/OpenCL/vendors"
weights_dir="${CONTENT_PATH}/weights"
python3 -c "from gimpopenvino import install_utils; install_utils.complete_install(repo_weights_dir=r'${weights_dir}')"

exec python3 $SNAP/gimp-plugins/superresolution_ov/superresolution_ov.py "$@"

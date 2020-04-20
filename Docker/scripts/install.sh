#!/usr/bin/env bash

# v4l2loopback
git submodule update --init
echo "--- Installing v4l2loopback"
cd v4l2loopback
make && make install
depmod -a
cd ../

source $(conda info --base)/etc/profile.d/conda.sh
conda create -y -n $CONDA_ENV_NAME python=3.8
conda activate $CONDA_ENV_NAME

pip install face-alignment pyfakewebcam

# FOMM
git submodule update --init
pip install -r fomm/requirements.txt
pip install requests

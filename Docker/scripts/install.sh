#!/usr/bin/env bash

source scripts/settings.sh

# v4l2loopback
<<<<<<< HEAD
apt install v4l2loopback-dkms
=======
sudo apt install v4l2loopback-dkms
>>>>>>> initial dockerifle with python, conda, repo cloning, and install/startup scripts.

source $(conda info --base)/etc/profile.d/conda.sh
conda create -y -n $CONDA_ENV_NAME python=3.8
conda activate $CONDA_ENV_NAME

pip install face-alignment pyfakewebcam

# FOMM
git clone https://github.com/alievk/first-order-model.git fomm
pip install -r fomm/requirements.txt
pip install requests

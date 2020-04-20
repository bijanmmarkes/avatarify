#!/usr/bin/env bash

source settings.sh

pip install face-alignment pyfakewebcam

# FOMM
git submodule update --init
pip install -r fomm/requirements.txt
pip install requests

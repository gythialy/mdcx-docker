#!/bin/bash

if [[ ! -e "/app/config.ini" ]]; then
    cp -r "/app/config.sample.ini" "/app/config.ini"
fi

export APP_VERSION="$(cat /app/version)"
export DOCKER_IMAGE_VERSION="v1.0.$(cat /app/version)"

python3.9 /app/MDCx_Main.py

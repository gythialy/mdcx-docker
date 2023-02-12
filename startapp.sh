#!/bin/bash

if [[ ! -e "/app/config.ini" ]]; then
    cp -r "/app/config.sample.ini" "/app/config.ini"
fi

python3.9 /app/MDCx_Main.py

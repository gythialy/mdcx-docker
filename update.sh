#!/bin/bash

LIBS=(jq curl unrar find)
MDCX_FILE="mdcx.rar"
MDCX_PREFIX="MDCx-py-"
UPDATE_FLAG=true

rm -rf app

for b in ${LIBS[@]}; do
  if ! which $b >/dev/null; then
    if $UPDATE_FLAG; then
      sudo apt update -y
      UPDATE_FLAG=false
    fi
    sudo apt-get install -y $b
    echo "install $b"
  fi
done

assets_url=$(curl -s https://api.github.com/repos/anyabc/something/releases/latest | jq -r '.assets[].browser_download_url' | grep $MDCX_PREFIX)

echo "downloading $MDCX_FILE from $assets_url"

curl -L $assets_url -o $MDCX_FILE && unrar x -y -inul $MDCX_FILE && mv $(find . -type d -iname "${MDCX_PREFIX}*" | sort -V | tail -n1) app && rm -rf $MDCX_FILE

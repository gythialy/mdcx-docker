#!/bin/bash

LIBS=(jq curl unrar find)
MDCX_FILE="mdcx.rar"
MDCX_PREFIX="MDCx-py-"
VERSION_FILE="app/version"
UPDATE_FLAG=true

rm -rf app

for b in "${LIBS[@]}"; do
  if ! which "$b" >/dev/null; then
    if $UPDATE_FLAG; then
      sudo apt update -y
      UPDATE_FLAG=false
    fi
    sudo apt-get install -y "$b"
    echo "install $b"
  fi
done

assets_url=$(curl -s https://api.github.com/repos/anyabc/something/releases/latest | jq -r '.assets[].browser_download_url' | grep $MDCX_PREFIX)

echo "downloading $MDCX_FILE from $assets_url"

curl -L "$assets_url" -o $MDCX_FILE && unrar x -y -inul $MDCX_FILE

extract_file="$(find . -type d -iname "${MDCX_PREFIX}*")" && echo "file: $extract_file"

mv "${extract_file}" app && ls -al

[[ ! -e "${VERSION_FILE}" ]] || touch "${VERSION_FILE}"

echo -e "$(echo "$extract_file" | cut -d'-' -f 3)" > "${VERSION_FILE}"

rm -rf ${MDCX_FILE}

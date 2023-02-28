#!/bin/bash

LIBS=(jq curl unrar find)
MDCX_FILE="mdcx.rar"
MDCX_PREFIX="MDCx-py-"
VERSION_FILE="app/version"
UPDATE_FLAG=true
APP_DIR="app"
rm -rf "${APP_DIR}"

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

ASSET_URL=$(curl -fsSL https://api.github.com/repos/anyabc/something/releases/latest | jq -r --arg name "${MDCX_PREFIX}" '.assets[] | select(.name | startswith($name)).browser_download_url')

echo "downloading $MDCX_FILE from $ASSET_URL"

curl -fsSL "$ASSET_URL" -o $MDCX_FILE && unrar x -y -inul $MDCX_FILE

EXTRACT_FILE="$(find . -type d -iname "${MDCX_PREFIX}*")" 
mv "${EXTRACT_FILE}" ${APP_DIR}
MDCX_VERSION="$(echo "$EXTRACT_FILE" | cut -d'-' -f 3)"

echo "find file: $EXTRACT_FILE, version: $MDCX_VERSION"

[[ ! -f "${VERSION_FILE}" ]] || touch "${VERSION_FILE}"

echo -e "${MDCX_VERSION}" >"${VERSION_FILE}"
echo -e "${MDCX_VERSION}" >"version"

git diff --quiet --exit-code
[[ $? -ne 0 ]] && IS_CHANGED='true' || IS_CHANGED='false'

echo "is_changed=${IS_CHANGED}" >>$GITHUB_OUTPUT
echo "tag=v1.0.${MDCX_VERSION}" >>$GITHUB_OUTPUT

rm -rf ${MDCX_FILE}

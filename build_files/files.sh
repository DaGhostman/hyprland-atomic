#!/usr/bin/bash
set -ouex pipefail

readarray -t COPIABLE_FILES < <(jq -r "[(.all.copy | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
    (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".copy | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
    | to_entries[] | (select(.value != null).value | to_entries[] | \"\(.key) \(.value)\")" /ctx/files.json)


if [[ "${#COPIABLE_FILES[@]}" -gt 0 ]]; then
    echo -e "Copying ${#COMPATIBLE_FILES[@]}..."
    cp -frL /ctx/${#COMPIABLE_FILES[@]}
    echo -e "DONE\n"
fi

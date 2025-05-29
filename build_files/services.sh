#!/usr/bin/bash
set -ouex pipefail

readarray -t ENABLED_SERVICES < <(jq -r "[(.all.enable, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\".enable)[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".enable | (.all.enable, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\".enable)[])] \
                             | sort | unique[]" /ctx/services.json)

if [[ "${#ENABLED_SERVICES[@]}" -gt 0 ]]; then
    systemctl enable ${ENABLED_SERVICES[@]}
fi


readarray -t DISABLED_SERVICES < <(jq -r "[(.all.disable, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\".disable)[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".disable | (.all.disable, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\".disable)[])] \
                             | sort | unique[]" /ctx/services.json)

if [[ "${#DISABLED_SERVICES[@]}" -gt 0 ]]; then
    systemctl disable ${DISABLED_SERVICES[@]}
fi

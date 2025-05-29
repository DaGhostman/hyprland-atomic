#!/usr/bin/bash
set -ouex pipefail

readarray -t ENABLED_SERVICES < <(jq -r "[(.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".enable | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
                             | sort | unique[]" /ctx/services.json)

if [[ "${#ENABLED_SERVICES}" -gt 0 ]]; then
    systemctl enable ${ENABLED_SERVICES}
fi


readarray -t DISABLED_SERVICES < <(jq -r "[(.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".disable | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
                             | sort | unique[]" /ctx/services.json)

if [[ "${#DISABLED_SERVICES}" -gt 0 ]]; then
    systemctl disable ${DISABLED_SERVICES}
fi

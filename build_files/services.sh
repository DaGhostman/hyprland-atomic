#!/usr/bin/bash
set -ouex pipefail

readarray -t ENABLED_SERVICES < <(jq -r "[(.all.enable, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\".enable)[], \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".enable | (.all.enable, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\".enable)[])] \
                             | sort | unique[]" /ctx/services.json)

if [[ "${#ENABLED_SERVICES[@]}" -gt 0 ]]; then
    systemctl enable --now ${ENABLED_SERVICES[@]}
fi


readarray -t DISABLED_SERVICES < <(jq -r "[(.all.disable, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\".disable)[], \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".disable | (.all.disable, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\".disable)[])] \
                             | sort | unique[]" /ctx/services.json)

if [[ "${#DISABLED_SERVICES[@]}" -gt 0 ]]; then
    systemctl disable --now ${DISABLED_SERVICES[@]}
fi


readarray -t ENABLED_SERVICES < <(jq -r "[(.user.all.enable, select(.user.\"$IMAGE_NAME\" != null).user.\"$IMAGE_NAME\".enable)[], \
                             (select(.user.\"$FEDORA_MAJOR_VERSION\" != null).user.\"$FEDORA_MAJOR_VERSION\".enable | (.user.all.enable, select(.user.\"$IMAGE_NAME\" != null).user.\"$IMAGE_NAME\".enable)[])] \
                             | sort | unique[]" /ctx/services.json)

if [[ "${#ENABLED_SERVICES[@]}" -gt 0 ]]; then
    systemctl enable --user --now ${ENABLED_SERVICES[@]}
fi


readarray -t DISABLED_SERVICES < <(jq -r "[(.user.all.disable, select(.user.\"$IMAGE_NAME\" != null).user.\"$IMAGE_NAME\".disable)[], \
                             (select(.user.\"$FEDORA_MAJOR_VERSION\" != null).user.\"$FEDORA_MAJOR_VERSION\".disable | (.user.all.disable, select(.user.\"$IMAGE_NAME\" != null).user.\"$IMAGE_NAME\".disable)[])] \
                             | sort | unique[]" /ctx/services.json)

if [[ "${#DISABLED_SERVICES[@]}" -gt 0 ]]; then
    systemctl disable --user --now ${DISABLED_SERVICES[@]}
fi

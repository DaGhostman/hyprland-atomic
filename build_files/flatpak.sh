#!/usr/bin/bash
set -ouex pipefail

if [[ -z $(which flatpak) ]]; then
    echo -e "Flatpak is not installed, skipping flatpack packages"
    exit 0
fi

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

readarray -t INCLUDED_FLATPAKS < <(jq -r "[(.all.include | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".include | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
                             | sort | unique[]" /ctx/flatpak.json)

# Install Packages
if [[ "${#INCLUDED_FLATPAKS[@]}" -gt 0 ]]; then
    flatpak install -y flathub \
        "${INCLUDED_FLATPAKS[@]}"
else
    echo "No flatpak packages to install."

fi


readarray -t EXCLUDED_FLATPAKS < <(jq -r "[(.all.exclude | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".exclude | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
                             | sort | unique[]" /ctx/flatpak.json)

if [[ "${#EXCLUDED_FLATPAKS[@]}" -gt 0 ]]; then
    flatpak remove --assymeyes \
        "${EXCLUDED_FLATPAKS[@]}"
else
    echo "No flatpak packages to remove."
fi



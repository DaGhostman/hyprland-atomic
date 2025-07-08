#!/usr/bin/bash
set -ouex pipefail

readarray -t PATCHES < <(jq -r "[(.all | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\" | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
                             | sort | unique[]" /ctx/patches.json)

readarray -t INCLUDED_PACKAGES < <(jq -r "[(.all.include | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".include | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
                             | sort | unique[]" /ctx/packages.json)
# Install Packages
if [[ "${#INCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    dnf5 -yq install \
        "${INCLUDED_PACKAGES[@]}"
else
    echo "No packages to install."

fi

# build list of all packages requested for exclusion
readarray -t EXCLUDED_PACKAGES < <(jq -r "[(.all.exclude | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".exclude | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
                             | sort | unique[]" /ctx/packages.json)

if [[ "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    readarray -t EXCLUDED_PACKAGES < <(rpm -qa --queryformat='%{NAME}\n' "${EXCLUDED_PACKAGES[@]}")
fi

# remove any excluded packages which are still present on image
if [[ "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    dnf5 -y remove \
        "${EXCLUDED_PACKAGES[@]}"
else
    echo "No packages to remove."
fi


readarray -t SWAPPED_PACKAGES < <(jq -r "[(.all.swap | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".swap | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\"))] \
                             | to_entries[] | (select(.value != null).value | to_entries[] | \"\(.key) \(.value)\")" /ctx/packages.json)


if [[ "${#PATCHES[@]}" -gt 0 ]]; then

    sudo dnf upgrade --enablerepo=updates-testing --refresh --advisory=$(join , "${PATCHES[@]}") -y
else
    echo "No patches to apply"
fi


# Swap Packages
if [[ "${#SWAPPED_PACKAGES[@]}" -gt 0 ]]; then
    for ((i=0; i<${#SWAPPED_PACKAGES[@]}; i++)); do
        packages="${SWAPPED_PACKAGES[i]}"

        dnf5 -y swap ${packages}
    done

else
    echo "No packages to swap."

fi

# jq -r "[(.all.swap | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")), (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".swap | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\"))] to_entries[] | .value | to_entries[] | \"(.key) (.value)\"" /ctx/packages.json

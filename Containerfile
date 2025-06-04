ARG IMAGE_NAME="${IMAGE_NAME}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"
ARG BASE_IMAGE="${BASE_IMAGE}"

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /
COPY sys_files /sys_files
COPY packages.json /
COPY flatpak.json /
COPY services.json /

# Base Image
FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION}

ARG IMAGE_NAME="${IMAGE_NAME}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"


### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    /ctx/build.sh && \
    /ctx/packages.sh && \
    /ctx/flatpak.sh && \
    /ctx/configure.sh && \
    /ctx/services.sh && \
    /ctx/workarounds.sh && \
    /ctx/customization.sh && \
    /ctx/initramfs.sh && \
    /ctx/post-install.sh && \
    ostree container commit
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint --no-truncate

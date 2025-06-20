# Hyprland Atomic
Available both here in GHCR and on [Quay.io](https://quay.io/repository/ddimitrov/hyprland-atomic). Note that GH has some download speed limits and the images are quite large and might not eexactly be beneficial to use, but at the same time it is the most raw build, as quay gets rechunked image for convenience during updates and doesn't seem to have a speed limit or if it does it is higher than the one of github (YMMV)

# Purpose
This repository is my take on a more or less minimal Fedora Atomic install that comes with Hyprland and some configurations for it, as well as some relatively minimal customizations(a couple of aliases, some extra packages, cursor theme, wallpaper-rotation service), that I think bring enough of the typical desktop experience that we get from other DEs but without the initial struggle to get all the configurations one might want.


# How to
1. Download an installer.iso for here:
    - AMD - some AMD-specific changes
    - INTEL - Some INTEL-specific changes
    - NVIDIA - Should have NVIDIA-specific changes, but I don't own NVIDIA hardware so consider this unstable
    - BASE - Without any modifications, related to replacing core packages (no replacements used)

2. Follow the installer
Since there might be some issues getting the installer to start graphically, you either have to <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>F2</kbd> or reboot and try again until the GUI loads and works properly (unfortunatly this is an issue with the installer itself).

3. Login and open a terminal <kbd>Super</kbd> + <kbd>Enter</kbd>
Then you should be able to do `atomic target` in order to setup the correct remote from which to fetch updates. Or manually `sudo bootc switch --apply quay.io/ddimitrov/hyprland-atomic:{{version}}-{{variant}}` and after the reboot you should be able to do `rpm-ostree update` without any errors. (This ideally should be set by the installer, but it seems it is not the case for some reason and the container location points to local filesystem, which ... there is no way to get updates to)

4. Then if all is good, you could do <kbd>Super</kbd> + <kbd>b</kbd> to open your browser and you could start from there.

There are some nicesities hidden inside the `atomic` command, which will enable spotlight wallpapers, copy default configurations for some things, toggle auto-opdates on or off, install brew and flatpak packages, with the idea to have many more to come in the near future without them being too intrusive and get in the way.


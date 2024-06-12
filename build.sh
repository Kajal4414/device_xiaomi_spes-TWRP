#!/bin/bash
# For Gitpod Workspace

# Build Environment
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install gperf gcc-multilib gcc-10-multilib g++-multilib g++-10-multilib libc6-dev lib32ncurses5-dev x11proto-core-dev libx11-dev tree lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc bc ccache lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libwxgtk3.0-gtk3-dev libxml2 lzop pngcrush schedtool squashfs-tools imagemagick libbz2-dev lzma ncftp qemu-user-static libstdc++-10-dev libncurses5 python3

# Install Repo
mkdir ~/bin && curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo && sudo ln -sf ~/bin/repo /usr/bin/repo

# Initialize Repo
mkdir workspace && cd workspace
git config user.name "Sakshi Aggarwal"
git config user.email "81718060+sakshiagrwal@users.noreply.github.com"
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1

# Repo Sync
repo sync -j$(nproc --all) --force-sync

# Sync Device Source
git clone -b twrp-12.1 --depth=1 https://github.com/sakshiagrwal/device_xiaomi_spes-TWRP.git device/xiaomi/spes
git clone -b twrp-12.1 --depth=1 https://github.com/PixelExperience-Devices/kernel_xiaomi_sm6225.git kernel/xiaomi/spes

# Build Start
source build/envsetup.sh
lunch twrp_spes-eng && make clean && make bootimage -j$(nproc --all)

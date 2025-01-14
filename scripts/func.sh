#!/usr/bin/env bash
#
# Copyright (C) 2024 AuxXxilium <https://github.com/AuxXxilium>
# 
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Get latest Arc
# $1 path
function getArcSystem() {
  echo "Getting ArcSystem begin"
  local DEST_PATH="${1}"
  local RELEASE="${2}"
  local CACHE_FILE="/tmp/system.zip"
  rm -f "${CACHE_FILE}"
  if [ "${RELEASE}" = "dev" ]; then
    local TAG="$(curl -m 10 -skL "https://api.github.com/repos/AuxXxilium/arc-system/releases" | jq -r ".[].tag_name" | grep "dev" | sort -rV | head -1)"
  else
    local TAG="$(curl -m 10 -skL "https://api.github.com/repos/AuxXxilium/arc-system/releases" | jq -r ".[].tag_name" | grep -v "dev" | sort -rV | head -1)"
  fi
  if curl -skL "https://github.com/AuxXxilium/arc-system/releases/download/${TAG}/system-${TAG}.zip" -o "${CACHE_FILE}"; then
    # Unzip LKMs
    mkdir -p "${DEST_PATH}"
    unzip -o "${CACHE_FILE}" -d "${DEST_PATH}"
    rm -f "${CACHE_FILE}"
    echo "Getting ArcSystem end - ${TAG}"
  else
    echo "Failed to get ArcSystem"
    exit 1
  fi
}

# Get latest LKMs
# $1 path
function getLKMs() {
  echo "Getting LKMs begin"
  local DEST_PATH="${1}"
  local CACHE_FILE="/tmp/rp-lkms.zip"
  rm -f "${CACHE_FILE}"
  TAG="$(curl -s "https://api.github.com/repos/AuxXxilium/arc-lkm/releases/latest" | grep -oP '"tag_name": "\K(.*)(?=")')"
  if curl -skL "https://github.com/AuxXxilium/arc-lkm/releases/download/${TAG}/rp-lkms.zip" -o "${CACHE_FILE}"; then
    # Unzip LKMs
    rm -rf "${DEST_PATH}"
    mkdir -p "${DEST_PATH}"
    unzip -o "${CACHE_FILE}" -d "${DEST_PATH}"
    rm -f "${CACHE_FILE}"
    echo "Getting LKMs end - ${TAG}"
  else
    echo "Failed to get LKMs"
    exit 1
  fi
}

# Get latest Addons
# $1 path
function getAddons() {
  echo "Getting Addons begin"
  local DEST_PATH="${1}"
  local CACHE_DIR="/tmp/addons"
  local CACHE_FILE="/tmp/addons.zip"
  TAG="$(curl -s https://api.github.com/repos/AuxXxilium/arc-addons/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  if curl -skL "https://github.com/AuxXxilium/arc-addons/releases/download/${TAG}/addons-${TAG}.zip" -o "${CACHE_FILE}"; then
    # Unzip Addons
    rm -rf "${CACHE_DIR}"
    mkdir -p "${CACHE_DIR}"
    mkdir -p "${DEST_PATH}"
    unzip -o "${CACHE_FILE}" -d "${CACHE_DIR}"
    echo "Installing Addons to ${DEST_PATH}"
    [ -f /tmp/addons/VERSION ] && cp -f /tmp/addons/VERSION ${DEST_PATH}/
    for PKG in $(ls ${CACHE_DIR}/*.addon); do
      ADDON=$(basename "${PKG}" .addon)
      mkdir -p "${DEST_PATH}/${ADDON}"
      echo "Extracting ${PKG} to ${DEST_PATH}/${ADDON}"
      tar -xaf "${PKG}" -C "${DEST_PATH}/${ADDON}"
    done
    rm -f "${CACHE_FILE}"
    echo "Getting Addons end - ${TAG}"
  else
    echo "Failed to get Addons"
    exit 1
  fi
}

# Get latest Modules
# $1 path
function getModules() {
  echo "Getting Modules begin"
  local DEST_PATH="${1}"
  local CACHE_FILE="/tmp/modules.zip"
  rm -f "${CACHE_FILE}"
  TAG="$(curl -s https://api.github.com/repos/AuxXxilium/arc-modules/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  if curl -skL "https://github.com/AuxXxilium/arc-modules/releases/download/${TAG}/modules-${TAG}.zip" -o "${CACHE_FILE}"; then
    # Unzip Modules
    rm -rf "${DEST_PATH}"
    mkdir -p "${DEST_PATH}"
    unzip -o "${CACHE_FILE}" -d "${DEST_PATH}"
    echo "Getting Modules end - ${TAG}"
  else
    echo "Failed to get Modules"
    exit 1
  fi
}

# Get latest Configs
# $1 path
function getConfigs() {
  echo "Getting Configs begin"
  local DEST_PATH="${1}"
  local CACHE_FILE="/tmp/configs.zip"
  rm -f "${CACHE_FILE}"
  TAG="$(curl -s https://api.github.com/repos/AuxXxilium/arc-configs/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  if curl -skL "https://github.com/AuxXxilium/arc-configs/releases/download/${TAG}/configs-${TAG}.zip" -o "${CACHE_FILE}"; then
    # Unzip Configs
    rm -rf "${DEST_PATH}"
    mkdir -p "${DEST_PATH}"
    unzip -o "${CACHE_FILE}" -d "${DEST_PATH}"
    rm -f "${CACHE_FILE}"
    echo "Getting Configs end - ${TAG}"
  else
    echo "Failed to get Configs"
    exit 1
  fi
}

# Get latest Patches
# $1 path
function getPatches() {
  echo "Getting Patches begin"
  local DEST_PATH="${1}"
  local CACHE_FILE="/tmp/patches.zip"
  rm -f "${CACHE_FILE}"
  TAG="$(curl -s https://api.github.com/repos/AuxXxilium/arc-patches/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  if curl -skL "https://github.com/AuxXxilium/arc-patches/releases/download/${TAG}/patches-${TAG}.zip" -o "${CACHE_FILE}"; then
    # Unzip Patches
    rm -rf "${DEST_PATH}"
    mkdir -p "${DEST_PATH}"
    unzip -o "${CACHE_FILE}" -d "${DEST_PATH}"
    rm -f "${CACHE_FILE}"
    echo "Getting Patches end - ${TAG}"
  else
    echo "Failed to get Patches"
    exit 1
  fi
}

# Get latest Custom
# $1 path
function getCustom() {
  echo "Getting Custom begin"
  local DEST_PATH="${1}"
  local CACHE_FILE="/tmp/custom.zip"
  rm -f "${CACHE_FILE}"
  TAG="$(curl -s https://api.github.com/repos/AuxXxilium/arc-custom/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  if curl -skL "https://github.com/AuxXxilium/arc-custom/releases/download/${TAG}/custom-${TAG}.zip" -o "${CACHE_FILE}"; then
    # Unzip Custom
    rm -rf "${DEST_PATH}"
    mkdir -p "${DEST_PATH}"
    unzip -o "${CACHE_FILE}" -d "${DEST_PATH}"
    rm -f "${CACHE_FILE}"
    echo "Getting Custom end - ${TAG}"
  else
    echo "Failed to get Custom"
    exit 1
  fi
}

# Get latest Theme
# $1 path
function getTheme() {
  echo "Getting Theme begin"
  local DEST_PATH="${1}"
  local CACHE_FILE="/tmp/theme.zip"
  rm -f "${CACHE_FILE}"
  TAG="$(curl -s https://api.github.com/repos/AuxXxilium/arc-theme/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  if curl -skL "https://github.com/AuxXxilium/arc-theme/releases/download/${TAG}/arc-theme-${TAG}.zip" -o "${CACHE_FILE}"; then
    # Unzip Theme
    mkdir -p "${DEST_PATH}"
    unzip -o "${CACHE_FILE}" -d "${DEST_PATH}"
    rm -f "${CACHE_FILE}"
    echo "Getting Theme end - ${TAG}"
  else
    echo "Failed to get Theme"
    exit 1
  fi
}

# Get latest Buildroot-X
# $1 path
function getBuildrootx() {
  echo "Getting Buildroot-X begin"
  local DEST_PATH="${1}"

  TAG="$(curl -s https://api.github.com/repos/AuxXxilium/arc-buildroot-x/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  [ ! -d "${DEST_PATH}" ] && mkdir -p "${DEST_PATH}"
  echo "Getting Kernel"
  rm -f "${DEST_PATH}/bzImage-arc"
  if curl -skL "https://github.com/AuxXxilium/arc-buildroot-x/releases/download/${TAG}/bzImage" -o "${DEST_PATH}/bzImage-arc"; then
    echo "Kernel: ${TAG}"
  else
    echo "Failed to get Kernel"
    exit 1
  fi
  echo "Getting Ramdisk"
  rm -f "${DEST_PATH}/initrd-arc"
  if curl -skL "https://github.com/AuxXxilium/arc-buildroot-x/releases/download/${TAG}/rootfs.cpio.xz" -o "${DEST_PATH}/initrd-arc"; then
    echo "Ramdisk: ${TAG}"
  else
    echo "Failed to get Ramdisk"
    exit 1
  fi
}

# Get latest Buildroot-X
# $1 path
function getBuildroots() {
  echo "Getting Buildroot-S begin"
  local DEST_PATH="${1}"

  TAG="$(curl -s https://api.github.com/repos/AuxXxilium/arc-buildroot-s/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')"
  [ ! -d "${DEST_PATH}" ] && mkdir -p "${DEST_PATH}"
  echo "Getting Kernel"
  rm -f "${DEST_PATH}/bzImage-arc"
  if curl -skL "https://github.com/AuxXxilium/arc-buildroot-s/releases/download/${TAG}/bzImage" -o "${DEST_PATH}/bzImage-arc"; then
    echo "Kernel: ${TAG}"
  else
    echo "Failed to get Kernel"
    exit 1
  fi
  echo "Getting Ramdisk"
  rm -f "${DEST_PATH}/initrd-arc"
  if curl -skL "https://github.com/AuxXxilium/arc-buildroot-s/releases/download/${TAG}/rootfs.cpio.xz" -o "${DEST_PATH}/initrd-arc"; then
    echo "Ramdisk: ${TAG}"
  else
    echo "Failed to get Ramdisk"
    exit 1
  fi
}

# Get latest Offline
# $1 path
function getOffline() {
  echo "Getting Offline begin"
  local DEST_PATH="${1}"

  [ ! -d "${DEST_PATH}" ] && mkdir -p "${DEST_PATH}"
  rm -f "${DEST_PATH}/offline.json"
  if curl -skL "https://autoupdate.synology.com/os/v2" -o "${DEST_PATH}/offline.json"; then
    echo "Getting Offline end"
  else
    echo "Failed to get Offline"
    exit 1
  fi
}

# repack initrd
# $1 initrd file  
# $2 plugin path
# $3 output file
function repackInitrd() {
  INITRD_FILE="${1}"
  PLUGIN_PATH="${2}"
  OUTPUT_PATH="${3:-${INITRD_FILE}}"

  [ -z "${INITRD_FILE}" ] || [ ! -f "${INITRD_FILE}" ] && exit 1
  [ -z "${PLUGIN_PATH}" ] || [ ! -d "${PLUGIN_PATH}" ] && exit 1
  
  INITRD_FILE="$(readlink -f "${INITRD_FILE}")"
  PLUGIN_PATH="$(readlink -f "${PLUGIN_PATH}")"
  OUTPUT_PATH="$(readlink -f "${OUTPUT_PATH}")"

  RDXZ_PATH="rdxz_tmp"
  mkdir -p "${RDXZ_PATH}"
  (
    cd "${RDXZ_PATH}"
    sudo xz -dc <"${INITRD_FILE}" | sudo cpio -idm
  ) || true
  sudo cp -Rf "${PLUGIN_PATH}/"* "${RDXZ_PATH}/"
  [ -f "${OUTPUT_PATH}" ] && rm -rf "${OUTPUT_PATH}"
  (
    cd "${RDXZ_PATH}"
    sudo find . 2>/dev/null | sudo cpio -o -H newc -R root:root | xz -9 --check=crc32 >"${OUTPUT_PATH}"
  ) || true
  sudo rm -rf "${RDXZ_PATH}"
}

# resizeimg
# $1 input file  
# $2 changsize MB eg: +50M -50M
# $3 output file
function resizeImg() {
  INPUT_FILE="${1}"
  CHANGE_SIZE="${2}"
  OUTPUT_FILE="${3:-${INPUT_FILE}}"

  [[ -z "${INPUT_FILE}" || ! -f "${INPUT_FILE}" ]] && exit 1
  [ -z "${CHANGE_SIZE}" ] && exit 1

  INPUT_FILE="$(readlink -f "${INPUT_FILE}")"
  OUTPUT_FILE="$(readlink -f "${OUTPUT_FILE}")"


  SIZE=$(($(du -m "${INPUT_FILE}" | awk '{print $1}')$(echo "${CHANGE_SIZE}" | sed 's/M//g; s/b//g')))
  [[ -z "${SIZE}" || "${SIZE}" -lt 0 ]] && exit 1

  if [ ! "${INPUT_FILE}" = "${OUTPUT_FILE}" ]; then
    sudo cp -f "${INPUT_FILE}" "${OUTPUT_FILE}"
  fi

  sudo truncate -s ${SIZE}M "${OUTPUT_FILE}"
  echo -e "d\n\nn\n\n\n\n\nn\nw" | sudo fdisk "${OUTPUT_FILE}"
  LOOPX=$(sudo losetup -f)
  sudo losetup -P ${LOOPX} "${OUTPUT_FILE}"
  sudo e2fsck -fp $(ls ${LOOPX}* | sort -n | tail -1)
  sudo resize2fs $(ls ${LOOPX}* | sort -n | tail -1)
  sudo losetup -d ${LOOPX}
}

# convertova
# $1 bootloader file
# $2 ova file
function convertova() {
  BLIMAGE=${1}
  OVAPATH=${2}

  BLIMAGE="$(readlink -f "${BLIMAGE}")"
  OVAPATH="$(readlink -f "${OVAPATH}")"
  VMNAME="$(basename "${OVAPATH}" .ova)"

  # Download and install ovftool if it doesn't exist
  if [ ! -x ovftool/ovftool ]; then
    rm -rf ovftool ovftool.zip
    curl -skL https://github.com/rgl/ovftool-binaries/raw/main/archive/VMware-ovftool-4.6.0-21452615-lin.x86_64.zip -o ovftool.zip
    if [ $? -ne 0 ]; then
      echo "Failed to download ovftool"
      exit 1
    fi
    unzip ovftool.zip -d . >/dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "Failed to extract ovftool"
      exit 1
    fi
    chmod +x ovftool/ovftool
  fi
  if ! command -v qemu-img &>/dev/null; then
    sudo apt install -y qemu-utils
  fi

  # Convert raw image to VMDK
  rm -rf "OVA_${VMNAME}"
  mkdir -p "OVA_${VMNAME}"
  qemu-img convert -O vmdk -o 'adapter_type=lsilogic,subformat=streamOptimized,compat6' "${BLIMAGE}" "OVA_${VMNAME}/${VMNAME}-disk1.vmdk"
  qemu-img create -f vmdk "OVA_${VMNAME}/${VMNAME}-disk2.vmdk" "32G"

  # Create VM configuration
  cat <<_EOF_ >"OVA_${VMNAME}/${VMNAME}.vmx"
.encoding = "UTF-8"
config.version = "8"
virtualHW.version = "21"
displayName = "${VMNAME}"
annotation = "https://github.com/AuxXxilium/arc"
guestOS = "ubuntu-64"
firmware = "efi"
mks.enable3d = "TRUE"
pciBridge0.present = "TRUE"
pciBridge4.present = "TRUE"
pciBridge4.virtualDev = "pcieRootPort"
pciBridge4.functions = "8"
pciBridge5.present = "TRUE"
pciBridge5.virtualDev = "pcieRootPort"
pciBridge5.functions = "8"
pciBridge6.present = "TRUE"
pciBridge6.virtualDev = "pcieRootPort"
pciBridge6.functions = "8"
pciBridge7.present = "TRUE"
pciBridge7.virtualDev = "pcieRootPort"
pciBridge7.functions = "8"
vmci0.present = "TRUE"
hpet0.present = "TRUE"
nvram = "${VMNAME}.nvram"
virtualHW.productCompatibility = "hosted"
powerType.powerOff = "soft"
powerType.powerOn = "soft"
powerType.suspend = "soft"
powerType.reset = "soft"
tools.syncTime = "FALSE"
sound.autoDetect = "TRUE"
sound.fileName = "-1"
sound.present = "TRUE"
numvcpus = "2"
cpuid.coresPerSocket = "1"
vcpu.hotadd = "TRUE"
memsize = "4096"
mem.hotadd = "TRUE"
usb.present = "TRUE"
ehci.present = "TRUE"
usb_xhci.present = "TRUE"
svga.graphicsMemoryKB = "8388608"
usb.vbluetooth.startConnected = "TRUE"
extendedConfigFile = "${VMNAME}.vmxf"
floppy0.present = "FALSE"
ethernet0.addressType = "generated"
ethernet0.virtualDev = "vmxnet3"
ethernet0.connectionType = "nat"
ethernet0.allowguestconnectioncontrol = "true"
ethernet0.present = "TRUE"
sata0.present = "TRUE"
sata0:0.fileName = "${VMNAME}-disk1.vmdk"
sata0:0.present = "TRUE"
sata0:1.fileName = "${VMNAME}-disk2.vmdk"
sata0:1.present = "TRUE"
_EOF_

  rm -f "${OVAPATH}"
  ovftool/ovftool "OVA_${VMNAME}/${VMNAME}.vmx" "${OVAPATH}"
  rm -rf "OVA_${VMNAME}"
}

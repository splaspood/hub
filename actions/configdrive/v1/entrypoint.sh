#!/bin/sh
set -o xtrace
LABEL=config-2
sgdisk --move-second-header --new 0:-256M:0 --typecode 0:0700 --change-name "0:${LABEL}" "${DEST_DISK:?}"
partprobe
#mkdosfs -F 32 -n "${LABEL}" "/dev/disk/by-partlabel/${LABEL}"
PARTITION=$(sgdisk -p "${DEST_DISK:?}" | grep "${LABEL}" | awk '{print $1}')
mkdosfs -F 32 -n "${LABEL}" "${DEST_DISK:?}${PARTITION}"

# mount the configdrive

# fetch metadata from hegel

# write out configdrive format files based on metadata

# unmount configrive

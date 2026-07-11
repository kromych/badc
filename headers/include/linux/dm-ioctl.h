// linux/dm-ioctl.h -- a subset of the device-mapper uapi header: the command
// enumeration and the DM_MPATH_PROBE_PATHS ioctl. struct dm_ioctl and the
// struct-based ioctls are not bundled; consumers here use only the probe.

#pragma once

#ifdef __linux__

#include <linux/ioctl.h>

enum {
    DM_VERSION_CMD = 0,
    DM_REMOVE_ALL_CMD,
    DM_LIST_DEVICES_CMD,
    DM_DEV_CREATE_CMD,
    DM_DEV_REMOVE_CMD,
    DM_DEV_RENAME_CMD,
    DM_DEV_SUSPEND_CMD,
    DM_DEV_STATUS_CMD,
    DM_DEV_WAIT_CMD,
    DM_TABLE_LOAD_CMD,
    DM_TABLE_CLEAR_CMD,
    DM_TABLE_DEPS_CMD,
    DM_TABLE_STATUS_CMD,
    DM_LIST_VERSIONS_CMD,
    DM_TARGET_MSG_CMD,
    DM_DEV_SET_GEOMETRY_CMD,
    DM_DEV_ARM_POLL_CMD,
    DM_GET_TARGET_VERSION_CMD,
    DM_MPATH_PROBE_PATHS_CMD,
};

#define DM_IOCTL 0xfd

#define DM_MPATH_PROBE_PATHS _IO(DM_IOCTL, DM_MPATH_PROBE_PATHS_CMD)

#endif /* __linux__ */

// linux/can/raw.h -- CAN_RAW socket options from the kernel uapi header:
// the SOL_CAN_RAW level and the CAN_RAW_* setsockopt names.

#pragma once

#ifdef __linux__

#include <linux/can.h>

#define SOL_CAN_RAW (SOL_CAN_BASE + CAN_RAW)

#define CAN_RAW_FILTER_MAX 512

enum {
    SCM_CAN_RAW_ERRQUEUE = 1,
};

enum {
    CAN_RAW_FILTER = 1,
    CAN_RAW_ERR_FILTER,
    CAN_RAW_LOOPBACK,
    CAN_RAW_RECV_OWN_MSGS,
    CAN_RAW_FD_FRAMES,
    CAN_RAW_JOIN_FILTERS,
    CAN_RAW_XL_FRAMES,
    CAN_RAW_XL_VCID_OPTS,
};

struct can_raw_vcid_options {
    __u8 flags;
    __u8 tx_vcid;
    __u8 rx_vcid;
    __u8 rx_vcid_mask;
};

#define CAN_RAW_XL_VCID_TX_SET    0x01
#define CAN_RAW_XL_VCID_TX_PASS   0x02
#define CAN_RAW_XL_VCID_RX_FILTER 0x04

#endif /* __linux__ */

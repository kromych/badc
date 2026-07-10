// scsi/sg.h -- SCSI generic (sg) v3 passthrough uapi. Self-contained
// Linux-only surface used via ioctl(fd, SG_IO, &hdr). The sg ioctl
// request numbers are the driver's fixed legacy magic values (raw hex,
// not _IOC-encoded), identical on aarch64 and x86_64. Struct layouts are
// byte-exact against the aarch64 kernel/glibc definition.

#pragma once

#ifdef __linux__

#include <stddef.h>   // size_t for sg_iovec_t

typedef struct sg_iovec {
    void  *iov_base;              // starting address
    size_t iov_len;              // length in bytes
} sg_iovec_t;

// Direction/status fields tagged [i] caller-set, [o] kernel-written.
typedef struct sg_io_hdr {
    int            interface_id;   // [i] 'S' for SCSI generic
    int            dxfer_direction;// [i] SG_DXFER_*
    unsigned char  cmd_len;        // [i] SCSI command length (<= 16)
    unsigned char  mx_sb_len;      // [i] max length written to sbp
    unsigned short iovec_count;    // [i] 0 implies no scatter-gather
    unsigned int   dxfer_len;      // [i] byte count of data transfer
    void          *dxferp;         // [i][*io] data buffer or iovec list
    unsigned char *cmdp;           // [i][*i] command to perform
    unsigned char *sbp;            // [i][*o] sense buffer
    unsigned int   timeout;        // [i] millisec; MAX_UINT -> no timeout
    unsigned int   flags;          // [i] SG_FLAG_*
    int            pack_id;        // [i->o] unused internally
    void          *usr_ptr;        // [i->o] unused internally
    unsigned char  status;         // [o] scsi status
    unsigned char  masked_status;  // [o] shifted, masked scsi status
    unsigned char  msg_status;     // [o] messaging level data
    unsigned char  sb_len_wr;      // [o] byte count written to sbp
    unsigned short host_status;    // [o] errors from host adapter
    unsigned short driver_status;  // [o] errors from software driver
    int            resid;          // [o] dxfer_len - actual transferred
    unsigned int   duration;       // [o] time taken by cmd (millisec)
    unsigned int   info;           // [o] SG_INFO_*
} sg_io_hdr_t;

// dxfer_direction: negative to distinguish from the legacy sg_header.
#define SG_DXFER_NONE        (-1)  // e.g. TEST UNIT READY
#define SG_DXFER_TO_DEV      (-2)  // e.g. WRITE
#define SG_DXFER_FROM_DEV    (-3)  // e.g. READ
#define SG_DXFER_TO_FROM_DEV (-4)  // FROM_DEV, buffer pre-copied on indirect IO

// flags: or-ed together.
#define SG_FLAG_DIRECT_IO   1
#define SG_FLAG_LUN_INHIBIT 2
#define SG_FLAG_NO_DXFER    0x10000

// info: or-ed together.
#define SG_INFO_OK_MASK        0x1
#define SG_INFO_OK             0x0
#define SG_INFO_CHECK          0x1
#define SG_INFO_DIRECT_IO_MASK 0x6
#define SG_INFO_INDIRECT_IO    0x0
#define SG_INFO_DIRECT_IO      0x2
#define SG_INFO_MIXED_IO       0x4

// Returned by SG_GET_SCSI_ID.
struct sg_scsi_id {
    int   host_no;         // scsi<n> host number
    int   channel;
    int   scsi_id;         // target device id
    int   lun;
    int   scsi_type;       // TYPE_* from <scsi/scsi.h>
    short h_cmd_per_lun;   // host max commands per lun
    short d_queue_depth;   // device/adapter max queue length
    int   unused[2];       // 0 for now
};

// Returned by SG_GET_REQUEST_TABLE.
typedef struct sg_req_info {
    char         req_state;   // 0 unused, 1 written, 2 ready to read
    char         orphan;      // 1 -> from interrupted SG_IO
    char         sg_io_owned; // 1 -> owned by SG_IO
    char         problem;     // 1 -> error to report
    int          pack_id;
    void        *usr_ptr;
    unsigned int duration;
    int          unused;
} sg_req_info_t;

// ioctls: fixed sg-driver magic values (3rd arg is 'int *' unless noted).
#define SG_EMULATED_HOST     0x2203  // true for emulated (ATAPI) adapter
#define SG_SET_TRANSFORM     0x2204  // 3rd arg is value, not pointer
#define SG_GET_TRANSFORM     0x2205
#define SG_SET_RESERVED_SIZE 0x2275
#define SG_GET_RESERVED_SIZE 0x2272
#define SG_GET_SCSI_ID       0x2276  // 3rd arg 'struct sg_scsi_id *'
#define SG_SET_FORCE_LOW_DMA 0x2279
#define SG_GET_LOW_DMA       0x227a
#define SG_SET_FORCE_PACK_ID 0x227b
#define SG_GET_PACK_ID       0x227c
#define SG_GET_NUM_WAITING   0x227d
#define SG_GET_SG_TABLESIZE  0x227F  // 0 implies no scatter-gather
#define SG_GET_VERSION_NUM   0x2282  // 2.1.34 yields 20134
#define SG_SCSI_RESET        0x2284  // returns -EBUSY if occupied
#define SG_IO                0x2285  // synchronous command, 'sg_io_hdr_t *'
#define SG_GET_REQUEST_TABLE 0x2286
#define SG_SET_KEEP_ORPHAN   0x2287
#define SG_GET_KEEP_ORPHAN   0x2288

// SG_SCSI_RESET argument values (3rd arg 'int *').
#define SG_SCSI_RESET_NOTHING 0
#define SG_SCSI_RESET_DEVICE  1
#define SG_SCSI_RESET_BUS     2
#define SG_SCSI_RESET_HOST    3

// Legacy 2.x ioctls retained for the sg_header interface.
#define SG_SET_TIMEOUT   0x2201  // *(int *)arg == timeout
#define SG_GET_TIMEOUT   0x2202  // returns timeout
#define SG_GET_COMMAND_Q 0x2270
#define SG_SET_COMMAND_Q 0x2271

#endif // __linux__

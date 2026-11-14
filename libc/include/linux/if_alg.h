// linux/if_alg.h -- AF_ALG kernel crypto API sockets from the kernel uapi
// header: the address, the IV control message, and the ALG_* operations.

#pragma once

#ifdef __linux__

#include <linux/types.h>

struct sockaddr_alg {
    __u16 salg_family;
    __u8 salg_type[14];
    __u32 salg_feat;
    __u32 salg_mask;
    __u8 salg_name[64];
};

struct sockaddr_alg_new {
    __u16 salg_family;
    __u8 salg_type[14];
    __u32 salg_feat;
    __u32 salg_mask;
    __u8 salg_name[];
};

struct af_alg_iv {
    __u32 ivlen;
    __u8 iv[];
};

// SOL_ALG socket options and control message types.
#define ALG_SET_KEY               1
#define ALG_SET_IV                2
#define ALG_SET_OP                3
#define ALG_SET_AEAD_ASSOCLEN     4
#define ALG_SET_AEAD_AUTHSIZE     5
#define ALG_SET_DRBG_ENTROPY      6
#define ALG_SET_KEY_BY_KEY_SERIAL 7

#define ALG_OP_DECRYPT 0
#define ALG_OP_ENCRYPT 1

#endif

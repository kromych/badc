// mach-o/nlist.h -- the Mach-O symbol table entry. Values and field
// layout match the macOS SDK header of the same name. The format is
// fixed, so the definitions are usable on any host. No bindings -- data
// layout only.
//
// The debugging (stab) type codes live in <mach-o/stab.h> and are not
// declared here.
//
// `struct nlist` carries only `n_strx`. The SDK's in-core `char *n_name`
// alternative is gated on !__LP64__, and every target badc emits for has
// 64-bit pointers, so admitting it would widen the union past the
// 12-byte on-disk entry.

#pragma once

#include <stdint.h>

struct nlist {
    union {
        uint32_t n_strx;
    } n_un;
    uint8_t  n_type;
    uint8_t  n_sect;
    int16_t  n_desc;
    uint32_t n_value;
};

struct nlist_64 {
    union {
        uint32_t n_strx;
    } n_un;
    uint8_t  n_type;
    uint8_t  n_sect;
    uint16_t n_desc;
    uint64_t n_value;
};

// n_type packs four fields.
#define N_STAB 0xe0
#define N_PEXT 0x10
#define N_TYPE 0x0e
#define N_EXT  0x01

// Values of the N_TYPE bits.
#define N_UNDF 0x0
#define N_ABS  0x2
#define N_SECT 0xe
#define N_PBUD 0xc
#define N_INDR 0xa

#define NO_SECT  0
#define MAX_SECT 255

// n_desc: reference type of an undefined symbol.
#define REFERENCE_TYPE                            0x7
#define REFERENCE_FLAG_UNDEFINED_NON_LAZY         0
#define REFERENCE_FLAG_UNDEFINED_LAZY             1
#define REFERENCE_FLAG_DEFINED                    2
#define REFERENCE_FLAG_PRIVATE_DEFINED            3
#define REFERENCE_FLAG_PRIVATE_UNDEFINED_NON_LAZY 4
#define REFERENCE_FLAG_PRIVATE_UNDEFINED_LAZY     5
#define REFERENCED_DYNAMICALLY                    0x0010

// n_desc: remaining attribute bits.
#define N_NO_DEAD_STRIP    0x0020
#define N_DESC_DISCARDED   0x0020
#define N_WEAK_REF         0x0040
#define N_WEAK_DEF         0x0080
#define N_REF_TO_WEAK      0x0080
#define N_ARM_THUMB_DEF    0x0008
#define N_SYMBOL_RESOLVER  0x0100
#define N_ALT_ENTRY        0x0200
#define N_COLD_FUNC        0x0400

// n_desc: two-level namespace library ordinal, in the high 8 bits.
#define GET_LIBRARY_ORDINAL(n_desc) (((n_desc) >> 8) & 0xff)
#define SET_LIBRARY_ORDINAL(n_desc, ordinal) \
    (n_desc) = (((n_desc) & 0x00ff) | (((ordinal) & 0xff) << 8))
#define SELF_LIBRARY_ORDINAL   0x0
#define MAX_LIBRARY_ORDINAL    0xfd
#define DYNAMIC_LOOKUP_ORDINAL 0xfe
#define EXECUTABLE_ORDINAL     0xff

// n_desc: alignment of a common symbol, as a power of two.
#define GET_COMM_ALIGN(n_desc) (((n_desc) >> 8) & 0x0f)
#define SET_COMM_ALIGN(n_desc, align) \
    (n_desc) = (((n_desc) & 0xf0ff) | (((align) & 0x0f) << 8))

/* The SimpleSvm bitfield/union layouts the user-mode harness exercises,
 * reproduced here with the upstream size invariants as compile-time
 * asserts. SEGMENT_DESCRIPTOR and SEGMENT_ATTRIBUTE live in
 * SimpleSvm.cpp and EVENTINJ in SimpleSvm.hpp; the harness mirrors them
 * (and the two pure transforms over them) so the segment-descriptor
 * decode and the event-injection packing can be run and diffed in ring
 * 3 without loading the driver. A divergence points at a badc codegen
 * defect in bitfield/union access, shifts or masking. */
#pragma once
#include <stdint.h>

typedef uint16_t UINT16;
typedef uint32_t UINT32;
typedef uint64_t UINT64;

#define RPL_MASK    3
#define DPL_SYSTEM  0

/* "Long-Mode Segment Descriptors"; mixes 16-bit members with a 32-bit
 * bitfield unit, so the 8-byte total is the layout invariant. */
typedef struct _SEGMENT_DESCRIPTOR {
    union {
        UINT64 AsUInt64;
        struct {
            UINT16 LimitLow;        /* [0:15]  */
            UINT16 BaseLow;         /* [16:31] */
            UINT32 BaseMiddle : 8;  /* [32:39] */
            UINT32 Type : 4;        /* [40:43] */
            UINT32 System : 1;      /* [44]    */
            UINT32 Dpl : 2;         /* [45:46] */
            UINT32 Present : 1;     /* [47]    */
            UINT32 LimitHigh : 4;   /* [48:51] */
            UINT32 Avl : 1;         /* [52]    */
            UINT32 LongMode : 1;    /* [53]    */
            UINT32 DefaultBit : 1;  /* [54]    */
            UINT32 Granularity : 1; /* [55]    */
            UINT32 BaseHigh : 8;    /* [56:63] */
        } Fields;
    };
} SEGMENT_DESCRIPTOR;
_Static_assert(sizeof(SEGMENT_DESCRIPTOR) == 8, "SEGMENT_DESCRIPTOR size");

typedef struct _SEGMENT_ATTRIBUTE {
    union {
        UINT16 AsUInt16;
        struct {
            UINT16 Type : 4;        /* [0:3]   */
            UINT16 System : 1;      /* [4]     */
            UINT16 Dpl : 2;         /* [5:6]   */
            UINT16 Present : 1;     /* [7]     */
            UINT16 Avl : 1;         /* [8]     */
            UINT16 LongMode : 1;    /* [9]     */
            UINT16 DefaultBit : 1;  /* [10]    */
            UINT16 Granularity : 1; /* [11]    */
            UINT16 Reserved1 : 4;   /* [12:15] */
        } Fields;
    };
} SEGMENT_ATTRIBUTE;
_Static_assert(sizeof(SEGMENT_ATTRIBUTE) == 2, "SEGMENT_ATTRIBUTE size");

typedef struct _EVENTINJ {
    union {
        UINT64 AsUInt64;
        struct {
            UINT64 Vector : 8;          /* [0:7]   */
            UINT64 Type : 3;            /* [8:10]  */
            UINT64 ErrorCodeValid : 1;  /* [11]    */
            UINT64 Reserved1 : 19;      /* [12:30] */
            UINT64 Valid : 1;           /* [31]    */
            UINT64 ErrorCode : 32;      /* [32:63] */
        } Fields;
    };
} EVENTINJ;
_Static_assert(sizeof(EVENTINJ) == 8, "EVENTINJ size");

/* SvGetSegmentAccessRight: extract the attribute fields out of a segment
 * descriptor into the compact attribute word. */
static UINT16 sv_segment_access_right(const SEGMENT_DESCRIPTOR *Descriptor) {
    SEGMENT_ATTRIBUTE attribute;
    attribute.Fields.Type = Descriptor->Fields.Type;
    attribute.Fields.System = Descriptor->Fields.System;
    attribute.Fields.Dpl = Descriptor->Fields.Dpl;
    attribute.Fields.Present = Descriptor->Fields.Present;
    attribute.Fields.Avl = Descriptor->Fields.Avl;
    attribute.Fields.LongMode = Descriptor->Fields.LongMode;
    attribute.Fields.DefaultBit = Descriptor->Fields.DefaultBit;
    attribute.Fields.Granularity = Descriptor->Fields.Granularity;
    attribute.Fields.Reserved1 = 0;
    return attribute.AsUInt16;
}

/* SvInjectGeneralProtectionException: pack a valid #GP event. */
static UINT64 sv_event_gp(void) {
    EVENTINJ event;
    event.AsUInt64 = 0;
    event.Fields.Vector = 13;
    event.Fields.Type = 3;
    event.Fields.ErrorCodeValid = 1;
    event.Fields.Valid = 1;
    return event.AsUInt64;
}

/* Stub <intrin.h> for the user-mode logic harness. The harness exercises
 * SimpleVisor's pure decode logic (ShvUtilConvertGdtEntry,
 * ShvUtilAdjustMsr) in ring 3 on any architecture, so the segment-limit
 * intrinsic it reaches is replaced by a deterministic constant rather
 * than the privileged/host-dependent `lsl`. Resolved ahead of the demo's
 * real inline-asm <intrin.h> via a harness-first -I. */
#pragma once

#define SHV_HARNESS_SEGMENT_LIMIT 0x000FFFFFu

static unsigned __segmentlimit(unsigned Selector) {
    (void)Selector;
    return SHV_HARNESS_SEGMENT_LIMIT;
}

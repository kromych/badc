/* User-mode logic harness for the SimpleSvm demo.
 *
 * Loading the hypervisor is out of scope (shared host, and an SVM fault
 * takes the host down), so the pure bitfield logic is exercised in ring
 * 3 instead: the segment-descriptor decode (SvGetSegmentAccessRight) and
 * the #GP event packing (SvInjectGeneralProtectionException), both over
 * SimpleSvm's exact union/bitfield layouts (harness/svbits.h).
 *
 * The harness asserts hand-computed invariants so it is meaningful on a
 * lane that has only badc, and prints the same values so a reference
 * compiler's build can be diffed against badc's (the smoke does this).
 * A mismatch points at a badc codegen defect in bitfield/union access,
 * shifts or masking. */
#include "svbits.h"
#include <stdio.h>

static int failures;

static void check(const char *what, unsigned long long got, unsigned long long want) {
    printf("%-28s = 0x%llx\n", what, (unsigned long long)got);
    if (got != want) {
        fprintf(stderr, "FAIL %s: got 0x%llx want 0x%llx\n", what, got, want);
        failures++;
    }
}

int main(void) {
    /* A descriptor carrying a known set of attribute fields. The
     * extracted attribute word packs them as
     *   Type | System<<4 | Dpl<<5 | Present<<7 | Avl<<8
     *        | LongMode<<9 | DefaultBit<<10 | Granularity<<11. */
    SEGMENT_DESCRIPTOR d;
    d.AsUInt64 = 0;
    d.Fields.Type = 0x3;
    d.Fields.System = 1;
    d.Fields.Dpl = 2;
    d.Fields.Present = 1;
    d.Fields.Avl = 1;
    d.Fields.LongMode = 1;
    d.Fields.DefaultBit = 0;
    d.Fields.Granularity = 1;
    check("segment.access_right", sv_segment_access_right(&d), 0xBD3);

    /* The high half of a descriptor (base/limit) must not leak into the
     * attribute word; set it and confirm the result is unchanged. */
    d.Fields.BaseHigh = 0xFF;
    d.Fields.LimitHigh = 0xF;
    d.Fields.BaseMiddle = 0xAB;
    check("segment.access_right.masked", sv_segment_access_right(&d), 0xBD3);

    /* A null descriptor yields no attribute bits. */
    SEGMENT_DESCRIPTOR z;
    z.AsUInt64 = 0;
    check("segment.null", sv_segment_access_right(&z), 0);

    /* #GP: vector 13, type 3 (exception), error code valid, event valid:
     *   13 | 3<<8 | 1<<11 | 1<<31. */
    check("event.inject_gp", sv_event_gp(), 0x80000B0Dull);

    printf("harness: %s\n", failures ? "FAIL" : "OK");
    return failures ? 1 : 0;
}

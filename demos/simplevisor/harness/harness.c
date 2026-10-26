/* User-mode logic harness for the SimpleVisor demo.
 *
 * Loading the hypervisor is out of scope (shared host), so the host-mode
 * decode logic is exercised in ring 3 instead: the GDT-descriptor
 * conversion (ShvUtilConvertGdtEntry, shvutil.c) and the VMX capability
 * MSR adjustment (ShvUtilAdjustMsr). Both are pure functions of their
 * inputs once the segment-limit intrinsic is stubbed (harness/intrin.h).
 *
 * The harness asserts hand-computed invariants so it is meaningful on a
 * lane that has only badc, and prints the same values so a reference
 * compiler's build can be diffed against badc's (the smoke does this).
 * A mismatch points at a badc codegen defect in bitfield/union access,
 * shifts or masking, isolated from the driver's privileged paths. */
#include "shv.h"
#include <stdio.h>
#include <string.h>

static int failures;

static void check(const char *what, unsigned long long got, unsigned long long want) {
    printf("%-28s = 0x%llx\n", what, got);
    if (got != want) {
        fprintf(stderr, "FAIL %s: got 0x%llx want 0x%llx\n", what, got, want);
        failures++;
    }
}

int main(void) {
    /* ShvUtilAdjustMsr: VMX capability MSRs put the must-be-1 bits in the
     * low half and the allowed-1 (must-be-0 inverted) bits in the high
     * half; the result keeps requested bits that are allowed and forces
     * the required ones. */
    LARGE_INTEGER cap;
    cap.LowPart = 0x00000012u;  /* bits 1 and 4 required */
    cap.HighPart = 0x0000003Fu; /* bits 0..5 allowed */
    UINT32 adjusted = ShvUtilAdjustMsr(cap, 0xFFFFFFFFu);
    check("adjust_msr(all-ones)", adjusted, (0xFFFFFFFFu & 0x3Fu) | 0x12u);
    check("adjust_msr(zero)", ShvUtilAdjustMsr(cap, 0u), 0x12u);

    /* A GDT with a 16-byte system descriptor (a TSS, Type bit 4 clear)
     * at selector 0x10, carrying a known 64-bit base so the reconstruction
     * across BaseLow/BaseMiddle/BaseHigh/BaseUpper can be checked. */
    unsigned char gdt[0x40];
    memset(gdt, 0, sizeof(gdt));
    KGDTENTRY64 *e = (KGDTENTRY64 *)&gdt[0x10];
    e->LimitLow = 0xFFFF;              /* ignored: limit comes from the intrinsic */
    e->BaseLow = 0x5678;              /* base[15:0]  */
    e->Bytes.BaseMiddle = 0x34;       /* base[23:16] */
    e->Bytes.BaseHigh = 0x12;         /* base[31:24] */
    e->BaseUpper = 0xFFFFF800u;       /* base[63:32] (system descriptor) */
    e->Bytes.Flags1 = 0x89;           /* Type=9 (TSS), Dpl=0, Present=1 */
    e->Bytes.Flags2 = 0x20;           /* LongMode=1 */

    VMX_GDTENTRY64 vmx;
    ShvUtilConvertGdtEntry(gdt, 0x10, &vmx);
    check("gdt.base", vmx.Base, 0xFFFFF80012345678ull);
    check("gdt.limit", vmx.Limit, SHV_HARNESS_SEGMENT_LIMIT);
    check("gdt.selector", vmx.Selector, 0x10);
    check("gdt.access_rights", vmx.AccessRights, 0x2089);
    check("gdt.unusable", vmx.Bits.Unusable, 0);

    /* A null selector must come back marked unusable with no base. */
    VMX_GDTENTRY64 nul;
    ShvUtilConvertGdtEntry(gdt, 0, &nul);
    check("null.unusable", nul.Bits.Unusable, 1);
    check("null.base", nul.Base, 0);

    printf("harness: %s\n", failures ? "FAIL" : "OK");
    return failures ? 1 : 0;
}

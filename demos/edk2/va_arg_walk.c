/* Regression for the edk2 VA_ARG / badc __builtin_va_arg contract bridge.
 *
 * edk2 MdePkg/Include/Base.h (the __GNUC__ MS-ABI path) expands VA_ARG to
 * `(TYPE)(__builtin_va_arg(Marker, TYPE))`: it passes the VA_LIST by name and
 * does not dereference. badc's __builtin_va_arg instead takes the ADDRESS of
 * the va_list storage and returns the slot address (its <stdarg.h> derefs the
 * result). badc_efi_compat.h bridges the two. Without the bridge each VA_ARG
 * reads and advances `*Marker` in place, never advancing the cursor, so every
 * argument after the first walks back as the previous one plus one slot -- the
 * defect that made DxeCore's CoreInstallMultipleProtocolInterfaces install every
 * protocol with Interface = &Guid + 8 and crash the badc-built OVMF in early DXE.
 *
 * Build with `--gnu` so the __GNUC__ Base.h path (hence __builtin_va_arg) is the
 * one under test; run under `--interp` for a host-independent check. */
#include "badc_efi_compat.h"

typedef __builtin_ms_va_list VA_LIST;
typedef unsigned long long   UINTN;

#define VA_START(Marker, Parameter)  __builtin_ms_va_start (Marker, Parameter)
#define VA_ARG(Marker, TYPE) \
  ((sizeof (TYPE) < sizeof (UINTN)) ? (TYPE)(__builtin_va_arg (Marker, UINTN)) \
                                    : (TYPE)(__builtin_va_arg (Marker, TYPE)))
#define VA_END(Marker)  __builtin_ms_va_end (Marker)

static void *seen[8];
static int   count;

static void walk (void *first, ...) {
    VA_LIST ap;
    VA_START (ap, first);
    for (;;) {
        void *p = VA_ARG (ap, void *);
        if (p == (void *)0) {
            break;
        }
        if (count < 8) {
            seen[count] = p;
        }
        count++;
        if (count > 6) {          /* the unbridged walk never terminates */
            break;
        }
    }
    VA_END (ap);
}

int main (void) {
    int a, b, c, d;
    walk ((void *)0, &a, &b, &c, &d, (void *)0);
    if (count != 4) {
        return 10 + count;        /* bug: repeats / runs past the NULL */
    }
    if (seen[0] != (void *)&a) {
        return 1;
    }
    if (seen[1] != (void *)&b) {  /* bug delivered &a + one slot here */
        return 2;
    }
    if (seen[2] != (void *)&c) {
        return 3;
    }
    if (seen[3] != (void *)&d) {
        return 4;
    }
    return 0;
}

/* <cpuid.h> leaf-checked queries. __get_cpuid / __get_cpuid_count report
   whether the leaf is within the range reported by __get_cpuid_max, taking
   the extended range for leaves with bit 31 set, and leave the four output
   words untouched when they reject a leaf. Natively leaf 0 is read and its
   vendor string is not empty; under the interpreter, which runs CPUID as
   zero, every leaf is rejected and the outputs keep their sentinels. */

#include <cpuid.h>

#define SENTINEL 0xA5A5A5A5u

static int vendor_is_nonempty(void) {
    unsigned int a = SENTINEL, b = SENTINEL, c = SENTINEL, d = SENTINEL;

    if (!__get_cpuid(0, &a, &b, &c, &d)) {
        /* Leaf 0 rejected: the outputs must be as they were left. */
        return a == SENTINEL && b == SENTINEL && c == SENTINEL && d == SENTINEL;
    }
    /* Leaf 0 returns the maximum basic leaf and the vendor string in
       %ebx/%edx/%ecx, which is never all zero on real hardware. */
    return (b | c | d) != 0;
}

static int rejects_implausible_leaf(void) {
    unsigned int a = SENTINEL, b = SENTINEL, c = SENTINEL, d = SENTINEL;

    if (__get_cpuid(0x7FFFFFFFu, &a, &b, &c, &d)) {
        return 0;
    }
    return a == SENTINEL && b == SENTINEL && c == SENTINEL && d == SENTINEL;
}

static int rejects_implausible_extended_leaf(void) {
    unsigned int a = SENTINEL, b = SENTINEL, c = SENTINEL, d = SENTINEL;

    /* Bit 31 set: checked against the extended maximum, not the basic one. */
    if (__get_cpuid(0xFFFFFFFFu, &a, &b, &c, &d)) {
        return 0;
    }
    return a == SENTINEL && b == SENTINEL && c == SENTINEL && d == SENTINEL;
}

static int count_form_agrees(void) {
    unsigned int a = SENTINEL, b = SENTINEL, c = SENTINEL, d = SENTINEL;
    unsigned int a2 = SENTINEL, b2 = SENTINEL, c2 = SENTINEL, d2 = SENTINEL;

    /* The subleaf form applies the same range check to the leaf. */
    if (__get_cpuid_count(0x7FFFFFFFu, 0, &a, &b, &c, &d)) {
        return 0;
    }
    if (a != SENTINEL || b != SENTINEL || c != SENTINEL || d != SENTINEL) {
        return 0;
    }
    return __get_cpuid_count(7, 0, &a2, &b2, &c2, &d2) ==
           __get_cpuid(7, &a2, &b2, &c2, &d2);
}

int main(void) {
    if (!vendor_is_nonempty()) {
        return 1;
    }
    if (!rejects_implausible_leaf()) {
        return 2;
    }
    if (!rejects_implausible_extended_leaf()) {
        return 3;
    }
    if (!count_form_agrees()) {
        return 4;
    }
    return 0;
}

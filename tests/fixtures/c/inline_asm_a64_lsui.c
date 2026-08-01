// AArch64 inline asm: the FEAT_LSUI unprivileged atomics, reached through an
// `.arch_extension lsui` preamble and `+Q` read-write memory operands, the
// shape privileged code uses to touch a user mapping. The family is
// add/clear/set/swap in both widths and all four orderings plus the
// 64-bit-only compare-and-swap; there is no exclusive-or member.
//
// Compile-only: the instructions need Armv9.6 hardware, so the functions have
// external linkage to keep them emitted and main never runs them.

typedef unsigned int u32;
typedef unsigned long long u64;

#define LSUI_RMW(name, insn, ty, mod)                                          \
    ty name(ty *p, ty v) {                                                     \
        ty old;                                                                \
        __asm__ volatile(".arch_extension lsui\n\t" insn                       \
                         " %" mod "1, %" mod "0, %2"                           \
                         : "=r"(old), "+r"(v), "+Q"(*p)::"memory");            \
        return old;                                                            \
    }

LSUI_RMW(lsui_add32, "ldtadd", u32, "w")
LSUI_RMW(lsui_add32_a, "ldtadda", u32, "w")
LSUI_RMW(lsui_add32_l, "ldtaddl", u32, "w")
LSUI_RMW(lsui_add32_al, "ldtaddal", u32, "w")
LSUI_RMW(lsui_add64, "ldtadd", u64, "x")
LSUI_RMW(lsui_add64_al, "ldtaddal", u64, "x")
LSUI_RMW(lsui_clr32_al, "ldtclral", u32, "w")
LSUI_RMW(lsui_clr64, "ldtclr", u64, "x")
LSUI_RMW(lsui_set32_l, "ldtsetl", u32, "w")
LSUI_RMW(lsui_set64_a, "ldtseta", u64, "x")
LSUI_RMW(lsui_swap32, "swpt", u32, "w")
LSUI_RMW(lsui_swap64_al, "swptal", u64, "x")

// The compare-and-swap forms take the expected value in place, so the first
// operand is read-write; a leading local label is what the kernel's fault
// table anchors on.
#define LSUI_CAS(name, insn)                                                   \
    u64 name(u64 *p, u64 expect, u64 newval) {                                 \
        __asm__ volatile(".arch_extension lsui\n"                              \
                         "1:\t" insn " %0, %2, %1"                             \
                         : "+r"(expect), "+Q"(*p)                              \
                         : "r"(newval)                                         \
                         : "memory");                                          \
        return expect;                                                         \
    }

LSUI_CAS(lsui_cas, "cast")
LSUI_CAS(lsui_cas_a, "casat")
LSUI_CAS(lsui_cas_l, "caslt")
LSUI_CAS(lsui_cas_al, "casalt")

int main(void) {
    return 42;
}

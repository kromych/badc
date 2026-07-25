/* AArch64 inline asm: system-register moves that name registers beyond the
 * common set -- CLIDR_EL1, MDSCR_EL1, ID_AA64MMFR1_EL1, the indexed debug
 * breakpoint/watchpoint families (DBGB{V,C}R<n>_EL1 / DBGW{V,C}R<n>_EL1), the
 * performance-monitor counters (PMEVCNTR<n>_EL0 / PMEVTYPER<n>_EL0), and the
 * generic S<op0>_<op1>_C<n>_C<m>_<op2> spelling with op0=0. The moves are
 * privileged, so they sit in external-linkage functions that are emitted but
 * never executed by main; x86_64 has no such instruction and is skipped. */

unsigned long read_named_sysregs(void) {
    unsigned long v = 0, t;
    __asm__ volatile("mrs %0, clidr_el1" : "=r"(t));
    v ^= t;
    __asm__ volatile("mrs %0, id_aa64mmfr1_el1" : "=r"(t));
    v ^= t;
    __asm__ volatile("mrs %0, mdscr_el1" : "=r"(t));
    v ^= t;
    __asm__ volatile("msr mdscr_el1, %0" : : "r"(t));
    return v;
}

/* The kernel indexes the whole DBGBVR/DBGBCR/DBGWVR/DBGWCR families 0..15 via a
 * macro-generated switch; the low and a high index cover the encoding range. */
unsigned long read_debug_family(void) {
    unsigned long v = 0, t;
    __asm__ volatile("mrs %0, dbgbvr0_el1" : "=r"(t));
    v ^= t;
    __asm__ volatile("mrs %0, dbgbcr0_el1" : "=r"(t));
    v ^= t;
    __asm__ volatile("mrs %0, dbgwvr0_el1" : "=r"(t));
    v ^= t;
    __asm__ volatile("mrs %0, dbgwcr0_el1" : "=r"(t));
    v ^= t;
    __asm__ volatile("mrs %0, dbgbvr15_el1" : "=r"(t));
    v ^= t;
    __asm__ volatile("mrs %0, dbgwcr15_el1" : "=r"(t));
    v ^= t;
    return v;
}

unsigned long read_pmu_and_generic(void) {
    unsigned long v = 0, t;
    __asm__ volatile("mrs %0, pmevcntr0_el0" : "=r"(t));
    v ^= t;
    __asm__ volatile("mrs %0, pmevtyper0_el0" : "=r"(t));
    v ^= t;
    __asm__ volatile("mrs %0, s0_3_c1_c0_1" : "=r"(t));
    v ^= t;
    return v;
}

int main(void) { return 42; }

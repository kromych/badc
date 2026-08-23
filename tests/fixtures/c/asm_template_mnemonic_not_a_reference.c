// A token in an assembler statement's leading position is a label, mnemonic
// or directive, never an operand, so it does not reference a same-named
// internal symbol. `nop` names both the always_inline helper and the
// instruction its body holds. Once the body is spliced into the caller the
// out-of-line copy has no caller left, and treating the spliced template's
// `nop` as a reference to the helper would keep that dead copy in the image.
// The snapshots carry the check: no `<nop>` body survives on either target.

static __attribute__((always_inline)) inline void nop(void) {
    __asm__ __volatile__ ("nop" ::: "memory");
}

// Same collision behind a label, where the mnemonic is not the first token
// of its line but still leads its statement.
static __attribute__((always_inline)) inline void pause_lbl(void) {
    __asm__ __volatile__ ("8: nop\n" ::: "memory");
}

int main(void) {
    nop();
    pause_lbl();
    return 0;
}

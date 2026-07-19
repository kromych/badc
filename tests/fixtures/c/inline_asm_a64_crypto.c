/* AArch64 inline asm: NEON AES steps. AESMC (MixColumns) and AESIMC
 * (InvMixColumns) are exact inverses, so applying them in turn restores the
 * original state -- a self-checking round-trip that needs no key schedule.
 * Native-only on AArch64 with the AES feature (present on the Apple-silicon and
 * server hosts this runs on); on x86_64 the identity runs in plain C. */

static int aes_mixcolumns_roundtrip(int seed) {
    int r;
#if defined(__aarch64__)
    __asm__("dup v0.4s, %w1\n\t"
            "aesmc v0.16b, v0.16b\n\t"  /* MixColumns    */
            "aesimc v0.16b, v0.16b\n\t" /* InvMixColumns */
            "umov %w0, v0.s[0]"
            : "=r"(r)
            : "r"(seed)
            : "d0", "memory");
#else
    r = seed;
#endif
    return r;
}

int main(void) {
    /* InvMixColumns(MixColumns(x)) == x for every state. */
    return (aes_mixcolumns_roundtrip(42) == 42) ? 42 : 0;
}

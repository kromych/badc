/* A caller whose return type needs a different 64-bit extension than
   its tail-position callee's must not be lowered as a bare tail jump:
   the callee leaves the accumulator extended per ITS declared type,
   and the caller's contract re-extends. The recursive callee keeps
   the calls from inlining away at -O. */

int load_le32(const unsigned char *p, int i) {
    if (i >= 4)
        return 0;
    return ((int)p[i] << (8 * i)) | load_le32(p, i + 1);
}

/* int -> unsigned int: sign- vs zero-extension differ for bit 31. */
unsigned int get_long(const unsigned char *p) {
    return load_le32(p, 0);
}

/* unsigned int -> unsigned long long relies on get_long's contract. */
unsigned long long widen(const unsigned char *p) {
    return get_long(p);
}

/* int -> int: same contract, the tail jump stays legal. */
int load_alias(const unsigned char *p) {
    return load_le32(p, 0);
}

int main(void) {
    unsigned char high = 0xfe, low = 0x7f;
    unsigned char cfg[4];
    cfg[0] = 0x00;
    cfg[1] = 0x10;
    cfg[2] = 0xbf;
    cfg[3] = high; /* 0xfebf1000: bit 31 set */
    if (widen(cfg) != 0xfebf1000ULL)
        return 1;
    if (load_alias(cfg) != (int)0xfebf1000)
        return 2;
    cfg[3] = low; /* 0x7fbf1000: bit 31 clear */
    if (widen(cfg) != 0x7fbf1000ULL)
        return 3;
    return 0;
}

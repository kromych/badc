// C11 6.7.5: `_Alignas` on a block-scope declarator places the object on
// the requested boundary -- a static local in the data image, an
// automatic one in the over-aligned frame region -- and a thread-local
// keeps the 8-byte boundary its block is placed on. Odd-sized neighbours
// keep the running offsets off every wide boundary, so a dropped request
// shows up in the address. Returns 0, distinct non-zero per failure.

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

int main(void) {
    static char pad0[3] = "ab";
    static _Alignas(16) long s16[2] = { 1, 2 };
    static char pad1[3] = "cd";
    static _Alignas(32) long s32 = 3;
    static char pad2[3] = "ef";
    static _Alignas(16) long s_defer[] = { 4, 5, 6 };

    char lpad0 = 1;
    _Alignas(16) long l16[2] = { 7, 8 };
    char lpad1 = 2;
    _Alignas(32) long l32 = 9;

    static _Thread_local long t0;
    static _Thread_local char t1;
    static _Thread_local long t2;

    if (misaligned(s16, 16)) return 1;
    if (misaligned(&s32, 32)) return 2;
    if (misaligned(s_defer, 16)) return 3;
    if (misaligned(l16, 16)) return 4;
    if (misaligned(&l32, 32)) return 5;
    if (misaligned(&t0, 8)) return 6;
    if (misaligned(&t2, 8)) return 7;

    if (s16[0] != 1 || s16[1] != 2 || s32 != 3) return 8;
    if (s_defer[0] != 4 || s_defer[2] != 6) return 9;
    if (sizeof s_defer != 3 * sizeof(long)) return 10;
    if (l16[0] != 7 || l16[1] != 8 || l32 != 9) return 11;

    t0 = 13;
    t1 = 14;
    t2 = 15;
    if (t0 != 13 || t1 != 14 || t2 != 15) return 12;
    if (pad0[0] != 'a' || pad1[0] != 'c' || pad2[0] != 'e') return 13;
    if (lpad0 != 1 || lpad1 != 2) return 14;
    return 0;
}

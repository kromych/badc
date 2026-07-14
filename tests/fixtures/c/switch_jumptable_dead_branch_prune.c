/* A switch with enough cases lowers to a jump table. Each case here holds a
   compile-time-false guard (`sizeof(int) == 0`), whose taken block calls a
   helper; constfold_branch proves the guard false and orphans that block.
   prune_unreachable must delete the orphan even though the function has a
   jump table -- otherwise the dead helper calls reach the object (the qemu
   `qemu_build_assert` canary shape). The guard is never true, so the helper
   is never called and the per-case value is returned unchanged at -O and
   -O0 alike. */

static int helper(int x) {
    return x * 1000; /* never called: would corrupt the result if it were */
}

static int classify(int c) {
    int r;
    switch (c) {
    case 0:  r = 10; if (sizeof(int) == 0) { r += helper(c); } break;
    case 1:  r = 21; if (sizeof(int) == 0) { r += helper(c); } break;
    case 2:  r = 32; if (sizeof(int) == 0) { r += helper(c); } break;
    case 3:  r = 43; if (sizeof(int) == 0) { r += helper(c); } break;
    case 4:  r = 54; if (sizeof(int) == 0) { r += helper(c); } break;
    case 5:  r = 65; if (sizeof(int) == 0) { r += helper(c); } break;
    case 6:  r = 76; if (sizeof(int) == 0) { r += helper(c); } break;
    case 7:  r = 87; if (sizeof(int) == 0) { r += helper(c); } break;
    case 8:  r = 98; if (sizeof(int) == 0) { r += helper(c); } break;
    case 9:  r = 19; if (sizeof(int) == 0) { r += helper(c); } break;
    default: r = 0;
    }
    return r;
}

int main(void) {
    int acc = 0;
    for (int i = 0; i < 12; i++) {
        acc = acc * 2 + classify(i);
    }
    return acc & 0x7f;
}

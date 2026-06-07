// A four-parameter callee whose later parameter's incoming argument
// register is reused as an earlier parameter's home under register
// pressure. The ParamRef materialization must not clobber a not-yet-read
// incoming argument register (System V AMD64 3.2.3 / AAPCS64 6.4.1).
//
// `swap_or_copy` mirrors the Lua string.pack `copywithendian` shape: a
// branch keyed on the fourth parameter selects a forward copy or a
// reversing copy. When the fourth parameter (`reverse`) was clobbered by
// the placement of an earlier pointer parameter, the wrong branch ran.
// Reproduced under BADC_MAX_GPR=5 at -O; correct at lower pressure and
// without the fix.

static void byte_copy(char *dst, const char *src, unsigned n) {
    while (n-- != 0) {
        *dst++ = *src++;
    }
}

static void swap_or_copy(char *dst, const char *src, unsigned size, int reverse) {
    if (!reverse) {
        byte_copy(dst, src, size);
    } else {
        dst += size - 1;
        while (size-- != 0) {
            *(dst--) = *(src++);
        }
    }
}

int main() {
    char a[8];
    char b[8];
    int i;
    for (i = 0; i < 8; i++) {
        a[i] = (char)(i + 1);
    }

    // reverse = 1 -> b reversed.
    swap_or_copy(b, a, 8, 1);
    for (i = 0; i < 8; i++) {
        if (b[i] != (char)(8 - i)) {
            return 10 + i;
        }
    }

    // reverse = 0 -> b == a. This is the call that inverted when the
    // `reverse` parameter was clobbered by `src`'s placement.
    swap_or_copy(b, a, 8, 0);
    for (i = 0; i < 8; i++) {
        if (b[i] != (char)(i + 1)) {
            return 20 + i;
        }
    }

    return 0;
}

// Regression for a struct field of pointer-to-array type:
//   short (*tbl)[8];
// The declarator records the trailing `[8]` as an inner
// dimension on the field's `array_dims` (with a leading 0
// sentinel to distinguish from a decayed multi-dim array).
// At field-load time the indexing path peels one pointer
// level so the existing multi-dim stride machinery sees the
// decayed-array shape `T*`, then seeds the stride queue from
// the inner dims. Without this, `tbl[j][k] = val` walked off
// at sizeof(short*) per step instead of sizeof(short[8]) for
// the first index, and the second index loaded 8 bytes
// where such pointer-to-array shapes
// expected a 2-byte short. The test pins both the read and
// the write path.

#include <stdio.h>
#include <stdlib.h>

typedef struct {
    short (*tbl)[8];
} R;

int main(void) {
    R r;
    int j, k;
    r.tbl = (short (*)[8]) malloc(sizeof(short) * 32); /* 4 x 8 shorts */
    if (r.tbl == 0) return 1;

    /* Write a deterministic pattern through the pointer-to-array. */
    for (j = 0; j < 4; j++) {
        for (k = 0; k < 8; k++) {
            r.tbl[j][k] = (short)(j * 100 + k);
        }
    }

    /* Read back and verify. */
    for (j = 0; j < 4; j++) {
        for (k = 0; k < 8; k++) {
            if (r.tbl[j][k] != (short)(j * 100 + k)) {
                return 10 + j * 8 + k;
            }
        }
    }

    /* Plain `-1` sentinel write. */
    r.tbl[0][0] = -1;
    if (r.tbl[0][0] != -1) return 99;

    free(r.tbl);
    printf("pointer-to-array struct field OK\n");
    return 0;
}

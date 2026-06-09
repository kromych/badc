// Pointer arithmetic on a pointer-to-array `T (*p)[N]` scales by
// sizeof(T[N]), not sizeof(T) (C99 6.5.6p8 with the 6.2.5p20 array
// type). The flat pointer type looks like `T*`, so the array element
// size has to come from the declared dimension. Covers `a + i`, `p++`
// / `p--`, a chained `p + i - j`, the deref `(*p)[k]` after an offset,
// the pointer difference `p - a`, and the post-increment deref form
// `(*p++)[k]` (the SmallerC `rev()` shape that exposed the bug).
int a[5][2] = {{0, 1}, {2, 3}, {4, 5}, {6, 7}, {8, 9}};

int main(void) {
    if ((char *)(a + 2) - (char *)a != 16) return 1;

    int(*p)[2] = a;
    p++;
    if ((char *)p - (char *)a != 8) return 2;

    int(*q)[2] = a + 3 - 1; // chained -> a[2]
    if ((char *)q - (char *)a != 16) return 3;
    if ((*q)[0] != 4 || (*q)[1] != 5) return 4; // a[2] == {4, 5}

    if (p - a != 1) return 5;

    int(*r)[2] = a;
    int v0 = (*r++)[1]; // a[0][1] == 1, r -> a[1]
    int v1 = (*r)[1];   // a[1][1] == 3
    if (v0 != 1 || v1 != 3) return 6;

    int(*s)[2] = a + 4;
    s--;
    if ((char *)s - (char *)a != 24) return 7; // a[3]

    return 0;
}

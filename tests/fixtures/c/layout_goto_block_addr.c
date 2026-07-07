// Loops built from plain gotos and from GCC labels-as-values. The
// plain-goto loop in main is layout-eligible; dispatch takes label
// addresses (`&&label`), so the layout pass leaves its block order
// untouched and the label table stays valid.
static int dispatch(int n) {
    void *labels[2];
    labels[0] = &&even;
    labels[1] = &&odd;
    int acc = 0;
    int i = 0;
next:
    if (i >= n)
        return acc;
    goto *labels[i & 1];
even:
    acc += 2;
    i++;
    goto next;
odd:
    acc += 1;
    i++;
    goto next;
}

int main(void) {
    int acc = 0;
    int i = 0;
again:
    acc += dispatch(i);
    i++;
    if (i < 5)
        goto again;
    return acc;
}

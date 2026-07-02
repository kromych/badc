/* The result of an inlined multi-block callee is read in caller blocks
   emitted after the splice point; the splice must resolve those forward
   references instead of dropping them. */
static int helper_one(int x) { return x + x; }

static int helper_two(int x) {
    int y;
    goto compute;
compute:
    y = x << 1;
    return y;
}

int test(int a) {
    int r = helper_two(a);
    int s = helper_one(a);
    if (a > 3) {
        return r;
    }
    return r + s;
}

int main(void) { return test(5); }

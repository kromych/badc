/* A one-word struct passed by value to a read-only helper inlines: the
   helper's field load redirects to the caller's argument address. The
   sum over an array of such structs must match the off-line value. */
typedef union { unsigned long bits; } SR;
static unsigned long sr_obj(SR r) { return r.bits; }
static unsigned long sum_sr(const SR *a, int n) {
    unsigned long s = 0;
    for (int i = 0; i < n; i++) {
        s += sr_obj(a[i]);
    }
    return s;
}
int main(void) {
    SR a[5];
    for (int i = 0; i < 5; i++) a[i].bits = (unsigned long)(i + 1) * 100;
    /* 100+200+300+400+500 = 1500 */
    return sum_sr(a, 5) == 1500 ? 0 : 1;
}

// Taking the address of a weak symbol this unit does not define. An
// absent definition resolves to a null address, a present one to the
// object, and the choice is made at link time -- so the reference cannot
// be a page-relative pair against the symbol, which has no encoding for
// zero. Matches GCC and clang on x86-64 and aarch64; returns 0, distinct
// non-zero per failure.

extern __attribute__((weak)) const int absent_tbl[];
extern __attribute__((weak)) const int present_tbl[];
extern const int plain_tbl[];

const int present_tbl[3] = {11, 22, 33};
const int plain_tbl[2] = {44, 55};

static const int *take(const int *p) { return p; }

int main(void) {
    if (absent_tbl != (const int *)0) {
        return 1;
    }
    if (take(absent_tbl) != (const int *)0) {
        return 2;
    }
    if (present_tbl == (const int *)0) {
        return 3;
    }
    if (present_tbl[0] != 11 || present_tbl[2] != 33) {
        return 4;
    }
    if (take(present_tbl) != present_tbl) {
        return 5;
    }
    if (plain_tbl[0] != 44 || plain_tbl[1] != 55) {
        return 6;
    }
    return 0;
}

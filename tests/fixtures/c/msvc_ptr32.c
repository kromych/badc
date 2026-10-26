// MSVC's `__ptr32` on the 64-bit PE targets, as clang takes it for a
// windows-msvc triple: the pointer it follows is 4 bytes, sign-extended to
// 64 bits when it widens and truncated when it narrows; converted to a
// wider integer it is its 32 bits. Layouts, a pointer to one, arrays,
// members and static integer-constant initializers follow. Each failed
// check sets its bit; off the PE targets the unit checks nothing.

#ifdef _WIN32
typedef void * __ptr32 PVOID32;
struct echo32 { unsigned long addr; unsigned char * __ptr32 options; PVOID32 data; };
struct mixed { char c; int * __ptr32 p; int * __ptr64 q; };
struct init32 { int * __ptr32 a; int b; int * __ptr32 c; };

static int x = 7;
int * __ptr32 g32;
struct init32 s = { (int * __ptr32)0x10, 7, 0 };
int * __ptr32 table[3] = { 0, (int * __ptr32)0x20, (int * __ptr32)(long long)-4 };

static int * __ptr32 narrow(int *p) { return p; }
static int *widen(int * __ptr32 p) { return p; }

int main(void) {
    int bad = 0;
    bad |= (sizeof(int * __ptr32) != 4 || _Alignof(int * __ptr32) != 4) << 0;
    bad |= (sizeof(PVOID32) != 4 || sizeof(struct echo32) != 12) << 1;
    bad |= (sizeof(struct mixed) != 16 || __builtin_offsetof(struct mixed, q) != 8) << 2;
    int * __ptr32 arr[4];
    bad |= (sizeof(int * __ptr32 *) != 8 || sizeof arr != 16) << 3;
    int *p64 = (int *)(long long)0x12345678;
    int * __ptr32 p = p64;
    bad |= ((long long)(int *)p != 0x12345678) << 4;
    int * __ptr32 *pp = &arr[1];
    arr[1] = (int * __ptr32)(long long)0x7ffffff0;
    bad |= ((long long)(int *)*pp != 0x7ffffff0 || (char *)(pp + 1) - (char *)pp != 4) << 5;
    int * __ptr32 neg = (int * __ptr32)(long long)-16;
    bad |= ((long long)(int *)neg != -16 || (long long)neg != 0xfffffff0LL) << 6;
    g32 = (int * __ptr32)(long long)0x1000;
    bad |= (g32 + 1 != (int *)(long long)0x1004) << 7;
    struct mixed m = { 1, (int * __ptr32)(long long)0x40, &x };
    bad |= ((long long)(int *)m.p != 0x40 || *m.q != 7) << 8;
    bad |= (sizeof s != 12 || s.b != 7 || (long long)(int *)s.a != 0x10 || s.c != 0) << 9;
    bad |= ((long long)(int *)table[1] != 0x20 || (long long)(int *)table[2] != -4) << 10;
    int *wide = (int *)(long long)0x123456789LL;
    bad |= ((long long)widen(narrow(wide)) != 0x23456789) << 11;
    return bad;
}
#else
int main(void) { return 0; }
#endif

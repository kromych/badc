// A function has one calling convention, its first declaration's in
// whatever scope that is (C99 6.2.7p2, as gcc and clang take the attribute):
// a declaration naming none, at file scope or in a block, takes it, and the
// calls through every declaration and the definition agree, a block hiding
// the name behind a local included, and a cleanup handler's call where a
// local hides its name. F is the convention foreign to the target. The
// callees write rsi and rdi, which a Microsoft x64 function keeps and a
// System V one does not, so a caller keeping values across the call on the
// wrong convention loses them.
// snapshot-budget: exempt
#ifdef _WIN32
#define F __attribute__((sysv_abi))
#else
#define F __attribute__((ms_abi))
#endif
#if defined(__x86_64__)
#define WRITE_SI_DI() __asm__ volatile("movq $-1, %%rsi\n\tmovq $-1, %%rdi" ::: "rsi", "rdi")
#else
#define WRITE_SI_DI() ((void)0)
#endif
typedef long long ll;

static volatile ll vin[8] = {3, 5, 7, 11, 13, 17, 19, 23};
static volatile int seven = 7;

__attribute__((noinline)) static int block_first(int x) {
    F int add100(int);
    return add100(x + seven);
}

__attribute__((noinline)) static int block_plain(void) {
    int add100(int);
    return add100(2);
}

F int twice(int);

__attribute__((noinline)) static int hidden_by_local(void) {
    int twice = 7;
    {
        int twice(int);
        return twice(5) + 0 * twice(0);
    }
}

__attribute__((noinline)) static int names_foreign(void) {
    F int times3(int);
    return times3(1);
}

__attribute__((noinline)) static ll keeps_values(void) {
    ll x0 = vin[0], x1 = vin[1], x2 = vin[2], x3 = vin[3];
    ll x4 = vin[4], x5 = vin[5], x6 = vin[6], x7 = vin[7];
    int times3(int);
    ll r = times3(seven);
    return r + x0 + 2 * x1 + 3 * x2 + 4 * x3 + 5 * x4 + 6 * x5 + 7 * x6 + 8 * x7;
}

__attribute__((noinline)) int add100(int x) {
    WRITE_SI_DI();
    return x + 100;
}

__attribute__((noinline)) int twice(int x) {
    WRITE_SI_DI();
    return x * 2;
}

F __attribute__((noinline)) int times3(int x) {
    WRITE_SI_DI();
    return x * 3;
}

static int cleaned;

F __attribute__((noinline)) static void fcl(int *p) {
    WRITE_SI_DI();
    cleaned += *p;
}

__attribute__((noinline)) static int cleanup_hidden(int k) {
    int x __attribute__((cleanup(fcl))) = 2;
    {
        int fcl = 9;
        if (k)
            return fcl;
    }
    return 0;
}

int main(void) {
    int bad = 0;
    bad |= (block_first(14) != 121) << 0;
    bad |= (block_plain() != 102) << 1;
    bad |= (hidden_by_local() != 10) << 2;
    bad |= (names_foreign() != 3) << 5;
    ll kept = 3 + 2 * 5 + 3 * 7 + 4 * 11 + 5 * 13 + 6 * 17 + 7 * 19 + 8 * 23;
    bad |= (keeps_values() != 21 + kept) << 3;
    int (F *pf)(int) = add100;
    bad |= (pf(1) != 101) << 4;
    bad |= (cleanup_hidden(1) != 9 || cleaned != 2) << 6;
    return bad != 0;
}

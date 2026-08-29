// __builtin_return_address(N) for N > 0 walks the frame-pointer chain
// the way __builtin_frame_address(N) does and reads the return slot of
// the record it reaches: level N is the return address level 0 reports
// N calls up. Each frame publishes its own level-0 address and the
// addresses of the labels around its call, so the checks compare values
// and code ranges rather than absolute addresses. gcc 16 answers the
// same on linux-x86_64 at -O0 and at -O2 -fno-omit-frame-pointer; its
// aarch64 backend folds a level above 0 to 0 and fails the checks. The
// interpreter has no native frame pointer and links a per-frame record
// of the same shape, whose return slot holds a code position that
// orders against label addresses the way a native address does.
//
// The levels only name the frames the source names while those frames
// exist: `noinline` keeps f1 / f2 / f3 apart, and the volatile store
// after each call keeps the call out of tail position.

void *own1, *own2, *own3;
void *lvl0, *lvl1, *lvl2;
void *before_main, *after_main, *before1, *after1, *before2, *after2;
volatile int sink;

__attribute__((noinline)) static int f3(void) {
    own3 = __builtin_return_address(0);
    lvl0 = __builtin_return_address(0);
    lvl1 = __builtin_return_address(1);
    lvl2 = __builtin_return_address(2);
    return 1;
}

__attribute__((noinline)) static int f2(void) {
    own2 = __builtin_return_address(0);
    before2 = &&call2;
call2:
    sink = f3();
    after2 = &&past2;
past2:
    return sink + 1;
}

__attribute__((noinline)) static int f1(void) {
    own1 = __builtin_return_address(0);
    before1 = &&call1;
call1:
    sink = f2();
    after1 = &&past1;
past1:
    return sink + 1;
}

// The label before the call precedes the call instruction and the one
// after it is at or past the return point.
static int within(void *p, void *lo, void *hi) {
    return (char *) lo < (char *) p && (char *) p <= (char *) hi;
}

int main(void) {
    int r;
    before_main = &&call_main;
call_main:
    r = f1();
    sink = r;
    after_main = &&past_main;
past_main:
    if (r != 3) return 1;
    // Level N in f3 is level 0 in the frame N calls up.
    if (lvl0 != own3) return 2;
    if (lvl1 != own2) return 3;
    if (lvl2 != own1) return 4;
    // Each is the return point of the call in that caller.
    if (!within(lvl0, before2, after2)) return 5;
    if (!within(lvl1, before1, after1)) return 6;
    if (!within(lvl2, before_main, after_main)) return 7;
    // The three calls sit in distinct functions.
    if (lvl0 == lvl1 || lvl1 == lvl2 || lvl0 == lvl2) return 8;
    return 0;
}

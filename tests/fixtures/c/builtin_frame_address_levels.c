// __builtin_frame_address(N) for N > 0 walks the frame-pointer chain:
// level N is the frame address level 0 reports N calls up. Each frame
// publishes its own level-0 address so the checks compare values rather
// than absolute addresses, which are target-dependent. gcc answers the
// same way on linux-x86_64 and linux-aarch64. The interpreter has no
// native frame pointer and links a per-frame record instead, with the
// same chain shape.
//
// The levels only name the frames the source names while those frames
// exist: `noinline` keeps f1 / f2 / f3 apart, and the volatile store
// after each call keeps the call out of tail position. Without both, a
// collapsed frame shifts every level -- which is why gcc documents a
// level above 0 as dependent on the callers keeping their frames.

void *own_main, *own1, *own2, *own3;
void *lvl0, *lvl1, *lvl2, *lvl3;
volatile int sink;

__attribute__((noinline)) static int f3(void) {
    own3 = __builtin_frame_address(0);
    lvl0 = __builtin_frame_address(0);
    lvl1 = __builtin_frame_address(1);
    lvl2 = __builtin_frame_address(2);
    lvl3 = __builtin_frame_address(3);
    return 1;
}

__attribute__((noinline)) static int f2(void) {
    own2 = __builtin_frame_address(0);
    int r = f3();
    sink = r;
    return r + 1;
}

__attribute__((noinline)) static int f1(void) {
    own1 = __builtin_frame_address(0);
    int r = f2();
    sink = r;
    return r + 1;
}

int main(void) {
    own_main = __builtin_frame_address(0);
    if (f1() != 3) return 1;
    if (lvl0 != own3) return 2;
    if (lvl1 != own2) return 3;
    if (lvl2 != own1) return 4;
    if (lvl3 != own_main) return 5;
    // Every level names a distinct frame.
    if (lvl0 == lvl1 || lvl1 == lvl2 || lvl2 == lvl3) return 6;
    return 0;
}

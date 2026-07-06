// The 800-byte local array pushes the frame past the folded shape's
// pair imm7 reach, so the aarch64 prologue keeps the frame-record
// stp / mov fp / `sub sp` shape and stores the two call-crossing
// values as one stp pair at its signed offset; the epilogue keeps the
// paired ldp, `add sp`, and post-indexed fp/lr ldp. Locked by the asm
// snapshot; the exit code checks the array and the restored registers
// survive the call.

int sink(int x) {
    if (x <= 0) return 1;
    return x + sink(x - 1);
}

int bigframe(int a, int b) {
    int buf[200];
    buf[0] = a;
    buf[199] = b;
    int t = sink(buf[0]);
    return t + buf[199] + a + b;
}

int main(void) { return bigframe(3, 4); }  // sink(3)=7; 7+4+3+4 = 18

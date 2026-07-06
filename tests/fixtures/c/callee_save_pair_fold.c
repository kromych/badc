// Five values live across a call occupy five callee-saved GPRs, so
// the aarch64 prologue saves them as two stp pairs plus a single str
// tail. The frame fits the pair imm7 reach, so the whole allocation
// (frame plus the fp/lr slot pair) folds into the first pair's
// pre-index, fp/lr store through the signed-offset pair form at
// [sp, #frame], and fp comes from `add x29, sp, #frame`; the epilogue
// restores fp/lr first and tears the frame down with the final
// restore's post-index. x86_64 keeps its mov-to-slot saves. Locked by
// the asm snapshot; the exit code checks the restores read back intact.

int sink(int x) {
    if (x <= 0) return 1;
    return x + sink(x - 1);
}

int quad(int a, int b, int c, int d, int e) {
    int t = sink(a);
    return t + a + b + c + d + e;
}

int main(void) { return quad(1, 2, 3, 4, 5); }  // 17

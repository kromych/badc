// `n` is live across the call to `hop`, so the SSA allocator
// must place it in a callee-saved register (rbx / r12 / ... on
// SysV-x86_64). The `n < 2` branch then returns `n` directly,
// reading from that register after the epilogue's GPR restore.
// emit_return must stage the integer return into a caller-saved
// reg (rcx) before the restore loop overwrites the source;
// without the staging, rax receives the caller's saved register
// contents instead of `n`.
//
// Returning 7 confirms the staging fired: hop(6) ran, hop_return_n
// returned `n` (= 7), and main propagated that exit code.

int hop(int x);

int hop_return_n(int n) {
    if (n < 2) return n;
    hop(n - 1);
    return n;
}

int hop(int x) { return x + 1; }

int main(void) {
    return hop_return_n(7);
}

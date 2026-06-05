// Assigning a wider value to a narrow local truncates to the local's
// width (C99 6.5.16.1p2): char c = 300 yields 44. The stored register
// holds the full 300, so under -O the slot promotes by lowering the
// load to a sign-extension of that value rather than a plain
// reference; the extension reproduces the truncate-then-extend a
// frame round-trip performs. Returning 0 only when the read is
// correct keeps the check off the exit-code low byte, where 300 and
// 44 would otherwise alias.
int check(int n) {
    char c = n;
    return (c == 44) ? 0 : 1;
}
int main(void) {
    return check(300);
}

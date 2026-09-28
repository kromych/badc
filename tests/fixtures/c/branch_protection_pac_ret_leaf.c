// snapshot-flags: -mbranch-protection=pac-ret+leaf+bti
// `-mbranch-protection=pac-ret+leaf`, as Linux 5.10 to 6.1 build arm64:
// the frameless leaf signs the return address it keeps in x30 (`paciasp`,
// which stands in for the `bti c` landing pad) and authenticates it ahead
// of its `ret`, as the framed caller does. Returns 42.

__attribute__((noinline)) int leaf(int a, int b) { return a * 2 + b; }

int main(void) { return leaf(20, 2); }

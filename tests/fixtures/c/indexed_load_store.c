// Scaled-index loads and stores (a[i], b[i]) folded into the addressing
// mode on AArch64. The loop mixes indexed reads and writes to both
// arrays so base / index operands take a range of register and spill
// placements under the codegen_test pressure caps.

static int work(int *a, int *b, int n, int s) {
    int i;
    int acc = 0;
    for (i = 0; i < n; i++) {
        int x = a[i] + s;
        int y = b[i] - s;
        a[i] = y;
        b[i] = x;
        acc = acc + a[i] * b[i];
    }
    return acc;
}

int main() {
    int a[8];
    int b[8];
    int i;
    for (i = 0; i < 8; i++) {
        a[i] = i + 1;
        b[i] = (i + 1) * 10;
    }
    return work(a, b, 8, 3) == 2940 ? 0 : 1;
}

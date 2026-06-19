// Exercises synthetic stack-slot reuse. Each loop iteration evaluates several
// short-circuit and ternary expressions, whose merge points the SSA builder
// backs with fresh synthetic slots; their live ranges do not overlap across
// iterations, so the slot allocator coalesces them. The merge-heavy
// accumulation must match a second accumulation of the same values written
// with plain if / else, so any slot that is reused while still live corrupts
// one side and the totals diverge.

int main(void) {
    int sum = 0;
    int ref = 0;
    for (int i = 0; i < 64; i++) {
        int x = (i & 1) ? i * 3 : i + 7;
        int y = (x > 10 && x < 100) ? x - 1 : x + 1;
        int z = (y % 2 == 0 || y > 50) ? y * 2 : y;
        sum += z + x + y;

        int rx;
        if (i & 1) {
            rx = i * 3;
        } else {
            rx = i + 7;
        }
        int ry;
        if (rx > 10 && rx < 100) {
            ry = rx - 1;
        } else {
            ry = rx + 1;
        }
        int rz;
        if (ry % 2 == 0 || ry > 50) {
            rz = ry * 2;
        } else {
            rz = ry;
        }
        ref += rz + rx + ry;
    }
    return sum == ref ? 0 : 1;
}

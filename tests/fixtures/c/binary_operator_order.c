// C99 6.5.5-6.5.14: precedence and associativity of the binary operators,
// and the sequence points of `&&` and `||` (6.5.13p4, 6.5.14p4), pinned
// through side effects whose order the standard fixes. Each check exits
// with its own code; success returns 0.

static int n;
static int next(void) { return ++n; }

static int trace[8];
static int at;
static int note(int v) {
    trace[at++] = v;
    return v;
}

int main(void) {
    // `&` binds tighter than `^`, `^` than `|`, and `==` than all three.
    if ((1 | 2 ^ 3 & 4 == 5) != 3) return 1;
    if ((6 & 3 == 3) != 0) return 2;
    if ((1 & 1 | 2) != 3) return 3;
    if ((4 ^ 4 & 4) != 0) return 4;
    // `*` over `+`, `+` over `<<`, `<<` over `<`, `<` over `==`.
    if ((1 << 2 + 1) != 8) return 5;
    if ((2 + 3 * 4 == 14) != 1) return 6;
    if ((1 < 2 == 1) != 1) return 7;
    if ((3 < 2 == 0) != 1) return 8;
    // `|` over `&&`, `&&` over `||`.
    if ((0 || 1 && 0) != 0) return 9;
    if ((0 | 0 || 1 && 1) != 1) return 10;
    if ((1 && 0 | 1) != 1) return 11;
    // Left associativity of `-`, `/`, `==`, `<<`; right of assignment.
    if ((10 - 4 - 3) != 3) return 12;
    if ((64 / 4 / 2) != 8) return 13;
    if ((1 == 1 == 1) != 1) return 14;
    if ((1 << 1 << 2) != 8) return 15;
    int a, b;
    a = b = 5;
    if (a != 5 || b != 5) return 16;

    // The right operand of `&&` / `||` is not evaluated when the left
    // decides.
    n = 0;
    if ((0 && next()) != 0 || n != 0) return 17;
    if ((1 || next()) != 1 || n != 0) return 18;
    if ((1 && next()) != 1 || n != 1) return 19;
    if ((0 || next()) != 1 || n != 2) return 20;
    // A sequence point follows the left operand, so the right operand
    // sees its side effect.
    n = 0;
    if ((++n && n == 1) != 1) return 21;
    if ((n++ || n == 2) != 1 || n != 2) return 22;
    if ((n-- - 2 || n == 1) != 1) return 23;
    // Chains evaluate left to right and stop at the deciding operand.
    at = 0;
    if ((note(1) && note(2) && note(3)) != 1) return 24;
    if (at != 3 || trace[0] != 1 || trace[1] != 2 || trace[2] != 3) return 25;
    at = 0;
    if ((note(0) || note(0) || note(4)) != 1) return 26;
    if (at != 3 || trace[2] != 4) return 27;
    at = 0;
    if ((note(1) && note(0) && note(9)) != 0 || at != 2) return 28;
    at = 0;
    if ((note(0) || note(0) && note(1)) != 0 || at != 2) return 29;
    // `|`, `^`, `&` and `==` evaluate both operands.
    at = 0;
    if ((note(6) | note(1)) != 7 || at != 2) return 30;
    if ((note(6) ^ note(3)) != 5 || at != 4) return 31;
    if ((note(6) & note(3)) != 2 || at != 6) return 32;
    if ((note(6) == note(6)) != 1 || at != 8) return 33;
    // Both operands of `|` are evaluated before `||` decides.
    at = 0;
    if ((note(0) | note(0) || note(1) && note(1)) != 1 || at != 4) return 34;
    return 0;
}

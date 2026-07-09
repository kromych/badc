// GCC statement expressions `({ ... })` (Annex J.5 common extension).
// The value and type of the construct are those of its last
// expression-statement; the enclosed block introduces its own scope.
// Each check exits with a distinct non-zero code on failure so a
// regression points at the offending case; success returns 0.

int calls;

int bump(void) {
    calls++;
    return calls;
}

int main(void) {
    // Value is the last expression-statement.
    int a = ({ int x = 3; int y = 4; x + y; });
    if (a != 7) {
        return 1;
    }

    // Control flow inside the block; value from the trailing expression.
    int s = ({
        int acc = 0;
        for (int i = 1; i <= 5; i++) {
            acc += i;
        }
        acc;
    });
    if (s != 15) {
        return 2;
    }

    // Side effects run exactly once (the block must not be double-walked).
    calls = 0;
    int t = ({ bump(); bump(); }) + ({ int v = bump() * 2; v; });
    if (t != 8 || calls != 3) {
        return 3;
    }

    // Comma-separated declarators, each with a statement-expression
    // initializer that declares its own local.
    calls = 0;
    int p = ({ int m = bump(); m * 10; }), q = ({ int n = bump(); n * 100; });
    if (p != 10 || q != 200 || calls != 2) {
        return 4;
    }

    // Nested statement expressions. inner = 2 (second bump); then
    // r = 2 + 3 (third bump) = 5, with three calls total.
    calls = 0;
    int r = ({ int inner = ({ bump(); bump(); }); inner + bump(); });
    if (r != 5 || calls != 3) {
        return 5;
    }

    // As a plain expression statement: side effects run, value discarded.
    calls = 0;
    ({ bump(); bump(); });
    if (calls != 2) {
        return 6;
    }

    // The `({ __typeof__(a) _a = (a); ... })` shape QEMU's qatomic macros
    // and MIN/MAX expand to.
    int lo = 8, hi = 20;
    int mx = ({ __typeof__(lo) _l = (lo); __typeof__(hi) _h = (hi); _l > _h ? _l : _h; });
    if (mx != 20) {
        return 7;
    }

    return 0;
}

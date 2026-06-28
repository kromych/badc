// IEEE 754 / C99 Annex F: floating division by zero in a constant
// expression yields +/-infinity for a non-zero numerator and NaN for
// 0.0/0.0, rather than a diagnostic. The `1.0 / 0.0` infinity idiom is
// common in static initializers.

static double pos_inf = 1.0 / 0.0;
static double neg_inf = -1.0 / 0.0;
static double not_a_num = 0.0 / 0.0;

// The integer-constant-expression evaluator (the _Static_assert /
// array-size / case-label path) follows the same Annex F rule, not a
// fold-to-zero. These compile only when 1.0/0.0 folds to +infinity and
// 0.0/0.0 to NaN.
_Static_assert((1.0 / 0.0) > 1e308, "1.0/0.0 must fold to +infinity");
_Static_assert((0.0 / 0.0) != (0.0 / 0.0), "0.0/0.0 must fold to NaN");

int main(void) {
    if (!(pos_inf > 1e308)) return 1;
    if (!(neg_inf < -1e308)) return 2;
    if (not_a_num == not_a_num) return 3; // NaN compares unequal to itself
    // A local constant-folded form too.
    double inf = 2.0 / 0.0;
    if (!(inf > 1e308)) return 4;
    return 0;
}

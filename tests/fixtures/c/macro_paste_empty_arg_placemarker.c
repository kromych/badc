// C99 6.10.3.3: an empty macro argument is a placemarker. `placemarker ## x`
// yields `x`, and the token before the placemarker stays a separate token. So
// `return sign##name` with an empty `sign` must expand to `return name`, not
// the glued `returnname`. A non-empty `sign` still pastes (`u`##`int` ->
// `uint`), and a placemarker between two pastes drops out (`a##e##b` -> `ab`).

int int32_to_x(int v) { return v + 1; }
int uint32_to_x(int v) { return v + 2; }

// The failing shape: `return` precedes an empty-argument paste operand.
#define ITOF(sign) return sign##int32_to_x(1)
static int with_empty_sign(void) { ITOF(); }
static int with_u_sign(void) { ITOF(u); }

// Placemarker sandwiched between two pastes collapses to a single token.
#define MID(a, m, b) a##m##b
static int ab_val = 0;
#define ab_ref MID(ab, , _val)

int main(void) {
    if (with_empty_sign() != 2) return 1; // int32_to_x(1) == 2
    if (with_u_sign() != 3) return 2;      // uint32_to_x(1) == 3
    ab_ref = 9;                            // must resolve to `ab_val`
    if (ab_val != 9) return 3;
    return 0;
}

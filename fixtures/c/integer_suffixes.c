// M20 -- integer literal suffixes. The lexer accepts u/U/l/L plus any
// combination (ll, LL, ull, ULL, lu, ...) on decimal and hex literals.
// In c5 the suffix is purely informational; the value is preserved
// verbatim and lives in whatever storage the receiving variable
// declares (4 bytes for `int`, 8 bytes for `long`).

int main() {
    int u, U, l, L, ull, ULL, llu, LLU, lu;
    int hex_u, hex_l, hex_ull;
    // Big values need a real 64-bit slot under M31 -- `int` is 4
    // bytes and would overflow on assignment.
    long big_dec, big_hex;
    int sum;

    u = 1u;
    U = 2U;
    l = 3l;
    L = 4L;
    ull = 5ull;
    ULL = 6ULL;
    llu = 7llu;
    LLU = 8LLU;
    lu = 9lu;

    hex_u = 0xAu;
    hex_l = 0xFFL;
    hex_ull = 0xCAFEULL;

    // Large 64-bit values that would overflow a 32-bit int but fit in
    // c5's 64-bit int. The suffix on the source side is informational;
    // the value still lands in a 64-bit slot.
    big_dec = 1000000000000ll;
    big_hex = 0x100000000ULL;

    if (u   != 1) return 1;
    if (U   != 2) return 2;
    if (l   != 3) return 3;
    if (L   != 4) return 4;
    if (ull != 5) return 5;
    if (ULL != 6) return 6;
    if (llu != 7) return 7;
    if (LLU != 8) return 8;
    if (lu  != 9) return 9;

    if (hex_u   != 10)     return 10;
    if (hex_l   != 255)    return 11;
    if (hex_ull != 0xCAFE) return 12;

    if (big_dec != 1000000000000) return 13;
    if (big_hex != 0x100000000)   return 14;

    sum = 1u + 2L + 3ull + 4LL;
    if (sum != 10) return 15;

    return 0;
}

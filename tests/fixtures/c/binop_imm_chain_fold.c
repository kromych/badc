// Chained `BinopI` reassociation peephole in `Build::binop_imm`.
// Each pair below would otherwise emit two BinopI insts; with
// the fold they collapse to one (and the intermediate becomes
// dead). The result values are observable, the instruction count
// is locked in by the existing `binop_imm_cse_collapses_repeats`
// test plus this fixture's exit code.
#include <stdio.h>

int main(void) {
    int x = 10;
    int s_add_add = (x + 3) + 7;       // 20
    int s_add_sub = (x + 8) - 3;       // 15
    int s_sub_add = (x - 4) + 9;       // 15
    int s_sub_sub = (x - 2) - 5;       // 3
    int s_and = (x & 0xff) & 0x3f;     // 10 & 63 = 10
    int s_or  = (x | 0x01) | 0x02;     // 10 | 1 | 2 = 11
    int s_xor = (x ^ 0x05) ^ 0x06;     // 10 ^ 5 ^ 6 = 9

    int total = s_add_add + s_add_sub + s_sub_add + s_sub_sub
              + s_and + s_or + s_xor;
    // 20 + 15 + 15 + 3 + 10 + 11 + 9 = 83
    printf("%d\n", total);
    return total == 83 ? 0 : 1;
}

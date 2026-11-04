/* A conditional branch whose arms do no work and meet at a block whose
   merges take the same value over either arm decides nothing: it is a
   jump, and the condition is not computed. Branches with a store in an
   arm or a merge of different values stay. */

int same_constant(int k) { int x = 2; if (k) x = 2; return x; }
int both_arms_assign(int k) { int x; if (k) x = 5; else x = 5; return x; }
int or_true(int x) { return x || 1; }
int and_false(int x) { return x && 0; }
int keeps_values(int k) { int x = 1; if (k) x = 2; return x; }
int keeps_store(int k, int *p) { if (k) *p = 1; return 0; }

int main(void) {
    volatile int seed = 3;
    int k = seed, cell = 0;
    if (same_constant(k) != 2 || same_constant(0) != 2) return 1;
    if (both_arms_assign(k) != 5 || both_arms_assign(0) != 5) return 2;
    if (or_true(k) != 1 || or_true(0) != 1) return 3;
    if (and_false(k) != 0 || and_false(0) != 0) return 4;
    if (keeps_values(k) != 2 || keeps_values(0) != 1) return 5;
    if (keeps_store(0, &cell) != 0 || cell != 0) return 6;
    if (keeps_store(k, &cell) != 0 || cell != 1) return 7;
    return 0;
}

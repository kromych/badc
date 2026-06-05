// `for (i=0; i<n; i++) sum += i;` -- two phi classes at the loop
// header (one each for `i` and `sum`), both with a back-edge source
// defined later in PC order than the phi result. The single-source
// back-edge coalesce (ssa_alloc::compute_back_edge_phi_of) handles
// each class independently, so this case already passes under the
// phi-promote override; the fixture pins the expected result so the
// union-find rewrite does not regress it.

int test(int n) {
    int i;
    int sum;
    sum = 0;
    for (i = 0; i < n; i++) sum = sum + i;
    return sum;
}

int main(void) {
    return test(10);
}

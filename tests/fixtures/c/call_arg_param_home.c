// A parameter passed as a call argument in a different position: the
// parameter's home must follow the call's argument register, not its
// incoming register, or the marshal swaps the two sources through the
// scratch. Here the vector parameter reads through the second integer
// register, so the pointer's home moves there at entry and the
// constants land in the neighbouring argument registers without a
// swap. The check writes the scalar arguments back and compares.

typedef float v1f __attribute__((vector_size(4)));

static int got_k, got_j;

__attribute__((noinline)) void take(int k, v1f v, int j) {
    got_k = k;
    got_j = j;
}

void pass(v1f *p) { take(1, *p, 2); }

int main(void) {
    v1f v = {7.0f};
    pass(&v);
    return got_k == 1 && got_j == 2 ? 0 : 1;
}

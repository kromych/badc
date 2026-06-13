// A loop body with nested conditionals produces many local branches
// whose targets sit within the signed 8-bit range, so the x86_64
// emitter relaxes them to the 2-byte rel8 form (`EB`/`7x`). Running the
// function confirms the shortened branches keep their targets across
// both the forward (if/else) and backward (loop) directions.
int classify(int n) {
    int acc = 0;
    for (int i = 0; i < n; i++) {
        if (i % 3 == 0) {
            acc += i;
        } else if (i % 3 == 1) {
            acc -= 1;
        } else {
            acc += 2;
        }
    }
    return acc;
}

int main(void) {
    return classify(10);
}

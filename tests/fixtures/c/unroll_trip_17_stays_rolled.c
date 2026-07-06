/* A trip count above the unroll cap keeps the loop rolled: the SSA
 * snapshot retains the header phi and back edge. */
long acc[17];

int main(void) {
    long i, s = 0;
    for (i = 0; i < 17; i++) acc[i] = i;
    for (i = 0; i < 17; i++) s += acc[i];
    return !(s == 136 && i == 17);
}

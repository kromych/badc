/* A volatile access is performed strictly per the abstract machine
 * (C99 6.7.3p6): the loop must not unroll, and each of the four
 * iterations performs one load and one store. */
volatile long counter;

int main(void) {
    long i;
    for (i = 0; i < 4; i++) counter = counter + 1;
    return !(counter == 4 && i == 4);
}

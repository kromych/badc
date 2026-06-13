// Sieve of Eratosthenes: count the primes below N and check the count
// against the known value. Exercises a dense array write/read loop with a
// multiplicative inner stride and an integer accumulator. Asserted by
// return code.

#define N 100000

static char composite[N];

int main(void) {
    for (int i = 2; (long)i * i < N; i++) {
        if (!composite[i]) {
            for (int j = i * i; j < N; j += i) {
                composite[j] = 1;
            }
        }
    }
    int count = 0;
    for (int i = 2; i < N; i++) {
        if (!composite[i]) {
            count++;
        }
    }
    // pi(100000) = 9592.
    return count == 9592 ? 0 : 1;
}

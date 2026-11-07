// C99 7.20.2, 7.23.2 and 7.21.6.2: rand draws the sequence of the target's
// C library -- glibc's additive generator, Apple's minimal standard one,
// msvcrt's linear congruential one -- from seed 1 before any srand; time
// and clock read the host's clocks; strerror gives the C library's message
// and perror writes it to the standard error.

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main(void) {
    int a = rand(), b = rand();
    srand(1);
    printf("%d %d %d %d|", a == rand(), b == rand(), a, b);
    srand(42);
    printf("%d\n", rand());
    time_t t = 0, now = time(&t);
    printf("%d %d %d %g\n", now > 1600000000, now == t, clock() >= 0, difftime(10, 4));
    printf("%s|%s|%s\n", strerror(ENOENT), strerror(ERANGE), strerror(0));
    errno = EACCES;
    perror("open");
    return 0;
}

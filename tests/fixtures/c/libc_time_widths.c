// C99 7.23.2: time_t / clock_t are 64-bit. A libc value passed or
// returned through a too-narrow `int` prototype is truncated to 32 bits.
// difftime takes two time_t by value, so an `int` parameter truncates an
// argument past 2^31 before the subtraction; time() returns a time_t.
#include <time.h>

int main(void) {
    // 5e9 and 1e9 are both representable in time_t. With int parameters,
    // 5000000000 truncates to 705032704 and the difference goes negative.
    double d = difftime((time_t)5000000000, (time_t)1000000000);
    if (d != 4000000000.0) return 1;

    // time() returns a plausible current epoch, and the value written
    // through the time_t* out-parameter matches the returned value.
    time_t a = time(0);
    time_t b = 0;
    time(&b);
    if (a < 1672531200) return 2;     // before 2023-01-01 UTC is impossible
    if (b < a || b - a > 5) return 3; // same site, a few seconds apart

    return 0;
}

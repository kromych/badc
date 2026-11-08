// A copy of a signaling NaN `float` keeps its bits, raising nothing; the
// conversion to `double` and an arithmetic operation quiet it and raise
// invalid (IEC 60559 5.4.2, 6.2). Exits 0 when all three hold.

#include <fenv.h>
#include <string.h>
int main(void) {
    unsigned in = 0x7f800001, back;
    float f;
    memcpy(&f, &in, 4);
    feclearexcept(FE_ALL_EXCEPT);
    volatile float copy = f;
    float g = copy;
    memcpy(&back, &g, 4);
    if (back != in || fetestexcept(FE_INVALID))
        return 1;
    volatile double d = g;
    double dd = d;
    unsigned long long u;
    memcpy(&u, &dd, 8);
    if (u != 0x7ff8000020000000ull || !fetestexcept(FE_INVALID))
        return 2;
    feclearexcept(FE_ALL_EXCEPT);
    volatile float sum = g + 1.0f;
    float s = sum;
    memcpy(&back, &s, 4);
    return back == 0x7fc00001 && fetestexcept(FE_INVALID) ? 0 : 3;
}

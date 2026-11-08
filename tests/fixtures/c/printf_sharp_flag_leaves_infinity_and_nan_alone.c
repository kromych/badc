// C99 7.19.6.1p8: an infinity converts to `inf` and a NaN to `nan` under
// every `%e %f %g %a` form; the `#` flag shapes finite values only. The
// arguments after such a conversion keep their places.
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <wchar.h>

int main(void)
{
    char b[128];
    snprintf(b, sizeof b, "%#.0e|%#.0f|%#g|%#.0a|%#.0E|%#.0e|%5d|%#x|%s",
             INFINITY, -INFINITY, NAN, -INFINITY, INFINITY, 1.0, 7, 255, "s");
    if (strcmp(b, "inf|-inf|nan|-inf|INF|1.e+00|    7|0xff|s") != 0)
        return 1;
    wchar_t w[64];
    swprintf(w, 64, L"%#.0e|%#G|%#.1f", -INFINITY, INFINITY, 1.5);
    return wcscmp(w, L"-inf|INF|1.5") != 0 ? 2 : 0;
}

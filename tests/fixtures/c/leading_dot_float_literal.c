// C99 6.4.4.2 fractional-constant: the integer part of a
// floating literal is optional, so `.5` parses as a real
// floating constant equal to `0.5`. clang/gcc accept it; c5
// used to drop it as a struct-field-access `.` followed by a
// number, killing every `0.5`-spelt-as-`.5` literal that
// shows up in `kissfft`'s `HALF_OF` macro and similar
// places. This fixture pins the recovery: bare `.5`,
// `.5f`, `.25e2`, and a cast-shape `((float).5)` all hit the
// new lexer path and round-trip to the expected double bit
// patterns.
#include <stdio.h>

int main(void) {
    float a = .5f;
    double b = .25;
    double c = .25e2;        // 25.0
    float d = ((float).5);
    int ok = 1;
    if (a != 0.5f) ok = 0;
    if (b != 0.25) ok = 0;
    if (c != 25.0) ok = 0;
    if (d != 0.5f) ok = 0;
    return ok ? 7 : 0;
}

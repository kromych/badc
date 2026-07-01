// C99 6.7.8p11: an initializer for a scalar object or member is
// converted as in assignment. A runtime initializer element whose type
// differs from the target member type (integer element of a floating
// member, or the reverse) must round through the value conversion, not
// store the raw object representation. The non-constant local
// aggregate / array initializer path previously stored an integer
// element's bit pattern directly into a floating slot, so an int->double
// member read back as a denormal (~0). This also reaches the by-value
// struct ABI: a nested point/size record built from int extents and
// passed by value arrived as zeros.

typedef struct { double x, y; } Point;
typedef struct { double w, h; } Size;
typedef struct { Point origin; Size size; } Rect; // 4 doubles, HFA

__attribute__((noinline)) static int rect_ok(Rect r) {
    return r.origin.x == 0.0 && r.origin.y == 0.0 && r.size.w == 840.0 &&
           r.size.h == 540.0;
}

int main(void) {
    int w = 840, h = 540;

    // Flat struct, integer element -> double member.
    Size s = {w, h};
    if (s.w != 840.0 || s.h != 540.0) return 1;

    // Nested struct (the windowing-frame shape), integer extents.
    Rect r = {{0, 0}, {w, h}};
    if (r.size.w != 840.0 || r.size.h != 540.0) return 2;

    // Array initializer, integer element -> double.
    double a[2] = {w, h};
    if (a[0] != 840.0 || a[1] != 540.0) return 3;

    // Reverse direction: floating element -> integer member truncates.
    double dv = 3.9;
    struct { int p, q; } iv = {dv, 7};
    if (iv.p != 3 || iv.q != 7) return 4;

    // float member fed by a double-typed runtime value (precision narrow).
    float fv = 0.0f;
    struct { float f; } fs = {dv + 0.0};
    fv = fs.f;
    if (fv < 3.89f || fv > 3.91f) return 5;

    // End-to-end: the converted nested record survives a by-value call.
    if (!rect_ok(r)) return 6;
    if (!rect_ok((Rect){{0, 0}, {w, h}})) return 7;

    return 0;
}

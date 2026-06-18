// A struct returned by value through the out-pointer convention (System V
// AMD64 3.2.3: larger than 16 bytes is MEMORY class; Win64: any size
// outside {1,2,4,8} bytes) is reached with the all-integer call path,
// which carries each floating-point argument in an 8-byte integer slot as
// its f64-widened bit pattern and narrows it on read. A float argument
// must therefore be widened to that pattern, not passed as its 4-byte form
// in the low half of the slot. A four-`float` struct is 16 bytes -- in
// registers under System V but through the out-pointer on Win64 -- so the
// Win64 out-pointer path is covered as well; a `double`-argument variant
// is the control that already round-tripped.

typedef struct {
    float a, b, c, d;
} F4; // 16 bytes
typedef struct {
    float a, b, c, d, e;
} F5; // 20 bytes
typedef struct {
    double a, b, c;
} D3; // 24 bytes

static F4 mkf4(float a, float b, float c, float d) {
    F4 r;
    r.a = a;
    r.b = b;
    r.c = c;
    r.d = d;
    return r;
}
static F5 mkf5(float a, float b, float c, float d, float e) {
    F5 r;
    r.a = a;
    r.b = b;
    r.c = c;
    r.d = d;
    r.e = e;
    return r;
}
static D3 mkd3(double a, double b, double c) {
    D3 r;
    r.a = a;
    r.b = b;
    r.c = c;
    return r;
}

int main(void) {
    F4 f4 = mkf4(1.0f, 2.0f, 3.0f, 4.0f);
    if (f4.a != 1.0f || f4.b != 2.0f || f4.c != 3.0f || f4.d != 4.0f)
        return 1;
    F5 f5 = mkf5(1.5f, 2.5f, 3.5f, 4.5f, 5.5f);
    if (f5.a != 1.5f || f5.b != 2.5f || f5.c != 3.5f || f5.d != 4.5f || f5.e != 5.5f)
        return 2;
    D3 d3 = mkd3(10.0, 20.0, 30.0);
    if (d3.a != 10.0 || d3.b != 20.0 || d3.c != 30.0)
        return 3;
    return 0;
}

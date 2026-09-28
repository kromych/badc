// A call through a pointer takes the pointed-to prototype, or the lack of
// one, whatever spells the callee: past the prototype, or with none, a
// `float` argument becomes `double` (C99 6.5.2.2p6), and a declared
// parameter converts its argument (6.5.2.2p7).

double twice(d) double d; { return d * 2; }
double half(double d) { return d / 2; }
long wide(long v) { return v; }

struct holder { double (*f)(); } h = { twice };
double (*table[1])() = { twice };
typedef double (*unproto_t)();
typedef double (*proto_t)(double);

// A file-scope pointer of the name the block-scope one below shadows: the
// call takes the block-scope pointer's type, which has no prototype.
long (*pick)(int);

long through_local(long x) {
    long (*pick)() = wide;
    return pick((long)(int)x);
}

int main(void) {
    double (*p)() = twice;
    void *v = (void *)twice;
    void *w = (void *)half;
    if (h.f(1.5f) != 3.0) return 1;
    if (table[0](1.5f) != 3.0) return 2;
    if ((*p)(1.5f) != 3.0) return 3;
    if (((double (*)())v)(1.5f) != 3.0) return 4;
    if (((unproto_t)v)(1.5f) != 3.0) return 5;
    if (((proto_t)w)(3) != 1.5) return 6;
    if (through_local(0x100000005L) != 5) return 7;
    return 0;
}

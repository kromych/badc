// Aggregates assigned from compound literals: the zero image through a
// pointer at sizes and alignments that split into different store widths,
// into a local, chained, above the inline fill bound, and a literal with a
// non-zero member beside them.

struct A { long long s; long n; };
struct B { char c[3]; };
struct C { int i; short s; char c; };
struct D { char c[13]; };
struct F { long w[75]; };
union U { long l; char c[9]; };

void zero_pointer(struct A *a) { *a = (struct A){}; }
void zero_designated(struct A *a) { *a = (struct A){.n = 0}; }
void zero_bytes(struct B *b) { *b = (struct B){0}; }
void zero_mixed(struct C *c) { *c = (struct C){}; }
void zero_tail(struct D *d) { *d = (struct D){}; }
void zero_union(union U *u) { *u = (union U){}; }
void zero_chained(struct A *a, struct A *b) { *b = *a = (struct A){}; }
void zero_above_bound(struct F *f) { *f = (struct F){}; }
void copy_nonzero(struct A *a) { *a = (struct A){1, 2}; }

long zero_local(void)
{
    struct C x = {1, 2, 3};
    x = (struct C){};
    return x.i + x.s + x.c;
}

int main(void)
{
    struct A a, b;
    struct B bytes;
    struct C mixed;
    struct D tail;
    struct F big;
    union U u;
    copy_nonzero(&a);
    zero_pointer(&a);
    zero_designated(&a);
    zero_bytes(&bytes);
    zero_mixed(&mixed);
    zero_tail(&tail);
    zero_union(&u);
    zero_chained(&a, &b);
    zero_above_bound(&big);
    return (int)(a.s + b.n + bytes.c[2] + mixed.c + tail.c[12] + u.l + big.w[74] + zero_local());
}

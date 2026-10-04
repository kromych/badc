// A structure returned from an inlined function is read by the caller
// after the callee's scope ends. Spliced at -O, the callee's objects
// share the caller's frame: the returned object must keep its storage
// until the caller has copied it, though another object whose address is
// taken starts and ends inside the callee after the returned one was
// written. Returns 0 when every check passes.

struct one {
    int b;
};

struct three {
    long x, y, z;
};

short c;
signed char e;
struct one f;
struct three t;

struct one returned_twice(int m)
{
    struct one o = {0};
    c = 10;
    for (; c <= 0;)
        return o;
    const signed char *p = &e;
    const signed char **q = &p;
    0 != q && m;
    return o;
}

struct three one_of_two(int m)
{
    struct three a = {1, 2, 3};
    struct three b = {4, 5, 6};
    c = 10;
    for (; c <= 0;)
        return a;
    const signed char *p = &e;
    const signed char **q = &p;
    if (0 != q && m)
        return b;
    return a;
}

__attribute__((noinline)) int check_one(int m)
{
    f = returned_twice(m);
    return f.b;
}

__attribute__((noinline)) long check_three(int m)
{
    t = one_of_two(m);
    return t.x * 100 + t.y * 10 + t.z;
}

int main(void)
{
    if (check_one(9) != 0)
        return 1;
    if (check_three(9) != 456)
        return 2;
    if (check_three(0) != 123)
        return 3;
    return 0;
}

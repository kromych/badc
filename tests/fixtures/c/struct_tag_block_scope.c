/* C99 6.2.1 and 6.7.2.3: struct, union, and enum tags have block
   scope. A tag declared inside a nested block shadows a same-named
   tag from any enclosing scope and goes out of scope when the block
   exits; the outer tag's binding is then visible again. */
struct T {
    int x;
};

int main(void) {
    struct T v;
    v.x = 2;
    {
        struct T { int z; };
        struct T inner;
        inner.z = 5;
        if (inner.z != 5) {
            return 1;
        }
    }
    struct T w;
    w.x = 3;
    if (v.x != 2) {
        return 2;
    }
    if (w.x != 3) {
        return 3;
    }
    return 0;
}

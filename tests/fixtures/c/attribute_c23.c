// C23 6.7.12 attribute-specifier-sequence `[[...]]` and the C11
// `_Alignas` keyword. badc acts on `packed` at the type-attribute
// position (see attribute_packed.c) and consumes the rest as advisory
// hints. This fixture exercises the positions a C23 corpus uses: a
// leading attribute on a file-scope declaration, the type-attribute
// position on a struct, a leading attribute on a function definition,
// a block-scope declaration attribute, and a statement attribute
// (`[[fallthrough]]`). `_Alignas` is accepted; the requested alignment
// of more than 8 bytes is not yet honored (see aggregate.rs).

[[noreturn]] void die(void);

// Type-attribute position: `packed` applies to the struct.
struct [[gnu::packed]] P { char c; long l; };

[[maybe_unused]] static int helper(int x) { return x + 1; }

// `_Alignas` on a struct member is parsed and consumed.
struct A { char c; _Alignas(4) int x; };

int classify(int x) {
    int r = 0;
    switch (x) {
    case 1:
        r = 10;
        [[fallthrough]];
    case 2:
        r += 1;
        break;
    default:
        r = -1;
        break;
    }
    return r;
}

int main(void) {
    [[maybe_unused]] int unused = 0;
    struct P p;
    p.c = 1;
    p.l = 2;
    if (sizeof(struct P) != 9) return 1;
    if (p.c != 1 || p.l != 2) return 2;
    if (helper(5) != 6) return 3;
    if (classify(1) != 11) return 4;
    if (classify(2) != 1) return 5;
    if (classify(9) != -1) return 6;
    struct A a;
    a.c = 7;
    a.x = 8;
    if (a.c != 7 || a.x != 8) return 7;
    return 0;
}

void die(void) { for (;;) {} }

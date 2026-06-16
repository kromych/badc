// GCC `__attribute__` may appear in many declaration positions. badc
// acts on `packed` (see attribute_packed.c) and consumes the rest as
// advisory hints without affecting semantics. This fixture exercises
// the positions a real GNU-C corpus uses: declaration specifiers, a
// pointer declarator, a function prototype and definition, a typedef,
// a struct member, and a parameter.

int __attribute__((unused)) g_var = 5;

// Trailing attribute on a prototype, and an attribute inside the
// pointer declarator.
void *__attribute__((malloc)) make(unsigned long n);
int probe(void) __attribute__((pure));

// Leading attribute on a definition.
__attribute__((always_inline)) static int inl(int x) { return x + 1; }

// On a typedef and on a struct member.
typedef int my_int __attribute__((aligned(4)));
struct S {
    int x __attribute__((deprecated));
    my_int y;
};

// On a parameter.
int use(int a __attribute__((unused)), int b) { return b; }

int probe(void) { return 3; }
void *make(unsigned long n) { (void) n; return 0; }

int main(void) {
    if (g_var != 5) return 1;
    if (inl(2) != 3) return 2;
    if (probe() != 3) return 3;
    if (use(100, 7) != 7) return 4;
    struct S s;
    s.x = 11;
    s.y = 22;
    if (s.x != 11 || s.y != 22) return 5;
    if (make(8) != 0) return 6;
    return 0;
}

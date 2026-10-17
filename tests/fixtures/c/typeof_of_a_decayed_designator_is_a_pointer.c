/* A function designator decays in a conditional, a comma and a compound
 * literal's initializer (C99 6.3.2.1p4), so each result is a pointer
 * value: `typeof` names the pointer type and `_Generic` selects it. A
 * designator and `*` on a pointer to a function still name the function
 * type. Returns 0. */
typedef long (*fn_t)(void);

static long h(void) { return 42; }
static long g(void) { return 7; }

int main(int argc, char **argv) {
    (void)argv;
    __typeof__(argc ? h : g) a = g;
    __typeof__((0, h)) b = h;
    __typeof__((fn_t){h}) c = g;
    __typeof__(&(fn_t){h}) pc = &c;
    __typeof__(h) *d = g;
    __typeof__(*a) *e = h;
    if (a() != 7 || b() != 42 || c() != 7 || (*pc)() != 7 || d() != 7 || e() != 42) {
        return 1;
    }
    if (sizeof a != sizeof(fn_t) || sizeof b != sizeof(fn_t) || sizeof c != sizeof(fn_t)) {
        return 2;
    }
    if (_Generic(argc ? h : g, fn_t: 0, default: 1) || _Generic((0, h), fn_t: 0, default: 1)) {
        return 3;
    }
    if (_Generic((fn_t){h}, fn_t: 0, default: 1) || _Generic(&(fn_t){h}, fn_t *: 0, default: 1)) {
        return 4;
    }
    return 0;
}

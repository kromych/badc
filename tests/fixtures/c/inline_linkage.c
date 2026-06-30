// C99 6.7.4p7: a plain `inline` definition whose every declaration in
// the unit is `inline` without `extern` provides no external definition
// -- badc gives it internal linkage so the same inline function in
// another unit does not collide. `static inline` is internal; `extern
// inline` provides the one external definition. All three are callable
// here regardless of the linkage they carry.

inline int inl(int x) { return x + 1; }
static inline int sinl(int x) { return x + 2; }
extern inline int einl(int x) { return x + 3; }

int main(void) {
    return (inl(10) == 11 && sinl(10) == 12 && einl(10) == 13) ? 0 : 1;
}

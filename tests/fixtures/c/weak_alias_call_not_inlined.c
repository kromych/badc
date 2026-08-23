// A weak alias is interposable: a strong definition of the alias name in
// another object replaces it at link time, so a call through the alias
// stays out of line under -O and keeps its relocation instead of inlining
// the target's body. Calls naming the target directly still inline.

int real_fn(void) { return 41; }
int alias_fn(void) __attribute__((weak, alias("real_fn")));

int (*tab)(void) = alias_fn;

int main(void) {
    if (tab() != 41) {
        return 1;
    }
    if (tab != alias_fn) {
        return 2;
    }
    return alias_fn() + 1;
}

// A cast to a pointer to a function-type typedef must not leave the
// function-type marker set for a following declarator. A later function
// returning a pointer would otherwise have its pointer level absorbed
// and be mis-typed as returning void. C99 6.5.4 (cast) + 6.7.7.

typedef void *ReallocFunc(void *opaque, void *ptr, unsigned long size);

static void use(ReallocFunc *f) {
    (void) f;
}

static void caller(void) {
    use((ReallocFunc *) 0);
}

// This function's `void *` return must survive the cast above.
static void *next_fn(void *p, unsigned long n) {
    if (n > 100) {
        return 0;
    }
    return p;
}

int main(void) {
    caller();
    int x = 5;
    return next_fn(&x, 5) == &x ? 0 : 1;
}

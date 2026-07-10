// A self-referential function-like macro -- `#define f(x) f(cast(x))` --
// expands once; the recurring name becomes the real function, while a
// macro in its argument still expands (C99 6.10.3.4). A common shape
// defines the function first, then a shadowing macro that wraps the
// argument in a cast.

struct box { int value; };

#define AS_PTR(p) ((void *)(p))

int unwrap(void *p) {
    return ((struct box *)p)->value;
}

int twice(void *p) {
    return 2 * ((struct box *)p)->value;
}

#define unwrap(ob) unwrap(AS_PTR(ob))
#define twice(ob) twice(AS_PTR(ob))

int main(void) {
    struct box b = {21};
    if (unwrap(&b) != 21) return 1;
    if (twice(&b) != 42) return 2;
    return 0;
}

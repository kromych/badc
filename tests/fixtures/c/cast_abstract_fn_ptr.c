/* C99 6.5.4 / 6.7.7: a cast whose type-name uses an abstract declarator of
   function-pointer shape `(*)(params)` or pointer-to-array shape `(*)[N]`.
   In a constant expression -- a file-scope initializer or a designated
   aggregate member -- it must parse and fold like any other pointer cast.
   `((void (*)(int))0)` is the spelling the signal handler macros use. */

typedef void (*handler_t)(int);

static handler_t g = (void (*)(int))0;

struct s {
    void (*h)(int);
};

int main(void) {
    struct s a = {.h = (void (*)(int))0};
    int (*p)[4] = (int (*)[4])0;
    if (a.h != 0) return 1;
    if (g != 0) return 2;
    if (p != 0) return 3;
    return 0;
}

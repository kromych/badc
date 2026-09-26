// C99 6.5.4: the value of a cast has the cast type. A function pointer
// converted to an object pointer (C99 J.5.7) is dereferenced as that
// object pointer, so `*` loads the object rather than designating a
// function (6.5.3.2p4), whatever expression held the function pointer. A
// cast to a pointer to a function pointer keeps the function type a
// following `*` decays through. Each check exits with its own code;
// success returns 0.

#include <stdint.h>

static int answer(void) { return 42; }
static int (*getfp(void))(void) { return answer; }
typedef int (*fn_t)(void);
static int seven = 7;
static fn_t data_fp(void) { return (fn_t)(void *)&seven; }

struct holder {
    fn_t f;
    fn_t arr[2];
};

int main(void) {
    int x = 5;
    char bytes[4] = {1, 2, 3, 4};
    fn_t fp = (fn_t)(void *)&x;
    struct holder h = {(fn_t)(void *)&x, {(fn_t)(void *)&x, (fn_t)(void *)bytes}};

    if (*(int *)fp != 5) return 1;
    if (*(int *)(void *)fp != 5) return 2;
    if (*(int *)(uintptr_t)fp != 5) return 3;
    if (*(int *)h.f != 5) return 4;
    if (*(int *)h.arr[0] != 5) return 5;
    if (*(char *)h.arr[1] != 1) return 6;
    if (((char *)h.arr[1])[2] != 3) return 7;
    if (sizeof *(char *)fp != 1 || sizeof *(int *)fp != sizeof(int)) return 8;
    if (*(int *)data_fp() != 7) return 9;

    fn_t real = answer;
    fn_t *pp = &real;
    if ((**(fn_t *)pp)() != 42) return 10;
    if ((***(int (**)(void))pp)() != 42) return 11;
    if ((*(fn_t)(void *)getfp())() != 42) return 12;
    return 0;
}

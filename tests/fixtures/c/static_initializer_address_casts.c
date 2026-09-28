// C99 6.6p9 address constants cast to an integer or another pointer type
// initialize static objects -- scalars, members, elements, block-scope
// statics -- as the relocation of the address itself; a cast changes the
// value's type, not its bits. Each check exits with its own code; success
// returns 0.

#include <stdint.h>

struct S {
    int a;
    int m;
};

int g;
int arr[4];
struct S s1, sarr[3];

static int f(void) { return 1; }

intptr_t a1 = (intptr_t)(&g);
intptr_t a2 = (intptr_t)((&g));
uintptr_t a3 = (uintptr_t)f;
intptr_t a4 = ((intptr_t)&g);
void (*a5)(void) = ((void (*)(void))f);
intptr_t a6 = (intptr_t)(char *)&g;
intptr_t a7 = (intptr_t)&arr[1];
intptr_t a8 = (intptr_t)&s1.m;
intptr_t a10 = (intptr_t)arr;
intptr_t a11 = (intptr_t)&((struct S *)0)->m;
uintptr_t a12 = (uintptr_t)(sarr + 1);
intptr_t a13 = (intptr_t)(&arr[0] + 2);
intptr_t a14 = (intptr_t)(1 ? &g : 0);
struct {
    intptr_t v;
    uintptr_t w;
    void *p;
} agg = {(intptr_t)&g, (uintptr_t)f, (void *)(intptr_t)&g};
intptr_t tab[] = {(intptr_t)&g, (intptr_t)(f), (intptr_t)arr};

int main(void) {
    static intptr_t sl = (intptr_t)&g;
    static struct {
        intptr_t v;
    } sagg = {(intptr_t)(&g)};
    intptr_t G = (intptr_t)&g;
    if (a1 != G || a2 != G || a4 != G || a6 != G || a14 != G) return 1;
    if (a3 != (uintptr_t)f || (void *)a5 != (void *)f) return 2;
    if (a7 != (intptr_t)&arr[1] || a8 != (intptr_t)&s1.m || a10 != (intptr_t)arr) return 3;
    if (a11 != 4 || a12 != (uintptr_t)&sarr[1] || a13 != (intptr_t)&arr[2]) return 4;
    if (agg.v != G || agg.w != (uintptr_t)f || agg.p != &g) return 5;
    if (tab[0] != G || tab[1] != (intptr_t)f || tab[2] != (intptr_t)arr) return 6;
    if (sl != G || sagg.v != G) return 7;
    return 0;
}

/* A compound literal of pointer type is an unnamed object (C99 6.5.2.5p4):
 * `&` gives its address, not the pointer it holds, through a typedef too,
 * when the initializer is an array or a function designator that decays,
 * and as an argument or a member's initializer; the object is distinct
 * from its initializer's. Returns 0. */
#include <stdint.h>

typedef char *cp_t;
typedef long (*fn_t)(void);
struct S {
    int a;
};
struct holder {
    fn_t *pp;
};

static int read_through(int *const *pp) { return **pp; }
static long h(void) { return 42; }
static long call_pp(fn_t *p) { return (*p)(); }
static long call_void(void *p) { return (*(fn_t *)p)(); }

int main(void) {
    char buf[] = "lit";
    char *q = buf;
    int v = 7;
    struct S s = {9};
    long (*pf)(void) = 0;
    char **pc = &(char *){q};
    cp_t *pt = &(cp_t){buf + 1};
    char **pa = &(char *){buf};
    int **pi = &(int *){&v};
    struct S **ps = &(struct S *){&s};
    long (**ppf)(void) = &(long (*)(void)){pf};
    if ((uintptr_t)pc == (uintptr_t)q || *pc != q || **pt != 'i' || **pa != 'l') {
        return 1;
    }
    if (**pi != 7 || (*ps)->a != 9 || *ppf != 0 || read_through(&(int *){&v}) != 7) {
        return 2;
    }
    *pc += 2;
    if (**pc != 't' || q != buf) {
        return 3;
    }
    void *pv = &(fn_t){h};
    fn_t *pfn = &(fn_t){h};
    struct holder hd = {&(fn_t){h}};
    if (pv == (void *)h || call_void(pv) != 42 || (*pfn)() != 42 || (*hd.pp)() != 42) {
        return 4;
    }
    if (call_pp(&(fn_t){h}) != 42 || call_pp(&(fn_t){1 ? h : 0}) != 42) {
        return 5;
    }
    return 0;
}

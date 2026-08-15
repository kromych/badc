// A pointer to a typedef'd function TYPE (`typedef RET F(args); F *p`)
// is the same type as the spelled-out function-pointer declarator (C99
// 6.2.7, 6.7.5.1p1): mixed-spelling prototype/definition pairs merge
// silently, `F **` keeps one real deref, and `F (*p)` groups to `F *p`.

typedef void *ReallocFunc(void *opaque, void *ptr, unsigned long size);

struct Range {
    int n;
    void *(*realloc_func)(void *, void *, unsigned long);
};

void cr_init(struct Range *cr, void *opaque,
             void *(*realloc_func)(void *opaque, void *ptr, unsigned long size));

void cr_init(struct Range *cr, void *opaque, ReallocFunc *realloc_func)
{
    (void)opaque;
    cr->n = 7;
    cr->realloc_func = realloc_func;
}

static unsigned long g_last_size;

static void *my_realloc(void *opaque, void *ptr, unsigned long size)
{
    (void)opaque;
    g_last_size = size;
    return ptr;
}

typedef int Fn(int);

static int inc(int x) { return x + 1; }

int apply(int (*p)(int), int v);
int apply(Fn *p, int v) { return p(v); }

int apply2(Fn *p, int v);
int apply2(int (*p)(int), int v) { return (*p)(v); }

int deref_call(int (**pp)(int), int v);
int deref_call(Fn **pp, int v) { return (*pp)(v); }

int grouped(int (*p)(int), int v);
int grouped(Fn (*p), int v) { return p(v); }

typedef Fn *FnPtr;
int via_alias(int (*p)(int), int v);
int via_alias(FnPtr p, int v) { return p(v); }

Fn *gv = inc;

int main(void)
{
    struct Range r;
    int cookie = 5;
    cr_init(&r, 0, my_realloc);
    void *back = r.realloc_func(0, &cookie, 42);
    if (r.n != 7 || g_last_size != 42 || *(int *)back != 5) return 1;
    Fn *v = inc;
    if (apply(v, 1) != 2) return 2;
    if (apply2(v, 2) != 3) return 3;
    if (deref_call(&v, 3) != 4) return 4;
    if (grouped(v, 4) != 5) return 5;
    if (via_alias(v, 5) != 6) return 6;
    if (gv(6) != 7) return 7;
    if (sizeof(Fn *) != sizeof(int (*)(int))) return 8;
    return 0;
}

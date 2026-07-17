/* C99 6.5.2.2 / 6.5.2.3: two back-to-back struct-field-then-call
   expressions where the second call dispatches through a pointer
   stored by the first. The walker used to reuse the previous
   call site's argument expression as the dispatch base for the
   second, so `ctx.vtable->generate(...)` lowered as if `ctx.vtable`
   were one of the arguments passed to `G_VT.init(...)`. The crash
   surfaced under the produce_ssa_funcs flip. Pins the contract
   end-to-end: 42 + 8 = 50. */
#include <stdio.h>

typedef struct vt vt;
typedef struct ctx_s {
    vt *vtable;
    int dummy;
} ctx_s;

struct vt {
    int (*init)(ctx_s *c, vt *params, int seed, int len);
    int (*generate)(ctx_s *c, int *out, int n);
};

extern vt G_VT;

static int my_init(ctx_s *c, vt *params, int seed, int len)
{
    (void)params;
    c->vtable = &G_VT;
    c->dummy = seed + len;
    return 0;
}

static int my_generate(ctx_s *c, int *out, int n)
{
    *out = c->dummy;
    return n;
}

vt G_VT = { my_init, my_generate };
static vt OTHER = { 0, 0 };

int main(void)
{
    ctx_s ctx = { 0 };
    G_VT.init(&ctx, &OTHER, 42, 8);
    int out;
    ctx.vtable->generate(&ctx, &out, 1);
    printf("out=%d\n", out);
    return out;
}

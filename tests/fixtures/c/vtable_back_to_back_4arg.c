/* C99 6.5.2.2p10: argument expressions and the function designator
   may evaluate in unspecified order, but the SSA walker and the
   bytecode parser must AGREE on whichever order they pick, or the
   linker's post-merge resolver pairs Inst::ImmData entries with
   the wrong Op::Imm operands.

   A real-world vtable-init call crashed on
       vtable.init(&ctx.vtable, &base_vtable, seed, len);
   because the walker walked the callee AFTER the args while the
   parser had emitted bytecode for the callee FIRST. The resolver's
   order-zip then patched the v_arg ImmData with the dispatch base's
   merged offset and vice versa; the indirect call loaded its function
   pointer from `&base_vtable + 8` (the desc word) and jumped to
   wild data.

   This fixture mirrors the same shape with two distinct global vtables
   AND a 4-arg call. driver returns 1 + 200 = 201 only when the init
   call actually wired ctx.vtable through to the right struct. */
#include <stdio.h>

typedef struct vt vt;
typedef struct ctx_s {
    vt *vtable;
    int dummy;
} ctx_s;

struct vt {
    int (*init)(ctx_s *c, vt *unused, int seed, int len);
    int (*generate)(ctx_s *c, int *out, int n);
};

extern vt G_VT;
extern vt OTHER_VT;

static int g_init(ctx_s *c, vt *unused, int seed, int len)
{
    (void)unused;
    c->vtable = &G_VT;
    c->dummy = seed + len;
    return 0;
}

static int g_generate(ctx_s *c, int *out, int n)
{
    *out = c->dummy + 100;
    return n;
}

vt G_VT = { g_init, g_generate };
vt OTHER_VT = { 0, 0 };

int driver(void)
{
    ctx_s ctx = { 0 };
    G_VT.init(&ctx, &OTHER_VT, 1, 100);
    int out;
    ctx.vtable->generate(&ctx, &out, 1);
    return out;
}

int main(void)
{
    return driver();
}

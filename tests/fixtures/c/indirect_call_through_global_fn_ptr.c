/* C99 6.5.2.2: indirect call through a simple global function-
   pointer Ident has two operand-emit orders the walker and the
   parser must agree on:

     * Path 1 (this fixture): callee is an Ident of class Glo
       or Loc -- a plain variable holding a function pointer.
       The parser's `()`-after-identifier branch emits args
       first, then the callee's data-imm load, then Jsri. The
       walker mirrors this by deferring the callee walk until
       after the args loop.

     * Path 2 (`vtable_back_to_back_4arg`): callee is a struct
       field or a more complex expression. The parser evaluates
       the FP into the accumulator, spills via Op::StLocI, then
       evaluates args. The walker mirrors this by walking the
       callee first and stashing its ValueId.

   This fixture pins Path 1. The post-merge resolver's order-zip
   between Inst::ImmData entries and bytecode Op::Imm operands
   silently mis-paired the callee's ImmData with the first arg's
   ImmData when the walker took Path 2's order for a Path 1
   callee -- which is the shape sqlite3 shell.c's Windows-only
   beginTimer / endTimer use. */

typedef int (*adder_fn)(int *out, int x, int y);

static int g_out;
static int g_x;
static int g_y;

static int do_add(int *out, int x, int y)
{
    *out = x + y;
    return 0;
}

static adder_fn g_adder = do_add;

int driver(void)
{
    g_x = 7;
    g_y = 35;
    g_adder(&g_out, g_x, g_y);
    return g_out;
}

int main(void)
{
    return driver();
}

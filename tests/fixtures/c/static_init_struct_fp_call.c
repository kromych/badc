// Static-initializer dispatch table -- a `static struct Vtable v
// = { do_add, do_sub };` whose fields hold function pointers, then
// the call sites copy each field into a local and call through it.
// Same shape as struct_initializers.c, minimised so a regression
// shows up here without the surrounding designated/positional
// initializer variants.
//
// Was the regression marker for: on PE/x64 the call landed
// on the c5 function's bare body, but Win64's Jsri lowering had
// already allocated 32 bytes of shadow space before the call, so
// the body's `[rbp+16]` reads pointed into that shadow region
// instead of the c5-stack args. Linux / macOS / PE-arm64 worked
// by accident -- their call ABIs don't reserve shadow space, so
// the args still landed where the body expected. The fix routes
// every `code_relocs` static-init slot through the per-function
// arg-shuffling thunk that already wraps Op::Imm function-pointer
// literals.
#include <stdio.h>

typedef int (*BinOp)(int, int);

static int do_add(int a, int b) { return a + b; }
static int do_sub(int a, int b) { return a - b; }

struct Vtable {
    BinOp add;
    BinOp sub;
};

static struct Vtable v = { do_add, do_sub };

int main() {
    BinOp fn;

    fn = v.add;
    if (fn(2, 3) != 5) return 1;
    fn = v.sub;
    if (fn(10, 4) != 6) return 2;

    return 0;
}

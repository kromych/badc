// C99 6.3.2.1p4: a function-pointer rvalue auto-decays through
// any unary `*` chain. `(*fp)(args)` and `fp(args)` produce the
// same call when `fp` is a function pointer. The c5 parser
// records the indirection level on a local via
// `Symbol::fn_ptr_indirection` so the unary-`*` handler can
// recognise the decay; the lookup at the use site checks
// `Symbol::fn_ptr_indirection` of the named local.
//
// The function-body-top path (`parse_function_body_local_decl`)
// wrote the lineage tag; the inside-block path
// (`parse_block_local_decl`, used for any nested `{ ... }`
// including `else { ... }`, `for (T x = 0; ...; ...)`,
// and any other block-scoped decl) used to skip the write.
// A `lua_KFunction kf = ci->u.c.k;` declaration inside an
// `else` branch therefore left `kf.fn_ptr_indirection = 0`,
// the deref handler took the through-pointer-load branch, and
// `(*kf)(...)` lowered as `Load { kind = I32 }` -- 4 bytes
// sign-extended from the function pointer's bit pattern, then
// called through nonsense.
//
// This fixture pins the lineage propagation by exercising
// every block-scoped declaration path (compound, `else`,
// `for`) and calling through the resulting fn-ptr local.

typedef int (*kfn_t)(int);

static int adder(int x) {
    return x + 100;
}

int main(void) {
    int sum = 0;
    int branch = 1;

    // `else { kfn_t kf = ...; (*kf)(...); }` -- the lua
    // finishCcall shape.
    if (branch == 0) {
        return 1;
    } else {
        kfn_t kf = adder;
        sum += (*kf)(1);    // 101
        sum += kf(2);       // 102
    }

    // for-init declaration: `for (kfn_t fp = adder; ...; ...)`
    // routes through `parse_block_local_decl` as well.
    for (kfn_t fp = adder; fp != 0; fp = 0) {
        sum += (*fp)(3);    // 103
    }

    // Plain nested compound `{ ... }`.
    {
        kfn_t k2 = adder;
        sum += (**(&k2))(4); // 104
    }

    return sum == 410 ? 0 : 2;
}

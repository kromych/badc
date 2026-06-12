// A double-typed argument passed to a float-parameter function pointer
// must narrow to the parameter type (C99 6.5.2.2p7) before the call,
// even when the callee is a non-identifier postfix expression. A float
// literal is typed double in the accumulator, so without the narrowing
// the callee reads the wrong half of the FP register and computes on 0.
//
// The direct-identifier call path already narrows; this covers the
// postfix shapes whose callee parameter types are carried from the
// producing symbol: a function-pointer array element (`tbl[i](x)`), a
// dereferenced function-pointer variable (`(*fp)(x)`), and a
// function-pointer struct field (`s.fp(x)` / `s->fp(x)`).

static float scale2(float x) { return x * 2.0f; }
static float negf(float x) { return -x; }
static float addf(float a, float b) { return a + b; }

int main(void) {
    // Subscripted dispatch table, double-typed literal argument.
    float (*tbl[2])(float) = { scale2, negf };
    if (tbl[0](3.0f) != 6.0f) return 1;
    if (tbl[1](3.0f) != -3.0f) return 2;

    // Variable index, same shape.
    int i = 0;
    if (tbl[i](4.0f) != 8.0f) return 3;

    // Two float parameters through a table entry.
    float (*tbl2[1])(float, float) = { addf };
    if (tbl2[0](1.5f, 2.0f) != 3.5f) return 4;

    // Dereferenced function-pointer variable.
    float (*fp)(float) = scale2;
    if ((*fp)(5.0f) != 10.0f) return 5;

    // A float lvalue argument was always correct; keep it as a guard
    // that the narrowing path does not corrupt an already-float value.
    float v = 7.0f;
    if (tbl[0](v) != 14.0f) return 6;

    // Function-pointer struct fields, called through a value and a
    // pointer (the vtable shape).
    struct Ops {
        float (*g)(float);
        float (*add)(float, float);
    };
    struct Ops ops = { scale2, addf };
    struct Ops *po = &ops;
    if (ops.g(3.0f) != 6.0f) return 7;
    if (po->g(3.0f) != 6.0f) return 8;
    if (po->add(1.5f, 2.0f) != 3.5f) return 9;

    return 0;
}

// C99 6.7.5.3: a function whose return type is a function-pointer
// typedef has its own parameter list. A prior version recorded the
// typedef's pointee parameters as the function's parameters on the
// prototype, so the prototype and the definition disagreed (a spurious
// redeclaration mismatch) and a call placed through the prototype
// type-checked against the wrong parameter list. Declare such a
// function, call it through its prototype before the definition, and
// use the returned pointer.

typedef int (*binop)(int a, int b);

static int add(int a, int b) { return a + b; }

binop pick(int which); // prototype: returns binop, takes one int

static binop via_proto(void) { return pick(7); } // call through the prototype

binop pick(int which) {
    (void)which;
    return add;
}

int main(void) {
    binop f = via_proto();
    return (f(20, 22) == 42) ? 0 : 1;
}

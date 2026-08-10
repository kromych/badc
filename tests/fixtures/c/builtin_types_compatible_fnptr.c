// C99 6.7.5.3p15 function-type compatibility through
// `__builtin_types_compatible_p`: two function types are compatible when
// their return types are compatible and their parameter lists agree. A
// declarator with no prototype (`T ()`) is compatible with a prototyped,
// non-variadic one whose parameters are unchanged by the default argument
// promotions. Pointer depth participates, so a function type is never
// compatible with a pointer to it. Every expectation below matches gcc
// and clang. Returns 0 on success; distinct non-zero per failure.

typedef int (*initcall_t)(void);
typedef int (*noproto_t)();
typedef long (*retlong_t)(void);
typedef int (*oneparam_t)(int);
typedef int (fn_t)(void);

int f(void);
int g(int);
long h(void);

// A function-pointer typedef against the address of a matching function,
// spelled directly and through the `typeof`-of-both-operands form a
// compile-time type guard uses.
_Static_assert(__builtin_types_compatible_p(initcall_t, __typeof__(&f)) == 1, "fnptr ~ &f");
_Static_assert(__builtin_types_compatible_p(__typeof__(initcall_t), __typeof__(&f)) == 1, "same_type");
_Static_assert(__builtin_types_compatible_p(retlong_t, __typeof__(&h)) == 1, "long ret");
_Static_assert(__builtin_types_compatible_p(initcall_t, __typeof__(&g)) == 0, "&g mismatch");

// The typedef against the same type spelled out as an abstract
// function-pointer declarator.
_Static_assert(__builtin_types_compatible_p(initcall_t, int (*)(void)) == 1, "spelled out");
_Static_assert(__builtin_types_compatible_p(oneparam_t, int (*)(int)) == 1, "one param");

// Return types must be compatible.
_Static_assert(__builtin_types_compatible_p(initcall_t, retlong_t) == 0, "ret type");
_Static_assert(__builtin_types_compatible_p(void (*)(void), int (*)(void)) == 0, "void ret");

// Parameter lists must agree, including arity and signedness.
_Static_assert(__builtin_types_compatible_p(initcall_t, oneparam_t) == 0, "param list");
_Static_assert(__builtin_types_compatible_p(int (*)(int, int), int (*)(int)) == 0, "arity");
_Static_assert(__builtin_types_compatible_p(int (*)(unsigned), int (*)(int)) == 0, "signedness");

// A top-level qualifier on a parameter is dropped (6.7.5.3p15).
_Static_assert(__builtin_types_compatible_p(int (*)(int), int (*)(const int)) == 1, "param qual");

// An unspecified parameter list is compatible with a prototype whose
// parameters survive the default argument promotions, and only then.
_Static_assert(__builtin_types_compatible_p(initcall_t, noproto_t) == 1, "() ~ (void)");
_Static_assert(__builtin_types_compatible_p(int (*)(), int (*)(void)) == 1, "() ~ (void) spelled");
_Static_assert(__builtin_types_compatible_p(int (*)(), int (*)(int)) == 1, "() ~ (int)");
_Static_assert(__builtin_types_compatible_p(int (*)(), int (*)(char)) == 0, "() !~ (char)");
_Static_assert(__builtin_types_compatible_p(int (*)(), int (*)(int, ...)) == 0, "() !~ variadic");

// Pointer depth participates: a function type is not its own pointer, and
// an extra level of indirection is a distinct type.
_Static_assert(__builtin_types_compatible_p(initcall_t, fn_t) == 0, "fn !~ fnptr");
_Static_assert(__builtin_types_compatible_p(fn_t, int (void)) == 1, "fn typedef ~ fn");
_Static_assert(__builtin_types_compatible_p(initcall_t, __typeof__(f)) == 0, "typeof(f)");
_Static_assert(__builtin_types_compatible_p(initcall_t, int (**)(void)) == 0, "extra ptr");

// A function pointer is not an object pointer or an integer.
_Static_assert(__builtin_types_compatible_p(initcall_t, void *) == 0, "void *");
_Static_assert(__builtin_types_compatible_p(int (*)(void), int *) == 0, "int *");
_Static_assert(__builtin_types_compatible_p(int (*)(void), int) == 0, "int");

int main(void) { return 0; }

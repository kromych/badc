// GCC `__builtin_*` macro thunks.
//
// Defining `__GNUC__` makes code reach for the GCC builtins. The ones
// handled here as macros rather than in the compiler are those whose
// value is an expression built from the operands: the hints with no
// code-generation effect, and the infinity / NaN constants.
//
// Every other builtin is supplied by the compiler, which is what keeps
// it out of reach of a translation unit's macros. In particular the
// builtins equivalent to a library function -- `__builtin_strlen` and
// the rest -- bind to that function through the symbol table, so a unit
// that defines a macro of the library name (as the fortified string
// headers do) still gets the builtin from the `__builtin_` spelling.

#pragma once

#define __builtin_expect(exp, c) (exp)
#define __builtin_prefetch(...) ((void) 0)
#define __builtin_assume_aligned(p, ...) (p)
// GCC exposes the infinity / NaN constants as builtins. The double form
// overflows to +inf the same way <math.h>'s INFINITY does; the float and
// long-double forms cast that value, and NaN is 0.0/0.0. The NaN payload
// string argument is ignored.
#define __builtin_inf() (1.0e+308 * 10.0)
#define __builtin_huge_val() (1.0e+308 * 10.0)
#define __builtin_inff() ((float)(1.0e+308 * 10.0))
#define __builtin_huge_valf() ((float)(1.0e+308 * 10.0))
#define __builtin_infl() ((long double)(1.0e+308 * 10.0))
#define __builtin_huge_vall() ((long double)(1.0e+308 * 10.0))
#define __builtin_nan(s) (0.0 / 0.0)
#define __builtin_nanf(s) ((float)(0.0 / 0.0))
// Convert between the raw and "real" return address. Both are identity:
// `__builtin_return_address` already strips the aarch64 authentication
// code, and no supported target carries other flag bits there. gcc and
// clang define the pair the same way on aarch64.
#define __builtin_extract_return_addr(a) (a)
#define __builtin_frob_return_addr(a) (a)
// `__builtin_choose_expr` and `__builtin_constant_p` are first-class
// builtins handled by the compiler: the chosen `choose_expr` operand IS
// the expression, keeping its exact type (a `?:` rewrite would apply the
// usual arithmetic conversions and widen, e.g., a chosen `bool`);
// `constant_p` folds to 1 when its unevaluated operand is a constant
// expression, else 0.

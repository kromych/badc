// GCC integer absolute-value builtin thunks.
//
// Split out of <_builtins.h>, which every translation unit gets: the
// compiler evaluates these three itself in a constant expression, and a
// macro defined up front would replace the spelling before it got
// there. Auto-included when one of them is used where the constant
// evaluator does not run, so the library function supplies the value.

#pragma once

#define __builtin_abs abs
#define __builtin_labs labs
#define __builtin_llabs llabs

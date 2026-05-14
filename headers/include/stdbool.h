// stdbool.h -- C99 (7.16) boolean type and value macros.
//
// c5 already accepts `_Bool` as a 1-byte integer modifier; this
// header lets the user spell it `bool` and use the conventional
// `true` / `false` constants. The C99 spec says `__bool_true_false_are_defined`
// is defined to the constant 1 by this header; some sources test it.

#pragma once

#define bool _Bool
#define true 1
#define false 0
#define __bool_true_false_are_defined 1

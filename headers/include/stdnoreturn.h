// stdnoreturn.h -- C11 (7.23) `noreturn` macro.
//
// Maps the keyword `noreturn` to `_Noreturn`. c5 accepts both as
// no-op function specifiers (declared in the lexer keyword
// table), so this header exists mainly so user code with
// `#include <stdnoreturn.h>` doesn't trip the missing-include
// warning. The macro form is the C11-standard spelling
// (7.23p2: "The header <stdnoreturn.h> defines the macro
// `noreturn`, which expands to `_Noreturn`.").

#pragma once

#define noreturn _Noreturn

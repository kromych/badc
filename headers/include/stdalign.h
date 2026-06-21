// stdalign.h -- C11 7.15 alignment macros.
//
// The `_Alignas` and `_Alignof` keywords are spelled `alignas` and
// `alignof` through these macros. C23 promotes both to keywords and
// makes this header empty, but the macro form stays valid, so the
// definitions are unconditional.

#pragma once

#define alignas _Alignas
#define alignof _Alignof

#define __alignas_is_defined 1
#define __alignof_is_defined 1

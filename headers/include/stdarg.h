// stdarg.h -- variadic-argument access for c5.
//
// `va_list` is a pointer that walks the c5 stack starting just past
// the last named argument. c5's cdecl push order parks the first
// declared parameter at val=2 (`bp + 16`) and successive parameters
// at val=3, val=4, ...; the variadic tail begins at val=N+2 where N
// is the fixed-arg count.
//
// Each c5 stack slot is 16 bytes (8 bytes of value + 8 bytes of
// pad), and an `int *` in c5 advances 8 bytes per `+1`, so "skip
// one slot" is `+2`.
//
// Usage:
//
//   int sum(int count, ...) {
//       va_list ap;
//       int total;
//       int i;
//       total = 0;
//       va_start(ap, count);
//       i = 0;
//       while (i < count) {
//           total = total + va_arg(ap, int);
//           i = i + 1;
//       }
//       va_end(ap);
//       return total;
//   }
//
// `va_arg(ap, T)` advances `ap` by one slot and yields the slot it
// just stepped over, cast to `T`. The expansion uses the c5 dialect's
// comma operator, so the advance-and-read happens in a single
// expression.

#pragma once

// c5 doesn't have typedef, so va_list is a #define that expands to
// the underlying int * type. `va_list ap;` becomes `int * ap;`.
#define va_list            int *

#define va_start(ap, last) ap = ((int *)&(last)) + 2
#define va_arg(ap, T)      (ap = ap + 2, *(T *)(ap - 2))
#define va_end(ap)

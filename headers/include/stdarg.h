// stdarg.h -- variadic-argument access for c5.
//
// `va_list` is a pointer that walks the c5 stack starting just past
// the last named argument. c5's cdecl push order parks the first
// declared parameter at val=2 (`bp + 16`) and successive parameters
// at val=3, val=4, ...; the variadic tail begins at val=N+2 where N
// is the fixed-arg count.
//
// Each c5 stack slot is 16 bytes (8 bytes of value + 8 bytes of
// pad). Pointer arithmetic on `long long *` strides 8 bytes per
// `+1` on every supported target -- LP64 (Linux/macOS) and LLP64
// (Windows) both -- so "skip one 16-byte slot" is `+2`. We use
// `long long *` rather than `long *` because `long` is only 4
// bytes on Windows LLP64 and `long *` would stride 4 there,
// landing mid-slot. `int *` has the same 4-byte-stride problem
// on every target.
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

// `va_list` is just a cursor over the c5 stack. Storing it as
// `long long *` means pointer arithmetic strides 8 bytes
// everywhere -- one half of a c5 16-byte slot -- so the `+2` in
// the macros below advances exactly one slot on LP64 (Linux/macOS)
// and LLP64 (Windows) alike. `int *` (4-byte stride) and `long *`
// (4 on Windows, 8 on LP64) would both land mid-slot somewhere.
typedef long long *va_list;

#define va_start(ap, last) ap = ((long long *)&(last)) + 2
#define va_arg(ap, T)      (ap = ap + 2, *(T *)(ap - 2))
#define va_end(ap)

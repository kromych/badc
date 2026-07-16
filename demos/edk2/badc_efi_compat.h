/* Force-included ahead of edk2's Base.h (via the BADC toolchain-def
   CC flags) so badc satisfies the GCC/clang builtins edk2 uses for the
   UEFI ABI. UEFI x64 is the Microsoft ABI, which badc's windows-x64
   target implements natively, so the ms-variants alias the plain
   variadic builtins badc already provides. */
#ifndef BADC_EFI_COMPAT_H
#define BADC_EFI_COMPAT_H

#include <stdarg.h>

/* edk2 Base.h: typedef __builtin_ms_va_list VA_LIST; -- used as a bare
   type before any header, so the compiler is expected to provide it.
   On the windows target va_list already carries the Microsoft ABI. */
typedef va_list __builtin_ms_va_list;
typedef va_list __builtin_va_list;

#define __builtin_ms_va_start(ap, last) va_start(ap, last)
#define __builtin_ms_va_arg(ap, t)      va_arg(ap, t)
#define __builtin_ms_va_end(ap)         va_end(ap)
#define __builtin_ms_va_copy(d, s)      va_copy(d, s)

#endif /* BADC_EFI_COMPAT_H */

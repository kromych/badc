/* Force-included ahead of edk2's Base.h (via the BADC toolchain-def
   CC flags) so badc satisfies the GCC/clang builtins edk2 uses for the
   UEFI ABI. UEFI x64 is the Microsoft ABI, which badc's windows-x64
   target implements natively, so the ms-variants map onto badc's plain
   variadic intrinsics.

   This header does NOT include <stdarg.h>. It is force-included first for
   every module; a CryptoPkg module carries `-I CryptoPkg/Library/Include`
   on its command line, where edk2 keeps its own OpenSSL CRT <stdarg.h>
   shim that pulls in CrtLibSupport.h. Resolving <stdarg.h> to that shim
   here would process CrtLibSupport.h's architecture check before AutoGen.h
   has included ProcessorBind.h to define MDE_CPU_X64. Using badc's
   __builtin_va_* intrinsics directly avoids the shadowed header. */
#ifndef BADC_EFI_COMPAT_H
#define BADC_EFI_COMPAT_H

/* edk2 Base.h: `typedef __builtin_ms_va_list VA_LIST;` -- used as a bare
   type before any header. On badc's windows-x64 target va_list is a single
   void* cursor over the Microsoft-ABI home/stack area. */
typedef void *__builtin_ms_va_list;
typedef void *__builtin_va_list;

/* Declare badc's variadic intrinsics -- normally advertised by badc's own
   <stdarg.h>, which this header no longer pulls in. badc's __builtin_va_arg
   takes the ADDRESS of the va_list storage and returns the address of the
   next argument slot; the caller dereferences it (badc <stdarg.h> contract).
   edk2's Base.h VA_ARG instead expands to `(TYPE)(__builtin_va_arg (Marker,
   TYPE))`: it passes the VA_LIST by name and does not dereference. Bridge the
   two with a function-like macro named after the intrinsic -- it rewrites each
   use to `*(TYPE *)__builtin_va_arg(&Marker, TYPE)`. The macro name is not
   re-expanded inside its own body (C99 6.10.3.4), so the inner reference
   reaches the intrinsic. */
#pragma intrinsic("__builtin_va_start")
#pragma intrinsic("__builtin_va_arg")
#pragma intrinsic("__builtin_va_end")
#pragma intrinsic("__builtin_va_copy")
void  __builtin_va_start(void **ap, void *last_addr);
void *__builtin_va_arg(void **ap, ...);
void  __builtin_va_end(void **ap);
void  __builtin_va_copy(void **dst, void **src);

#define __builtin_va_arg(Marker, TYPE)  (*(TYPE *)__builtin_va_arg(&(Marker), TYPE))

/* The ms-variant builtins edk2's Base.h uses for VA_START / VA_END / VA_COPY.
   badc's intrinsics take the address of the va_list storage (the windows
   cursor form). VA_ARG defers to the bridged __builtin_va_arg above. */
#define __builtin_ms_va_start(ap, last) __builtin_va_start(&(ap), (void *)&(last))
#define __builtin_ms_va_arg(ap, t)      __builtin_va_arg(ap, t)
#define __builtin_ms_va_end(ap)         __builtin_va_end(&(ap))
#define __builtin_ms_va_copy(d, s)      __builtin_va_copy(&(d), &(s))

#endif /* BADC_EFI_COMPAT_H */

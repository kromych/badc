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
   <stdarg.h>, which this header no longer pulls in. Each takes the ADDRESS of
   the va_list storage; __builtin_va_arg returns the address of the next
   argument slot and the caller dereferences it (badc <stdarg.h> contract).
   edk2's Base.h uses these builtins BY NAME: the x64 MS-ABI path through
   __builtin_ms_va_start + __builtin_va_arg(Marker, TYPE), the AArch64 GCC path
   through __builtin_va_start / _arg / _end / _copy (Marker, ...) directly --
   passing the VA_LIST rather than its address (and VA_ARG without a
   dereference). Bridge each with a function-like macro named after the
   intrinsic: it rewrites the use to pass &Marker (and, for VA_ARG, to
   dereference). A macro name is not re-expanded inside its own body
   (C99 6.10.3.4), so the inner reference reaches the intrinsic. */
#pragma intrinsic("__builtin_va_start")
#pragma intrinsic("__builtin_va_arg")
#pragma intrinsic("__builtin_va_end")
#pragma intrinsic("__builtin_va_copy")
void  __builtin_va_start(void **ap, void *last_addr);
void *__builtin_va_arg(void **ap, ...);
void  __builtin_va_end(void **ap);
void  __builtin_va_copy(void **dst, void **src);

#define __builtin_va_start(Marker, Parameter)  __builtin_va_start(&(Marker), (void *)&(Parameter))
#define __builtin_va_arg(Marker, TYPE)         (*(TYPE *)__builtin_va_arg(&(Marker), TYPE))
#define __builtin_va_end(Marker)               __builtin_va_end(&(Marker))
#define __builtin_va_copy(Dest, Start)         __builtin_va_copy(&(Dest), &(Start))

/* The ms-variants (x64 Base.h path) defer to the bridged builtins above. */
#define __builtin_ms_va_start(ap, last)  __builtin_va_start(ap, last)
#define __builtin_ms_va_arg(ap, t)       __builtin_va_arg(ap, t)
#define __builtin_ms_va_end(ap)          __builtin_va_end(ap)
#define __builtin_ms_va_copy(d, s)       __builtin_va_copy(d, s)

#endif /* BADC_EFI_COMPAT_H */

/* Force-included ahead of edk2's Base.h (via the BADC toolchain-def
   CC flags) so badc satisfies the GCC/clang builtins edk2 uses for the
   UEFI ABI. UEFI x64 is the Microsoft ABI, which badc's windows-x64
   target implements natively, so the ms-variants map onto badc's plain
   variadic builtins.

   This header does NOT include <stdarg.h>. It is force-included first for
   every module; a CryptoPkg module carries `-I CryptoPkg/Library/Include`
   on its command line, where edk2 keeps its own OpenSSL CRT <stdarg.h>
   shim that pulls in CrtLibSupport.h. Resolving <stdarg.h> to that shim
   here would process CrtLibSupport.h's architecture check before AutoGen.h
   has included ProcessorBind.h to define MDE_CPU_X64. No shim is needed:
   `__builtin_va_list` and the __builtin_va_* operations are compiler
   builtins with the GCC call shapes (VA_LIST passed by name, VA_ARG
   yields the value), so edk2's Base.h uses them directly; only the
   ms-variant spellings need mapping. */
#ifndef BADC_EFI_COMPAT_H
#define BADC_EFI_COMPAT_H

/* edk2 Base.h: `typedef __builtin_ms_va_list VA_LIST;` -- used as a bare
   type before any header. On badc's windows targets `__builtin_va_list`
   is the same single cursor over the Microsoft-ABI home/stack area. */
typedef __builtin_va_list __builtin_ms_va_list;

#define __builtin_ms_va_start(ap, last)  __builtin_va_start(ap, last)
#define __builtin_ms_va_arg(ap, t)       __builtin_va_arg(ap, t)
#define __builtin_ms_va_end(ap)          __builtin_va_end(ap)
#define __builtin_ms_va_copy(d, s)       __builtin_va_copy(d, s)

#endif /* BADC_EFI_COMPAT_H */

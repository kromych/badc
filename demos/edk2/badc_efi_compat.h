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

/* badc's __builtin_va_start / _arg / _end / _copy take the address of the
   va_list storage (the windows cursor form); _arg yields a pointer to the
   fetched slot. Mirror badc's own <stdarg.h> macros. */
#define __builtin_ms_va_start(ap, last) __builtin_va_start(&(ap), (void *)&(last))
#define __builtin_ms_va_arg(ap, t)      (*(t *)__builtin_va_arg(&(ap), t))
#define __builtin_ms_va_end(ap)         __builtin_va_end(&(ap))
#define __builtin_ms_va_copy(d, s)      __builtin_va_copy(&(d), &(s))

#endif /* BADC_EFI_COMPAT_H */

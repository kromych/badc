/* Sweep measurement shim: badc does not provide the `__builtin_va_list`
   type name. Supply the per-target register-save-area layout (the same one
   badc's own stdarg.h uses) and bind the __builtin_va_* intrinsics so a
   freestanding <stdarg.h> replacement that typedefs __builtin_va_list
   parses. Compile-only: not ABI-audited for direct __builtin_va_start
   calls that pass the last parameter by value. */
#ifndef __C5_VALIST_SHIM_H
#define __C5_VALIST_SHIM_H
#if defined(__x86_64__)
typedef struct {
    unsigned int gp_offset;
    unsigned int fp_offset;
    void *overflow_arg_area;
    void *reg_save_area;
} __c5_va_tag;
#else
typedef struct {
    void *__stack;
    void *__gr_top;
    void *__vr_top;
    int __gr_offs;
    int __vr_offs;
} __c5_va_tag;
#endif
typedef __c5_va_tag __builtin_va_list[1];
#pragma intrinsic("__builtin_va_start")
#pragma intrinsic("__builtin_va_arg")
#pragma intrinsic("__builtin_va_end")
#pragma intrinsic("__builtin_va_copy")
void __builtin_va_start(__builtin_va_list ap, ...);
void *__builtin_va_arg(__builtin_va_list ap, ...);
void __builtin_va_end(__builtin_va_list ap);
void __builtin_va_copy(__builtin_va_list dst, __builtin_va_list src);
#endif

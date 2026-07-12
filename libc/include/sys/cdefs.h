/* BSD/Darwin <sys/cdefs.h>: the decoration macros system headers wrap
** declarations in. For a plain C compiler they carry no effect. */
#pragma once

#define __BEGIN_DECLS
#define __END_DECLS
#define __THROW
#define __pure
#define __const const
#define __restrict restrict
#define __dead2
#define __pure2
#define __unused
#define __used
#define __deprecated
#define __restrict_arr
#define __P(protos) protos
#define __DARWIN_ALIAS(sym)
#define __DARWIN_ALIAS_C(sym)
#define __DARWIN_ALIAS_I(sym)
#define __DARWIN_INODE64(sym)
#define __GNUC_PREREQ(maj, min) 0

/* glibc <sys/cdefs.h> decoration macros, in the fallback forms glibc
** itself uses when __GNUC_PREREQ fails. System headers layered over
** this file (iconv.h, ...) reference them unconditionally. */
#define __attribute_malloc__
#define __attr_dealloc(dealloc, argno)
#define __attr_dealloc_free
#define __attribute_alloc_size__(params)
#define __attribute_alloc_align__(param)
#define __attribute_pure__
#define __attribute_const__
#define __attribute_used__
#define __attribute_noinline__
#define __attribute_deprecated__
#define __attribute_deprecated_msg__(msg)
#define __attribute_format_arg__(x)
#define __attribute_format_strfmon__(a, b)
#define __attribute_nonstring__
#define __attribute_warn_unused_result__
#define __attribute_artificial__
#define __attribute_maybe_unused__
#define __wur
#define __nonnull(params)
#define __returns_nonnull
#define __always_inline __inline__
#define __extern_inline extern __inline__
#define __extern_always_inline extern __inline__
#define __fortify_function extern __inline__
#define __glibc_likely(cond) (cond)
#define __glibc_unlikely(cond) (cond)
#define __glibc_macro_warning(message)
#define __glibc_has_attribute(attr) 0
#define __glibc_has_builtin(name) 0
#define __glibc_has_extension(ext) 0

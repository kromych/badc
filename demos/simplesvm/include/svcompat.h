/* MSVC/SAL spellings the SimpleSvm sources use that are not codegen
 * directives. Passed with -include so they are visible before the first
 * source line, mirroring demos/simplevisor/include/shvcompat.h.
 *
 * EXTERN_C and static_assert are language spellings: extern "C" linkage
 * is meaningless in C, and the C11 keyword is _Static_assert in C99
 * mode. The _IRQL / SAL annotations are static-analysis hints with no
 * runtime effect, so they expand to nothing. */
#pragma once

#ifndef EXTERN_C
#define EXTERN_C extern
#endif
#ifndef static_assert
#define static_assert _Static_assert
#endif

/* SAL source-annotation macros (sal.h), object-like forms. */
#define _In_
#define _Out_
#define _Inout_
#define _In_opt_
#define _Out_opt_
#define _In_z_
#define _Check_return_
#define _Must_inspect_result_
#define _Use_decl_annotations_
#define _IRQL_requires_same_
#define _Post_maybenull_
#define _Pre_notnull_
#define _Printf_format_string_

/* SAL annotations that take an argument. */
#define _IRQL_requires_max_(x)
#define _IRQL_requires_min_(x)
#define __drv_allocatesMem(x)
#define __drv_freesMem(x)
#define _Post_writable_byte_size_(x)
#define _Analysis_assume_(x)

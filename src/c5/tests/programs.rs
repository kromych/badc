//! End-to-end tests: load a C source from `tests/fixtures/c/`, compile, run, and
//! check the exit code. These exercise the whole pipeline.

use super::run_fixture;

#[test]
fn arithmetic() {
    assert_eq!(run_fixture("arithmetic.c"), 60);
}

#[test]
fn hex_float_literal() {
    // C99 6.4.4.2 hexadecimal floating constants.
    assert_eq!(run_fixture("hex_float_literal.c"), 0);
}

#[test]
fn bool_normalize_c99() {
    // C99 6.3.1.2 `_Bool` 0/1 normalisation on every conversion.
    assert_eq!(run_fixture("bool_normalize_c99.c"), 0);
}

#[test]
fn compound_literal_block() {
    // C99 6.5.2.5 block-scope compound literals.
    assert_eq!(run_fixture("compound_literal_block.c"), 0);
}

#[test]
fn cast_fn_ptr_call() {
    // C99 6.5.4 cast to an abstract function-pointer type.
    assert_eq!(run_fixture("cast_fn_ptr_call.c"), 0);
}

#[test]
fn struct_arg_in_registers() {
    // C99 6.5.2.2 + AAPCS64 6.8.2: small integer aggregates passed by
    // value in argument registers, with by-value copy semantics.
    assert_eq!(run_fixture("struct_arg_in_registers.c"), 0);
}

#[test]
fn struct_arg_two_eightbyte() {
    // AAPCS64 6.8.2: two two-eightbyte aggregates in one call -- one
    // aggregate's load must not clobber the other's pending base
    // register.
    assert_eq!(run_fixture("struct_arg_two_eightbyte.c"), 0);
}

#[test]
fn struct_arg_by_stack() {
    // System V AMD64 3.2.3: an aggregate larger than two eightbytes is
    // MEMORY class, passed inline on the caller's outgoing stack; the
    // callee copies it from the incoming stack into its own local.
    assert_eq!(run_fixture("struct_arg_by_stack.c"), 0);
}

#[test]
fn wide_char_utf8() {
    // A multibyte UTF-8 code point decodes to its scalar value in a
    // wide char constant and survives the preprocessor in a narrow
    // string literal.
    assert_eq!(run_fixture("wide_char_utf8.c"), 0);
}

#[test]
fn local_aggregate_runtime_init() {
    // A local aggregate initializer mixes a runtime file-scope scalar
    // read with a string-literal char-array member and a constant
    // global address.
    assert_eq!(run_fixture("local_aggregate_runtime_init.c"), 0);
}

#[test]
fn flexible_array_member() {
    // A flexible array member contributes no storage but decays to a
    // pointer-to-element at the field offset for `p->v[i]`.
    assert_eq!(run_fixture("flexible_array_member.c"), 0);
}

#[test]
fn sizeof_array_type_and_binding() {
    // `sizeof(T [N])` sizes the array type; `sizeof(arr)[i]` binds to
    // the full unary-expression.
    assert_eq!(run_fixture("sizeof_array_type_and_binding.c"), 0);
}

#[test]
fn designator_override_and_braced_string() {
    // A duplicate designator re-initializes the whole subobject; a
    // character array accepts a brace-wrapped string literal.
    assert_eq!(run_fixture("designator_override_and_braced_string.c"), 0);
}

#[test]
fn multidim_array_init() {
    // N-dimensional array initializers pad each nesting level to its
    // sub-array span, with inner designators and inferred outer dim.
    assert_eq!(run_fixture("multidim_array_init.c"), 0);
}

#[test]
fn macro_paste_stringize_unexpanded() {
    // `#` and `##` operands substitute the unexpanded argument.
    assert_eq!(run_fixture("macro_paste_stringize_unexpanded.c"), 0);
}

#[test]
fn line_directive() {
    // `#line` retargets `__LINE__`, expands its operand, and reaches
    // `#if` conditions.
    assert_eq!(run_fixture("line_directive.c"), 0);
}

#[test]
fn float_global_init() {
    // A `float` global stores the f32 pattern, not the f64 low bytes.
    assert_eq!(run_fixture("float_global_init.c"), 0);
}

#[test]
fn func_name_array() {
    // `sizeof(__func__)` is the array length, not a decayed pointer.
    assert_eq!(run_fixture("func_name_array.c"), 0);
}

#[test]
fn unary_plus_init_and_param_shadow() {
    // Unary `+` in a constant initializer is identity; a parameter
    // shadows a same-named function.
    assert_eq!(run_fixture("unary_plus_init_and_param_shadow.c"), 0);
}

#[test]
fn fn_ptr_multi_deref() {
    // Repeated `*` on a function decays to the function; a pointer to
    // an incomplete array dereferences address-preservingly.
    assert_eq!(run_fixture("fn_ptr_multi_deref.c"), 0);
}

#[test]
fn const_member_address_init() {
    // C99 6.6: a static initializer may be the constant address of a
    // global's member, array member, or indexed element's member.
    assert_eq!(run_fixture("const_member_address_init.c"), 0);
}

#[test]
fn array_of_struct_brace_elision() {
    // C99 6.7.8p20: a flat value list fills an array of structs with the
    // per-element braces elided; the length follows from the slot count.
    assert_eq!(run_fixture("array_of_struct_brace_elision.c"), 0);
}

#[test]
fn anon_union_init() {
    // C11 6.7.2.1p13: an anonymous union is one positional slot in a
    // brace initializer; an anonymous struct contributes one per member.
    assert_eq!(run_fixture("anon_union_init.c"), 0);
}

#[test]
fn builtin_trap() {
    // __builtin_trap() does not return; a function whose fall-through
    // path ends in it satisfies the non-void return requirement. The
    // trap path is not taken at run time.
    assert_eq!(run_fixture("builtin_trap.c"), 0);
}

#[test]
fn struct_multi_byval() {
    // C99 6.5.2.2: several aggregates of mixed size passed by value in
    // one call, interleaved with scalars, plus aggregate returns. The
    // aggregates consume argument registers and push later scalars onto
    // the host stack, so the ParamRef seed must track the per-ABI
    // register/stack split rather than parameter position.
    assert_eq!(run_fixture("struct_multi_byval.c"), 0);
}

#[test]
fn struct_return_by_value() {
    // C99 6.8.6.4 + AAPCS64 6.9: integer aggregate returns in x0/x1
    // (<= 16 bytes) or through x8 (> 16 bytes).
    assert_eq!(run_fixture("struct_return_by_value.c"), 0);
}

#[test]
fn goto() {
    assert_eq!(run_fixture("goto.c"), 5);
}

#[test]
fn function_pointers() {
    // (10+20) * (10-5) = 150
    assert_eq!(run_fixture("function_pointers.c"), 150);
}

#[test]
fn switch_statement() {
    // a == 2 -> res = 20, falls through to case 3 -> res += 5 -> 25
    assert_eq!(run_fixture("switch_statement.c"), 25);
}

#[test]
fn switch_default_routing() {
    assert_eq!(run_fixture("switch_default_routing.c"), 100);
}

#[test]
fn static_local_shadows_extern_fn() {
    // C99 6.2.1p4: an inner-block `static const T arr[];` shadows
    // an outer function declaration of the same name. The parser's
    // hash-keyed symbol table mutates class/val for the duration
    // of the block and restores them on block exit; the
    // link_unit glo_imm_refs filter must look at class==Glo (not
    // just linkage) so the restored-to-Fun outer state doesn't
    // surface a cross-TU data reference against the operand.
    // driver(1) returns 42 only when the static-local `expect[]`
    // read resolves to the local data segment.
    assert_eq!(run_fixture("static_local_shadows_extern_fn.c"), 42);
}

#[test]
fn indirect_call_through_global_fn_ptr() {
    // C99 6.5.2.2: Path 1 indirect call (callee is a plain Glo
    // Ident holding a function pointer). The walker defers the
    // callee walk past the arg loop so the load-of-function-
    // pointer Inst::ImmData lands after the arg-evaluating
    // Inst::*. driver() returns 42 only when the walker emits
    // every Inst::ImmData against the right Glo offset.
    assert_eq!(run_fixture("indirect_call_through_global_fn_ptr.c"), 42);
}

#[test]
fn for_loop_call_body_and_step() {
    // C99 6.8.5.3: the walker mirrors the parser's step-before-
    // body block layout (so the post-merge linker rebase keeps
    // the i-th `Inst::Call` referring to the same callee the
    // C source named). driver() returns 7 (add_one count) * 6 =
    // 42 only when both calls resolve to their own targets.
    assert_eq!(run_fixture("for_loop_call_body_and_step.c"), 42);
}

#[test]
fn vtable_back_to_back_4arg() {
    // Same contract as `vtable_back_to_back` but with a 4-arg
    // init call. driver() = 1 + 100 + 100 = 201 only when the
    // walker's callee-before-args evaluation lays Inst out so
    // each `Inst::CallIndirect` target resolves through the
    // right vtable slot.
    assert_eq!(run_fixture("vtable_back_to_back_4arg.c"), 201);
}

#[test]
fn vtable_back_to_back() {
    // Two adjacent struct-field-then-call expressions where the
    // second dispatches through a pointer the first stored.
    // Pins the walker's contract that adjacent call expressions
    // don't cross-contaminate their dispatch base / argument
    // evaluations.
    assert_eq!(run_fixture("vtable_back_to_back.c"), 50);
}

#[test]
fn switch_break_calls() {
    // C99 6.8.4.2: each case marker is a re-entry point regardless
    // of how the preceding body ended. Pins that contract end-to-
    // end across break-terminated bodies, fall-through pairs, and
    // the default arm.
    assert_eq!(run_fixture("switch_break_calls.c"), 300);
}

#[test]
fn control_flow() {
    assert_eq!(run_fixture("control_flow.c"), 1);
}

#[test]
fn do_while() {
    assert_eq!(run_fixture("do_while.c"), 5);
}

#[test]
fn break_continue() {
    // 1 + 3 = 4 (loop breaks at i==5, skips even values)
    assert_eq!(run_fixture("break_continue.c"), 4);
}

#[test]
fn for_loop() {
    assert_eq!(run_fixture("for_loop.c"), 10);
}

#[test]
fn recursion_factorial() {
    assert_eq!(run_fixture("recursion_factorial.c"), 120);
}

#[test]
fn pointers() {
    assert_eq!(run_fixture("pointers.c"), 200);
}

#[test]
fn nested_function_calls() {
    assert_eq!(run_fixture("nested_function_calls.c"), 100);
}

#[test]
fn printf_runs_to_completion() {
    assert_eq!(run_fixture("printf.c"), 0);
}

#[test]
fn memory_ops() {
    assert_eq!(run_fixture("memory_ops.c"), 0);
}

#[test]
fn file_io() {
    std::fs::write("test_dummy.txt", "1234567890").unwrap();
    let res = run_fixture("file_io.c");
    std::fs::remove_file("test_dummy.txt").unwrap();
    assert_eq!(res, 0);
}

#[test]
fn pointer_arithmetic_scaling() {
    // p+1 advances by sizeof(int)=4 bytes (`int` is 32-bit).
    assert_eq!(run_fixture("pointer_arithmetic_scaling.c"), 104);
}

#[test]
fn expression_precedence() {
    assert_eq!(run_fixture("expression_precedence.c"), 1);
}

#[test]
fn variable_shadowing() {
    // Inner block's `int i; i = 20;` doesn't leak.
    assert_eq!(run_fixture("variable_shadowing.c"), 10);
}

#[test]
fn pointer_arithmetic() {
    assert_eq!(run_fixture("pointer_arithmetic.c"), 3);
}

#[test]
fn memset_mcmp() {
    assert_eq!(run_fixture("memset_mcmp.c"), 42);
}

#[test]
fn memcpy_copies_bytes_between_allocations() {
    // memset src to 'A', memcpy into dst, return dst[0].
    assert_eq!(run_fixture("memcpy_basic.c"), 'A' as i64);
}

#[test]
fn shebang_line_is_skipped() {
    // A leading `#!/usr/bin/env badc` line lets a .c file be made
    // executable; the lexer absorbs it the same way it absorbs
    // `#include`. The fixture's `main` returns 7.
    assert_eq!(run_fixture("shebang.c"), 7);
}

#[test]
fn sizeof_handles_type_names() {
    // sizeof(int) / sizeof(char) / sizeof(<ptr>) all return the platform
    // word size (1 for char, 8 otherwise). Returns 0 on success.
    assert_eq!(run_fixture("sizeof_basic.c"), 0);
}

#[test]
fn sizeof_handles_expressions() {
    // sizeof(x), sizeof(*p) etc. -- the operand isn't evaluated.
    assert_eq!(run_fixture("sizeof_expr.c"), 0);
}

#[test]
fn sizeof_typedef_array_reports_total_bytes() {
    // C99 6.5.3.4 paragraph 4: `sizeof` on an array type yields
    // the total byte count. C99 6.7.7 paragraph 3 makes
    // `typedef T arr[N]; arr v;` equivalent to `T v[N];`, so
    // `sizeof(arr) == N * sizeof(T)`. Pointer decoration on the
    // typedef collapses to a scalar pointer.
    assert_eq!(run_fixture("sizeof_typedef_array.c"), 0);
}

#[test]
fn sizeof_string_literal_returns_array_size() {
    // C99 6.4.5p6: a string literal has type `char[N+1]` (the
    // `+1` counts the trailing NUL). `sizeof` reads the array
    // size, not the decayed pointer size. The fixture pins the
    // four byte counts plus the adjacent-literal concatenation
    // and the `sizeof - 1` skip-trailing-NUL idiom.
    assert_eq!(run_fixture("sizeof_string_literal.c"), 0);
}

#[test]
fn bitfield_brace_init_packs_into_storage_unit() {
    // C99 6.7.8: each bitfield brace-initializer entry is
    // converted to the field's type and merged into the shared
    // storage unit. A naive byte-wide overwrite at the unit's
    // offset (which c5 did historically) stomps every other
    // bitfield in the same unit; the per-field RMW preserves
    // adjacent bits.
    assert_eq!(run_fixture("bitfield_brace_init.c"), 0);
}

#[test]
fn vsnprintf_underscore_alias_resolves_to_libc() {
    // Locks the c5 <stdio.h> alias so `#define vsnprintf _vsnprintf`
    // (the standard MSVC-compatibility rewrite per C99 7.1.4 and CRT
    // convention) resolves through the canonical `vsnprintf` to the
    // platform C library. The fixture self-checks the formatted bytes,
    // so the JIT run also confirms libc walks the forwarded c5 va_list
    // correctly.
    use super::compile_fixture;
    let _ = compile_fixture("vsnprintf_underscore_alias.c");
}

#[test]
fn bitop_preserves_operand_width() {
    // C99 6.5.10 / 6.5.11 / 6.5.12: the result type of `&` /
    // `^` / `|` is the common type from the usual arithmetic
    // conversions, not unconditionally `int`. A wrong type pin
    // here lets downstream operators emit a 32-bit
    // sign-extension that clobbers bits 32..63 of a 64-bit
    // value -- e.g. `(u64 | u64) + 1` would land at
    // `value & 0xFFFFFFFF + 1` for any positive operand.
    assert_eq!(run_fixture("bitop_common_type.c"), 0);
}

#[test]
fn string_literal_init_drops_nul_at_bound() {
    // C99 6.7.8p14: a char-array string-literal initializer
    // stores its trailing NUL when the array has room; when
    // the literal's length is exactly the array's bound the
    // NUL is omitted. Treating the NUL as mandatory rejects
    // `static const char sigma[16] = "expand 32-byte k";`,
    // which compiles cleanly on every other C99 toolchain.
    assert_eq!(run_fixture("string_literal_no_room_for_nul.c"), 0);
}

#[test]
fn typedef_array_outer_dim_composes() {
    // C99 6.7.7p3 (multi-dim composition): when the typedef
    // base aliases an array, the declarator's brackets supply
    // the outer dimensions. `typedef i64 gf[16]; gf q[4];`
    // declares `q` as `i64[4][16]`. sizeof and indexing must
    // both reflect the composed shape.
    assert_eq!(run_fixture("typedef_array_outer_dim.c"), 0);
}

#[test]
fn local_struct_array_brace_init_works() {
    // C99 6.7.8p18 + 6.7.8p13: a local `T xs[N] = { {...}, {...} }`
    // array initializer must fan out into per-element field
    // stores. Constant-folded elements stage in the data segment
    // and Mcpy into the slot; non-constant elements (taking the
    // address of another local etc.) emit per-field runtime
    // stores into `&xs[i] + field.offset`.
    assert_eq!(run_fixture("local_struct_array_brace_init.c"), 0);
}

#[test]
fn static_init_accepts_paren_cast_of_string() {
    // C99 6.7.8: a static initializer for a pointer slot can
    // use the cast-of-string-literal idiom
    // `((const T *)"...")`. The integer constant-expression
    // path would drop the data relocation; the init parser
    // must recognise the shape and route through the
    // string-literal branch so the slot is patched at load.
    assert_eq!(run_fixture("static_init_paren_cast_string.c"), 0);
}

#[test]
fn static_init_folds_offsetof() {
    // C99 6.6 + 7.19: the standard `offsetof(T, m)` macro
    // expands to a constant arithmetic chain that must fold
    // at translation time when used as an initializer.
    assert_eq!(run_fixture("static_init_offsetof.c"), 0);
}

#[test]
fn static_inline_function_compiles_and_runs() {
    // C99 6.7.4: a `static inline` function at file scope has
    // internal linkage; c5 treats `inline` as a no-op modifier
    // and keeps the `static` attribute, so the body is emitted
    // as a private definition in each TU that sees it. This
    // fixture pins the single-TU case; the multi-TU variant
    // is exercised through the library demos that include
    // headers with `static inline` helpers.
    assert_eq!(run_fixture("static_inline_function.c"), 0);
}

#[test]
fn extern_decl_does_not_alias_following_defines() {
    // C99 6.9.2 / 6.2.2: an earlier `extern T x;` followed
    // by a defining `T x = ...;` must allocate fresh storage
    // for the definition. Mishandling the merge collapses
    // every following defining decl to the same `.data`
    // offset, so two adjacent array globals would both read
    // as whichever set of bytes landed first.
    assert_eq!(run_fixture("extern_decl_then_define.c"), 0);
}

#[test]
fn preprocessor_handles_uint64_literal() {
    // C99 6.10.1p4: `#if` evaluates in (u)intmax_t. A literal
    // at 2^64-1 must parse, and shifts on it must use logical
    // semantics so the 64-bit-host probe
    // `((ULONG_MAX >> 31) >> 31) == 3` evaluates to true on an
    // LP64 host.
    assert_eq!(run_fixture("preprocessor_uint64_literal.c"), 0);
}

#[test]
fn unary_minus_on_unsigned_int_wraps_mod_2_pow_32() {
    // C99 6.5.3.3p3: the unary `-` operator's result has the
    // promoted operand type. `unsigned int` does not promote
    // down, so `-x` on a `uint32_t` must wrap modulo 2^32. c5
    // lowers the negation as a 64-bit signed multiply, so
    // without an explicit 32-bit mask the sign-extended high
    // half stays in the register and a downstream `|` / `>>`
    // operates on the wider pattern -- the constant-time
    // identity `(q | -q) >> 31` then returns 0xFFFFFFFF
    // instead of 1.
    assert_eq!(run_fixture("unary_minus_unsigned_int_truncation.c"), 0);
}

#[test]
fn typedef_struct_carrier_does_not_leak() {
    // C99 6.7.7p3 boundary: a `typedef struct { fe X; ... } ge;`
    // whose final field is an array-typedef must not leak that
    // dimension into the outer `ge` binding. Without the
    // save/restore of `typedef_base_array_size` around the
    // aggregate body, `ge *p` is misclassified and `p->X`
    // rejects the operand as not a single-level struct pointer.
    assert_eq!(run_fixture("typedef_struct_carrier_reset.c"), 0);
}

#[test]
fn typedef_array_param_decays_to_pointer() {
    // C99 6.7.5.3p7: a parameter whose declared type is an
    // array is adjusted to a pointer to the element type.
    // The rule applies when the array shape comes from a
    // typedef alias, not only from a direct declarator.
    assert_eq!(run_fixture("typedef_array_param_decay.c"), 0);
}

#[test]
fn typedef_array_dim_applies_to_comma_list() {
    // C99 6.7.7p3: a typedef name names a type. When the
    // typedef alias is an array, every declarator sharing the
    // same base type carries that array dimension. Consuming
    // the carrier on the first declarator and leaving zero for
    // the rest of the comma list misroutes the trailing
    // initializer through the scalar parser.
    assert_eq!(run_fixture("typedef_array_comma_list.c"), 0);
}

#[test]
fn bitfield_signed_read_sign_extends() {
    // C99 6.7.2.1p4: a signed bitfield of width N holds values in
    // [-2^(N-1), 2^(N-1)-1]; the read path must sign-extend so the
    // bit pattern `11...1` for width N reads as -1, not the
    // unsigned `(1 << N) - 1`. A `signed short:2 cluster_dx`
    // storing -1 must read back as -1, otherwise downstream
    // signed arithmetic on the field falls out of range.
    assert_eq!(run_fixture("bitfield_signed_read.c"), 0);
}

#[test]
fn bitfield_storage_unit_matches_base_type() {
    // C99 6.7.2.1 paragraph 11: a bitfield's addressable
    // storage unit width is implementation-defined, but the
    // struct's size respects the base type's width. Treating
    // every bitfield as if it lived in an 8-byte unit inflates
    // a uint32_t-based struct to 8 bytes and bleeds a
    // read-modify-write into adjacent storage.
    assert_eq!(run_fixture("bitfield_storage_unit.c"), 0);
}

#[test]
fn integer_literal_suffix_picks_type() {
    // C99 6.4.4.1 paragraph 5: an integer literal's type comes
    // from its suffix. `1ULL` is unsigned long long, not int;
    // dropping the suffix truncates downstream 64-bit
    // arithmetic through the int rank.
    assert_eq!(run_fixture("integer_literal_suffix.c"), 0);
}

#[test]
fn unary_minus_preserves_uint64_width() {
    // C99 6.5.3.3 paragraph 3: the integer promotions are
    // performed on the operand of unary `-` and the result has
    // the promoted operand type. Collapsing the result to `int`
    // after the negation drops the high half of an
    // `unsigned long long` operand and mis-evaluates the
    // subsequent comparison in 32-bit signed.
    assert_eq!(run_fixture("unary_minus_uint64_compare.c"), 0);
}

#[test]
fn size_t_is_unsigned() {
    // C99 7.17 paragraph 2: `size_t` is an unsigned integer
    // type. A signed underlying typedef silently corrupts
    // every `MAX_SIZET / N`-shaped cap (-1 divided by N is 0
    // in two's complement signed arithmetic).
    assert_eq!(run_fixture("size_t_is_unsigned.c"), 0);
}

#[test]
fn macro_argument_rescan_resolves_pasted_call() {
    // C99 6.10.3.4: the function-like macro's substituted body
    // is rescanned for further macro replacement. An object
    // identifier supplied as a parameter and immediately
    // followed by `(` in the body must be recognised as a
    // function-like call in the rescan.
    assert_eq!(run_fixture("macro_argument_rescan.c"), 0);
}

#[test]
fn parenthesized_function_declarator() {
    // C99 6.7.5 paragraph 1: parentheses around a direct
    // declarator are transparent. `(name)(args)` declares a
    // function, not a function pointer, so a forward
    // declaration in that shape must not clash with the
    // matching definition.
    assert_eq!(run_fixture("parenthesized_function_declarator.c"), 0);
}

#[test]
fn large_int_literal_auto_promotes() {
    // C99 6.4.4.1 paragraph 5: an unsuffixed decimal integer
    // literal picks the first of `int`, `long`, `long long`
    // that can hold its value. Leaving a value past INT_MAX at
    // `int` forces the post-Add/Sub mask in the usual-arith
    // path to truncate `INT64_MAX - 1` to -2 and
    // `-LLONG_MAX - 1` to 0.
    assert_eq!(run_fixture("large_int_literal_auto_promotes.c"), 0);
}

#[test]
fn mcpy_temp_aliases_src() {
    // Locks the SSA emit's `Inst::Mcpy` lowering against a
    // regression where the per-iteration scratch register
    // aliased the source pointer. Picking a temp that only
    // avoided the destination corrupted the source base on the
    // first `ldr` and read the rest of the struct from a garbage
    // address. Reproduces under high register pressure on a
    // whole-struct assignment shape (`*p = constant_struct;`).
    assert_eq!(run_fixture("mcpy_temp_aliases_src.c"), 0);
}

#[test]
fn return_int_widens_to_double() {
    // C99 6.8.6.4 paragraph 3: the value of a return
    // expression is converted as if by assignment to the
    // function's return type. An int-typed `return` from a
    // `double`-returning function must lift through the
    // int-to-float cast;
    // dropping the integer bit pattern into the FP slot would
    // make a `(double)x == 505.0` check compare the bit
    // patterns instead of the values.
    assert_eq!(run_fixture("return_int_widens_to_double.c"), 0);
}

#[test]
fn struct_fn_ptr_field_deref_call() {
    // C99 6.3.2.1 paragraph 4: an lvalue of function type
    // decays to a pointer to the function. `(*s.cb)(args)`
    // is the canonical decay no-op; without a re-seed of the
    // fn-ptr chain depth after the struct-field load the unary
    // `*` emits a spurious `Li` and the call jumps to garbage.
    assert_eq!(run_fixture("struct_fn_ptr_field_deref_call.c"), 0);
}

#[test]
fn typedef_fn_ptr_struct_field_carries_lineage() {
    // Same shape as the previous test but the field's type
    // comes from a `typedef RET (*fn_t)(args)` alias rather
    // than an inline fn-pointer declarator. The typedef's
    // `fn_ptr_indirection` must propagate into the StructField
    // record so the post-load `(*g->cb)(args)` recognises the
    // decay.
    assert_eq!(run_fixture("typedef_fn_ptr_struct_field.c"), 0);
}

#[test]
fn fp_nan_unordered_compare() {
    // C99 6.5.8 paragraph 4 + 6.5.9 paragraph 3 + footnote
    // 96: NaN compares unordered with everything. Relational
    // and equality ops yield 0 when either operand is NaN; `!=`
    // yields 1. Locks the post-UCOMISD AND-with-`setnp` /
    // OR-with-`setp` masks the x86_64 backend needs to honour
    // the unordered case.
    assert_eq!(run_fixture("fp_nan_unordered_compare.c"), 0);
}

#[test]
fn sizeof_threads_through_malloc_write_and_return() {
    // sizeof(struct Packet) used in three positions in one program:
    // malloc size, write count, and the function's return value. Tests
    // that the same constant survives arithmetic and call-site
    // propagation. layout: code(4) + payload(4) + label(8) = 16.
    assert_eq!(run_fixture("sizeof_with_write.c"), 16);
}

#[test]
fn struct_basic_field_access() {
    // struct Point { int x; int y; }; allocate, set fields, read them.
    // Returns 3*3 + 4*4 = 25.
    assert_eq!(run_fixture("struct_basic.c"), 25);
}

#[test]
fn struct_self_referential_linked_list() {
    // struct Node { int v; struct Node *next; };
    // Build list of [4,3,2,1,0], sum via traversal -- expects 10.
    assert_eq!(run_fixture("struct_linked_list.c"), 10);
}

#[test]
fn global_initializer_int() {
    // `int answer = 42;` smoke test -- the c5 frontend writes
    // the initializer's bytes into `.data` at the symbol's
    // offset. Returns answer + sentinel = 141.
    assert_eq!(run_fixture("global_initializer_int.c"), 141);
}

#[test]
fn global_initializer_pointer() {
    // `int *p = &target;` exercises the address-of-global
    // relocation channel. The VM ignores the relocation entries
    // (it stores the target's data offset directly), so this
    // test catches frontend bugs; native parity tests catch
    // per-format relocation bugs.
    assert_eq!(run_fixture("global_initializer_pointer.c"), 0);
}

#[test]
fn static_linked_list() {
    // Static linked list: 3 nodes in `.data`, head pointer
    // initialized to `&node_a`. Walks the list via the
    // statically-relocated head pointer; the node `next`
    // pointers are wired up at runtime since c5 doesn't yet
    // have struct-field-initializer syntax.
    assert_eq!(run_fixture("static_linked_list.c"), 0);
}

#[test]
fn thread_local_initializer() {
    // `_Thread_local int counter = 7;` -- the VM doesn't
    // distinguish .tdata from .tbss (single-threaded), so
    // tls_data bytes are read directly. Returns 0 on
    // success.
    assert_eq!(run_fixture("thread_local_initializer.c"), 0);
}

#[test]
fn struct_sizeof_reports_aggregate_size() {
    // sizeof(struct Three) == 24, etc. Returns 0 on success.
    assert_eq!(run_fixture("struct_sizeof.c"), 0);
}

#[test]
fn adjacent_string_literals_concatenate() {
    // C concatenates `"abc" "def" "ghi"` into one string. The lexer used
    // to put a NUL between each part, breaking lookups past the first
    // segment -- which made original c4.c's keyword table truncate.
    assert_eq!(run_fixture("adjacent_strings.c"), 'f' as i64);
}

#[test]
fn float_long_double_suffix_accepted() {
    // C99 6.4.4.2: the floating-suffix is one of `f`, `F`, `l`,
    // `L`. The dialect stores every floating literal in `f64`,
    // so the four spellings of the same value land identical at
    // the bit level. The fixture also pins the integer-vs-float
    // disambiguator -- bare `7L` stays a `long` integer because
    // no `.` / `e` was seen.
    assert_eq!(run_fixture("float_long_double_suffix.c"), 0);
}

#[test]
fn bitfield_compound_assignment() {
    // C99 6.5.16.2: a bitfield is a valid lvalue for every
    // compound assignment operator. The fixture walks the
    // logical / arithmetic / shift compound set against a
    // multi-field struct, asserting both the updated field's
    // value and that adjacent bits stay untouched.
    assert_eq!(run_fixture("bitfield_compound_assignment.c"), 0);
}

#[test]
fn macro_arg_blue_paint_preserved_across_body_rescan() {
    // C99 6.10.3.4: a macro that fired during the pre-expansion
    // of a function-like macro's argument must not re-fire when
    // the substituted body is rescanned. The fixture exercises
    // the per-state-accessor pattern (`#define foo s1->foo`)
    // passed as an argument to a generic helper macro -- without
    // blue paint the inner accessor re-fires inside the body and
    // double-prefixes the access.
    assert_eq!(run_fixture("macro_arg_blue_paint.c"), 0);
}

#[test]
fn array_typedef_dimensions_propagate() {
    // C99 6.7.7 paragraph 3: a typedef name denotes the same
    // type as its right-hand-side, including any array
    // dimension. The fixture exercises the four positions where
    // the parser routes the type into a declarator -- file
    // scope, block scope, struct field, plus a raw-array
    // comparison -- and asserts each reports the array's full
    // byte count.
    assert_eq!(run_fixture("array_typedef_dimensions_propagate.c"), 0);
}

#[test]
fn variadic_call_through_fnptr_delivers_all_args() {
    // C99 6.5.2.2: a call through a function pointer must
    // deliver every fixed and variadic argument to the callee.
    // c5 used to route every address-taken function through an
    // arg-shuffling thunk that lost the variadic tail; the
    // fixture covers a bare fn-pointer call and the
    // comma-operator-yielding-fn-pointer macro shape.
    assert_eq!(run_fixture("variadic_via_fnptr.c"), 0);
}

#[test]
#[ignore = "TODO: c5 VM has no shim for strtold / ldexpl; the fixture verifies the SysV x86_64 long-double libc-return convention through the native lane via NATIVE_FIXTURES"]
fn long_double_libc_return_round_trips() {
    // SysV x86_64 ABI: `long double` libc returns ride in
    // x87 `st(0)`, not XMM0. The libc-call lowering spills
    // st(0) and reloads as double; the fixture asserts that
    // strtold and ldexpl yield the right bit pattern after
    // the round trip. Pre-fix the path read XMM0 and got
    // -0.0 for every call.
    assert_eq!(run_fixture("long_double_libc_return.c"), 0);
}

#[test]
fn typedef_shadowed_by_parameter_name() {
    // C99 6.2.1 paragraph 4: an inner-scope declaration that
    // reuses an outer name (here, a function-prototype parameter
    // taking the spelling of an outer typedef) fully hides the
    // outer binding only for the duration of the inner scope.
    // The outer typedef -- including its array dimension -- must
    // reappear unchanged on scope exit. The fixture confirms the
    // shadow-restore protocol covers `array_size`, not only
    // `class` / `type_` / `val`.
    assert_eq!(run_fixture("typedef_shadowed_by_parameter_name.c"), 0);
}

#[test]
fn nested_struct_array_initializer() {
    // C99 6.7.8: an array-of-struct field inside an enclosing
    // struct accepts a nested brace-enclosed initializer for
    // each element. The fixture exercises the array between
    // scalar fields, as the only field, and adjacent to a flat
    // int array; every per-element value reads back correctly.
    assert_eq!(run_fixture("nested_struct_array_initializer.c"), 0);
}

#[test]
fn array_initializer_accepts_constant_expressions() {
    // C99 6.6: a constant arithmetic expression is a valid
    // initializer in every position, including individual
    // elements of an array (or nested struct/array) initializer
    // list. The fixture exercises bitwise (|, ^, &), additive,
    // multiplicative, and shift compound forms of integer
    // constants -- both macro-defined and enum-declared --
    // across scalar arrays and nested struct-of-array tables.
    assert_eq!(run_fixture("array_init_constant_expression.c"), 0);
}

#[test]
fn sizeof_through_null_pointer_cast() {
    // C99 6.5.3.4: `sizeof` does not evaluate its operand, so
    // `sizeof ((T *)0)->m` is a valid way to read the size of a
    // member without instantiating the struct. The fixture
    // exercises four scalar member widths, a nested-struct
    // member access via `->...`, and the matching `offsetof`
    // macro (the address-of-via-null-cast variant) to keep both
    // sides of the standard idiom locked.
    assert_eq!(run_fixture("sizeof_member_via_null_cast.c"), 0);
}

#[test]
fn extern_declaration_inside_function_body() {
    // C99 6.7.1 paragraph 3: `extern` declarations are valid at
    // any scope. c5 has no separate translation units, so a
    // block-scope extern is consumed as a no-op; the resolver
    // still finds the symbol through its own table. The fixture
    // exercises both the bare-identifier form and the
    // pointer-qualified return type (`extern int abs(int);`).
    assert_eq!(run_fixture("extern_in_function.c"), 0);
}

#[test]
fn va_copy_clones_va_list_cursor() {
    // C99 7.15.1.2: `va_copy(dst, src)` initialises `dst` to the
    // same position in the variadic list as `src`. The fixture
    // builds a copy of the cursor immediately after `va_start`
    // and walks the copy; the sum must match the values passed
    // to the variadic call.
    assert_eq!(run_fixture("va_copy.c"), 0);
}

#[test]
fn macro_paste_result_is_rescanned() {
    // C99 6.10.3.4: after a function-like macro's body is built,
    // the result is re-scanned for further replacement; when the
    // re-scan finds another function-like macro name and the
    // source token immediately after the outer invocation is `(`,
    // those arguments feed the inner expansion. The fixture
    // exercises the width-mux `WIDTH##_##NAME(...)` idiom.
    assert_eq!(run_fixture("macro_paste_rescan.c"), 0);
}

#[test]
fn func_name_predeclared_identifier() {
    // C99 6.4.2.2 makes `__func__` an implicitly declared string
    // literal carrying the enclosing function's name. c5 mirrors
    // the standard plus the GCC aliases `__FUNCTION__` and
    // `__PRETTY_FUNCTION__`. The fixture pins three properties:
    // each name resolves to the right function, the three
    // spellings agree byte-for-byte, and distinct functions
    // produce distinct strings.
    assert_eq!(run_fixture("function_macro.c"), 0);
}

#[test]
fn unistd_exposes_posix_types() {
    // POSIX-2017 requires `<unistd.h>` to make `ssize_t`,
    // `size_t`, `off_t`, `pid_t`, `uid_t`, `gid_t` visible; the
    // width-sensitive ones come through `<sys/types.h>`. c5's
    // `<unistd.h>` includes `<sys/types.h>` to satisfy this. The
    // fixture asserts the types resolve under only `<unistd.h>`
    // and that their widths match the LP64 contract c5 ships.
    assert_eq!(run_fixture("unistd_exposes_posix_types.c"), 0);
}

#[test]
fn attribute_and_declspec_absorbed_as_no_op() {
    // The preprocessor predefines `__attribute__` / `__declspec`
    // as empty function-like macros so attribute-decorated
    // declarations parse without dragging in real attribute
    // semantics. Fixture exercises prefix attribute on a
    // function declaration, postfix attribute (the GCC
    // position), nested-paren payloads with comma arguments,
    // and `__declspec(align(...))` on a struct.
    assert_eq!(run_fixture("attribute_noop.c"), 0);
}

#[test]
#[ignore = "TODO: c5 VM has no setjmp / longjmp shim; the fixture verifies the host-libc semantic and needs the JIT / AOT path"]
fn setjmp_longjmp_unwinds_through_jmp_buf() {
    // C99 7.13: `setjmp` returns 0 directly and the matching
    // `longjmp(env, val)` rewinds control to the setjmp site
    // with a return value of `val`. The fixture embeds a
    // `jmp_buf` in a struct and checks both the return-value
    // contract and the survival of a volatile local across the
    // unwind. Bound to host libc per platform; if a host's libc
    // setjmp implementation requires a wider buffer than 64
    // longs (512 bytes), this fixture detects the size mismatch.
    assert_eq!(run_fixture("setjmp_longjmp.c"), 0);
}

#[test]
fn inttypes_header_supplies_types_and_format_macros() {
    // C99 7.8: `<inttypes.h>` layers on top of `<stdint.h>` and adds
    // the PRI / SCN conversion-specifier macros. The fixture
    // includes only `<inttypes.h>` and asserts the fixed-width
    // typedefs still resolve transitively, plus the macro
    // expansions match the LP64 / LLP64 contract c5 ships
    // (int64_t aliases `long long`, so PRId64 is "lld" uniformly).
    assert_eq!(run_fixture("inttypes_header.c"), 0);
}

#[test]
fn predefined_constants_are_visible() {
    // PROT_*, O_*, STDIN_FILENO, NULL, EXIT_SUCCESS/FAILURE -- each is
    // an integer constant the lexer pre-binds before any user code is
    // parsed. Returns 0 if every comparison holds.
    assert_eq!(run_fixture("predefined_constants.c"), 0);
}

#[test]
fn c99_qualifiers_parse_as_no_ops() {
    // const, volatile, restrict, signed, unsigned, short, long, _Bool,
    // register, auto, inline -- recognised by the lexer and consumed at
    // every declaration position the parser visits. Returns 0 if every
    // shape parsed and ran.
    assert_eq!(run_fixture("c99_qualifiers.c"), 0);
}

#[test]
fn integer_literal_suffixes_are_consumed() {
    // u/U/l/L/ll/LL/ULL etc. on decimal and hex integer literals --
    // accepted by the lexer and the value preserved verbatim (c5 has a
    // single 64-bit int representation; the suffix is informational).
    // Returns 0 if every literal lands at the expected value.
    assert_eq!(run_fixture("integer_suffixes.c"), 0);
}

#[test]
fn static_locals() {
    // `static T name [= init];` inside a function gets a
    // persistent slot in the data segment instead of the stack
    // frame. Counters, cached state, etc. survive across calls.
    // Two functions with the same-named static each have an
    // independent slot.
    assert_eq!(run_fixture("static_locals.c"), 0);
}

#[test]
fn bitfields_basic() {
    // bitfields pack into shared 8-byte storage units;
    // reads use Li/Shr/And; writes use load-clear-shift-or-store.
    // Pins both single-bit flags and wider bitfields, plus
    // mutation that must not disturb adjacent bits.
    assert_eq!(run_fixture("bitfields.c"), 0);
}

#[test]
fn enum_tag_types() {
    // `enum Foo { ... };` registers a tag whose constants
    // resolve to integers; `enum Foo` then works as a type spec
    // (equivalent to int in c5) in parameter / return / local /
    // array-dimension positions.
    assert_eq!(run_fixture("enum_tag_types.c"), 0);
}

#[test]
fn struct_initializers() {
    // struct initializers (designated + positional + mixed),
    // including function-pointer fields that need a CodeReloc so
    // the per-format writers patch the slot to the runtime code
    // address. Plain-data struct globals also covered.
    assert_eq!(run_fixture("struct_initializers.c"), 0);
}

#[test]
fn array_initializers() {
    // string-literal and brace-list array initializers,
    // size-inferred and explicit-size shapes, at both file scope
    // and function scope.
    assert_eq!(run_fixture("array_initializers.c"), 0);
}

#[test]
fn unions_basic() {
    // unions: layout shares storage among members; field
    // access uses the same path as struct fields with all offsets
    // = 0 and total size = max(member size). Tagged-union shape
    // (struct tag + nested union) also exercised.
    assert_eq!(run_fixture("unions_basic.c"), 0);
}

#[test]
fn function_pointer_typedefs_and_fields() {
    // `typedef RET (*Name)(args);`, function-pointer struct
    // fields, and function-pointer parameters all parse and run.
    // Calling through an FP-typed struct field directly (`s.cb(args)`)
    // is still missing -- the workaround in the fixture is to copy
    // the field into a local before calling.
    assert_eq!(run_fixture("function_pointer_typedefs.c"), 0);
}

#[test]
fn arrays_as_language_types() {
    // stack and global arrays, indexing with correct
    // per-element scaling (including struct arrays), array fields
    // inside a struct, sizeof(arr) returning N*elem_size, and
    // array-to-pointer decay through a pointer-typed parameter.
    assert_eq!(run_fixture("arrays_basic.c"), 0);
}

#[test]
fn local_init_and_block_scope_decls_work() {
    // local variable initializers and C99 block-scope
    // declarations interleaved with statements, including
    // shadowing in nested blocks.
    assert_eq!(run_fixture("local_init_and_block_scope.c"), 0);
}

#[test]
fn typedef_basics_work() {
    // typedef of primitives, pointers, forward struct + alias,
    // single-declaration struct + alias, typedef-name in
    // parameters / return / struct fields / casts / sizeof.
    assert_eq!(run_fixture("typedef_basic.c"), 0);
}

#[test]
fn macro_operators_work() {
    // # (stringify), ## (token paste), __VA_ARGS__ in variadic
    // macros. The fixture exercises each operator and checks the
    // resulting program runs to completion.
    assert_eq!(run_fixture("macro_operators.c"), 0);
}

#[test]
fn predefined_macros_resolve() {
    // __FILE__, __LINE__, __STDC__, __DATE__, __TIME__ -- the standard
    // C99 predefines. __LINE__ and __FILE__ expand dynamically per
    // line; the rest are seeded once.
    assert_eq!(run_fixture("predefined_macros.c"), 0);
}

#[test]
fn error_directive_aborts_compilation() {
    // `#error` produces a compile-time diagnostic with the message
    // text. Compilation must fail and the message must surface in the
    // diagnostic.
    use crate::c5::Compiler;
    let src = "#error must abort here\nint main() { return 0; }\n";
    let err = Compiler::new(src.to_string())
        .compile()
        .expect_err("#error should abort compilation");
    let msg = format!("{err:?}");
    assert!(
        msg.contains("must abort here"),
        "expected the #error message in the diagnostic, got {msg:?}"
    );
}

#[test]
fn error_directive_in_inactive_branch_is_ignored() {
    // `#error` inside a `#if 0` block must not abort -- the C standard
    // requires the directive to fire only when the branch is active.
    use crate::c5::Compiler;
    let src = "\
#define USE 1
#if USE == 0
#error wrong branch
#endif
int main() { return 0; }
";
    Compiler::new(src.to_string())
        .compile()
        .expect("#error in inactive branch must not fire");
}

#[test]
fn original_c4_compiles_and_runs_hello() {
    // The canonical self-hosting test: Robert Swierczek's original c4.c
    // runs under badc, compiles the c4-subset self-host fixture, and
    // runs the resulting program -- which prints "Hello 123" then exits
    // 0. We only check the exit code; the printed output goes to the
    // real stdout.
    let exit = super::run_fixture_with_args(
        "c4.c",
        [
            "c4.c",
            concat!(
                env!("CARGO_MANIFEST_DIR"),
                "/tests/fixtures/c/c4_selfhost_hello.c"
            ),
        ],
    );
    assert_eq!(exit, 0);
}

#[test]
fn quicksort() {
    assert_eq!(run_fixture("quicksort.c"), 0);
}

#[test]
fn linked_list() {
    assert_eq!(run_fixture("linked_list.c"), 10);
}

#[test]
fn binary_search_tree() {
    assert_eq!(run_fixture("binary_search_tree.c"), 0);
}

#[test]
fn bst_free() {
    assert_eq!(run_fixture("bst_free.c"), 0);
}

#[test]
fn double_pointers() {
    assert_eq!(run_fixture("double_pointers.c"), 0);
}

#[test]
fn for_init_declaration() {
    // C99 6.8.5.3: `for (int i = 0; ...; ...)` -- the init clause
    // is a declaration whose scope is the loop body. The fixture
    // covers single + multi-declarator, shadowing of an outer
    // name, adjacent loops re-using the loop variable, and a
    // struct-pointer init.
    assert_eq!(run_fixture("for_init_declaration.c"), 0);
}

#[test]
fn designated_initializers() {
    // C99 6.7.8p6: `.field = ...` for structs and `[N] = ...` for
    // arrays, both supported in any order and intermixable with
    // positional initializers.
    assert_eq!(run_fixture("designated_initializers.c"), 0);
}

#[test]
fn nonconst_local_struct_init() {
    // C99 6.7.8p13: a local struct initializer may contain
    // non-constant expressions (function calls, runtime values).
    // The fix pre-scans the brace list, falls through to
    // per-field stores when any entry isn't a constant, and
    // zero-fills the gaps the scan didn't visit.
    assert_eq!(run_fixture("nonconst_local_struct_init.c"), 0);
}

#[test]
fn void_function_produces_no_value() {
    // C99 6.8.6.4p3: a void-returning function produces no value.
    // A caller that observes the return value via a mistyped
    // function-pointer cast reads 0 (matching gcc / clang),
    // both for the function-end exit path and an explicit
    // `return;` statement.
    assert_eq!(run_fixture("void_function_produces_no_value.c"), 0);
}

#[test]
fn const_expr_arithmetic() {
    // C99 6.6: integer constant expressions accept the full
    // constant-expression grammar -- arithmetic, casts, comparisons,
    // conditionals, sizeof, bitwise / logical operators, and FP
    // operands as casts (folded at parse time and truncated at the
    // integer boundary). Exercises enum initialisers, _Static_assert,
    // array sizes (global + local), and nested combinations.
    assert_eq!(run_fixture("const_expr_arithmetic.c"), 0);
}

#[test]
fn float_is_four_bytes() {
    // C99 6.2.5 + the real-IEEE-single refactor: `sizeof(float) == 4`,
    // struct fields pack at 4-byte stride, static `float` initializers
    // narrow f64 -> f32 bits at the storage boundary, and function
    // parameters of `float` type get rebound to a fresh local at
    // entry so the body's narrow load/store stays consistent with
    // the f64-shaped call ABI.
    assert_eq!(run_fixture("float_is_four_bytes.c"), 0);
}

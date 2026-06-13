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
fn aggregate_init_struct_member_copy() {
    // C99 6.7.8p13: a struct member of an automatic aggregate initialized
    // by a non-constant struct expression (subscript, deref, by-value
    // parameter) copies the source's bytes, not its address.
    assert_eq!(run_fixture("aggregate_init_struct_member_copy.c"), 0);
}

#[test]
fn variadic_union_struct_return() {
    // A variadic function returning a 16-byte struct whose first eightbyte
    // is a union overlapping a double with an int/pointer returns in the
    // integer result registers while its variadic tail rides the host
    // stack.
    assert_eq!(run_fixture("variadic_union_struct_return.c"), 0);
}

#[test]
fn union_fp_member_regs_return() {
    // C99 6.7.2.1 / System V AMD64 3.2.3 / AAPCS64 6.9: a 16-byte struct
    // whose first eightbyte overlaps a double with an int/pointer member
    // returns in the integer result registers, not through an out-pointer.
    assert_eq!(run_fixture("union_fp_member_regs_return.c"), 0);
}

#[test]
fn fn_ptr_float_return() {
    // C99 6.2.5p10 / 6.3.1.8: a call through a function pointer with a
    // `float` return type yields a single-precision value; the indirect
    // result must be tagged f32 so the store does not narrow it twice.
    assert_eq!(run_fixture("fn_ptr_float_return.c"), 0);
}

#[test]
fn fn_ptr_float_arg() {
    // C99 6.5.2.2p7: a float argument through a function pointer is
    // converted to the pointer's declared parameter type, not promoted to
    // double. Covers a fn-pointer variable, typedef, and a callback
    // parameter whose own parameter name shadows the enclosing prototype.
    assert_eq!(run_fixture("fn_ptr_float_arg.c"), 0);
}

#[test]
fn variadic_fn_ptr_init() {
    // C99 6.5.2.2: a variadic function pointer declared with an initializer
    // (or via a typedef) keeps its variadic prototype, so an indirect call
    // places the variadic arguments per the host variadic ABI.
    assert_eq!(run_fixture("variadic_fn_ptr_init.c"), 0);
}

#[test]
fn variadic_struct_return() {
    // A variadic function returning a struct by value: the call must
    // recover the result registers into the caller's temp.
    assert_eq!(run_fixture("variadic_struct_return.c"), 0);
}

#[test]
fn flex_array_member_sizing() {
    // C99 6.7.2.1p18: a flexible/zero-length array member contributes no
    // storage; an aggregate built only from such members has size 0.
    assert_eq!(run_fixture("flex_array_member_sizing.c"), 0);
}

#[test]
fn bitfield_mixed_base_packing() {
    // C99 6.7.2.1p11: adjacent bitfields of different base types share a
    // storage unit when the bits fit (the gcc/clang layout).
    assert_eq!(run_fixture("bitfield_mixed_base_packing.c"), 0);
}

#[test]
fn computed_goto() {
    // GCC labels-as-values: `&&label` address, `goto *expr` indirect
    // branch, with a runtime label table, a back edge, and a scalar
    // target.
    assert_eq!(run_fixture("computed_goto.c"), 0);
}

#[test]
fn label_addr_array_init() {
    // A `&&label` element in an array initializer fills the slot with a
    // runtime store (the block address is not a compile-time constant),
    // indexed by a computed goto.
    assert_eq!(run_fixture("label_addr_array_init.c"), 0);
}

#[test]
fn sieve_of_eratosthenes() {
    // Dense array write/read loop with a multiplicative inner stride;
    // the prime count below 100000 checks the result.
    assert_eq!(run_fixture("sieve_of_eratosthenes.c"), 0);
}

#[test]
fn static_neg_infinity_init() {
    // `-INFINITY` in a static initializer folds in f64, not coerced to an
    // integer; covers scalar, struct, and union members.
    assert_eq!(run_fixture("static_neg_infinity_init.c"), 0);
}

#[test]
fn sub_word_return_narrow() {
    // A char/short return narrows its body value to the declared type.
    assert_eq!(run_fixture("sub_word_return_narrow.c"), 0);
}

#[test]
fn array_range_designator() {
    // GCC `[a ... b] = value` fills the inclusive range; covers constant
    // data and a label-address dispatch table.
    assert_eq!(run_fixture("array_range_designator.c"), 0);
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
fn stringize_whitespace() {
    // `#` collapses inter-token white space and preserves it inside
    // literals.
    assert_eq!(run_fixture("stringize_whitespace.c"), 0);
}

#[test]
fn kr_old_style_def() {
    // Old-style parameter declarations between `)` and the body refine
    // the parameter types.
    assert_eq!(run_fixture("kr_old_style_def.c"), 0);
}

#[test]
fn fn_ptr_return_type() {
    // A call through a function pointer yields the callee's return
    // type, so a following `->` / `[` sees the right shape.
    assert_eq!(run_fixture("fn_ptr_return_type.c"), 0);
}

#[test]
fn fn_returning_fn_ptr() {
    // A function returning a function pointer: the result decays so a
    // following `*` is a no-op and the result is callable.
    assert_eq!(run_fixture("fn_returning_fn_ptr.c"), 0);
}

#[test]
fn duff_switch_into_loop() {
    // Duff's device: case labels inside a loop nested in the switch,
    // plus K&R parameters and C89 implicit-int locals.
    assert_eq!(run_fixture("duff_switch_into_loop.c"), 0);
}

#[test]
fn empty_macro_arg_and_string_rows() {
    // `q()` passes one empty argument; a string fills a row of a
    // multi-dimensional char array.
    assert_eq!(run_fixture("empty_macro_arg_and_string_rows.c"), 0);
}

#[test]
fn extern_incomplete_struct_completion() {
    // An `extern` of an incomplete struct reserves no storage; the
    // completed definition allocates without overlapping later globals.
    assert_eq!(run_fixture("extern_incomplete_struct_completion.c"), 0);
}

#[test]
fn block_scope_extern() {
    // A block-scope `extern` declaration refers to the file-scope
    // object, allocating no local and not shadowing it.
    assert_eq!(run_fixture("block_scope_extern.c"), 0);
}

#[test]
fn inline_arg_count_mismatch() {
    // A call passing fewer arguments than the callee has parameters is
    // not inlined, so the optimized IR stays well-formed.
    assert_eq!(run_fixture("inline_arg_count_mismatch.c"), 0);
}

#[test]
fn const_member_address_init() {
    // C99 6.6: a static initializer may be the constant address of a
    // global's member, array member, or indexed element's member.
    assert_eq!(run_fixture("const_member_address_init.c"), 0);
}

#[test]
fn const_float_div_zero() {
    // IEEE float division by zero in a constant expression yields
    // inf / NaN, not a diagnostic.
    assert_eq!(run_fixture("const_float_div_zero.c"), 0);
}

#[test]
fn array_of_struct_brace_elision() {
    // C99 6.7.8p20: a flat value list fills an array of structs with the
    // per-element braces elided; the length follows from the slot count.
    assert_eq!(run_fixture("array_of_struct_brace_elision.c"), 0);
}

#[test]
fn local_struct_array_runtime_init() {
    // C99 6.7.8p13: a deferred-size automatic array of structs whose
    // element field takes the address of a local routes to per-element
    // runtime stores instead of the constant stage-into-data path.
    assert_eq!(run_fixture("local_struct_array_runtime_init.c"), 0);
}

#[test]
fn nested_runtime_init() {
    // C99 6.7.8p13: a nested struct/union member with non-constant
    // initializers stores each field at runtime at the member's offset.
    assert_eq!(run_fixture("nested_runtime_init.c"), 0);
}

#[test]
fn fn_type_typedef_cast() {
    // A cast through a function-type-typedef pointer must not leak its
    // marker into a following declarator's return type.
    assert_eq!(run_fixture("fn_type_typedef_cast.c"), 0);
}

#[test]
fn fn_type_typedef_local() {
    // A pointer to a function-type typedef is a function pointer (one
    // level), distinct from a pointer to a function-pointer typedef.
    assert_eq!(run_fixture("fn_type_typedef_local.c"), 0);
}

#[test]
fn fn_type_typedef_field() {
    // Struct field that is a pointer to a function-type typedef returning
    // a struct, called through the field; the call yields the struct.
    assert_eq!(run_fixture("fn_type_typedef_field.c"), 0);
}

#[test]
fn fn_ptr_float_arg_narrow() {
    // A double-typed argument narrows to a float parameter through a
    // subscripted dispatch table and a dereferenced function pointer
    // (C99 6.5.2.2p7), matching the direct-identifier call path.
    assert_eq!(run_fixture("fn_ptr_float_arg_narrow.c"), 0);
}

#[test]
fn struct_array_elided_runtime() {
    // C99 6.7.8p20 brace elision for a struct-array element with a
    // non-constant initializer (runtime per-field stores).
    assert_eq!(run_fixture("struct_array_elided_runtime.c"), 0);
}

#[test]
fn bitfield_incdec() {
    // C99 6.7.2.1: ++/-- on a bitfield member, wrapping within the field
    // width and preserving the other bits.
    assert_eq!(run_fixture("bitfield_incdec.c"), 0);
}

#[test]
fn c11_atomic_specifier() {
    // C11 6.7.2.4 / 6.7.3: the `_Atomic(type-name)` specifier and the
    // `_Atomic` qualifier both reduce to the unqualified inner type.
    assert_eq!(run_fixture("c11_atomic_specifier.c"), 0);
}

#[test]
fn c11_atomic_ops() {
    // C11 7.17: atomic_load / store / exchange / fetch_* /
    // compare_exchange_strong lowered to load / store / RMW on the
    // pointee width.
    assert_eq!(run_fixture("c11_atomic_ops.c"), 0);
}

#[test]
fn inline_asm_hint() {
    // GCC inline asm: the operand-free empty barrier and the
    // pause / yield spin hint compile and leave the surrounding
    // computation unaffected.
    assert_eq!(run_fixture("inline_asm_hint.c"), 0);
}

#[test]
fn compound_assign_int_fp() {
    // C99 6.5.16.2: an integer lvalue with a floating rhs in a
    // compound assignment performs the operation in floating point
    // and converts the result back to the integer type.
    assert_eq!(run_fixture("compound_assign_int_fp.c"), 0);
}

#[test]
fn signal_sig_t() {
    // POSIX `sig_t` handler type in <signal.h>.
    assert_eq!(run_fixture("signal_sig_t.c"), 0);
}

#[test]
fn math_classify() {
    // C99 7.12.3: isnan / isinf / isfinite classify a floating value.
    assert_eq!(run_fixture("math_classify.c"), 0);
}

#[test]
fn switch_unsigned_negative_case() {
    // C99 6.8.4.2: case labels convert to the promoted controlling type.
    assert_eq!(run_fixture("switch_unsigned_negative_case.c"), 0);
}

#[test]
fn enum_bitfield_unsigned() {
    // C99 6.7.2.1/6.7.2.2: a non-negative enum bitfield reads unsigned.
    assert_eq!(run_fixture("enum_bitfield_unsigned.c"), 0);
}

#[test]
fn indirect_struct_return_outptr() {
    // A struct returned through a function pointer in the out-pointer
    // class (SysV > 16B, Win64 outside {1,2,4,8}B); the result temp is
    // sized to the whole struct.
    assert_eq!(run_fixture("indirect_struct_return_outptr.c"), 0);
}

#[test]
fn indirect_struct_return() {
    // A struct returned by value from a call through a function pointer
    // follows the same return ABI as a direct call.
    assert_eq!(run_fixture("indirect_struct_return.c"), 0);
}

#[test]
fn nested_compound_literal() {
    // C99 6.5.2.5 compound literal nested inside another aggregate
    // initializer; the inner cast names the member type and is dropped
    // so the brace list initializes the member directly.
    assert_eq!(run_fixture("nested_compound_literal.c"), 0);
}

#[test]
fn zero_length_array() {
    // GCC zero-length array `T x[0]` as a struct's trailing member,
    // treated as a flexible array member (zero storage, real bytes
    // follow the fixed part).
    assert_eq!(run_fixture("zero_length_array.c"), 0);
}

#[test]
fn builtin_frame_address() {
    // __builtin_frame_address(0): non-null, stable within a frame,
    // distinct between a function and its callee.
    assert_eq!(run_fixture("builtin_frame_address.c"), 0);
}

#[test]
fn builtin_bswap_expect() {
    // GCC __builtin_bswap16/32/64, __builtin_expect, __builtin_unreachable.
    assert_eq!(run_fixture("builtin_bswap_expect.c"), 0);
}

#[test]
fn builtin_bit_count() {
    // GCC __builtin_clz / ctz / popcount (+ ll forms), lowered to a
    // portable shift / mask sequence; results match hand-computed
    // values on every lane including the interpreter.
    assert_eq!(run_fixture("builtin_bit_count.c"), 0);
}

#[test]
fn scanf_fscanf_binding() {
    // C99 7.19.6.4 scanf / 7.19.6.2 fscanf must be declared and bound
    // from <stdio.h>; the calls are guarded so the interp lane never
    // reaches their (unimplemented) CallExt and never blocks on stdin.
    assert_eq!(run_fixture("scanf_fscanf_binding.c"), 0);
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
    assert_eq!(run_fixture("switch_binary_search.c"), 0);
    assert_eq!(run_fixture("branch_relaxation.c"), 21);
    assert_eq!(run_fixture("float_register_resident.c"), 45);
    assert_eq!(run_fixture("variadic_struct_arg.c"), 18);
    assert_eq!(run_fixture("variadic_struct_arg_16b.c"), 51);
    assert_eq!(run_fixture("libc_div.c"), 0);
    assert_eq!(run_fixture("libc_fp_classify.c"), 0);
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
fn function_pointer_global_initialized_with_address_of() {
    // C99 6.3.2.1p4: `&func` is the same function-pointer value as the
    // bare name. A scalar global initialized `= &func` must work like
    // `= func`.
    assert_eq!(run_fixture("funcptr_global_addressof_init.c"), 0);
}

#[test]
fn static_local_shadows_same_named_global() {
    // C99 6.2.1 + 6.2.4p3: a block-scope `static` local has its own
    // static storage and block scope; a same-named file-scope object
    // is a distinct object. The local must not share the global's
    // storage and the global reappears after the function returns.
    assert_eq!(run_fixture("static_local_shadows_global.c"), 0);
}

#[test]
fn float_argument_to_variadic_is_promoted_to_double() {
    // C99 6.5.2.2p6-7: a `float` passed to a variadic function is
    // promoted to `double`. The fixture self-checks `%g` of a float
    // variable, a float cast, and a float mixed with other arguments
    // via snprintf.
    assert_eq!(run_fixture("float_variadic_promotion.c"), 0);
}

#[test]
fn pointer_to_array_arithmetic_scales_by_array_size() {
    // C99 6.5.6p8: arithmetic on a pointer-to-array `T (*p)[N]` steps
    // by `sizeof(T[N])`, not `sizeof(T)`. The fixture self-checks
    // `a+i`, `p++`/`p--`, a chained `p+i-j`, `(*p)[k]` after an offset,
    // `p-a`, and the post-increment deref `(*p++)[k]`.
    assert_eq!(run_fixture("pointer_to_array_arithmetic.c"), 0);
}

#[test]
fn typedef_at_function_body_top_level() {
    // C99 6.7.7 + 6.2.1: a `typedef` is a declaration valid at the
    // function-body top level (before or after a statement), with block
    // scope. The fixture self-checks a body-top `typedef enum`, a
    // typedef after a statement, and that a function-scope typedef does
    // not leak to file scope nor shadow a same-named file-scope object
    // outside the function.
    assert_eq!(run_fixture("typedef_in_function_body.c"), 0);
}

#[test]
fn const_expr_cast_narrows_to_target_width() {
    // C99 6.3.1.3: a cast to an integer type in a constant expression
    // narrows to the target width and re-interprets by signedness, so
    // `(int)UINT_MAX` folds to -1. The fixture self-checks signed
    // sign-extension, unsigned truncation, `_Bool`, an 8-byte target,
    // and runtime/compile-time agreement, all via array-dimension and
    // enum constant expressions.
    assert_eq!(run_fixture("const_expr_cast_narrowing.c"), 0);
}

#[test]
fn scalar_initializer_may_be_brace_enclosed() {
    // C99 6.7.8p11: a scalar initializer is a single expression,
    // optionally brace-enclosed, at block scope (function-body top and
    // nested blocks) and for static locals, not only at file scope. The
    // fixture self-checks braced integer / pointer / non-constant /
    // trailing-comma / static-local / nested-block forms.
    assert_eq!(run_fixture("scalar_brace_initializer.c"), 0);
}

#[test]
fn brace_elided_struct_member_array_init() {
    // C99 6.7.8p20: a struct member that is an array of structs accepts
    // a flat initializer list with each element's braces elided. The
    // fixture self-checks brace-elided elements (each consuming one
    // struct's fields, including a partially-braced nested array member)
    // and zero-fill of an omitted trailing element. Previously a
    // brace-elided element was written as a single struct-width scalar,
    // overflowing the initializer byte writer (panic).
    assert_eq!(run_fixture("brace_elided_struct_array_init.c"), 0);
}

#[test]
fn brace_elided_toplevel_struct_array() {
    // C99 6.7.8p20: brace elision for a top-level array of structs at
    // file scope, block scope, and static local, in known-size and
    // size-from-initializer forms, plus a mix of braced and elided
    // elements. Previously these rejected elided elements, and the
    // known-size static-local path overran its buffer (panic).
    assert_eq!(run_fixture("brace_elided_toplevel_struct_array.c"), 0);
}

#[test]
fn multichar_constant_packs_bytes() {
    // C99 6.4.4.4p10: a narrow character constant with more than one
    // character packs the bytes with the first character most
    // significant (`value = (value << 8) | byte`). The fixture checks the
    // packed value, that a single-character constant and escape sequences
    // are unaffected, and a char followed by an octal escape.
    assert_eq!(run_fixture("multichar_constant.c"), 0);
}

#[test]
fn sqrtf_fabsf_lower_to_hardware_intrinsics() {
    // C99 7.12.7.5 / 7.12.7.2: sqrtf / fabsf lower to a single hardware
    // instruction (no math library), so they run on the interpreter too.
    // The fixture self-checks several values, a float result widened to
    // double, nesting, and a non-constant argument.
    assert_eq!(run_fixture("fp_unary_intrinsic.c"), 0);
}

#[test]
fn wide_string_literal_size_includes_one_terminator() {
    // C99 6.4.5: a wide string literal is `wchar_t[N+1]` with a single
    // wide terminator; adjacent wide literals concatenate. The lexer
    // appends the wchar_t-width NUL, so the parser must not also append
    // the narrow one-byte NUL. The fixture checks sizes (empty, single,
    // multi, concatenated), narrow-literal sizes for contrast, and wide
    // content across a concatenation.
    assert_eq!(run_fixture("wide_string_literal_size.c"), 0);
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

//! End-to-end tests: load a C source from `tests/fixtures/c/`, compile, run, and
//! check the exit code. These exercise the whole pipeline.

use super::run_fixture;
use super::run_str;

#[test]
fn constructors_run_before_main_in_priority_order() {
    // `__attribute__((constructor))` functions run before `main` under
    // the interpreter, ordered as the native `.init_array` runs them:
    // prioritized ascending, then unprioritized. `main` observes their
    // writes; the encoded return pins the order (portable, no native
    // toolchain needed).
    let src = "
        static int order[8];
        static int n;
        __attribute__((constructor(102))) static void c2(void) { order[n++] = 2; }
        __attribute__((constructor(101))) static void c1(void) { order[n++] = 1; }
        __attribute__((constructor)) static void c3(void) { order[n++] = 3; }
        int main(void) {
            if (n != 3) return 100;
            return order[0] * 100 + order[1] * 10 + order[2];
        }
    ";
    assert_eq!(run_str(src), 123);
}

#[test]
fn destructor_runs_after_main_without_disturbing_return() {
    // A destructor runs after `main` returns (the VM has no way for
    // `main` to observe it), so `main` still returns the constructor's
    // value and the destructor path executes without error. Destructor
    // ordering is pinned by the native Linux suites' stdout sequence.
    let src = "
        static int n;
        __attribute__((constructor)) static void ctor(void) { n = 5; }
        __attribute__((destructor)) static void dtor(void) { n = 0; }
        int main(void) { return n; }
    ";
    assert_eq!(run_str(src), 5);
}

// C23 6.7.13 `[[...]]` attribute-specifier-sequences in the declarator
// positions GNU headers place them: after a pointer `*`, leading a
// declaration, after the type before the identifier, before a
// parenthesized function-pointer declarator, and on a struct member. All
// are parsed and ignored; the program's value pins that they were skipped,
// not miscompiled.
#[test]
fn c23_attribute_specifier_positions() {
    let src = "
        int gv = 5;
        int * [[deprecated]] gp = &gv;
        [[maybe_unused]] static int leading(void) { return 1; }
        void [[cold]] noop(void) { }
        int [[deprecated]] doubler(int x) { return x + x; }
        struct ops { int [[deprecated]] (*fn)(int); };
        int main(void) {
            struct ops o;
            o.fn = doubler;
            noop();
            if (*gp != 5) return 99;
            return o.fn(21) + leading();
        }
    ";
    assert_eq!(run_str(src), 43);
}

// The bundled <sched.h> gained the glibc CPU_COUNT_S / CPU_COUNT set-bit
// counters (popcount over the mask words). Build a mask and check the
// counts, including a byte-limited count over just the first word.
// cpu_set_t and the CPU_* macros are `__linux__`-only, so gate on a
// Linux host where the host-target preprocess defines it.
#[cfg(target_os = "linux")]
#[test]
fn cpu_set_count_macros() {
    let src = "
        #include <sched.h>
        int main(void) {
            cpu_set_t s;
            CPU_ZERO(&s);
            CPU_SET(0, &s);
            CPU_SET(3, &s);
            CPU_SET(64, &s);
            if (CPU_COUNT(&s) != 3) return 1;
            if (CPU_COUNT_S(sizeof(unsigned long), &s) != 2) return 2;
            CPU_CLR(3, &s);
            if (CPU_COUNT(&s) != 2 || !CPU_ISSET(64, &s)) return 3;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn arithmetic() {
    assert_eq!(run_fixture("arithmetic.c"), 60);
}

#[test]
fn compound_literal_struct_field() {
    // C99 6.5.2.5: a compound literal used as a struct field value must
    // not drop the fields written before it. Returns 0 only when every
    // field survived.
    assert_eq!(run_fixture("compound_literal_struct_field.c"), 0);
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
fn anon_member_designated_init() {
    // C11 6.7.2.1: `.member = { ... }` designating a named aggregate member
    // inside an anonymous union/struct initializes that member's own type,
    // distinct from a positional brace selecting a group member.
    assert_eq!(run_fixture("anon_member_designated_init.c"), 0);
}

#[test]
fn runtime_anon_struct_init() {
    // The unified initializer engine gives the runtime (non-constant) store
    // path the same anonymous-struct / anonymous-union / nested-aggregate
    // handling the constant-staging path has.
    assert_eq!(run_fixture("runtime_anon_struct_init.c"), 0);
}

#[test]
fn runtime_array_designator() {
    // C99 6.7.8p6 `[N] =` array designators interleaved with positional
    // entries in a runtime (non-constant) array initializer, at parity with
    // the constant-staging path.
    assert_eq!(run_fixture("runtime_array_designator.c"), 0);
}

#[test]
fn anon_struct_designated_init() {
    // C99 6.7.8p7: `.member` designators inside a brace on a flattened
    // anonymous-struct region, out of order, in both the constant and the
    // runtime store paths.
    assert_eq!(run_fixture("anon_struct_designated_init.c"), 0);
}

#[test]
fn wide_string_struct_member() {
    // C99 6.7.8p15: a wide string literal initializes a wchar_t-width array
    // member; constant (file-scope + local) and runtime store paths, with
    // tail zero-fill and exact-fit NUL drop.
    assert_eq!(run_fixture("wide_string_struct_member.c"), 0);
}

#[test]
fn inline_asm_memory_operand() {
    // An inline-asm `"m"` / `"+m"` operand is a memory reference: the
    // interlocked `lock cmpxchg` / `lock xadd` (edk2 BaseSynchronizationLib)
    // read and write the memory object, not a register (a `lock` on a
    // register destination is an invalid encoding that faults at runtime).
    assert_eq!(run_fixture("inline_asm_memory_operand.c"), 0);
}

#[test]
fn init_2d_struct_array() {
    // A 2D array of structs with an inferred outer dimension
    // (`struct T xs[][M] = { { {...}, ... }, ... }`, OpenSSL's OSSL_PARAM
    // tables) descends the rows instead of misreading a row as one struct.
    // Covers file-scope and static-local; 1D and fixed-size regress.
    assert_eq!(run_fixture("init_2d_struct_array.c"), 0);
}

#[test]
fn init_paren_conditional_arith() {
    // A parenthesized constant conditional followed by arithmetic
    // (`(cond ? a : b) * N`) in an aggregate initializer folds correctly
    // instead of misreading the trailing operators as extra elements
    // (OpenSSL cipher tables use this form).
    assert_eq!(run_fixture("init_paren_conditional_arith.c"), 0);
}

#[test]
fn offsetof_runtime_subscript() {
    // GCC extension: `__builtin_offsetof(T, m[i])` with a non-constant `i`
    // yields the runtime offset `offsetof(T, m) + i * stride` (edk2 firmware
    // uses it). A constant subscript still folds.
    assert_eq!(run_fixture("offsetof_runtime_subscript.c"), 0);
}

#[test]
fn decl_specifier_order() {
    // C99 6.7.1: declaration specifiers may appear in any order. A
    // storage-class specifier after the type (`INTN STATIC f()`, the edk2
    // firmware form) is accepted at file and block scope; internal linkage
    // still applies.
    assert_eq!(run_fixture("decl_specifier_order.c"), 0);
}

#[test]
fn wide_string_pointer_array() {
    // C99 6.7.8: `wchar_t *names[] = { L"a", L"b" }` is a brace list of
    // pointer initializers, not a brace-wrapped string. The wide brace-wrap
    // now requires a wchar_t-width scalar element, so a pointer array stays a
    // brace list (the edk2 `CHAR16 *mDeviceTypeStr[]` form).
    assert_eq!(run_fixture("wide_string_pointer_array.c"), 0);
}

#[test]
fn compound_literal_pointer_field() {
    // C99 6.5.2.5: a pointer struct field taking the address of an
    // array-of-struct compound literal in a static initializer (a
    // real-world descriptor-table shape), including a trailing
    // empty `{ }` element in a deferred-size literal.
    assert_eq!(run_fixture("compound_literal_pointer_field.c"), 0);
}

#[test]
fn zero_length_local_array() {
    // GCC zero-length array `T x[0]` as a local (including inside a
    // statement expression) -- valid and empty, as compile-time-assert
    // idioms rely on; previously rejected as an incomplete array.
    assert_eq!(run_fixture("zero_length_local_array.c"), 0);
}

#[test]
fn int128_type_layout() {
    // GCC `__int128` / `__int128_t` / `__uint128_t` / `unsigned __int128`
    // as a 16-byte type: sizeof, struct / array layout (the aarch64
    // asm/sigcontext.h shape), and by-value copy. The operators are
    // covered by `int128_arithmetic`.
    assert_eq!(run_fixture("int128_type_layout.c"), 0);
}

#[test]
fn int128_arithmetic() {
    // GCC 128-bit integer arithmetic, expanded by the walker over the
    // two 64-bit halves. Each fixture cross-checks against the values
    // gcc / clang produce for the same expressions.
    //   add / sub / neg / bitwise / ++ / -- with carry and borrow,
    //   compound-assignment chains, mixed scalar operands
    assert_eq!(run_fixture("int128_arith.c"), 0);
    //   shifts by 0 / 1 / 63 / 64 / 65 / 127, constant and runtime
    //   counts, logical and arithmetic right shift
    assert_eq!(run_fixture("int128_shift.c"), 0);
    //   the widening 64x64 -> 128 product and the wrapping 128-bit one
    assert_eq!(run_fixture("int128_mul.c"), 0);
    //   equality and all orderings, signed vs unsigned edges
    assert_eq!(run_fixture("int128_cmp.c"), 0);
    //   division / remainder, small and larger-than-64-bit divisors,
    //   C99 6.5.5p6 truncation toward zero
    assert_eq!(run_fixture("int128_divmod.c"), 0);
    //   `!` / `~` / unary minus, controlling-expression truthiness,
    //   a conditional yielding a 128-bit value, short-circuit operands
    assert_eq!(run_fixture("int128_unary.c"), 0);
    //   a comparison's `int` result in every scalar context, including
    //   a variadic argument
    assert_eq!(run_fixture("int128_scalar_result.c"), 0);
    //   the type as a struct member: alignment-driven offsets, brace
    //   initializers, and access through a pointer
    assert_eq!(run_fixture("int128_struct_member.c"), 0);
}

#[test]
fn divq_udiv_qrnnd() {
    // The x86-64 `divq` inline-asm shape (a common `udiv_qrnnd` 128/64
    // divide) as Intrinsic::Divq128: unsigned 128/64 division. Run under
    // the VM, which computes it in 128-bit host arithmetic (the native
    // x86-64 backend emits `div r/m64`; other native targets gate it out).
    assert_eq!(run_fixture("divq_udiv_qrnnd.c"), 0);
}

#[test]
fn rdtsc_host_ticks() {
    // The x86-64 `rdtsc` inline-asm shape (a common host-tick counter)
    // as Intrinsic::Rdtsc: two register-tied outputs, no inputs. The VM
    // zeroes the counter (no host clock); native x86-64 emits `rdtsc`.
    assert_eq!(run_fixture("rdtsc_host_ticks.c"), 0);
}

#[test]
fn cpuid_partial_outputs() {
    // A `cpuid` asm with one output and the remaining implicit outputs
    // listed as clobbers lowers to the same Intrinsic::Cpuid as the
    // full four-output form; the VM zeroes every output, including the
    // synthesized scratch slots of the clobbered registers.
    assert_eq!(run_fixture("cpuid_partial_outputs.c"), 0);
}

#[test]
fn cacheflush_asm() {
    // AArch64 `mrs ctr_el0` / `dc cvau` / `ic ivau` / `dsb ish` / `isb`
    // (a common cache-flush sequence) as fixed-encoding intrinsics. Run
    // under the VM (native aarch64 emits the real instructions, which
    // need EL0 cache-op permission; x86-64 gates them out).
    assert_eq!(run_fixture("cacheflush_asm.c"), 0);
}

#[test]
fn atomic128_ldaxp_stlxp() {
    // AArch64 128-bit atomic RMW via the ldaxp/stlxp exclusive pair: the
    // compare-exchange (match + mismatch), exchange, fetch-and and fetch-or
    // shapes. Under the VM the sequence runs as an ordinary load / modify /
    // store; native aarch64 emits the exclusive-pair loop (x86-64 gates the
    // shape out). The fixture returns 0 only when every prior value and
    // stored result is correct.
    assert_eq!(run_fixture("atomic128_ldaxp_stlxp.c"), 0);
}

#[test]
fn atomic128_ldst() {
    // AArch64 128-bit atomic load / store via the ldp/stp and ldxp/stxp
    // idioms: the plain and exclusive forms, cross-checked so a value stored
    // by one form reads back through the other, plus a plain load from a
    // read-only object. Under the VM each runs as an ordinary load / store;
    // native aarch64 emits the real sequence (x86-64 gates the shape out).
    // The fixture returns 0 only when every round-trip is correct.
    assert_eq!(run_fixture("atomic128_ldst.c"), 0);
}

#[test]
fn builtin_inf() {
    // __builtin_inf / __builtin_inff / __builtin_huge_val are positive
    // infinity; the Linux SYNC_FILE_RANGE_* flags ride along under guard.
    assert_eq!(run_fixture("builtin_inf.c"), 0);
}

#[test]
fn alignof_expression() {
    // GCC `__alignof__` accepts an expression operand (C11 `_Alignof` is
    // type-only); the alignment is that of the operand's unevaluated type,
    // and the type-name form still works.
    assert_eq!(run_fixture("alignof_expression.c"), 0);
}

#[test]
fn builtin_return_address() {
    // __builtin_return_address(0) is the caller's return address; native
    // reads the saved slot at [fp+8], the VM returns a non-zero per-frame
    // proxy. The fixture returns 0 only when it is non-null.
    assert_eq!(run_fixture("builtin_return_address.c"), 0);
}

#[test]
fn atomic_op_fetch() {
    // C11 __atomic_*_fetch builtins (add/sub/and/or/xor) return the updated
    // value, unlike the __atomic_fetch_* family; the older __sync_*_and_fetch
    // spelling does too. The fixture checks the return value and the store.
    assert_eq!(run_fixture("atomic_op_fetch.c"), 0);
}

#[test]
fn case_range() {
    // GNU case ranges `case lo ... hi:` -- boundaries, interior, stacked
    // ranges sharing a body, mixed with single labels, and fall-through
    // out of a range into the next label.
    assert_eq!(run_fixture("case_range.c"), 0);
}

#[test]
fn case_range_wide() {
    // A wide `case lo ... hi` is dispatched by a bounds comparison, so a
    // range spanning millions of values (a real-world register-decode /
    // page-table switch) needs no per-value expansion; signed and unsigned.
    assert_eq!(run_fixture("case_range_wide.c"), 0);
}

#[test]
fn deferred_array_designator() {
    // A deferred-size array's size is max designated index + 1 (C99 6.7.8p22),
    // via array designators with gaps (a real-world sparse memory-map table).
    assert_eq!(run_fixture("deferred_array_designator.c"), 0);
}

#[test]
fn outer_range_designator_replicates_subarray() {
    // A GCC range designator on the outer dimension of an array of
    // aggregates (`[a ... b] = { ... }`) replicates the brace-enclosed
    // sub-array across every covered index, so the deferred outer size
    // resolves to `max index + 1` -- not the ragged element count that
    // dropped the last row and under-sized the array (state-transition
    // table shape: rows selected by an enum, one range covering the two
    // start states, then a two-level designator patching the last row).
    let src = "
        enum { S_A = 1, S_START = 4, S_INTERP = 5 };
        static const unsigned char tbl[][8] = {
            [S_A] = { [0 ... 7] = 9 },
            [S_START ... S_INTERP] = { [1] = 3, [2 ... 4] = 7 },
            [S_INTERP][6] = 5,
        };
        int main(void) {
            if (sizeof(tbl) / sizeof(tbl[0]) != 6) return 1;
            if (tbl[4][1] != 3 || tbl[4][2] != 7 || tbl[4][4] != 7 || tbl[4][0] != 0) return 2;
            if (tbl[5][1] != 3 || tbl[5][2] != 7 || tbl[5][4] != 7) return 3;
            if (tbl[5][6] != 5) return 4;
            if (tbl[4][6] != 0) return 5;
            if (tbl[1][0] != 9 || tbl[1][7] != 9) return 6;
            if (tbl[0][0] != 0 || tbl[2][3] != 0 || tbl[3][7] != 0) return 7;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn outer_range_designator_replicates_string_rows() {
    // A GCC range designator whose value is a string literal
    // (`[a ... b] = "..."`) replicates the row across every covered
    // index of a 2-D character array, zero-padding each to the row
    // width -- the string-row counterpart of the brace-list case above.
    let src = "
        static const char m[][6] = { [0 ... 2] = \"abc\", [4] = \"XY\" };
        int main(void) {
            if (sizeof(m) / sizeof(m[0]) != 5) return 1;
            for (int r = 0; r <= 2; r++)
                if (m[r][0] != 'a' || m[r][1] != 'b' || m[r][2] != 'c'
                    || m[r][3] != 0 || m[r][5] != 0) return 2 + r;
            if (m[3][0] != 0 || m[3][5] != 0) return 6;
            if (m[4][0] != 'X' || m[4][1] != 'Y' || m[4][2] != 0) return 7;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn member_array_designator() {
    // C99 6.7.8p7 `.member[i] = value` designator chain into an array-typed
    // struct member (a real-world device-register table shape).
    assert_eq!(run_fixture("member_array_designator.c"), 0);
}

#[test]
fn designator_array_field_compound() {
    // C99 6.7.8p7 compound designator `[N].field = value` on a deferred-size
    // struct-array element in a file-scope initializer (a dispatch-table
    // shape). The size is set by the highest designated index.
    assert_eq!(run_fixture("designator_array_field_compound.c"), 0);
}

#[test]
fn typedef_pointer_array() {
    // A `typedef T *Name[N]` array-of-pointer typedef folds its dimension onto
    // an object like any array typedef (a real-world string-table shape), while
    // a declarator that adds a pointer stays pointer-to-array.
    assert_eq!(run_fixture("typedef_pointer_array.c"), 0);
}

#[test]
fn anon_union_nested_init() {
    // A struct with an anonymous union whose selected member is an aggregate
    // may be brace-initialized with an explicit union sub-brace
    // (`{ { { bytes } } }`, a real-world UUID table shape).
    assert_eq!(run_fixture("anon_union_nested_init.c"), 0);
}

#[test]
fn compound_literal_addr_init() {
    // The address of a compound literal `&(T){...}` as an aggregate element /
    // member value, including nested (a real-world config-struct table).
    assert_eq!(run_fixture("compound_literal_addr_init.c"), 0);
}

#[test]
fn scalar_compound_literal_lvalue() {
    // C99 6.5.2.5p4: a compound literal is an lvalue. Taking the address of a
    // scalar literal `&(int){5}` must work, not only the struct / array forms.
    assert_eq!(run_fixture("scalar_compound_literal_lvalue.c"), 0);
}

#[test]
fn compound_literal_array_element() {
    // An array-of-struct element written as a compound literal `(T){...}`
    // naming the element type (C99 6.5.2.5).
    assert_eq!(run_fixture("compound_literal_array_element.c"), 0);
}

#[test]
fn deferred_array_typedef() {
    // A deferred-size array typedef (`typedef T X[]`) binds an object as a
    // deferred array sized by its initializer (a real-world init-array shape).
    assert_eq!(run_fixture("deferred_array_typedef.c"), 0);
}

#[test]
fn local_array_designator() {
    // A block-scope struct array (static or automatic) may use `[N] =`
    // designators and take its deferred size from the largest index.
    assert_eq!(run_fixture("local_array_designator.c"), 0);
}

#[test]
fn math_compare_macros() {
    // C99 7.12.14 relational macros (isgreater/isless/isunordered/...);
    // NaN operands compare false and are unordered.
    assert_eq!(run_fixture("math_compare_macros.c"), 0);
}

#[test]
fn function_type_param() {
    // C99 6.7.5.3p8: an abstract function-type parameter `RET(types)` decays
    // to a function pointer (a real-world test-driver shape), without
    // breaking parenthesized declarators or `(*fp)` parameters.
    assert_eq!(run_fixture("function_type_param.c"), 0);
}

#[test]
fn bitfield_runtime_init() {
    // A bitfield struct member initialized at block scope by a non-constant
    // value: the walker read-modify-writes the storage unit. Signedness,
    // packing across units, and interleaving with regular fields.
    assert_eq!(run_fixture("bitfield_runtime_init.c"), 0);
}

#[test]
fn aligned_member() {
    // `__attribute__((aligned(16)))` on a struct member / its type raises the
    // member and aggregate alignment to 16 (a real-world aligned-struct
    // shape). Layout, size, alignment, and value round-trip.
    assert_eq!(run_fixture("aligned_member.c"), 0);
}

#[test]
fn packed_enum() {
    // `enum __attribute__((packed))` uses the smallest integer type holding
    // its values, changing the layout of an embedding struct (a real-world
    // status-field shape). Sizes, interleaved-field offsets, and sign-extension.
    assert_eq!(run_fixture("packed_enum.c"), 0);
}

#[test]
fn hex_case_range() {
    // `case 0x10...0x20:` (no spaces around `...`, common after macro
    // expansion) must lex the hex integer + ellipsis, not a hex float; a
    // real hex float `0x1.8p3` must still lex as a float.
    assert_eq!(run_fixture("hex_case_range.c"), 0);
}

#[test]
fn elvis_operator() {
    // GNU conditional with omitted middle operand `a ?: b`: single
    // evaluation of the condition, truthy/falsy selection, pointer and
    // nested forms, int->long result widening, and constant contexts.
    assert_eq!(run_fixture("elvis_operator.c"), 0);
}

#[test]
fn runtime_array_member() {
    // C99 6.7.8p13: an array member of a local struct initialized by a
    // brace list with non-constant elements -- full, partial (zero-filled
    // tail), 2D, brace-elided, and designated forms. Previously rejected.
    assert_eq!(run_fixture("runtime_array_member.c"), 0);
}

#[test]
fn builtin_type_macros() {
    // GCC/Clang predefined `__SIZE_TYPE__` / `__PTRDIFF_TYPE__` /
    // `__INTPTR_TYPE__` / `__UINTPTR_TYPE__`: width tracks the pointer
    // size and signedness is correct, as headers rely on for typedefs.
    assert_eq!(run_fixture("builtin_type_macros.c"), 0);
}

#[test]
fn stmt_expr() {
    // GCC statement expressions `({ ... })`: value from the last
    // expression-statement, single-evaluation side effects, own block
    // scope, comma declarators, and nesting.
    assert_eq!(run_fixture("stmt_expr.c"), 0);
}

#[test]
fn generic_selection() {
    // C11 6.5.1.1 `_Generic`: type dispatch, `default`, the
    // unevaluated-non-selected rule, pointer-to-struct dispatch, and use
    // in integer and address static initializers.
    assert_eq!(run_fixture("generic_selection.c"), 0);
}

#[test]
fn builtin_types_compatible() {
    // GCC `__builtin_types_compatible_p`: constant and runtime contexts,
    // qualifier/signedness rules, and composition with `typeof` as in a
    // common qualifier-stripping macro.
    assert_eq!(run_fixture("builtin_types_compatible.c"), 0);
}

#[test]
fn builtin_types_compatible_array() {
    // C99 6.7.5.2p6: array type names as `__builtin_types_compatible_p`
    // arguments, including an omitted bound matching any bound, mismatched
    // bounds, rank, and array-vs-pointer. Matches gcc and clang.
    assert_eq!(run_fixture("builtin_types_compatible_array.c"), 0);
}

#[test]
fn has_builtin_clrsb() {
    // `__has_builtin(NAME)` preprocessor operator routes supported vs
    // unsupported builtins, and `__builtin_clrsb` / `__builtin_clrsbll`
    // count leading redundant sign bits.
    assert_eq!(run_fixture("has_builtin_clrsb.c"), 0);
}

#[test]
fn builtin_overflow() {
    // GCC `__builtin_{add,sub,mul}_overflow`: signed / unsigned at 32 and
    // 64 bits, wrapped result and overflow flag, at the type boundaries.
    assert_eq!(run_fixture("builtin_overflow.c"), 0);
}

#[test]
fn builtin_parity() {
    // GCC `__builtin_parity` / `__builtin_parityll`: odd-set-bit predicate
    // (`popcount(x) & 1`), constant and runtime.
    assert_eq!(run_fixture("builtin_parity.c"), 0);
}

#[test]
fn has_attribute() {
    // `__has_attribute` operator: recognized-attribute predicate, the
    // `#ifdef` guard, `__`-wrapped names, and resolution through a macro
    // alias (a common `__has_attribute` wrapper).
    assert_eq!(run_fixture("has_attribute.c"), 0);
}

#[test]
fn typeof_array_compatible() {
    // C99 6.7.6.2: `typeof(arr)` and `typeof(&arr[0])` are an array and a
    // pointer, never compatible. Drives the common array-length / is-array
    // macros built on `typeof`.
    assert_eq!(run_fixture("typeof_array_compatible.c"), 0);
}

#[test]
fn typeof_array_row() {
    // A subscripted row of a multi-dim array, a `*p` pointer-to-array deref,
    // and a string literal all have array type. Drives a common
    // array-length macro over a row of a 2-D table.
    assert_eq!(run_fixture("typeof_array_row.c"), 0);
}

#[test]
fn typeof_expression() {
    // `typeof(expr)` over a full expression: binary, shift, conditional
    // (the common MIN/MAX `typeof(1 ? (a) : (b))` shape), and comma operators.
    assert_eq!(run_fixture("typeof_expression.c"), 0);
}

#[test]
fn file_scope_typeof() {
    // `typeof` / `__typeof__` as a file-scope declaration specifier, over a
    // type-name or an expression operand. The block-scope path already
    // handled it; the file-scope declaration loop lacked the branch.
    assert_eq!(run_fixture("file_scope_typeof.c"), 0);
}

#[test]
fn atomic_generic() {
    // GCC generic `__atomic_load(p, ret, mo)` / `__atomic_store(p, val, mo)`
    // move the value through a pointer; 32/64-bit and pointer widths.
    assert_eq!(run_fixture("atomic_generic.c"), 0);
}

#[test]
fn cpu_relax_hint() {
    // The CPU spin-loop hint spelled `rep; nop` (x86 PAUSE), `pause`, and
    // `yield` (arm) all normalize to the relax hint.
    assert_eq!(run_fixture("cpu_relax_hint.c"), 0);
}

#[test]
fn empty_struct_member() {
    // A complete empty `struct {}` member contributes zero storage (GCC),
    // so the common flexible-array-in-union idiom lays a flexible array
    // over a union's first member. Forward-declared members stay rejected.
    assert_eq!(run_fixture("empty_struct_member.c"), 0);
}

#[test]
fn int128_struct_fallback() {
    // A struct-based 128-bit integer (used when the compiler lacks
    // __int128): 16-byte struct-by-value returns / params, designated
    // compound literals, and carry / borrow arithmetic across the halves.
    assert_eq!(run_fixture("int128_struct_fallback.c"), 0);
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
fn float_ternary_promote() {
    // C99 6.5.15: an FP-typed conditional expression rides the fused
    // StoreLocal / LoadLocal F32 path, keeping the synthetic merge slot
    // mem2reg-promotable while preserving single-precision value.
    assert_eq!(run_fixture("float_ternary_promote.c"), 0);
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
fn static_function_pointer_identity() {
    // C99 6.5.9p6: a function pointer held in static storage and initialized
    // with a function name compares equal to that function's address, and is
    // callable. Regression for the SSA interpreter, which patched a
    // static-initializer code slot with a different tag than a symbol
    // reference, so the two compared unequal.
    assert_eq!(run_fixture("static_function_pointer_identity.c"), 0);
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
fn static_init_once_guard() {
    // C99 6.2.4p3: a static-local initialized by runtime stores
    // (`&&label` elements) runs its initializer once; later calls
    // must not clobber user writes to the table.
    assert_eq!(run_fixture("static_init_once_guard.c"), 0);
}

#[test]
fn computed_goto_static_table() {
    // A static `&&label` dispatch table across repeated calls: the
    // once-guard skip path must leave correct label addresses.
    assert_eq!(run_fixture("computed_goto_static_table.c"), 0);
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
fn fp_const_return() {
    // A floating-constant return reaches the FP return register (d0/xmm0).
    assert_eq!(run_fixture("fp_const_return.c"), 0);
}

#[test]
fn fp_param_float_before_double() {
    // A float parameter ahead of a double in the FP argument bank must not
    // be clobbered when the parameters are materialized at entry.
    assert_eq!(run_fixture("fp_param_float_before_double.c"), 0);
}

#[test]
fn struct_param_stack_spill() {
    // A by-value struct that spills to the stack (preceding scalar args
    // exhaust the integer argument registers) must be read correctly by
    // the callee from the caller's stack argument area.
    assert_eq!(run_fixture("struct_param_stack_spill.c"), 0);
}

#[test]
fn struct_stack_arg_then_scalar() {
    // A by-value 16-byte struct overflowing to the stack argument area
    // followed by a trailing scalar stack argument: the caller copies the
    // struct before the register marshal clobbers its source address, and
    // the callee reads the scalar from the incoming offset past the
    // struct (AAPCS64 5.4.2).
    assert_eq!(run_fixture("struct_stack_arg_then_scalar.c"), 0);
}

#[test]
fn mixed_struct_gpr_abi() {
    // A non-homogeneous aggregate no larger than 16 bytes with a
    // floating-point member passes in general registers (AAPCS64 5.4.2
    // C.10), not by reference.
    assert_eq!(run_fixture("mixed_struct_gpr_abi.c"), 0);
}

#[test]
fn unary_plus_preserves_type() {
    // Unary `+` yields the integer-promoted operand type (C99 6.5.3.3p2);
    // an operand of rank int or above keeps its width and signedness, so
    // a following relational operator runs with the correct type.
    assert_eq!(run_fixture("unary_plus_preserves_type.c"), 0);
}

#[test]
fn local_multidim_aggregate_array_init() {
    // An automatic multi-dimensional array of structs/unions accepts the
    // nested-brace initializer; the inner braces span the inner
    // dimensions (C99 6.7.8).
    assert_eq!(run_fixture("local_multidim_aggregate_array_init.c"), 0);
}

#[test]
fn nested_aggregate_brace_elision() {
    // A nested struct field's braces may be elided, filling its members
    // from the flat list; an unbraced union takes its first member
    // (C99 6.7.8p17/p20).
    assert_eq!(run_fixture("nested_aggregate_brace_elision.c"), 0);
}

#[test]
fn const_addr_multidim_array_elem() {
    // The address of a multi-dimensional array element in a pointer-array
    // initializer strides by the full dimension ladder, not the leaf
    // element size (C99 6.6 / 6.5.2.1p2).
    assert_eq!(run_fixture("const_addr_multidim_array_elem.c"), 0);
}

#[test]
fn unsigned_signed_relational_compare() {
    // A relational comparison whose common type is unsigned and narrower
    // than the register masks a sign-extended signed operand to the common
    // width so the unsigned compare is correct (C99 6.3.1.8).
    assert_eq!(run_fixture("unsigned_signed_relational_compare.c"), 0);
}

#[test]
fn inline_two_reg_struct_param() {
    // A 16-byte all-integer struct parameter inlines: the splice
    // redirects the body's parameter-slot reads to the caller's argument.
    assert_eq!(run_fixture("inline_two_reg_struct_param.c"), 0);
}

#[test]
fn struct_copy_comma_side_effect() {
    // C99 6.5.17: a struct copy as the discarded left operand of a comma,
    // nested in an enclosing assignment to a global, must still execute.
    assert_eq!(run_fixture("struct_copy_comma_side_effect.c"), 0);
}

#[test]
fn assign_expr_value_narrowed() {
    // C99 6.5.16p3: a narrowing integer assignment used as a value
    // yields the converted (narrowed) left-operand value, not the raw
    // right-hand side.
    assert_eq!(run_fixture("assign_expr_value_narrowed.c"), 0);
}

#[test]
fn local_array_runtime_nested_init() {
    // C99 6.7.8: a multi-dimensional automatic array with non-constant
    // element initializers (&local) inits per-element, recursing into
    // nested braces with brace elision and zero-fill of omitted tails.
    assert_eq!(run_fixture("local_array_runtime_nested_init.c"), 0);
}

#[test]
fn global_addr_struct_member() {
    // C99 6.6: the address of a struct member / array element of a static
    // object is an address constant; the designator may chain members and
    // subscripts.
    assert_eq!(run_fixture("global_addr_struct_member.c"), 0);
}

#[test]
fn global_addr_multidim_index() {
    // The address of a multi-dimensional array element is an address
    // constant; each subscript level strides by the product of the inner
    // dimensions times the element size (C99 6.6).
    assert_eq!(run_fixture("global_addr_multidim_index.c"), 0);
}

#[test]
fn struct_array_init_from_lvalue() {
    // An array-of-struct element initialized by a compatible struct
    // expression copies the whole object (C99 6.7.9p13).
    assert_eq!(run_fixture("struct_array_init_from_lvalue.c"), 0);
}

#[test]
fn shift_result_type_signedness() {
    // `E1 << E2` has the type of the promoted E1, so a cast of the
    // result sign-extends per the operand's signedness (C99 6.5.7).
    assert_eq!(run_fixture("shift_result_type_signedness.c"), 0);
}

#[test]
fn integer_negate_shift_overflow() {
    // A 32-bit `int` operation that overflows the width (`1<<31`, `-INT_MIN`)
    // must renormalize before a wider read (C99 6.5.7 / 6.5.3.3p3 / 6.2.5p9).
    assert_eq!(run_fixture("integer_negate_shift_overflow.c"), 0);
}

#[test]
fn posix_unix_headers() {
    // Bundled sys/select.h (fd_set), grp.h, sys/utsname.h.
    assert_eq!(run_fixture("posix_unix_headers.c"), 0);
}

#[test]
fn socket_headers_abi() {
    // Bundled socket headers expose the address structs with the platform ABI.
    assert_eq!(run_fixture("socket_headers_abi.c"), 0);
}

#[test]
fn posix_utime_errno_headers() {
    // badc bundles POSIX <utime.h> (struct utimbuf) and the ENOTCONN errno.
    assert_eq!(run_fixture("posix_utime_errno_headers.c"), 0);
}

#[test]
fn cast_fn_typedef_ptr_in_initializer() {
    // A cast to a function-type-typedef pointer in an initializer must not
    // leak the function-type marker to the next declaration (C99 6.5.4).
    assert_eq!(run_fixture("cast_fn_typedef_ptr_in_initializer.c"), 0);
}

#[test]
fn global_init_paren_operand() {
    // C99 6.6: a parenthesised operand + binary operator in a constant
    // initializer folds with full precedence (`(1) << 5`).
    assert_eq!(run_fixture("global_init_paren_operand.c"), 0);
}

#[test]
fn function_type_typedef_declaration() {
    // C99 6.9.1: a function declared via a function-type typedef (no pointer)
    // is a function, so a following definition is a redeclaration.
    assert_eq!(run_fixture("function_type_typedef_declaration.c"), 0);
}

#[test]
fn float_increment_decrement() {
    // `++` / `--` on a real floating type add / subtract 1 (C99 6.5.3.1 /
    // 6.5.2.4), prefix yielding the new value and postfix the prior.
    assert_eq!(run_fixture("float_increment_decrement.c"), 0);
}

#[test]
fn compound_assign_float_register_resident() {
    // A float lvalue updated via `op=` / `++` / `--` (C99 6.5.16.2,
    // 6.5.2.4, 6.5.3.1) stays promotable to an FP register, matching
    // the `x = x op k` form.
    assert_eq!(run_fixture("compound_assign_float_register_resident.c"), 0);
}

#[test]
fn float_literal_f_suffix() {
    // C99 6.4.4.2p4-5: an `f`/`F`-suffixed floating constant has type
    // `float` and its value is rounded to single precision at the
    // literal. Covers sizeof, widening, the variadic default argument
    // promotion, and hex-float spellings.
    assert_eq!(run_fixture("float_literal_f_suffix.c"), 0);
}

#[test]
fn float_literal_arith_single_precision() {
    // C99 6.3.1.8: `float` combined with an `f`-suffixed constant
    // computes in single precision with no widen / narrow hop.
    assert_eq!(run_fixture("float_literal_arith_single_precision.c"), 0);
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
fn flex_array_member_static_init() {
    // A file-scope object initializing a flexible array member with
    // trailing elements (C99 6.7.2.1p18 GCC/clang extension) must place
    // the element bytes past the fixed struct size without corrupting
    // the next file-scope object.
    assert_eq!(run_fixture("flex_array_member_static_init.c"), 0);
}

#[test]
fn attribute_section_placement() {
    // `section("name")` placements: the interpreter ignores them; the
    // native object writer places the bytes (locked by the object-level
    // tests). The program's behavior is identical either way.
    assert_eq!(run_fixture("attribute_section_placement.c"), 0);
}

#[test]
fn attribute_weak_alias() {
    // `weak` / `alias` / `used`: the interpreter resolves an alias to
    // its target at parse time; weak binding is an object-file
    // property it ignores.
    assert_eq!(run_fixture("attribute_weak_alias.c"), 0);
}

#[test]
fn register_var_stack_pointer() {
    // `register T name asm("sp"/"rsp"/"x29"/"rbp")` reads compile; the
    // interpreter substitutes its per-frame proxy for both pointers.
    assert_eq!(run_fixture("register_var_stack_pointer.c"), 0);
}

#[test]
fn auto_type_inference() {
    // GNU `__auto_type`: initializer supplies the declared type, at
    // block and file scope; arrays decay to pointers.
    assert_eq!(run_fixture("auto_type_inference.c"), 0);
}

#[test]
fn attribute_hot_cold_accepted() {
    // GNU `hot` / `cold` hints parse in declaration and declarator
    // positions without altering behavior.
    assert_eq!(run_fixture("attribute_hot_cold.c"), 0);
}

#[test]
fn attribute_cleanup() {
    // __attribute__((cleanup(fn))) runs fn(&var) at every scope exit
    // (fall-through, return, break, continue), reverse order, innermost
    // scope first; a returned value is evaluated before the cleanups.
    assert_eq!(run_fixture("attribute_cleanup.c"), 0);
}

#[test]
fn sizeof_array_type_and_binding() {
    // `sizeof(T [N])` sizes the array type; `sizeof(arr)[i]` binds to
    // the full unary-expression.
    assert_eq!(run_fixture("sizeof_array_type_and_binding.c"), 0);
}

#[test]
fn sizeof_abstract_fn_ptr() {
    // `sizeof` of an abstract function-pointer type-name `int (*)(int)`
    // is the pointer width, in both the runtime and constant-expression
    // forms (C99 6.5.3.4 / 6.7.6).
    assert_eq!(run_fixture("sizeof_abstract_fn_ptr.c"), 0);
}

#[test]
fn pragma_operator() {
    // The C99 6.10.9 `_Pragma` operator: destringized and handled as the
    // matching `#pragma`, including the macro-stringize and `pack` forms,
    // and not recognized inside a string literal.
    assert_eq!(run_fixture("pragma_operator.c"), 0);
}

#[test]
fn variadic_macro_named_rest() {
    // The GCC named-rest variadic macro `#define foo(rest...)`: the named
    // tail behaves like `__VA_ARGS__`, including `#rest` and `, ##rest`.
    assert_eq!(run_fixture("variadic_macro_named_rest.c"), 0);
}

#[test]
fn stdatomic_c11() {
    // C11 <stdatomic.h> over c5's atomic builtins, the `_Atomic(type-name)`
    // specifier in every base-type position, and the C99 least/fast stdint
    // types.
    assert_eq!(run_fixture("stdatomic_c11.c"), 0);
}

#[test]
fn atomic_rmw_ops() {
    // C11 7.17.7 read-modify-write and compare-exchange across every
    // operator and both exchange outcomes, including the expected-operand
    // write-back on a failed compare-exchange.
    assert_eq!(run_fixture("atomic_rmw_ops.c"), 0);
}

#[test]
fn fn_ptr_typedef_multi_declarator() {
    // A function-pointer typedef declaring several variables in one
    // declaration must give every declarator the pointed-to return type;
    // a later declarator's call result must not be truncated to int.
    assert_eq!(run_fixture("fn_ptr_typedef_multi_declarator.c"), 0);
}

#[test]
fn hfa_struct_return() {
    // A homogeneous floating-point aggregate returns in FP registers
    // (AAPCS64 6.9) rather than through an out-pointer; the member values
    // must round-trip through a call intact.
    assert_eq!(run_fixture("hfa_struct_return.c"), 0);
}

#[test]
fn bitfield_assign_value() {
    // A bitfield assignment used as an rvalue yields the masked field
    // value (C99 6.5.16p3), not the storage word; a chained assignment to
    // adjacent fields of one storage unit observes the inner store.
    assert_eq!(run_fixture("bitfield_assign_value.c"), 0);
}

#[test]
fn struct_arg_indirect_subscript() {
    // A by-value aggregate argument is placed in the platform-ABI
    // registers (System V AMD64 3.2.3 / AAPCS64 6.4.2) through a function
    // pointer, in tail position, and when the argument is a subscript
    // lvalue -- not passed by address on either end.
    assert_eq!(run_fixture("struct_arg_indirect_subscript.c"), 0);
}

#[test]
fn out_pointer_return_float_args() {
    // A struct returned through the out-pointer convention reaches its
    // callee on the all-integer call path; a float argument rides as its
    // f64-widened 8-byte pattern (System V AMD64 3.2.3 / Win64), not as a
    // 4-byte value in the low half of the slot.
    assert_eq!(run_fixture("out_pointer_return_float_args.c"), 0);
}

#[test]
fn compound_literal_tagged_address() {
    // A block-scope compound literal whose member initializer tags an
    // address with a bitwise / shift operator takes the runtime path; a
    // bare `&global` stays a link-time constant (C99 6.5.2.5).
    assert_eq!(run_fixture("compound_literal_tagged_address.c"), 0);
}

#[test]
fn compound_literal_in_call_arg_survives_next_call() {
    // C99 6.5.2.5p5: a block-scope compound literal has automatic storage
    // lasting to the end of the enclosing block. When `&(T){...}` is a call
    // argument, its cells sit above the call's argument-staging frame; the
    // staging recycle must not reclaim them for a later full-expression, or
    // the second literal aliases the first (the polymorphic-lock idiom
    // `f(&(struct L){.object=x, .lock=..., .unlock=...})` twice in a block).
    let src = "
        typedef void Fn(void *);
        struct L { void *object; Fn *lock; Fn *unlock; };
        static void lk(void *x) { (void)x; }
        static void ul(void *x) { (void)x; }
        static struct L *mk(void *x, struct L *l) { return x ? l : 0; }
        static int a, b;
        int main(void) {
            struct L *p = mk(&a, &(struct L){ .object = &a, .lock = lk, .unlock = ul });
            struct L *q = mk(&b, &(struct L){ .object = &b, .lock = lk, .unlock = ul });
            int bad = 0;
            if (p->object != (void *)&a) bad |= 1;
            if (p->lock   != lk)         bad |= 2;
            if (p->unlock != ul)         bad |= 4;
            if (q->object != (void *)&b) bad |= 8;
            return bad;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn function_typed_parameter() {
    // A function-typed parameter `RET name(args)` / `RET (name)(args)`
    // decays to a pointer to function (C99 6.7.5.3p8).
    assert_eq!(run_fixture("function_typed_parameter.c"), 0);
}

#[test]
fn static_init_braced_scalar() {
    // A scalar member's initializer may be brace-enclosed (C99 6.7.9p11),
    // including nested aggregates (a real-world object-header init shape).
    assert_eq!(run_fixture("static_init_braced_scalar.c"), 0);
}

#[test]
fn paren_string_char_array_init() {
    // C99 6.7.9p14 + 6.5.1: a parenthesized string literal initializes a
    // char array by copying its bytes (a common `._data = (LITERAL)` macro
    // shape), not by storing the literal's pointer.
    assert_eq!(run_fixture("paren_string_char_array_init.c"), 0);
}

#[test]
fn static_init_paren_relocation() {
    // A relocation-bearing initializer leaf (function / `&global`) may be
    // wrapped in redundant parentheses and casts (the method-table idiom).
    assert_eq!(run_fixture("static_init_paren_relocation.c"), 0);
}

#[test]
fn const_conditional_address_init() {
    // C99 6.6: a constant-condition conditional whose arms are address
    // constants selects one arm; its relocation must reach the static
    // initializer (a real-world character-table idiom).
    assert_eq!(run_fixture("const_conditional_address_init.c"), 0);
}

#[test]
fn do_while_zero_returns() {
    // A `do { ...; return; } while (0)` body never reaches the exit test,
    // so the function does not fall off its end (C99 6.8.5).
    assert_eq!(run_fixture("do_while_zero_returns.c"), 0);
}

#[test]
fn self_referential_macro() {
    // A self-referential function-like macro expands once and the
    // recurring name becomes the function, while an argument macro still
    // expands (C99 6.10.3.4) -- a common accessor-macro idiom.
    assert_eq!(run_fixture("self_referential_macro.c"), 0);
}

#[test]
fn logical_not_float() {
    // `!x` on a floating-point operand is the FP comparison `x == 0`
    // (C99 6.5.3.3p5), not an integer comparison of the bit pattern.
    assert_eq!(run_fixture("logical_not_float.c"), 0);
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
fn inline_struct_param_mutated() {
    // A helper that mutates its by-value struct parameter stays out of
    // line; the caller's copy is unaffected.
    assert_eq!(run_fixture("inline_struct_param_mutated.c"), 0);
}

#[test]
fn inline_struct_return_escape() {
    // A struct-returning helper with an escaping store through a pointer
    // parameter stays out of line; the escaping write still happens.
    assert_eq!(run_fixture("inline_struct_return_escape.c"), 0);
}

#[test]
fn inline_one_word_struct_return() {
    // A one-word-struct-returning helper inlines; its result-slot writes
    // redirect to the caller's return slot.
    assert_eq!(run_fixture("inline_one_word_struct_return.c"), 0);
}

#[test]
fn inline_struct_return_reg() {
    // A one-word-struct return is forwarded out of its frame slot into a
    // register: a store-into-array-slot, a field read, and a local-variable
    // round-trip all read the stored word directly.
    assert_eq!(run_fixture("inline_struct_return_reg.c"), 0);
}

#[test]
fn inline_two_word_struct_return() {
    // A helper returning a 16-byte struct (two integer registers) inlines,
    // including a partially-written union whose unspecified bytes need not
    // be reproduced.
    assert_eq!(run_fixture("inline_two_word_struct_return.c"), 0);
}

#[test]
fn store_forward_local_slot() {
    // A frame-slot store immediately reloaded in one block forwards to
    // the stored value; volatile, address-taken, and cross-block pairs
    // reload from memory.
    assert_eq!(run_fixture("store_forward_local_slot.c"), 0);
}

#[test]
fn struct_return_reg_computed_goto() {
    // A one-word-struct return that carries a label address is promoted out
    // of its frame slot; the computed-goto terminator reading the field must
    // be redirected to the stored word rather than the neutralised slot.
    assert_eq!(run_fixture("struct_return_reg_computed_goto.c"), 0);
}

#[test]
fn inline_one_word_struct() {
    // A read-only helper taking a one-word struct by value inlines; its
    // field load redirects to the caller's argument address.
    assert_eq!(run_fixture("inline_one_word_struct.c"), 0);
}

#[test]
fn inline_into_computed_goto() {
    // A single-block helper inlines into a computed-goto caller. The flat
    // splice keeps block ids fixed, so the caller's `Inst::BlockAddr` and
    // computed-goto target table stay valid and dispatch is correct.
    assert_eq!(run_fixture("inline_into_computed_goto.c"), 0);
}

#[test]
fn inline_arg_count_mismatch() {
    // A call passing fewer arguments than the callee has parameters is
    // not inlined, so the optimized IR stays well-formed.
    assert_eq!(run_fixture("inline_arg_count_mismatch.c"), 0);
}

#[test]
fn inline_phi_caller_leaf_helper() {
    // A single-block leaf helper inlines into a caller whose loop-carried
    // values are phis; the value-remap fixpoint resolves each phi's
    // back-edge incoming so the spliced body stays well-formed.
    assert_eq!(run_fixture("inline_phi_caller_leaf_helper.c"), 0);
}

#[test]
fn inline_phi_narrow_param_return() {
    // A leaf returning its narrow parameter inlines to an Extend of the
    // call argument; the call result resolves to that Extend. With a
    // loop-carried (back-edge) argument the value-remap fixpoint must
    // converge the Extend's operand, and the parameter narrows the wide
    // argument every iteration (the callee-narrows ABI).
    assert_eq!(run_fixture("inline_phi_narrow_param_return.c"), 0);
}

#[test]
fn reg_alloc_callee_bank_call_block_before_loop() {
    // A recursive function whose call block is laid out at a lower pc
    // than its hot loop: only the values whose CFG live range spans
    // the calls need callee-saved homes. A pc-interval class test also
    // flagged the loop-local values, overfilled the callee bank, and
    // spilled the loop induction variable.
    assert_eq!(
        run_fixture("reg_alloc_callee_bank_call_block_before_loop.c"),
        0
    );
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
fn inline_asm_raw_bytes() {
    // Raw machine bytes emitted from a template (`.byte` directive and the
    // bare hex-byte run) encode a no-op per target; the interpreter models
    // them as opaque and the surrounding computation is unaffected.
    assert_eq!(run_fixture("inline_asm_raw_bytes.c"), 0);
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
fn setbuffer_is_a_unix_stdio_binding() {
    use crate::{CompileOptions, Compiler, Target};
    // The BSD `setbuffer` is bound on the Unix targets (glibc / macOS) and
    // absent on Windows (msvcrt has no such symbol); a successful compile
    // is the presence check.
    let compiles = |target: Target| -> bool {
        let src = "#include <stdio.h>\nvoid f(char *b) { setbuffer(0, b, 512); }\n";
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), target, opts)
            .compile()
            .is_ok()
    };
    assert!(compiles(Target::LinuxAarch64), "setbuffer on linux-aarch64");
    assert!(compiles(Target::LinuxX64), "setbuffer on linux-x64");
    assert!(compiles(Target::MacOSAarch64), "setbuffer on macos");
    assert!(
        !compiles(Target::WindowsX64),
        "setbuffer must be absent on Windows"
    );
}

#[test]
fn struct_mmsghdr_batched_socket_io() {
    use crate::{CompileOptions, Compiler, Target};
    // struct mmsghdr + recvmmsg/sendmmsg -- the GNU/Linux batched-socket
    // extension. A successful compile is the presence check for the
    // struct's msg_len field and the two prototypes.
    let src = "#define _GNU_SOURCE\n\
               #include <sys/socket.h>\n\
               struct timespec;\n\
               unsigned len_of(struct mmsghdr *m) { return m->msg_len; }\n\
               int io(int f, struct mmsghdr *m, unsigned n, struct timespec *t) {\n\
                   return recvmmsg(f, m, n, 0, t) + sendmmsg(f, m, n, 0);\n\
               }";
    let compiles = |target: Target| -> bool {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), target, opts)
            .compile()
            .is_ok()
    };
    assert!(compiles(Target::LinuxX64), "mmsghdr on linux-x64");
    assert!(compiles(Target::LinuxAarch64), "mmsghdr on linux-aarch64");
}

#[test]
fn fcntl_stat_constants_match_the_target_libc() {
    use crate::{CompileOptions, Compiler, Target};
    // A negative-size array declaration is a compile error unless every
    // constant matches, so a successful compile IS the assertion.
    let compiles = |src: &str, target: Target| -> bool {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), target, opts)
            .compile()
            .is_ok()
    };
    // aarch64 and x86-64 rearrange O_DIRECT / O_DIRECTORY / O_NOFOLLOW;
    // O_LARGEFILE is 0 on both 64-bit targets. S_ISVTX and the UTIME_*
    // values are arch-independent. Values verified against gcc.
    let common = "&& O_ASYNC==020000 && FASYNC==020000 && O_LARGEFILE==0 \
                  && S_ISVTX==01000 && UTIME_NOW==((1L<<30)-1L) \
                  && UTIME_OMIT==((1L<<30)-2L)";
    let aarch64 = format!(
        "#include <fcntl.h>\n#include <sys/stat.h>\nint ck[(O_DIRECT==0200000 \
         && O_DIRECTORY==040000 && O_NOFOLLOW==0100000 {common})?1:-1];\n"
    );
    let x86_64 = format!(
        "#include <fcntl.h>\n#include <sys/stat.h>\nint ck[(O_DIRECT==040000 \
         && O_DIRECTORY==0200000 && O_NOFOLLOW==0400000 {common})?1:-1];\n"
    );
    assert!(compiles(&aarch64, Target::LinuxAarch64), "aarch64 values");
    assert!(compiles(&x86_64, Target::LinuxX64), "x86-64 values");
    // A wrong value must fail, proving the assertion actually bites.
    let wrong = "#include <fcntl.h>\nint ck[(O_DIRECT==0)?1:-1];\n";
    assert!(
        !compiles(wrong, Target::LinuxAarch64),
        "a wrong constant should fail to compile"
    );
}

#[test]
fn linux_falloc_parport_uapi_headers() {
    use crate::{CompileOptions, Compiler, Target};
    // The bundled linux/falloc.h, linux/ppdev.h and linux/parport.h uapi
    // headers plus the fcntl.h `fallocate` binding: a successful compile of
    // the negative-size-array assertion IS the check (values are arch
    // independent). The ppdev ioctls and the fallocate call must also parse.
    let compiles = |src: &str| -> bool {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .is_ok()
    };
    let src = "#include <fcntl.h>\n#include <linux/falloc.h>\n\
               #include <linux/ppdev.h>\n#include <linux/parport.h>\n\
               int ck[(FALLOC_FL_KEEP_SIZE==0x01 && FALLOC_FL_PUNCH_HOLE==0x02 \
               && FALLOC_FL_ZERO_RANGE==0x10 && FALLOC_FL_INSERT_RANGE==0x20 \
               && PARPORT_CONTROL_STROBE==0x1 && PARPORT_STATUS_BUSY==0x80 \
               && IEEE1284_MODE_ECP==0x10 && PARPORT_CLASS_PRINTER==1 \
               && PPCLAIM!=0 && PPRELEASE!=0)?1:-1];\n\
               int use_fallocate(int fd){ return fallocate(fd, FALLOC_FL_PUNCH_HOLE, 0, 4096); }\n";
    assert!(
        compiles(src),
        "bundled uapi headers + fallocate must compile"
    );
    let wrong = "#include <linux/falloc.h>\nint ck[(FALLOC_FL_PUNCH_HOLE==0)?1:-1];\n";
    assert!(!compiles(wrong), "a wrong constant should fail to compile");
}

#[test]
fn linux_vsock_errqueue_socket_constants() {
    use crate::{CompileOptions, Compiler, Target};
    // AF_VSOCK / SO_PEERCRED / IPPROTO_MPTCP and the bundled linux/
    // vm_sockets.h + errqueue.h (with linux/time_types.h): the socket
    // credential struct and the vsock address struct must define, and the
    // constants match (arch independent). A successful compile is the check.
    let compiles = |src: &str| -> bool {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .is_ok()
    };
    let src = "#include <sys/socket.h>\n#include <netinet/in.h>\n\
               #include <linux/vm_sockets.h>\n#include <linux/errqueue.h>\n\
               int ck[(AF_VSOCK==40 && PF_VSOCK==40 && SO_PEERCRED==17 \
               && SO_PASSCRED==16 && IPPROTO_MPTCP==262 && VMADDR_CID_HOST==2 \
               && SO_EE_ORIGIN_ICMP==2 && SCM_TSTAMP_ACK==2)?1:-1];\n\
               int cred_size(void){ struct ucred u; return sizeof(u.pid)+sizeof(u.uid)+sizeof(u.gid); }\n\
               int vm_size(void){ struct sockaddr_vm v; return sizeof(v)==sizeof(struct sockaddr); }\n";
    assert!(
        compiles(src),
        "vsock/errqueue headers + constants must compile"
    );
    let wrong = "#include <sys/socket.h>\nint ck[(AF_VSOCK==0)?1:-1];\n";
    assert!(!compiles(wrong), "a wrong constant should fail to compile");
}

#[test]
fn linux_can_socket_and_block_headers() {
    use crate::{CompileOptions, Compiler, Target};
    // AF_CAN / SOCK_RAW / SIOCGIFINDEX and the bundled linux/can.h,
    // linux/can/raw.h and linux/blkzoned.h uapi headers: constants match
    // (arch independent) and the CAN frame / address structs define.
    let compiles = |src: &str| -> bool {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .is_ok()
    };
    let src = "#include <sys/socket.h>\n#include <net/if.h>\n\
               #include <linux/can.h>\n#include <linux/can/raw.h>\n\
               #include <linux/blkzoned.h>\n\
               int ck[(AF_CAN==29 && PF_CAN==29 && SOCK_RAW==3 && SOCK_SEQPACKET==5 \
               && SIOCGIFINDEX==0x8933 && CAN_RAW==1 && CAN_MAX_DLEN==8 \
               && CANFD_MAX_DLEN==64 && SOL_CAN_RAW==101 && CAN_RAW_FD_FRAMES==5 \
               && BLK_ZONE_COND_FULL==0xE)?1:-1];\n\
               int sz(void){ struct can_frame f; struct sockaddr_can a; struct blk_zone_range r; \
               return sizeof(f)+sizeof(a)+sizeof(r); }\n";
    assert!(
        compiles(src),
        "can/block uapi headers + constants must compile"
    );
    let wrong = "#include <sys/socket.h>\nint ck[(SOCK_RAW==0)?1:-1];\n";
    assert!(!compiles(wrong), "a wrong constant should fail to compile");
}

#[test]
fn linux_block_device_and_file_headers() {
    use crate::{CompileOptions, Compiler, Target};
    // The bundled linux/cdrom.h, dm-ioctl.h, hdreg.h, fd.h, the FS_IOC_* /
    // FS_*_FL additions to linux/fs.h, the POSIX_FADV_* advice, and the
    // mincore binding -- everything block/file drivers pull in. Constant
    // values are arch independent; a successful compile is the check.
    let compiles = |src: &str| -> bool {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), Target::LinuxX64, opts)
            .compile()
            .is_ok()
    };
    let src = "#include <fcntl.h>\n#include <sys/mman.h>\n#include <linux/cdrom.h>\n\
               #include <linux/dm-ioctl.h>\n#include <linux/hdreg.h>\n\
               #include <linux/fd.h>\n#include <linux/fs.h>\n\
               int ck[(CDROMEJECT==0x5309 && CDS_DISC_OK==4 && HDIO_GETGEO==0x0301 \
               && POSIX_FADV_DONTNEED==4 && FS_APPEND_FL==0x20 && FS_NOCOW_FL==0x00800000 \
               && DM_IOCTL==0xfd && DM_MPATH_PROBE_PATHS_CMD==18)?1:-1];\n\
               int use_fs(int fd){ return FS_IOC_GETFLAGS != 0 ? fd : 0; }\n\
               int use_mincore(char *a){ unsigned char v; return mincore(a, 4096, &v); }\n\
               int use_geo(void){ struct hd_geometry g; return sizeof(g); }\n";
    assert!(compiles(src), "block/file uapi headers must compile");
    let wrong = "#include <linux/cdrom.h>\nint ck[(CDROMEJECT==0)?1:-1];\n";
    assert!(!compiles(wrong), "a wrong constant should fail to compile");
}

#[test]
fn utf16_utf32_string_literals() {
    // C11 `u"..."` (char16_t, 2-byte) and `U"..."` (char32_t, 4-byte)
    // string literals initialize a matching-width array; `L"..."` is
    // unaffected.
    assert_eq!(run_fixture("utf16_utf32_string_literals.c"), 0);
}

#[test]
fn const_object_array_bound() {
    // A static `const` integer object folds its value in a later constant
    // expression, so it works as an array bound (a fixed array, not a VLA)
    // and may carry an initializer.
    assert_eq!(run_fixture("const_object_array_bound.c"), 0);
}

#[test]
fn block_scope_thread_local() {
    // C11 6.7.1: a block-scope `static _Thread_local` / `static __thread`
    // object has thread storage duration -- placed in the TLS block, one per
    // thread, persisting across calls (single-threaded: accumulates).
    assert_eq!(run_fixture("block_scope_thread_local.c"), 0);
}

#[test]
fn builtin_offsetof() {
    // GCC / C11 `__builtin_offsetof(type, member)` folds to the member's byte
    // offset -- struct tag / typedef, `.field` chains, `[index]` subscripts
    // (incl. multi-dim and array-of-struct), and constant contexts.
    assert_eq!(run_fixture("builtin_offsetof.c"), 0);
}

#[test]
fn large_aggregate_copy() {
    // A large aggregate init / struct copy (> 4 KB) keeps load/store offsets
    // in the scaled-immediate range by advancing the base pointer.
    assert_eq!(run_fixture("large_aggregate_copy.c"), 0);
}

#[test]
fn conditional_constant_initializer() {
    // `cond ? A : B` with a constant condition is a constant initializer:
    // a file-scope scalar, and an aggregate element whose arms may be
    // address constants (function pointer, `&global`, null).
    assert_eq!(run_fixture("conditional_constant_initializer.c"), 0);
}

#[test]
fn conditional_pointer_null_constant_type() {
    // C99 6.5.15p6: `c ? (T*)p : (void*)0` (or `: 0`) has type `T*`, so the
    // conditional and `typeof` of it keep the struct pointer for a `->`.
    assert_eq!(run_fixture("conditional_pointer_null_constant_type.c"), 0);
}

#[test]
fn empty_array_init() {
    // A file-scope `T x[] = {}` has zero elements but keeps its element
    // type: it decays to a pointer, `sizeof` is 0, and `typeof(x)` differs
    // from `typeof(&x[0])`, so an `ARRAY_SIZE` macro reports 0 (and N for a
    // sized array).
    assert_eq!(run_fixture("empty_array_init.c"), 0);
}

#[test]
fn multidim_array_designator() {
    // A chained `[i][j] = v` designator selects one scalar of a
    // multi-dimensional array; single `[i] = { row }` designators and the
    // zero seed for untouched positions still hold.
    assert_eq!(run_fixture("multidim_array_designator.c"), 0);
}

#[test]
fn struct_member_array_range_designator() {
    // A struct's array member accepts a GNU range designator
    // `[a ... b] = v` (the top-level array path already did); mixed with
    // single `[i] = v` designators and a following scalar member.
    assert_eq!(run_fixture("struct_member_array_range_designator.c"), 0);
}

#[test]
fn runtime_struct_array_member_init() {
    // A struct's array-of-struct member brace-initialized with a
    // non-constant element value (`&g[i]`) takes the runtime store path;
    // each element must recurse into the struct initializer instead of
    // being parsed as a scalar leaf.
    assert_eq!(run_fixture("runtime_struct_array_member_init.c"), 0);
}

#[test]
fn aggregate_init_statement_expression_element() {
    // A local aggregate element that is a GNU statement expression (C99 6.6,
    // not constant) initializes at runtime; when it declares its own local,
    // the inner declaration must not drain the enclosing aggregate's
    // accumulated runtime elements, so an earlier field/element survives.
    assert_eq!(
        run_fixture("aggregate_init_statement_expression_element.c"),
        0
    );
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
fn builtin_ffs() {
    // GCC / POSIX __builtin_ffs / ffsl / ffsll: one plus the index of the
    // least-significant set bit, 0 for a zero argument (the zero case is
    // defined, unlike ctz). Lowered as `(ctz(x) + 1) * (x != 0)`.
    assert_eq!(run_fixture("builtin_ffs.c"), 0);
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
fn packed_anon_union_layout() {
    // A trailing `__attribute__((packed))` repacks the fields; the promoted
    // members of an anonymous union must keep overlapping (and a nested
    // anonymous struct keeps its in-arm offsets) instead of being laid out
    // sequentially. Mirrors the ACPI bios-linker-loader command entry.
    assert_eq!(run_fixture("packed_anon_union_layout.c"), 0);
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
fn struct_return_to_global() {
    // A by-value struct returned (or passed) to a global / static object
    // copies into the data segment, which holds writable objects: the SSA
    // interpreter's Mcpy must permit the write, matching native code.
    assert_eq!(run_fixture("struct_return_to_global.c"), 0);
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
    assert_eq!(run_fixture("switch_jump_table_dense.c"), 0);
    assert_eq!(run_fixture("switch_jump_table_sparse_kept.c"), 0);
    assert_eq!(run_fixture("switch_jump_table_phi_join.c"), 0);
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
fn layout_bottom_test_loop() {
    assert_eq!(run_fixture("layout_bottom_test_loop.c"), 45);
}

#[test]
fn layout_nested_loops() {
    assert_eq!(run_fixture("layout_nested_loops.c"), 27);
}

#[test]
fn layout_goto_block_addr() {
    assert_eq!(run_fixture("layout_goto_block_addr.c"), 16);
}

#[test]
fn unroll_const_trip_copy() {
    assert_eq!(run_fixture("unroll_const_trip_copy.c"), 0);
}

#[test]
fn unroll_trip_17_stays_rolled() {
    assert_eq!(run_fixture("unroll_trip_17_stays_rolled.c"), 0);
}

#[test]
fn unroll_volatile_stays_rolled() {
    assert_eq!(run_fixture("unroll_volatile_stays_rolled.c"), 0);
}

#[test]
fn recursion_factorial() {
    assert_eq!(run_fixture("recursion_factorial.c"), 120);
}

#[test]
fn tailrec_narrow_param() {
    // C99 6.3.1.3: a signed-char-parameter accumulator recursion whose
    // tail leg becomes a loop must re-narrow the back-edge argument.
    assert_eq!(run_fixture("tailrec_narrow_param.c"), 0);
}

#[test]
fn tailrec_void_accumulate() {
    // A void helper's same-block tail call lowers to a loop; the
    // per-level global store stays inside the loop body.
    assert_eq!(run_fixture("tailrec_void_accumulate.c"), 0);
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
    // `L`. 1.0 is exact in every precision, so the four spellings
    // of the value land identical at the bit level after conversion
    // to double. The fixture also pins the integer-vs-float
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
fn typedef_name_as_declarator() {
    // C99 6.7.2p2: a typedef name cannot combine with
    // `unsigned`/`short`/`long`/`signed`, so once an int-modifier
    // is seen the following typedef name is the declarator
    // identifier (a redeclared name), not a second type specifier.
    // Exercises struct field, block-scope object, and parameter.
    assert_eq!(run_fixture("typedef_name_as_declarator.c"), 0);
}

#[test]
fn pointer_to_array_typedef_deref_decays() {
    // C99 6.3.2.1p3: `*(A *)p` where `A` is an array typedef yields the
    // array, which decays to `p` (its address) with no load. The cast
    // to a pointer-to-array typedef previously dropped the array shape,
    // so the deref loaded the first element and passed that as the
    // pointer -- the failure a `siglongjmp(*(sigjmp_buf *)slot, 1)`
    // reaches when the jmp_buf is stashed through a `void *`.
    assert_eq!(run_fixture("pointer_to_array_typedef_deref_decays.c"), 0);
}

#[test]
fn flexible_array_member_after_tentative_decl() {
    // A struct with a flexible array member, forward-declared before it is
    // defined with FAM elements, must allocate storage for the elements
    // rather than reuse the tentative slot (which reserved only the fixed
    // part). Reusing it overflows the FAM data into the following global.
    assert_eq!(
        run_fixture("flexible_array_member_after_tentative_decl.c"),
        0
    );
}

#[test]
fn pointer_to_array_typedef_param_subscript() {
    // A `Node *nodes` parameter, where `Node` is an array typedef, is a
    // pointer to the array (not an array parameter -- 6.7.5.3p7 does not
    // apply), so `nodes[k]` strides by `sizeof(Node)` and decays to the
    // row address. The parameter path used to add a second pointer level,
    // striding by a pointer width and loading a word as the row.
    assert_eq!(run_fixture("pointer_to_array_typedef_param_subscript.c"), 0);
}

#[test]
fn pointer_to_array_typedef_member_subscript() {
    // A struct member of pointer-to-array-typedef type is a pointer to
    // the row array: `s->nodes[k]` strides by the row width and decays
    // to the element pointer. The member path used to stride by the
    // element width and load through the row.
    assert_eq!(
        run_fixture("pointer_to_array_typedef_member_subscript.c"),
        0
    );
}

#[test]
fn typedef_of_pointer_to_array_deref() {
    // C99 6.7.7p3: a typedef of pointer-to-array (`typedef arr *arrp`)
    // denotes the same type as `arr *`. The alias previously dropped the
    // array layer, so `(*p)[2]` on the alias failed with "pointer type
    // expected" while the direct spelling worked.
    let src = r#"
        typedef long arr[4];
        typedef arr *arrp;
        int direct(arr *p) { return (int)(*p)[2]; }
        int viatd(arrp p)  { return (int)(*p)[2]; }
        int main(void) { arr a; a[2] = 21; return direct(&a) + viatd(&a); }
    "#;
    assert_eq!(run_str(src), 42);
}

#[test]
fn store_through_pointer_to_pointer_to_array() {
    // `*out = &b` where `out` is `jb **` is a real dereference followed
    // by a pointer store. The first deref was previously treated as the
    // pointer-to-array row-decay no-op, the assignment rewrote the
    // parameter's own load as the lvalue, and the store was silently
    // dropped (with a spurious unused-parameter warning).
    let src = r#"
        typedef long jb[8];
        void prologue(jb **out) { static jb b; *out = &b; }
        int main(void) { jb *p = 0; prologue(&p); return p ? 42 : 1; }
    "#;
    assert_eq!(run_str(src), 42);
}

#[test]
fn multi_dim_array_typedef_object() {
    // A multi-dim array typedef binds objects with per-level strides
    // (C99 6.7.7p3); the dimension carrier previously kept only the
    // element product, so `g[i][j]` failed with "pointer type expected".
    let src = r#"
        typedef long grid[3][4];
        int main(void) {
            grid g;
            int i, j;
            for (i = 0; i < 3; i++)
                for (j = 0; j < 4; j++)
                    g[i][j] = (long)(i * 4 + j);
            if (sizeof(g) != 12 * sizeof(long)) return 1;
            return (int)(g[1][2] + g[2][3] + g[0][1] * 25);  /* 6+11+25 */
        }
    "#;
    assert_eq!(run_str(src), 42);
}

#[test]
fn ptr_to_array_typedef_roundtrip() {
    // End-to-end fixture for the pointer-to-array type layer: typedef
    // alias deref, pointer-to-pointer store, subscripts, sizeof, and a
    // multi-dim array typedef.
    assert_eq!(run_fixture("ptr_to_array_typedef.c"), 42);
}

#[test]
fn shadowed_fn_signature_restored() {
    // C99 6.2.1p4: a fn-ptr parameter or block-scope local that reuses
    // a function name hides it only for its scope; the function's
    // params / variadic flag must be intact afterward, or a later
    // variadic call misroutes its tail on stack-packing ABIs.
    assert_eq!(run_fixture("shadowed_fn_signature_restored.c"), 0);
}

#[test]
fn fnptr_param_indirection() {
    // A parameter of type "pointer to function-pointer typedef"
    // (`fn_t *p`) carries two levels of fn-pointer indirection, so
    // `*p` is a real dereference rather than the `*fp == fp` decay
    // no-op. Locks store and load through such a parameter.
    assert_eq!(run_fixture("fnptr_param_indirection.c"), 0);
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
fn variadic_fnptr_proto_erased() {
    // C99 6.5.2.2: a variadic call through a function pointer whose
    // prototype is not recoverable from a bare identifier symbol (a
    // struct field, an array element, or an inline-declared field) must
    // still split the argument list at the fixed-parameter count so the
    // host variadic ABI (macOS/AAPCS64 places the tail on the stack)
    // delivers the variadic tail where the callee's va_arg walks it.
    assert_eq!(run_fixture("variadic_fnptr_proto_erased.c"), 0);
}

#[test]
fn block_extern_shadows_local() {
    // C99 6.2.1p4 / 6.2.2p4: a block-scope `extern` that shadows an
    // enclosing local or parameter refers to the file-scope object for
    // the block and restores the enclosing binding at block exit; an
    // in-block reference resolves to the same-TU definition (including a
    // forward reference) rather than clobbering the outer object.
    assert_eq!(run_fixture("block_extern_shadows_local.c"), 0);
}

#[test]
fn win64_xmm_scratch_callee_save() {
    // The x86_64 emit pass uses xmm13/14/15 as fixed FP scratch, which
    // Win64 marks non-volatile. An FP function that returns a small
    // struct by value (the register-aggregate return path) must save and
    // restore those registers at offsets that match the prologue, or the
    // epilogue restores callee-saved GPRs from the wrong slot and leaves
    // the caller's xmm clobbered. Correctness check on every target.
    assert_eq!(run_fixture("win64_xmm_scratch_callee_save.c"), 0);
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
fn const_address_of_member_folds_through_parens() {
    // C99 6.6p9: a constant address expression `&((T*)0)->m` folds to a
    // byte offset regardless of parenthesization -- the recursive
    // designation grammar treats parens as transparent. The bare form
    // `&((T*)0)->m`, the once-wrapped `&(((T*)0)->m)`, and a doubly-wrapped
    // form must all agree, including through a nested `.member` chain.
    // (This is what makes the `offsetof` macro fold in a static
    // initializer or enumerator, but no `offsetof` shape is special-cased.)
    let src = "\
struct Inner { int p; int q; };\n\
struct Outer { int a; struct Inner in; };\n\
enum E {\n\
  A = (unsigned long) &(((struct Outer*)0)->in.q),\n\
  B = (unsigned long) &((struct Outer*)0)->in.q,\n\
  C = (unsigned long) &((((struct Outer*)0)->in.q))\n\
};\n\
int main(void){ return (int)A*100 + (int)B*10 + (int)C; }\n";
    // offsetof(Outer, in.q) == 4 (a) + 4 (in.p) == 8 for all three forms.
    assert_eq!(super::run_str(src), 888);
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
fn builtin_choose_expr_selects_on_constant() {
    // GCC `__builtin_choose_expr(c, a, b)` yields `a` when the compile-time
    // constant `c` is non-zero, else `b`. badc provides it as a
    // constant-condition conditional thunk; only the taken branch is
    // evaluated, and the result folds to that branch (usable in constant
    // contexts). Guarded by __GNUC__ so the `<_builtins.h>` thunk is in play.
    let src = "\
#define __GNUC__ 4\n\
#include <_builtins.h>\n\
_Static_assert(__builtin_choose_expr(1, 7, 999) == 7, \"true picks a\");\n\
_Static_assert(__builtin_choose_expr(0, 999, 3) == 3, \"false picks b\");\n\
int main(void){\n\
    int r = 0;\n\
    r += __builtin_choose_expr(1, 10, 0);\n\
    r += __builtin_choose_expr(0, 0, 5);\n\
    return r - 15;\n\
}\n";
    assert_eq!(super::run_str(src), 0);
}

#[test]
fn block_scope_extern_array_decays_on_subscript() {
    // C99 6.2.1p4 / 6.7.6.2: a block-scope `extern T a[N];` names an array
    // object; a subscript inside the block must decay it to a pointer, not
    // reject it as a scalar. Covers the array declared at function-body top
    // level, inside a nested block, and a multi-dimensional extern.
    let top = "\
static const int tab[4] = { 10, 20, 30, 40 };\n\
static int f(int i){ extern const int tab[4]; return tab[i]; }\n\
int main(void){ return f(2); }\n"; // tab[2] == 30
    assert_eq!(super::run_str(top), 30);
    let nested = "\
static const int nb[4] = { 1, 2, 3, 4 };\n\
static int g(int i){ { extern const int nb[4]; return nb[i] + 5; } }\n\
int main(void){ return g(1); }\n"; // nb[1] + 5 == 7
    assert_eq!(super::run_str(nested), 7);
    let multidim = "\
static const int m[2][3] = { {1,2,3}, {4,5,6} };\n\
static int h(int i,int j){ extern const int m[2][3]; return m[i][j]; }\n\
int main(void){ return h(1,2); }\n"; // m[1][2] == 6
    assert_eq!(super::run_str(multidim), 6);
}

#[test]
fn intn_c_macros_carry_the_wide_type() {
    // C99 7.18.4.1: `UINT64_C`/`INT64_C`/`INTMAX_C`/`UINTMAX_C` expand to a
    // constant of the wide (>= 64-bit) type, so a shift past bit 31 keeps its
    // high bits instead of evaluating in `int`. A bare-token expansion would
    // silently truncate `UINT64_C(1) << 35` to zero -- the defect that
    // miscompiled 64-bit flag tables.
    let src = "\
#include <stdint.h>\n\
int main(void){\n\
    int bad = 0;\n\
    if ((int)(sizeof(UINT64_C(1))) != 8) bad |= 1;\n\
    if (((UINT64_C(1) << 35) >> 35) != 1) bad |= 2;\n\
    if (((INT64_C(1)  << 40) >> 40) != 1) bad |= 4;\n\
    if (((UINTMAX_C(1) << 60) >> 60) != 1) bad |= 8;\n\
    if (UINT32_C(0xFFFFFFFF) != 0xFFFFFFFFu) bad |= 16;\n\
    return bad;\n\
}\n";
    assert_eq!(super::run_str(src), 0);
}

#[test]
fn const_init_address_of_parenthesized_symbol() {
    // Parentheses around the operand of a constant `&` are transparent: the
    // address folds through the recursive designation grammar, so `&(g)` and
    // `(fp)&(fn)` in an aggregate initializer relocate against the data /
    // code symbol exactly as `&g` / `(fp)&fn` do. Regression for a
    // token-peek that only matched `& <bare-identifier>` and misrouted
    // `&(id)` to the offsetof integer folder.
    let src = "\
static int g = 7;\n\
static int fn(int x){ return x + 1; }\n\
typedef int (*fp)(int);\n\
int main(void){\n\
    struct { int *p; fp f; } t[] = { { &(g), (fp)&(fn) } };\n\
    return *t[0].p + t[0].f(34);\n\
}\n";
    assert_eq!(super::run_str(src), 42);
}

#[test]
fn toascii_masks_to_seven_bits() {
    // XSI (SVID / X/Open) `toascii(c)` reduces a value to 7-bit ASCII
    // (`c & 0x7f`), provided as a <ctype.h> inline.
    let src = "\
#include <ctype.h>\n\
int main(void){\n\
    if (toascii(0xC1) != 0x41) return 1;\n\
    if (toascii(0x7F) != 0x7F) return 2;\n\
    if (toascii(0x80) != 0x00) return 3;\n\
    return 0;\n\
}\n";
    assert_eq!(super::run_str(src), 0);
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
fn builtin_va_list_type_and_gcc_builtin_shapes() {
    // `__builtin_va_list` is a builtin type name usable with no header
    // (`typedef __builtin_va_list va_list;`), and the __builtin_va_*
    // operations take the GCC call shapes: the va_list and the
    // rightmost fixed parameter by name, __builtin_va_arg yielding the
    // argument value. <stdarg.h> aliases the same type, so the two
    // spellings are interchangeable.
    assert_eq!(run_fixture("builtin_va_list_typedef.c"), 0);
}

#[test]
fn builtin_expect_is_predefined() {
    // `__builtin_expect` is predefined -- available in a translation
    // unit with no #include and no auto-include; its value is the
    // first operand.
    assert_eq!(run_fixture("builtin_expect_no_header.c"), 0);
}

#[test]
fn builtin_va_list_typedef_at_file_scope() {
    // Parser: `typedef __builtin_va_list va_list;` at file scope binds
    // the alias to the target's representation, including through a
    // second-level alias (the `__gnuc_va_list` indirection freestanding
    // stdarg headers use).
    let src = "
        typedef __builtin_va_list __gnuc_va_list;
        typedef __gnuc_va_list va_list;
        int main(void) {
            return sizeof(va_list) == sizeof(__gnuc_va_list)
                && sizeof(va_list) == sizeof(__builtin_va_list) ? 0 : 1;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn builtin_va_list_direct_declaration_at_block_scope() {
    // Parser: `__builtin_va_list ap;` declares an object of the
    // target's va_list representation directly at block scope.
    let src = "
        int main(void) {
            __builtin_va_list ap;
            (void)ap;
            return sizeof(ap) == sizeof(__builtin_va_list) ? 0 : 1;
        }
    ";
    assert_eq!(run_str(src), 0);
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
fn macro_paste_empty_arg_placemarker() {
    // C99 6.10.3.3: an empty macro argument is a placemarker, so
    // `sign##name` with an empty `sign` yields `name` and keeps the
    // preceding token (`return`) separate rather than gluing `returnname`.
    assert_eq!(run_fixture("macro_paste_empty_arg_placemarker.c"), 0);
}

#[test]
fn static_over_alignment() {
    // C11 6.7.5 / GCC `aligned`: static objects (file-scope and block-scope
    // static) are placed at the requested power-of-two alignment, up to a
    // page -- verified at runtime via the object address modulo alignment.
    assert_eq!(run_fixture("static_over_alignment.c"), 0);
}

#[test]
fn pointer_local_ignores_type_alignment() {
    // A type-position `aligned` attribute appertains to the pointee type, so
    // an automatic pointer object is not rejected for it (the pointer keeps
    // pointer alignment) -- `struct {...} aligned(16) *p`.
    assert_eq!(run_fixture("pointer_local_ignores_type_alignment.c"), 0);
}

#[test]
fn flexible_array_member_typeof_is_array() {
    // C99 6.7.2.1p16: a flexible array member has an incomplete array type,
    // distinct from its decayed element pointer, so
    // `__builtin_types_compatible_p(typeof(m), typeof(&m[0]))` is false --
    // the array-detection idiom must see it as an array.
    assert_eq!(run_fixture("flexible_array_member_typeof_is_array.c"), 0);
}

#[test]
fn multidim_struct_array_designator() {
    // C99 6.7.8p6: `arr[i][j] = { ... }` indexes every dimension of a
    // multi-dimensional array of structs to a single element (row-major flat
    // offset), with `[i][j].field` overrides and whole-row designators.
    assert_eq!(run_fixture("multidim_struct_array_designator.c"), 0);
}

#[test]
fn local_multidim_struct_array_designator() {
    // C99 6.7.8p6 at block scope: `arr[i][j] = { ... }` indexes every
    // dimension of a multi-dimensional array of structs to one element, for
    // automatic and `static` locals and past two dimensions -- parity with a
    // file-scope initializer.
    assert_eq!(run_fixture("local_multidim_struct_array_designator.c"), 0);
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
fn union_bitfield_layout() {
    // C99 6.7.2.1: a union with a named bitfield member sizes and aligns
    // to that member's storage unit (a union of only bitfields is not
    // zero-sized), so a bitfield store stays in bounds.
    assert_eq!(run_fixture("union_bitfield_layout.c"), 0);
}

#[test]
fn ternary_arith_conversion() {
    // C99 6.5.15p5: a conditional with arithmetic arms converts both to
    // their usual-arithmetic-conversions common type; a mixed int /
    // floating ternary must not read one arm through the other's width.
    assert_eq!(run_fixture("ternary_arith_conversion.c"), 0);
}

#[test]
fn alloca_arena_in_bounds() {
    // An 8000-byte alloca succeeds and every byte is writable (the
    // historical fixed-arena bound; kept as a size regression).
    assert_eq!(run_fixture("alloca_arena_in_bounds.c"), 0);
}

#[test]
fn init_float_to_int() {
    // C99 6.3.1.4: a floating constant initializing an integer aggregate
    // element converts (truncates), not a raw IEEE-754 bit copy.
    assert_eq!(run_fixture("init_float_to_int.c"), 0);
}

#[test]
fn global_init_midexpr_cast_narrow() {
    // C99 6.3.1.3: a narrowing cast that is a sub-operand of a file-scope
    // constant initializer narrows the operand; reloc casts still resolve.
    assert_eq!(run_fixture("global_init_midexpr_cast_narrow.c"), 0);
}

#[test]
fn init_brace_intermediate_cast() {
    // C99 6.5.4 + 6.7.8p11: a brace-enclosed initializer element applies
    // every cast in its chain -- `(long)(int)0x92492493` sign-extends
    // through `int` -- in static and automatic storage, for array
    // elements and struct members alike.
    assert_eq!(run_fixture("init_brace_intermediate_cast.c"), 0);
}

#[test]
fn dead_local_load_frame_elide() {
    // C99 6.2.4p2: a local that is never observed needs no storage. A
    // promotion-orphaned slot load with no consumers emits no code and
    // must not force a frame; a volatile access (5.1.2.3p2) keeps it.
    assert_eq!(run_fixture("dead_local_load_frame_elide.c"), 0);
}

#[test]
fn narrow_param_entry_extend() {
    // C99 6.5.2.2p4 / 6.3.1.3: a register-passed narrow parameter is
    // converted on entry; an I8/I16 conversion rewrites bits 8..31,
    // so it cannot be skipped on a bits-32..63-only liveness proof.
    assert_eq!(run_fixture("narrow_param_entry_extend.c"), 0);
}

#[test]
fn qsort_scan_extend_dedup() {
    // One sign-extension result per (value, kind): re-extensions at
    // dominated positions redirect to the dominating one.
    assert_eq!(run_fixture("qsort_scan_extend_dedup.c"), 0);
}

#[test]
fn tailcall_return_extension() {
    // int-returning tail callee under an unsigned-returning caller:
    // the widened value must zero-extend (bit 31 set).
    assert_eq!(run_fixture("tailcall_return_extension.c"), 0);
}

#[test]
fn fnptr_array_call() {
    // `(*arr[i])()` and struct-returning K&R fn-pointer array elements.
    assert_eq!(run_fixture("fnptr_array_call.c"), 0);
}

#[test]
fn call_arg_extend_drop() {
    // The caller-side re-extension of a direct-call argument drops
    // only when the callee re-derives the parameter from the low bits.
    assert_eq!(run_fixture("call_arg_extend_drop.c"), 0);
}

#[test]
fn indirect_call_narrow_scalar_args() {
    // C99 6.5.2.2p7: a non-variadic indirect call converts each
    // argument to the pointee prototype's parameter type; narrow
    // (char/short) parameters read the same values as a direct call.
    assert_eq!(run_fixture("indirect_call_narrow_scalar_args.c"), 0);
}

#[test]
fn indirect_call_ten_scalar_args() {
    // Ten integer arguments through a function pointer: args 9 and 10
    // ride the host stack overflow slots; positional weights catch a
    // slot permutation or a missed overflow store.
    assert_eq!(run_fixture("indirect_call_ten_scalar_args.c"), 0);
}

#[test]
fn indirect_call_mixed_fp_int_args() {
    // Interleaved int/FP scalars through a non-variadic function
    // pointer: the banks advance independently per the arg-type mask.
    assert_eq!(run_fixture("indirect_call_mixed_fp_int_args.c"), 0);
}

#[test]
fn float_param_stack_overflow() {
    // `float` parameters past the FP argument registers ride the host
    // stack at single precision; the argument cell carries the f32 bit
    // pattern on both the native and the interpreter paths.
    assert_eq!(run_fixture("float_param_stack_overflow.c"), 0);
}

#[test]
fn indirect_call_variadic_fp_control() {
    // A variadic callee through a function pointer keeps the host
    // variadic placement; mixed int/double varargs cover both banks
    // and the stack tail.
    assert_eq!(run_fixture("indirect_call_variadic_fp_control.c"), 0);
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
fn macro_multiline_comment_body_resolve() {
    // A `\`-continued macro whose body holds a block comment spanning a
    // physical-line break must not be truncated at the comment.
    assert_eq!(run_fixture("macro_multiline_comment_body.c"), 0);
}

#[test]
fn compound_literal_paren_init_resolve() {
    // A parenthesized compound literal `((T){...})` must be accepted as
    // an aggregate-initializer element (C99 6.5.1/6.5.2.5).
    assert_eq!(run_fixture("compound_literal_paren_init.c"), 0);
}

#[test]
fn struct_value_arithmetic_is_rejected() {
    // C99 6.5: a struct / union value is not a valid operand of an
    // arithmetic / bitwise / shift / relational / equality / logical
    // operator. Each must be a compile error rather than silently
    // operating on the operand's address. A pointer to a struct is a
    // scalar and stays valid.
    use crate::c5::Compiler;
    let cases = [
        (
            "struct P{int x,y;}; int f(struct P a,struct P b){return (int)(a+b);}",
            "+ (lhs)",
        ),
        (
            "struct P{int x,y;}; int f(int a,struct P b){return (int)(a+b);}",
            "+ (rhs)",
        ),
        (
            "struct P{int x,y;}; int f(int a,struct P b){return (int)(a*b);}",
            "*",
        ),
        (
            "struct P{int x,y;}; int f(int a,struct P b){return a<b;}",
            "<",
        ),
        (
            "struct P{int x,y;}; int f(int a,struct P b){return a==b;}",
            "==",
        ),
        (
            "struct P{int x,y;}; int f(int a,struct P b){return (int)(a&b);}",
            "&",
        ),
        (
            "struct P{int x,y;}; int f(int a,struct P b){return (int)(a<<b);}",
            "<<",
        ),
        (
            "struct P{int x,y;}; int f(int a,struct P b){return a&&b;}",
            "&&",
        ),
    ];
    for (src, label) in cases {
        let err = Compiler::new(src.to_string()).compile().expect_err(label);
        let msg = format!("{err:?}");
        assert!(
            msg.contains("invalid operands"),
            "struct-value arithmetic ({label}) expected an invalid-operands diagnostic, got {msg:?}"
        );
    }
    // Valid uses still compile: pointer arithmetic, member arithmetic.
    for ok in [
        "struct P{int x;}; struct P a[4]; int main(void){struct P*p=a; return (p+2)-a;}",
        "struct P{int x,y;}; int main(void){struct P a={2,3}; return a.x*a.y-6;}",
    ] {
        Compiler::new(ok.to_string())
            .compile()
            .expect("valid struct pointer / member arithmetic must compile");
    }

    // The GCC 128-bit integer shares the aggregate layout machinery but
    // is an integer type: every operator above is valid on it. The
    // rejection must key on the plain struct / union case alone.
    let int128_ok = [
        "int f(__int128 a, __int128 b){return (int)(a+b);}",
        "int f(__int128 a, __int128 b){return (int)(a*b);}",
        "int f(unsigned __int128 a, unsigned __int128 b){return (int)(a/b);}",
        "int f(__int128 a, int b){return (int)(a<<b);}",
        "int f(__int128 a, __int128 b){return a<b;}",
        "int f(__int128 a, __int128 b){return a==b;}",
        "int f(__int128 a, int b){return (int)(a|b);}",
        "int f(__int128 a){return a ? 1 : 0;}",
        "int f(__int128 a, __int128 b){a+=b; return (int)a;}",
        "int f(__int128 a){++a; return (int)a;}",
    ];
    for src in int128_ok {
        let src = alloc::format!("{src} int main(void){{return 0;}}");
        Compiler::new(src.clone())
            .compile()
            .unwrap_or_else(|e| panic!("128-bit integer arithmetic must compile: {src:?}: {e}"));
    }
}

#[test]
fn diagnostic_echoes_the_source_line() {
    use crate::c5::Compiler;
    // A compile error echoes the offending source line beneath the
    // `<file>:<line>: error: ...` message (plain line, no caret).
    let src = "int main(void) {\n    int x = 5;\n    x = y + 1;\n    return x;\n}\n";
    let err = Compiler::new(src.to_string())
        .compile()
        .expect_err("undeclared y is an error");
    let msg = format!("{err}");
    assert!(msg.contains("undefined variable y"), "message: {msg:?}");
    assert!(
        msg.contains("x = y + 1;"),
        "expected the source line echoed under the error, got {msg:?}"
    );

    // A warning does the same via `Program.warnings`.
    let wsrc = "int add(int a, int b);\nint main(void) {\n    return add(1);\n}\n";
    let prog = Compiler::new(wsrc.to_string())
        .compile()
        .expect("too-few-arguments is a warning, not an error");
    let warns = prog.warnings.join("\n");
    assert!(warns.contains("too few arguments"), "warnings: {warns:?}");
    assert!(
        warns.contains("return add(1);"),
        "expected the source line echoed under the warning, got {warns:?}"
    );

    // A diagnostic whose line the parser already read past echoes THAT
    // line, not the current one: an unused-parameter warning fires at the
    // closing brace but names the signature line.
    let usrc = "int cmd(int f, int n)\n{\n    return n;\n}\nint main(void) { return cmd(1, 2); }\n";
    let prog2 = Compiler::new(usrc.to_string())
        .compile()
        .expect("unused parameter is a warning");
    let w2 = prog2.warnings.join("\n");
    assert!(w2.contains("unused parameter `f`"), "warnings: {w2:?}");
    assert!(
        w2.contains("int cmd(int f, int n)"),
        "expected the signature line, not the brace, got {w2:?}"
    );

    // Giving a body to a predefined library function is an error anchored
    // to the signature line, not the body's opening brace parsed after it.
    let asrc = "#include <stdlib.h>\nint abs(int n)\n{\n    return n < 0 ? -n : n;\n}\nint main(void) { return abs(-1); }\n";
    let err3 = Compiler::new(asrc.to_string())
        .compile()
        .expect_err("a body for a predefined library function is an error");
    let m3 = format!("{err3}");
    assert!(
        m3.contains("predefined library function `abs`"),
        "message: {m3:?}"
    );
    assert!(
        m3.contains("int abs(int n)"),
        "expected the signature line echoed, not the brace, got {m3:?}"
    );
}

#[test]
fn atomic_ops_require_stdatomic_header() {
    // The C11 7.17 atomic operations are recognized only when declared
    // via `#pragma intrinsic` (which `<stdatomic.h>` does); a call with
    // no such declaration is an ordinary unresolved function reference,
    // so a name like `atomic_load` is not silently intercepted.
    use crate::c5::Compiler;
    let src = "int main(void){int x=0; return atomic_load(&x);}\n";
    let err = Compiler::new(src.to_string())
        .compile()
        .expect_err("atomic_load without <stdatomic.h> must not be recognized");
    let msg = format!("{err:?}");
    assert!(
        msg.contains("atomic_load"),
        "expected an unresolved-reference diagnostic, got {msg:?}"
    );
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
fn loop_iv_spill_priority() {
    // Loop-depth-weighted spill ordering keeps the loop's induction
    // variable and accumulator in registers; the result is unchanged.
    assert_eq!(run_fixture("loop_iv_spill_priority.c"), 40);
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

#[test]
fn bound_import_arg_narrowing() {
    // C99 6.5.2.2p4: a bound-import (libc) call argument is converted to
    // the declared parameter type, matching a user-defined callee. memcmp
    // with a count > 2^32 narrows to the declared `int`, comparing the
    // in-range prefix instead of walking past the buffers.
    assert_eq!(run_fixture("bound_import_arg_narrowing.c"), 0);
}

#[test]
fn long_double_advertised_as_fp64() {
    // c5 stores `long double` as 8-byte IEEE binary64 on every target, so
    // float.h must advertise the binary64 characteristics. The previous
    // x86_64-ELF 80-bit row let LDBL_MAX overflow to +inf and LDBL_EPSILON
    // drop below the real machine epsilon.
    let src = "#include <float.h>\n\
               int main(void){ return (sizeof(long double)==8 && LDBL_MANT_DIG==53\n\
               && LDBL_MAX==DBL_MAX && LDBL_EPSILON==DBL_EPSILON\n\
               && LDBL_MIN==DBL_MIN) ? 0 : 1; }";
    assert_eq!(super::run_str(src), 0);
}

#[cfg(target_os = "macos")]
#[test]
fn darwin_enotsup_is_distinct_from_eopnotsupp() {
    // On Darwin ENOTSUP is 45 and EOPNOTSUPP the legacy socket value 102;
    // aliasing ENOTSUP to EOPNOTSUPP made `errno == ENOTSUP` silently
    // false for a libc call that set errno to 45.
    let src = "#include <errno.h>\n\
               int main(void){ return (ENOTSUP==45 && EOPNOTSUPP==102\n\
               && ENOTSUP!=EOPNOTSUPP) ? 0 : 1; }";
    assert_eq!(super::run_str(src), 0);
}

#[test]
fn ndebug_optimize_predefine() {
    // The library harness never sets the driver's `-O`, so neither
    // NDEBUG nor __OPTIMIZE__ is predefined here; the CLI-level
    // `-O` semantics are locked by `tests/cli_fixture_smoke.rs`.
    assert_eq!(run_fixture("ndebug_optimize_predefine.c"), 100);
}

#[test]
fn constfold_post_inline_matches_interpreter() {
    // The differential companion to the mid-end constant folder: the
    // same fixture runs natively unoptimized and with -O via the
    // fixture tables, so any fold that disagrees with the
    // interpreter's evaluator surfaces as a lane divergence.
    assert_eq!(run_fixture("constfold_post_inline.c"), 0);
}

#[test]
fn rotate_inline_const_count_matches_interpreter() {
    assert_eq!(run_fixture("rotate_inline_const_count.c"), 0);
}

#[test]
fn generic_selection_subscript_arm() {
    // A `_Generic` arm containing a subscript (`&x[0]`) must not break the
    // balanced-bracket association scan.
    assert_eq!(run_fixture("generic_selection_subscript_arm.c"), 0);
}

#[test]
fn stmt_expr_local_aggregate_assign() {
    // A statement-expression block must leave the enclosing expression
    // parse's operand stack net-unchanged: an aggregate (array or
    // bitfield-struct) local initializer inside the block previously
    // left a residual entry that made the enclosing assignment pop the
    // wrong operand and drop itself.
    assert_eq!(run_fixture("stmt_expr_local_aggregate_assign.c"), 0);
}

#[test]
fn stmt_expr_zero_length_array() {
    // `T a[] = { }` keeps its array-ness (decay, subscript typing,
    // sizeof 0) when declared in a nested block or statement expression.
    assert_eq!(run_fixture("stmt_expr_zero_length_array.c"), 0);
}

#[test]
fn pp_number_macro_token() {
    // C99 6.4.8: a pp-number is one token; an identifier-shaped tail
    // (`2op`, `1.f`) is not a macro or parameter candidate.
    assert_eq!(run_fixture("pp_number_macro_token.c"), 0);
}

#[test]
fn pp_expansion_token_seam() {
    // Expansion output must not paste adjacent tokens into new ones
    // (`- -22` stays two tokens); `##` still glues.
    assert_eq!(run_fixture("pp_expansion_token_seam.c"), 0);
}

#[test]
fn array_field_designator_local() {
    // C99 6.7.8p7 designator lists continuing into the element
    // (`[N].field = v`, `[i][j].field = v`) in block-scope static and
    // automatic struct arrays.
    assert_eq!(run_fixture("array_field_designator_local.c"), 0);
}

#[test]
fn volatile_struct_assign() {
    // C99 6.5.16.1p1: struct assignment compares unqualified types;
    // qualified sources and destinations interoperate with plain ones.
    assert_eq!(run_fixture("volatile_struct_assign.c"), 0);
}

#[test]
fn builtin_object_size() {
    // GCC `__builtin_object_size`: folds for a known declared array,
    // (size_t)-1 / 0 per type class otherwise, operand unevaluated.
    assert_eq!(run_fixture("builtin_object_size.c"), 0);
}

#[test]
fn bool_bitfield_zero_extends() {
    // C99 6.2.5p2: a `_Bool` bitfield is unsigned even at width 1, so
    // a set bit reads back as 1, not the -1 a signed 1-bit field
    // yields. The wrong sign made an expression like `64 - 8 * flag`
    // overshoot when a `_Bool` bitfield feeds integer arithmetic.
    assert_eq!(run_fixture("bool_bitfield_zero_extends.c"), 0);
}

#[test]
fn return_narrows_to_type_width() {
    // C99 6.8.6.4 / 6.3.1.1: a sub-64-bit integer return is narrowed to
    // its declared type in the result register -- zero-extend when
    // unsigned, sign-extend when signed. A same-unit caller reads the
    // register directly. A `uint32_t` syndrome built from `0x24 << 26`
    // (bit 31 set) reached a 64-bit read sign-extended before the fix.
    assert_eq!(run_fixture("return_narrows_to_type_width.c"), 0);
}

#[test]
fn ipproto_case_labels() {
    // <netinet/in.h> IPPROTO_* constants are usable as case labels.
    assert_eq!(run_fixture("ipproto_case_labels.c"), 0);
}

#[test]
fn elf_header_types() {
    // <elf.h> specification-fixed type and struct layouts.
    assert_eq!(run_fixture("elf_header_types.c"), 0);
}

#[test]
fn syscall_numbers_x86_64() {
    // <sys/syscall.h> per-architecture numbers: SYS_/__NR_ pairs, with
    // arch_prctl present on x86-64 only.
    assert_eq!(run_fixture("syscall_numbers_x86_64.c"), 0);
}

#[test]
fn noreturn_dead_tail() {
    // The noreturn-call block seal must not disturb control flow
    // around an untaken guard.
    assert_eq!(run_fixture("noreturn_dead_tail.c"), 0);
}

#[test]
fn builtin_choose_expr() {
    // `__builtin_choose_expr` keeps the chosen operand's exact type
    // (no `?:` conversions) and never evaluates the other operand.
    assert_eq!(run_fixture("builtin_choose_expr.c"), 0);
}

#[test]
fn conditional_void_pointer() {
    // C99 6.5.15p6 for two pointer arms: a null pointer constant arm
    // takes the other arm's type, otherwise a `void *` arm wins. The
    // constant-expression detection idiom rests on that distinction.
    assert_eq!(run_fixture("conditional_void_pointer.c"), 0);
}

#[test]
fn empty_declaration() {
    // A stray `;` declares nothing: accepted in a struct/union member
    // list and at file scope (gcc/clang extension), without opening a
    // new field group or perturbing layout.
    assert_eq!(run_fixture("empty_declaration.c"), 0);
}

#[test]
fn builtin_constant_p() {
    // `__builtin_constant_p(x)` folds to 1 for a constant operand and 0
    // for a runtime one, in both constant-expression and runtime
    // contexts. Locks the `__builtin_constant_p`-guarded min/max macro
    // idiom so a stubbed always-0 form can't silently collapse it to
    // the fallback arm.
    assert_eq!(run_fixture("builtin_constant_p.c"), 0);
}

// GCC extended inline asm with operand lists (x86_64 register-operand
// forms). The interpreter evaluates the template semantics, so these
// round-trip on any host; the native x86_64 encoding is checked by the
// snapshot suite and the box validation.
#[test]
fn inline_asm_byte_width_keeps_upper_bits() {
    // A byte / word operation writes only the low lane of its destination
    // and leaves the upper bits of the object as they were.
    let src = "
        int main(void) {
            unsigned long long w = 0x1122334455667788ULL;
            asm(\"xorb $0x80, %0\" : \"+m\"(w));
            if (w != 0x1122334455667708ULL) return 1;
            asm(\"addw $2, %0\" : \"+m\"(w));
            if (w != 0x112233445566770AULL) return 2;
            asm(\"shrb $1, %0\" : \"+m\"(w));
            if (w != 0x1122334455667705ULL) return 3;
            return 42;
        }
    ";
    assert_eq!(run_str(src), 42);
}

#[test]
fn inline_asm_shld_double_shift() {
    // `shld count, src, dst` (AT&T) shifts `dst` left by `count`, feeding
    // in the high bits of `src`. Constraints: `+r` read-write output, `r`
    // input, `ci` (immediate-or-CL) count with a `%b` byte-size operand.
    let src = "
        unsigned long long shl_double(unsigned long long l, unsigned long long r, int c) {
            asm(\"shld %b2, %1, %0\" : \"+r\"(l) : \"r\"(r), \"ci\"(c));
            return l;
        }
        int main(void) {
            unsigned long long l = 0x0123456789ABCDEFULL, r = 0xFEDCBA9876543210ULL;
            int c = 12;
            unsigned long long got = shl_double(l, r, c);
            unsigned long long want = (l << c) | (r >> (64 - c));
            return got == want ? 42 : 1;
        }
    ";
    assert_eq!(run_str(src), 42);
}

#[test]
fn inline_asm_shrd_double_shift() {
    let src = "
        unsigned long long shr_double(unsigned long long l, unsigned long long r, int c) {
            asm(\"shrd %b2, %1, %0\" : \"+r\"(r) : \"r\"(l), \"ci\"(c));
            return r;
        }
        int main(void) {
            unsigned long long l = 0x0123456789ABCDEFULL, r = 0xFEDCBA9876543210ULL;
            int c = 20;
            unsigned long long got = shr_double(l, r, c);
            unsigned long long want = (r >> c) | (l << (64 - c));
            return got == want ? 42 : 1;
        }
    ";
    assert_eq!(run_str(src), 42);
}

#[test]
fn inline_asm_bswap_matching_constraint() {
    // `bswapl %0` with `"=r"(val)` output and `"0"(val)` matching input:
    // the input shares operand 0's register (a byte-reverse in place).
    let src = "
        unsigned bswap32(unsigned val) {
            __asm__(\"bswapl %0\" : \"=r\"(val) : \"0\"(val));
            return val;
        }
        int main(void) {
            unsigned x = 0x11223344u;
            return bswap32(x) == 0x44332211u ? 42 : 1;
        }
    ";
    assert_eq!(run_str(src), 42);
}

#[test]
fn inline_asm_bswap_size_modifier() {
    // A size-modifier register name: `bswapq` on a 64-bit operand.
    let src = "
        unsigned long long bswap64(unsigned long long val) {
            __asm__(\"bswapq %0\" : \"=r\"(val) : \"0\"(val));
            return val;
        }
        int main(void) {
            unsigned long long x = 0x0102030405060708ULL;
            return bswap64(x) == 0x0807060504030201ULL ? 42 : 1;
        }
    ";
    assert_eq!(run_str(src), 42);
}

#[test]
fn inline_asm_rdtscp_sequence_fixed_regs() {
    // `rdtscp; shl $32,%%rdx; or %%rdx,%%rax` assembles a 64-bit value in
    // rax from the timestamp halves: fixed-register output `=a`, explicit
    // `%%reg` operands, an immediate `$32`, and `%rcx`/`%rdx` clobbers.
    // The interpreter has no clock, so the read is zero; the point is
    // that the multi-instruction template compiles and runs.
    let src = "
        unsigned long long rdtscp_read(void) {
            unsigned long long tsc;
            __asm__ __volatile__(\"rdtscp; shl $32,%%rdx; or %%rdx,%%rax\"
                                 : \"=a\"(tsc) : : \"%rcx\", \"%rdx\");
            return tsc;
        }
        int main(void) {
            return rdtscp_read() == 0 ? 42 : 1;
        }
    ";
    assert_eq!(run_str(src), 42);
}

#[test]
fn inline_asm_extended_operands_fixture() {
    // Full fixture (also snapshotted): x86_64 asm forms with a portable
    // fallback. Returns 0 when every form round-trips.
    assert_eq!(run_fixture("inline_asm_extended_operands.c"), 0);
}

#[test]
fn extern_typeof_redeclaration_merges() {
    // `extern typeof(f) f;` (and the object form) after or before the
    // definition is a redeclaration, not a duplicate definition; an
    // added attribute rides along (the export-macro composition shape).
    let src = "
        int f(void) { return 40; }
        extern typeof(f) f;
        int g(void);
        extern typeof(g) g __attribute__((used));
        int g(void) { return 2; }
        int arr[3] = {1, 2, 3};
        extern typeof(arr) arr;
        extern typeof(printf) printf;
        int main(void) {
            if (sizeof(arr) != 3 * sizeof(int)) return 1;
            if (arr[2] != 3) return 2;
            return f() + g() - 42;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn typeof_array_operand_declares_array() {
    // `typeof(arr)` carries the array type into a declaration: the
    // declared object has the operand's element type and dimension,
    // matching an array typedef used as the base type.
    let src = "
        int arr[3] = {1, 2, 3};
        typedef long arr4_t[4];
        typeof(arr) file_copy;
        int main(void) {
            typeof(arr) copy;
            if (sizeof(copy) != sizeof(arr)) return 1;
            if (sizeof(file_copy) != sizeof(arr)) return 2;
            copy[0] = 5; copy[1] = 6; copy[2] = 7;
            file_copy[2] = 9;
            if (copy[2] != 7 || file_copy[2] != 9) return 3;
            typeof(arr4_t) q;
            if (sizeof(q) != 4 * sizeof(long)) return 4;
            typeof(arr4_t *) p = &q;
            if (sizeof(p) != sizeof(void *)) return 5;
            if (sizeof(typeof(arr)) != sizeof(arr)) return 6;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn file_scope_asm_and_register_variable_run() {
    // The export-macro composition at file scope: a definition, an
    // `extern typeof` redeclaration, an asm block emitting the name
    // into a custom section (a no-op for the VM), and a stack-pointer
    // register variable read from a function.
    let sp = if cfg!(target_arch = "x86_64") {
        "rsp"
    } else {
        "sp"
    };
    let src = alloc::format!(
        "
        int export_me(int v) {{ return v + 2; }}
        extern typeof(export_me) export_me __attribute__((used));
        __asm__(\".pushsection .export_tab,\\\"a\\\"\\n\"
                \".balign 8\\n\"
                \".quad export_me\\n\"
                \".asciz \\\"export_me\\\"\\n\"
                \".popsection\");
        register unsigned long stack_ptr asm(\"{sp}\");
        int main(void) {{
            if (stack_ptr == 0) return 1;
            return export_me(-2);
        }}
    "
    );
    assert_eq!(run_str(&src), 0);
}

//! End-to-end tests: load a C source from `tests/fixtures/c/`, compile, run, and
//! check the exit code. These exercise the whole pipeline.

use super::compile_str;
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
fn global_member_array_decay_pointer_init() {
    // C99 6.3.2.1p3 / 6.6: `T *p = g.member;` where the member is an array
    // decays to an address constant; union offset 0 and struct offset != 0.
    assert_eq!(run_fixture("global_member_array_decay_pointer_init.c"), 0);
}

#[test]
fn global_self_referential_init() {
    // C99 6.6p9: a file-scope object's initializer may take the object's
    // own address (directly, via a member, and cast); the object stays a
    // defined symbol when an extern redeclaration follows the definition,
    // including a struct with a flexible array member.
    assert_eq!(run_fixture("global_self_referential_init.c"), 0);
}

#[test]
fn global_mutual_reference_init() {
    // C99 6.6p9 / 6.9.2: two file-scope objects holding each other's
    // addresses; a reference recorded against the extern declaration binds
    // to the definition the same unit provides later.
    assert_eq!(run_fixture("global_mutual_reference_init.c"), 0);
}

#[test]
fn nested_block_shadow_restore() {
    // C99 6.2.1: a nested-block declaration that shadows an outer name must
    // restore the outer binding's full array / VLA shape at block exit, in
    // both shadow directions, across nesting levels, and for a `for`-init.
    assert_eq!(run_fixture("nested_block_shadow_restore.c"), 0);
}

#[test]
fn runtime_array_designator() {
    // C99 6.7.8p6 `[N] =` array designators interleaved with positional
    // entries in a runtime (non-constant) array initializer, at parity with
    // the constant-staging path.
    assert_eq!(run_fixture("runtime_array_designator.c"), 0);
}

#[test]
fn runtime_range_designator() {
    // GNU `[lo ... hi] =` range in a runtime array initializer: the value
    // is evaluated once and copied across the range (gcc semantics),
    // positional entries resume after the range end, later designators
    // override with the last entry winning, and a deferred size resolves
    // to the range end + 1.
    assert_eq!(run_fixture("runtime_range_designator.c"), 0);
}

#[test]
fn runtime_range_designator_struct() {
    // The struct-element and 2-D-row counterparts of the runtime range
    // fill: one evaluation of the braced entry, byte copies across the
    // range, declared and deferred sizes, a range inside a struct
    // member's array, and override order.
    assert_eq!(run_fixture("runtime_range_designator_struct.c"), 0);
}

#[test]
fn anon_struct_designated_init() {
    // C99 6.7.8p7: `.member` designators inside a brace on a flattened
    // anonymous-struct region, out of order, in both the constant and the
    // runtime store paths.
    assert_eq!(run_fixture("anon_struct_designated_init.c"), 0);
}

#[test]
fn anon_group_designator_chain() {
    // C99 6.7.8p7: a `.member[i]` / `.member.inner` designator chain inside
    // the brace of a flattened anonymous union/struct member, constant and
    // runtime store paths.
    assert_eq!(run_fixture("anon_group_designator_chain.c"), 0);
}

#[test]
fn local_struct_array_compound_literal_runtime() {
    // C99 6.5.2.5: a whole-element compound literal `(T){ ... }` as a local
    // struct-array element, with non-constant field values on the per-element
    // runtime store path (deferred and fixed size).
    assert_eq!(
        run_fixture("local_struct_array_compound_literal_runtime.c"),
        0
    );
}

#[test]
fn declarator_asm_label_noop_rename() {
    // A GNU asm-label (`decl asm("name")`) restating the identifier is a
    // no-op rename, accepted on both a function declarator and an object,
    // which then behave as ordinary declarations.
    let src = "
        int add(int a, int b) asm(\"add\");
        int add(int a, int b) { return a + b; }
        int counter asm(\"counter\") = 40;
        int main(void) { counter += add(1, 1); return counter; }
    ";
    assert_eq!(run_str(src), 42);
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
fn inline_asm_x64_callee_saved_operands() {
    // An inline asm whose clobber list names the caller-saved integer bank
    // (what an asm that calls out must declare) forces its `r` operands into
    // the callee-saved registers. The operand allocator must offer the whole
    // usable GP file, including rbx / r12..r15, not just the caller-saved
    // half, or it reports a spurious "out of registers"; the emitter already
    // saves and restores each operand register around the block.
    assert_eq!(run_fixture("inline_asm_x64_callee_saved_operands.c"), 0);
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
fn offsetof_multi_runtime_subscript() {
    // GCC extension: any number of runtime subscripts in an offsetof
    // designator; each adds `(size_t)index * stride`. Mixed constant and
    // runtime subscripts and member-subscript-member chains; all-constant
    // designators still fold to integer constant expressions.
    assert_eq!(run_fixture("offsetof_multi_runtime_subscript.c"), 0);
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
fn zero_length_array_sizeof() {
    // GCC `T[0]` is a complete zero-size type: `sizeof(*p)` on
    // `T (*p)[0]` (local, member, cast) and `sizeof(T[0])` fold to 0.
    // Locks the size-keyed fifo-layout dispatch: a nonzero result
    // selected a record layout that consumed payload bytes as length
    // headers.
    assert_eq!(run_fixture("zero_length_array_sizeof.c"), 0);
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
    //   C99 6.3.1.4 conversions to and from `float` / `double`:
    //   round-to-nearest-even past the significand, truncation toward
    //   zero, and the 2^53 / 2^64 / 2^127 boundaries
    assert_eq!(run_fixture("int128_fp_convert.c"), 0);
    //   `__builtin_{add,sub,mul}_overflow` in infinite precision with a
    //   128-bit operand or result, including mixed operand signedness
    //   and a destination of a different width
    assert_eq!(run_fixture("int128_overflow_builtin.c"), 0);
    //   bitfields of the type: 16-byte storage units, widths past 64
    //   bits, sign extension, the operators, and the C99 6.3.1.1p2
    //   promotion of a field narrow enough to read as `int`
    assert_eq!(run_fixture("int128_bitfield.c"), 0);
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
    // The x86-64 `rdtsc` inline-asm shape (a common host-tick counter):
    // two register-tied outputs, no inputs. The VM zeroes the counter (no
    // host clock); native x86-64 emits `rdtsc`.
    assert_eq!(run_fixture("rdtsc_host_ticks.c"), 0);
}

#[test]
fn inline_asm_fixed_reg_output_width() {
    // A fixed-register output stores back at the width of its C object:
    // a `long` operand of a 32-bit instruction takes all eight bytes, a
    // 16-bit operand takes two and leaves its neighbours alone.
    assert_eq!(run_fixture("inline_asm_fixed_reg_output_width.c"), 0);
}

#[test]
fn cpuid_partial_outputs() {
    // A `cpuid` asm with one output and the remaining implicit outputs
    // listed as clobbers takes the same generic extended-asm path as the
    // full four-output form; the VM zeroes every register cpuid defines.
    assert_eq!(run_fixture("cpuid_partial_outputs.c"), 0);
}

#[test]
fn cpuid_xgetbv_output_width() {
    // `cpuid` / `xgetbv` outputs store back at the width of the C
    // operand: a `long` output takes all eight bytes (the instruction
    // clears the register's upper half), an `unsigned` output four.
    assert_eq!(run_fixture("cpuid_xgetbv_output_width.c"), 0);
}

#[test]
fn get_cpuid_leaf_checks() {
    // <cpuid.h> __get_cpuid / __get_cpuid_count range-check the leaf against
    // __get_cpuid_max, select the extended maximum for leaves with bit 31 set,
    // and leave the outputs untouched when they reject one.
    assert_eq!(run_fixture("get_cpuid_leaf_checks.c"), 0);
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
fn typedef_aligned_attribute() {
    // A GNU `aligned(N)` type attribute on a typedef sets the aliased
    // type's alignment (raising or lowering it), honored by `__alignof__`,
    // `sizeof`, struct / union field layout, and array element alignment.
    // The fixture's `_Static_assert`s and runtime checks match gcc / clang.
    assert_eq!(run_fixture("typedef_aligned_attribute.c"), 0);
}

#[test]
fn builtin_return_address() {
    // __builtin_return_address(0) is the caller's return address; native
    // reads the saved slot at [fp+8], the VM the code position its frame
    // record holds. The fixture returns 0 only when it is non-null.
    assert_eq!(run_fixture("builtin_return_address.c"), 0);
}

#[test]
fn frame_builtins_take_a_non_negative_constant_level() {
    // GCC types the operand as the number of frames to walk up and
    // rejects a non-constant one; a negative level names no frame.
    use crate::c5::Compiler;
    for (src, want) in [
        (
            "void *f(int n){ return __builtin_return_address(n); }",
            "must be an integer constant",
        ),
        (
            "void *f(int n){ return __builtin_frame_address(n); }",
            "must be an integer constant",
        ),
        (
            "void *f(void){ return __builtin_frame_address(-1); }",
            "must not be negative",
        ),
        (
            "void *f(void){ return __builtin_return_address(-1); }",
            "must not be negative",
        ),
    ] {
        let err = Compiler::new(src.to_string())
            .compile()
            .expect_err("the level must be rejected");
        let msg = format!("{err:?}");
        assert!(
            msg.contains(want),
            "expected {want:?} for {src:?}, got {msg:?}"
        );
    }
    // Any constant expression compiles: level 0 directly, a level above
    // 0 to the chain walk.
    for ok in [
        "void *f(void){ return __builtin_return_address(0); } int main(void){return 0;}",
        "void *f(void){ return __builtin_frame_address(0); } int main(void){return 0;}",
        "void *f(void){ return __builtin_return_address(1 - 1); } int main(void){return 0;}",
        "void *f(void){ return __builtin_return_address(1); } int main(void){return 0;}",
        "void *f(void){ return __builtin_return_address(2 + 3); } int main(void){return 0;}",
        "void *f(void){ return __builtin_frame_address(1); } int main(void){return 0;}",
        "void *f(void){ return __builtin_frame_address(1 + 2); } int main(void){return 0;}",
    ] {
        Compiler::new(ok.to_string())
            .compile()
            .unwrap_or_else(|e| panic!("{ok:?} must compile: {e:?}"));
    }
}

#[test]
fn builtin_frame_address_walks_to_a_callers_frame() {
    // __builtin_frame_address(N > 0) reports the frame address level 0
    // reports N calls up. The fixture checks three levels against the
    // frames that published them; gcc answers identically at -O0 and -O2
    // on linux-x86_64 and linux-aarch64.
    assert_eq!(run_fixture("builtin_frame_address_levels.c"), 0);
}

#[test]
fn builtin_return_address_walks_to_a_callers_frame() {
    // __builtin_return_address(N > 0) reports the return address level 0
    // reports N calls up, read from the frame record the frame-pointer
    // walk reaches. The fixture checks three levels against the frames
    // that published them and against the labels around each call; gcc
    // answers identically at -O0 on linux-x86_64 and folds a level above
    // 0 to 0 on linux-aarch64.
    assert_eq!(run_fixture("builtin_return_address_levels.c"), 0);
}

#[test]
fn atomic_lock_free_widths() {
    // C11 7.17.5: the lock-free predicates report the widths the emit
    // backs. A 16-byte object reports false, matching gcc and clang
    // where no 16-byte compare-exchange is enabled.
    assert_eq!(run_fixture("atomic_lock_free_widths.c"), 0);
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
fn deferred_struct_array_string_field() {
    // Staged storage is reserved before `{` is consumed, so a leading
    // string literal's bytes and parser-added NUL stay contiguous
    // instead of aliasing element 0's slot; every end alignment.
    assert_eq!(run_fixture("deferred_struct_array_string_field.c"), 0);
}

#[test]
fn struct_array_init_from_elem_values() {
    // Initializer entries that are expressions of the element type
    // count one element each (C99 6.7.8p13); mixed and flat lists
    // keep the field-slot walk (6.7.8p20).
    assert_eq!(run_fixture("struct_array_init_from_elem_values.c"), 0);
}

#[test]
fn deferred_struct_array_row_designator() {
    // A `[N] =` designator naming a row of a deferred-size 2-D struct
    // array sets the cursor and the outer size (C99 6.7.8p7+p22), with
    // positional rows continuing after it; file- and block-scope statics.
    assert_eq!(run_fixture("deferred_struct_array_row_designator.c"), 0);
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
fn static_local_compound_literal_struct() {
    // C99 6.5.2.5: a block-scope `static` struct initialized by a compound
    // literal naming its own type -- `static T s = (T){ ... };` -- drops the
    // redundant cast, matching the file-scope allocator. Covers the anon-union
    // nested-designator shape a spinlock static initializer expands to.
    assert_eq!(run_fixture("static_local_compound_literal_struct.c"), 0);
}

#[test]
fn scalar_compound_literal_lvalue() {
    // C99 6.5.2.5p4: a compound literal is an lvalue. Taking the address of a
    // scalar literal `&(int){5}` must work, not only the struct / array forms.
    assert_eq!(run_fixture("scalar_compound_literal_lvalue.c"), 0);
}

#[test]
fn qualified_compound_literal_element_scopes() {
    // C99 6.7.7p1: a type-name is a specifier-qualifier-list, so a qualified
    // whole-element compound literal `(const T){ ... }` names the same type as
    // `(T){ ... }`. Every element position is asserted at file scope, block
    // scope with static storage, and block scope with automatic storage, so a
    // divergence between the scopes' initializer paths fails rather than
    // passing at one of them.
    assert_eq!(
        run_fixture("qualified_compound_literal_element_scopes.c"),
        0
    );
}

#[test]
fn builtin_fold_in_aggregate_element() {
    // A builtin that folds to an integer constant expression (C99 6.6p10) is
    // a constant expression in an aggregate initializer element as much as in
    // a scalar one. Asserted through the scalar, positional-element,
    // designated-element, array-element and enum entry points so a capability
    // difference between them fails rather than passing at one.
    assert_eq!(run_fixture("builtin_fold_in_aggregate_element.c"), 0);
}

#[test]
fn sizeof_array_compound_literal() {
    // C99 6.3.2.1p3 exempts a `sizeof` operand from array-to-pointer
    // conversion, so `sizeof (T[]){ ... }` is the literal's object size, not
    // the decayed pointer's. Several counts at each of four element widths:
    // a total that happens to equal the pointer size cannot discriminate.
    assert_eq!(run_fixture("sizeof_array_compound_literal.c"), 0);
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
fn cast_fn_ptr_named_param_scope() {
    // C99 6.2.1p4: parameter names in an abstract function-pointer type
    // (here inside a cast) have no scope, so binding one that matches a
    // local of the enclosing function must not corrupt the enclosing
    // scope's shadow. A later function's same-named first local was
    // wrongly rejected as a "duplicate local definition".
    assert_eq!(run_fixture("cast_fn_ptr_named_param_scope.c"), 0);
}

#[test]
fn block_scope_fn_typedef_extern_decay() {
    // C99 6.3.2.1p4 + 6.2.2p4: a block-scope `extern` through a
    // function-type typedef (or an alias of one) declares a function; a
    // value use decays to its address. The object classification loaded
    // the code bytes at the function's address instead.
    assert_eq!(run_fixture("block_scope_fn_typedef_extern_decay.c"), 0);
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
fn cacheline_aligned_member() {
    // Member alignment above 16 -- cache-line alignment (64, and 128 on
    // some configurations). Member offsets and padding, aggregate size and
    // alignment, arrays, nesting, `_Alignas(type-name)`, the `#pragma pack`
    // and `packed` interactions, and the runtime alignment of the objects
    // badc places. Every constant checked against GCC and clang on x86-64
    // and aarch64.
    assert_eq!(run_fixture("cacheline_aligned_member.c"), 0);
}

/// C99 6.2.2: inlining a stub that ignores its `ops` argument orphans the
/// table passed to it, so `.data` is packed a second time. Every surviving
/// object must still be reachable at the address its references carry --
/// a pointer initializer, an interior element, a literal, an over-aligned
/// object, and a zero-initialized global are all read back.
#[test]
fn post_inline_dead_data_repack() {
    assert_eq!(run_fixture("post_inline_dead_data_repack.c"), 0);
}

#[test]
fn overaligned_data_placement() {
    // Objects with an explicit `aligned(N)` above 16 land on their
    // boundary in the emitted image: the static data-DCE rebase keeps
    // each object's full alignment residue. Runtime address checks,
    // matched against GCC and clang on x86-64 and aarch64. The native /
    // JIT parity lists carry the same fixture (the VM does not compact).
    assert_eq!(run_fixture("overaligned_data_placement.c"), 0);
}

#[test]
fn overaligned_bss_placement() {
    // Zero-initialized objects with an explicit `aligned(N)` land on their
    // boundary when `.data` asks for less: the merged `.bss` base follows
    // the widest `.bss` alignment, not the `.data` one.
    assert_eq!(run_fixture("overaligned_bss_placement.c"), 0);
}

#[test]
fn compound_literal_alignment() {
    // C99 6.5.2.5p5: a compound literal is an unnamed object of its named
    // type, so it is placed on that type's boundary rather than on the
    // 8-byte data granularity. Runtime address checks; clang returns 0.
    assert_eq!(run_fixture("compound_literal_alignment.c"), 0);
}

#[test]
fn attributed_aggregate_align_floor() {
    // A variable-level `aligned(N)` lower than the type's alignment still
    // places at the members' attribute-free alignment, including where the
    // aggregate's own alignment is attribute-derived. Runtime address
    // checks, matched against clang; gcc keeps no floor for a lowered
    // request.
    assert_eq!(run_fixture("attributed_aggregate_align_floor.c"), 0);
}

#[test]
fn overaligned_type_placement() {
    // An object whose alignment comes from its type (an over-aligned
    // struct member raising the aggregate), with no attribute on the
    // declarator, is placed on that boundary for file-scope, block-scope
    // static, and initialised storage. Runtime address checks, matched
    // against GCC and clang on x86-64 and aarch64.
    assert_eq!(run_fixture("overaligned_type_placement.c"), 0);
}

#[test]
fn page_multiple_alignment() {
    // A page-multiple alignment (16 KiB, above the x86-64 page size) is
    // honored for struct layout and for static / global placement,
    // including the type-derived case. Layout up to the 64 KiB cap is
    // checked with `_Static_assert`; the addresses are read at run time.
    // Matched against GCC and clang on x86-64 and aarch64.
    assert_eq!(run_fixture("page_multiple_alignment.c"), 0);
}

#[test]
fn section_attr_aligned_placement() {
    // An object with both `section("name")` and an alignment source
    // (explicit `aligned(N)`, aligned typedef, or the type's natural
    // alignment) lands on its boundary at runtime. Runtime address
    // checks, matched against GCC and clang on x86-64 and aarch64.
    assert_eq!(run_fixture("section_attr_aligned_placement.c"), 0);
}

#[test]
fn section_attr_bss_family_zero_fill() {
    // A zero-initialized object in a `.bss`-family named section is
    // zero-fill storage; alignment requests merge to the strictest
    // across redeclarations (the post-definition `extern typeof(obj)
    // obj;` shape included). Runtime address and zero checks, matched
    // against GCC on x86-64 and aarch64.
    assert_eq!(run_fixture("section_attr_bss_family_zero_fill.c"), 0);
}

#[test]
fn section_attr_flexible_array_tail() {
    // C99 6.7.2.1p16: a flexible array member is out of `sizeof`, but a
    // definition initializing it occupies those bytes, so the next
    // object in the same named section starts past them. Read back
    // through a table in that section, at file scope and for a
    // block-scope static. Matched against GCC and clang.
    assert_eq!(run_fixture("section_attr_flexible_array_tail.c"), 0);
}

#[test]
fn max_alignment_placement() {
    // The widest static alignment badc honors (64 KiB) lands on its
    // boundary for bare, initialised, and block-scope-static storage. Off
    // the Mach-O list: macOS slides a PIE by whole pages, so a wider
    // boundary is not guaranteed at run time (clang rejects it likewise).
    assert_eq!(run_fixture("max_alignment_placement.c"), 0);
}

#[test]
fn overaligned_automatic() {
    // An automatic object whose alignment exceeds the 8-byte frame slot (C11
    // 6.7.5) lands on its boundary via prologue stack realignment. The VM run
    // agrees with the native / JIT runs the fixture lists exercise.
    assert_eq!(run_fixture("overaligned_automatic.c"), 0);
}

#[test]
fn overaligned_automatic_boundaries() {
    // Every boundary an automatic object may request: 16 (the narrowest the
    // frame slots cannot place), the intermediate ones, a page, and an object
    // larger than a page, whose region reservation descends in probed steps.
    assert_eq!(run_fixture("overaligned_automatic_boundaries.c"), 0);
}

#[test]
fn overaligned_automatic_type_derived_16() {
    // An automatic object whose type alignment is exactly 16 -- `__int128`,
    // an aligned(16) aggregate, a member-derived 16 -- lands on 16 at a
    // static frame offset, at both frame parities and across call depths.
    assert_eq!(run_fixture("overaligned_automatic16.c"), 0);
}

#[test]
fn overaligned_automatic_beside_vla() {
    // A 16-aligned automatic coexists with a VLA (the region needs no sp
    // move), and a VLA of a 16-aligned element type lands on 16.
    assert_eq!(run_fixture("overaligned_vla_int128.c"), 0);
}

#[test]
fn packed_enum() {
    // `enum __attribute__((packed))` uses the smallest integer type holding
    // its values, changing the layout of an embedding struct (a real-world
    // status-field shape). Sizes, interleaved-field offsets, and sign-extension.
    assert_eq!(run_fixture("packed_enum.c"), 0);
}

#[test]
fn builtin_bitcount_const() {
    // `__builtin_clz` / `ctz` / `popcount` (and the `ll` forms) and
    // `__builtin_constant_p` fold to integer constant expressions when their
    // argument is constant, so an `ilog2`-style file-scope array bound is not
    // taken for a VLA. Values match GCC and clang; also checked at run time.
    assert_eq!(run_fixture("builtin_bitcount_const.c"), 0);
}

#[test]
fn builtin_bitcount_zero_const_fold() {
    // clz / ctz at zero are undefined per the standard; badc folds them to the
    // bit width, matching GCC and the walker's run-time lowering (clang instead
    // refuses to fold the zero case). Locking the value keeps the constant path
    // and the run-time path in agreement.
    assert_eq!(
        run_str(
            "int a[__builtin_clz(0) + 1];\n\
             int b[__builtin_ctz(0) + 1];\n\
             int c[__builtin_clzll(0) - 63];\n\
             int main(void) {\n\
                 return (sizeof(a)/sizeof(int) == 33)\n\
                     && (sizeof(b)/sizeof(int) == 33)\n\
                     && (sizeof(c)/sizeof(int) == 1) ? 0 : 1;\n\
             }\n"
        ),
        0
    );
}

#[test]
fn const_cond_dead_arm_not_vla() {
    // C99 6.6p3: in a constant expression the operand not selected by a
    // constant condition is not evaluated and need not be a constant
    // expression, so an array bound of the kernel `ilog2` shape --
    // `__builtin_constant_p(n) ? const : nonconst` and the `||` / `&&`
    // short-circuit forms -- is a constant, not a C99 6.7.6.2 VLA. Sizes
    // match gcc and clang; the fixture also links with the unselected-arm
    // callee undefined, proving the dead arm is never referenced.
    assert_eq!(run_fixture("const_cond_array_bound.c"), 0);
}

#[test]
fn const_cond_live_arm_still_a_vla() {
    // The short-circuit above must not over-accept: when the selected arm
    // is non-constant the bound is still a C99 6.7.6.2 VLA, rejected at
    // file scope, and an undeclared identifier in an unselected arm is a
    // name-lookup violation regardless of evaluation (6.5.1). Matches gcc
    // and clang.
    use crate::c5::Compiler;
    for src in [
        "int nc(void); int a[__builtin_constant_p(32) ? nc() : 5];", // selected arm non-constant
        "int nc(void); int a[0 ? 5 : nc()];",                        // const-false selects nc()
        "int nc(void); int a[0 || nc()];",                           // || RHS is live
        "int nc(void); int a[1 && nc()];",                           // && RHS is live
        "int a[1 ? 5 : undeclared_operand];",                        // unselected arm undeclared
        "int nc(void); int a[nc()];",                                // plain file-scope VLA
    ] {
        let err = Compiler::new(src.to_string())
            .compile()
            .expect_err("a live non-constant array bound must be rejected");
        let msg = format!("{err:?}");
        assert!(
            msg.contains("variable-length array") || msg.contains("constant integer expected"),
            "expected a VLA / non-constant diagnostic for {src:?}, got {msg:?}"
        );
    }
    // The selected-arm forms still compile when that arm is constant.
    for ok in [
        "int nc(void); int a[__builtin_constant_p(32) ? 5 : nc()]; int main(void){return 0;}",
        "int nc(void); int a[(1 || nc()) ? 5 : 3]; int main(void){return 0;}",
        "int nc(void); int a[1 ? 2 ? 3 : nc() : nc()]; int main(void){return 0;}",
    ] {
        Compiler::new(ok.to_string())
            .compile()
            .expect("a constant selected arm must compile");
    }
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
fn stmt_expr_goto_label_value() {
    // A labeled tail `({ ... goto out; ... out: v; })` supplies the
    // construct's value and type on every path into the label -- the
    // find-next-bit macro shape.
    assert_eq!(run_fixture("stmt_expr_goto_label_value.c"), 0);
}

#[test]
fn local_label_shadowing_branches_to_the_innermost_declaration() {
    // An inner `__label__ l` shadows the enclosing one, and the outer
    // binding is back in scope at the inner block's `}`. Each `goto`
    // skips the addend guarding the label it must not reach, so a
    // mis-bound branch changes the result.
    let src = "
        int main(void) {
            __label__ l;
            int acc = 0;
            { __label__ l; if (acc == 0) goto l; acc += 100; l: acc += 2; }
            if (acc == 2) goto l;
            acc += 1000;
            l: acc += 4;
            return acc;
        }
    ";
    assert_eq!(run_str(src), 6);
}

#[test]
fn local_labels_of_two_sibling_blocks_stay_separate() {
    // Each block's `l` is its own label, so neither `goto` can reach
    // the other block's.
    let src = "
        int main(void) {
            int acc = 0;
            { __label__ l; if (acc == 0) goto l; acc += 10; l: acc += 1; }
            { __label__ l; if (acc == 1) goto l; acc += 20; l: acc += 2; }
            return acc;
        }
    ";
    assert_eq!(run_str(src), 3);
}

#[test]
fn stmt_expr_pointer_arith_arrow() {
    // A statement expression ending in pointer arithmetic keeps the pointer
    // result type (C99 6.5.6p8), so `({ ...; p - 1; })->field` resolves the
    // single-level struct pointer -- the `task_pt_regs` macro shape.
    assert_eq!(run_fixture("stmt_expr_pointer_arith_arrow.c"), 0);
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
fn builtin_types_compatible_ptr_array() {
    // C99 6.7.5.2p4/p6: `T (*)[]` names a pointer to an incomplete array;
    // `typeof` of its dereference is that array type, whose unspecified
    // bound is compatible with any bound. Pointer-to-array pairs compare
    // through the pointee (6.7.5.1p2), zero-length and multi-dimensional
    // bounds stay exact, and `_Generic` selects through the same rule.
    // Matches gcc and clang.
    assert_eq!(run_fixture("builtin_types_compatible_ptr_array.c"), 0);
}

#[test]
fn gnu_capability_macros_match_their_features() {
    use crate::{CompileOptions, Compiler, Target, Vm};
    // Every capability macro the `--gnu` predefine set claims, checked
    // against the behaviour it promises: the atomic lock-free properties
    // and test-and-set true value, the `__sync_*` widths, the byte-swap
    // builtins the version claim covers, and the UTF literal encodings.
    let src = super::load_fixture("gnu_capability_macros.c");
    let opts = CompileOptions::default().with_gnu(true);
    let program = Compiler::with_options(src, Target::host(), opts)
        .compile()
        .expect("fixture must compile under --gnu");
    assert_eq!(Vm::new(program).with_pointer_tracking().run().unwrap(), 0);
}

#[test]
fn builtin_types_compatible_typedef() {
    // C99 6.7.7p3: an array typedef in a `__builtin_types_compatible_p`
    // type-name position is that array type, `A *` over it names a
    // pointer to the array, and both compose through chained aliases,
    // qualifiers, deferred / zero-length / multi-dimensional bounds and
    // aggregate elements. Matches gcc.
    assert_eq!(run_fixture("builtin_types_compatible_typedef.c"), 0);
}

#[test]
fn builtin_types_compatible_fnptr() {
    // C99 6.7.5.3p15: function and function-pointer type names as
    // `__builtin_types_compatible_p` arguments, including a typedef against
    // the address of a matching function, differing return types and
    // parameter lists, an unspecified parameter list against a prototype,
    // and pointer-to-function versus function type. Matches gcc and clang.
    assert_eq!(run_fixture("builtin_types_compatible_fnptr.c"), 0);
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
fn typeof_addr_of_array() {
    // C99 6.5.3.2p3: `&arr` is a pointer-to-array, so `sizeof(&arr)` is a
    // pointer's width and `typeof(&arr)` / `typeof(*(&arr))` round-trip. Drives
    // the per-CPU `SHIFT_PERCPU_PTR` shape `(typeof(*(ptr)) *)(addr + off)`.
    assert_eq!(run_fixture("typeof_addr_of_array.c"), 0);
}

#[test]
fn typeof_expression() {
    // `typeof(expr)` over a full expression: binary, shift, conditional
    // (the common MIN/MAX `typeof(1 ? (a) : (b))` shape), and comma operators.
    assert_eq!(run_fixture("typeof_expression.c"), 0);
}

#[test]
fn typeof_conditional_call_decay() {
    // C99 6.3.2.1p3 / 6.5.2.2 / 6.5.15: a function call and a conditional
    // yield a fresh rvalue, so an array / string operand does not leak its
    // shape into an enclosing `typeof` / `sizeof`. Drives `typeof(f("s"))`
    // (container-of macro shape), `MAX(x, strlen("s"))`, and a conditional
    // over string / array arms.
    assert_eq!(run_fixture("typeof_conditional_call_decay.c"), 0);
}

#[test]
fn typeof_abstract_array_type() {
    // `__typeof__(type-name)` accepts an abstract array type -- `T [N]`,
    // `T []`, `T [N][M]` (C99 6.7.6) -- and yields the array type: sizeof /
    // _Alignof report the array's size and alignment, a declarator through
    // the specifier is an array, and an omitted bound is an incomplete array
    // type (compatible with any bound, distinct from a pointer). Sizes match
    // GCC and clang; also checked at run time.
    assert_eq!(run_fixture("typeof_abstract_array_type.c"), 0);
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
fn member_name_space_keeps_object_shape() {
    // C99 6.2.3: a member name shares nothing with the ordinary identifier
    // of the same spelling, so declaring the member must leave the object's
    // recorded array dimensions intact.
    assert_eq!(run_fixture("member_name_space_keeps_object_shape.c"), 0);
}

#[test]
fn array_alias_param_outer_bracket() {
    // C99 6.7.7p3 + 6.7.5.3p7: `rows_t rows[]` over `typedef T rows_t[1]`
    // is pointer-to-row; one subscript strides a whole row and decays to
    // the element pointer (the kernel's cpumask_var_t parameter shape).
    assert_eq!(run_fixture("array_alias_param_outer_bracket.c"), 0);
}

#[test]
fn string_literal_const_index_fold() {
    // C99 6.4.5p6: literal storage is immutable, so a constant-index
    // read may fold to the initializer's byte; the folded value must
    // equal the runtime load at every position, including the
    // terminator and concatenated parts.
    assert_eq!(run_fixture("string_literal_const_index_fold.c"), 0);
}

#[test]
fn const_array_copy_member_fold() {
    // A whole-struct copy of a const static array element reads the
    // initializer bytes; copies from a mutable array, a written-through
    // copy, and a variable index read what is actually stored.
    assert_eq!(run_fixture("const_array_copy_member_fold.c"), 0);
}

#[test]
fn attr_arg_keeps_declared_type() {
    // An attribute argument (`aligned(sizeof(T))`, `_Alignas(sizeof
    // expr)`, ...) parses with the expression and type-name machinery;
    // it must not reset the declared-type carriers of the declarator it
    // annotates (`typeof("")` array-ness, an array or function-pointer
    // typedef base).
    assert_eq!(run_fixture("attr_arg_keeps_declared_type.c"), 0);
}

#[test]
fn case_label_const_object() {
    // GCC (GNU mode, at -O) folds a const-qualified scalar arithmetic
    // object with a constant initializer in case labels, static_assert,
    // designator indices, and static initializers -- and never in type
    // dimensions, so `int a[n]` stays a VLA.
    assert_eq!(run_fixture("case_label_const_object.c"), 0);
}

#[test]
fn init_subdesignator_multi_dim() {
    // C99 6.7.8p7: chained array designators walk one rank per `[i]`,
    // mixed with `.member` steps, for static, constant-local, and
    // runtime-valued targets alike.
    assert_eq!(run_fixture("init_subdesignator_multi_dim.c"), 0);
}

#[test]
fn fn_ptr_typedef_param_no_leak() {
    // An unnamed fn-pointer-typedef parameter must not leak its
    // prototype into the next struct definition's first field record
    // (which broke typeof-based container_of static asserts).
    assert_eq!(run_fixture("fn_ptr_typedef_param_no_leak.c"), 0);
}

#[test]
fn init_paren_cond_operator_chain() {
    // A parenthesized constant conditional in an initializer element
    // continues through any trailing binary operator or another `?:`
    // (`(c ? a : b) | x << 8`) instead of leaving tokens to the brace
    // list.
    assert_eq!(run_fixture("init_paren_cond_operator_chain.c"), 0);
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
    // A `&&label` element in an array initializer indexed by a computed
    // goto, in automatic and static storage.
    assert_eq!(run_fixture("label_addr_array_init.c"), 0);
}

#[test]
fn zero_local_aggregate_no_template() {
    // A zero-initialized local aggregate takes stores; a non-zero one, one
    // past the inline fill bound, and one whose zeros are a relocation's
    // placeholder keep the copy.
    assert_eq!(run_fixture("zero_local_aggregate_no_template.c"), 0);
}

#[test]
fn label_addr_table_relocation() {
    // A static `&&label` table is filled by relocations, not by stores at
    // the declaration point: plain, section-attributed, and range-
    // designated spellings all dispatch correctly, including across
    // calls and when the declaration's block is entered indirectly.
    assert_eq!(run_fixture("label_addr_table_relocation.c"), 0);
}

#[test]
fn label_address_arithmetic_is_rejected() {
    // A label address is a link-time constant but has no integer value:
    // only `goto *` gives it meaning. Arithmetic on one has to be a
    // diagnostic, not a silent fold to its zero displacement.
    let e = crate::Compiler::new(alloc::string::String::from(
        "int f(void){ static const void *const t[1] = {&&L + 1};\n\
         goto *t[0]; L: return 1; }",
    ))
    .compile()
    .unwrap_err();
    assert!(
        alloc::format!("{e}").contains("label address is not an operand"),
        "unexpected diagnostic: {e}"
    );
}

#[test]
fn static_init_once_guard() {
    // C99 6.2.4p3: a static-local runs its initializer once; later
    // calls must not clobber user writes to the table.
    assert_eq!(run_fixture("static_init_once_guard.c"), 0);
}

#[test]
fn computed_goto_static_table() {
    // A static `&&label` dispatch table across repeated calls: every
    // entry must still name its label on re-entry.
    assert_eq!(run_fixture("computed_goto_static_table.c"), 0);
}

#[test]
fn computed_goto_const_static_table() {
    // The same table in each `const` spelling. Every element is a
    // link-time constant, so the storage is read-only data whose
    // entries come from relocations.
    assert_eq!(run_fixture("computed_goto_const_static_table.c"), 0);
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
fn static_init_logical_and() {
    // C99 6.6 admits `&&` / `||` in an integer constant expression, so a
    // static aggregate initializer using them keeps its compile-time image;
    // the prefix `&&label` in the same shape still fills at runtime.
    assert_eq!(run_fixture("static_init_logical_and.c"), 42);
}

#[test]
fn va_opt_initializer() {
    // C23 6.10.5.2: __VA_OPT__ emits its content only for a non-empty
    // variadic tail, here the comma separating a terminated pointer list.
    assert_eq!(run_fixture("va_opt_initializer.c"), 42);
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
fn redecl_composite_keeps_prototype() {
    // C99 6.2.7p4: a redeclaration supplying no parameter information of
    // its own keeps the list a prior declaration or definition set, so
    // by-value aggregate arguments stay in address form.
    assert_eq!(run_fixture("redecl_composite_keeps_prototype.c"), 0);
}

#[test]
fn redecl_composite_arity_warning() {
    // The same composite keeps call-site argument checking alive.
    assert_eq!(run_fixture("redecl_composite_arity_warning.c"), 0);
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
fn flex_2d_member_index() {
    // A multi-dimensional flexible array member (`T v[][M]`) scales the
    // outer subscript by the inner row size; rows decay and keep their
    // array type under sizeof.
    assert_eq!(run_fixture("flex_2d_member_index.c"), 0);
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
fn flex_array_member_multidim_static_init() {
    // A multi-dimensional flexible array member (`T v[][M]`) initialized
    // at file scope: each element of the flexible outer dimension is a
    // sub-array of the inner dimensions, so a nested brace list fills it
    // and the object's tail is sized to the scalar-leaf count. Read back
    // through a flat pointer so the check does not depend on multi-dim
    // subscripting of the member.
    let src = "
        struct db { unsigned mask; int map[][4]; };
        static const struct db d = {
            .mask = 7,
            .map = { { 1, 2, 3, 4 }, { 5, 6, 7, 8 } },
        };
        int main(void) {
            const int *p = (const int *)d.map;
            if (d.mask != 7) return 1;
            for (int i = 0; i < 8; i++)
                if (p[i] != i + 1) return 10 + i;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn local_struct_array_compound_literal_elements() {
    // C99 6.5.2.5: a local array-of-struct may list its elements as
    // compound literals `(T){ ... }` whose type names the element's own
    // struct. The redundant cast is stripped so the brace list fills the
    // element in place. A `(U){ ... }` of a different type is instead the
    // first field's value under brace elision (6.7.8p20), so the two must
    // not be confused.
    let src = "
        struct pe { const char *name; int v; };
        struct inner { int a, b; };
        struct outer { struct inner in; int x; };
        int main(void) {
            struct pe p[] = {
                (struct pe){ \"x\", 11 },
                (struct pe){ \"y\", 22 },
                {},
            };
            if (p[0].v != 11 || p[1].v != 22 || p[2].v != 0) return 1;
            if (p[0].name[0] != 'x' || p[1].name[0] != 'y') return 2;
            /* Brace-elided element whose first field is a compound literal
               of a different type: fills `in` then `x`, not the whole
               element. */
            struct outer o[] = { (struct inner){ 1, 2 }, 5 };
            if (o[0].in.a != 1 || o[0].in.b != 2 || o[0].x != 5) return 3;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn alignof_unparenthesized_expression_operand() {
    // GCC's `__alignof__` (which shares the token with `_Alignof`) accepts
    // an unparenthesized expression operand, whose alignment is that of its
    // type; it binds tighter than a following binary operator, like
    // `sizeof`. The parenthesized type-name and expression forms still work.
    let src = "
        struct big { long long a; };
        int main(void) {
            int i; long long ll; double d; struct big b; char c;
            if (__alignof__ i != 4) return 1;
            if (__alignof__ ll != 8) return 2;
            if (__alignof__ d != 8) return 3;
            if (__alignof__ c != 1) return 4;
            if (__alignof__ b != 8) return 5;
            if (__alignof__ i + 1 != 5) return 6;
            if (_Alignof(int) != 4 || __alignof__(double) != 8) return 7;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn positional_after_designated_in_anonymous_union_struct() {
    // C99 6.7.8p17: after a designator into a member of an anonymous
    // struct that is an anonymous union's alternative, a positional
    // initializer continues at the next member of that struct, not past
    // the whole union. `.name` then `0` must fill `size`, and `.align`
    // then `0` must fill `is_signed`, not overflow the object.
    let src = "
        struct tef {
            const char *type;
            union {
                struct {
                    const char *name; const int size; const int align;
                    const unsigned int is_signed : 1; unsigned int needs_test : 1;
                    const int filter_type; const int len;
                };
                int (*define_fields)(void *);
            };
        };
        static struct tef a = { .type = \"int\", .name = \"x\", .size = 4, 5 };
        static struct tef b = { .type = \"int\", .name = \"y\", .size = 4, .align = 8, 0, .filter_type = 3 };
        int main(void) {
            if (a.size != 4 || a.align != 5) return 1;
            if (b.size != 4 || b.align != 8 || b.is_signed != 0 || b.filter_type != 3) return 2;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn address_of_multidim_array_is_pointer_to_array() {
    // C99 6.5.3.2p3: `&arr` on a multi-dimensional array has type pointer
    // to the whole array `T[D0][D1]...`, so `(*p)[i][j][k]` and
    // `typeof(&arr)` see the multi-dim shape rather than the decayed
    // element pointer. Covers a direct deref, a `typeof(&arr)` variable,
    // and a statement-expression yielding the pointer, read and written.
    let src = "
        typedef unsigned long long u64;
        static u64 hw[4][6][8];
        int main(void) {
            u64 c = 0;
            for (int i = 0; i < 4; i++)
                for (int j = 0; j < 6; j++)
                    for (int k = 0; k < 8; k++) hw[i][j][k] = c++;
            if ((*(&hw))[1][2][3] != (u64)(1 * 48 + 2 * 8 + 3)) return 1;
            typeof(&hw) p = &hw;
            if ((*p)[3][5][7] != (u64)(3 * 48 + 5 * 8 + 7)) return 2;
            (*({ typeof(&hw) fp = &hw; fp; }))[0][0][0] = 999;
            if (hw[0][0][0] != 999) return 3;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn parameter_array_multidim_subscript() {
    // C99 6.7.5.3p7: a parameter declared `T name[][M...]` is adjusted to
    // a pointer to `T[M...]`. Subscripting `name[i][j]...` must stride by
    // the inner dimensions at each level and decay to the element at the
    // innermost, for both a 2-D and a 3-D parameter.
    let src = "
        unsigned char g(unsigned char otp[][4]) { return otp[1][2]; }
        int h(int a[][2][4]) { return a[1][0][2]; }
        int main(void) {
            unsigned char m[3][4];
            for (int i = 0; i < 3; i++)
                for (int j = 0; j < 4; j++) m[i][j] = i * 10 + j;
            if (g(m) != 12) return 1;
            int n[3][2][4];
            int c = 0;
            for (int i = 0; i < 3; i++)
                for (int j = 0; j < 2; j++)
                    for (int k = 0; k < 4; k++) n[i][j][k] = c++;
            if (h(n) != 1 * 8 + 0 * 4 + 2) return 2;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn address_of_parenthesized_compound_literal_static_init() {
    // C99 6.5.2.5 / 6.6: a file-scope object may be initialized with the
    // address of a compound literal, which has static storage duration.
    // The literal may sit behind grouping parens (`&((T){...})`); the
    // address constant is the same. Exercised through a pointer field and
    // a scalar pointer, with an offsetof inside the literal.
    let src = "
        struct fields { int x; int y; };
        struct sa { int a; unsigned long off; };
        struct wrap { void *var; };
        static struct wrap w = {
            .var = &((struct sa){ -1, __builtin_offsetof(struct fields, y) }),
        };
        static void *s = &((struct sa){ 7, 3 });
        int main(void) {
            struct sa *p = w.var;
            if (p->a != -1 || p->off != 4) return 1;
            struct sa *q = s;
            if (q->a != 7 || q->off != 3) return 2;
            return 0;
        }
    ";
    assert_eq!(run_str(src), 0);
}

#[test]
fn array_compound_literal_address_const() {
    // C99 6.5.2.5 / 6.6: `&(T[]){ ... }[i].member` as an address constant in a
    // static initializer -- an anonymous static array whose designated member
    // address is stored (a sysfs attribute-table shape).
    assert_eq!(run_fixture("array_compound_literal_address_const.c"), 0);
}

#[test]
fn parenthesized_address_constant() {
    // C99 6.5.1p5: parentheses around the operand of `&` are transparent, so
    // `&(obj)` is the address constant `&obj` (6.6p9). Covers the operand
    // forms at file scope and at block-scope `static`, which share the
    // constant-expression path.
    assert_eq!(run_fixture("parenthesized_address_constant.c"), 0);
}

#[test]
fn const_init_literal_suffix() {
    // C99 6.4.4.1: a constant's suffix and base give it its type. A static
    // initializer is parsed speculatively, so a rewind has to restore the
    // attributes that type the current token along with the token itself.
    assert_eq!(run_fixture("const_init_literal_suffix.c"), 0);
}

#[test]
fn attribute_section_placement() {
    // `section("name")` placements: the interpreter ignores them; the
    // native object writer places the bytes (locked by the object-level
    // tests). The program's behavior is identical either way.
    assert_eq!(run_fixture("attribute_section_placement.c"), 0);
}

#[test]
fn weak_extern_data_address() {
    // A weak symbol with no definition addresses as null; one with a
    // definition addresses the object.
    assert_eq!(run_fixture("weak_extern_data_address.c"), 0);
}

#[test]
fn addr_null_compare_defined() {
    // The address of a non-weak symbol defined in the unit never
    // compares equal to a null pointer constant.
    assert_eq!(run_fixture("addr_null_compare_defined.c"), 0);
}

#[test]
fn enum_unsigned_compatible() {
    // An all-non-negative enum takes the unsigned compatible type;
    // enumerator constants that fit keep `int`.
    assert_eq!(run_fixture("enum_unsigned_compatible.c"), 0);
}

#[test]
fn types_compatible_fn_ptr_cast() {
    // typeof of a function-pointer cast carries the cast's prototype
    // into __builtin_types_compatible_p.
    assert_eq!(run_fixture("types_compatible_fn_ptr_cast.c"), 0);
}

#[test]
fn types_compatible_fn_ptr_object() {
    // typeof of a function-pointer object -- a variable, a member, an
    // element -- carries the object's prototype into
    // __builtin_types_compatible_p.
    assert_eq!(run_fixture("types_compatible_fn_ptr_object.c"), 0);
}

#[test]
fn zero_length_array_decay() {
    // A zero-length array reads as its address, not as a load of the
    // storage it does not have.
    assert_eq!(run_fixture("zero_length_array_decay.c"), 0);
}

#[test]
fn speculative_init_parse_data_rewind() {
    // A parenthesized initializer element parsed speculatively as a
    // conditional emits data and rewinds it; the padding and boundary
    // records must rewind with it.
    assert_eq!(run_fixture("speculative_init_parse_data_rewind.c"), 0);
}

#[test]
fn attribute_weak_alias() {
    // `weak` / `alias` / `used`: a non-weak alias resolves to its
    // target at parse time; a weak alias stays symbolic and the
    // interpreter binds it at execution, its link step.
    assert_eq!(run_fixture("attribute_weak_alias.c"), 0);
}

#[test]
fn weak_alias_call_not_inlined() {
    // Calls, a static function-pointer initializer, and an address
    // comparison through a weak alias; execution binds them to the
    // target once no strong override can appear.
    assert_eq!(run_fixture("weak_alias_call_not_inlined.c"), 42);
}

#[test]
fn asm_label_rename() {
    // A GNU asm-label renames the emitted symbol without changing what the
    // identifier denotes, so the program's behaviour is the same as it
    // would be without the labels.
    assert_eq!(run_fixture("asm_label_rename.c"), 0);
}

#[test]
fn alias_extern_redeclaration() {
    // A no-initializer redeclaration of an alias-defined object is a
    // pure redeclaration; it must not re-allocate storage over the
    // alias binding.
    assert_eq!(run_fixture("alias_extern_redeclaration.c"), 0);
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
fn type_name_forms() {
    // C99 6.7.6 type names with abstract declarators in a cast, `sizeof`,
    // `_Alignof`, a `_Generic` association and `va_arg`.
    assert_eq!(run_fixture("type_name_forms.c"), 0);
}

#[test]
fn binary_operator_order() {
    // C99 6.5.5-6.5.14 precedence and associativity, and the sequence
    // points of `&&` / `||` (6.5.13p4, 6.5.14p4).
    assert_eq!(run_fixture("binary_operator_order.c"), 0);
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
fn parenthesized_bitfield_chained_assign() {
    // C99 6.5.1p5: a parenthesized lvalue is an lvalue. A macro wrapping a
    // cast-pointer bitfield member (`(((T*)&f)->field)`) and chaining the
    // assignment (`SPACE(f) = HAS_LINK(f) = 1`) must store to both fields.
    // has_link is bit 4 (16) and space is bits 8-11 (1 << 8 = 256): 272.
    let src = "struct tf { unsigned int link_space:4, has_link:1, mfc_fn:3, space:4; };\n\
               int main(void){\n\
               unsigned int flags = 0;\n\
               (((struct tf *)(&(flags)))->space) = (((struct tf *)(&(flags)))->has_link) = 1;\n\
               struct tf *p = (struct tf *)&flags;\n\
               if (flags != 272u) return 1;\n\
               if (p->has_link != 1u) return 2;\n\
               if (p->space != 1u) return 3;\n\
               return 0;\n\
               }\n";
    assert_eq!(run_str(src), 0);
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
fn zero_size_static_distinct() {
    // Zero-sized statics (GNU empty struct) keep distinct addresses:
    // the object model identifies objects by start offset.
    assert_eq!(run_fixture("zero_size_static_distinct.c"), 0);
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
fn fn_ptr_return_via_fn_ptr_var() {
    // A pointer to a function returning a function pointer
    // (`int (*(*p)(int))(int)`): `(*p)` decays, and the call result is
    // itself callable, for local / global / typedef / member /
    // parameter carriers of the type.
    assert_eq!(run_fixture("fn_ptr_return_via_fn_ptr_var.c"), 0);
}

#[test]
fn fn_type_typedef_ptr() {
    // `F *` for a function-TYPE typedef `F` is the spelled-out
    // fn-pointer type (C99 6.2.7): mixed-spelling prototype pairs,
    // the `F **` deref, `F (*p)` grouping, and calls through stored
    // pointers.
    assert_eq!(run_fixture("fn_type_typedef_ptr.c"), 0);
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
fn block_extern_shadows_file_scope_name() {
    // C99 6.2.1p4: an `extern` declaration binds the name for its own
    // scope only. A name that is an enumeration constant or a typedef at
    // file scope is one again after the function that shadowed it, whether
    // the shadowing declaration sat in the body's outermost scope or in a
    // nested block.
    assert_eq!(run_fixture("block_extern_shadows_file_scope_name.c"), 0);
}

#[test]
fn decl_specifier_order_const_after_type() {
    // C99 6.7.1p1: specifiers may appear in any order, so `T const x`
    // qualifies the object as `const T x` does. The trailing form must
    // fold into a later constant expression at every scope.
    assert_eq!(run_fixture("decl_specifier_order_const_after_type.c"), 0);
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
fn inline_struct_return_multi_block() {
    // A branching struct-returning helper inlines, and its fields reach
    // the caller through a whole-struct copy and across the block a
    // later call and branch open.
    assert_eq!(run_fixture("inline_struct_return_multi_block.c"), 0);
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
fn inline_asm_x64_align_padding_opaque() {
    // `.align` / `.p2align` / `.balign` padding in the code stream has no
    // modelled effect; the surrounding computation is unaffected.
    assert_eq!(run_fixture("inline_asm_x64_align.c"), 42);
}

#[test]
fn inline_asm_x64_port_dx_parses() {
    // The `(%dx)` port spelling parses to the same operand as bare `%dx`;
    // the guarded port accesses stay unexecuted.
    assert_eq!(run_fixture("inline_asm_x64_port_dx.c"), 42);
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
fn x86intrin_umbrella_scalar_subset() {
    use crate::{CompileOptions, Compiler, Target};
    // <x86intrin.h> carries the scalar ia32 subset: byte swaps, bit
    // scans, rotates, rdtsc/rdtscp/rdpmc and pause. It compiles on the
    // x86 targets only; elsewhere the include reports the missing
    // header, as gcc's per-target header set does.
    let compiles = |target: Target| -> bool {
        let src = "#include <x86intrin.h>\n\
                   unsigned long long f(unsigned int *aux) {\n\
                     __pause();\n\
                     return __rdtsc() + __rdtscp(aux) + __rdpmc(0)\n\
                       + (unsigned long long)__bswapd(__bsfd(0x10) + __bsrd(0x10))\n\
                       + (unsigned long long)_bswap64(1) + _lrotl(1, 2)\n\
                       + __rolw(1, 3) + __rorb(8, 1) + _rotr(4u, 1);\n\
                   }\n";
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src.to_string(), target, opts)
            .compile()
            .is_ok()
    };
    assert!(compiles(Target::LinuxX64), "x86intrin.h on linux-x64");
    assert!(compiles(Target::WindowsX64), "x86intrin.h on windows-x64");
    assert!(
        !compiles(Target::LinuxAarch64),
        "x86intrin.h must report non-x86 targets"
    );
}

#[test]
fn the_pty_headers_complete_struct_termios() {
    use crate::{CompileOptions, Compiler, Target};
    // glibc's <pty.h> and the BSD <util.h> include <termios.h>, so a unit
    // that reaches the pty helpers through either header alone still sees
    // the struct definition. QEMU's chardev/char-pty.c is such a unit.
    let compiles = |header: &str, target: Target| -> bool {
        let src = alloc::format!(
            "#include <{header}>\nint f(void) {{ struct termios t; t.c_iflag = 0; \
             return (int)t.c_iflag; }}\n"
        );
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src, target, opts).compile().is_ok()
    };
    assert!(compiles("pty.h", Target::LinuxX64), "<pty.h> on linux-x64");
    assert!(
        compiles("pty.h", Target::LinuxAarch64),
        "<pty.h> on linux-aarch64"
    );
    assert!(
        compiles("util.h", Target::MacOSAarch64),
        "<util.h> on macos"
    );
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
fn string_concat_encoding_prefix() {
    // C99 6.4.5p4: an unprefixed part of an adjacent-literal run joins at
    // the run's element width, whichever end carries the prefix. Matched
    // against GCC and clang.
    assert_eq!(run_fixture("string_concat_encoding_prefix.c"), 0);
}

#[test]
fn utf8_string_prefix_ucn() {
    // C11 6.4.5p3: `u8` is a narrow literal, so it joins an unprefixed
    // part in a run; 6.4.3 universal character names encode as UTF-8
    // there and as one code point in a wide literal. Matched against
    // GCC and clang.
    assert_eq!(run_fixture("utf8_string_prefix_ucn.c"), 0);
}

#[test]
fn const_object_array_bound() {
    // A static `const` integer object folds its value in a later constant
    // expression, so it works as an array bound (a fixed array, not a VLA)
    // and may carry an initializer.
    assert_eq!(run_fixture("const_object_array_bound.c"), 0);
}

#[test]
fn const_pointer_object_fold() {
    // A const-qualified pointer object with static storage duration is
    // read as its initializer's address: file-scope and block-scope
    // objects, an aggregate member, an interior and a one-past-the-end
    // element address, a later-defined extern, a function, and one
    // whose own address escapes. The object-level cover is in
    // `relocatable`.
    assert_eq!(run_fixture("const_pointer_object_fold.c"), 0);
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
fn byteswap_glibc() {
    // glibc <byteswap.h>: bswap_16/32/64 and the __bswap_N spellings,
    // including the truncation to the operand width and the fold.
    assert_eq!(run_fixture("byteswap_glibc.c"), 0);
}

#[test]
fn builtin_bswap_reversal() {
    // The Inst::Bswap lowering: runtime operands at each width, the
    // truncation of a wider operand, and the zero-extended result.
    assert_eq!(run_fixture("builtin_bswap_reversal.c"), 0);
}

#[test]
fn byte_load_wide_merge() {
    // Byte-assembly readers merge to one wide load, with a byte
    // reversal for the order opposite the target's; the 3-byte reader
    // has no width to merge into.
    assert_eq!(run_fixture("byte_load_wide_merge.c"), 0);
}

#[test]
fn byte_store_wide_merge() {
    // The store side: runs of byte stores of one value merge to one
    // wide store, reversed first for the opposite order.
    assert_eq!(run_fixture("byte_store_wide_merge.c"), 0);
}

#[test]
fn inline_byte_access_leaf() {
    // A pointer-parameter byte-access leaf called in a tight loop: the
    // merge collapses each body to a wide access and the inliner takes
    // the collapsed body, so the loop pays no call per byte group. The
    // asm snapshots hold that shape; this holds the values.
    assert_eq!(run_fixture("inline_byte_access_leaf.c"), 0);
}

#[test]
fn sysexits_codes() {
    // <sysexits.h>: the BSD exit-status codes, same on every target.
    assert_eq!(run_fixture("sysexits_codes.c"), 0);
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
fn builtin_bit_byte_const() {
    // The bit / byte builtins (`bswap16` / `bswap32` / `bswap64`, `ffs`,
    // `clrsb`, `parity`, and the bit-count family) fold in an integer
    // constant expression, so a `case htons(...)` label, a file-scope array
    // bound, and `_Static_assert` accept them. `bswap` carries its fixed-width
    // unsigned result type. Values match GCC and clang; also checked at run
    // time so the constant and run-time paths agree.
    assert_eq!(run_fixture("builtin_bit_byte_const.c"), 0);
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
fn packed_anon_struct_layout() {
    // `packed` removes the padding between an aggregate's own members, not
    // the padding inside a member's type. A member promoted from an
    // anonymous struct/union has to lay out exactly like the same-typed
    // named member, on every data model.
    assert_eq!(run_fixture("packed_anon_struct_layout.c"), 0);
}

#[test]
fn attribute_statement() {
    // An attribute specifier at statement position: a null statement of
    // its own (`__attribute__((fallthrough));`) or a prefix on the
    // declaration or statement that follows.
    assert_eq!(run_fixture("attribute_statement.c"), 0);
}

#[test]
fn typeof_member_array_dims() {
    // `typeof` of a multi-dimensional array member keeps the row shape,
    // so the named type indexes and measures like the member itself.
    assert_eq!(run_fixture("typeof_member_array_dims.c"), 0);
}

#[test]
fn ptr_to_incomplete_array() {
    // C99 6.7.5.2p4 / 6.3.2.1p3: `T (*)[]` points at an incomplete array
    // type and `*p` still decays to `T *`.
    assert_eq!(run_fixture("ptr_to_incomplete_array.c"), 0);
}

#[test]
fn int128_return_scalar() {
    // C99 6.8.6.4p3: a scalar `return` operand converts to the 128-bit
    // integer return type as if by assignment.
    assert_eq!(run_fixture("int128_return_scalar.c"), 0);
}

#[test]
fn designator_chain_runtime_array() {
    // C99 6.7.8p7 `[N].member = value` in an array filled by stores
    // because its element values are not all constant.
    assert_eq!(run_fixture("designator_chain_runtime_array.c"), 0);
}

#[test]
fn designator_range_in_chain() {
    // The GNU `[lo ... hi]` range inside a designator list, not only as a
    // whole-array designator.
    assert_eq!(run_fixture("designator_range_in_chain.c"), 0);
}

#[test]
fn designator_multidim_scalar_array() {
    // A chained `[i][j] =` designator names a row of the innermost
    // dimension, so its brace list spans that row.
    assert_eq!(run_fixture("designator_multidim_scalar_array.c"), 0);
}

#[test]
fn designator_chain_runtime_multidim() {
    // A chained `[i][j]... =` designator on the per-element runtime
    // store path takes the constant collector's grammar, member chains
    // and ranges included, and positional entries resume at the
    // designated rank.
    assert_eq!(run_fixture("designator_chain_runtime_multidim.c"), 0);
}

#[test]
fn macro_alias_tail_invocation() {
    // C99 6.10.3.4p1: a function-like macro name ending an object-like
    // macro's body takes its arguments from the source that follows,
    // across new-lines.
    assert_eq!(run_fixture("macro_alias_tail_invocation.c"), 0);
}

#[test]
fn anon_member_brace_nesting() {
    // C11 6.7.2.1p13 + C99 6.7.9p17: each promoted anonymous aggregate is
    // a sub-object with its own brace level, at any nesting depth.
    assert_eq!(run_fixture("anon_member_brace_nesting.c"), 0);
}

#[test]
fn compound_literal_array_init() {
    // GCC compound literals: an array initialized by an array-typed
    // compound literal takes the literal's brace list.
    assert_eq!(run_fixture("compound_literal_array_init.c"), 0);
}

#[test]
fn compound_literal_multidim() {
    // C99 6.5.2.5: every bracket dimension of an array-typed compound
    // literal shapes its initializer; the value decays to a row pointer.
    assert_eq!(run_fixture("compound_literal_multidim.c"), 0);
}

#[test]
fn struct_array_brace_elision() {
    // C99 6.7.9p20/p21: a sub-array of structs whose braces are elided
    // takes what it holds from the enclosing list; the rest stays zero.
    assert_eq!(run_fixture("struct_array_brace_elision.c"), 0);
}

#[test]
fn struct_array_designator_resume() {
    // C99 6.7.8p17: a positional entry after a designated one in an array
    // of structs takes the next subobject, not the next outer row.
    assert_eq!(run_fixture("struct_array_designator_resume.c"), 0);
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
fn pointer_to_array_cast_keeps_pointee_size() {
    // C99 6.7.6: the abstract declarator `T (*)[N]` in a cast builds the
    // same type as the named `T (*p)[N]`, so `sizeof(*(T (*)[N])p)` is the
    // row and arithmetic strides by it. The dimension used to be parsed and
    // discarded, and the deref of the cast result was swallowed by the
    // function-pointer decay branch.
    assert_eq!(run_fixture("pointer_to_array_cast.c"), 0);
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
fn static_local_shadowing_a_file_scope_name_binds_locally() {
    // C99 6.2.2p6 + 6.2.4p3: a block-scope static object has no
    // linkage. The fixture self-checks that its references bind to the
    // block-scope storage under a name shared with a file-scope extern
    // declaration and with a defined global, and that the hidden
    // global's storage record survives the scope.
    assert_eq!(run_fixture("static_local_shadows_file_scope.c"), 0);
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
fn partial_initializer_zeroes_the_padding() {
    // C99 6.7.8p10 requires zero padding for static storage only; an
    // automatic aggregate initializer zero-fills the whole object before
    // storing the members, which is what `-fzero-init-padding-bits=all`
    // names. The fixture dirties the stack first and ORs the padding.
    assert_eq!(run_fixture("init_padding_zero.c"), 0);
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
fn thread_local_address_constant_initializer() {
    // C99 6.7.8p4: thread storage duration takes the same initializer
    // forms as static, address constants included. The VM keeps one
    // copy of the template, so a slot holding a data offset reads back
    // as the pointer it names. Returns 0 on success.
    assert_eq!(run_fixture("thread_local_address_init.c"), 0);
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
fn flexible_array_member_after_tentative_def() {
    // C99 6.9.2 + 6.7.2.1p16: a tentative definition of a FAM-bearing struct
    // reserves only `sizeof`, so the later defining declaration -- which is
    // larger by its initialized elements -- must take fresh storage. Reusing
    // the tentative slot writes the elements over the next object.
    assert_eq!(
        run_fixture("flexible_array_member_after_tentative_def.c"),
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
fn inner_binding_keeps_outer_array_shape() {
    // A parameter or block local of the same name binds for its own scope
    // only (C99 6.2.1p4). The declarator writes the shared symbol slot
    // before the scope save runs, so the outer array's stride list has to
    // be saved from before that write.
    assert_eq!(run_fixture("inner_binding_keeps_outer_array_shape.c"), 0);
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
fn typedef_aligned_layout() {
    // GNU `aligned(N)` carried by a typedef: object placement (static and
    // automatic), member offsets, sizes, and `__alignof__` on types,
    // objects and member lvalues all follow the gcc semantics, including
    // a typedef lowering the alignment and a declarator attribute
    // replacing the carrier.
    assert_eq!(run_fixture("typedef_aligned_layout.c"), 0);
}

#[test]
fn typedef_aligned_array_element_rejected() {
    use crate::c5::Compiler;
    // An element type whose typedef-carried alignment exceeds its size
    // cannot tile an array; every declarator-added dimension over it is
    // an error (gcc: "alignment of array elements is greater than element
    // size"), while the array typedef itself stays legal.
    let cases = [
        "typedef int T __attribute__((aligned(16))); T a[3]; int main(void){return 0;}",
        "typedef int T __attribute__((aligned(16))); int main(void){T a[3]; a[0]=0; return a[0];}",
        "typedef int T __attribute__((aligned(16))); struct S { char c; T a[3]; }; \
         int main(void){return (int)sizeof(struct S);}",
        "typedef int T __attribute__((aligned(16))); typedef T A[3]; int main(void){return 0;}",
        "typedef char A16[4] __attribute__((aligned(16))); A16 two[2]; int main(void){return 0;}",
    ];
    for src in cases {
        let err = Compiler::new(src.to_string())
            .compile()
            .expect_err("over-aligned array element must be rejected");
        let msg = format!("{err}");
        assert!(
            msg.contains("alignment of array elements is greater than element size"),
            "unexpected diagnostic for {src:?}: {msg:?}"
        );
    }
    // The alignment binding to the array typedef itself is satisfiable.
    let ok = "typedef char A16[4] __attribute__((aligned(16))); A16 one; \
              int main(void){one[0]=1; return one[0]-1;}";
    Compiler::new(ok.to_string())
        .compile()
        .expect("array typedef carrying its own alignment must compile");
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
fn static_local_array_init_bounds() {
    // C99 6.7.8p2/p14/p21: a static-local array initializer fills the storage
    // reserved for the declared bound and no more -- an over-long list is
    // rejected (see `tests::parser`), and the legal shapes leave the
    // neighbouring statics untouched.
    assert_eq!(run_fixture("static_local_array_init_bounds.c"), 0);
}

#[test]
fn string_initializer_copy_rules() {
    // C99 6.7.8p14/p21: one set of copy rules at every string-literal
    // destination -- bare and brace-wrapped array, multi-dimensional row,
    // struct member (constant and runtime paths), flexible array member.
    // An embedded NUL is a copied character (the flexible array member used
    // to stop there) and a wide row decodes at the wchar_t stride (it used
    // to fall through to the pointer path).
    assert_eq!(run_fixture("string_initializer_copy_rules.c"), 0);
}

#[test]
fn struct_arg_value_form() {
    // A by-value aggregate argument has two call-site forms: the address of
    // the caller's copy, and -- when the callee's parameter list is not in
    // scope -- the object's bytes in one machine word. The interpreter read
    // the second form's word as an address; the native backends take both.
    assert_eq!(run_fixture("struct_arg_value_form.c"), 0);
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
fn cross_block_cse() {
    // Dominator-scoped CSE: duplicates at dominated positions reuse the
    // dominating value, and the cases the pressure gate declines keep
    // computing the same results.
    assert_eq!(run_fixture("cross_block_cse.c"), 0);
}

#[test]
fn divmod_pair_shared_quotient() {
    // One quotient serves a division and a modulo over the same
    // operands, in either source order and across blocks; the
    // remaining lone divides keep their own.
    assert_eq!(run_fixture("divmod_pair_shared_quotient.c"), 0);
}

#[test]
fn mul_add_contraction() {
    // An integer multiply feeding an add or a subtract contracts into
    // one multiply-accumulate; the results match the pair at both
    // widths, signed and unsigned, and where the product has a second
    // reader or the operands spill.
    assert_eq!(run_fixture("mul_add_contraction.c"), 0);
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
fn int_compare_narrow_width() {
    // Comparisons over `int` operands are decided by the low words, so
    // they are emitted at 32 bits; the widening conversions, unsigned
    // wraparound and `int`-indexed subscripts around them keep their
    // C99 results.
    assert_eq!(run_fixture("int_compare_narrow_width.c"), 0);
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
fn enum_unsigned_value_cmp() {
    // Enum constants outside int's range take the enum's compatible
    // type (unsigned int / long long), so `int != BIAS` with
    // BIAS = -1U<<31 compares at 32-bit unsigned per C99 6.3.1.8.
    assert_eq!(run_fixture("enum_unsigned_value_cmp.c"), 0);
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
fn split_spilled_reload_run() {
    // Live-range splitting of the values one cold call forces out of
    // the caller-saved bank; the result is unchanged.
    assert_eq!(run_fixture("split_spilled_reload_run.c"), 229);
}

#[test]
fn hoist_loop_invariant_address() {
    // Loop-invariant addresses and constants lifted out of the loops
    // that rebuild them; the results are unchanged.
    assert_eq!(run_fixture("hoist_loop_invariant_address.c"), 42);
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
fn long_double_characteristics_track_the_target() {
    // <float.h> advertises the target ABI's `long double` storage
    // format; `sizeof` and the predefines agree on whichever host this
    // runs on, and the MANT_DIG value is one of the three formats.
    let src = "#include <float.h>\n\
               int main(void){ return (sizeof(long double)==__SIZEOF_LONG_DOUBLE__\n\
               && (LDBL_MANT_DIG==53 || LDBL_MANT_DIG==64 || LDBL_MANT_DIG==113)\n\
               && (LDBL_MANT_DIG!=53 || (LDBL_MAX==DBL_MAX && LDBL_MIN==DBL_MIN))) ? 0 : 1; }";
    assert_eq!(super::run_str(src), 0);
    // <float.h> derives every name from the predefines, so the header
    // and `__LDBL_*` / `__DBL_*` / `__FLT_*` cannot drift apart.
    let derived = "#include <float.h>\n\
                   int main(void){ return (LDBL_MANT_DIG==__LDBL_MANT_DIG__\n\
                   && DBL_MANT_DIG==__DBL_MANT_DIG__ && FLT_MANT_DIG==__FLT_MANT_DIG__\n\
                   && FLT_RADIX==__FLT_RADIX__ && DBL_MAX==__DBL_MAX__\n\
                   && LDBL_TRUE_MIN==__LDBL_DENORM_MIN__\n\
                   && DECIMAL_DIG==__DECIMAL_DIG__) ? 0 : 1; }";
    assert_eq!(super::run_str(derived), 0);
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
fn phi_group_dead_phi_interference_terminates() {
    // A dead phi shared the loop counter's register because the
    // interference sweep sequenced the block's phi definitions, so the
    // counter's phi was already retired when the dead one was scanned.
    // The predecessor-edge copy then reset the counter every iteration
    // and the -O loop never exited. The fixture tables run this at -O.
    assert_eq!(run_fixture("phi_group_dead_phi_interference.c"), 0);
}

#[test]
fn inline_by_value_aggregate_param_copy_is_a_copy() {
    // C99 6.5.2.2p4: the splice must copy the argument into the
    // parameter's relocated cell rather than bind the cell to the
    // caller's object, which made a write through an aliasing pointer
    // visible in the parameter.
    assert_eq!(run_fixture("inline_by_value_aggregate_param_copy.c"), 0);
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
    // (size_t)-1 / 0 per type class otherwise, operand unevaluated. An
    // array member is unbounded through a pointer when it is a `[]`
    // member or, at the default -fstrict-flex-arrays=0, the last member;
    // a member of a declared object is bounded by the object.
    assert_eq!(run_fixture("builtin_object_size.c"), 0);
}

#[test]
fn strict_flex_arrays_default_level() {
    // At the default -fstrict-flex-arrays=0 every trailing array member
    // is unbounded through a pointer; only the array that is not the
    // last member answers its size (the fixture's bit 4).
    assert_eq!(run_fixture("strict_flex_arrays.c"), 16);
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
fn bool_bitfield_assign_normalizes() {
    // C99 6.5.16.1p2 + 6.3.1.2: a value assigned to a `_Bool` bitfield
    // converts to `_Bool` (zero / nonzero) before the store, not by
    // truncation to the field's width. Masking alone folded
    // `flag = x & 4` to a constant 0 for a field at bit 0 or 1, which
    // is the kernel's `data->allow_reinit = flags &
    // PERCPU_REF_ALLOW_REINIT`.
    assert_eq!(run_fixture("bool_bitfield_assign_normalizes.c"), 0);
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
fn conditional_pointer_result_identity() {
    // C99 6.5.15p6 result types observed through _Generic: the `void *`
    // arm wins over character pointers too, and `void *` never matches
    // a character-pointer association (6.2.5p19 distinct-type identity).
    assert_eq!(run_fixture("conditional_pointer_result_identity.c"), 0);
}

#[test]
fn sizeof_result_size_t() {
    // C99 6.5.3.4p4: sizeof / _Alignof results are size_t (unsigned),
    // visible through the usual arithmetic conversions and typeof.
    assert_eq!(run_fixture("sizeof_result_size_t.c"), 0);
}

#[test]
fn minmax_signedness_chain() {
    // choose_expr + conditional-based constant detection + signedness
    // static_assert, over size_t-typed operands: the composed macro
    // chain selects the correct arm and the assertion stays quiet.
    assert_eq!(run_fixture("minmax_signedness_chain.c"), 0);
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

#[test]
fn builtin_constant_p_value_kinds() {
    // An object or a symbol-relative address is not a constant value:
    // an array, a struct, `&global` and a compound literal answer 0 as
    // gcc does; literals, enum constants, `sizeof` and folded pointer
    // comparisons answer 1.
    assert_eq!(run_fixture("builtin_constant_p_value_kinds.c"), 0);
}

#[test]
fn builtin_constant_p_selects_choose_expr_arm_in_initializer() {
    // The kernel's PIN_GROUP shape: an array operand selects the address
    // arm, whose value carries a relocation; an integer operand selects
    // the constant arm; a floating arm keeps its value.
    assert_eq!(run_fixture("builtin_constant_p_choose_expr_init.c"), 0);
}

#[test]
fn builtin_constant_p_deferred() {
    // The interpreter runs unoptimized SSA, where the walker answers a
    // non-constant operand 0 directly, so `Intrinsic::ConstantP` never
    // reaches it. The fixture's assertions hold in both modes; the
    // native lanes run the same source under -O.
    assert_eq!(run_fixture("builtin_constant_p_deferred.c"), 0);
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
fn inline_asm_operand_avoids_clobbered_gp_register() {
    // A plain `r` operand must not be placed in a register the template
    // clobbers. The asm writes 0x1234 into the output, then trashes
    // rax/rbx/rcx/rdx; if the operand shared one of those the value would be
    // lost. Compiled for x86-64 so the clobber names resolve regardless of the
    // host arch, then run under the (x86-only) interpreter.
    use crate::{Compiler, Target, Vm};
    let src = "
        int main(void) {
            int result;
            __asm__ volatile(\"movl $0x1234, %0\\n\\t\"
                             \"movl $0, %%eax\\n\\t\"
                             \"movl $0, %%ebx\\n\\t\"
                             \"movl $0, %%ecx\\n\\t\"
                             \"movl $0, %%edx\\n\\t\"
                             : \"=r\"(result)
                             :
                             : \"rax\", \"rbx\", \"rcx\", \"rdx\");
            return result == 0x1234 ? 42 : 1;
        }
    ";
    let program = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .unwrap();
    let got = Vm::new(program).with_pointer_tracking().run().unwrap();
    assert_eq!(got, 42, "operand landed in a clobbered register");
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
fn inline_asm_x64_operand_modifiers_fixture() {
    // `%z` / `%h` and the immediate arm of a register-or-immediate
    // constraint, with a portable fallback.
    assert_eq!(run_fixture("inline_asm_x64_operand_modifiers.c"), 42);
}

#[test]
fn inline_asm_x64_operand_modifiers_hold_under_both_data_models() {
    use crate::Target;
    // The suffix `%z` selects and the comparisons the fixture makes follow
    // the operand's width, and `long` is 4 bytes on the Windows targets.
    // The x86 targets take the asm arm and the aarch64 ones the portable
    // fallback, so both arms are covered at both widths.
    for target in [
        Target::LinuxX64,
        Target::LinuxAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
        Target::MacOSAarch64,
    ] {
        assert_eq!(
            super::run_fixture_for("inline_asm_x64_operand_modifiers.c", target),
            42,
            "{target:?}"
        );
    }
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

#[test]
fn for_post_statement_expression_returns() {
    // A `for` post-expression is a void context, so its value is
    // discarded. When it is a GNU statement expression whose final
    // statement transfers control out of the expression (here a
    // `return`), the block that would carry the post back-edge is
    // closed. The walker must open a fresh block for that unreachable
    // back-edge instead of emitting it into no block. Runtime: the init
    // runs, the body runs once (i becomes 8), then the post's `return`
    // yields steps * 100 + i == 108, matching gcc.
    let src = "
        int main(void) {
            int i = 3;
            int steps = 0;
            for (i = 3; ; ({ steps += 1; return steps * 100 + i; }))
                i = i + 5;
        }
    ";
    assert_eq!(run_str(src), 108);
}

#[test]
fn for_post_statement_expression_goto() {
    // The same shape with a `goto` out of the post statement expression
    // to a label after the loop. The post back-edge is unreachable and
    // must not be emitted into a closed block. Runtime: body runs once
    // (i becomes 4), the post records log == 4 and jumps past the loop,
    // so the result is log * 100 + i == 404, matching gcc.
    let src = "
        int main(void) {
            int i = 1;
            int log = 0;
            for (i = 1; ; ({ log = log * 10 + i; goto done; }))
                i = 4;
        done:
            return log * 100 + i;
        }
    ";
    assert_eq!(run_str(src), 404);
}

#[test]
fn of_declare_fn_pointer_null_compare_selects_arm() {
    // The Linux `_OF_DECLARE` idiom `(fn == (T)NULL) ? fn : fn` in a
    // section-placed struct: the pointer comparison folds to 0 (a
    // function's address is never null), so the `?:` selects `fn`.
    let src = "
        typedef int (*fn_t)(void);
        static int impl(void) { return 7; }
        struct desc { const char *c; const void *data; };
        static const struct desc d = {
            .c = \"x\",
            .data = (impl == (fn_t)((void *)0)) ? impl : impl,
        };
        int main(void) { fn_t f = (fn_t)d.data; return f(); }
    ";
    assert_eq!(run_str(src), 7);
}

#[test]
fn typeof_of_pointer_cast_of_array_is_pointer() {
    // `typeof((T *)arr)` is `T *`, not the array type: a cast yields the
    // cast type regardless of the operand (C99 6.5.4). Subscripting the
    // cast then indexes correctly, and `sizeof` of the cast is a pointer.
    let src = "
        struct b { long long v; };
        static struct b arr[4] = { {10}, {20}, {30}, {40} };
        _Static_assert(sizeof((typeof(*(arr)) *)(arr)) == sizeof(void *), \"cast is ptr\");
        int main(void) {
            return (int)((typeof((typeof(*(arr)) *)(arr)))(arr))[2].v;
        }
    ";
    assert_eq!(run_str(src), 30);
}

#[test]
fn parenthesized_compound_literal_static_init() {
    // A parenthesized compound literal `((T){ ... })` as a static
    // initializer (C99 6.5.2.5), the `GUID_INIT` shape.
    let src = "
        typedef struct { unsigned char b[4]; } g_t;
        static const g_t g = ((g_t){ { 1, 2, 3, 4 } });
        int main(void) { return g.b[0] * 1000 + g.b[3]; }
    ";
    assert_eq!(run_str(src), 1004);
}

#[test]
fn nested_anonymous_aggregate_fully_braced_init() {
    // A field flattened from a union nesting an anonymous struct takes a
    // fully-braced initializer bracing each level (C11 6.7.2.1), the
    // `QSTR_INIT` shape.
    let src = "
        struct qstr {
            union {
                struct { unsigned h; unsigned l; };
                unsigned long long hl;
            };
            const char *name;
        };
        static const struct qstr q = { { { .l = 9 } }, .name = \"ab\" };
        int main(void) { return (int)q.l * 10 + (int)q.h; }
    ";
    assert_eq!(run_str(src), 90);
}

#[test]
fn flexible_array_member_designated_init() {
    // A flexible array member initialized with a `[index] = value`
    // designator sizes the member to the highest index and zero-fills the
    // gaps (GCC/clang extension over C99 6.7.2.1p18).
    let src = "
        struct fam { int a; long long bm[]; };
        static struct fam fm = { .a = 5, .bm = { [2] = 77 } };
        int main(void) { return fm.a * 100 + (int)fm.bm[2] + (int)fm.bm[0]; }
    ";
    assert_eq!(run_str(src), 577);
}

#[test]
fn address_of_deref_null_folds_to_null() {
    // `&*(T *)0` folds to the null pointer (`&*` cancels, C99 6.5.3.2p3),
    // the `&sysrq_showlocks_op`-via-macro shape.
    let src = "
        struct op { int x; };
        static struct op *const table[2] = { &(*(struct op *)((void *)0)), (void *)0 };
        int main(void) {
            return (table[0] == (void *)0 && table[1] == (void *)0) ? 1 : 0;
        }
    ";
    assert_eq!(run_str(src), 1);
}

#[test]
fn struct_member_two_dimensional_scalar_array_init() {
    // A struct's scalar 2D-array member takes a fully-braced initializer
    // with a brace per row (C99 6.7.8p20), the `DEFINE_PER_CPU(... ) =
    // {{{0}}}` shape reduced to non-zero values.
    let src = "
        struct s { long long a[2][3]; };
        static struct s x = { .a = { {1, 2, 3}, {4, 5, 6} } };
        int main(void) { return (int)(x.a[0][0] * 100 + x.a[1][2]); }
    ";
    assert_eq!(run_str(src), 106);
}

#[test]
fn typeof_multidimensional_array_redeclaration_keeps_inner_dim() {
    // `extern typeof(a) a;` (the EXPORT_SYMBOL shape) on a multi-dim array
    // must keep every dimension so a later `a[i][j]` strides by the inner
    // dimension, not drop to a single dimension.
    let src = "
        static const long long t[2][3] = { {10, 11, 12}, {20, 21, 22} };
        extern typeof(t) t;
        int main(void) { return (int)(t[1][2] - t[0][0]); }
    ";
    assert_eq!(run_str(src), 12);
}

#[test]
fn const_expr_dead_ternary_arm_keeps_function_call() {
    // The address-constant folding must not intercept a function
    // designator in an unevaluated `?:` arm: `ilog2`'s dead arm holds a
    // non-constant call the constant evaluator skips. A constant condition
    // selects the live arm, so the array dimension folds.
    let src = "
        extern int probe_u32(unsigned);
        extern int probe_u64(unsigned long long);
        #define pick(n) (__builtin_constant_p(n) ? ((n) < 2 ? 0 : 5) \
                         : (sizeof(n) <= 4) ? probe_u32(n) : probe_u64(n))
        struct s { long long a[pick(64) + 1]; };
        int main(void) { return (int)(sizeof(struct s) / sizeof(long long)); }
    ";
    assert_eq!(run_str(src), 6);
}

#[test]
fn inner_scope_bindings_unbind_at_scope_exit() {
    // C99 6.2.1p4: a parameter, body local, block local, block-scope
    // `static` / `typedef` / `extern` and a prototype's parameters all
    // stop being visible at their scope's end. A binding left in place
    // resolves the file-scope name to the inner declaration's frame slot.
    assert_eq!(run_fixture("scope_unbind_at_function_exit.c"), 0);
}

#[test]
fn unused_binding_diagnostics_follow_symbol_table_order() {
    // The per-function unused-binding report walks the function's
    // bindings in symbol-table index order, not declaration order:
    // `zz` interns at file scope and so precedes `aa` despite being
    // declared second.
    let src = "
        int zz;
        int f(void)
        {
            int aa = 1;
            int zz = 2;
            return 0;
        }
        int main(void) { return f(); }
    ";
    let prog = compile_str(src);
    let unused: Vec<&str> = prog
        .warnings
        .iter()
        .filter_map(|w| {
            if w.contains("unused variable `zz`") {
                Some("zz")
            } else if w.contains("unused variable `aa`") {
                Some("aa")
            } else {
                None
            }
        })
        .collect();
    assert_eq!(unused, ["zz", "aa"], "warnings: {:?}", prog.warnings);
}

/// A file-scope brace list of `n` compound-literal elements shaped like a
/// schema table: nested dict literals with string members. The shape that
/// exercises the initializer checkpoint/restore machinery per element.
#[cfg(not(debug_assertions))]
fn nested_literal_unit(n: usize) -> String {
    let mut s = String::from(
        "typedef struct E E; typedef struct O O;\n\
         struct O { int type; union { const char *s; const E *d; const O *l; } u; };\n\
         struct E { const char *key; O value; };\n\
         const O table = { .type = 3, .u.l = ((O[]) {\n",
    );
    for i in 0..n {
        s.push_str(&format!(
            "{{ .type = 2, .u.d = ((E[]) {{ \
             {{ \"a\", {{ .type = 1, .u.s = (\"{i}\") }} }}, \
             {{ \"b\", {{ .type = 1, .u.s = (\"x\") }} }}, \
             {{ \"c\", {{ .type = 1, .u.s = (\"y\") }} }}, \
             {{}} }}) }},\n"
        ));
    }
    s.push_str("{} }) };\nint main(void) { return table.type - 3; }\n");
    s
}

#[test]
#[cfg(not(debug_assertions))]
fn initializer_cost_is_linear_in_element_count() {
    // A brace list of compound-literal elements must cost per element:
    // a value's speculative parses may only stage and roll back state
    // the value itself appended, the constant-conditional attempt must
    // not run without a `?` ahead, and the initializer-override
    // retirement must cost what it retires rather than the recorded set.
    //
    // The span is 16x the elements, because a quadratic term is a small
    // fraction of the total until the unit is large: over 4x it hides
    // inside the per-element constant. Measured here, linear cost runs
    // 15x and the quadratic retirement ran 102x, so 32x separates them
    // with better than 2x margin on either side. The metric is the ratio
    // rather than either time, so a loaded box scales both ends.
    fn once(src: &str) -> f64 {
        let t = std::time::Instant::now();
        let _ = compile_str(src);
        t.elapsed().as_secs_f64()
    }
    let units = [nested_literal_unit(1600), nested_literal_unit(25600)];
    let mut best = [f64::MAX; 2];
    for _ in 0..3 {
        for (b, u) in best.iter_mut().zip(units.iter()) {
            *b = b.min(once(u));
        }
    }
    let (small, large) = (best[0], best[1]);
    assert!(small > 0.0, "no measurable initializer cost to compare");
    assert!(
        large < small * 32.0,
        "initializer cost grew {:.1}x for 16x the elements ({small:.3e}s -> {large:.3e}s)",
        large / small
    );
}

/// One block declaring `n` `__label__` names, each defined and reached
/// by a `goto`. The shape that exercises the declaration bookkeeping
/// and the reference resolution together.
#[cfg(not(debug_assertions))]
fn local_label_unit(n: usize) -> String {
    let mut s = String::from("int main(void) {\n__label__ L0");
    for i in 1..n {
        s.push_str(&format!(", L{i}"));
    }
    s.push_str(";\nint acc = 0;\ngoto L0;\n");
    for i in 0..n - 1 {
        s.push_str(&format!("L{i}: acc++; goto L{};\n", i + 1));
    }
    s.push_str(&format!("L{}: return acc;\n}}\n", n - 1));
    s
}

#[test]
#[cfg(not(debug_assertions))]
fn local_label_parse_cost_is_linear_in_declaration_count() {
    // End-to-end cover for the same property the lookup-count test
    // asserts, independent of that instrumentation: `__label__` parse
    // must cost per name rather than per name pair.
    //
    // The span is 16x the names; the smaller point carries the fixed
    // per-compile cost, so linear growth reads under 16x. Measured here,
    // the keyed bindings ran 7.2x and the per-block scan they replaced
    // ran 135x, so 32x separates them with better than 4x margin on
    // either side. The metric is the ratio rather than either time, so
    // a loaded box scales both ends.
    fn once(src: &str) -> f64 {
        let t = std::time::Instant::now();
        let _ = compile_str(src);
        t.elapsed().as_secs_f64()
    }
    let units = [local_label_unit(800), local_label_unit(12800)];
    let mut best = [f64::MAX; 2];
    for _ in 0..3 {
        for (b, u) in best.iter_mut().zip(units.iter()) {
            *b = b.min(once(u));
        }
    }
    let (small, large) = (best[0], best[1]);
    assert!(small > 0.0, "no measurable parse cost to compare");
    assert!(
        large < small * 32.0,
        "`__label__` parse grew {:.1}x for 16x the names ({small:.3e}s -> {large:.3e}s)",
        large / small
    );
}

/// Closing a function scope must cost its own bindings, not the whole
/// symbol table. Measured in symbols examined at scope exit, so the
/// claim holds exactly rather than to within timer noise: the same
/// definitions examine the same symbols whatever the unit's file-scope
/// declaration count, while a full-table scan per exit grows with it.
#[test]
fn function_close_cost_is_independent_of_declaration_count() {
    fn unit(globals: usize, functions: usize) -> String {
        let mut s = String::new();
        for j in 0..globals {
            s.push_str(&format!("int gv{j};\n"));
        }
        for i in 0..functions {
            s.push_str(&format!(
                "int sf{i}(int p, int q) {{ int u = p + q; int v = u * 3; return u + v; }}\n"
            ));
        }
        s.push_str("int main(void) { return 0; }\n");
        s
    }
    let once = |globals: usize| -> (usize, usize) {
        let src = unit(globals, 300);
        crate::c5::compiler::SCOPE_UNWIND.with(|c| c.set((0, 0)));
        let _ = compile_str(&src);
        crate::c5::compiler::SCOPE_UNWIND.with(|c| c.get())
    };
    let (small, small_scan) = once(500);
    let (large, large_scan) = once(16000);
    assert!(small > 0, "no scope unwinds to compare");
    assert_eq!(
        small, large,
        "32x the file-scope declarations changed the symbols the scope \
         exits examine, so the unwind is reading the table rather than \
         the scope's own bindings",
    );
    // The full-table scan this replaced does grow with the declarations,
    // so the equality above is not something any implementation gives.
    assert!(
        large_scan >= small_scan * 8,
        "a full-table scan per scope exit no longer grows with the \
         declaration count ({small_scan} -> {large_scan}); the check \
         above no longer proves anything",
    );
}

#[test]
fn switch_const_index_jump_table_fold() {
    // A jump-table dispatch whose index folds to a constant leaves the
    // table's target list without a terminator naming it; the deleted
    // case blocks must not stay recorded there.
    assert_eq!(run_fixture("switch_const_index_jump_table_fold.c"), 0);
}

#[test]
fn computed_goto_label_only_target() {
    // A label reachable only through `goto *` survives block deletion:
    // the indirect transfer carries no terminator edge.
    assert_eq!(run_fixture("computed_goto_label_only_target.c"), 0);
}

#[test]
fn zero_length_array_member_marker() {
    // C99 6.7.2.1p16: only a trailing member is the flexible array
    // member; a `T v[0]` marker ahead of it is zero-storage.
    assert_eq!(run_fixture("zero_length_array_member_marker.c"), 0);
}

/// Compile `src` for `target` with no entry point. A negative-size array
/// declaration is a compile error unless every constant in its condition
/// matches, so a successful compile IS the assertion.
#[cfg(test)]
fn header_snippet_compiles(src: &str, target: crate::Target) -> bool {
    use crate::{CompileOptions, Compiler};
    let opts = CompileOptions::default().with_no_entry_point(true);
    Compiler::with_options(src.to_string(), target, opts)
        .compile()
        .is_ok()
}

#[test]
fn elf_header_publishes_the_abi_constant_set() {
    use crate::Target;
    // The bundled <elf.h> carries the generic ABI constants, the GNU OS
    // extensions and the per-processor relocation tables that object
    // readers switch on. Values follow the generic ELF ABI and the
    // i386 / AMD64 / AArch64 / Arm processor supplements.
    let src = "#include <elf.h>\n\
        int ck[(SHN_LORESERVE==0xff00 && SHN_XINDEX==0xffff \
             && SHN_HIRESERVE==0xffff && SHF_ALLOC==2 && SHF_EXECINSTR==4 \
             && SHF_INFO_LINK==0x40 && SHF_TLS==0x400 \
             && SHT_SYMTAB_SHNDX==18 && SHT_GROUP==17 && SHT_GNU_HASH==0x6ffffff6 \
             && GRP_COMDAT==1 && STT_COMMON==5 && STT_GNU_IFUNC==10 \
             && STT_SPARC_REGISTER==13 && STB_GNU_UNIQUE==10 \
             && STV_HIDDEN==2 && STV_PROTECTED==3 \
             && PT_GNU_EH_FRAME==0x6474e550 && PT_GNU_STACK==0x6474e551 \
             && PF_X==1 && PF_W==2 && PF_R==4 \
             && DT_INIT_ARRAY==25 && DT_VERSYM==0x6ffffff0 \
             && EM_AARCH64==183 && EM_LOONGARCH==258 && ELFOSABI_GNU==3 \
             && NT_GNU_BUILD_ID==3 && ELF64_ST_VISIBILITY(0x83)==3 \
             && R_386_PC32==2 && R_386_GOTPC==10 \
             && R_X86_64_PLT32==4 && R_X86_64_GOTPCREL==9 && R_X86_64_PC64==24 \
             && R_AARCH64_ABS64==257 && R_AARCH64_CALL26==283 \
             && R_ARM_ABS32==2 && R_RISCV_64==2)?1:-1];\n\
        Elf64_Shdr sh; Elf64_Rela ra; Elf64_Sym sy;\n";
    assert!(
        header_snippet_compiles(src, Target::LinuxX64),
        "x86-64 <elf.h>"
    );
    assert!(
        header_snippet_compiles(src, Target::LinuxAarch64),
        "aarch64 <elf.h>"
    );
    // A wrong value must fail, proving the assertion actually bites.
    assert!(
        !header_snippet_compiles(
            "#include <elf.h>\nint ck[(SHF_ALLOC==0)?1:-1];\n",
            Target::LinuxX64
        ),
        "the negative-size assertion must reject a wrong value"
    );
}

/// Every target badc emits for. The header-presence checks below run the
/// same snippet through all of them, so a header that resolves on the
/// host but nowhere else fails here rather than in a cross build.
#[cfg(test)]
const ALL_TARGETS: [crate::Target; 5] = [
    crate::Target::MacOSAarch64,
    crate::Target::LinuxAarch64,
    crate::Target::LinuxX64,
    crate::Target::WindowsX64,
    crate::Target::WindowsAarch64,
];

#[test]
fn fnmatch_flags_follow_each_platform_libc() {
    use crate::Target;
    // The flags every target agrees on. FNM_PATHNAME / FNM_NOESCAPE are
    // numbered the other way round by the two platform libraries, so
    // only their distinctness and the GNU aliases are common.
    let common = "#include <fnmatch.h>\n\
        int ck[(FNM_NOMATCH==1 && FNM_NOSYS==-1 && FNM_PERIOD==0x04 \
             && FNM_LEADING_DIR==0x08 && FNM_CASEFOLD==0x10 \
             && FNM_PATHNAME!=FNM_NOESCAPE \
             && FNM_FILE_NAME==FNM_PATHNAME \
             && FNM_IGNORECASE==FNM_CASEFOLD)?1:-1];\n";
    for target in ALL_TARGETS {
        assert!(
            header_snippet_compiles(common, target),
            "<fnmatch.h> on {target:?}"
        );
    }

    // The BSD-derived libc numbers FNM_NOESCAPE first, glibc
    // FNM_PATHNAME; Windows takes badc's engine, compiled against the
    // glibc numbering.
    let bsd = "#include <fnmatch.h>\nint ck[(FNM_NOESCAPE==0x01 && FNM_PATHNAME==0x02)?1:-1];\n";
    let gnu = "#include <fnmatch.h>\nint ck[(FNM_PATHNAME==0x01 && FNM_NOESCAPE==0x02)?1:-1];\n";
    assert!(header_snippet_compiles(bsd, Target::MacOSAarch64));
    assert!(!header_snippet_compiles(gnu, Target::MacOSAarch64));
    for target in [
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(header_snippet_compiles(gnu, target), "{target:?}");
        assert!(!header_snippet_compiles(bsd, target), "{target:?}");
    }

    // FNM_EXTMATCH selects ksh extended patterns, which only glibc's
    // fnmatch matches; defining it elsewhere would accept a flag the
    // implementation behind the call ignores.
    let ext = "#include <fnmatch.h>\nint ck[(FNM_EXTMATCH==0x20)?1:-1];\n";
    assert!(header_snippet_compiles(ext, Target::LinuxX64));
    assert!(header_snippet_compiles(ext, Target::LinuxAarch64));
    for target in [
        Target::MacOSAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(
            !header_snippet_compiles(ext, target),
            "FNM_EXTMATCH must be absent on {target:?}"
        );
    }
}

#[test]
fn byteswap_header_needs_no_platform_library() {
    // glibc's spelling over badc's byte-reversal builtins, which fold in
    // a constant expression, so the values are checked at compile time.
    let src = "#include <byteswap.h>\n\
        int ck[(bswap_16(0x0102)==0x0201 && bswap_32(0x01020304u)==0x04030201u \
             && bswap_64(0x0102030405060708ull)==0x0807060504030201ull \
             && __bswap_16(0x0102)==0x0201 && __bswap_32(0x01020304u)==0x04030201u \
             && __bswap_64(0x0102030405060708ull)==0x0807060504030201ull)?1:-1];\n";
    for target in ALL_TARGETS {
        assert!(
            header_snippet_compiles(src, target),
            "<byteswap.h> on {target:?}"
        );
    }
}

#[test]
fn sysexits_codes_are_target_independent() {
    // sysexits(3) is a set of integer constants with no library, syscall
    // or target dependency behind it.
    let src = "#include <sysexits.h>\n\
        int ck[(EX_OK==0 && EX__BASE==64 && EX_USAGE==64 && EX_DATAERR==65 \
             && EX_NOINPUT==66 && EX_NOUSER==67 && EX_NOHOST==68 \
             && EX_UNAVAILABLE==69 && EX_SOFTWARE==70 && EX_OSERR==71 \
             && EX_OSFILE==72 && EX_CANTCREAT==73 && EX_IOERR==74 \
             && EX_TEMPFAIL==75 && EX_PROTOCOL==76 && EX_NOPERM==77 \
             && EX_CONFIG==78 && EX__MAX==78)?1:-1];\n";
    for target in ALL_TARGETS {
        assert!(
            header_snippet_compiles(src, target),
            "<sysexits.h> on {target:?}"
        );
    }
}

#[test]
fn strchrnul_memrchr_and_explicit_bzero_declare_on_every_target() {
    // libSystem and msvcrt export none of these; there the call resolves
    // to `libc/lib/string_ext.c`, joined to the link on demand. A
    // successful compile is the declaration check.
    let src = "#include <string.h>\n\
        char *f(char *s, void *p) { explicit_bzero(p, 4); \
        return strchrnul(s, '/') + (memrchr(s, '/', 4) - s); }\n";
    for target in ALL_TARGETS {
        assert!(
            header_snippet_compiles(src, target),
            "the GNU string extensions on {target:?}"
        );
    }
}

#[test]
fn mach_vm_statistics_carries_the_user_memory_tags() {
    use crate::Target;
    // The allocator tag namespace and the shift that places a tag in the
    // top 8 bits of a VM flags word. Values follow the macOS SDK's
    // <mach/vm_statistics.h>.
    let src = "#include <mach/vm_statistics.h>\n\
        int ck[(VM_MAKE_TAG(VM_MEMORY_MALLOC)==0x01000000 \
             && VM_MEMORY_MALLOC==1 && VM_MEMORY_MALLOC_SMALL==2 \
             && VM_MEMORY_MALLOC_NANO==11 && VM_MEMORY_STACK==30 \
             && VM_MEMORY_DYLD==60 && VM_MEMORY_SQLITE==62 \
             && VM_MEMORY_SANITIZER==99 && VM_MEMORY_IOACCELERATOR==100 \
             && VM_MEMORY_APPLICATION_SPECIFIC_1==240 \
             && VM_MEMORY_APPLICATION_SPECIFIC_16==255 \
             && VM_MEMORY_COUNT==256 \
             && VM_MEMORY_CARBON==VM_MEMORY_CORESERVICES \
             && VM_FLAGS_ANYWHERE==1 && VM_FLAGS_OVERWRITE==0x4000 \
             && VM_FLAGS_ALIAS_MASK==0xFF000000 \
             && VM_FLAGS_SUPERPAGE_SIZE_2MB==(2<<16))?1:-1];\n";
    assert!(header_snippet_compiles(src, Target::MacOSAarch64));
    // A Mach tag has no meaning off Darwin; mimalloc's own probe is
    // `#if defined(VM_MAKE_TAG)`, so defining it elsewhere would select a
    // tagged mmap on a kernel that reads the fd argument as a descriptor.
    for target in [
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(
            !header_snippet_compiles(src, target),
            "the Mach memory tags must be absent on {target:?}"
        );
    }
}

#[test]
fn the_mach_process_inspection_headers_are_macos_only() {
    use crate::Target;
    // The include set a remote-memory reader pulls in: the process
    // introspection calls, the Mach-O fat and symbol-table layouts, and
    // the 64-bit VM routines with their region-info flavours.
    let src = "#include <libproc.h>\n\
        #include <mach-o/fat.h>\n\
        #include <mach-o/loader.h>\n\
        #include <mach-o/nlist.h>\n\
        #include <mach/mach.h>\n\
        #include <mach/mach_vm.h>\n\
        #include <mach/machine.h>\n\
        #include <sys/proc.h>\n\
        #include <sys/sysctl.h>\n\
        int f(int pid, char *buf) {\n\
            mach_vm_address_t a = 0; mach_vm_size_t n = 0;\n\
            vm_region_basic_info_data_64_t info;\n\
            mach_msg_type_number_t c = VM_REGION_BASIC_INFO_COUNT_64;\n\
            mach_port_t obj = 0;\n\
            mach_vm_region(mach_task_self(), &a, &n, VM_REGION_BASIC_INFO_64,\n\
                           (vm_region_info_t)&info, &c, &obj);\n\
            mach_vm_read_overwrite(mach_task_self(), a, n, (mach_vm_address_t)buf, &n);\n\
            proc_pidpath(pid, buf, PROC_PIDPATHINFO_MAXSIZE);\n\
            return proc_regionfilename(pid, a, buf, 1024) + info.protection; }\n";
    assert!(header_snippet_compiles(src, Target::MacOSAarch64));
    for target in [
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(
            !header_snippet_compiles(src, target),
            "the Mach introspection surface must be absent on {target:?}"
        );
    }

    // The file-format layouts describe fixed on-disk records, so they are
    // readable from any host. Sizes are what clang reports against the
    // macOS SDK; `struct nlist` keeps its 12-byte on-disk shape because
    // the SDK gates the in-core `char *n_name` on !__LP64__.
    let layout = "#include <mach-o/fat.h>\n#include <mach-o/nlist.h>\n\
        #include <mach/machine.h>\n\
        int ck[(sizeof(struct fat_header)==8 && sizeof(struct fat_arch)==20 \
             && sizeof(struct fat_arch_64)==32 \
             && sizeof(struct nlist)==12 && sizeof(struct nlist_64)==16 \
             && FAT_MAGIC==0xcafebabe && FAT_CIGAM==0xbebafeca \
             && FAT_MAGIC_64==0xcafebabf && FAT_CIGAM_64==0xbfbafeca \
             && N_STAB==0xe0 && N_TYPE==0x0e && N_EXT==0x01 && N_SECT==0xe \
             && NO_SECT==0 && MAX_SECT==255 && DYNAMIC_LOOKUP_ORDINAL==0xfe \
             && CPU_TYPE_X86_64==0x01000007 && CPU_TYPE_ARM64==0x0100000c \
             && CPU_SUBTYPE_ARM64E==2 && CPU_SUBTYPE_X86_64_ALL==3)?1:-1];\n";
    for target in ALL_TARGETS {
        assert!(
            header_snippet_compiles(layout, target),
            "the Mach-O record layouts on {target:?}"
        );
    }
}

#[test]
fn vm_region_basic_info_keeps_the_kernel_packing() {
    use crate::Target;
    // <mach/vm_region.h> is 4-byte packed. Without it the 64-bit flavour
    // pads to 40 bytes and VM_REGION_BASIC_INFO_COUNT_64 reports 10, so
    // mach_vm_region would be handed a reply size the kernel rejects.
    let src = "#include <mach/vm_region.h>\n\
        int ck[(sizeof(vm_region_basic_info_data_64_t)==36 \
             && sizeof(vm_region_basic_info_data_t)==32 \
             && VM_REGION_BASIC_INFO_COUNT_64==9 \
             && VM_REGION_BASIC_INFO_COUNT==8 \
             && VM_REGION_BASIC_INFO_64==9 && VM_REGION_BASIC_INFO==10)?1:-1];\n";
    assert!(header_snippet_compiles(src, Target::MacOSAarch64));
}

#[test]
fn commoncrypto_random_is_bound_to_libsystem() {
    use crate::Target;
    // mimalloc's Unix layer reaches for both headers to draw entropy:
    // <AvailabilityMacros.h> puts MAC_OS_X_VERSION_MAX_ALLOWED past
    // 10.15, which selects CCRandomGenerateBytes over arc4random_buf.
    let src = "#include <AvailabilityMacros.h>\n\
        #include <CommonCrypto/CommonCryptoError.h>\n\
        #include <CommonCrypto/CommonRandom.h>\n\
        #include <stddef.h>\n\
        int ck[(sizeof(CCStatus)==4 && sizeof(CCCryptorStatus)==4 \
             && sizeof(CCRNGStatus)==4 \
             && kCCSuccess==0 && kCCParamError==-4300 \
             && kCCBufferTooSmall==-4301 && kCCRNGFailure==-4307 \
             && kCCInvalidKey==-4311 \
             && MAC_OS_X_VERSION_MAX_ALLOWED>=MAC_OS_X_VERSION_10_15)?1:-1];\n\
        int f(void *buf, size_t n) {\n\
            return CCRandomGenerateBytes(buf, n) == kCCSuccess; }\n";
    assert!(header_snippet_compiles(src, Target::MacOSAarch64));
    for target in [
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(
            !header_snippet_compiles(src, target),
            "the CommonCrypto surface must be absent on {target:?}"
        );
    }
}

#[test]
fn mach_time_declares_the_sdk_clock_set() {
    use crate::Target;
    // The SDK's declaration set, all bound to libSystem. The struct tag
    // and mach_timebase_info_t matter because callers spell the argument
    // either way.
    let src = "#include <mach/mach_time.h>\n\
        int ck[(sizeof(mach_timebase_info_data_t)==8 \
             && sizeof(struct mach_timebase_info)==8)?1:-1];\n\
        unsigned long long f(void) {\n\
            mach_timebase_info_data_t tb;\n\
            mach_timebase_info_t p = &tb;\n\
            mach_timebase_info(p);\n\
            mach_wait_until(mach_absolute_time());\n\
            return mach_absolute_time() * tb.numer / tb.denom\n\
                 + mach_approximate_time() + mach_continuous_time()\n\
                 + mach_continuous_approximate_time(); }\n";
    assert!(header_snippet_compiles(src, Target::MacOSAarch64));
    for target in [
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(
            !header_snippet_compiles(src, target),
            "the Mach clock surface must be absent on {target:?}"
        );
    }
}

#[test]
fn corevideo_umbrella_carries_the_time_types() {
    use crate::Target;
    // Sizes, offsets and values are what clang reports against the macOS
    // SDK. CVSMPTETime packs to 24 bytes on 4-byte alignment, which puts
    // CVTimeStamp's trailing two 64-bit words at 64 and 72.
    let src = "#include <CoreVideo/CoreVideo.h>\n\
        #include <stddef.h>\n\
        int ck[(sizeof(CVOptionFlags)==8 && sizeof(CVSMPTETimeType)==4 \
             && sizeof(CVSMPTETimeFlags)==4 && sizeof(CVTimeFlags)==4 \
             && sizeof(CVTimeStampFlags)==8 && sizeof(CVReturn)==4 \
             && sizeof(CVSMPTETime)==24 && sizeof(CVTime)==16 \
             && sizeof(CVTimeStamp)==80 \
             && offsetof(CVSMPTETime,counter)==4 \
             && offsetof(CVSMPTETime,hours)==16 \
             && offsetof(CVSMPTETime,frames)==22 \
             && offsetof(CVTime,timeScale)==8 && offsetof(CVTime,flags)==12 \
             && offsetof(CVTimeStamp,videoTime)==8 \
             && offsetof(CVTimeStamp,rateScalar)==24 \
             && offsetof(CVTimeStamp,smpteTime)==40 \
             && offsetof(CVTimeStamp,flags)==64 \
             && offsetof(CVTimeStamp,reserved)==72 \
             && kCVSMPTETimeType24==0 && kCVSMPTETimeType5994==7 \
             && kCVSMPTETimeValid==1 && kCVSMPTETimeRunning==2 \
             && kCVTimeIsIndefinite==1 \
             && kCVTimeStampVideoTimeValid==1 \
             && kCVTimeStampRateScalarValid==16 \
             && kCVTimeStampTopField==65536 \
             && kCVTimeStampBottomField==131072 \
             && kCVTimeStampVideoHostTimeValid==3 \
             && kCVTimeStampIsInterlaced==196608 \
             && kCVReturnSuccess==0 && kCVReturnFirst==-6660 \
             && kCVReturnError==-6660 && kCVReturnLast==-6699 \
             && kCVReturnInvalidArgument==-6661 \
             && kCVReturnUnsupported==-6663 \
             && kCVReturnDisplayLinkCallbacksNotSet==-6673 \
             && kCVReturnPixelBufferNotMetalCompatible==-6684 \
             && kCVReturnRetry==-6692)?1:-1];\n\
        enum _CVReturn tag_is_named;\n";
    assert!(header_snippet_compiles(src, Target::MacOSAarch64));
    // Every declaration sits behind __APPLE__, so no other target sees it.
    for target in [
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(
            !header_snippet_compiles(src, target),
            "the CoreVideo surface must be absent on {target:?}"
        );
    }
}

#[test]
fn corevideo_host_clock_is_bound_to_the_framework() {
    use crate::Target;
    // The only CoreVideo entry points the bundled set declares. Anything
    // else in the framework is left undeclared so a caller fails at the
    // link rather than against a stand-in.
    let src = "#include <CoreVideo/CVHostTime.h>\n\
        double f(CVTimeStamp *ts) {\n\
            ts->hostTime = CVGetCurrentHostTime();\n\
            ts->version = CVGetHostClockMinimumTimeDelta();\n\
            return CVGetHostClockFrequency(); }\n";
    assert!(header_snippet_compiles(src, Target::MacOSAarch64));

    let absent = "#include <CoreVideo/CoreVideo.h>\n\
        void f(void) { CVDisplayLinkRelease(0); }\n";
    assert!(
        !header_snippet_compiles(absent, Target::MacOSAarch64),
        "the display-link surface needs CoreGraphics types that are not bundled"
    );
}

#[test]
fn process_vm_transfers_are_a_linux_binding() {
    use crate::Target;
    // glibc declares the pair in <sys/uio.h> under __USE_GNU; no other
    // platform libc has a cross-address-space vectored transfer.
    let src = "#include <sys/uio.h>\n\
        long f(int pid, struct iovec *l, struct iovec *r) {\n\
            return process_vm_readv(pid, l, 1, r, 1, 0)\n\
                 + process_vm_writev(pid, l, 1, r, 1, 0); }\n";
    assert!(header_snippet_compiles(src, Target::LinuxX64));
    assert!(header_snippet_compiles(src, Target::LinuxAarch64));
    for target in [
        Target::MacOSAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(
            !header_snippet_compiles(src, target),
            "process_vm_readv must be absent on {target:?}"
        );
    }
}

#[test]
fn cpu_time_clocks_follow_each_platform_libc() {
    use crate::Target;
    // POSIX names the two CPU-time clocks but leaves the ids to the
    // implementation: libSystem's clockid_t enum numbers them 12 and 16,
    // glibc 2 and 3. Windows takes the glibc numbering, as the realtime
    // and monotonic ids already do.
    let apple = "#include <time.h>\n\
        int ck[(CLOCK_PROCESS_CPUTIME_ID==12 && CLOCK_THREAD_CPUTIME_ID==16)?1:-1];\n";
    let gnu = "#include <time.h>\n\
        int ck[(CLOCK_PROCESS_CPUTIME_ID==2 && CLOCK_THREAD_CPUTIME_ID==3)?1:-1];\n";
    assert!(header_snippet_compiles(apple, Target::MacOSAarch64));
    assert!(!header_snippet_compiles(gnu, Target::MacOSAarch64));
    for target in [
        Target::LinuxAarch64,
        Target::LinuxX64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(header_snippet_compiles(gnu, target), "{target:?}");
        assert!(!header_snippet_compiles(apple, target), "{target:?}");
    }
    // The three ids that were already defined keep their values.
    let common = "#include <time.h>\n\
        int ck[(CLOCK_REALTIME==0 && CLOCK_MONOTONIC_RAW==4 \
             && CLOCK_PROCESS_CPUTIME_ID!=CLOCK_THREAD_CPUTIME_ID)?1:-1];\n";
    for target in ALL_TARGETS {
        assert!(header_snippet_compiles(common, target), "{target:?}");
    }
}

#[test]
fn closefrom_is_a_linux_binding() {
    use crate::Target;
    // glibc exports closefrom from 2.34 on. libSystem has never had it --
    // the macOS SDK's <unistd.h> does not declare it -- and neither does
    // msvcrt, so declaring it there would bind a symbol the loader cannot
    // resolve.
    let src = "#include <unistd.h>\nvoid f(void) { closefrom(3); }\n";
    assert!(header_snippet_compiles(src, Target::LinuxX64));
    assert!(header_snippet_compiles(src, Target::LinuxAarch64));
    for target in [
        Target::MacOSAarch64,
        Target::WindowsX64,
        Target::WindowsAarch64,
    ] {
        assert!(
            !header_snippet_compiles(src, target),
            "closefrom must be absent on {target:?}"
        );
    }
}

#[test]
fn underscore_putenv_is_an_msvcrt_binding() {
    use crate::Target;
    // msvcrt spells POSIX putenv `_putenv`; code written against the CRT
    // uses that name directly. The Unix targets keep only `putenv`.
    let src = "#include <stdlib.h>\nint f(char *s) { return _putenv(s); }\n";
    assert!(header_snippet_compiles(src, Target::WindowsX64));
    assert!(header_snippet_compiles(src, Target::WindowsAarch64));
    for target in [Target::MacOSAarch64, Target::LinuxX64, Target::LinuxAarch64] {
        assert!(
            !header_snippet_compiles(src, target),
            "_putenv must be absent on {target:?}"
        );
    }
    // `putenv` itself stays available everywhere.
    let posix = "#include <stdlib.h>\nint f(char *s) { return putenv(s); }\n";
    for target in ALL_TARGETS {
        assert!(header_snippet_compiles(posix, target), "{target:?}");
    }
}

#[test]
fn sys_types_declares_time_t() {
    use crate::Target;
    // POSIX-2017 requires <sys/types.h> to define `time_t`; system
    // headers layered over it spell it in declarations without
    // including <time.h>. Either include order gives one 8-byte type.
    let alone = "#include <sys/types.h>\n\
                 int ck[(sizeof(time_t)==8 && sizeof(clock_t)==8)?1:-1];\n\
                 time_t stamp(time_t *p) { return *p; }\n";
    let after_time = "#include <time.h>\n#include <sys/types.h>\n\
                      int ck[(sizeof(time_t)==8)?1:-1];\n";
    let before_time = "#include <sys/types.h>\n#include <time.h>\n\
                       int ck[(sizeof(time_t)==8)?1:-1];\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64, Target::MacOSAarch64] {
        assert!(
            header_snippet_compiles(alone, target),
            "alone on {target:?}"
        );
        assert!(
            header_snippet_compiles(after_time, target),
            "<time.h> first on {target:?}"
        );
        assert!(
            header_snippet_compiles(before_time, target),
            "<sys/types.h> first on {target:?}"
        );
    }
}

#[test]
fn posix_line_input_and_string_declarations() {
    use crate::Target;
    // POSIX.1-2008 `getline` / `getdelim` / `dprintf`, the XSI and GNU
    // `strerror_r`, and the BSD/GNU `strcasestr` / `bcmp` / `bcopy`.
    // Declarations only; the symbols come from the target C library.
    let src = "#include <stdio.h>\n#include <string.h>\n\
        long rd(FILE *f, char **p, size_t *n) { return getline(p, n, f); }\n\
        long rdd(FILE *f, char **p, size_t *n) { return getdelim(p, n, ':', f); }\n\
        int say(int fd) { return dprintf(fd, \"%d\\n\", 1); }\n\
        char *find(const char *h, const char *n) { return strcasestr(h, n); }\n\
        int cmp(const void *a, const void *b) { return bcmp(a, b, 4); }\n\
        void cpy(const void *a, void *b) { bcopy(a, b, 4); }\n";
    // Two incompatible return types share the name `strerror_r`: the XSI
    // form returns int, the GNU one (under _GNU_SOURCE) the message.
    let xsi = "#include <string.h>\nint e(char *b) { return strerror_r(2, b, 8); }\n";
    let gnu = "#define _GNU_SOURCE\n#include <string.h>\n\
               char *e(char *b) { return strerror_r(2, b, 8); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64, Target::MacOSAarch64] {
        assert!(
            header_snippet_compiles(src, target),
            "declarations on {target:?}"
        );
        assert!(
            header_snippet_compiles(xsi, target),
            "XSI strerror_r on {target:?}"
        );
    }
    assert!(
        header_snippet_compiles(gnu, Target::LinuxX64),
        "GNU strerror_r on linux-x64"
    );
}

#[test]
fn cdefs_confines_darwin_decorations_to_darwin() {
    use crate::Target;
    // `__used` and friends come from Darwin's <sys/cdefs.h>. Defining
    // them elsewhere rewrites identifiers in system headers that spell
    // them as ordinary names -- a C library's <regex.h> declares a
    // struct member `__used`.
    let member = "#include <sys/cdefs.h>\n\
                  struct b { unsigned long __used; unsigned long __unused; };\n\
                  unsigned long get(struct b *p) { return p->__used + p->__unused; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64, Target::WindowsX64] {
        assert!(
            header_snippet_compiles(member, target),
            "`__used` must stay an ordinary identifier on {target:?}"
        );
    }
    // On Darwin the decoration is part of the platform header surface.
    let decorated = "#include <sys/cdefs.h>\nstatic int x __used;\n";
    assert!(
        header_snippet_compiles(decorated, Target::MacOSAarch64),
        "macOS keeps __used defined"
    );
}

#[test]
fn struct_member_keeps_its_own_name_space() {
    // C99 6.2.3: members live in a name space separate from ordinary
    // identifiers. A member declarator reusing an object's name must
    // leave that object's declaration -- here a two-dimensional array's
    // shape -- untouched, or the later subscript loses its stride.
    assert_eq!(
        run_str(
            "static const short nxt[][3] = { {1,2,3}, {4,5,6} };\n\
             struct info { int verify; int nxt; };\n\
             int main(void) { struct info i; i.nxt = 6;\n\
                 if (sizeof nxt / sizeof nxt[0] != 2) return 1;\n\
                 return nxt[1][2] * 6 + i.nxt; }"
        ),
        42
    );
}

#[test]
fn integer_constant_added_to_an_address_constant() {
    // C99 6.6p9: an address constant may have an integer constant
    // expression added to it in either order. A leading integer term --
    // including a cast or a `sizeof` of an anonymous bitfield struct,
    // the shape a compile-time type assertion expands to -- must still
    // leave a relocation in the slot.
    assert_eq!(
        run_str(
            "struct opts { int a; int b; };\n\
             static struct opts opts;\n\
             struct row { void *value; };\n\
             static struct row r[] = {\n\
                 { .value = &opts.b + 0 },\n\
                 { .value = 0 + &opts.b },\n\
                 { .value = (int)(sizeof(struct { int : (-!!0); })) + &opts.b },\n\
             };\n\
             int main(void) {\n\
                 if (r[0].value != &opts.b) return 1;\n\
                 if (r[1].value != r[0].value) return 2;\n\
                 if (r[2].value != r[0].value) return 3;\n\
                 return 42; }"
        ),
        42
    );
}

//! End-to-end JIT tests. The lowering and relocation paths are the
//! same as the AOT ELF backend (see [`super::native_elf`] /
//! [`super::native_elf_x64`]); the only thing that's different is
//! how the produced code is loaded -- mmap + mprotect + a transmuted
//! function pointer, instead of an ELF on disk + exec.
//!
//! Gated to the OS / arch combinations where `jit_run` is
//! implemented: Linux (aarch64 + x86_64) and macOS arm64. The
//! `host_target()` helper inside `jit.rs` picks the right backend
//! at runtime, so the test body is platform-agnostic.
//!
//! Output from the JIT'd program (printf, etc.) goes to the test
//! process's stdout. Tests assert only on the exit code, so the
//! interleaving with `cargo test`'s output is cosmetic.

#![cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]

use super::fixture_tables::{JIT_FIXTURES, JIT_UNSUPPORTED_FIXTURES};
use crate::{Compiler, NativeOptions, jit_run, jit_run_with_options};

/// Compile `src` and run it through the JIT with `args` as argv.
/// Panics on compile or JIT-load failure -- the call sites here
/// expect both phases to succeed.
fn jit_exit(src: &str, args: &[&str]) -> i32 {
    let program = Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile failed");
    let argv: Vec<String> = args.iter().map(|s| s.to_string()).collect();
    jit_run(&program, &argv).expect("jit_run failed")
}

/// JIT-run with the native optimizer on (the same pipeline that
/// `--optimize` / `-O` triggers from the CLI). Used to guard parity
/// between the default and optimized lowerings.
fn jit_exit_native_optimized(src: &str, args: &[&str]) -> i32 {
    let program = Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile failed");
    let argv: Vec<String> = args.iter().map(|s| s.to_string()).collect();
    let opts = NativeOptions::new().with_optimize();
    jit_run_with_options(&program, &argv, opts).expect("jit_run_with_options failed")
}

// ---- Smoke tests, same shapes as src/c5/tests/native_elf.rs but
//      driven through the JIT loader. ----

#[test]
fn return_42() {
    assert_eq!(jit_exit("int main() { return 42; }", &["jit-ret42"]), 42);
}

/// Raw-byte inline asm executes natively: the literal bytes `B8 25 00 00 00`
/// are `mov eax, 0x25`, and the `"=a"` output ties the result to the return
/// value. x86_64 host only -- the bytes are x86 machine code, and the VM
/// (which cannot model opaque bytes) is bypassed by the JIT path.
#[cfg(target_arch = "x86_64")]
#[test]
fn raw_byte_inline_asm_executes() {
    let src = r#"
        int main() {
            int x = 1;
            __asm__ volatile(".byte 0xb8, 0x25, 0x00, 0x00, 0x00" : "=a"(x));
            return x;
        }
    "#;
    assert_eq!(jit_exit(src, &["jit-raw-bytes"]), 0x25);
}

#[test]
fn external_int_return_is_sign_extended() {
    // C99 6.3.1.1 + AAPCS64: a callee returning `int` leaves only the low
    // 32 bits defined; the caller must extend the result before using it
    // at 64-bit width. c5 keeps accumulator values extended to 64 bits and
    // its own callees honour that, but an external (defined-elsewhere)
    // callee compiled by another toolchain need not, so a narrow return
    // used at 64 bits must be extended at the call site. libc `atoi`
    // (resolved via dlsym) returns -1 for "-1"; the `== -1` compare is a
    // 64-bit signed compare and fails unless the result is sign-extended.
    let src = "int atoi(const char *); \
               int main(void) { return atoi(\"-1\") == -1 ? 0 : 1; }";
    assert_eq!(jit_exit(src, &["t"]), 0);
    assert_eq!(jit_exit_native_optimized(src, &["t"]), 0);
}

#[test]
fn dead_branch_call_to_undefined_symbol_is_pruned() {
    // At -O, `constfold_branch` folds `if (0)` to an unconditional jump
    // and `prune_unreachable` deletes the orphaned arm, so the
    // never-taken call to the undefined `u` produces no reference and
    // the program loads and runs. Without the prune the JIT loader
    // would fail to resolve `u`.
    let src = "extern void u(void); int main(void) { if (0) { u(); } return 7; }";
    assert_eq!(
        jit_exit_native_optimized(src, &["jit-dead-branch-prune"]),
        7
    );
}

#[test]
fn struct_returning_always_inline_folds_parameter_guards() {
    // A struct-returning always_inline helper is spliced at every call
    // site, so its parameter-dependent guard folds per site and the
    // never-taken call to the undefined `bug` leaves no reference. The
    // returned fields then reach the caller as constants -- including
    // `r.reg`, read past an intervening call and a branch, which decides
    // a switch whose default arm also calls `bug`. Without either fold
    // the JIT loader would fail to resolve `bug`.
    let src = "
        extern void bug(void);
        struct R { unsigned function; int reg; };
        static const struct R table[2] = { {1u, 3}, {7u, 1} };
        static __attribute__((always_inline)) struct R reg_of(unsigned f) {
            unsigned leaf = f / 32u;
            if (leaf >= 2u) bug();
            if (table[leaf].function == 0u) bug();
            return table[leaf];
        }
        int pick(const int *e, int reg);
        int pick(const int *e, int reg) { return e[reg & 3]; }
        static __attribute__((always_inline)) int probe(const int *e, unsigned f) {
            const struct R r = reg_of(f);
            int slot = pick(e, (int)r.function);
            if (slot < 0) return -1;
            switch (r.reg) {
            case 1: return slot + 1;
            case 3: return slot + 3;
            default: bug(); return 0;
            }
        }
        int main(void) {
            static const int e[4] = {10, 20, 30, 40};
            return probe(e, 0u) + probe(e, 32u) == (20 + 3) + (40 + 1) ? 5 : 1;
        }
    ";
    assert_eq!(jit_exit_native_optimized(src, &["jit-struct-ret-guard"]), 5);
}

#[test]
fn always_inline_callee_passing_an_aggregate_by_value_is_spliced() {
    // A body that hands a structure to another function by value is
    // still inlinable: the argument address is one more value operand
    // and the callee's aggregate layout re-interns into the caller. The
    // request here is mandatory, and honouring it is what folds the
    // per-site guards on the constant `sr` -- the undefined `bug` would
    // otherwise fail the JIT load.
    //
    // The nested call takes both a register-class aggregate and one the
    // System V AMD64 classification puts in memory, which the caller
    // copies to its outgoing argument area. Only the callee's own
    // parameters have to pass by value in registers for the splice to
    // redirect their frame copies; what a nested call marshals is the
    // per-arch call plan's business, out of line or inlined alike. Both
    // must arrive at `sink` intact.
    let src = "
        extern void bug(void);
        struct resx { unsigned long lo, hi; };
        struct wide { unsigned long w[5]; };
        struct ctx { unsigned long v[4]; };
        static unsigned long seen_lo, seen_hi, seen_w;
        void sink(struct ctx *c, int sr, struct resx r, struct wide w);
        void sink(struct ctx *c, int sr, struct resx r, struct wide w) {
            c->v[sr] = r.lo + r.hi + (unsigned long) sr;
            seen_lo = r.lo;
            seen_hi = r.hi;
            seen_w = w.w[0] + w.w[1] + w.w[2] + w.w[3] + w.w[4];
        }
        static __attribute__((always_inline))
        void set_masks(struct ctx *c, int sr, struct resx r,
                       const struct wide *wp) {
            if (!__builtin_constant_p(sr)) bug();
            if (sr < 0 || sr >= 4) bug();
            sink(c, sr, r, *wp);
        }
        int main(void) {
            struct ctx c = {{0, 0, 0, 0}};
            struct resx r = {10ul, 20ul};
            struct wide w = {{1ul, 2ul, 3ul, 4ul, 5ul}};
            set_masks(&c, 0, r, &w);
            set_masks(&c, 1, r, &w);
            set_masks(&c, 2, r, &w);
            set_masks(&c, 3, r, &w);
            if (seen_lo != 10ul || seen_hi != 20ul || seen_w != 15ul) return 1;
            for (int i = 0; i < 4; i++)
                if (c.v[i] != 30ul + (unsigned long) i) return 2;
            return 9;
        }
    ";
    assert_eq!(jit_exit_native_optimized(src, &["jit-agg-arg-inline"]), 9);
}

#[test]
fn always_inline_callee_returning_a_large_struct_is_spliced() {
    // A callee returning an aggregate too large for the return registers
    // gets a caller-provided destination -- the hidden out-pointer
    // argument (System V AMD64 MEMORY class, Win64 over the by-value
    // size) or the indirect-result register (AAPCS64 above 16 bytes).
    // Both are mandatory-request shapes the splice has to reproduce.
    //
    // `mk_state` also reaches its result through another function, which
    // has to see the redirected destination, and `wrap` returns the
    // result of a second by-address callee -- the nested shape whose
    // whole-object copy the splice drops.
    //
    // The guards call a defined `bug` rather than an undefined one so the
    // values are checked at whatever register budget is in effect: which
    // of them fold is the scalar-promotion budget's business (see the
    // linker test), while the value each field carries is not.
    let src = "
        static int bug_calls;
        static void bug(void) { bug_calls++; }
        struct state { void *base; void *table; unsigned long span;
                       unsigned long off; unsigned int level;
                       unsigned short idx; unsigned char kind; };
        static void tag(struct state *s, unsigned char k) { s->kind = k; }
        static __attribute__((always_inline))
        struct state mk_state(void *base, unsigned int level) {
            struct state s = { .base = base, .level = level, .span = 4096ul };
            tag(&s, 7);
            return s;
        }
        static __attribute__((always_inline))
        struct state wrap(void *base) { return mk_state(base, 0u); }
        static unsigned long sink;
        int main(void) {
            struct state a = mk_state(&sink, 3u);
            if (a.level != 3u) bug();
            if (a.kind != 7) bug();
            if (a.span != 4096ul) bug();
            if (a.table != 0 || a.off != 0ul || a.idx != 0) bug();
            struct state b = wrap(&sink);
            if (b.level != 0u) bug();
            if (b.base != (void *) &sink) bug();
            sink = a.span + b.span + a.level + a.kind;
            if (sink != 4096ul + 4096ul + 3ul + 7ul) bug();
            return bug_calls == 0 ? 6 : 2;
        }
    ";
    assert_eq!(jit_exit_native_optimized(src, &["jit-sret-inline"]), 6);
}

#[test]
fn a_dominating_condition_decides_the_comparison_it_implies() {
    // Three shapes whose answer follows from the condition guarding the
    // block rather than from any immediate: a loop guard settling the
    // sign of the induction variable (the query a widely used min()/max()
    // macro set puts to `__builtin_constant_p`), a masked switch operand
    // whose value set the labels cover, and an enumerated state the loop
    // condition excludes. The undefined `bug` fails the JIT load if any
    // guarded arm survives.
    let src = "
        extern void bug(void);
        #define statically_true(x) (__builtin_constant_p(x) && (x))
        #define is_signed_type(type) (((type)(-1)) < (type)1)
        #define __is_nonneg(ux) statically_true((long long)(ux) >= 0)
        #define __sign_use(ux) (is_signed_type(typeof(ux)) ? \
            (2 + __is_nonneg(ux)) : (1 + 2 * (sizeof(ux) < 4)))
        #define __types_ok(ux, uy) (__sign_use(ux) & __sign_use(uy))
        #define MIN(x, y) ({                    \
            __auto_type ux = (x);               \
            __auto_type uy = (y);               \
            if (!__types_ok(ux, uy)) bug();     \
            ux < uy ? ux : uy;                  \
        })
        static unsigned long chunks;
        static void drain(int len) {
            while (len > 0) {
                unsigned int n = MIN(len, 4096UL);
                chunks += n;
                len -= n;
            }
        }
        static int masked(unsigned int flags) {
            switch (flags & 3u) {
            case 0: return 10;
            case 1: return 20;
            case 2: return 30;
            case 3: return 40;
            default: bug(); return 0;
            }
        }
        static int stage(int v) {
            if (v > 4) {
                if (v <= 4) bug();
                if (v < 0) bug();
                return 1;
            }
            if (v > 4) bug();
            return 0;
        }
        int main(void) {
            drain(10000);
            if (chunks != 10000ul) return 1;
            if (masked(0u) != 10 || masked(5u) != 20) return 2;
            if (masked(6u) != 30 || masked(7u) != 40) return 3;
            if (stage(9) != 1 || stage(4) != 0) return 4;
            return 7;
        }
    ";
    assert_eq!(jit_exit_native_optimized(src, &["jit-implied-cmp"]), 7);
}

#[test]
fn a_taken_branch_says_its_condition_is_nonzero_not_one() {
    // A branch tests its condition against zero, so the taken edge says
    // only that the value is not zero. Reading it as 1 would decide the
    // comparisons below wrongly -- a masked flag word arrives holding
    // the mask, and a subtraction arrives holding whatever it computed.
    let src = "
        static int sink;
        static volatile unsigned int in_u;
        static volatile int in_a, in_b;
        int flags(void);
        int flags(void) {
            unsigned int m = in_u & 0x24u;
            if (m) {
                if (m == 1u) sink |= 1;
                if (m > 0x24u) sink |= 2;
                return (int) m;
            }
            return 0;
        }
        int spread(void);
        int spread(void) {
            int d = in_a - in_b;
            if (d) {
                if (d == 1) sink |= 4;
                if (d < -100 || d > 100) return 99;
                return d;
            }
            return 0;
        }
        int main(void) {
            in_u = 0xffu; if (flags() != 0x24) return 1;
            in_u = 0x20u; if (flags() != 0x20) return 2;
            in_u = 0x04u; if (flags() != 4) return 3;
            in_u = 0x08u; if (flags() != 0) return 4;
            in_a = 10; in_b = 3;   if (spread() != 7) return 5;
            in_a = 3;  in_b = 10;  if (spread() != -7) return 6;
            in_a = 5;  in_b = 5;   if (spread() != 0) return 7;
            in_a = 500; in_b = 1;  if (spread() != 99) return 8;
            if (sink != 0) return 9;
            return 6;
        }
    ";
    assert_eq!(jit_exit_native_optimized(src, &["jit-nonzero-cond"]), 6);
}

#[test]
fn select_of_two_constants_folds_its_guard() {
    // A value produced by a runtime `?:` between two constants keeps a
    // guard on it live unless the guard is evaluated per incoming: the
    // comparison `> 3ul` is false for both 1 and 0, and the mask selects
    // neither the bit the two arms differ in nor any bit either sets, so
    // the build-time asserts are unreachable whichever arm runs -- also
    // through a nested `?:`, whose value set is the union of both levels.
    // The undefined `bug` would fail the JIT load if any survived.
    let src = "
        extern void bug(void);
        #define BUILD_BUG_ON(c) do { if (!(!(c))) bug(); } while (0)
        static __attribute__((always_inline)) unsigned long
        encode(unsigned long page, unsigned long flags) {
            BUILD_BUG_ON(flags > 3ul);
            return flags | page;
        }
        static int delay_rmap;
        unsigned long add_page(unsigned long page);
        unsigned long add_page(unsigned long page) {
            return encode(page, delay_rmap ? 1ul : 0ul);
        }
        static unsigned long personality;
        #define DATA_FLAGS (0x1ul | 0x2ul | ((personality & 0x400000ul) ? 0x4ul : 0ul) \
                            | 0x10ul | 0x20ul | 0x40ul)
        #define STACK_FLAGS (0x100ul | DATA_FLAGS | 0x100000ul)
        static unsigned long stack_flags(void) {
            BUILD_BUG_ON(STACK_FLAGS & (0x10000ul | 0x8000ul));
            return STACK_FLAGS;
        }
        static int tier;
        static unsigned long tier_bits(void) {
            unsigned long v = tier ? (delay_rmap ? 1ul : 2ul) : 3ul;
            BUILD_BUG_ON(v > 3ul);
            BUILD_BUG_ON(v == 0ul);
            return v;
        }
        int main(void) {
            delay_rmap = 0;
            if (add_page(0x1000ul) != 0x1000ul) return 1;
            delay_rmap = 1;
            if (add_page(0x1000ul) != 0x1001ul) return 2;
            personality = 0ul;
            if (stack_flags() != 0x100173ul) return 3;
            personality = 0x400000ul;
            if (stack_flags() != 0x100177ul) return 4;
            tier = 1;
            if (tier_bits() != 1ul) return 5;
            delay_rmap = 0;
            if (tier_bits() != 2ul) return 7;
            tier = 0;
            if (tier_bits() != 3ul) return 8;
            return 6;
        }
    ";
    assert_eq!(jit_exit_native_optimized(src, &["jit-select-guard"]), 6);
}

#[test]
fn const_trip_loop_unrolls_so_its_index_folds_a_guard() {
    // A counted loop with a constant trip count hands its induction
    // variable to an always_inline helper that asserts the index is in
    // range. The guard resolves only once each iteration's index is a
    // literal, which full unrolling produces. The body is wide enough
    // (five member stores through an array-of-struct subscript reached
    // via a pointer parameter, plus two calls) that gating on the
    // rolled body size instead of on the expansion keeps it rolled and
    // leaves the undefined `bug`, which would fail the JIT load. The
    // exit code checks the values the copies compute, including the
    // rolled loop's over a runtime bound.
    let src = "
        extern void bug(void);
        #define BUILD_BUG_ON(c) do { if (!(!(c))) bug(); } while (0)
        #define NR_FIXED 3
        #define BASE_IDX 32
        struct counter {
            unsigned int kind; unsigned int idx; unsigned long long count;
            unsigned long long eventsel; void *event; void *owner;
            unsigned long long config;
        };
        struct bank { struct counter fixed[NR_FIXED]; };
        static const int event_ids[NR_FIXED] = { 11, 22, 33 };
        static __attribute__((always_inline)) unsigned long long sel_of(unsigned int i) {
            BUILD_BUG_ON(i >= NR_FIXED);
            return (unsigned long long)event_ids[i] << 8;
        }
        static __attribute__((always_inline)) unsigned int slot_of(unsigned int i) {
            BUILD_BUG_ON(BASE_IDX + i >= 64u);
            return i + BASE_IDX;
        }
        static void bank_init(struct bank *b, void *owner) {
            int i;
            for (i = 0; i < NR_FIXED; i++) {
                b->fixed[i].kind = 2;
                b->fixed[i].owner = owner;
                b->fixed[i].idx = slot_of((unsigned int)i);
                b->fixed[i].config = 0;
                b->fixed[i].eventsel = sel_of((unsigned int)i);
            }
        }
        static int runtime_bound = NR_FIXED;
        static struct bank the_bank;
        int main(void) {
            int i; unsigned long long acc = 0, rolled = 0; static char token;
            bank_init(&the_bank, &token);
            for (i = 0; i < NR_FIXED; i++) {
                if (the_bank.fixed[i].kind != 2) return 1;
                if (the_bank.fixed[i].owner != &token) return 2;
                if (the_bank.fixed[i].idx != (unsigned int)(i + BASE_IDX)) return 3;
                if (the_bank.fixed[i].config != 0) return 4;
                acc += the_bank.fixed[i].eventsel;
            }
            if (acc != ((11ull + 22ull + 33ull) << 8)) return 5;
            for (i = 0; i < runtime_bound; i++)
                rolled += (unsigned long long)event_ids[i] << 8;
            if (rolled != acc) return 6;
            return 9;
        }
    ";
    assert_eq!(jit_exit_native_optimized(src, &["jit-unroll-guard"]), 9);
}

#[test]
fn const_scalar_load_folds_to_its_initializer() {
    // C99 6.7.3p5: modifying an object defined with a const-qualified
    // type is undefined, so a file-scope `const` scalar's load folds to
    // its initializer and a guard on it resolves -- including the
    // zero-initialized flag, whose object the data compaction moves to
    // the zero-filled bss region, and a block-scope static, whose object
    // model is the same. The qualifier must reach the object:
    // `const char *names[2]` has writable elements, so `names[0]` keeps
    // its load and observes the store. The undefined `bug` would fail
    // the JIT load if any guard survived.
    let src = "
        extern void bug(void);
        #define BUILD_BUG_ON(c) do { if (!(!(c))) bug(); } while (0)
        static const _Bool is_conditional = 1;
        static const _Bool is_unconditional = 0;
        static const int depth = 3;
        static const unsigned char kind = 200;
        static const long mask = -4;
        static int guard(void) {
            BUILD_BUG_ON(!is_conditional);
            BUILD_BUG_ON(is_unconditional);
            BUILD_BUG_ON(depth != 3);
            BUILD_BUG_ON(kind != 200);
            BUILD_BUG_ON(mask >= 0);
            return depth;
        }
        static int block_guard(void) {
            static const _Bool outer = 1;
            { static const int inner = 5; BUILD_BUG_ON(inner != 5); }
            BUILD_BUG_ON(!outer);
            return 5;
        }
        static const char *names[2] = {(const char *)1, (const char *)2};
        static long first(void) { return (long)names[0]; }
        int main(void) {
            if (guard() != 3) return 1;
            if (block_guard() != 5) return 2;
            if (first() != 1) return 3;
            names[0] = (const char *)99;
            if (first() != 99) return 4;
            return 8;
        }
    ";
    assert_eq!(jit_exit_native_optimized(src, &["jit-const-scalar"]), 8);
}

#[test]
fn return_zero() {
    assert_eq!(jit_exit("int main() { return 0; }", &["jit-ret0"]), 0);
}

#[test]
fn constructors_run_before_main_in_priority_order() {
    // The JIT runs `__attribute__((constructor))` functions before the
    // entry, ordered as `.init_array` does (prioritized ascending, then
    // unprioritized). `main` returns an encoding of the observed order.
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
    assert_eq!(jit_exit(src, &["jit-ctor-order"]), 123);
}

#[test]
fn destructor_runs_through_atexit_chain() {
    // The JIT registers destructors on its atexit chain, drained after
    // main. A destructor that observably runs would need stdout capture;
    // here assert the program with a constructor + destructor completes
    // and returns the constructor-set value (the destructor drains
    // without disturbing the exit code).
    let src = "
        static int n;
        __attribute__((constructor)) static void ctor(void) { n = 9; }
        __attribute__((destructor)) static void dtor(void) { n = 0; }
        int main(void) { return n; }
    ";
    assert_eq!(jit_exit(src, &["jit-dtor"]), 9);
}

#[test]
fn arithmetic_and_locals() {
    let src = r#"
        int main() {
            int x;
            x = 41;
            x = x + 1;
            return x;
        }
    "#;
    assert_eq!(jit_exit(src, &["jit-locals"]), 42);
}

#[test]
fn while_loop_terminates() {
    let src = r#"
        int main() {
            int i;
            int s;
            i = 0;
            s = 0;
            while (i < 10) {
                s = s + i;
                i = i + 1;
            }
            return s;
        }
    "#;
    assert_eq!(jit_exit(src, &["jit-while"]), 45);
}

/// Cross-block reassigned loop counter: `i` is stored at the for-
/// init block and re-stored in the post (step) block; its load in
/// the head block sees two reaching defs and would otherwise stay
/// in the frame slot. With phi promotion the slot promotes
/// through an `Inst::Phi` at the head block; the per-arch emit
/// places the predecessor-exit moves before each branch so the
/// counter survives in a register.
///
/// Locks three things at once:
/// 1. With the gate off, the SSA IR for `main` contains no
///    `Inst::Phi` for the counter slot (the slot stays in memory).
/// 2. With the gate on, the same source produces at least one
///    `Inst::Phi` in `main`'s IR -- proving the rename actually
///    inserted the merge rather than falling back to the
///    in-memory slot.
/// 3. The compiled-and-run program returns the expected sum
///    (0 + 1 + ... + 9 = 45) under both modes -- proving the
///    per-arch lowering of `Inst::Phi` plus the predecessor-exit
///    moves still evaluates the loop correctly.
#[test]
#[cfg(feature = "std")]
fn while_loop_promotes_counter_through_phi_under_phi_promote() {
    use crate::Target;
    use crate::c5::codegen::ssa::shadow::produce_ssa_funcs;
    let src = r#"
        int main() {
            int i;
            int s;
            i = 0;
            s = 0;
            while (i < 10) {
                s = s + i;
                i = i + 1;
            }
            return s;
        }
    "#;
    let count_phis_in_main = || -> usize {
        let program = Compiler::new(super::with_prelude(src))
            .compile()
            .expect("compile failed");
        let mut funcs =
            produce_ssa_funcs(&program, Target::host(), false, true).expect("produce_ssa_funcs");
        for f in &mut funcs {
            crate::c5::codegen::ssa::mem2reg::run(f);
        }
        let main = funcs
            .iter()
            .find(|f| f.name == "main")
            .expect("main not found");
        main.insts
            .iter()
            .filter(|i| matches!(i, crate::c5::ir::Inst::Phi { .. }))
            .count()
    };
    // Scope the promotion flag to the current test thread so a
    // concurrent test on a different thread is not affected.
    let phis_off =
        crate::c5::codegen::ssa::mem2reg::with_phi_promote_override(false, count_phis_in_main);
    let (phis_on, result) =
        crate::c5::codegen::ssa::mem2reg::with_phi_promote_override(true, || {
            (
                count_phis_in_main(),
                jit_exit_native_optimized(src, &["jit-phi-promote"]),
            )
        });
    assert_eq!(
        phis_off, 0,
        "no Inst::Phi expected in main's IR with phi promotion forced off"
    );
    // The loop has two cross-block reassigned scalars (`i` and
    // `s`); the IDF places exactly one phi per slot at the loop
    // header, so the post-rename count is two.
    assert_eq!(
        phis_on, 2,
        "phi promotion expected exactly 2 Inst::Phi in main \
         (one each for `i` and `s` at the loop header); got {phis_on}",
    );
    assert_eq!(result, 45);
}

#[test]
fn function_call_returns_value() {
    let src = r#"
        int square(int n) { return n * n; }
        int main() { return square(6) + square(2); }
    "#;
    assert_eq!(jit_exit(src, &["jit-fncall"]), 40);
}

#[test]
fn recursion_factorial() {
    let src = r#"
        int fact(int n) {
            if (n < 2) return 1;
            return n * fact(n - 1);
        }
        int main() { return fact(5); }
    "#;
    assert_eq!(jit_exit(src, &["jit-fact"]), 120);
}

/// Regression for the dead-phi predecessor-exit move collision under
/// phi promotion. This is a reduced getline-style shape: a loop with
/// several loop-carried scalars (`zLine` pointer, `nLine`, `n`) and
/// multiple exit edges, so the
/// function-exit block is a join carrying a phi for every scalar.
/// Only `zLine` is returned; the phis for `nLine` and `n` at the join
/// are dead. A naive allocator reuses one register across those dead
/// phis and the live `zLine` phi (the dead ranges are empty), so their
/// predecessor-exit moves clobber the return register -- the function
/// returns `nLine` (100) instead of `zLine`. The interference-checked
/// phi congruence coalesces each dead phi into its own operand class
/// (a dead phi interferes with nothing), turning its exit-moves into
/// dropped self-moves, so the return register is never clobbered.
/// Without the fix the returned pointer is the small integer 100 and
/// the guard below returns 2; with it the round-trip returns 0.
#[test]
#[cfg(feature = "std")]
fn dead_phi_exit_move_does_not_clobber_return_under_phi_promote() {
    let src = r#"
        char *getline_like(char *zLine, char *src) {
            int nLine = zLine == 0 ? 0 : 100;
            int n = 0;
            int slen = 0;
            while (src[slen]) slen++;
            while (1) {
                if (n + 100 > nLine) {
                    nLine = nLine * 2 + 100;
                    zLine = realloc(zLine, nLine);
                    if (zLine == 0) return 0;
                }
                int k = 0;
                while (src[n + k] && k < 99) { zLine[n + k] = src[n + k]; k++; }
                zLine[n + k] = 0;
                if (n + k >= slen) { n += k; break; }
                n += k;
            }
            return zLine;
        }
        int main() {
            char *r = getline_like(0, "abcdefghij");
            if (r == 0) return 1;
            if (((long)r) < 4096) return 2;
            if (r[0] != 'a') return 3;
            if (r[9] != 'j') return 4;
            return 0;
        }
    "#;
    let result = crate::c5::codegen::ssa::mem2reg::with_phi_promote_override(true, || {
        jit_exit_native_optimized(src, &["jit-dead-phi"])
    });
    assert_eq!(result, 0, "dead-phi exit-move clobbered the return value");
}

#[test]
fn phi_predecessor_parallel_copy_handles_reg_spill_conflict() {
    // The phi predecessor-exit copy must schedule register and
    // spill-slot operands as one parallel copy. A phi whose
    // destination is a spill slot and whose source is a register can
    // otherwise have that source register clobbered by a sibling phi's
    // reg-to-reg move emitted in a separate pass. The SHA-512-shaped
    // loop in ssa_call_result_spill.c, compiled with the integer bank
    // capped to three registers per class, forces eight loop-carried
    // u64 phis to span both registers and spill slots and reproduces
    // the conflict on both backends.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("ssa_call_result_spill.c");
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(3, 2, || {
        jit_exit(&src, &["phi-parallel-copy"])
    });
    assert_eq!(
        result, 0,
        "phi parallel copy clobbered a spilled loop-carried value under register pressure"
    );
}

#[test]
fn spill_slot_beyond_imm12_reach() {
    // aarch64 LDR/STR (unsigned offset) reaches a byte displacement of
    // `4095 * size`; for 8-byte spill slots that caps SP-relative
    // access at 0x7FF8. A function that spills more than ~4096 values
    // pushes its lowest-numbered (deepest) spill slots past that reach.
    // The encoders only `debug_assert` the bound, so in release the
    // scaled imm12 overflowed into the opcode's load/store bit and a
    // spill store silently became a load (and vice versa), leaving the
    // slot uninitialised. The SP-relative spill helpers now materialise
    // the base into a scratch register for out-of-reach offsets.
    //
    // With the integer bank capped to one register, every local spills,
    // producing well over 4096 slots. The function stores each local to
    // its slot, then reloads all of them in a sum -- exercising the
    // store-to-slot and reload-from-slot paths at out-of-reach offsets.
    const N: u64 = 5000;
    let mut src = String::from("long f() {\n");
    for i in 0..N {
        src.push_str(&format!("  long a{i} = {};\n", i + 1));
    }
    src.push_str("  long s = 0;\n");
    for i in 0..N {
        src.push_str(&format!("  s = s + a{i};\n"));
    }
    // Sum of 1..=N. Return a small sentinel so the value survives the
    // exit-code byte truncation while still depending on every slot.
    let expected: u64 = N * (N + 1) / 2;
    src.push_str(&format!("  return s == {expected} ? 7 : 0;\n"));
    src.push_str("}\n");
    src.push_str("int main() { return (int)f(); }\n");
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit_native_optimized(&src, &["spill-imm12-reach"])
    });
    assert_eq!(
        result, 7,
        "an out-of-reach spill slot was accessed with a corrupt LDR/STR encoding"
    );
}

#[test]
fn modulo_with_spilled_divisor_under_pressure() {
    // The modulo lowering computes `rem = n - (n / d) * d`. The
    // quotient must occupy a register distinct from the divisor; when
    // the divisor spills and is reloaded into a scratch register, the
    // divide must not reuse that same register for the quotient, or the
    // multiply reads the quotient as the divisor and computes
    // `n - (n/d) * (n/d)`. With the integer bank capped to one register
    // per class the constant divisor spills, reproducing the conflict.
    let src = r#"
        int main() {
            int s = 0;
            int i;
            for (i = 0; i < 6; i++) {
                if (i % 2 == 1) s = s + i;
            }
            return s; // 1 + 3 + 5 = 9
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["mod-spill"])
    });
    assert_eq!(
        result, 9,
        "modulo lowering reused the divisor's reload register for the quotient under pressure"
    );
}

#[test]
fn fp_param_incoming_reg_clobber_under_pressure() {
    // Each Inst::ParamRef reads its incoming FP argument register, which
    // stays live from function entry until that ParamRef materializes.
    // Under FP register pressure the hint that homes each parameter in
    // its own incoming register is rejected (the register lies beyond the
    // truncated bank), so the colorer could park an earlier ParamRef on a
    // later ParamRef's incoming register; the earlier parameter's
    // materialization then overwrote the later parameter's argument before
    // it was read. sum4 mixes float and double parameters: the double in
    // d3 is routed through d0, the float parameter a's incoming register,
    // clobbering a before its spill. The allocator now forbids placing a
    // ParamRef on a later same-bank ParamRef's incoming register.
    let src = r#"
        static double sum4(float a, double b, float c, double d) {
            return a + b + c + d;
        }
        int main(void) {
            return sum4(1.0f, 2.0, 3.0f, 4.0) == 10.0 ? 0 : 5;
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(2, 2, || {
        jit_exit(src, &["fp-param-incoming-clobber"])
    });
    assert_eq!(
        result, 0,
        "a float parameter in an earlier FP argument register was clobbered \
         by a later double routed through it under register pressure"
    );
}

#[test]
fn indirect_call_spilled_target_under_pressure() {
    // A six-argument indirect call. Under register pressure the target
    // pointer is spilled to a stack slot above the marshal's scratch
    // window; the marshaller reloads spilled argument sources relative to
    // the adjusted stack pointer, and that shift must include the target
    // slot. Without it a reloaded pointer argument reads the wrong stack
    // offset and the callee dereferences a corrupt pointer (x86_64 only;
    // surfaces under the low-GPR pressure CI exercises).
    let src = r#"
        typedef long (*cmp)(void *, int *, long *, long, long *, long);
        struct task { cmp fn; };
        static long do_cmp(void *t, int *cached, long *k1, long n1, long *k2, long n2) {
            (void)t; *cached = 1;
            return *k1 * 1000 + *k2 * 10 + n1 + n2;
        }
        static long run(struct task *pt, long *p1, long n1, long *p2, long n2) {
            int cached = 0;
            long r = pt->fn(pt, &cached, p1 + 2, n1, p2 + 2, n2);
            return r + cached;
        }
        int main(void) {
            struct task t; t.fn = do_cmp;
            long a[4]; long b[4];
            a[2] = 3; b[2] = 7;
            return run(&t, a, 5, b, 9) == 3085 ? 0 : 1;
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(3, 3, || {
        jit_exit_native_optimized(src, &["indirect-spill-target"])
    });
    assert_eq!(
        result, 0,
        "indirect-call target-slot spill desynced a spilled argument reload under pressure"
    );
}

#[test]
fn inline_asm_operands_under_pressure() {
    // Six inline-asm operands (one output address + five inputs). Under a
    // 2-register cap most places spill to sp-relative slots; the asm block
    // adjusts sp before capturing each operand, so the captures must read
    // spilled places through the sp-shifted form. Without the shift a later
    // operand reads the block's own capture area (a garbage value at -O0,
    // a corrupt output address at -O).
    let src = r#"
        static int asm_sum5(int a, int b, int c, int d, int e) {
            int r;
        #if defined(__aarch64__)
            __asm__("add %w0, %w1, %w2\n\t"
                    "add %w0, %w0, %w3\n\t"
                    "add %w0, %w0, %w4\n\t"
                    "add %w0, %w0, %w5"
                    : "=r"(r)
                    : "r"(a), "r"(b), "r"(c), "r"(d), "r"(e));
        #elif defined(__x86_64__)
            __asm__("movl %1, %0\n\t"
                    "addl %2, %0\n\t"
                    "addl %3, %0\n\t"
                    "addl %4, %0\n\t"
                    "addl %5, %0"
                    : "=r"(r)
                    : "r"(a), "r"(b), "r"(c), "r"(d), "r"(e));
        #else
            r = a + b + c + d + e;
        #endif
            return r;
        }
        int main(void) {
            return asm_sum5(6, 7, 8, 9, 12) == 42 ? 0 : 1;
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(2, 2, || {
        jit_exit(src, &["asm-operands-pressure"])
    });
    assert_eq!(result, 0, "asm operand captured from a shifted spill slot");
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(2, 2, || {
        jit_exit_native_optimized(src, &["asm-operands-pressure-opt"])
    });
    assert_eq!(
        result, 0,
        "asm operand capture under -O read a corrupt place through the moved sp"
    );
}

#[test]
fn register_asm_variable_pinned_to_staging_scratch_neighbor() {
    // A local register variable bound to the register neighboring the
    // emitter's asm-staging scratch (x86-64 r11, next to r10; AArch64 x0,
    // used through GCC's `r0` spelling) must be honored as a `+r` operand:
    // the value loads into the named register and the store-back reads it
    // there, so the staging cannot use that register as its own scratch.
    // Run under a 2-register cap so the operands spill and the staging
    // exercises the scratch path.
    let src = r#"
        static long rt(long a, long b) {
        #if defined(__aarch64__)
            register long v asm("r0") = a;
            __asm__ volatile("add %0, %0, %1" : "+r"(v) : "r"(b));
        #elif defined(__x86_64__)
            register long v asm("r11") = a;
            __asm__ volatile("addq %1, %0" : "+r"(v) : "r"(b) : "cc");
        #else
            long v = a + b;
        #endif
            return v;
        }
        int main(void) { return rt(40, 2) == 42 ? 0 : 1; }
    "#;
    assert_eq!(
        jit_exit(src, &["reg-asm-scratch-neighbor"]),
        0,
        "bound register not honored across asm staging"
    );
    assert_eq!(
        jit_exit_native_optimized(src, &["reg-asm-scratch-neighbor-opt"]),
        0,
        "bound register not honored across asm staging (-O)"
    );
    // Under a 2-register cap the operands spill, so the staging exercises
    // the scratch path that must not reuse the bound register.
    let capped = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(2, 2, || {
        jit_exit(src, &["reg-asm-scratch-neighbor-cap"])
    });
    assert_eq!(
        capped, 0,
        "bound register not honored under register pressure"
    );
    let capped_opt = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(2, 2, || {
        jit_exit_native_optimized(src, &["reg-asm-scratch-neighbor-cap-opt"])
    });
    assert_eq!(
        capped_opt, 0,
        "bound register not honored under pressure (-O)"
    );
}

#[test]
fn inline_asm_memory_output_to_local_under_pressure() {
    // Four memory outputs to locals (`=m`, aarch64 `=Q`) and four register
    // inputs: eight operands. Under a 2-register cap the operands spill to
    // sp-relative slots, and a memory output carries its destination address
    // as the operand. Reading a spilled place unshifted let a later operand
    // capture the block's own scratch, corrupting an output address: a wrong
    // store at -O0, a store through a bad pointer (SIGSEGV) at -O. The sibling
    // above covers register outputs; this covers the memory-output address.
    let src = r#"
        static int asm_store4(int a, int b, int c, int d) {
            int p = 0, q = 0, r = 0, s = 0;
        #if defined(__aarch64__)
            __asm__("str %w4, %0\n\t"
                    "str %w5, %1\n\t"
                    "str %w6, %2\n\t"
                    "str %w7, %3"
                    : "=Q"(p), "=Q"(q), "=Q"(r), "=Q"(s)
                    : "r"(a), "r"(b), "r"(c), "r"(d));
        #elif defined(__x86_64__)
            __asm__("movl %4, %0\n\t"
                    "movl %5, %1\n\t"
                    "movl %6, %2\n\t"
                    "movl %7, %3"
                    : "=m"(p), "=m"(q), "=m"(r), "=m"(s)
                    : "r"(a), "r"(b), "r"(c), "r"(d));
        #else
            p = a; q = b; r = c; s = d;
        #endif
            return p + q * 10 + r * 100 + s * 1000;
        }
        int main(void) {
            return asm_store4(6, 7, 8, 9) == 9876 ? 0 : 1;
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(2, 2, || {
        jit_exit(src, &["asm-mem-output-pressure"])
    });
    assert_eq!(
        result, 0,
        "inline-asm memory output captured a corrupt destination address under pressure"
    );
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(2, 2, || {
        jit_exit_native_optimized(src, &["asm-mem-output-pressure-opt"])
    });
    assert_eq!(
        result, 0,
        "inline-asm memory output address read a corrupt place through the moved sp under -O"
    );
}

#[test]
fn division_with_spilled_dividend_under_pressure() {
    // On x86_64 the divmod lowering stages the dividend into the
    // destination register; when the allocator reuses the divisor's
    // register for the result and the dividend spills, that store
    // overwrites the divisor before IDIV reads it -- computing
    // `dividend / dividend`. With the integer bank capped to one
    // register per class the operands spill and the destination
    // reuses an operand register, reproducing the conflict.
    let src = r#"
        int main() {
            int s = 0;
            int i;
            for (i = 1; i <= 6; i++) {
                s = s + 100 / i;
            }
            return s; // 100+50+33+25+20+16 = 244
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["div-spill"])
    });
    assert_eq!(
        result, 244,
        "division lowering took the dividend register as the divisor under pressure"
    );
}

#[test]
fn variadic_va_list_survives_spilled_operands_under_pressure() {
    // VaStart / VaArg / VaCopy each take their `va_list` pointer
    // operands -- and VaArg its result -- from the allocator. With
    // the integer bank capped to one register per class the cursor
    // pointer (`&ap`), the source / destination pointers (VaCopy),
    // the `&last` pointer (VaStart) and the VaArg result all land in
    // spill slots. The x86_64 emit previously required each to be a
    // register and bailed the whole function to an ICE otherwise.
    // The handlers must instead materialize a spilled operand into a
    // reserved scratch (r10 / r13, outside both pools) and store a
    // spilled result back to its slot. `sum` walks three ints twice
    // (once through the original list, once through a va_copy) and
    // returns 2 * (11 + 22 + 33) = 132.
    let src = r#"
        #include <stdarg.h>
        static int sum(int n, ...) {
            va_list ap;
            va_list bp;
            int total = 0;
            int i;
            va_start(ap, n);
            va_copy(bp, ap);
            for (i = 0; i < n; i++) {
                total = total + va_arg(ap, int);
            }
            for (i = 0; i < n; i++) {
                total = total + va_arg(bp, int);
            }
            va_end(ap);
            va_end(bp);
            return total;
        }
        int main() {
            return sum(3, 11, 22, 33); // 2 * 66 = 132
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["va-spill"])
    });
    assert_eq!(
        result, 132,
        "variadic emit bailed or miscompiled when va_list operands / result spilled under pressure"
    );
}

#[test]
fn paramref_pointer_arg_survives_shared_register_packing() {
    // A `ParamRef` materialises its parameter from the incoming host
    // argument register. When the allocator packs several
    // sequentially-live parameters into one register -- each consumed
    // by an intervening store before the next is produced -- the
    // destination register it picks for an earlier parameter can be a
    // later parameter's incoming argument register. The earlier
    // `ParamRef`'s write then clobbers the later parameter's argument
    // value before it is read; on System V the fourth integer argument
    // is rcx, which the allocator readily reuses for earlier params.
    // This mirrors a real-world shape where two int parameters (`base`,
    // `n`) are stored, then a pointer parameter (`zAff`) is dereferenced,
    // and the corrupted `zAff` (a small integer) faulted on deref. The
    // first parameter is kept live so the allocator packs parameters
    // 1, 2 and 3 into the second integer register, which on System V
    // is rcx -- the incoming register of the fourth argument. The
    // non-elidable parameters must be read from their prologue home
    // cells, which survive the clobber, not from the live argument
    // register. The -O pipeline produces the packing on its own.
    // The trailing `while` loop over `zAff` is load-bearing: it is the
    // register pressure that drives the allocator to pack the three
    // stored parameters into the second integer register (rcx) instead
    // of leaving them in distinct registers. Without it the allocator
    // colours them apart and the entry parallel-copy batch -- which is
    // always correct -- handles the placement, hiding the per-inst bug.
    let src = r#"
        static int g[8];
        static int apply(int *keep, int base, int n, int *zAff) {
            g[5] = keep[0];
            g[0] = base;
            g[1] = n;
            if (zAff == 0) return -1;
            g[2] = keep[1];
            while (n > 0 && zAff[0] <= 64) { n--; base++; zAff++; }
            return base * 100 + n + keep[2];
        }
        int main() {
            int keep[3];
            int z[4];
            keep[0] = 11; keep[1] = 22; keep[2] = 33;
            z[0] = 100; z[1] = 100; z[2] = 100; z[3] = 0;
            // zAff[0]=100 > 64 so the loop never runs; the result is
            // base*100 + n + keep[2] = 5*100 + 1 + 33 = 534. A clobbered
            // `zAff` dereferences a small integer in the loop guard and
            // faults or yields nonsense.
            return apply(keep, 5, 1, z);
        }
    "#;
    let result = jit_exit_native_optimized(src, &["paramref-pack"]);
    assert_eq!(
        result, 534,
        "a pointer parameter was clobbered by an earlier ParamRef sharing its argument register"
    );
}

#[test]
fn division_with_call_result_divisor_and_spilled_dst_under_pressure() {
    // The x86_64 divmod lowering must marshal a divisor that the
    // allocator placed in rax or rdx out of those registers before the
    // dividend setup overwrites them. The copy target was always
    // SCRATCH_R10; when the destination is itself a spill, rd resolves
    // to SCRATCH_R10 and the spilled dividend is staged there, so the
    // divisor copy and the dividend collide and the function bailed out
    // of the implemented subset. The divisor must
    // go to a second reserved scratch (r13) in that case.
    //
    // Reproducing the exact place triple (dividend Spill, divisor in the
    // rax result register, dst Spill) needs: a non-inlinable callee so
    // the divisor stays a live call result in rax; a loop-carried
    // (phi'd) quotient so the allocator spills the destination; and the
    // capped bank so the dividend spills too. 1000 / 3 six times is 1.
    let src = r#"
        long dv(long x) { if (x > 1000000) return x; return x + 1; }
        long g[8];
        int main() {
            g[0] = 1000; g[1] = 0; g[2] = 2; g[3] = 0;
            long acc = g[0];
            int i;
            for (i = 0; i < 6; i++) {
                long t = acc + g[1];
                acc = t / dv(g[2]);
            }
            return (int)(acc + g[3]); // 1000/3/3/3/3/3/3 = 1
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit_native_optimized(src, &["div-call-spill"])
    });
    assert_eq!(
        result, 1,
        "divmod lowering failed to marshal a call-result divisor away from a spilled dividend/dst"
    );
}

#[test]
fn multiply_by_immediate_with_spilled_result_under_pressure() {
    // `BinopI { op: Mul }` by a non-power-of-two constant. The x86_64
    // lowering must not depend on a free caller-saved scratch to
    // materialise the immediate: with the bank capped to one register
    // the product spills and no scratch is free, so the three-operand
    // `imul rd, rn, imm32` form is required. The earlier scratch path
    // bailed the whole function out of the implemented subset here.
    let src = r#"
        int main() {
            int s = 0;
            int i;
            for (i = 0; i < 6; i++) {
                s = s + i * 7;
            }
            return s; // 7 * (0+1+2+3+4+5) = 105
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["mul-imm-spill"])
    });
    assert_eq!(
        result, 105,
        "multiply by an immediate with a spilled result was not lowered under pressure"
    );
}

#[test]
fn and_with_low_32_bit_mask_lowers_without_scratch() {
    // `x & 0xffffffff` is a 32-bit zero-extension. The immediate does
    // not fit a signed i32 (the `and r64, imm32` form sign-extends, so
    // 0xffffffff would mask nothing), and the rcx-scratch fallback for a
    // 64-bit immediate bailed the whole function out of the implemented
    // subset when no caller-saved register was free under pressure. The
    // lowering must emit a 32-bit `mov rd, rn`, which clears the upper
    // half with no scratch. Capping the integer bank to one register
    // spills the masked result and removes any free scratch, reproducing
    // the bail (a real-world little-endian load-helper shape hits it at
    // -O on x86_64).
    let src = r#"
        unsigned long g[8];
        int main() {
            g[0] = 0x1122334455667788UL;
            g[1] = 0xaabbccddeeff0011UL;
            unsigned long s = 0;
            int i;
            for (i = 0; i < 2; i++) {
                s = s + (g[i] & 0xffffffffUL);
            }
            // 0x55667788 + 0xeeff0011 = 0x144657799
            return (int)(s & 0xffffffffUL); // 0x44657799
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["and-lo32-mask"])
    });
    assert_eq!(
        result, 0x4465_7799,
        "x & 0xffffffff was not lowered as a 32-bit zero-extension under pressure"
    );
}

#[test]
fn long_lived_base_pointer_survives_shift_count_and_store_scratch() {
    // A base pointer kept live across many indexed loads while the body
    // also runs 64-bit rotations and stores under register pressure. On
    // x86_64 a shift reads its count from cl (rcx). When the destination
    // is a spill the shift's spilled count was materialised straight into
    // rcx through the rhs scratch -- before the shift arm's push / pop
    // could preserve a long-lived SSA value the allocator had parked in
    // rcx -- so the base pointer was overwritten by a shift count and the
    // next indexed load faulted. The shift now stages a spilled count
    // through r13 (reserved outside both allocator banks) instead of rcx,
    // so the rcx-preserving push / pop in the shift arm covers the move.
    // This is the BLAKE2b compress shape (a 16-word work vector plus the
    // `input` pointer, all live across an unrolled mixing round) reached
    // at -O once the rotate helper is inlined.
    let src = r#"
        static unsigned long rotr64(unsigned long x, unsigned long n) {
            return (x >> n) ^ (x << (64 - n));
        }
        unsigned long out[8];
        unsigned long in[16];
        static void mix(unsigned long *h, unsigned long *m) {
            unsigned long v0=h[0],v1=h[1],v2=h[2],v3=h[3];
            unsigned long v4=h[4],v5=h[5],v6=h[6],v7=h[7];
            unsigned long a=v0,b=v4,c=v0^v4,d=v0+v4;
            a += b + m[0];  d = rotr64(d ^ a, 32);
            c += d;         b = rotr64(b ^ c, 24);
            a += b + m[1];  d = rotr64(d ^ a, 16);
            c += d;         b = rotr64(b ^ c, 63);
            a += b + m[2];  d = rotr64(d ^ a, 32);
            c += d;         b = rotr64(b ^ c, 24);
            a += b + m[3];  d = rotr64(d ^ a, 16);
            c += d;         b = rotr64(b ^ c, 63);
            h[0] = a ^ v1; h[1] = b ^ v2; h[2] = c ^ v3; h[3] = d ^ v5;
            h[4] = a ^ m[4]; h[5] = b ^ m[5]; h[6] = c ^ m[6]; h[7] = d ^ m[7];
        }
        int main() {
            int i;
            for (i = 0; i < 8; i++) out[i] = 0x0101010101010101UL * (i + 1);
            for (i = 0; i < 16; i++) in[i] = 0xfedcba9876543210UL * (i + 3);
            mix(out, in);
            unsigned long acc = 0;
            for (i = 0; i < 8; i++) acc ^= out[i] + i;
            return (int)(acc & 0xffffffffUL);
        }
    "#;
    // The -O path inlines `rotr64`, which raises register pressure to the
    // level that forces the clobber; the interpreter and the unoptimised
    // path both compute the reference value.
    let expected = jit_exit(src, &["mix-ref"]);
    let optimized = jit_exit_native_optimized(src, &["mix-opt"]);
    assert_eq!(
        optimized, expected,
        "a long-lived base pointer was clobbered by a shift-count or store scratch under pressure"
    );
}

/// `always_inline` is a mandatory request -- gcc and clang report a
/// diagnostic when they cannot honour one rather than declining -- so the
/// inliner's size and frame budgets do not apply to it, and the splice
/// relocates the callee's own slots into the caller's frame. Every
/// relocated slot must still address correctly past the single-instruction
/// and scaled-immediate reaches. The index comes from the parameter so the
/// buffer survives store forwarding; the frame stays under the guest main
/// thread's 8 MiB stack. Reach past the 24-bit immediate form is covered by
/// the encoder and image tests.
#[test]
fn always_inline_frame_growth_runs_correctly() {
    const COPIES: usize = 20;
    let mut src = String::from(
        "static __attribute__((always_inline)) inline long helper(long n) {\n\
             char buf[300000];\n\
             long i = n & 0xffff;\n\
             buf[i] = (char)n;\n\
             if (n > 0) { buf[i + 1] = 2; } else { buf[i + 1] = 0; }\n\
             return (long)buf[i] + (long)buf[i + 1];\n\
         }\n\
         int main(void) {\n\
             long s = 0;\n",
    );
    for _ in 0..COPIES {
        src.push_str("    s += helper(1);\n");
    }
    src.push_str("    return (int)s;\n}\n");
    // helper(1) == 1 + 2.
    let want = (COPIES * 3) as i32;
    assert_eq!(
        jit_exit_native_optimized(&src, &["always-inline-frame"]),
        want,
        "an always_inline chain that grew the caller frame miscomputed"
    );
}

#[test]
fn large_stack_frame_is_page_probed() {
    // A function whose frame exceeds one 4 KiB page. On Win64 the
    // prologue must touch every page it allocates, in descending order,
    // so the OS guard-page mechanism commits the next page before the
    // frame reaches it; a single `sub rsp, bytes` that jumps past the
    // guard page faults on the first access into an uncommitted page.
    // System V Linux grows the stack on demand. The large local arrays
    // force a multi-page frame; the loops touch the high and low ends so
    // an unprobed frame faults on the first write. (Heavily-spilled -O
    // functions reach this frame size on their own -- a BLAKE2b compress
    // allocates tens of kilobytes after the rotate helper inlines.)
    let src = r#"
        int main() {
            volatile int a[3000];
            volatile int b[3000];
            int i;
            for (i = 0; i < 3000; i++) { a[i] = i; b[i] = 3000 - i; }
            long sum = 0;
            for (i = 0; i < 3000; i++) sum += a[i] + b[i];
            return (int)(sum % 100000); // 3000 * 3000 = 9000000 -> 0
        }
    "#;
    assert_eq!(
        jit_exit(src, &["large-frame"]),
        0,
        "a multi-page stack frame was not page-probed; the prologue skipped a guard page"
    );
    assert_eq!(
        jit_exit_native_optimized(src, &["large-frame-opt"]),
        0,
        "a multi-page stack frame was not page-probed under -O"
    );
}

#[test]
fn fp_diamond_phi_under_pressure() {
    // A double-valued local assigned on both arms of an if/else: the
    // slot merges two FP definitions at the join, so mem2reg promotes
    // it through an FP-classed `Phi { kind: F64 }`. The predecessor-exit
    // move runs over the FP register / spill file. Capping the FP bank
    // to one register forces the merged value across registers and spill
    // slots, exercising the spilled-FP-phi edge.
    let src = r#"
        double pick(int c, double a, double b) {
            double x;
            if (c) { x = a * 2.0; }
            else   { x = b + 1.0; }
            return x * 3.0;
        }
        int main() {
            // c=1: (2.5*2)*3 = 15.0 ; c=0: (4.0+1)*3 = 15.0
            double t = pick(1, 2.5, 99.0) + pick(0, 99.0, 4.0);
            return (int)t; // 15 + 15 = 30
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(8, 1, || {
        jit_exit(src, &["fp-diamond"])
    });
    assert_eq!(
        result, 30,
        "FP diamond phi miscomputed under FP register pressure"
    );
}

#[test]
fn fp_loop_carried_phi_under_pressure() {
    // A double accumulator carried across a loop back-edge: the slot's
    // reaching value at the head block merges the entry seed with the
    // body's update, so mem2reg promotes it through an FP-classed phi
    // whose operand on the back edge is the in-body sum. With the FP
    // bank capped to one register the accumulator and the per-iteration
    // operands compete for registers and spill, exercising the FP-phi
    // predecessor move on a back edge.
    let src = r#"
        int main() {
            double a[5];
            a[0] = 1.5; a[1] = 2.5; a[2] = 3.0; a[3] = 4.0; a[4] = 9.0;
            double sum = 0.0;
            int i;
            for (i = 0; i < 5; i++) {
                sum = sum + a[i];
            }
            return (int)sum; // 1.5+2.5+3+4+9 = 20
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(8, 1, || {
        jit_exit(src, &["fp-loop-acc"])
    });
    assert_eq!(
        result, 20,
        "FP loop-carried accumulator phi miscomputed under FP register pressure"
    );
}

#[test]
fn fp_store_f32_preserves_live_numerator() {
    // A single `float` numerator reused as the dividend of two
    // consecutive `float` stores: `1.0f` is computed once and divided
    // by two different denominators, each result stored to a `float`
    // lvalue. The aarch64 `float` store narrows the f64 result with
    // `fcvt Sd, Dn`; writing the S view zeroes the rest of the V
    // register per AAPCS64, so narrowing over a pooled d-register
    // would destroy the still-live numerator before the second store.
    // The narrow must land in a scratch register outside the allocator
    // pool (mirrors a real-world JPEG quantization-table build, where the
    // second `1 / (table[..] * a * a)` came out zero).
    let src = r#"
        int main() {
            float a[2];
            float b[2];
            float t[2];
            t[0] = 4.0f; t[1] = 8.0f;
            int k;
            for (k = 0; k < 2; ++k) {
                // The `1` is an int divided by a float: the dividend is an
                // IntToFp cast (scvtf) materialised once and reused for both
                // stores. The first store's narrow must not clobber it.
                a[k] = 1 / (t[k] * 2.0f);
                b[k] = 1 / (t[k] * 4.0f);
            }
            // a[0]=1/8=0.125, a[1]=1/16=0.0625, b[0]=1/16=0.0625, b[1]=1/32=0.03125
            // *10000: 1250 + 625 + 625 + 312 = 2812
            return (int)(a[0]*10000.0f) + (int)(a[1]*10000.0f)
                 + (int)(b[0]*10000.0f) + (int)(b[1]*10000.0f);
        }
    "#;
    assert_eq!(
        jit_exit(src, &["fp-f32-store-numerator"]),
        2812,
        "float store narrowing clobbered a live FP numerator"
    );
    assert_eq!(
        jit_exit_native_optimized(src, &["fp-f32-store-numerator-opt"]),
        2812,
        "float store narrowing clobbered a live FP numerator (-O)"
    );
}

#[test]
fn fp_load_into_spill_preserves_live_operand_under_pressure() {
    // `a*b - c*d`: the first product is live in a pooled d-register
    // across the loads of the second multiply's operands. On aarch64 a
    // `float`/`double` load whose allocator destination is a spill slot
    // stages through a d-register before storing to the slot; staging
    // through d0 (inside the allocator's d0..d15 pool) overwrites the
    // still-live first product. The staging register must be a reserved
    // scratch (d16/d17) outside the pool. With the FP bank capped to one
    // register the second operand spills, reproducing the clobber (a
    // real-world complex-multiply butterfly `(a).r*(b).r - (a).i*(b).i`).
    let src = r#"
        float mul_sub(float a, float b, float c, float d) {
            return a * b - c * d;
        }
        int main() {
            // 10*3 - 2*4 = 30 - 8 = 22
            float r = mul_sub(10.0f, 3.0f, 2.0f, 4.0f);
            return (int)r;
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["fp-load-spill-operand"])
    });
    assert_eq!(
        result, 22,
        "an FP load into a spill slot staged through a pooled d-register and clobbered a live operand"
    );
    let result_opt = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit_native_optimized(src, &["fp-load-spill-operand-opt"])
    });
    assert_eq!(
        result_opt, 22,
        "FP load-into-spill clobbered a live operand under pressure (-O)"
    );
}

#[test]
fn mcpy_src_scratch_preserves_live_pointer_under_pressure() {
    // A zero-initialised local aggregate (`swc s = {0}`) lowers to an
    // `Inst::Mcpy` from a zero-filled `ImmData` blob. On x86_64 the Mcpy
    // emit materialises its destination base into SCRATCH_R10 and, when
    // the destination spilled (so its base already occupies r10), needs a
    // second scratch for the source base. rcx is in the LinuxX64
    // `caller_gprs` pool, so under raised register pressure the allocator
    // parks SSA values there; here it holds the `context` pointer (the
    // second parameter) that is live across the copy and threaded into a
    // later call argument. Using rcx as the source scratch overwrote that
    // pointer, so the callee saw the `ImmData` blob address instead.
    // The source scratch must be SCRATCH_R13, outside both pools. This is
    // a real-world JPEG-writer shape: the `context` passed to the
    // write-callback setup came out as the quant-table blob address, so
    // every JPEG byte was written to the wrong buffer.
    let src = r#"
        struct ctx { long *buf; int len; int cap; };
        typedef struct { void *func; void *context; unsigned char buf[64]; int used; } swc;
        struct ctx *g_seen;
        void start_cb(swc *s, void *f, void *c) { s->func = f; s->context = c; }
        int core(swc *s, int w, int h, int comp, int q) {
            g_seen = (struct ctx *)s->context;
            return w + h + comp + q;
        }
        int run(void *f, struct ctx *c, int w, int h, int comp, int q) {
            swc s = {0};
            start_cb(&s, f, c);
            return core(&s, w, h, comp, q);
        }
        int main() {
            struct ctx ctx;
            ctx.buf = 0; ctx.len = 0; ctx.cap = 0;
            g_seen = 0;
            run((void *)0x1234, &ctx, 8, 8, 3, 90);
            // 42 when the callee saw the real context pointer; a clobbered
            // context yields the blob address and a mismatch.
            return (g_seen == &ctx) ? 42 : 7;
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(2, 8, || {
        jit_exit(src, &["mcpy-src-scratch"])
    });
    assert_eq!(
        result, 42,
        "Mcpy source scratch clobbered a live pointer the allocator parked in rcx"
    );
    let result_opt = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(2, 8, || {
        jit_exit_native_optimized(src, &["mcpy-src-scratch-opt"])
    });
    assert_eq!(
        result_opt, 42,
        "Mcpy source scratch clobbered a live pointer parked in rcx (-O)"
    );
}

#[test]
fn fp_load_f64_into_spill_preserves_live_operand_under_pressure() {
    // Same shape as the f32 case but with `double`, exercising the
    // F64 (no-widen) branch of the spill-staging load.
    let src = r#"
        double mul_sub(double a, double b, double c, double d) {
            return a * b - c * d;
        }
        int main() {
            double r = mul_sub(10.0, 3.0, 2.0, 4.0); // 22
            return (int)r;
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["fp-load-f64-spill-operand"])
    });
    assert_eq!(
        result, 22,
        "an F64 load into a spill slot staged through a pooled d-register and clobbered a live operand"
    );
}

#[test]
fn fp_inttofp_cast_into_spill_preserves_live_operand_under_pressure() {
    // `-PI * ((double)(i+1)/n + 0.5)`: the negated constant is live in
    // a pooled d-register while the `(double)(i+1)` and `(double)n`
    // IntToFp casts run. On aarch64 an `scvtf` whose allocator
    // destination is a spill slot stages through a d-register; staging
    // through d0 (inside the allocator's d0..d15 pool) overwrites the
    // negated constant before the final multiply. The staging register
    // must be a reserved scratch (d16) outside the pool. With the FP
    // bank capped to one register the second cast spills, reproducing
    // the clobber (a real-world twiddle-phase build
    // `-PI * ((double)(i+1)/nfft + .5)`).
    let src = r#"
        double g_phase[4];
        void build(int n) {
            int i;
            for (i = 0; i < n / 2; ++i) {
                g_phase[i] = -3.141592653589793 * ((double)(i + 1) / n + 0.5);
            }
        }
        int main() {
            build(8);
            // phase[2] = -PI * (3/8 + 0.5) = -PI * 0.875 = -2.74889...
            // *(-1000) truncated = 2748
            return (int)(g_phase[2] * -1000.0);
        }
    "#;
    let result = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit(src, &["fp-inttofp-spill-operand"])
    });
    assert_eq!(
        result, 2748,
        "an IntToFp cast into a spill slot staged through a pooled d-register and clobbered a live operand"
    );
    let result_opt = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(1, 1, || {
        jit_exit_native_optimized(src, &["fp-inttofp-spill-operand-opt"])
    });
    assert_eq!(
        result_opt, 2748,
        "IntToFp cast into spill clobbered a live operand under pressure (-O)"
    );
}

#[test]
fn float_struct_field_const_init() {
    // C99 6.7.9: a `float`-typed struct member initialized from a
    // floating constant stores the narrowed f32 pattern. Writing the
    // f64 pattern's low four bytes instead yields +0.0f for any
    // non-tiny value. Covers positional, designated, nested-struct,
    // and array-of-struct field writes (all route through
    // write_init_value).
    let src = r#"
        typedef struct { float r; float i; } cpx;
        typedef struct { cpx a; int n; } box;
        typedef struct { float v; } w;
        int main() {
            cpx p = {3.0f, 4.0f};
            cpx d = {.r = 1.0f, .i = 2.0f};
            box b = {{1.5f, 2.5f}, 7};
            w a[2] = {{6.0f}, {0.5f}};
            return (int)(p.r * 10 + p.i)        /* 34 */
                 + (int)(d.r * 10 + d.i)        /* 12 */
                 + (int)(b.a.r * 10 + b.a.i)    /* 17 */
                 + b.n                          /* 7  */
                 + (int)(a[0].v + a[1].v * 10); /* 11 */
            /* 34 + 12 + 17 + 7 + 11 = 81 */
        }
    "#;
    assert_eq!(jit_exit(src, &["fstruct-const"]), 81);
}

#[test]
fn printf_through_libc_got() {
    // printf's libc address is dlsym'd at JIT time and patched into
    // the fake GOT region; the codegen's adrp+ldr+blr (aarch64) or
    // call qword [rip+disp32] (x86_64) reads through it.
    let src = r#"int main() { printf("%d\n", 42); return 0; }"#;
    assert_eq!(jit_exit(src, &["jit-printf"]), 0);
}

#[test]
fn malloc_memset_memcmp_roundtrip() {
    let src = r#"
        int main() {
            int *a;
            int *b;
            a = malloc(16);
            b = malloc(16);
            memset(a, 7, 16);
            memset(b, 7, 16);
            if (memcmp(a, b, 16) == 0) {
                free(a);
                free(b);
                return 1;
            }
            return 0;
        }
    "#;
    assert_eq!(jit_exit(src, &["jit-malloc"]), 1);
}

// ---- Fixture parity. Same fixture set as `super::native_elf`'s
//      NATIVE_ELF_FIXTURES; if either backend drifts, the failure
//      pinpoints which loader path broke. ----

fn jit_fixture(name: &str) -> i32 {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push(name);
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    jit_exit(&src, &[name])
}

/// A construct the JIT declines must fail to load with a diagnostic
/// naming it, on every JIT host. Left undriven, the combination
/// regressed to a fault in the generated code instead: nothing in the
/// suite ran a thread-local through the JIT.
#[test]
fn unsupported_fixtures_are_refused() {
    let failures = super::parity_failures(JIT_UNSUPPORTED_FIXTURES, |name, needle| {
        let src = super::with_prelude(&super::load_fixture(name));
        let program = match Compiler::new(src).compile() {
            Ok(p) => p,
            Err(e) => return Some(format!("{name}: compile failed: {e}")),
        };
        match jit_run(&program, &[name.to_string()]) {
            Ok(exit) => Some(format!("{name}: expected a refusal, ran and exited {exit}")),
            Err(e) => {
                let msg = format!("{e}");
                (!msg.contains(needle))
                    .then(|| format!("{name}: refusal does not name `{needle}`: {msg}"))
            }
        }
    });
    assert!(
        failures.is_empty(),
        "{} of {} unsupported JIT fixtures did not refuse as expected:\n  {}",
        failures.len(),
        JIT_UNSUPPORTED_FIXTURES.len(),
        failures.join("\n  ")
    );
}

#[test]
fn fixture_parity() {
    let failures = super::parity_failures(JIT_FIXTURES, |name, expected| {
        let got = jit_fixture(name);
        (got != *expected).then(|| format!("{name}: expected {expected}, got {got}"))
    });
    assert!(
        failures.is_empty(),
        "{} of {} JIT fixtures regressed:\n  {}",
        failures.len(),
        JIT_FIXTURES.len(),
        failures.join("\n  ")
    );
}

/// Parity for the native optimizer (the pipeline that `--optimize`
/// turns on): every fixture in the same table must produce the same
/// exit code with the optimizer enabled as without. Catches lowering
/// regressions in the register-eligible Psh path, the prologue /
/// epilogue save shape, the cmp+branch fusion peephole, or any
/// per-arch helper (binop_with_pop, cmp_with_pop, etc).
#[test]
fn fixture_parity_native_optimized() {
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    let failures = super::parity_failures(JIT_FIXTURES, |name, expected| {
        let mut p = path.clone();
        p.push(name);
        let src =
            std::fs::read_to_string(&p).unwrap_or_else(|e| panic!("read {}: {e}", p.display()));
        let got = jit_exit_native_optimized(&src, &[name]);
        (got != *expected)
            .then(|| format!("{name} (native optimizer on): expected {expected}, got {got}"))
    });
    assert!(
        failures.is_empty(),
        "{} of {} JIT fixtures regressed under the native optimizer:\n  {}",
        failures.len(),
        JIT_FIXTURES.len(),
        failures.join("\n  ")
    );
}

// ---- Standalone tests for fixtures that need argv setup the
//      parity harness can't provide. setenv / file_io are skipped:
//      they touch process-global state (env vars / cwd) and would
//      be flaky against parallel `cargo test` threads -- the
//      AOT-ELF suite covers them via per-test subprocesses. ----

#[test]
fn original_c4_compiles_and_runs_hello_jit() {
    // c4.c reads its first user argv entry as the source file to
    // compile-and-run; we hand it the c4-subset self-host fixture
    // via JIT argv and expect the resulting c4-VM run to print
    // "Hello 123" and exit 0.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).expect("read c4.c");
    let hello = concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/tests/fixtures/c/c4_selfhost_hello.c"
    );
    let exit = jit_exit(&src, &["c4", hello]);
    assert_eq!(exit, 0, "c4 self-host JIT exited {exit}");
}

#[test]
fn original_c4_compiles_and_runs_hello_jit_native_optimized() {
    // Same as above but with the native optimizer on. c4.c is the
    // most complex program in the fixture set; if anything in the
    // register-pool lowering or cmp+branch fusion breaks under
    // heavy code-emit load, this is the test that catches it first.
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("c4.c");
    let src = std::fs::read_to_string(&path).expect("read c4.c");
    let hello = concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/tests/fixtures/c/c4_selfhost_hello.c"
    );
    let exit = jit_exit_native_optimized(&src, &["c4", hello]);
    assert_eq!(
        exit, 0,
        "c4 self-host JIT (native optimizer on) exited {exit}"
    );
}

#[test]
fn const_time_des_round_wide_imm_native_optimized() {
    // A constant-time DES round-function shape,
    // tests/fixtures/c/const_time_des_round_wide_imm.c. At -O the
    // optimizer folds each `y = const ^ (x & mask)` line into a
    // `BinopI{Xor}` against a 32-bit constant outside i32 range; the
    // ~30 `y` temporaries are all live at once, saturating the
    // caller-saved registers so the wide-immediate Xor lowering finds
    // no free scratch and previously bailed with "op outside the
    // implemented subset" at ent_pc 113 on x86_64. The reserved r13
    // scratch closes that hole. The fixture self-folds its result into
    // one byte; 24 is the known answer (verified against the
    // non-optimized lowering, which agrees).
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("tests");
    path.push("fixtures");
    path.push("c");
    path.push("const_time_des_round_wide_imm.c");
    let src =
        std::fs::read_to_string(&path).unwrap_or_else(|e| panic!("read {}: {e}", path.display()));
    let opt = jit_exit_native_optimized(&src, &["round-O"]);
    assert_eq!(opt, 24, "DES round miscompiled at -O (wide-imm scratch)");
    let noopt = jit_exit(&src, &["round-noO"]);
    assert_eq!(noopt, 24, "DES round diverged between -O and default");
}

#[test]
fn variable_shift_to_spill_under_pressure() {
    // A variable-count shift whose value-to-shift and result spill, and
    // whose destination can land in rcx (the shift-count register). The
    // x86_64 lowering previously bailed when rd was rcx and no
    // caller-saved scratch was free; it now stages through the reserved
    // r13 scratch. The eight live accumulators saturate the registers
    // so the shift's working register is contended.
    let src = r#"
        unsigned do_shifts(unsigned a, unsigned b, unsigned c, unsigned d,
                           unsigned e, unsigned f, unsigned g, unsigned h) {
            unsigned s = (b ^ 0xAC74D1D4u) & 31u;
            unsigned x0 = (a << s) >> s;
            unsigned x1 = c + d + e + f + g + h;
            return x0 + (x1 & 0u);
        }
        int main() {
            // (a << s) >> s with a's high bits clear is a.
            unsigned r = do_shifts(200u, 3u, 7u, 8u, 9u, 10u, 11u, 12u);
            return (int)(r & 0xffu); // 200
        }
    "#;
    let cap = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(3, 2, || {
        jit_exit(src, &["shift-spill-cap"])
    });
    assert_eq!(
        cap, 200,
        "variable shift miscompiled under register-pool cap"
    );
    let opt = jit_exit_native_optimized(src, &["shift-spill-O"]);
    assert_eq!(opt, 200, "variable shift miscompiled at -O");
}

#[test]
fn dead_strip_drops_unused_static_function() {
    // C99 6.2.2: an internal-linkage function that no reachable code or data
    // references is dropped before codegen. The entry, a called static, and
    // an external function all survive; only the unreferenced static is gone.
    use crate::Target;
    use crate::c5::codegen::ssa::shadow::produce_ssa_funcs;
    let src = "static int never_called(int x){return x+100;}\n\
               static int helper(int x){return x*2;}\n\
               int used_export(int x){return x-1;}\n\
               int main(void){return helper(3);}";
    let program = Compiler::new(src.to_string())
        .compile()
        .expect("compile failed");
    let funcs =
        produce_ssa_funcs(&program, Target::host(), false, true).expect("produce_ssa_funcs");
    let names: Vec<&str> = funcs.iter().map(|f| f.name.as_str()).collect();
    assert!(names.contains(&"main"), "entry must survive: {names:?}");
    assert!(
        names.contains(&"helper"),
        "called static must survive: {names:?}"
    );
    assert!(
        names.contains(&"used_export"),
        "external fn must survive: {names:?}"
    );
    assert!(
        !names.contains(&"never_called"),
        "unused static must be dead-stripped: {names:?}"
    );
}

#[test]
fn asm_template_leading_token_is_not_a_reference() {
    // A statement's leading token is a label, mnemonic or directive, so it
    // does not reference a same-named static; a name in operand position
    // does. `8:` covers the mnemonic that leads its statement behind a label.
    use crate::Target;
    use crate::c5::codegen::ssa::shadow::produce_ssa_funcs;
    let src = "static int nop(int x){return x+1;}\n\
               static int target(int x){return x+2;}\n\
               void user(void){__asm__ __volatile__(\"nop\\n8: nop\\ncall target\\n\");}\n\
               int main(void){user();return 0;}";
    let program = Compiler::new(src.to_string())
        .compile()
        .expect("compile failed");
    let funcs =
        produce_ssa_funcs(&program, Target::host(), false, true).expect("produce_ssa_funcs");
    let names: Vec<&str> = funcs.iter().map(|f| f.name.as_str()).collect();
    assert!(
        !names.contains(&"nop"),
        "a leading mnemonic must not keep a same-named static: {names:?}"
    );
    assert!(
        names.contains(&"target"),
        "a name in operand position must keep its definition: {names:?}"
    );
}

// A pointer-to-extern-data initializer (`&extern_g`) must resolve to the
// symbol's runtime address under --jit, not be left NULL. `environ` is a
// libc data export reachable via dlsym in the host process. POSIX-only:
// the Windows resolver is best-effort and msvcrt's environ export is not
// uniform.
#[cfg(unix)]
#[test]
fn jit_resolves_pointer_to_extern_data() {
    let src = "extern char **environ;\n\
               char ***p = &environ;\n\
               int main(void) { return (*p == 0) ? 1 : 0; }\n";
    assert_eq!(jit_exit(src, &[]), 0);
}

// A `#pragma binding(data ...)` global read from code (not just a
// static initializer) must patch like the AOT path: the site loads
// the host cell's address from the fake GOT. Previously the
// UserExternDataRef sites were never patched and the read faulted.
#[cfg(unix)]
#[test]
fn jit_reads_binding_data_global() {
    let src = "#include <unistd.h>\n\
               int main(void) {\n\
                   int n = 0;\n\
                   for (char **e = environ; *e; e++) n++;\n\
                   return n > 0 ? 0 : 1;\n\
               }\n";
    let program = Compiler::new(src.to_string()).compile().expect("compile");
    assert_eq!(
        jit_run(&program, &["jit-environ".to_string()]).expect("jit_run"),
        0
    );
}

/// Mirror the linker: a call to a declared-but-undefined extern must
/// refuse to run instead of dispatching to whatever function sits at
/// the placeholder-colliding ent_pc.
#[test]
fn undefined_extern_call_is_a_link_error() {
    let program = Compiler::new(
        "int bar(int);\n\
         int helper(int x) { return x + 1; }\n\
         int main(void) { return bar(41); }"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let err = jit_run(&program, &["jit-undef-call".to_string()]).expect_err("must not run");
    let msg = err.to_string();
    assert!(msg.contains("undefined reference to `bar`"), "{msg}");
}

#[test]
fn undefined_extern_object_is_a_link_error() {
    let program = Compiler::new(
        "extern int missing_obj;\n\
         int main(void) { return missing_obj + 7; }"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let err = jit_run(&program, &["jit-undef-obj".to_string()]).expect_err("must not run");
    let msg = err.to_string();
    assert!(
        msg.contains("undefined reference to `missing_obj`"),
        "{msg}"
    );
}

/// C99 7.20.4.3p2: `exit` runs the registered atexit handlers. The
/// JIT intercepts both `atexit` and `exit`, so the handler chain must
/// drain before the process terminates with the passed status. `exit`
/// ends the whole process, so the assertion drives a re-executed copy
/// of this test binary gated by the marker env var.
#[test]
fn atexit_handlers_run_on_libc_exit() {
    if let Ok(marker) = std::env::var("BADC_JIT_EXIT_MARKER") {
        let src = format!(
            "#include <stdio.h>\n\
             #include <stdlib.h>\n\
             static void h(void) {{\n\
                 FILE *f = fopen(\"{marker}\", \"w\");\n\
                 if (f) {{ fputs(\"ran\", f); fclose(f); }}\n\
             }}\n\
             int main(void) {{ atexit(h); exit(42); }}\n",
        );
        let program = Compiler::new(src).compile().expect("compile");
        let _ = jit_run(&program, &["jit-exit".to_string()]);
        unreachable!("exit(42) must terminate the process");
    }
    let marker = std::env::temp_dir().join(format!("badc_jit_exit_{}", std::process::id()));
    let _ = std::fs::remove_file(&marker);
    // libtest names tests without the crate segment of module_path!.
    let module = module_path!();
    let module = module.split_once("::").map_or(module, |(_, rest)| rest);
    let test_name = format!("{module}::atexit_handlers_run_on_libc_exit");
    let out = std::process::Command::new(std::env::current_exe().expect("current_exe"))
        .args(["--exact", &test_name, "--test-threads=1"])
        .env("BADC_JIT_EXIT_MARKER", &marker)
        .output()
        .expect("re-exec the test binary");
    assert_eq!(
        out.status.code(),
        Some(42),
        "stdout: {}\nstderr: {}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr),
    );
    let contents = std::fs::read_to_string(&marker).expect("atexit handler must write the marker");
    let _ = std::fs::remove_file(&marker);
    assert_eq!(contents, "ran");
}

/// A file-scope address constant cast to a pointer-width integer slot is a
/// link-time relocation, not a compile-time integer (C99 6.6 / 6.3.2.3):
/// an object address, a bare array name, a `&arr[i]` element designator, and
/// a function name must each resolve to the same value the runtime `&` /
/// array decay yields.
#[test]
fn addr_constant_cast_to_integer_slot() {
    let src = "static int obj;\n\
               static int arr[4];\n\
               static int callee(void) { return 7; }\n\
               unsigned long p_obj = (unsigned long)&obj;\n\
               unsigned long p_arr = (unsigned long)arr;\n\
               unsigned long p_elt = (unsigned long)&arr[2];\n\
               unsigned long p_fn = (unsigned long)callee;\n\
               int main(void) {\n\
                   if (p_obj != (unsigned long)&obj) return 1;\n\
                   if (p_arr != (unsigned long)arr) return 2;\n\
                   if (p_elt != (unsigned long)&arr[2]) return 3;\n\
                   if (p_fn != (unsigned long)callee) return 4;\n\
                   return 0;\n\
               }\n";
    assert_eq!(jit_exit(src, &["jit-addr-const"]), 0);
}

/// A string literal is a static-storage array whose address is a link-time
/// constant (C99 6.4.5p6 / 6.6p9), so `&"..."` and `&"..."[i]` are valid
/// static initializers. Each must resolve to the string's runtime address
/// with its bytes intact -- as a struct member (via a constant `?:`), as an
/// array element, and cast to a pointer-width integer.
#[test]
fn addr_of_string_literal_static_init() {
    let src = "typedef unsigned long uptr;\n\
               struct e { int a; uptr d; };\n\
               static struct e t = { 5, (0 ? 0 : (uptr)&\"example\") };\n\
               static const char *arr[] = { &\"abc\"[1], \"xy\" };\n\
               static int eq(const char *a, const char *b) {\n\
                   while (*a && *a == *b) { a++; b++; }\n\
                   return *a == *b;\n\
               }\n\
               int main(void) {\n\
                   if (t.a != 5) return 1;\n\
                   if (!eq((const char *)t.d, \"example\")) return 2;\n\
                   if (!eq(arr[0], \"bc\")) return 3;\n\
                   if (!eq(arr[1], \"xy\")) return 4;\n\
                   return 0;\n\
               }\n";
    assert_eq!(jit_exit(src, &["jit-addr-str"]), 0);
}

/// A label may carry an attribute-specifier (C23 6.9 / GNU:
/// `L: __attribute__((unused)) stmt;`). The attribute appertains to the
/// label and must be discarded without disturbing the labeled statement,
/// which still runs when reached by fallthrough or `goto`.
#[test]
fn attribute_specifier_on_label() {
    let src = "int main(void) {\n\
                   int x = 0;\n\
                   goto skip;\n\
                   x = 100;\n\
               skip: __attribute__((__unused__)) x += 7;\n\
               done: __attribute__((unused)) __attribute__((cold)) x += 35;\n\
                   return x;\n\
               }\n";
    assert_eq!(jit_exit(src, &["jit-label-attr"]), 42);
}

/// C99 6.7.8p6: a designator list may chain a `[i]` / `.sub` step onto a
/// `.member` designator (`.extent[0] = { ... }`), including when the member
/// lives in an anonymous struct nested in an anonymous union. Each addressed
/// sub-object must receive its value.
#[test]
fn member_then_index_designator_in_anon_group() {
    let src = "struct ext { int first; unsigned count; };\n\
               struct map { union { struct { struct ext extent[4]; unsigned nr; }; \
                                     struct { void *f; void *r; }; }; };\n\
               static struct map m = { { .extent[0] = { .first = 7, .count = 4294967295U }, \
                                         .nr = 1, }, };\n\
               int main(void) {\n\
                   if (m.extent[0].first != 7) return 1;\n\
                   if (m.extent[0].count != 4294967295U) return 2;\n\
                   if (m.nr != 1) return 3;\n\
                   return 0;\n\
               }\n";
    assert_eq!(jit_exit(src, &["jit-desig-chain"]), 0);
}

/// C99 6.5.2.5: an array-of-struct member may take compound-literal
/// elements (`.hook = { (struct call){...}, (struct call){...} }`), the same
/// as a top-level array of struct. Each element's fields land at its stride,
/// and an omitted field zero-fills.
#[test]
fn struct_array_member_compound_literal_elements() {
    let src = "struct call { int key; int tramp; };\n\
               struct table { struct call hook[2]; int n; };\n\
               static struct table t = { .hook = { (struct call){ .key = 11, .tramp = 22 }, \
                                                   (struct call){ .key = 33 } }, .n = 5 };\n\
               int main(void) {\n\
                   if (t.hook[0].key != 11) return 1;\n\
                   if (t.hook[0].tramp != 22) return 2;\n\
                   if (t.hook[1].key != 33) return 3;\n\
                   if (t.hook[1].tramp != 0) return 4;\n\
                   if (t.n != 5) return 5;\n\
                   return 0;\n\
               }\n";
    assert_eq!(jit_exit(src, &["jit-cl-array-member"]), 0);
}

/// GCC evaluates a non-constant `__builtin_constant_p` operand late
/// under `-O`: after inlining and constant propagation a parameter fed
/// a literal answers 1, while a runtime value still answers 0. Without
/// `-O` the early conservative 0 stands (gcc -O0 parity). Locks the
/// deferred `Intrinsic::ConstantP` resolution through the whole
/// pipeline: walker -> inliner substitution -> constant fold -> the
/// branch-fold fixed point's resolve-to-0.
#[test]
fn constant_p_defers_to_post_inline_fold() {
    let src = "static inline int is_const(int x) { return __builtin_constant_p(x); }\n\
               static inline int is_const2(int x) { return is_const(x); }\n\
               static inline int arith_const(int x) { return __builtin_constant_p(x + 1); }\n\
               int main(void) {\n\
                   volatile int rt = 5;\n\
                   int lit = __builtin_constant_p(3);\n\
                   int run = __builtin_constant_p(rt);\n\
                   int se = 1;\n\
                   int sideeff = __builtin_constant_p(se++);\n\
                   int local = 7;\n\
                   return is_const(9) | (arith_const(9) << 1) | (is_const2(9) << 2)\n\
                        | (__builtin_constant_p(local) << 3) | (lit << 4) | (run << 5)\n\
                        | (sideeff << 6) | ((se == 1) << 7) | (is_const(rt) << 8);\n\
               }\n";
    // Unoptimized: only the literal answers 1; the operand of the
    // side-effecting form is never evaluated (se stays 1).
    assert_eq!(jit_exit(src, &["jit-constp-O0"]), (1 << 4) | (1 << 7));
    // Optimized: the inlined parameters and the propagated local fold
    // to 1; runtime and side-effecting operands stay 0 and unevaluated.
    assert_eq!(
        jit_exit_native_optimized(src, &["jit-constp-O"]),
        1 | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4) | (1 << 7)
    );
}

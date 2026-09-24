//! The x86-64 frame, decoded from emitted functions: what the prologue
//! reserves and pushes, and that every exit restores it in mirror order with
//! rsp where the pops expect it.
//!
//! The frame's bottom holds the callee-saved registers, pushed after the
//! `sub`. An exit is: the return value staged, the canary check, `lea rsp`
//! in a frame whose rsp moves, the pops, `leave` (or `pop rbp` when the
//! pushes were the whole frame), `ret` or the tail `jmp`. No rsp-relative
//! access and no call may sit between the first pop and the exit.

use super::codegen::{elf_func_symbols, function_bytes, text_relocs};
use super::perf_codegen::{X64Insn, x64_insns};
use crate::{
    Hardening, NativeOptions, PatchableEntry, Profiling, StackProtect, StackProtector, Target,
};

/// The relocatable object of `src`.
fn object(
    src: &str,
    target: Target,
    optimize: bool,
    caps: (usize, usize),
    opts: NativeOptions,
) -> Vec<u8> {
    use crate::{CompileOptions, Compiler, OutputKind, emit_native_with_options};
    let program = Compiler::with_options(
        src.to_string(),
        target,
        CompileOptions::default()
            .with_no_entry_point(true)
            .with_optimize(optimize),
    )
    .compile()
    .unwrap_or_else(|e| panic!("compile ({target:?}): {e}"));
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        optimize,
        ..opts
    };
    crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(caps.0, caps.1, || {
        emit_native_with_options(&program, target, opts)
    })
    .unwrap_or_else(|e| panic!("emit ({target:?}): {e}"))
}

const FULL: (usize, usize) = (usize::MAX, usize::MAX);

fn optimized(src: &str, target: Target) -> Vec<u8> {
    object(src, target, true, FULL, NativeOptions::new())
}

fn insns_of(obj: &[u8], name: &str) -> Vec<X64Insn> {
    x64_insns(&function_bytes(obj, name))
}

/// The registers the target's convention has the callee preserve, less rbp.
fn callee_saved(target: Target) -> &'static [u8] {
    match target {
        Target::WindowsX64 => &[3, 6, 7, 12, 13, 14, 15],
        _ => &[3, 12, 13, 14, 15],
    }
}

/// The register of a `push` (`0x50`) or `pop` (`0x58`) of a callee-saved one.
fn stack_op(i: &X64Insn, base: u16, target: Target) -> Option<u8> {
    let r = (i.op.checked_sub(base)? as u8) | ((i.rex & 1) << 3);
    (i.op < base + 8 && callee_saved(target).contains(&r)).then_some(r)
}

/// `sub rsp, imm` / `add rsp, imm` by ModRM byte (`0xEC` / `0xC4`).
fn rsp_adjust(i: &X64Insn, modrm: u8) -> Option<u32> {
    (matches!(i.op, 0x81 | 0x83) && i.rex_w() && i.modrm == Some(modrm)).then_some(i.imm as u32)
}

/// What a framed function's prologue reserves: the bytes of its `sub` steps
/// and the callee-saved registers it pushes, in push order, with the index
/// of the first instruction past them.
#[derive(Debug)]
struct Frame {
    alloc: u32,
    pushes: Vec<u8>,
    body: usize,
}

impl Frame {
    fn bytes(&self) -> u32 {
        self.alloc + 8 * self.pushes.len() as u32
    }
}

/// `None` for a function that opens with no `push rbp; mov rbp, rsp`.
fn frame_of(insns: &[X64Insn], target: Target) -> Option<Frame> {
    // `endbr64`, the patchable NOPs, the `-mfentry` call or its NOP.
    let mut i = insns
        .iter()
        .position(|x| !matches!(x.op, 0x0F1E | 0x0F1F | 0x90 | 0xE8))?;
    if !(insns[i].op == 0x55 && insns[i].rex == 0) {
        return None;
    }
    let mov = insns[i + 1];
    assert!(
        mov.op == 0x89 && mov.rex_w() && mov.modrm == Some(0xE5),
        "push rbp without mov rbp, rsp: {insns:x?}"
    );
    i += 2;
    let mut alloc = 0;
    loop {
        let x = &insns[i];
        if let Some(n) = rsp_adjust(x, 0xEC) {
            alloc += n;
        } else if !(
            // The probe store, the register save areas stored through rbp,
            // and the `test al, al; je` around the System V vector half.
            x.op == 0xC7 && x.mem_base() == Some(4)
                || matches!(x.op, 0x89 | 0x0F11) && x.mem_base() == Some(5)
                || x.op == 0x84 && x.modrm == Some(0xC0)
                || x.op == 0x0F84
        ) {
            break;
        }
        i += 1;
    }
    let mut pushes = Vec::new();
    while let Some(r) = stack_op(&insns[i], 0x50, target) {
        pushes.push(r);
        i += 1;
    }
    Some(Frame {
        alloc,
        pushes,
        body: i,
    })
}

/// Indices of the instructions that leave the function: every `ret`, and a
/// `jmp` that directly follows the frame teardown.
fn exits(insns: &[X64Insn]) -> Vec<usize> {
    let teardown = |x: &X64Insn| x.op == 0xC9 || (x.op == 0x5D && x.rex == 0);
    (0..insns.len())
        .filter(|&i| insns[i].op == 0xC3 || (insns[i].is_jmp() && i > 0 && teardown(&insns[i - 1])))
        .collect()
}

/// Index of the first restore pop of the exit at `e`, after checking the
/// exit's shape against `frame`.
fn check_exit(insns: &[X64Insn], e: usize, frame: &Frame, target: Target, what: &str) -> usize {
    let ctx = || format!("{what}: exit at {:#x}: {insns:x?}", insns[e].at);
    let t = e - 1;
    let leave = insns[t].op == 0xC9;
    assert!(
        leave || (insns[t].op == 0x5D && insns[t].rex == 0),
        "no teardown: {}",
        ctx()
    );
    // `pop rbp` alone is right only where the pops return rsp to rbp.
    assert_eq!(leave, frame.alloc > 0, "teardown form: {}", ctx());
    // Between the pops and the teardown: no rsp-relative operand, no stack
    // operation, no call, no branch.
    let mut j = t;
    while j > frame.body && stack_op(&insns[j - 1], 0x58, target).is_none() {
        let x = &insns[j - 1];
        if x.op == 0xC3 || x.is_jmp() || frame.pushes.is_empty() {
            break;
        }
        assert!(
            x.mem_base() != Some(4) && !matches!(x.op, 0x50..=0x5F | 0xE8),
            "rsp used after the restore: {}",
            ctx()
        );
        j -= 1;
    }
    let mut pops = Vec::new();
    while j > frame.body
        && let Some(r) = stack_op(&insns[j - 1], 0x58, target)
    {
        pops.push(r);
        j -= 1;
    }
    // Collected from the teardown backwards, the pops read as the pushes.
    assert_eq!(pops, frame.pushes, "restore order: {}", ctx());
    j
}

/// Check every exit of every framed function of `obj`. Returns how many
/// functions push a callee-saved register.
fn check_object(obj: &[u8], target: Target, what: &str) -> usize {
    let mut saving = 0;
    for (name, _) in elf_func_symbols(obj) {
        let insns = insns_of(obj, &name);
        let what = format!("{what} {name}");
        let Some(frame) = frame_of(&insns, target) else {
            let pushes = insns.iter().any(|x| stack_op(x, 0x50, target).is_some());
            assert!(!pushes, "{what}: a frameless function pushes: {insns:x?}");
            continue;
        };
        saving += usize::from(!frame.pushes.is_empty());
        let exits = exits(&insns);
        for &e in &exits {
            check_exit(&insns, e, &frame, target, &what);
        }
        // Every pop of a callee-saved register belongs to an exit.
        let pops = insns[frame.body..]
            .iter()
            .filter(|x| stack_op(x, 0x58, target).is_some())
            .count();
        assert_eq!(pops, exits.len() * frame.pushes.len(), "{what}: {insns:x?}");
    }
    saving
}

const SOURCES: &[&str] = &[
    include_str!("../../../tests/perf/qsort.c"),
    include_str!("../../../tests/perf/sieve.c"),
    include_str!("../../../tests/perf/munchausen.c"),
    include_str!("../../../tests/fixtures/c/fib.c"),
    include_str!("../../../tests/fixtures/c/perf_loop_shapes.c"),
];

/// Every exit of every function restores what the prologue pushed, on both
/// conventions, at both levels, and with the banks capped so that values,
/// return values among them, spill.
#[test]
fn every_exit_mirrors_the_prologue() {
    let mut saving = 0;
    for target in [Target::LinuxX64, Target::WindowsX64] {
        for optimize in [true, false] {
            for caps in [FULL, (2, 2), (1, 1)] {
                for (n, src) in SOURCES.iter().enumerate() {
                    let obj = object(src, target, optimize, caps, NativeOptions::new());
                    let what = format!("{target:?} -O={optimize} caps={caps:?} source {n}");
                    saving += check_object(&obj, target, &what);
                }
            }
        }
    }
    assert!(
        saving > 100,
        "{saving} functions with saves: the corpus is too thin"
    );
}

const FIB: &str = "long fib(int n) { if (n < 2) return n; return fib(n - 1) + fib(n - 2); }\n";

/// The pushes are the whole frame of `fib`: no `sub`, and `pop rbp` in place
/// of `leave`.
#[test]
fn pushes_alone_make_the_frame() {
    let insns = insns_of(&optimized(FIB, Target::LinuxX64), "fib");
    let frame = frame_of(&insns, Target::LinuxX64).expect("a frame");
    assert_eq!((frame.alloc, frame.pushes.len()), (0, 2), "{insns:x?}");
    let e = *exits(&insns).last().expect("an exit");
    assert_eq!(insns[e - 1].op, 0x5D, "{insns:x?}");
    check_exit(&insns, e, &frame, Target::LinuxX64, "fib");
}

/// An odd number of pushes keeps the frame a multiple of 16: the `sub`
/// carries the pad.
#[test]
fn an_odd_push_count_keeps_the_frame_aligned() {
    const SRC: &str = "long h(long);\nlong one(long a) { return h(a) + a; }\n";
    for target in [Target::LinuxX64, Target::WindowsX64] {
        let insns = insns_of(&optimized(SRC, target), "one");
        let frame = frame_of(&insns, target).expect("a frame");
        assert_eq!(frame.pushes.len(), 1, "{target:?}: {insns:x?}");
        assert_eq!(frame.bytes() % 16, 0, "{target:?}: {frame:?}");
    }
}

/// A frame whose rsp moves re-establishes `rsp = rbp - frame` ahead of the
/// pops: the displacement of the `lea` is the `sub` plus the pushes.
#[test]
fn a_dynamic_frame_resets_rsp_ahead_of_the_pops() {
    const SRC: &str = "long h(long *, long);\n\
        long vla(long n, long m) { long a[n]; a[0] = m; return h(a, n) + m + n; }\n";
    for target in [Target::LinuxX64, Target::WindowsX64] {
        let insns = insns_of(&optimized(SRC, target), "vla");
        let frame = frame_of(&insns, target).expect("a frame");
        assert!(!frame.pushes.is_empty(), "{target:?}: {insns:x?}");
        for e in exits(&insns) {
            let first_pop = check_exit(&insns, e, &frame, target, "vla");
            let lea = insns[first_pop - 1];
            // `lea rsp, [rbp + disp]`.
            assert!(
                lea.op == 0x8D && lea.rex == 0x48 && lea.regs().0 == 4 && lea.mem_base() == Some(5),
                "{target:?}: no lea rsp ahead of the pops: {insns:x?}"
            );
            assert_eq!(
                lea.disp,
                -i64::from(frame.bytes()),
                "{target:?}: {insns:x?}"
            );
        }
    }
}

/// The canary check can call `__stack_chk_fail`, so it runs ahead of the
/// pops, where rsp is 16-aligned: each exit is check, scratch clear, pops.
#[test]
fn the_canary_is_checked_ahead_of_the_pops() {
    const SRC: &str = "void snk(char *); long h(long);\n\
        long guarded(long a) { char b[24]; snk(b); return h(a) + a + b[0]; }\n";
    let opts = NativeOptions {
        stack_protect: StackProtect {
            mode: StackProtector::Strong,
            ..StackProtect::OFF
        },
        ..NativeOptions::new()
    };
    let target = Target::LinuxX64;
    let obj = object(SRC, target, true, FULL, opts);
    let insns = insns_of(&obj, "guarded");
    let frame = frame_of(&insns, target).expect("a frame");
    assert_eq!(frame.pushes.len() % 2, 1, "an odd push count: {insns:x?}");
    let fails: Vec<u64> = text_relocs(&obj)
        .into_iter()
        .filter(|(_, n, _)| n == "__stack_chk_fail")
        .map(|(at, _, _)| at)
        .collect();
    let exits = exits(&insns);
    assert_eq!(fails.len(), exits.len(), "one check per exit");
    for e in exits {
        let first_pop = check_exit(&insns, e, &frame, target, "guarded");
        // `xor r11d, r11d`, the scratch clear that ends the check.
        let clear = insns[first_pop - 1];
        assert!(
            clear.op == 0x31 && clear.rex == 0x45 && clear.modrm == Some(0xDB),
            "the check does not end at the pops: {insns:x?}"
        );
    }
}

/// Win64 saves its non-volatile FP scratch above the pushed registers: the
/// `movups` stores follow the pushes at `slots16(pushes)` up, and every
/// exit reloads them from the same offsets ahead of the pops.
#[test]
fn win64_xmm_saves_sit_above_the_pushed_registers() {
    const SRC: &str = "double g(double); long h(long);\n\
        double mixed(double a, long n) { long t = h(n); return g(a) * a + (double)(t + n); }\n";
    let target = Target::WindowsX64;
    let insns = insns_of(&optimized(SRC, target), "mixed");
    let frame = frame_of(&insns, target).expect("a frame");
    assert!(!frame.pushes.is_empty(), "{insns:x?}");
    let base = (8 * frame.pushes.len() as i64 + 15) & !15;
    // `movups [rsp + disp], xmm` / `movups xmm, [rsp + disp]` of xmm6..15.
    let xmm_slot = |x: &X64Insn, op: u16| {
        (x.op == op && x.mem_base() == Some(4) && x.regs().0 >= 6).then_some((x.regs().0, x.disp))
    };
    let saves: Vec<(u8, i64)> = insns[frame.body..]
        .iter()
        .map_while(|x| xmm_slot(x, 0x0F11))
        .collect();
    assert!(
        !saves.is_empty(),
        "no xmm save after the pushes: {insns:x?}"
    );
    for (k, &(_, disp)) in saves.iter().enumerate() {
        assert_eq!(disp, base + 16 * k as i64, "{insns:x?}");
    }
    assert!(
        i64::from(frame.bytes()) >= base + 16 * saves.len() as i64,
        "the saves lie inside the frame: {frame:?}"
    );
    for e in exits(&insns) {
        let first_pop = check_exit(&insns, e, &frame, target, "mixed");
        let loads: Vec<(u8, i64)> = insns[first_pop - saves.len()..first_pop]
            .iter()
            .filter_map(|x| xmm_slot(x, 0x0F10))
            .collect();
        assert_eq!(loads, saves, "{insns:x?}");
    }
    // System V has no non-volatile xmm: the same source saves none.
    let sysv = insns_of(&optimized(SRC, Target::LinuxX64), "mixed");
    let frame = frame_of(&sysv, Target::LinuxX64).expect("a frame");
    assert!(xmm_slot(&sysv[frame.body], 0x0F11).is_none(), "{sysv:x?}");
}

/// A tail call marshals its arguments, then restores and tears the frame
/// down as a return does, and leaves through `jmp`.
#[test]
fn a_tail_jump_pops_what_the_prologue_pushed() {
    const SRC: &str = "long h(long);\n\
        __attribute__((noinline)) long g(long a, long b) { return h(a) + b; }\n\
        long tail(long a, long b) { long t = h(a); return g(t + b, b); }\n";
    for target in [Target::LinuxX64, Target::WindowsX64] {
        let insns = insns_of(&optimized(SRC, target), "tail");
        let frame = frame_of(&insns, target).expect("a frame");
        assert!(!frame.pushes.is_empty(), "{target:?}: {insns:x?}");
        let exits = exits(&insns);
        // Win64 lowers no tail call here; its exits are returns.
        assert!(
            target == Target::WindowsX64 || exits.iter().any(|&e| insns[e].is_jmp()),
            "{target:?}: no tail jump: {insns:x?}"
        );
        for e in exits {
            check_exit(&insns, e, &frame, target, "tail");
        }
    }
}

/// A frame realigned for an over-aligned object has rsp below the saves, so
/// a tail jump out of it resets rsp as a return does. The object is
/// volatile, which keeps it in memory, and its address is not taken, which
/// is what admits the tail call.
#[test]
fn a_tail_jump_out_of_a_realigned_frame_resets_rsp() {
    const SRC: &str = "long h(long);\n\
        __attribute__((noinline)) long g(long a) { return h(a) * 3; }\n\
        long f(long a) { _Alignas(64) volatile long x = a; x += h(a); return g(x + a); }\n";
    let target = Target::LinuxX64;
    let insns = insns_of(&optimized(SRC, target), "f");
    let frame = frame_of(&insns, target).expect("a frame");
    assert!(!frame.pushes.is_empty(), "{insns:x?}");
    // `and rsp, -64`.
    let realigns = |x: &X64Insn| x.op == 0x83 && x.modrm == Some(0xE4) && x.imm == -64;
    assert!(insns.iter().any(realigns), "{insns:x?}");
    let exits = exits(&insns);
    assert!(exits.iter().any(|&e| insns[e].is_jmp()), "{insns:x?}");
    for e in exits {
        let first_pop = check_exit(&insns, e, &frame, target, "f");
        let lea = insns[first_pop - 1];
        assert!(
            lea.op == 0x8D && lea.regs().0 == 4 && lea.mem_base() == Some(5),
            "no lea rsp ahead of the pops: {insns:x?}"
        );
        assert_eq!(lea.disp, -i64::from(frame.bytes()), "{insns:x?}");
    }
    // Not volatile, the object is promoted: nothing is left in the region
    // and the frame is not realigned.
    let promoted = SRC.replace("volatile ", "");
    let insns = insns_of(&optimized(&promoted, target), "f");
    assert!(!insns.iter().any(realigns), "{insns:x?}");
}

/// A return value that spilled is read through rsp, so ahead of the pops.
/// With the banks capped, `r` lives across the loop's calls with nothing
/// reading it there, and is returned from its slot.
#[test]
fn a_spilled_return_value_is_read_ahead_of_the_pops() {
    const SRC: &str = "long h(long);\n\
        long keep(long a, long b) { long x = h(a); long y = h(b); h(x + y); return y; }\n\
        long cold(long a, long n) { long r = h(a); long s = 0;\n\
            for (long i = 0; i < n; i++) s += h(i + s) + i;\n\
            h(s); return r; }\n";
    let target = Target::LinuxX64;
    let mut from_a_slot = 0;
    for caps in [(1, 1), (2, 2)] {
        let obj = object(SRC, target, true, caps, NativeOptions::new());
        for name in ["keep", "cold"] {
            let insns = insns_of(&obj, name);
            let frame = frame_of(&insns, target).expect("a frame");
            assert!(!frame.pushes.is_empty(), "{name}: {insns:x?}");
            for e in exits(&insns) {
                let first_pop = check_exit(&insns, e, &frame, target, name);
                // `mov rax, [rsp + disp]` directly ahead of the pops.
                let load = insns[first_pop - 1];
                from_a_slot += usize::from(
                    load.op == 0x8B && load.regs().0 == 0 && load.mem_base() == Some(4),
                );
            }
        }
    }
    assert!(from_a_slot > 0, "no configuration returned a spilled value");
}

/// The link path's decoder over `name` of `obj`, with the window the
/// structured record implies.
fn decoded(obj: &[u8], name: &str) -> (crate::c5::codegen::FnUnwind, Vec<u8>) {
    let code = function_bytes(obj, name);
    let n = code.len() as u32;
    let uw = crate::c5::codegen::decode_x86_64_prologue_unwind(&code, 0, n, n);
    (uw, code)
}

/// The entry instructions that precede `push rbp` -- `endbr64`, the
/// patchable NOPs, the `-mfentry` call -- and the `-pg` call that follows
/// the pushes leave the prologue readable by the link path's decoder.
#[test]
fn the_prologue_decoder_reads_a_frame_with_pushes_behind_every_entry_form() {
    const SRC: &str = "long h(long); void snk(char *);\n\
        long one(long a) { char b[40]; snk(b); return h(a) + a + b[0]; }\n";
    let profiling = |fentry| Profiling {
        enabled: true,
        fentry,
        record_mcount: false,
        nop_mcount: false,
    };
    let forms = [
        ("plain", NativeOptions::new()),
        (
            "patchable + endbr64",
            NativeOptions {
                patchable_function_entry: PatchableEntry { nops: 3, before: 1 },
                hardening: Hardening {
                    cf_protection_branch: true,
                    ..Hardening::NONE
                },
                ..NativeOptions::new()
            },
        ),
        (
            "-pg -mfentry",
            NativeOptions {
                profiling: profiling(true),
                ..NativeOptions::new()
            },
        ),
        (
            "-pg",
            NativeOptions {
                profiling: profiling(false),
                ..NativeOptions::new()
            },
        ),
    ];
    for target in [Target::LinuxX64, Target::WindowsX64] {
        for (what, opts) in forms.clone() {
            // PE/COFF has no patchable entries and no profiling calls.
            if target == Target::WindowsX64 && what != "plain" {
                continue;
            }
            let obj = object(SRC, target, true, FULL, opts);
            let (uw, code) = decoded(&obj, "one");
            let insns = x64_insns(&code);
            let frame = frame_of(&insns, target).expect("a frame");
            assert!(!uw.leaf, "{target:?} {what}: {code:02x?}");
            assert_eq!(
                uw.frame_bytes, frame.alloc,
                "{target:?} {what}: {code:02x?}"
            );
            assert!(uw.frame_bytes > 0 && !frame.pushes.is_empty());
            // The described allocation ends where the pushes begin.
            let push = insns[frame.body - frame.pushes.len()];
            assert_eq!(uw.frame_alloc_end as usize, push.at, "{target:?} {what}");
            for e in exits(&insns) {
                check_exit(&insns, e, &frame, target, what);
            }
            if what == "-pg" {
                // `call mcount` with the frame complete: rsp is 16-aligned.
                assert_eq!(insns[frame.body].op, 0xE8, "{target:?}: {insns:x?}");
                assert_eq!(frame.bytes() % 16, 0);
            }
        }
    }
}

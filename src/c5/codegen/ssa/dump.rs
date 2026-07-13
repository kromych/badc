//! Human-readable rendering of the SSA lift + allocator output.
//! Active when the `--dump-ssa` CLI flag is set (or the
//! `BADC_DUMP_SSA` env var on a library caller); the per-arch
//! lowering invokes [`dump_function`] before emitting native code
//! so a failing emit can be cross-referenced against the SSA
//! the lowering was asked to consume.
//!
//! Format (one block at a time):
//!
//! ```text
//! fn ent_pc=128 n_params=3 variadic=false locals=40
//!   spill_count=1 gpr_used=[20] fp_used=[]
//!   block 0  start_pc=128
//!     v0  Imm(42)                       -> x20
//!     v1  LocalAddr(2)                  -> x20
//!     v2  Load { addr=v1, kind=I64 }    -> x20
//!     ...
//!     terminator Return(v2)
//!   block 1  start_pc=160
//!     v8  LocalAddr(-3)                 -> x20
//!     ...
//! ```
//!
//! Each line names the SSA value, its `Inst` shape, and the
//! `Place` the allocator picked. The lowering uses the same
//! value ids in its emitted code, so a single `eprintln!` of the
//! offending `v<id>` is enough to walk back to the producing
//! `Inst`.

#![cfg(feature = "std")]
#![allow(dead_code)]

use alloc::format;
use alloc::string::String;

use super::super::ir::{
    BinOp, BlockId, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator,
};
use super::reg_alloc::{Allocation, Place};

/// Format an entire function. Newline-terminated; one call per
/// function in `BADC_DUMP_SSA` mode.
pub(crate) fn dump_function(func: &FunctionSsa, alloc: &Allocation) -> String {
    let mut out = String::new();
    out.push_str(&format!(
        "fn ent_pc={} n_params={} variadic={} locals={}\n",
        func.ent_pc, func.n_params, func.is_variadic, func.locals,
    ));
    out.push_str(&format!(
        "  spill_count={} gpr_used={:?} fp_used={:?}\n",
        alloc.spill_count, alloc.gpr_used, alloc.fp_used,
    ));
    for (b_idx, block) in func.blocks.iter().enumerate() {
        out.push_str(&format!("  block {b_idx}  start_pc={}\n", block.start_pc,));
        for v in block.inst_range.clone() {
            let inst = &func.insts[v as usize];
            let place = alloc.places.get(v as usize).copied().unwrap_or(Place::None);
            let f32_mark = if func.f32_values.get(v as usize).copied().unwrap_or(false) {
                " [f32]"
            } else {
                ""
            };
            out.push_str(&format!(
                "    v{v:<3} {:<48} -> {}{}\n",
                fmt_inst(inst),
                fmt_place(place),
                f32_mark,
            ));
        }
        out.push_str(&format!(
            "    terminator {}",
            fmt_terminator(block.terminator),
        ));
        if let Terminator::JumpTable { table, .. } = block.terminator {
            let targets: alloc::vec::Vec<String> = func.jump_tables[table as usize]
                .iter()
                .map(|b| format!("b{b}"))
                .collect();
            out.push_str(&format!("   [{}]", targets.join(", ")));
        }
        if block.exit_acc != NO_VALUE {
            out.push_str(&format!("   (exit_acc=v{})", block.exit_acc));
        }
        out.push('\n');
    }
    out
}

fn fmt_inst(inst: &Inst) -> String {
    use Inst::*;
    match inst {
        Imm(v) => format!("Imm({v})"),
        ImmData(v) => format!("ImmData({v})"),
        ImmCode(pc) => format!("ImmCode(ent_pc={pc})"),
        ImmExtCode(binding) => format!("ImmExtCode(binding={binding})"),
        BlockAddr(b) => format!("BlockAddr(block={b})"),
        LocalAddr(n) => format!("LocalAddr({n})"),
        TlsAddr(o) => format!("TlsAddr({o})"),
        Load {
            addr,
            disp,
            kind,
            volatile,
        } => format!(
            "Load {{ addr=v{addr}, disp={disp}, kind={}{} }}",
            fmt_load_kind(*kind),
            fmt_volatile(*volatile),
        ),
        Store {
            addr,
            disp,
            value,
            kind,
            volatile,
        } => format!(
            "Store {{ addr=v{addr}, disp={disp}, value=v{value}, kind={}{} }}",
            fmt_store_kind(*kind),
            fmt_volatile(*volatile),
        ),
        LoadLocal {
            off,
            kind,
            volatile,
        } => format!(
            "LoadLocal {{ off={off}, kind={}{} }}",
            fmt_load_kind(*kind),
            fmt_volatile(*volatile),
        ),
        StoreLocal {
            off,
            value,
            kind,
            volatile,
        } => format!(
            "StoreLocal {{ off={off}, value=v{value}, kind={}{} }}",
            fmt_store_kind(*kind),
            fmt_volatile(*volatile),
        ),
        LoadIndexed {
            base,
            index,
            scale,
            kind,
        } => format!(
            "LoadIndexed {{ base=v{base}, index=v{index}, scale={scale}, kind={} }}",
            fmt_load_kind(*kind),
        ),
        StoreIndexed {
            base,
            index,
            scale,
            value,
            kind,
        } => format!(
            "StoreIndexed {{ base=v{base}, index=v{index}, scale={scale}, value=v{value}, kind={} }}",
            fmt_store_kind(*kind),
        ),
        Binop { op, lhs, rhs } => {
            format!("Binop {{ op={}, lhs=v{lhs}, rhs=v{rhs} }}", fmt_binop(*op))
        }
        BinopI { op, lhs, rhs_imm } => format!(
            "BinopI {{ op={}, lhs=v{lhs}, rhs_imm={rhs_imm} }}",
            fmt_binop(*op),
        ),
        Fneg(v) => format!("Fneg(v{v})"),
        Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        } => format!(
            "Fma {{ a=v{a}, b=v{b}, c=v{c}, neg_product={neg_product}, neg_addend={neg_addend} }}"
        ),
        Extend { value, kind } => {
            format!("Extend {{ value=v{value}, kind={} }}", fmt_load_kind(*kind))
        }
        FpCast { kind, value } => {
            format!("FpCast {{ kind={}, value=v{value} }}", fmt_fp_cast(*kind),)
        }
        Call {
            target_pc,
            args,
            fixed_args,
            fp_return,
            fp_arg_mask,
            ..
        } => format!(
            "Call {{ target_pc={target_pc}, args=[{}], fixed_args={fixed_args}, fp_return={fp_return}, fp_arg_mask={fp_arg_mask:#x} }}",
            fmt_value_list(args),
        ),
        CallIndirect {
            target,
            args,
            callee_variadic,
            fixed_args,
            fp_return,
            fp_arg_mask,
            ..
        } => format!(
            "CallIndirect {{ target=v{target}, args=[{}], callee_variadic={callee_variadic}, fixed_args={fixed_args}, fp_return={fp_return}, fp_arg_mask={fp_arg_mask:#x} }}",
            fmt_value_list(args),
        ),
        CallExt {
            binding_idx,
            args,
            fp_arg_mask,
            fp_return,
            ..
        } => {
            // Most external calls are integer-returning; show `fp_return`
            // only when set so the common case keeps a stable form.
            let fp = if *fp_return { ", fp_return=true" } else { "" };
            format!(
                "CallExt {{ binding_idx={binding_idx}, args=[{}], fp_arg_mask=0x{fp_arg_mask:x}{fp} }}",
                fmt_value_list(args),
            )
        }
        TailExt(b) => format!("TailExt({b})"),
        Mcpy { dst, src, size } => format!("Mcpy {{ dst=v{dst}, src=v{src}, size={size} }}"),
        AtomicRmw {
            op,
            addr,
            value,
            width,
        } => format!("AtomicRmw {{ op={op:?}, addr=v{addr}, value=v{value}, width={width} }}"),
        AtomicCas {
            addr,
            expected_addr,
            desired,
            width,
        } => format!(
            "AtomicCas {{ addr=v{addr}, expected_addr=v{expected_addr}, desired=v{desired}, width={width} }}"
        ),
        Intrinsic { kind, args } => format!(
            "Intrinsic {{ kind={kind}, args=[{}] }}",
            fmt_value_list(args),
        ),
        InlineAsm { asm, args } => format!(
            "InlineAsm {{ template={:?}, ops={}, args=[{}] }}",
            core::str::from_utf8(&asm.template).unwrap_or("<?>"),
            asm.operands.len(),
            fmt_value_list(args),
        ),
        AllocaInit(slot) => format!("AllocaInit({slot})"),
        ParamRef { idx, kind } => format!("ParamRef({idx}, kind={})", fmt_load_kind(*kind)),
        Phi { incoming, kind } => {
            let mut parts = String::new();
            for (i, (b, v)) in incoming.iter().enumerate() {
                if i > 0 {
                    parts.push_str(", ");
                }
                parts.push_str(&format!("b{b}:v{v}"));
            }
            format!(
                "Phi {{ incoming=[{parts}], kind={} }}",
                fmt_load_kind(*kind)
            )
        }
    }
}

fn fmt_value_list(vs: &[u32]) -> String {
    let mut s = String::new();
    for (i, v) in vs.iter().enumerate() {
        if i > 0 {
            s.push_str(", ");
        }
        s.push_str(&format!("v{v}"));
    }
    s
}

fn fmt_terminator(t: Terminator) -> String {
    match t {
        Terminator::Jmp(b) => format!("Jmp(b{b})"),
        Terminator::Bz {
            cond,
            target,
            fall_through,
        } => {
            format!("Bz {{ cond=v{cond}, target=b{target}, fall=b{fall_through} }}")
        }
        Terminator::Bnz {
            cond,
            target,
            fall_through,
        } => {
            format!("Bnz {{ cond=v{cond}, target=b{target}, fall=b{fall_through} }}")
        }
        Terminator::Return(v) => format!("Return(v{v})"),
        Terminator::TailExt(b) => format!("TailExt({b})"),
        Terminator::FallThrough(b) => format!("FallThrough(b{b})"),
        Terminator::GotoIndirect { target } => format!("GotoIndirect(v{target})"),
        Terminator::JumpTable { idx, table } => {
            format!("JumpTable {{ idx=v{idx}, table={table} }}")
        }
    }
}

fn fmt_place(p: Place) -> String {
    match p {
        Place::IntReg(r) => format!("x{r}"),
        Place::FpReg(r) => format!("d{r}"),
        Place::Spill(s) => format!("[spill {s}]"),
        Place::None => "-".into(),
    }
}

/// Rendered only when set so non-volatile dumps are unchanged.
fn fmt_volatile(v: bool) -> &'static str {
    if v { ", volatile" } else { "" }
}

fn fmt_load_kind(k: LoadKind) -> &'static str {
    match k {
        LoadKind::I64 => "I64",
        LoadKind::U8 => "U8",
        LoadKind::I8 => "I8",
        LoadKind::I32 => "I32",
        LoadKind::U32 => "U32",
        LoadKind::I16 => "I16",
        LoadKind::U16 => "U16",
        LoadKind::F32 => "F32",
        LoadKind::F64 => "F64",
    }
}

fn fmt_store_kind(k: StoreKind) -> &'static str {
    match k {
        StoreKind::I64 => "I64",
        StoreKind::I8 => "I8",
        StoreKind::I32 => "I32",
        StoreKind::I16 => "I16",
        StoreKind::F32 => "F32",
        StoreKind::F64 => "F64",
    }
}

fn fmt_binop(op: BinOp) -> &'static str {
    match op {
        BinOp::Or => "or",
        BinOp::Xor => "xor",
        BinOp::And => "and",
        BinOp::Eq => "eq",
        BinOp::Ne => "ne",
        BinOp::Lt => "lt",
        BinOp::Gt => "gt",
        BinOp::Le => "le",
        BinOp::Ge => "ge",
        BinOp::Ult => "ult",
        BinOp::Ugt => "ugt",
        BinOp::Ule => "ule",
        BinOp::Uge => "uge",
        BinOp::Shl => "shl",
        BinOp::Shr => "shr",
        BinOp::Shru => "shru",
        BinOp::Ror => "ror",
        BinOp::Add => "add",
        BinOp::Sub => "sub",
        BinOp::Mul => "mul",
        BinOp::Div => "div",
        BinOp::Mod => "mod",
        BinOp::Divu => "divu",
        BinOp::Modu => "modu",
        BinOp::Fadd => "fadd",
        BinOp::Fsub => "fsub",
        BinOp::Fmul => "fmul",
        BinOp::Fdiv => "fdiv",
        BinOp::Feq => "feq",
        BinOp::Fne => "fne",
        BinOp::Flt => "flt",
        BinOp::Fgt => "fgt",
        BinOp::Fle => "fle",
        BinOp::Fge => "fge",
    }
}

fn fmt_fp_cast(k: FpCastKind) -> &'static str {
    match k {
        FpCastKind::FpToInt => "FpToInt",
        FpCastKind::UFpToInt => "UFpToInt",
        FpCastKind::IntToFp => "IntToFp",
        FpCastKind::UIntToFp => "UIntToFp",
        FpCastKind::F32ToF64 => "F32ToF64",
        FpCastKind::F64ToF32 => "F64ToF32",
    }
}

#[allow(dead_code)]
fn _block_check(_b: BlockId) {}

/// True when SSA-dump output is requested through the CLI flag
/// (`NativeOptions::dump_ssa`). Under the `codegen_test` feature the
/// `BADC_DUMP_SSA` environment variable is also honoured; a production
/// build relies solely on the flag and never reads the environment.
pub(crate) fn enabled(options: super::NativeOptions) -> bool {
    if options.dump_ssa {
        return true;
    }
    #[cfg(feature = "codegen_test")]
    {
        std::env::var("BADC_DUMP_SSA").is_ok()
    }
    #[cfg(not(feature = "codegen_test"))]
    {
        false
    }
}

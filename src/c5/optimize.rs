//! Optional bytecode optimizer. Runs after `Compiler::compile()` and
//! returns a semantically-equivalent `Program` with fewer / faster
//! instructions. Off by default -- enable with `badc --optimize <file>`
//! or by calling [`optimize`] directly on a [`Program`].
//!
//! The pipeline is intentionally local -- no SSA, no real control-flow
//! graph. We decode the linear text into a typed IR (`Insn`), run the
//! peephole / branch-threading / DCE passes to a fixed point, then
//! re-encode with a single PC-remap step. Branch and call targets are
//! tracked as instruction indices throughout, so passes never have to
//! think about byte offsets.
//!
//! ## Passes
//! * **Constant fold** -- `Imm A; Psh; Imm B; <arith|cmp>` -> `Imm <result>`.
//! * **Branch-on-constant** -- `Imm K; Bz/Bnz` -> either `Jmp` or removed.
//! * **Jump-to-next** -- `Jmp T` where `T` is the next live instruction
//!   is removed.
//! * **Immediate-arithmetic fusion** -- `Psh; Imm N; <op>` -> `<op>I N`,
//!   one VM dispatch instead of three.
//! * **Local-load fusion** -- `Lea N; Li/Lc` -> `LdLocI/LdLocC N`.
//! * **Branch threading** -- `Bz/Bnz/Jmp T` where `T` itself is a `Jmp`
//!   retargets through the chain.
//! * **DCE** -- sweep reachability from `entry_pc` and every function
//!   entry (every `Ent`); drop instructions never touched.

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use super::CODE_BASE;
use super::error::C5Error;
use super::op::Op;
use super::program::Program;

/// Subset of `Op` that takes a target instruction (PC in the original
/// bytecode, index into the IR after decode).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum BrKind {
    Jmp,
    Jsr,
    Bz,
    Bnz,
}

impl BrKind {
    fn from_op(op: Op) -> Option<Self> {
        match op {
            Op::Jmp => Some(BrKind::Jmp),
            Op::Jsr => Some(BrKind::Jsr),
            Op::Bz => Some(BrKind::Bz),
            Op::Bnz => Some(BrKind::Bnz),
            _ => None,
        }
    }

    fn to_op(self) -> Op {
        match self {
            BrKind::Jmp => Op::Jmp,
            BrKind::Jsr => Op::Jsr,
            BrKind::Bz => Op::Bz,
            BrKind::Bnz => Op::Bnz,
        }
    }

    /// Branch-style ops fall through to the next instruction unless the
    /// branch is taken. `Jmp` and `Jsr` (return-to-fall-through is the
    /// reason `Jsr` falls through) all reach the next insn at runtime.
    /// `Jmp` is the only one that *doesn't* -- it's pure control transfer.
    fn falls_through(self) -> bool {
        !matches!(self, BrKind::Jmp)
    }
}

/// In-memory IR instruction. Each variant lines up with one bytecode
/// instruction; the size of the encoded form is given by [`Insn::word_size`].
#[derive(Debug, Clone)]
enum Insn {
    /// Op with no operand: arithmetic, loads, stores, intrinsics, Lev, Psh.
    NoArg(Op),
    /// `Lea <off>` -- local-frame offset.
    Lea(i64),
    /// `Imm <value>` -- arbitrary integer immediate.
    Imm(i64),
    /// `Imm <CODE_BASE + pc>` -- a function-pointer literal. Operand is
    /// the IR index of the target function's `Ent`. The encoder rebuilds
    /// the `CODE_BASE | pc` word from the post-DCE PC of that Ent.
    ImmCode(usize),
    /// `Imm <data_offset>` -- the address of a string literal or global,
    /// flagged by the compiler via `Program::data_imm_positions`. The VM
    /// treats it identically to `Imm`; the native backend reads it back
    /// out of the re-encoded `data_imm_positions` to relocate the value
    /// against the real `__data` vmaddr. Kept distinct from `Imm` so
    /// peephole passes (constant-fold, immediate-arith) skip it -- the
    /// value is an address, not a number to fold.
    ImmData(i64),
    /// `Ent <frame_size>` -- function entry; allocate locals.
    Ent(i64),
    /// `Adj <n>` -- drop n words from the stack post-call.
    Adj(i64),
    /// `JsrExt <binding_idx>` -- external library call, indexed by
    /// the program's flat `#pragma binding` table position.
    JsrExt(i64),
    /// `TailExt <binding_idx>` -- tail-jump to an external library
    /// symbol. Forms the entire body of a per-Sys-symbol address-
    /// take trampoline; carries through the optimizer unchanged.
    TailExt(i64),
    /// Branch-style op (`Jmp`/`Jsr`/`Bz`/`Bnz`); operand is the IR index
    /// of the target instruction.
    Branch(BrKind, usize),
    /// Immediate-arithmetic fusion of `Psh; Imm N; <op>`. The fused op
    /// must be one of [`is_immediate_arith_op`].
    ArithI(Op, i64),
    /// `Mcpy <size>` -- struct-copy primitive carrying a compile-time
    /// byte size. The optimizer never folds or rewrites it; the
    /// variant exists only so the decode pass can consume the
    /// operand and the encode pass can emit it back unchanged.
    Mcpy(i64),
    /// `TlsLea <tls_offset>` -- thread-local-storage address load.
    /// Same passthrough role as `Mcpy`: the optimizer doesn't
    /// touch the operand; the variant exists so the decode/encode
    /// pair stays in sync with the bytecode.
    TlsLea(i64),
    /// `Op::Intrinsic <id>` -- compiler-builtin (`alloca` today).
    /// Passthrough: the optimizer doesn't fold or rewrite it,
    /// but the variant has to exist so the decode pass advances
    /// past the operand instead of treating the id as a fresh
    /// op.
    Intrinsic(i64),
    /// `Op::AllocaInit <slot_idx>` -- alloca arena bookkeeping
    /// slot setup. Passthrough, same role as `Intrinsic`.
    AllocaInit(i64),
    /// Tombstone left in place by a pass that removed an instruction.
    /// The encoder skips these; targets continue to refer to indices,
    /// so leaving holes keeps everything stable across passes.
    Removed,
}

impl Insn {
    fn is_removed(&self) -> bool {
        matches!(self, Insn::Removed)
    }

    /// Bytecode word count this IR instruction encodes to.
    fn word_size(&self) -> usize {
        match self {
            Insn::NoArg(_) => 1,
            Insn::Lea(_)
            | Insn::Imm(_)
            | Insn::ImmCode(_)
            | Insn::ImmData(_)
            | Insn::Ent(_)
            | Insn::Adj(_)
            | Insn::JsrExt(_)
            | Insn::TailExt(_)
            | Insn::Branch(_, _)
            | Insn::ArithI(_, _)
            | Insn::Mcpy(_)
            | Insn::TlsLea(_)
            | Insn::Intrinsic(_)
            | Insn::AllocaInit(_) => 2,
            Insn::Removed => 0,
        }
    }
}

/// Public entry point: take a compiled `Program` and return an
/// optimized one. Warnings are preserved verbatim.
pub fn optimize(program: Program) -> Result<Program, C5Error> {
    let Program {
        text,
        data,
        entry_pc,
        warnings,
        data_imm_positions,
        code_imm_positions: in_code_imm_positions,
        tls_data,
        tls_init_size,
        call_fp_arg_masks,
        variadic_functions: in_variadic_functions,
        data_relocs,
        code_relocs,
        exports,
        dylibs,
        dllmain_pc,
        source_lines: in_source_lines,
        source_functions: in_source_functions,
        source_files: in_source_files,
        source_file_indices: in_source_file_indices,
        source_path,
        variables: in_variables,
        structs,
        entry_name,
        subsystem,
        finished_functions,
    } = program;

    let mut insns = decode(&text, &data_imm_positions, &in_code_imm_positions)?;
    // Build a single pc -> insn-index table by walking `insns`
    // once. A large amalgamated translation unit can produce
    // ~1M instructions and a few hundred CodeReloc entries; the
    // previous shape called `pc_to_index_in` once per reloc,
    // each call walking `insns` linearly, which was O(N*K) and
    // dominated `-O` wall time. One O(N) build + K binary
    // searches collapses it to O(N + K log N).
    let pc_at_idx = build_pc_at_idx(&insns);
    let entry_idx = lookup_pc(&pc_at_idx, entry_pc, insns.len(), text.len())?;
    // Snapshot the insn index of every CodeReloc target *before*
    // the peephole passes mutate the insn vector. Each target_bc_pc
    // points at a function's first instruction; the corresponding
    // index stays valid through DCE / peephole because function
    // entries aren't removed.
    let code_reloc_indices: Vec<usize> = code_relocs
        .iter()
        .map(|r| lookup_pc(&pc_at_idx, r.target_bc_pc as usize, insns.len(), text.len()))
        .collect::<Result<Vec<_>, _>>()?;

    // Run rewrites to a fixed point. Each pass returns true if it made
    // a change; we loop until none of them did. Bound the loop with a
    // hard cap to defend against an oscillation bug -- the normal case
    // converges in 2-3 passes.
    //
    // The branch-target set is shared across the four peephole passes
    // that need it (used to be rebuilt 4x per iteration -- showed up
    // as a real chunk of `-O` time on big inputs). None of our passes
    // ever *adds* a new branch target; they only delete branches or
    // retarget existing ones. So a snapshot taken at the top of the
    // iteration may go stale (a target that's been deleted still
    // appears live), but never the other way round -- which means a
    // stale entry only ever causes us to skip a fold that's safe, and
    // the next iteration picks it up.
    // BISECTION HOOKS (std-only). Read at runtime so we don't need
    // to recompile to flip flags.
    //   * BADC_OPT_OFF=<comma-list>: skip these passes entirely.
    //     Names: constfold, branch_const, jump_next, imm_arith,
    //     local_load, branch_thread, dce.
    //   * BADC_OPT_FUNC_RANGE=lo,hi: only let peephole work touch
    //     functions whose insn-order index is in [lo, hi). Outside
    //     that range, every instruction is masked as a branch
    //     target so the targets-respecting peepholes skip it.
    //     Doesn't gate jump_next / branch_thread / DCE because
    //     those don't take `targets`.
    #[cfg(feature = "std")]
    let off: alloc::collections::BTreeSet<alloc::string::String> = std::env::var("BADC_OPT_OFF")
        .unwrap_or_default()
        .split(',')
        .map(alloc::string::ToString::to_string)
        .collect();
    #[cfg(not(feature = "std"))]
    let off: alloc::collections::BTreeSet<alloc::string::String> =
        alloc::collections::BTreeSet::new();

    #[cfg(feature = "std")]
    let func_range: Option<(usize, usize)> =
        std::env::var("BADC_OPT_FUNC_RANGE").ok().and_then(|s| {
            let parts: Vec<&str> = s.split(',').collect();
            if parts.len() == 2 {
                Some((
                    parts[0].parse().unwrap_or(0),
                    parts[1].parse().unwrap_or(usize::MAX),
                ))
            } else {
                None
            }
        });
    #[cfg(not(feature = "std"))]
    let func_range: Option<(usize, usize)> = None;

    let mask_off_funcs = |insns: &[Insn], targets: &mut [bool]| {
        let Some((lo, hi)) = func_range else { return };
        let func_starts: Vec<usize> = insns
            .iter()
            .enumerate()
            .filter_map(|(i, ins)| match ins {
                Insn::NoArg(Op::Ent) | Insn::Ent(_) => Some(i),
                _ => None,
            })
            .collect();
        for (n, &start) in func_starts.iter().enumerate() {
            let end = func_starts.get(n + 1).copied().unwrap_or(insns.len());
            if n < lo || n >= hi {
                for t in targets.iter_mut().take(end).skip(start) {
                    *t = true;
                }
            }
        }
    };

    let mut targets = collect_branch_targets(&insns);
    mask_off_funcs(&insns, &mut targets);

    let off_constfold = off.contains("constfold");
    let off_branch_const = off.contains("branch_const");
    let off_jump_next = off.contains("jump_next");
    let off_imm_arith = off.contains("imm_arith");
    let off_local_load = off.contains("local_load");
    let off_branch_thread = off.contains("branch_thread");
    let off_dce = off.contains("dce");

    for _ in 0..16 {
        let mut changed = false;
        if !off_constfold {
            changed |= peephole_constant_fold(&mut insns, &targets);
        }
        if !off_branch_const {
            changed |= peephole_branch_on_constant(&mut insns, &targets);
        }
        if !off_jump_next {
            changed |= peephole_jump_to_next(&mut insns);
        }
        if !off_imm_arith {
            changed |= peephole_immediate_arith(&mut insns, &targets);
        }
        if !off_local_load {
            changed |= peephole_local_load(&mut insns, &targets);
        }
        if !off_branch_thread {
            changed |= branch_threading(&mut insns);
        }
        if !off_dce {
            changed |= dead_code_elimination(&mut insns, entry_idx);
        }
        if !changed {
            break;
        }
        // Something changed: refresh the target set for the next
        // iteration. Cheap (one O(N) sweep) compared to the four
        // rebuilds we used to do per iteration.
        targets = collect_branch_targets(&insns);
        mask_off_funcs(&insns, &mut targets);
    }

    let (text, entry_pc, data_imm_positions, code_imm_positions, new_pc) =
        encode(&insns, entry_idx);

    let remapped_code_relocs: Vec<_> = code_relocs
        .iter()
        .zip(&code_reloc_indices)
        .map(|(r, &idx)| crate::c5::program::CodeReloc {
            data_offset: r.data_offset,
            target_bc_pc: new_pc[idx] as u64,
        })
        .collect();

    // Remap source-line / source-function debug info through the
    // optimizer so dump-asm and DWARF keep their names and
    // line numbers at -O. For each pre-opt insn index `i`: its OLD
    // bc-pc was `pc_at_idx[i]` and its NEW bc-pc is `new_pc[i]`.
    // Each insn occupies `word_size()` text words; copy the
    // per-word entries verbatim into the new arrays. Removed insns
    // contribute zero words and drop out naturally; instructions
    // that survive but get retargeted (branch threading) keep their
    // original source line, since the C statement they translate is
    // unchanged.
    let mut out_source_lines: Vec<u32> = vec![0; text.len()];
    let mut out_source_functions: Vec<alloc::string::String> =
        vec![alloc::string::String::new(); text.len()];
    let mut out_source_file_indices: Vec<u16> = vec![0; text.len()];
    for (i, ins) in insns.iter().enumerate() {
        if ins.is_removed() || new_pc[i] == usize::MAX {
            continue;
        }
        let old_pc = pc_at_idx[i];
        let w = ins.word_size();
        for k in 0..w {
            let new_word_pc = new_pc[i] + k;
            let old_word_pc = old_pc + k;
            if new_word_pc < out_source_lines.len() && old_word_pc < in_source_lines.len() {
                out_source_lines[new_word_pc] = in_source_lines[old_word_pc];
            }
            if new_word_pc < out_source_functions.len() && old_word_pc < in_source_functions.len() {
                out_source_functions[new_word_pc] = in_source_functions[old_word_pc].clone();
            }
            if new_word_pc < out_source_file_indices.len()
                && old_word_pc < in_source_file_indices.len()
            {
                out_source_file_indices[new_word_pc] = in_source_file_indices[old_word_pc];
            }
        }
    }

    // Remap variable records' `function_bc_pc` through the same
    // PC table. Compiler captured each Loc symbol with the *pre-
    // optimizer* Ent position; the optimizer can shift Ents to
    // new positions (DCE never removes them, but earlier
    // instructions may collapse). Without this remap
    // the DWARF emitter's `function_bc_pc == ent_pc` filter
    // misses every function under -O, so `frame variable` works
    // at noO but goes silent at -O.
    let pc_at_idx_for_pc: alloc::collections::BTreeMap<u64, usize> = pc_at_idx
        .iter()
        .enumerate()
        .map(|(idx, &pc)| (pc as u64, idx))
        .collect();
    let out_variables: Vec<crate::c5::program::VariableInfo> = in_variables
        .into_iter()
        .filter_map(|mut v| {
            let idx = *pc_at_idx_for_pc.get(&v.function_bc_pc)?;
            let new_bc_pc = new_pc.get(idx).copied()?;
            if new_bc_pc == usize::MAX {
                return None;
            }
            v.function_bc_pc = new_bc_pc as u64;
            Some(v)
        })
        .collect();

    // Remap each `(JsrExt pc, fp_arg_mask)` tuple from the
    // pre-opt PC space to the post-opt PC space. Without this,
    // the codegen's `fp_arg_mask_at(jsrext_pc, ...)` lookup at
    // the new (post-opt) JsrExt PC returns 0 -- the call site
    // then loads every arg through the integer-arg register set,
    // sending the FP bit pattern into x0 / rdi instead of d0 /
    // xmm0 and feeding `sin(0.5)` an interpretation of 0.5's
    // bit pattern as an integer (4602678819172646912 -- which
    // libm reads as a vast double, returning sin(huge)=junk or
    // 0). Standard ABI surface: any FP argument in a libc call
    // through the optimizer has to keep its argument-register
    // mask intact across the PC remap.
    let remapped_call_fp_arg_masks: Vec<(usize, u32)> = call_fp_arg_masks
        .iter()
        .filter_map(|&(old_pc, mask)| {
            let idx = *pc_at_idx_for_pc.get(&(old_pc as u64))?;
            let new_bc_pc = new_pc.get(idx).copied()?;
            if new_bc_pc == usize::MAX {
                return None;
            }
            Some((new_bc_pc, mask))
        })
        .collect();

    // Variadic-function PCs are unit-local `Op::Ent` indices into
    // `text`. The decode/encode round-trip can shift those PCs
    // (DCE can drop a function entirely; peephole fusions shorten
    // the body but leave the `Op::Ent` itself in place). Remap each
    // entry through the same pc-to-idx-to-new-pc chain as the
    // other per-PC side tables; entries whose function was removed
    // get filtered out.
    let remapped_variadic_functions: alloc::collections::BTreeSet<usize> = in_variadic_functions
        .iter()
        .filter_map(|&old_pc| {
            let idx = *pc_at_idx_for_pc.get(&(old_pc as u64))?;
            let new_bc_pc = new_pc.get(idx).copied()?;
            if new_bc_pc == usize::MAX {
                return None;
            }
            Some(new_bc_pc)
        })
        .collect();

    Ok(Program {
        text,
        data,
        entry_pc,
        warnings,
        data_imm_positions,
        // Re-emitted by `encode()` from the post-DCE `Insn::ImmCode`
        // entries. Leaving this empty and relying on the value-range
        // heuristic in codegen (`v >= CODE_BASE && v - CODE_BASE <
        // text.len()`) misclassifies user constants that happen to
        // land in that range -- e.g. an integer flag with value
        // `0x20000000` gets emitted as a func-ptr
        // ADRP+ADD pair and corrupts the user's bit field.
        code_imm_positions,
        tls_data,
        tls_init_size,
        call_fp_arg_masks: remapped_call_fp_arg_masks,
        variadic_functions: remapped_variadic_functions,
        data_relocs,
        code_relocs: remapped_code_relocs,
        exports,
        dylibs,
        dllmain_pc,
        source_lines: out_source_lines,
        source_functions: out_source_functions,
        // The source-file table is global -- the file table is
        // a small set (one per `#include`d header) and the optimizer
        // never invents new files. Carry it through verbatim and
        // remap only the per-PC `source_file_indices` column above.
        source_files: in_source_files,
        source_file_indices: out_source_file_indices,
        source_path,
        variables: out_variables,
        structs,
        entry_name,
        subsystem,
        finished_functions,
    })
}

/// Decode a raw bytecode `text` vector into the typed IR. Branch and
/// `Imm <code_addr>` operands are converted from absolute PCs to
/// indices into the returned `Vec<Insn>`. `data_imm_positions` is the
/// compiler's side channel for `Op::Imm` operands that hold a data-
/// segment offset; we promote those to `Insn::ImmData` so peephole
/// passes leave them alone (folding a pointer with an int would be
/// wrong) and the encoder can re-emit a fresh position list.
/// `code_imm_positions` is the analogous side channel for `Op::Imm`
/// operands that hold a `CODE_BASE + pc` function-pointer literal;
/// we use it to upgrade only those `Imm`s to `Insn::ImmCode` (the
/// alternative -- the value-range heuristic alone -- misclassifies
/// any user constant in `[CODE_BASE, CODE_BASE + text.len())` as a
/// func-ptr and corrupts integer flag values that happen to land in
/// that range, like a flag with literal value `0x20000000` matching
/// `CODE_BASE`).
fn decode(
    text: &[i64],
    data_imm_positions: &[usize],
    code_imm_positions: &[usize],
) -> Result<Vec<Insn>, C5Error> {
    let is_data_imm: alloc::collections::BTreeSet<usize> =
        data_imm_positions.iter().copied().collect();
    let is_code_imm: alloc::collections::BTreeSet<usize> =
        code_imm_positions.iter().copied().collect();
    // Pass A: parse each instruction, recording where in the text each
    // IR instruction starts so we can build PC -> index later.
    let mut insns: Vec<Insn> = Vec::new();
    // Sentinel value usize::MAX means "no instruction starts at this PC".
    let mut pc_to_idx: Vec<usize> = vec![usize::MAX; text.len() + 1];

    let mut pc = 0usize;
    while pc < text.len() {
        let op = Op::from_i64(text[pc]).ok_or_else(|| {
            C5Error::Compile(crate::c5::error::fmt_ice_text(
                "optimizer: bad opcode -- the decoder drifted off the \
                 op/operand boundary or the op enum changed without \
                 updating from_i64",
                text,
                pc,
            ))
        })?;
        pc_to_idx[pc] = insns.len();
        pc += 1;
        if op.operand_count() > 0 && pc >= text.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_ice_text(
                &format!("optimizer: truncated operand for {op:?} at end of text"),
                text,
                pc.saturating_sub(1),
            )));
        }
        let insn = match op {
            Op::Lea => {
                let v = text[pc];
                pc += 1;
                Insn::Lea(v)
            }
            Op::Imm => {
                let operand_pc = pc;
                let v = text[pc];
                pc += 1;
                // ImmCode gets resolved in pass B once we know which
                // PCs are function entries. Data-segment Imms are
                // tagged via the compiler-supplied side channel.
                if is_data_imm.contains(&operand_pc) {
                    Insn::ImmData(v)
                } else {
                    Insn::Imm(v)
                }
            }
            Op::Ent => {
                let v = text[pc];
                pc += 1;
                Insn::Ent(v)
            }
            Op::Adj => {
                let v = text[pc];
                pc += 1;
                Insn::Adj(v)
            }
            Op::JsrExt => {
                let v = text[pc];
                pc += 1;
                Insn::JsrExt(v)
            }
            Op::TailExt => {
                let v = text[pc];
                pc += 1;
                Insn::TailExt(v)
            }
            Op::Jmp | Op::Jsr | Op::Bz | Op::Bnz => {
                let target = text[pc] as usize;
                pc += 1;
                // The match arm guarantees `BrKind::from_op` returns
                // Some; if a future Op variant slips into the arm
                // without a `BrKind` entry, the `expect` surfaces it.
                let kind = BrKind::from_op(op).expect("Op matched the BrKind arm above");
                Insn::Branch(kind, target)
            }
            Op::Mcpy => {
                // Op::Mcpy carries a compile-time byte size as its
                // operand. Treat it like Adj/JsrExt -- there's no
                // dedicated Insn variant because the optimizer
                // doesn't fold or rewrite it, but it still has to
                // advance `pc` past the operand.
                let v = text[pc];
                pc += 1;
                Insn::Mcpy(v)
            }
            Op::Intrinsic => {
                let v = text[pc];
                pc += 1;
                Insn::Intrinsic(v)
            }
            Op::AllocaInit => {
                let v = text[pc];
                pc += 1;
                Insn::AllocaInit(v)
            }
            Op::TlsLea => {
                // Op::TlsLea: byte offset within `tls_data` of the
                // _Thread_local global being addressed. The
                // optimizer carries it through unchanged; the
                // codegen lowers it to the per-target TLS
                // sequence (variant-1 mrs+add on aarch64,
                // variant-2 mov fs:0 + sub on x86_64).
                let v = text[pc];
                pc += 1;
                Insn::TlsLea(v)
            }
            Op::StLocI => {
                // Compiler-emitted store-to-local: spills `a` into
                // a fresh local temp slot. The op carries one
                // operand -- the slot offset (negative, in c5
                // stack words). Carried through unchanged; the
                // optimizer's local-fusion peephole only consumes
                // it as part of the input stream, never reorders
                // it across other reads/writes of the same slot.
                let v = text[pc];
                pc += 1;
                Insn::ArithI(Op::StLocI, v)
            }
            // Optimizer-emitted immediate-form ops carry an operand
            // identical in shape to a regular op's operand. The
            // generic AddI/SubI/etc. arms below pull the operand
            // out before falling through to a NoArg-style insn.
            _ => Insn::NoArg(op),
        };
        insns.push(insn);
    }

    // Pass B: collect "is this index an `Ent`?" to identify function
    // entries -- we'll only treat an `Imm` as a function-pointer literal
    // if its decoded PC lands on one.
    let is_ent: Vec<bool> = insns.iter().map(|i| matches!(i, Insn::Ent(_))).collect();

    // Pass C: rewrite branch targets PC -> index, and upgrade
    // `Imm <CODE_BASE + pc>` whose target is an Ent to `ImmCode`.
    // We promote on the compiler's `code_imm_positions` side channel,
    // not on a value-range heuristic, so user constants that happen
    // to land in `[CODE_BASE, CODE_BASE + text.len())` are left as
    // plain `Imm`. If the side channel is absent (e.g., a `Program`
    // built directly without going through the compiler -- mostly
    // unit tests) we fall back to the heuristic so those still
    // resolve `Imm <code_addr>` correctly.
    let mut text_walk_pc = 0usize;
    let use_heuristic = code_imm_positions.is_empty();
    for ins in insns.iter_mut() {
        let operand_pc = text_walk_pc + 1;
        let word_size = match ins {
            Insn::NoArg(_) => 1,
            Insn::Removed => 0,
            _ => 2,
        };
        text_walk_pc += word_size;
        match ins {
            Insn::Branch(_, target) => {
                let idx = lookup_idx(&pc_to_idx, *target).ok_or_else(|| {
                    C5Error::Compile(crate::c5::error::fmt_internal_err(&format!(
                        "optimizer: branch target {target} is not an instruction start"
                    )))
                })?;
                *target = idx;
            }
            Insn::Imm(v) => {
                let raw = *v as usize;
                let tagged = is_code_imm.contains(&operand_pc);
                let in_range = raw >= CODE_BASE && raw - CODE_BASE < text.len();
                if tagged || (use_heuristic && in_range) {
                    let target_pc = raw - CODE_BASE;
                    if let Some(idx) = lookup_idx(&pc_to_idx, target_pc)
                        && is_ent.get(idx).copied().unwrap_or(false)
                    {
                        *ins = Insn::ImmCode(idx);
                    }
                }
            }
            _ => {}
        }
    }

    Ok(insns)
}

fn lookup_idx(pc_to_idx: &[usize], pc: usize) -> Option<usize> {
    pc_to_idx.get(pc).copied().filter(|&v| v != usize::MAX)
}

/// Convert an old PC (into the original `text`) to its IR index by
/// re-walking the IR. Only used once for `entry_pc` -- too rare to
/// justify keeping the decode-time `pc_to_idx` table around.
/// Build a sorted (strictly monotonic) table where
/// `pc_at_idx[i]` is the bytecode pc at which insn `i` starts.
/// Length = `insns.len() + 1`; the trailing entry is the
/// past-the-end pc, used only by the empty-program edge case in
/// [`lookup_pc`].
fn build_pc_at_idx(insns: &[Insn]) -> Vec<usize> {
    let mut out = Vec::with_capacity(insns.len() + 1);
    let mut pc = 0usize;
    for ins in insns {
        out.push(pc);
        pc += ins.word_size();
    }
    out.push(pc);
    out
}

/// Resolve a bytecode pc back to the originating insn index. The
/// pcs in `pc_at_idx` are strictly increasing (each `Insn` has
/// `word_size() >= 1`), so a binary search lands on the exact
/// match in O(log N). Returns `Ok(insns_len)` for the
/// empty-program past-the-end case the caller tolerates.
fn lookup_pc(
    pc_at_idx: &[usize],
    target_pc: usize,
    insns_len: usize,
    text_len: usize,
) -> Result<usize, C5Error> {
    match pc_at_idx.binary_search(&target_pc) {
        Ok(idx) if idx <= insns_len => Ok(idx),
        Ok(_) | Err(_) => {
            if target_pc == text_len {
                // Entry past end: empty-program edge case.
                Ok(insns_len)
            } else {
                Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                    &format!("optimizer: entry_pc {target_pc} is not an instruction start"),
                )))
            }
        }
    }
}

/// Re-encode the IR to a flat bytecode vector. Returns
/// `(text, entry_pc, data_imm_positions, code_imm_positions, new_pc)`.
/// `new_pc` is the per-insn-index remap table so callers (e.g., the
/// code-reloc remapping in `optimize`) can translate any
/// pre-optimisation bytecode PC through the original `insns` index.
/// `code_imm_positions` mirrors `data_imm_positions`: every operand
/// slot whose word holds a `CODE_BASE + pc` function-pointer literal
/// (i.e., came from an `Insn::ImmCode`). The codegen uses this to
/// disambiguate user constants that happen to land in the
/// `[CODE_BASE, CODE_BASE + text.len())` range. A flag literal
/// `0x20000000` is exactly `CODE_BASE`, so the previous "fall back
/// to range heuristic at -O" shape misclassified the integer as a
/// func ptr.
fn encode(
    insns: &[Insn],
    entry_idx: usize,
) -> (Vec<i64>, usize, Vec<usize>, Vec<usize>, Vec<usize>) {
    // Pass A: assign post-DCE PCs, skipping Removed slots.
    let mut new_pc: Vec<usize> = vec![usize::MAX; insns.len() + 1];
    let mut pc = 0usize;
    for (i, ins) in insns.iter().enumerate() {
        if ins.is_removed() {
            continue;
        }
        new_pc[i] = pc;
        pc += ins.word_size();
    }
    // entry_idx may equal insns.len() for the empty-program case.
    if entry_idx == insns.len() {
        new_pc[entry_idx] = pc;
    }

    // Branch-threading and jump-to-next removal can leave a target
    // pointing at a Removed slot -- the original instruction is gone,
    // but we never rewrote the incoming branch. Walk forward to the
    // next live instruction so the resolved PC is always valid.
    // Past-the-end falls back to `pc` (the natural fall-through point
    // when an entire trailing block is dead).
    let resolve_target = |target: usize| -> usize {
        let mut t = target;
        while t < insns.len() && insns[t].is_removed() {
            t += 1;
        }
        if t < insns.len() { new_pc[t] } else { pc }
    };

    // Pass B: emit, resolving targets through new_pc.
    let mut text = Vec::with_capacity(pc);
    let mut data_imm_positions: Vec<usize> = Vec::new();
    let mut code_imm_positions: Vec<usize> = Vec::new();
    for ins in insns {
        match ins {
            Insn::NoArg(op) => text.push(*op as i64),
            Insn::Lea(v) => {
                text.push(Op::Lea as i64);
                text.push(*v);
            }
            Insn::Imm(v) => {
                text.push(Op::Imm as i64);
                text.push(*v);
            }
            Insn::ImmCode(target) => {
                let resolved = resolve_target(*target);
                text.push(Op::Imm as i64);
                code_imm_positions.push(text.len());
                text.push((CODE_BASE + resolved) as i64);
            }
            Insn::ImmData(v) => {
                text.push(Op::Imm as i64);
                data_imm_positions.push(text.len());
                text.push(*v);
            }
            Insn::Ent(v) => {
                text.push(Op::Ent as i64);
                text.push(*v);
            }
            Insn::Adj(v) => {
                text.push(Op::Adj as i64);
                text.push(*v);
            }
            Insn::JsrExt(v) => {
                text.push(Op::JsrExt as i64);
                text.push(*v);
            }
            Insn::TailExt(v) => {
                text.push(Op::TailExt as i64);
                text.push(*v);
            }
            Insn::Branch(kind, target) => {
                let resolved = resolve_target(*target);
                text.push(kind.to_op() as i64);
                text.push(resolved as i64);
            }
            Insn::ArithI(op, v) => {
                text.push(*op as i64);
                text.push(*v);
            }
            Insn::Mcpy(v) => {
                text.push(Op::Mcpy as i64);
                text.push(*v);
            }
            Insn::TlsLea(v) => {
                text.push(Op::TlsLea as i64);
                text.push(*v);
            }
            Insn::Intrinsic(v) => {
                text.push(Op::Intrinsic as i64);
                text.push(*v);
            }
            Insn::AllocaInit(v) => {
                text.push(Op::AllocaInit as i64);
                text.push(*v);
            }
            Insn::Removed => {}
        }
    }

    (
        text,
        resolve_target(entry_idx),
        data_imm_positions,
        code_imm_positions,
        new_pc,
    )
}

// --- Helpers shared across passes ---------------------------------

/// Find the next index `>= from` whose slot is live. Returns `None` if
/// the rest of the IR is all removed.
fn next_live(insns: &[Insn], from: usize) -> Option<usize> {
    (from..insns.len()).find(|&i| !insns[i].is_removed())
}

/// Set of indices that are reachable from any branch / call / function
/// pointer. Recomputed after any pass that adds or removes branches --
/// it's not held across the pipeline because changes invalidate it.
fn collect_branch_targets(insns: &[Insn]) -> Vec<bool> {
    let mut targets = vec![false; insns.len()];
    for ins in insns {
        match ins {
            Insn::Branch(_, t) | Insn::ImmCode(t) if *t < targets.len() => {
                targets[*t] = true;
            }
            _ => {}
        }
    }
    targets
}

// --- Passes -------------------------------------------------------

/// `Imm A; Psh; Imm B; <arith|cmp>` -> `Imm <A op B>`. The first three
/// instructions become `Removed`; the fourth carries the folded value.
/// Skip the fold if any of the intermediate instructions is itself a
/// branch target -- somebody might land mid-sequence.
fn peephole_constant_fold(insns: &mut [Insn], targets: &[bool]) -> bool {
    let mut changed = false;
    let n = insns.len();
    let mut i = 0;
    while i + 3 < n {
        let i1 = i;
        let i2 = i + 1;
        let i3 = i + 2;
        let i4 = i + 3;
        // No tombstones in scope yet -- first pass always runs on a
        // freshly-decoded IR. Once other passes start removing things,
        // this loop still works because it only matches contiguous
        // four-tuples (a Removed in the middle simply prevents a match).
        let (Insn::Imm(a), Insn::NoArg(Op::Psh), Insn::Imm(b), Insn::NoArg(op)) =
            (&insns[i1], &insns[i2], &insns[i3], &insns[i4])
        else {
            i += 1;
            continue;
        };
        // Don't fold across a branch target -- the branch could land on
        // i2/i3/i4 and the fold would change semantics.
        if targets[i2] || targets[i3] || targets[i4] {
            i += 1;
            continue;
        }
        // Don't fold a function-pointer literal as if it were a number.
        // (We already store those as ImmCode after decode, but a paranoid
        // belt-and-braces check: skip if either operand looks like one.)
        if is_code_addr(*a) || is_code_addr(*b) {
            i += 1;
            continue;
        }
        let Some(folded) = fold_arith(*op, *a, *b) else {
            i += 1;
            continue;
        };
        insns[i1] = Insn::Imm(folded);
        insns[i2] = Insn::Removed;
        insns[i3] = Insn::Removed;
        insns[i4] = Insn::Removed;
        changed = true;
        // Don't advance -- the new Imm at i1 might participate in a
        // higher-level fold (`Imm; Psh; Imm; Add` -> `Imm`, which itself
        // might be the inner of another fold).
        i = i.saturating_sub(2);
    }
    changed
}

fn is_code_addr(v: i64) -> bool {
    let u = v as usize;
    u >= CODE_BASE
}

/// Apply a binary arithmetic / comparison op to two compile-time
/// constants. Returns `None` for ops that aren't constant-foldable
/// (e.g. division by zero) or aren't binary arithmetic / comparison.
fn fold_arith(op: Op, a: i64, b: i64) -> Option<i64> {
    Some(match op {
        Op::Add => a.wrapping_add(b),
        Op::Sub => a.wrapping_sub(b),
        Op::Mul => a.wrapping_mul(b),
        Op::Div => {
            if b == 0 {
                return None;
            }
            a.wrapping_div(b)
        }
        Op::Mod => {
            if b == 0 {
                return None;
            }
            a.wrapping_rem(b)
        }
        Op::Divu => {
            if b == 0 {
                return None;
            }
            ((a as u64).wrapping_div(b as u64)) as i64
        }
        Op::Modu => {
            if b == 0 {
                return None;
            }
            ((a as u64).wrapping_rem(b as u64)) as i64
        }
        Op::And => a & b,
        Op::Or => a | b,
        Op::Xor => a ^ b,
        Op::Shl => {
            if !(0..64).contains(&b) {
                return None;
            }
            a.wrapping_shl(b as u32)
        }
        Op::Shr => {
            if !(0..64).contains(&b) {
                return None;
            }
            a.wrapping_shr(b as u32)
        }
        Op::Shru => {
            if !(0..64).contains(&b) {
                return None;
            }
            ((a as u64).wrapping_shr(b as u32)) as i64
        }
        Op::Eq => (a == b) as i64,
        Op::Ne => (a != b) as i64,
        Op::Lt => (a < b) as i64,
        Op::Gt => (a > b) as i64,
        Op::Le => (a <= b) as i64,
        Op::Ge => (a >= b) as i64,
        Op::Ult => ((a as u64) < (b as u64)) as i64,
        Op::Ugt => ((a as u64) > (b as u64)) as i64,
        Op::Ule => ((a as u64) <= (b as u64)) as i64,
        Op::Uge => ((a as u64) >= (b as u64)) as i64,
        _ => return None,
    })
}

/// `Imm K; Bz/Bnz T` collapses to either an unconditional jump or a
/// fall-through (in which case both insns vanish).
fn peephole_branch_on_constant(insns: &mut [Insn], targets: &[bool]) -> bool {
    let mut changed = false;
    let n = insns.len();
    let mut i = 0;
    while i + 1 < n {
        let i1 = i;
        let i2 = i + 1;
        let (Insn::Imm(k), Insn::Branch(kind, target)) = (&insns[i1], &insns[i2]) else {
            i += 1;
            continue;
        };
        if !matches!(kind, BrKind::Bz | BrKind::Bnz) {
            i += 1;
            continue;
        }
        if targets[i2] {
            // The branch itself is a target -- somebody jumps directly to
            // it, so we can't drop the leading Imm.
            i += 1;
            continue;
        }
        if is_code_addr(*k) {
            // Evaluating a function-pointer literal as a truth value is
            // legitimate (a non-NULL test); don't fold.
            i += 1;
            continue;
        }
        let zero = *k == 0;
        let target = *target;
        let take = match kind {
            BrKind::Bz => zero,
            BrKind::Bnz => !zero,
            _ => unreachable!(),
        };
        if take {
            // Always-taken: replace the Imm with Removed and the branch
            // with an unconditional Jmp.
            insns[i1] = Insn::Removed;
            insns[i2] = Insn::Branch(BrKind::Jmp, target);
        } else {
            // Always falls through: both insns vanish.
            insns[i1] = Insn::Removed;
            insns[i2] = Insn::Removed;
        }
        changed = true;
        i += 2;
    }
    changed
}

/// `Jmp T` where `T` is the next live instruction is a no-op.
fn peephole_jump_to_next(insns: &mut [Insn]) -> bool {
    let mut changed = false;
    for i in 0..insns.len() {
        let Insn::Branch(BrKind::Jmp, target) = &insns[i] else {
            continue;
        };
        let target = *target;
        if next_live(insns, i + 1) == Some(target) {
            insns[i] = Insn::Removed;
            changed = true;
        }
    }
    changed
}

/// `Psh; Imm N; <arith|cmp>` -> fused `<op>I N`. Saves one VM dispatch
/// per arithmetic-with-constant. Hugely common (`i + 1`, `p + sizeof(int)`,
/// `n < limit`, etc.).
fn peephole_immediate_arith(insns: &mut [Insn], targets: &[bool]) -> bool {
    let mut changed = false;
    let n = insns.len();
    let mut i = 0;
    while i + 2 < n {
        let i1 = i;
        let i2 = i + 1;
        let i3 = i + 2;
        let (Insn::NoArg(Op::Psh), Insn::Imm(v), Insn::NoArg(op)) =
            (&insns[i1], &insns[i2], &insns[i3])
        else {
            i += 1;
            continue;
        };
        if targets[i2] || targets[i3] {
            i += 1;
            continue;
        }
        if is_code_addr(*v) {
            i += 1;
            continue;
        }
        let Some(fused_op) = immediate_form(*op) else {
            i += 1;
            continue;
        };
        let v = *v;
        insns[i1] = Insn::Removed;
        insns[i2] = Insn::Removed;
        insns[i3] = Insn::ArithI(fused_op, v);
        changed = true;
        i += 3;
    }
    changed
}

/// Map a stack-arithmetic op to its immediate-arithmetic counterpart.
/// Returns `None` for ops that don't have one yet (we cover the hot set).
fn immediate_form(op: Op) -> Option<Op> {
    Some(match op {
        Op::Add => Op::AddI,
        Op::Sub => Op::SubI,
        Op::Mul => Op::MulI,
        Op::And => Op::AndI,
        Op::Or => Op::OrI,
        Op::Xor => Op::XorI,
        Op::Shl => Op::ShlI,
        Op::Shr => Op::ShrI,
        Op::Shru => Op::ShruI,
        Op::Eq => Op::EqI,
        Op::Ne => Op::NeI,
        Op::Lt => Op::LtI,
        Op::Gt => Op::GtI,
        Op::Le => Op::LeI,
        Op::Ge => Op::GeI,
        Op::Ult => Op::UltI,
        Op::Ugt => Op::UgtI,
        Op::Ule => Op::UleI,
        Op::Uge => Op::UgeI,
        _ => return None,
    })
}

/// `Lea N; Li/Lc` -> `LdLocI N` / `LdLocC N`. Local reads dominate
/// non-trivial programs; this halves their dispatch overhead.
fn peephole_local_load(insns: &mut [Insn], targets: &[bool]) -> bool {
    let mut changed = false;
    let n = insns.len();
    let mut i = 0;
    while i + 1 < n {
        let i1 = i;
        let i2 = i + 1;
        let (Insn::Lea(off), Insn::NoArg(load)) = (&insns[i1], &insns[i2]) else {
            i += 1;
            continue;
        };
        if targets[i2] {
            i += 1;
            continue;
        }
        let fused = match load {
            Op::Li => Op::LdLocI,
            Op::Lc => Op::LdLocC,
            _ => {
                i += 1;
                continue;
            }
        };
        let off = *off;
        insns[i1] = Insn::ArithI(fused, off);
        insns[i2] = Insn::Removed;
        changed = true;
        i += 2;
    }
    changed
}

/// Branch threading: `Branch X T` where `T` is itself an unconditional
/// `Jmp T2` retargets to `T2`. Iterates until the chain bottoms out.
fn branch_threading(insns: &mut [Insn]) -> bool {
    let mut changed = false;
    for i in 0..insns.len() {
        let Insn::Branch(_kind, target) = &insns[i] else {
            continue;
        };
        let mut t = *target;
        // Follow up to N hops to avoid spinning on a self-loop.
        let mut hops = 0;
        while hops < insns.len() {
            let Some(Insn::Branch(BrKind::Jmp, t2)) = insns.get(t) else {
                break;
            };
            if *t2 == t {
                break; // self-loop; stop chasing
            }
            t = *t2;
            hops += 1;
        }
        if t != *target
            && let Insn::Branch(_, target_mut) = &mut insns[i]
        {
            *target_mut = t;
            changed = true;
        }
    }
    changed
}

/// Drop instructions never reachable from `entry_idx` or any function
/// entry (`Ent`). Function entries are seeded conservatively because
/// they can be reached via function pointers (`ImmCode`) we may not
/// have traced.
fn dead_code_elimination(insns: &mut [Insn], entry_idx: usize) -> bool {
    let n = insns.len();
    if entry_idx >= n {
        return false;
    }
    let mut visited = vec![false; n];
    let mut worklist: Vec<usize> = Vec::new();

    let seed = |worklist: &mut Vec<usize>, visited: &mut [bool], i: usize| {
        if i < n && !visited[i] {
            visited[i] = true;
            worklist.push(i);
        }
    };

    seed(&mut worklist, &mut visited, entry_idx);
    for (i, ins) in insns.iter().enumerate() {
        if matches!(ins, Insn::Ent(_) | Insn::TailExt(_)) {
            // Both `Ent` (regular c5 functions) and `TailExt`
            // (single-op libc-tail-jump trampolines) are reachable
            // through function pointers we may not have traced.
            // Without seeding `TailExt` here, the post-Lev tail
            // emitted by `emit_sys_trampolines` falls outside the
            // reachability set and DCE prunes it -- which then
            // propagates a `usize::MAX` into the matching
            // `code_relocs` entry through `new_pc[Removed_idx]`.
            seed(&mut worklist, &mut visited, i);
        }
        if let Insn::ImmCode(t) = ins {
            seed(&mut worklist, &mut visited, *t);
        }
    }

    while let Some(i) = worklist.pop() {
        let ins = &insns[i];
        // Determine successors. All instructions except control-flow
        // terminators fall through to next_live; terminators only
        // transfer to their explicit target(s).
        // Terminators: only `Lev` (function return). `JsrExt` to
        // `exit` doesn't return either, but the optimizer doesn't
        // carry the symbol-table info to know which binding is the
        // exit one -- DCE conservatively traces past every JsrExt,
        // leaving any post-`exit` dead code in place. The native
        // codegen will emit it as unreachable bytes; no harm done.
        let (fall_through, branch_target) = match ins {
            Insn::NoArg(Op::Lev) => (false, None),
            // `TailExt` is a tail-jump: the libc fn's `RET`
            // returns directly to the c5 caller of the
            // trampoline, not to whatever follows in bytecode.
            // Treat it as a terminator so DCE doesn't trace into
            // the next trampoline (or whatever junk follows).
            Insn::TailExt(_) => (false, None),
            Insn::Branch(kind, t) => (kind.falls_through(), Some(*t)),
            _ => (true, None),
        };
        if fall_through
            && let Some(j) = next_live(insns, i + 1)
            && !visited[j]
        {
            visited[j] = true;
            worklist.push(j);
        }
        if let Some(t) = branch_target
            && t < n
            && !visited[t]
        {
            visited[t] = true;
            worklist.push(t);
        }
    }

    let mut changed = false;
    for (i, ins) in insns.iter_mut().enumerate() {
        if !visited[i] && !ins.is_removed() {
            *ins = Insn::Removed;
            changed = true;
        }
    }
    changed
}

#[cfg(all(test, feature = "std"))]
mod tests {
    //! Hand-built `Program` literals, so each test pins one optimizer
    //! pass. PC layout per test is annotated in a `// PC N:` comment
    //! against each line -- the encoded operand of every branch / Jsr
    //! must point at one of those starts.
    //!
    //! C4 calling conventions reminder used by these tests:
    //!   * `Lev` returns whatever's in the accumulator.
    //!   * `Lea N` computes `bp + N*8`. Local 0 is at `Lea -1`, etc.
    //!   * Stores are `<addr>; Psh; <value>; Si` -- Si pops the address.

    use super::*;
    use crate::Vm;

    fn prog(text: Vec<i64>) -> Program {
        Program {
            text,
            data: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            data_imm_positions: Vec::new(),
            code_imm_positions: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            call_fp_arg_masks: Vec::new(),
            variadic_functions: alloc::collections::BTreeSet::new(),
            data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            dylibs: Vec::new(),
            dllmain_pc: None,
            source_lines: Vec::new(),
            source_functions: Vec::new(),
            source_files: Vec::new(),
            source_file_indices: Vec::new(),
            source_path: String::new(),
            variables: Vec::new(),
            structs: Vec::new(),
            entry_name: None,
            subsystem: None,
            finished_functions: Vec::new(),
        }
    }

    #[test]
    fn imm_equal_to_code_base_is_not_promoted() {
        // A user constant whose value happens to land in
        // `[CODE_BASE, CODE_BASE + text.len())` (e.g. an integer
        // flag literal `0x20000000`, exactly `CODE_BASE`) must
        // survive the optimizer as a plain integer. The empty
        // `code_imm_positions` here means "no compiler-tagged
        // func-ptr literals" -- the only func-ptr-shaped thing in
        // the Program is the entry-Ent at PC 0, which the old
        // value-range heuristic latched onto.
        let p = prog(vec![
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            CODE_BASE as i64,
            Op::Lev as i64,
        ]);
        let opt = optimize(p).unwrap();
        // The interpreter doesn't go through the codegen disambig
        // path, but it does walk `Insn::ImmCode` if we wrongly
        // promoted -- and on a hand-built input with empty
        // `code_imm_positions`, that's the regression we want to
        // pin. Run via VM and assert the constant came through.
        assert_eq!(Vm::new(opt).run().unwrap(), CODE_BASE as i64);
    }

    #[test]
    fn fold_simple_constant_arith() {
        // 2 + 3 = 5
        let p = prog(vec![
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            2,
            Op::Psh as i64,
            Op::Imm as i64,
            3,
            Op::Add as i64,
            Op::Lev as i64,
        ]);
        let original_len = p.text.len();
        let opt = optimize(p).unwrap();
        assert_eq!(Vm::new(opt.clone()).run().unwrap(), 5);
        assert!(opt.text.len() < original_len);
    }

    #[test]
    fn fold_chained_constants() {
        // (1 + 2) * 4 = 12, all folded.
        let p = prog(vec![
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            1,
            Op::Psh as i64,
            Op::Imm as i64,
            2,
            Op::Add as i64,
            Op::Psh as i64,
            Op::Imm as i64,
            4,
            Op::Mul as i64,
            Op::Lev as i64,
        ]);
        let opt = optimize(p).unwrap();
        assert_eq!(Vm::new(opt).run().unwrap(), 12);
    }

    #[test]
    fn branch_on_constant_taken() {
        // a = 1; if (a) goto L; else return 0; L: return 7;
        // PC layout:
        //   0:  Ent 0
        //   2:  Imm 1
        //   4:  Bnz 9        ; target Imm 7
        //   6:  Imm 0
        //   8:  Lev
        //   9:  Imm 7
        //  11:  Lev
        let p = prog(vec![
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            1,
            Op::Bnz as i64,
            9,
            Op::Imm as i64,
            0,
            Op::Lev as i64,
            Op::Imm as i64,
            7,
            Op::Lev as i64,
        ]);
        let opt = optimize(p).unwrap();
        assert_eq!(Vm::new(opt).run().unwrap(), 7);
    }

    #[test]
    fn dce_drops_unreachable_after_jmp() {
        // PC layout:
        //   0:  Ent 0
        //   2:  Jmp 7        ; skip the next two
        //   4:  Imm 99       ; dead
        //   6:  Lev          ; dead
        //   7:  Imm 3
        //   9:  Lev
        let p = prog(vec![
            Op::Ent as i64,
            0,
            Op::Jmp as i64,
            7,
            Op::Imm as i64,
            99,
            Op::Lev as i64,
            Op::Imm as i64,
            3,
            Op::Lev as i64,
        ]);
        let original_len = p.text.len();
        let opt = optimize(p).unwrap();
        assert_eq!(Vm::new(opt.clone()).run().unwrap(), 3);
        assert!(opt.text.len() < original_len);
    }

    #[test]
    fn immediate_arith_fusion_runs_correctly() {
        // int x; x = 10; return x + 5;
        // PC layout:
        //   0:  Ent 1        ; 1 local
        //   2:  Lea -1       ; &x
        //   4:  Psh
        //   5:  Imm 10
        //   7:  Si           ; *(&x) = 10
        //   8:  Lea -1       ; &x
        //  10:  Li           ; a = x
        //  11:  Psh
        //  12:  Imm 5
        //  14:  Add
        //  15:  Lev
        let p = prog(vec![
            Op::Ent as i64,
            1,
            Op::Lea as i64,
            -1,
            Op::Psh as i64,
            Op::Imm as i64,
            10,
            Op::Si as i64,
            Op::Lea as i64,
            -1,
            Op::Li as i64,
            Op::Psh as i64,
            Op::Imm as i64,
            5,
            Op::Add as i64,
            Op::Lev as i64,
        ]);
        let opt = optimize(p).unwrap();
        assert_eq!(Vm::new(opt.clone()).run().unwrap(), 15);
        // Verify fusion happened: AddI op should appear in the text.
        assert!(
            opt.text.contains(&(Op::AddI as i64)),
            "expected AddI in optimized text {:?}",
            opt.text
        );
    }

    #[test]
    fn local_load_fusion_runs_correctly() {
        // int x; x = 42; return x;
        let p = prog(vec![
            Op::Ent as i64,
            1,
            Op::Lea as i64,
            -1,
            Op::Psh as i64,
            Op::Imm as i64,
            42,
            Op::Si as i64,
            Op::Lea as i64,
            -1,
            Op::Li as i64,
            Op::Lev as i64,
        ]);
        let opt = optimize(p).unwrap();
        assert_eq!(Vm::new(opt.clone()).run().unwrap(), 42);
        assert!(
            opt.text.contains(&(Op::LdLocI as i64)),
            "expected LdLocI in optimized text {:?}",
            opt.text
        );
    }

    #[test]
    fn branch_threading_collapses_chain() {
        // PC layout:
        //   0:  Ent 0
        //   2:  Jmp 7        ; -> L1
        //   4:  Imm 0        ; dead
        //   6:  Lev          ; dead
        //   7:  L1: Jmp 12   ; -> L2
        //   9:  Imm 0        ; dead
        //  11: Lev           ; dead
        //  12:  L2: Imm 9
        //  14:  Lev
        let p = prog(vec![
            Op::Ent as i64,
            0,
            Op::Jmp as i64,
            7,
            Op::Imm as i64,
            0,
            Op::Lev as i64,
            Op::Jmp as i64,
            12,
            Op::Imm as i64,
            0,
            Op::Lev as i64,
            Op::Imm as i64,
            9,
            Op::Lev as i64,
        ]);
        let opt = optimize(p).unwrap();
        assert_eq!(Vm::new(opt).run().unwrap(), 9);
    }

    #[test]
    fn function_pointer_target_remaps_after_dce() {
        // main calls add directly; we also take &add as a value to make
        // sure ImmCode operands get re-resolved through the new PC map
        // when DCE shifts add's location.
        // PC layout:
        //   0:  Ent 0
        //   2:  Jmp 6        ; skip dead block
        //   4:  Imm 999      ; dead -- DCE should drop
        //   6:  Imm <CODE_BASE+12>  ; &add (will be remapped)
        //   8:  Adj 1        ; drop the temporary &add
        //  10:  Jsr 12       ; call add
        //  12:  Lev          ; main returns add's result
        //  13:  Ent 0        ; add: returns 7
        //  15:  Imm 7
        //  17:  Lev
        // Wait -- Jsr returns to PC 12 (after the operand at 11), which
        // is `Lev`. Good. Then Adj 1 doesn't fit in this layout -- drop
        // it and just verify the ImmCode survives.
        // Simpler layout:
        //   0:  Ent 0
        //   2:  Jmp 6
        //   4:  Imm 999      ; dead
        //   6:  Imm <CODE_BASE+10>  ; &add  -- kept just to test remap
        //   8:  Jsr 10       ; call add
        //  10:  Ent 0        ; add -- but we'd come back here and infinite-loop
        // No -- Jsr's return address is the PC AFTER the operand (i.e.
        // the byte right after PC 9). In our layout PC 10 is `Ent`,
        // so the return would land mid-add. Need a Lev before add.
        // Final layout:
        //   0:  Ent 0
        //   2:  Imm <CODE_BASE+9>   ; take &add -> keep ImmCode alive
        //   4:  Jsr 9               ; call add
        //   6:  Imm 5               ; ignore the &add we computed (a = 5)
        //   8:  Lev                 ; main returns 5
        //   9:  Ent 0               ; add
        //  11:  Imm 7
        //  13:  Lev
        let text = vec![
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            (CODE_BASE + 9) as i64,
            Op::Jsr as i64,
            9,
            Op::Imm as i64,
            5,
            Op::Lev as i64,
            Op::Ent as i64,
            0,
            Op::Imm as i64,
            7,
            Op::Lev as i64,
        ];
        let p = Program {
            text,
            data: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            data_imm_positions: Vec::new(),
            code_imm_positions: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            call_fp_arg_masks: Vec::new(),
            variadic_functions: alloc::collections::BTreeSet::new(),
            data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            dylibs: Vec::new(),
            dllmain_pc: None,
            source_lines: Vec::new(),
            source_functions: Vec::new(),
            source_files: Vec::new(),
            source_file_indices: Vec::new(),
            source_path: String::new(),
            variables: Vec::new(),
            structs: Vec::new(),
            entry_name: None,
            subsystem: None,
            finished_functions: Vec::new(),
        };
        let opt = optimize(p).unwrap();
        // Main returns 5; if the ImmCode operand remapped wrong, the
        // call would land in nowhere-land and either crash or return
        // garbage. Round-trip the program so we know the encoder rebuilt
        // a valid CODE_BASE | new_pc word.
        assert_eq!(Vm::new(opt.clone()).run().unwrap(), 5);
        // Find the surviving Imm <code_addr>; check it points at the
        // (new) Ent of add.
        let code_imm = opt
            .text
            .windows(2)
            .find_map(|w| {
                if w[0] == Op::Imm as i64 && (w[1] as usize) >= CODE_BASE {
                    Some(w[1] as usize - CODE_BASE)
                } else {
                    None
                }
            })
            .expect("optimized text should still contain &add");
        assert_eq!(opt.text[code_imm], Op::Ent as i64);
    }
}

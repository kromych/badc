//! SSA-source selector for the codegen backends. The walker
//! drives every parsed function via its captured AST snapshot;
//! pre-built `synthetic_ssa_funcs` (sys-trampolines, CRT entry)
//! and `user_ssa_funcs` (archive reload) come through directly.

use crate::c5::Target;
use crate::c5::error::C5Error;
use crate::c5::ir::FunctionSsa;
use crate::c5::program::Program;
use alloc::vec::Vec;

/// Walks every entry in `program.finished_functions` through
/// [`crate::c5::ast::walk::walk_function`] and returns one
/// `FunctionSsa` per source function in `ent_pc` order. Sys
/// trampolines and the synthetic CRT entry don't go through
/// the AST walker; the caller layers them on from
/// `program.synthetic_ssa_funcs` after this returns.
pub(crate) fn walk_program(program: &Program, target: Target) -> Result<Vec<FunctionSsa>, C5Error> {
    // Walker entries from AST snapshots, keyed by ent_pc.
    let mut walker_pcs: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let mut out: Vec<FunctionSsa> = Vec::with_capacity(program.finished_functions.len());
    let mut ordered: Vec<usize> = (0..program.finished_functions.len()).collect();
    ordered.sort_by_key(|&i| program.finished_functions[i].ent_pc);
    for i in ordered {
        let f = &program.finished_functions[i];
        walker_pcs.insert(f.ent_pc);
        let mut func = crate::c5::ast::walk::walk_function(
            &f.ast,
            &program.symbols,
            &program.structs,
            target,
            f.ent_pc,
            f.end_pc,
            f.n_params,
            f.is_variadic,
            f.n_locals,
            &f.param_tys,
            &f.param_local_slots,
            f.returns_struct,
            f.return_struct_size,
            f.return_ty,
            f.alloca_top_slot,
        )
        .map_err(|e| {
            C5Error::Compile(crate::c5::error::fmt_internal_err(&alloc::format!(
                "ast::walk: function `{}` (ent_pc={}): {}",
                f.name,
                f.ent_pc,
                e,
            )))
        })?;
        func.name = f.name.clone();
        func.is_inline = f.is_inline;
        // Seed declared multi-cell extents alongside the synthetic ones the
        // walker recorded. Slot coalescing reserves every interior cell.
        func.multi_cell_slots.extend_from_slice(&f.multi_cell_slots);
        // `n_params` on FinishedFunction is the parser's
        // declared count. The codegen prologue spills the
        // matching host-arg regs into slots [2, 2+n). Use the
        // max of the declared count and the touched count
        // (`walker_param_count`): a struct-by-value param
        // wraps its slot-2 read inside the entry-Mcpy whose
        // dst is `slot -N`, so the touched scan would miss
        // slot 2 and the codegen wouldn't spill the host arg
        // -- the callee then reads junk for the struct
        // address.
        let touched = walker_param_count(&func);
        func.n_params = touched.max(f.n_params);
        out.push(func);
    }
    // Parser-emitted helpers (sys-trampolines) come through
    // `program.synthetic_ssa_funcs`. `program.user_ssa_funcs`
    // carries every other walker-translated function not present
    // in `finished_functions`. Merge both into the output, keyed
    // by ent_pc to keep the entry-per-PC invariant.
    let mut covered_pcs: alloc::collections::BTreeSet<usize> = walker_pcs.iter().copied().collect();
    for f in &program.synthetic_ssa_funcs {
        if covered_pcs.insert(f.ent_pc) {
            out.push(f.clone());
        }
    }
    for f in &program.user_ssa_funcs {
        if covered_pcs.insert(f.ent_pc) {
            out.push(f.clone());
        }
    }
    out.sort_by_key(|f| f.ent_pc);
    drop_unreachable_statics(&mut out, program);
    Ok(out)
}

/// Drop every `FunctionSsa` whose ent_pc is unreachable from the
/// program's static-DCE roots. Roots are the entry point (`main`),
/// every externally-linked function (`Linkage::External` /
/// `Linkage::None`), and every name starting with `_` (the gcc /
/// clang -Wunused-function convention -- treated as deliberately
/// retained, matching what `warn_unused_static_functions`
/// exempts). Anything transitively reachable from a root via
/// `Inst::Call` or `Inst::ImmCode` survives. `Inst::CallIndirect`
/// is handled conservatively: any function whose address appears
/// in `Inst::ImmCode` is already marked reachable, so an indirect
/// dispatch cannot reach a function the marker hasn't seen.
fn drop_unreachable_statics(funcs: &mut Vec<FunctionSsa>, program: &Program) {
    use crate::c5::ir::Inst;
    use crate::c5::symbol::Linkage;
    use crate::c5::token::Token;

    let mut linkage_by_name: alloc::collections::BTreeMap<&str, Linkage> =
        alloc::collections::BTreeMap::new();
    for sym in &program.symbols {
        if sym.class == Token::Fun as i64 && !sym.name.is_empty() {
            linkage_by_name.insert(sym.name.as_str(), sym.linkage);
        }
    }

    let mut by_pc: alloc::collections::BTreeMap<usize, usize> = alloc::collections::BTreeMap::new();
    for (i, f) in funcs.iter().enumerate() {
        by_pc.insert(f.ent_pc, i);
    }

    let mut reachable: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let mut queue: alloc::vec::Vec<usize> = alloc::vec::Vec::new();

    for f in funcs.iter() {
        let is_root = f.name == "main"
            || f.name.starts_with('_')
            || matches!(
                linkage_by_name.get(f.name.as_str()).copied(),
                Some(Linkage::External) | Some(Linkage::None)
            );
        if is_root {
            queue.push(f.ent_pc);
        }
    }
    // Static initialisers of the form `int (*fp)(int) = some_fn;`
    // park the target's ent_pc in `program.code_relocs` (the slot
    // is patched at link / load time). Treat each entry as a root
    // so the function whose address sits in the data segment
    // survives DCE even when it has no in-text call site.
    for r in &program.code_relocs {
        queue.push(r.target_ent_pc as usize);
    }
    // Every export name binds a function. Treat as a root so
    // `#pragma export(<name>)` keeps the body around when the
    // user's source has no in-image call site.
    for e in &program.exports {
        queue.push(e.ent_pc);
    }

    while let Some(pc) = queue.pop() {
        if !reachable.insert(pc) {
            continue;
        }
        let Some(&idx) = by_pc.get(&pc) else { continue };
        for inst in &funcs[idx].insts {
            match inst {
                Inst::Call { target_pc, .. } => queue.push(*target_pc),
                Inst::ImmCode(target_pc) => queue.push(*target_pc),
                _ => {}
            }
        }
    }

    funcs.retain(|f| {
        let keep = reachable.contains(&f.ent_pc);
        #[cfg(feature = "codegen_test")]
        if !keep && std::env::var("BADC_DEBUG_STATIC_DCE").is_ok() {
            std::eprintln!(
                "[static_dce] dropping unreachable function `{}` ent_pc={}",
                f.name,
                f.ent_pc,
            );
        }
        keep
    });
}

/// SSA-source pick for the codegen backends and the Vm. Two
/// sources, in priority order:
///
///   1. `program.finished_functions` non-empty -> walk_program
///      walks each AST snapshot. The in-memory compile+link
///      path takes this branch.
///
///   2. `program.user_ssa_funcs` or `program.synthetic_ssa_funcs`
///      non-empty -> the linker merged per-unit walker output.
///      Combine the user and synthetic vectors (sys-trampolines +
///      synthetic CRT entry). The archive-reload path of every
///      `.o` produced after the walker became canonical takes
///      this branch.
///
/// Programs with neither populated (the empty-text writer
/// fixtures) return an empty `Vec`.
pub(crate) fn produce_ssa_funcs(
    program: &Program,
    target: Target,
) -> Result<Vec<FunctionSsa>, C5Error> {
    if !program.finished_functions.is_empty() {
        let mut funcs = walk_program(program, target)?;
        // C99 6.2.2: a function with internal linkage that no reachable
        // code or data references is unobservable; drop it before codegen
        // so the unused `static inline` helpers headers pull into every
        // unit do not reach the image.
        let live = compute_live_functions(&funcs, program);
        funcs.retain(|f| live.contains(&f.ent_pc));
        #[cfg(feature = "std")]
        measure_dead_data(&funcs, program);
        return Ok(funcs);
    }
    if !program.user_ssa_funcs.is_empty() || !program.synthetic_ssa_funcs.is_empty() {
        let mut covered: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
        let mut out: Vec<FunctionSsa> =
            Vec::with_capacity(program.user_ssa_funcs.len() + program.synthetic_ssa_funcs.len());
        for f in &program.user_ssa_funcs {
            if covered.insert(f.ent_pc) {
                out.push(f.clone());
            }
        }
        for f in &program.synthetic_ssa_funcs {
            if covered.insert(f.ent_pc) {
                out.push(f.clone());
            }
        }
        out.sort_by_key(|f| f.ent_pc);
        return Ok(out);
    }
    Ok(Vec::new())
}

/// Reachable user functions: the set of `ent_pc`s the program can reach.
/// Roots are externally-visible functions (C99 6.2.2 external linkage --
/// callable from another unit) and functions whose address is stored in
/// the data segment (dispatch tables, via `code_relocs`). From the roots,
/// a function's direct calls (`Inst::Call`) and address-of references
/// (`Inst::ImmCode`) keep their targets reachable. A function absent from
/// the result has internal linkage and no reference path, so it can be
/// dropped before codegen.
pub(crate) fn compute_live_functions(
    funcs: &[FunctionSsa],
    program: &Program,
) -> alloc::collections::BTreeSet<usize> {
    use crate::c5::ir::Inst;
    use crate::c5::symbol::Linkage;
    use crate::c5::token::Token;
    use alloc::collections::{BTreeMap, BTreeSet};

    let by_ent: BTreeMap<usize, &FunctionSsa> = funcs.iter().map(|f| (f.ent_pc, f)).collect();
    let mut live: BTreeSet<usize> = BTreeSet::new();
    let mut work: alloc::vec::Vec<usize> = alloc::vec::Vec::new();

    for s in &program.symbols {
        if s.class == Token::Fun as i64
            && matches!(s.linkage, Linkage::External)
            && by_ent.contains_key(&(s.val as usize))
            && live.insert(s.val as usize)
        {
            work.push(s.val as usize);
        }
    }
    for r in &program.code_relocs {
        let ent = r.target_ent_pc as usize;
        if by_ent.contains_key(&ent) && live.insert(ent) {
            work.push(ent);
        }
    }
    while let Some(ent) = work.pop() {
        let Some(f) = by_ent.get(&ent) else { continue };
        for inst in &f.insts {
            let target = match inst {
                Inst::Call { target_pc, .. } => Some(*target_pc),
                Inst::ImmCode(t) => Some(*t),
                _ => None,
            };
            if let Some(t) = target
                && by_ent.contains_key(&t)
                && live.insert(t)
            {
                work.push(t);
            }
        }
    }
    live
}

/// Sorted data-object start offsets and a per-object live flag, shared by
/// the data-DCE measurement and the compaction prune so the two cannot
/// disagree on what is reachable. Objects are the `[starts[i],
/// starts[i+1])` intervals (the last running to `data_len`) of the sorted
/// union of `Program::data_object_starts` (anonymous literals) and the
/// named-global offsets (`symbols[..].val`).
///
/// `Inst::ImmData` in a surviving function is the only code->data edge
/// (string literals, global addresses, and aggregate-initializer
/// templates all lower through it); `data_relocs` are the data->data
/// edges. Roots are those edges plus externally-linked globals,
/// relocation slots, and the leading NULL guard (object 0). Marking is
/// conservative: a referenced object is never reported dead.
fn live_data_intervals(
    funcs: &[FunctionSsa],
    program: &Program,
    data_len: i64,
) -> (Vec<i64>, Vec<bool>) {
    use crate::c5::ir::Inst;
    use crate::c5::symbol::Linkage;
    use crate::c5::token::Token;
    use alloc::collections::BTreeSet;

    let mut start_set: BTreeSet<i64> = BTreeSet::new();
    start_set.insert(0);
    for &s in &program.data_object_starts {
        if (0..data_len).contains(&s) {
            start_set.insert(s);
        }
    }
    for sym in &program.symbols {
        if sym.class == Token::Glo as i64 && sym.defined_here && (0..data_len).contains(&sym.val) {
            start_set.insert(sym.val);
        }
    }
    let starts: Vec<i64> = start_set.into_iter().collect();
    let n = starts.len();
    let interval_of = |off: i64| -> usize {
        match starts.binary_search(&off) {
            Ok(i) => i,
            Err(i) => i.saturating_sub(1),
        }
    };

    let mut live = alloc::vec![false; n];
    // The 8-byte NULL guard at offset 0 must stay at offset 0 so a data
    // pointer is never confused with NULL.
    if n > 0 {
        live[0] = true;
    }
    for f in funcs {
        for inst in &f.insts {
            if let Inst::ImmData(off) = inst
                && (0..data_len).contains(off)
            {
                live[interval_of(*off)] = true;
            }
        }
    }
    for sym in &program.symbols {
        if sym.class == Token::Glo as i64
            && sym.defined_here
            && matches!(sym.linkage, Linkage::External)
            && (0..data_len).contains(&sym.val)
        {
            live[interval_of(sym.val)] = true;
        }
    }
    for off in program
        .code_relocs
        .iter()
        .map(|r| r.data_offset as i64)
        .chain(
            program
                .extern_data_relocs
                .iter()
                .map(|r| r.data_offset as i64),
        )
    {
        if (0..data_len).contains(&off) {
            live[interval_of(off)] = true;
        }
    }
    let edges: Vec<(usize, usize)> = program
        .data_relocs
        .iter()
        .filter(|r| (r.data_offset as i64) < data_len && (r.target_offset as i64) < data_len)
        .map(|r| {
            (
                interval_of(r.data_offset as i64),
                interval_of(r.target_offset as i64),
            )
        })
        .collect();
    let mut changed = true;
    while changed {
        changed = false;
        for &(src, dst) in &edges {
            if live[src] && !live[dst] {
                live[dst] = true;
                changed = true;
            }
        }
    }
    (starts, live)
}

/// New packed offset for a data byte at `off`, given the sorted object
/// `starts` and each object's packed base (`new_base[i] < 0` for a
/// dropped object). An offset outside `[0, data_len)` passes through
/// (e.g. the extern-import `ImmData(0)` sentinel maps to 0). A live
/// reference always lands in a kept object by construction; a dropped
/// object is only named from unreferenced nodes and maps to 0.
fn remap_data_off(off: i64, starts: &[i64], new_base: &[i64], data_len: i64) -> i64 {
    if !(0..data_len).contains(&off) {
        return off;
    }
    let i = match starts.binary_search(&off) {
        Ok(i) => i,
        Err(i) => i.saturating_sub(1),
    };
    if new_base[i] < 0 {
        return 0;
    }
    new_base[i] + (off - starts[i])
}

/// C99 6.2.2 / 6.7.8: return a copy of `program` whose `.data` holds only
/// the objects a surviving function or relocation can reach, every offset
/// surface rewritten to the packed layout. The static function prune has
/// already removed unreferenced functions; this drops the string literals
/// and `__func__` arrays that only those functions named. Live objects
/// keep their 8-byte alignment (the maximum badc lays `.data` out at) by
/// aligning each packed interval base. `tls_data` is a separate segment
/// and is left unchanged.
pub(crate) fn compact_program_data(
    program: &Program,
    target: Target,
    segregate: bool,
) -> Result<(Program, i64), C5Error> {
    use crate::c5::token::Token;

    let data_len = program.data.len() as i64;
    if data_len == 0 || program.finished_functions.is_empty() {
        return Ok((program.clone(), 0));
    }
    #[cfg(feature = "std")]
    if std::env::var("BADC_NO_DATA_DCE").is_ok() {
        return Ok((program.clone(), 0));
    }
    let funcs = produce_ssa_funcs(program, target)?;
    let live_func_pcs: alloc::collections::BTreeSet<usize> =
        funcs.iter().map(|f| f.ent_pc).collect();
    let (starts, live) = live_data_intervals(&funcs, program, data_len);
    let n = starts.len();

    // Each kept object moves to a new base congruent to its old start
    // modulo `ALIGN`, so every byte keeps its original alignment residue.
    // This holds even when adjacent objects share an interval (an object
    // whose start the parser did not record glues onto its predecessor):
    // the relative layout inside the copied span is preserved, and a
    // congruent base preserves the absolute alignment of every object in
    // it. badc lays `.data` out at 8-byte alignment; 16 covers any
    // wider scalar without measurable padding cost.
    const ALIGN: i64 = 16;
    let obj_end = |i: usize| -> i64 { if i + 1 < n { starts[i + 1] } else { data_len } };
    // A relocation writes a (generally non-zero) value into its slot at
    // link/write time, so the slot's object is initialised data even when
    // its bytes are zero in `program.data` (a function-pointer slot, or a
    // pointer whose stored placeholder is its target offset). Such objects
    // stay file-backed: the writer patches the slot in the file image.
    let interval_of = |off: i64| -> usize {
        match starts.binary_search(&off) {
            Ok(i) => i,
            Err(i) => i.saturating_sub(1),
        }
    };
    let mut has_reloc_slot = alloc::vec![false; n];
    for off in program
        .data_relocs
        .iter()
        .map(|r| r.data_offset as i64)
        .chain(program.code_relocs.iter().map(|r| r.data_offset as i64))
        .chain(
            program
                .extern_data_relocs
                .iter()
                .map(|r| r.data_offset as i64),
        )
    {
        if (0..data_len).contains(&off) {
            has_reloc_slot[interval_of(off)] = true;
        }
    }
    // Object 0 spans the leading NULL guard and must stay file-backed at
    // offset 0 so `remap(0) == 0` (the extern `ImmData(0)` sentinel and
    // VM NULL-distinctness both depend on it). Every other live object
    // whose bytes are all zero is uninitialised data: it carries no file
    // bytes and moves to the `.bss` region past the file image, which the
    // loader zero-fills. A partly-non-zero object keeps its interior zeros
    // in the file -- only wholly-zero objects can move.
    // Segregation is on by default; with it off (`segregate == false`,
    // the `BADC_NO_BSS_SEGREGATE` opt-out or a target whose writer does
    // not support it), every live object (zero or not) is packed into the
    // file image as before and `bss_size` stays 0. The caller sets it.
    let is_bss = |i: usize| -> bool {
        segregate
            && i != 0
            && live[i]
            && !has_reloc_slot[i]
            && program.data[starts[i] as usize..obj_end(i) as usize]
                .iter()
                .all(|&b| b == 0)
    };

    let mut new_base = alloc::vec![-1i64; n];
    let mut new_data: Vec<u8> = Vec::with_capacity(program.data.len());
    for i in 0..n {
        if live[i] && !is_bss(i) {
            let want = starts[i].rem_euclid(ALIGN);
            while (new_data.len() as i64).rem_euclid(ALIGN) != want {
                new_data.push(0);
            }
            new_base[i] = new_data.len() as i64;
            new_data.extend_from_slice(&program.data[starts[i] as usize..obj_end(i) as usize]);
        }
    }
    // The `.bss` region begins immediately past the file image; an offset
    // into it is `>= new_data.len()`, which each writer maps to a vaddr the
    // loader zero-fills (p_memsz > p_filesz / VirtualSize > SizeOfRawData /
    // vmsize > filesize). Align its base to `ALIGN`: the linker and the
    // per-format writers address `.bss` relative to its own base, so each
    // object's bss-relative offset must carry the same alignment residue
    // as its `.data` offset, which only holds when the base is aligned.
    if (0..n).any(&is_bss) {
        while (new_data.len() as i64).rem_euclid(ALIGN) != 0 {
            new_data.push(0);
        }
    }
    let bss_base = new_data.len() as i64;
    let mut bss_cursor = bss_base;
    for i in 0..n {
        if is_bss(i) {
            let want = starts[i].rem_euclid(ALIGN);
            while bss_cursor.rem_euclid(ALIGN) != want {
                bss_cursor += 1;
            }
            new_base[i] = bss_cursor;
            bss_cursor += obj_end(i) - starts[i];
        }
    }
    let bss_size = bss_cursor - bss_base;
    let map = |off: i64| remap_data_off(off, &starts, &new_base, data_len);

    let mut out = program.clone();
    out.data = new_data;
    out.finished_functions
        .retain(|f| live_func_pcs.contains(&f.ent_pc));
    for sym in &mut out.symbols {
        // A `_Thread_local` symbol's `val` is an offset into the separate
        // TLS image, not `.data`, so it must not pass through the `.data`
        // remap (mirrors `for_each_data_offset`, which skips them).
        if sym.class == Token::Glo as i64
            && sym.defined_here
            && !sym.is_thread_local
            && (0..data_len).contains(&sym.val)
        {
            sym.val = map(sym.val);
        }
    }
    for r in &mut out.data_relocs {
        r.data_offset = map(r.data_offset as i64) as u64;
        r.target_offset = map(r.target_offset as i64) as u64;
    }
    for r in &mut out.code_relocs {
        r.data_offset = map(r.data_offset as i64) as u64;
    }
    for r in &mut out.extern_data_relocs {
        r.data_offset = map(r.data_offset as i64) as u64;
    }
    for f in &mut out.finished_functions {
        f.ast.remap_data_offsets(&map);
    }
    out.data_object_starts.retain(|&s| {
        (0..data_len).contains(&s) && {
            let i = match starts.binary_search(&s) {
                Ok(i) => i,
                Err(i) => i.saturating_sub(1),
            };
            live[i]
        }
    });
    for s in &mut out.data_object_starts {
        *s = map(*s);
    }
    Ok((out, bss_size))
}

/// Read-only measurement of statically-dead data objects (no mutation,
/// no effect on codegen). Emits one line per translation unit to the
/// path in `BADC_DATA_DCE_LOG` when that variable is set, validating the
/// object-boundary model and the achievable `.data` reduction.
///
/// Objects are the `[start, next_start)` intervals of the sorted union of
/// `Program::data_object_starts` (anonymous literals) and the named-global
/// offsets (`symbols[..].val`). An interval is live if reached from a root
/// -- an `Inst::ImmData` in a surviving function, an externally-linked
/// named global, or a relocation slot -- or, transitively, from a live
/// object holding a data pointer (`data_relocs`). Marking is conservative:
/// it never reports a referenced object dead.
#[cfg(feature = "std")]
fn measure_dead_data(funcs: &[FunctionSsa], program: &Program) {
    use std::io::Write;

    let Ok(log_path) = std::env::var("BADC_DATA_DCE_LOG") else {
        return;
    };
    let data_len = program.data.len() as i64;
    if data_len == 0 {
        return;
    }
    let (starts, live) = live_data_intervals(funcs, program, data_len);
    let n = starts.len();

    let mut dead_bytes: i64 = 0;
    let mut dead_objs = 0usize;
    for i in 0..n {
        let end = if i + 1 < n { starts[i + 1] } else { data_len };
        if !live[i] {
            dead_bytes += end - starts[i];
            dead_objs += 1;
        }
    }
    let line = alloc::format!(
        "{} total={} dead={} objs={} dead_objs={}\n",
        program.source_path,
        data_len,
        dead_bytes,
        n,
        dead_objs,
    );
    if let Ok(mut f) = std::fs::OpenOptions::new()
        .create(true)
        .append(true)
        .open(&log_path)
    {
        let _ = f.write_all(line.as_bytes());
    }
}

/// Maximum param slot the function reads or writes. C5's
/// calling convention places declared param `i` (0-indexed) at
/// frame slot `i + 2`; the codegen prologue spills the matching
/// argument register into that slot. Returns the *touched*
/// count -- a declared-but-unused param is dropped so the frame
/// matches the body's actual reads.
fn walker_param_count(func: &FunctionSsa) -> usize {
    use crate::c5::ir::Inst;
    let mut max_seen: Option<i64> = None;
    for inst in &func.insts {
        let slot = match inst {
            Inst::LoadLocal { off, .. } => Some(*off),
            Inst::StoreLocal { off, .. } => Some(*off),
            Inst::LocalAddr(off) => Some(*off),
            _ => None,
        };
        if let Some(s) = slot
            && s >= 2
        {
            max_seen = Some(max_seen.map_or(s, |m| m.max(s)));
        }
    }
    // Param `i` (0-indexed) sits at slot `i + 2`, so the count
    // is `max_slot - 1` (e.g. only slot 2 touched -> 1 param).
    match max_seen {
        Some(s) => (s - 1).max(0) as usize,
        None => 0,
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::Compiler;
    use crate::c5::program::Program;
    use crate::c5::tests::with_prelude;

    fn compile(src: &str, target: Target) -> Program {
        Compiler::with_target(with_prelude(src), target)
            .compile()
            .expect("compile")
    }

    // A wholly-zero global referenced by a pointer initializer moves to
    // the `.bss` region under segregation, dropping its file bytes. The
    // region base (the file-image length) is ALIGN-aligned so each
    // object's bss-relative offset keeps the alignment residue of its
    // `.data` offset.
    #[test]
    fn segregate_moves_zero_global_to_aligned_bss() {
        let target = Target::LinuxX64;
        let src = "static long g[8]; long *const gp = &g[3]; \
                   int main(void) { return gp == &g[3] ? 0 : 1; }";
        let program = compile(src, target);

        let (_, bss_off) = compact_program_data(&program, target, false).expect("compact");
        assert_eq!(bss_off, 0, "no bss region when segregation is off");

        let (compacted, bss_size) = compact_program_data(&program, target, true).expect("compact");
        assert!(bss_size > 0, "the zero global must occupy the bss region");
        assert_eq!(
            compacted.data.len() % 16,
            0,
            "bss base (= file image length) must be 16-aligned"
        );
        let data_len = compacted.data.len() as u64;
        assert!(
            compacted
                .data_relocs
                .iter()
                .any(|r| r.target_offset >= data_len),
            "the &g[3] initializer must target a byte in the bss region"
        );
    }
}

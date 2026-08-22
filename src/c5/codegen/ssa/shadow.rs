//! SSA-source selector for the codegen backends. The walker
//! drives every parsed function via its captured AST snapshot;
//! pre-built `synthetic_ssa_funcs` (sys-trampolines, CRT entry)
//! and `user_ssa_funcs` (archive reload) come through directly.

use crate::c5::Target;
use crate::c5::error::C5Error;
use crate::c5::ir::FunctionSsa;
use crate::c5::program::Program;
use alloc::vec::Vec;

/// Names that bind STB_WEAK as function definitions: `__attribute__((weak))`
/// carriers and file-scope asm `.weak` names. Mirrors the set the object
/// writers use to pick the symbol binding.
fn weak_function_names(program: &Program) -> alloc::collections::BTreeSet<&str> {
    use crate::c5::token::Token;
    program
        .symbols
        .iter()
        .filter(|s| s.is_weak && s.class == Token::Fun as i64 && !s.name.is_empty())
        .map(|s| s.def_link_name())
        .chain(program.asm_weak_names.iter().map(|s| s.as_str()))
        .collect()
}

/// Explicit `__attribute__((section))` placement per defined function.
fn function_sections(
    program: &Program,
) -> alloc::collections::BTreeMap<&str, &alloc::string::String> {
    use crate::c5::token::Token;
    program
        .symbols
        .iter()
        .filter(|s| s.class == Token::Fun as i64 && s.defined_here)
        .filter_map(|s| Some((s.def_link_name(), s.section_name.as_ref()?)))
        .collect()
}

/// Assembler name per function identifier the unit emits under a name
/// other than the identifier: a GNU asm label, or an inline definition's
/// private body name. Only renamed entries appear; every other function
/// emits under its identifier.
fn renamed_functions(
    program: &Program,
) -> alloc::collections::BTreeMap<&str, &alloc::string::String> {
    use crate::c5::token::Token;
    program
        .symbols
        .iter()
        .filter(|s| s.class == Token::Fun as i64 && !s.name.is_empty())
        .filter_map(|s| {
            Some((
                s.name.as_str(),
                s.inline_body_name.as_ref().or(s.asm_name.as_ref())?,
            ))
        })
        .collect()
}

/// Names of function definitions with internal linkage (C99 6.2.2).
fn internal_function_names(program: &Program) -> alloc::collections::BTreeSet<&str> {
    use crate::c5::symbol::Linkage;
    use crate::c5::token::Token;
    program
        .symbols
        .iter()
        .filter(|s| {
            s.linkage == Linkage::Internal
                && s.class == Token::Fun as i64
                && s.defined_here
                && !s.name.is_empty()
        })
        .map(|s| s.def_link_name())
        .collect()
}

/// Walks every entry in `program.finished_functions` through
/// [`crate::c5::ast::walk::walk_function`] and returns one
/// `FunctionSsa` per source function in `ent_pc` order. Sys
/// trampolines and the synthetic CRT entry don't go through
/// the AST walker; the caller layers them on from
/// `program.synthetic_ssa_funcs` after this returns.
pub(crate) fn walk_program(
    program: &Program,
    target: Target,
    optimize: bool,
    jump_tables: bool,
) -> Result<Vec<FunctionSsa>, C5Error> {
    // Walker entries from AST snapshots, keyed by ent_pc.
    let mut walker_pcs: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let weak_names = weak_function_names(program);
    let internal_names = internal_function_names(program);
    let sections = function_sections(program);
    let renamed = renamed_functions(program);
    let mut out: Vec<FunctionSsa> = Vec::with_capacity(program.finished_functions.len());
    let mut ordered: Vec<usize> = (0..program.finished_functions.len()).collect();
    ordered.sort_by_key(|&i| program.finished_functions[i].ent_pc);
    for i in ordered {
        let f = &program.finished_functions[i];
        walker_pcs.insert(f.ent_pc);
        let mut func = crate::c5::ast::walk::walk_function(
            f,
            &program.symbols,
            &program.structs,
            target,
            optimize,
            jump_tables,
        )
        .map_err(|e| {
            // A deliberate rejection is an ordinary diagnostic; the
            // `internal compiler error` marker stays reserved for a broken
            // invariant, which also reports the offending node.
            C5Error::Compile(if e.is_internal() {
                crate::c5::error::fmt_internal_err(&alloc::format!(
                    "ast::walk: function `{}` (ent_pc={}): {}",
                    f.name,
                    f.ent_pc,
                    e,
                ))
            } else {
                crate::c5::error::fmt_unsupported_err(&alloc::format!(
                    "in function `{}`: {}",
                    f.name,
                    e,
                ))
            })
        })?;
        // `FunctionSsa::name` is the assembler name from here down: it feeds
        // `Build::func_names`, every writer's symbol table, and the bare-name
        // lookup an inline-asm `call`/`bl` resolves against. The identifier
        // stays available through `Program::symbols` for DWARF.
        func.name = renamed
            .get(f.name.as_str())
            .map_or_else(|| f.name.clone(), |n| (*n).clone());
        func.is_inline = f.is_inline;
        func.is_always_inline = f.is_always_inline;
        func.is_noinline = f.is_noinline;
        func.is_naked = f.is_naked;
        func.is_weak = weak_names.contains(func.name.as_str());
        func.is_internal = internal_names.contains(func.name.as_str());
        func.section = sections.get(func.name.as_str()).map(|s| (*s).clone());
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
    // Correctness cleanup at every optimization level, before the
    // caller's static DCE reads the call graph: fold constant-condition
    // branches the walker could not drop (constant loop conditions)
    // and delete the unreachable blocks they orphan -- including the
    // tails sealed off behind `noreturn` calls -- so a dead arm's
    // calls neither pin a static function nor lower into calls
    // and relocations against symbols the program never references.
    // The fixed point also resolves a merge phi that a pruned branch
    // collapses to one incoming. The -O pipeline reruns this post-inline.
    crate::c5::codegen::passes::simplify_branches::run(&mut out);
    Ok(out)
}

/// Bodies handed to a lowering in place of the AST walk, plus the frame
/// slots the passes that produced them promoted out (the debug-info
/// emitter drops those stale locations).
#[derive(Debug, Default)]
pub(crate) struct PrebuiltSsa {
    pub funcs: Vec<FunctionSsa>,
    pub promoted_local_slots: alloc::collections::BTreeMap<usize, Vec<i64>>,
}

/// Data objects the post-inline bodies no longer reach, reported by
/// [`drop_unreachable_statics`]: `.data` was compacted from the
/// pre-inline call graph, so an object whose last reference the inliner
/// removed is still in the image along with its relocations. The caller
/// feeds this to [`recompact_after_inlining`] and lowers `ssa` against
/// the result. It must lower `ssa` rather than re-walk: the ASTs describe
/// the pre-inline program, which still materialises the address of the
/// object the recompaction drops.
#[derive(Debug)]
pub(crate) struct OrphanedData {
    pub sets: LiveSets,
    pub ssa: PrebuiltSsa,
}

/// Drop every `FunctionSsa` unreachable per [`compute_live_sets`].
/// Runs after the function set was mutated (the -O pipeline's inliner
/// and branch folds). The prune assumes every data object live: the
/// `.data` image the caller lowers against is already fixed by
/// compaction and its relocations must keep their targets. The second,
/// joint pass reports the objects that assumption keeps alive, `None`
/// when the compacted image is still exactly the reachable set.
pub(crate) fn drop_unreachable_statics(
    funcs: &mut Vec<FunctionSsa>,
    program: &Program,
) -> Option<OrphanedData> {
    let live = compute_live_sets(funcs, program, true).func_pcs;
    funcs.retain(|f| {
        let keep = live.contains(&f.ent_pc);
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
    let sets = compute_live_sets(funcs, program, false);
    if sets.data_live.iter().all(|&l| l) {
        return None;
    }
    // `funcs` is left alone: this build's `.data` still holds the orphaned
    // objects, so their relocation targets must stay lowered. The reported
    // copy carries only the bodies the recompacted lowering emits.
    let kept: Vec<FunctionSsa> = funcs
        .iter()
        .filter(|f| sets.func_pcs.contains(&f.ent_pc))
        .cloned()
        .collect();
    Some(OrphanedData {
        sets,
        ssa: PrebuiltSsa {
            funcs: kept,
            promoted_local_slots: alloc::collections::BTreeMap::new(),
        },
    })
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
    optimize: bool,
    jump_tables: bool,
) -> Result<Vec<FunctionSsa>, C5Error> {
    if !program.finished_functions.is_empty() {
        let mut funcs = walk_program(program, target, optimize, jump_tables)?;
        // C99 6.2.2: a function with internal linkage that no reachable
        // code or data references is unobservable; drop it before codegen
        // so the unused `static inline` helpers headers pull into every
        // unit do not reach the image.
        let live = compute_live_sets(&funcs, program, false).func_pcs;
        funcs.retain(|f| live.contains(&f.ent_pc));
        #[cfg(feature = "std")]
        measure_dead_data(&funcs, program);
        return Ok(order_by_section(funcs, program));
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
        return Ok(order_by_section(out, program));
    }
    Ok(Vec::new())
}

/// Import-placeholder pcs that resolve inside this unit: entries of
/// `extern_function_imports` whose name a function alias defines, mapped
/// to the ent_pc of the alias chain's defined function. A weak alias
/// keeps references symbolic so a relocatable object leaves them to the
/// linker; a consumer that is itself the link -- the interpreter, the
/// JIT, a single-unit final image -- binds them with this map.
pub(crate) fn alias_import_bindings(
    program: &Program,
) -> alloc::collections::BTreeMap<usize, usize> {
    use crate::c5::token::Token;
    let mut out = alloc::collections::BTreeMap::new();
    if program.function_aliases.is_empty() {
        return out;
    }
    let defined: alloc::collections::BTreeMap<&str, usize> = program
        .symbols
        .iter()
        .filter(|s| s.class == Token::Fun as i64 && s.defined_here && !s.name.is_empty())
        .map(|s| (s.link_name(), s.val as usize))
        .collect();
    for (pc, name) in &program.extern_function_imports {
        let mut n = name.as_str();
        for _ in 0..=program.function_aliases.len() {
            if let Some(&ent) = defined.get(n) {
                out.insert(*pc, ent);
                break;
            }
            // An alias at an offset names no function entry, so a call
            // through it stays an unbound import.
            match program.function_aliases.iter().find(|a| a.name == n) {
                Some(a) if a.addend == 0 => n = a.target.as_str(),
                _ => break,
            }
        }
    }
    out
}

/// Rewrite call and code-address sites carrying an import placeholder
/// that [`alias_import_bindings`] resolves to a function of this unit.
pub(crate) fn bind_alias_imports(program: &Program, funcs: &mut [FunctionSsa]) {
    use crate::c5::ir::Inst;
    let map = alias_import_bindings(program);
    if map.is_empty() {
        return;
    }
    for f in funcs {
        for inst in &mut f.insts {
            match inst {
                Inst::Call { target_pc, .. } => {
                    if let Some(&t) = map.get(target_pc) {
                        *target_pc = t;
                    }
                }
                Inst::ImmCode(pc) => {
                    if let Some(&t) = map.get(pc) {
                        *pc = t;
                    }
                }
                _ => {}
            }
        }
    }
}

/// Stable-partition the emission order so functions placed in a named
/// section (`__attribute__((section("name")))`) come last, grouped by
/// section name. The relocatable writer carves each group off the tail
/// of `.text` into its section; grouping keeps intra-section direct
/// branches at a fixed relative distance, so only cross-section
/// references need relocations.
fn order_by_section(mut funcs: Vec<FunctionSsa>, program: &Program) -> Vec<FunctionSsa> {
    use crate::c5::token::Token;
    let section_of: alloc::collections::BTreeMap<&str, &str> = program
        .symbols
        .iter()
        .filter(|s| s.class == Token::Fun as i64 && s.defined_here && s.section_name.is_some())
        .map(|s| (s.link_name(), s.section_name.as_deref().unwrap_or("")))
        .collect();
    if section_of.is_empty() {
        return funcs;
    }
    // `None` (default `.text`) sorts before every named group.
    funcs.sort_by(|a, b| {
        section_of
            .get(a.name.as_str())
            .cmp(&section_of.get(b.name.as_str()))
    });
    funcs
}

/// Result of [`compute_live_sets`]: live function ent_pcs, the sorted
/// data-object start offsets, and the per-object live flag (interval i
/// spans `[starts[i], starts[i+1])`, the last running to the data end).
#[derive(Debug)]
pub(crate) struct LiveSets {
    pub func_pcs: alloc::collections::BTreeSet<usize>,
    pub starts: Vec<i64>,
    pub data_live: Vec<bool>,
}

#[derive(Clone, Copy)]
enum Node {
    Func(usize),
    Data(usize),
}

/// Sorted `.data` object boundaries: offset 0, every recorded object
/// start, and every named-global offset. The single boundary model for
/// both the liveness walk and the compaction that applies its result.
fn data_object_starts(program: &Program) -> Vec<i64> {
    use crate::c5::token::Token;
    let data_len = program.data.len() as i64;
    let mut start_set: alloc::collections::BTreeSet<i64> = alloc::collections::BTreeSet::new();
    start_set.insert(0);
    for &s in &program.data_object_starts {
        if (0..data_len).contains(&s) {
            start_set.insert(s);
        }
    }
    for sym in &program.symbols {
        // A `_Thread_local` symbol's `val` is an offset into the separate
        // TLS image, not `.data`; conflating it here would plant a spurious
        // `.data` object boundary at a coinciding low offset and split a
        // real object.
        if sym.class == Token::Glo as i64
            && sym.defined_here
            && !sym.is_thread_local
            && (0..data_len).contains(&sym.val)
        {
            start_set.insert(sym.val);
        }
    }
    start_set.into_iter().collect()
}

/// Joint function + data reachability for one translation unit (C99
/// 6.2.2: an unreferenced internal-linkage definition is unobservable
/// and dropped from the object, as gcc -O does). Nodes are functions
/// (by ent_pc) and data objects (intervals over the sorted union of
/// `data_object_starts` and the named-global offsets; an unrecorded
/// start glues an object to its predecessor, kept conservatively).
/// Roots: external-linkage / `used` / alias / named-section
/// definitions, constructors / destructors, exports, the entry, names
/// spelled in file-scope asm, and the NULL guard. Edges: a live
/// function keeps its callees, address-taken functions, addressed
/// data, and symbols named in its asm templates; a live data object
/// keeps its relocation targets. A relocation in a dead object keeps
/// nothing -- neither its target nor an extern undefined reference
/// reaches the emitted object. `assume_data_live` pre-marks all data
/// live for callers running after the `.data` image is final.
pub(crate) fn compute_live_sets(
    funcs: &[FunctionSsa],
    program: &Program,
    assume_data_live: bool,
) -> LiveSets {
    use crate::c5::ir::Inst;
    use crate::c5::symbol::Linkage;
    use crate::c5::token::Token;
    use alloc::collections::{BTreeMap, BTreeSet};

    let data_len = program.data.len() as i64;
    let starts = data_object_starts(program);
    let n = starts.len();
    let interval_of = |off: i64| -> usize {
        match starts.binary_search(&off) {
            Ok(i) => i,
            Err(i) => i.saturating_sub(1),
        }
    };

    let by_ent: BTreeMap<usize, &FunctionSsa> = funcs.iter().map(|f| (f.ent_pc, f)).collect();

    // Internal names an asm template can reference by spelling.
    let mut named: BTreeMap<&str, Node> = BTreeMap::new();
    for sym in &program.symbols {
        if sym.class == Token::Glo as i64
            && sym.defined_here
            && !sym.is_thread_local
            && !sym.name.is_empty()
            && (0..data_len).contains(&sym.val)
        {
            named.insert(sym.link_name(), Node::Data(interval_of(sym.val)));
        }
    }
    for f in funcs {
        if !f.name.is_empty() {
            named.insert(f.name.as_str(), Node::Func(f.ent_pc));
        }
    }

    // Relocation edges, keyed by the interval holding the slot.
    let mut code_edges: Vec<Vec<usize>> = alloc::vec![Vec::new(); n];
    let mut data_edges: Vec<Vec<usize>> = alloc::vec![Vec::new(); n];
    if n > 0 {
        for r in &program.code_relocs {
            let off = r.data_offset as i64;
            if (0..data_len).contains(&off) {
                code_edges[interval_of(off)].push(r.target_ent_pc as usize);
            }
        }
        // A `&&label` slot names a code location inside its function, so
        // it holds that function live exactly as a function pointer does.
        for (off, ent_pc) in program.label_data_slots() {
            let off = off as i64;
            if (0..data_len).contains(&off) {
                code_edges[interval_of(off)].push(ent_pc);
            }
        }
        // The target interval resolves via the anchor: a one-past-the-end
        // target coincides with the next object's start and would mark
        // the wrong object.
        for r in &program.data_relocs {
            let (off, anchor) = (r.data_offset as i64, r.target_anchor as i64);
            if (0..data_len).contains(&off) && (0..data_len).contains(&anchor) {
                data_edges[interval_of(off)].push(interval_of(anchor));
            }
        }
    }

    let mut func_pcs: BTreeSet<usize> = BTreeSet::new();
    let mut data_live = alloc::vec![false; n];
    let mut work: alloc::vec::Vec<Node> = alloc::vec::Vec::new();
    // A block-scope static exists only in an emitted instance of its
    // function, so its `used` / `section` intent keeps it only while
    // the owner survives: an edge from the owner, not a root.
    let mut owner_deps: BTreeMap<usize, alloc::vec::Vec<usize>> = BTreeMap::new();

    for s in &program.symbols {
        // A named section does not retain a function (gcc parity: the
        // section-attributed `static inline` helpers headers pull in
        // are dropped when unreferenced; a kept one is still placed in
        // its section). `used` and alias do.
        if s.class == Token::Fun as i64
            && (matches!(s.linkage, Linkage::External) || s.is_used || s.is_alias)
            && by_ent.contains_key(&(s.val as usize))
        {
            work.push(Node::Func(s.val as usize));
        }
        if s.class == Token::Glo as i64
            && s.defined_here
            && !s.is_thread_local
            && (0..data_len).contains(&s.val)
            && (matches!(s.linkage, Linkage::External) || s.is_used || s.section_name.is_some())
        {
            match s.owner_ent_pc {
                Some(pc) => owner_deps
                    .entry(pc as usize)
                    .or_default()
                    .push(interval_of(s.val)),
                None => work.push(Node::Data(interval_of(s.val))),
            }
        }
    }
    // A function alias exports its target under another name, so the
    // chain's defined end stays live even when the alias symbol is the
    // only reference (a weak alias's own `val` is an import placeholder,
    // not the target's pc).
    for a in &program.function_aliases {
        let mut t = a.target.as_str();
        for _ in 0..program.function_aliases.len() {
            match program.function_aliases.iter().find(|x| x.name == t) {
                Some(next) => t = next.target.as_str(),
                None => break,
            }
        }
        if let Some(&Node::Func(pc)) = named.get(t) {
            work.push(Node::Func(pc));
        }
    }
    // Constructors / destructors are referenced through `.init_array` /
    // `.fini_array`, exports through the export table, the entry through
    // the image header -- none has an in-image reference.
    for f in &program.init_funcs {
        work.push(Node::Func(f.ent_pc));
    }
    for e in &program.exports {
        work.push(Node::Func(e.ent_pc));
    }
    if program.entry_name.is_some() {
        work.push(Node::Func(program.entry_pc));
    }
    // The 8-byte NULL guard stays at offset 0 so a data pointer is never
    // confused with NULL.
    if n > 0 {
        work.push(Node::Data(0));
    }
    // The TLS template is kept whole, so an object its initializer names is
    // a root rather than an edge from a `data` interval.
    for r in &program.tls_data_relocs {
        let anchor = r.target_anchor as i64;
        if (0..data_len).contains(&anchor) {
            work.push(Node::Data(interval_of(anchor)));
        }
    }
    for r in &program.tls_code_relocs {
        work.push(Node::Func(r.target_ent_pc as usize));
    }
    for t in &program.file_asm {
        push_asm_names(t.as_bytes(), &named, &mut work);
    }
    if assume_data_live {
        for i in 0..n {
            work.push(Node::Data(i));
        }
    }

    while let Some(node) = work.pop() {
        match node {
            Node::Func(pc) => {
                if !func_pcs.insert(pc) {
                    continue;
                }
                if let Some(deps) = owner_deps.get(&pc) {
                    for &d in deps {
                        work.push(Node::Data(d));
                    }
                }
                let Some(f) = by_ent.get(&pc) else { continue };
                // Address edges come from exactly the materializations
                // the emitters lower: the use counts driving the
                // per-arch dead-code skip. An address whose last reader
                // was folded or pruned away emits nothing, so following
                // it would keep the object it names -- and everything
                // that object references -- in the image; one a pure
                // cycle still holds is emitted, so it must keep its
                // referent.
                let counts = super::reg_alloc::compute_use_counts(f);
                for blk in &f.blocks {
                    for i in blk.inst_range.clone() {
                        match &f.insts[i as usize] {
                            Inst::Call { target_pc, .. } => work.push(Node::Func(*target_pc)),
                            Inst::ImmCode(t) if counts[i as usize] > 0 => {
                                work.push(Node::Func(*t));
                            }
                            Inst::ImmData(off)
                                if counts[i as usize] > 0 && (0..data_len).contains(off) =>
                            {
                                work.push(Node::Data(interval_of(*off)));
                            }
                            Inst::InlineAsm { asm, .. } => {
                                push_asm_names(&asm.template, &named, &mut work);
                            }
                            _ => {}
                        }
                    }
                }
            }
            Node::Data(i) => {
                if data_live[i] {
                    continue;
                }
                data_live[i] = true;
                for &t in &code_edges[i] {
                    work.push(Node::Func(t));
                }
                for &d in &data_edges[i] {
                    work.push(Node::Data(d));
                }
            }
        }
    }
    LiveSets {
        func_pcs,
        starts,
        data_live,
    }
}

/// Push the nodes of internal symbols whose names appear as identifier
/// tokens in an asm template. Conservative in the keep direction, except
/// in a statement's leading position: that is a label, mnemonic or
/// directive, never an operand. Statements separate on newline and `;`;
/// `/* */` is skipped so a newline inside one does not open a statement.
fn push_asm_names(
    text: &[u8],
    named: &alloc::collections::BTreeMap<&str, Node>,
    work: &mut alloc::vec::Vec<Node>,
) {
    let is_ident = |b: u8| b.is_ascii_alphanumeric() || b == b'_' || b == b'.' || b == b'$';
    let mut i = 0;
    let mut leading = true;
    while i < text.len() {
        if text[i] == b'/' && text.get(i + 1) == Some(&b'*') {
            i += 2;
            while i < text.len() && !(text[i] == b'*' && text.get(i + 1) == Some(&b'/')) {
                i += 1;
            }
            i = i.saturating_add(2).min(text.len());
            continue;
        }
        if text[i] == b'\n' || text[i] == b';' {
            leading = true;
            i += 1;
            continue;
        }
        if !is_ident(text[i]) {
            i += 1;
            continue;
        }
        let s = i;
        while i < text.len() && is_ident(text[i]) {
            i += 1;
        }
        if leading {
            // A label definition leaves the next token still leading.
            let mut j = i;
            while matches!(text.get(j), Some(b' ' | b'\t')) {
                j += 1;
            }
            leading = text.get(j) == Some(&b':');
            continue;
        }
        if text[s].is_ascii_digit() {
            continue;
        }
        if let Ok(tok) = core::str::from_utf8(&text[s..i])
            && let Some(node) = named.get(tok)
        {
            work.push(*node);
        }
    }
}

/// Where each data object landed in the packed image: the sorted object
/// `starts`, each object's packed base (`new_base[i] < 0` for a dropped
/// object) and length. Answers the compaction pass's offset surface.
struct PackedData<'a> {
    starts: &'a [i64],
    new_base: &'a [i64],
    obj_lens: &'a [i64],
    data_len: i64,
}

impl PackedData<'_> {
    fn interval_of(&self, off: i64) -> usize {
        match self.starts.binary_search(&off) {
            Ok(i) => i,
            Err(i) => i.saturating_sub(1),
        }
    }
}

impl crate::c5::layout::DataRemap for PackedData<'_> {
    fn in_data(&self, off: i64) -> bool {
        (0..self.data_len).contains(&off)
    }

    fn remap(&self, off: i64, anchor: i64) -> Option<i64> {
        if !self.in_data(anchor) {
            // No object owns the offset; it passes through (the extern
            // `ImmData(0)` sentinel and out-of-image values both land here).
            return Some(remap_data_off(
                off,
                self.starts,
                self.new_base,
                self.data_len,
            ));
        }
        let i = self.interval_of(anchor);
        (self.new_base[i] >= 0).then(|| self.new_base[i] + (off - self.starts[i]))
    }

    fn remap_span(&self, lo: i64, hi: i64) -> Option<(i64, i64)> {
        if !self.in_data(lo) || hi <= lo || hi > self.data_len {
            return None;
        }
        let i = self.interval_of(lo);
        // A span crossing into the next object would not stay contiguous.
        if self.new_base[i] < 0 || hi > self.starts[i] + self.obj_lens[i] {
            return None;
        }
        let delta = self.new_base[i] - self.starts[i];
        Some((lo + delta, hi + delta))
    }
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

/// Where each object of the input image landed in the packed one.
/// `new_base[i]` is the packed offset of the object at input offset
/// `starts[i]`, `-1` when dropped; `kept` is the same relation sorted by
/// packed base, for resolving a packed offset back.
pub(crate) struct DataMap {
    new_base: Vec<i64>,
    /// `(packed base, length, input offset)`, ascending by packed base.
    kept: Vec<(i64, i64, i64)>,
}

impl DataMap {
    fn new(starts: &[i64], new_base: Vec<i64>, obj_len: &[i64]) -> DataMap {
        let mut kept: Vec<(i64, i64, i64)> = (0..starts.len())
            .filter(|&i| new_base[i] >= 0)
            .map(|i| (new_base[i], obj_len[i], starts[i]))
            .collect();
        kept.sort_unstable();
        DataMap { new_base, kept }
    }

    /// Input offset for a byte at packed offset `off`, `None` when no kept
    /// object covers it. `.bss` objects resolve too: their packed base is
    /// past the file image but still an offset in it.
    fn to_input(&self, off: i64) -> Option<i64> {
        let i = match self.kept.binary_search_by_key(&off, |&(base, _, _)| base) {
            Ok(i) => i,
            Err(0) => return None,
            Err(i) => i - 1,
        };
        let (base, len, start) = self.kept[i];
        (off < base + len).then_some(start + (off - base))
    }

    /// Packed base of the object at input offset `starts[i]`, `None` when
    /// it was dropped.
    fn packed_base(&self, i: usize) -> Option<i64> {
        (self.new_base[i] >= 0).then_some(self.new_base[i])
    }
}

/// The liveness a compaction applied and the offset map it produced, for
/// a caller that may need to redo it with a sharper live set.
pub(crate) struct CompactionPlan {
    pub live: LiveSets,
    pub map: DataMap,
    /// Functions the pass kept in `finished_functions`. A redo applies the
    /// same set: the ASTs are not walked again, but everything else derived
    /// from them -- the import table above all -- must still see every
    /// function the first pass did.
    pub func_pcs: alloc::collections::BTreeSet<usize>,
}

/// What [`compact_program_data`] produced. `plan` is absent when the
/// compaction was a no-op and there is nothing to redo.
pub(crate) struct Compaction {
    pub program: Program,
    pub bss_size: i64,
    pub plan: Option<CompactionPlan>,
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
    optimize: bool,
) -> Result<Compaction, C5Error> {
    let unchanged = || Compaction {
        program: program.clone(),
        bss_size: 0,
        plan: None,
    };
    let data_len = program.data.len() as i64;
    if data_len == 0 || program.finished_functions.is_empty() {
        return Ok(unchanged());
    }
    #[cfg(feature = "std")]
    if std::env::var("BADC_NO_DATA_DCE").is_ok() {
        return Ok(unchanged());
    }
    // Liveness is over program functions and data; the switch dispatch
    // form reaches the same set either way.
    // `[nested]`: inside `object::compact_program_data`, so the pass report
    // lists it without adding it to a phase total twice.
    let funcs =
        super::emit_common::time_pass("object::compact_program_data ssa build [nested]", || {
            produce_ssa_funcs(program, target, optimize, true)
        })?;
    let live_func_pcs: alloc::collections::BTreeSet<usize> =
        funcs.iter().map(|f| f.ent_pc).collect();
    let sets = compute_live_sets(&funcs, program, false);
    let (out, bss_size, map) = apply_data_liveness(program, &sets, &live_func_pcs, segregate, None);
    Ok(Compaction {
        program: out,
        bss_size,
        plan: Some(CompactionPlan {
            live: sets,
            map,
            func_pcs: live_func_pcs,
        }),
    })
}

/// Redo a compaction of `program` with the post-inline liveness the first
/// pass reported. The report names objects of the packed image, so it is
/// carried back onto `program`'s own objects through `plan`: compacting
/// the packed image instead would lose its `.bss` region, whose objects
/// sit past `data` and so outside the interval model. Those objects keep
/// the liveness the first pass gave them, so this narrows `.data` only.
pub(crate) fn recompact_after_inlining(
    program: &Program,
    plan: &CompactionPlan,
    orphaned: &mut OrphanedData,
    segregate: bool,
) -> (Program, i64) {
    let mut sets = LiveSets {
        starts: plan.live.starts.clone(),
        data_live: plan.live.data_live.clone(),
        func_pcs: orphaned.sets.func_pcs.clone(),
    };
    let packed_starts = &orphaned.sets.starts;
    for i in 0..sets.starts.len() {
        let Some(base) = plan.map.packed_base(i) else {
            continue;
        };
        // A base the packed image records no boundary for is a `.bss`
        // object (its offset is past the file image).
        if let Ok(j) = packed_starts.binary_search(&base) {
            sets.data_live[i] = orphaned.sets.data_live[j];
        }
    }
    let (out, bss_size, _) = apply_data_liveness(
        program,
        &sets,
        &plan.func_pcs,
        segregate,
        Some((&mut orphaned.ssa.funcs, &plan.map)),
    );
    (out, bss_size)
}

/// Rewrite `program` to hold only the data objects `sets` marks live and
/// only the functions in `live_func_pcs`, packing `.data` and mapping
/// every offset surface -- symbol values, relocation slots, relocation
/// targets and their anchors, AST data references, recorded padding and
/// alignment marks, object starts -- onto the new layout. Split out of
/// [`compact_program_data`] so a caller holding a later, sharper live set
/// (post-inline reachability) applies it through the same code.
///
/// `ssa` are bodies the caller lowers instead of re-walking the ASTs,
/// paired with the map of the image their offsets are in (itself produced
/// from `program`). Their `Inst::ImmData` offsets -- the only `.data`
/// offset the IR holds -- are carried back through that map and forward
/// through this one here, so no consumer is left on a stale layout.
pub(crate) fn apply_data_liveness(
    program: &Program,
    sets: &LiveSets,
    live_func_pcs: &alloc::collections::BTreeSet<usize>,
    segregate: bool,
    ssa: Option<(&mut [FunctionSsa], &DataMap)>,
) -> (Program, i64, DataMap) {
    let data_len = program.data.len() as i64;
    let starts = &sets.starts;
    let live = &sets.data_live;
    debug_assert_eq!(*starts, data_object_starts(program));
    debug_assert_eq!(starts.len(), live.len());
    let n = starts.len();

    // Each kept object moves to a new base congruent to its old start
    // modulo its own placement alignment, so every byte of it keeps its
    // original alignment residue. This holds even when adjacent objects
    // share an interval (an object whose start the parser did not record
    // glues onto its predecessor): the relative layout inside the copied
    // span is preserved, and the interval's alignment is the strictest
    // one recorded anywhere inside it. The section is placed at the
    // maximum over the objects it keeps, so an object needing A <= that
    // keeps its absolute alignment.
    let cap = crate::c5::layout::bss_image_align(program.data_align);
    let obj_align = crate::c5::layout::data_object_aligns(program, starts, cap);
    // Region boundaries sit on the strictest alignment any kept object
    // needs, so every packed residue past one holds wherever the writers
    // place that region.
    let img_align: i64 = (0..n)
        .filter(|&i| live[i])
        .map(|i| obj_align[i])
        .max()
        .unwrap_or(0)
        .max(crate::c5::layout::BSS_ALIGN_MIN as i64);
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
    // Storage nothing writes belongs on a read-only page: `const`-qualified
    // objects (C99 6.7.3p5) and the anonymous immutable spans below. Only
    // file-backed objects reach the writer's `.rodata` carve, so a wholly-zero
    // one has to stay out of the zero-fill region and pay its file bytes.
    let mut is_readonly = alloc::vec![false; n];
    {
        use crate::c5::token::Token;
        for sym in &program.symbols {
            if sym.class == Token::Glo as i64
                && sym.defined_here
                && sym.storage_is_const
                && !sym.is_thread_local
                // Storage the declaration fills with stores is written
                // during execution whatever its declared type says.
                && !sym.runtime_initialized
                && (0..data_len).contains(&sym.val)
            {
                is_readonly[interval_of(sym.val)] = true;
            }
        }
        // The anonymous immutable spans -- string literals, `__func__`
        // arrays, staged initializer templates. No symbol names them, so
        // the loop above cannot see them.
        for &(lo, hi) in &program.const_data_ranges {
            if hi <= lo || !(0..data_len).contains(&lo) {
                continue;
            }
            let mut i = interval_of(lo);
            while i < n && starts[i] < hi {
                is_readonly[i] = true;
                i += 1;
            }
        }
    }
    let mut has_reloc_slot = alloc::vec![false; n];
    for off in program.data_reloc_offsets() {
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
    //
    // This predicate is the only place the question is decided. The
    // layout it produces records the answer as a position -- everything
    // at or past the file image is zero-fill -- and the object writer
    // reads it back through that watershed rather than re-deriving it.
    let is_bss = |i: usize| -> bool {
        segregate
            && i != 0
            && live[i]
            && !has_reloc_slot[i]
            && !is_readonly[i]
            && program.data[starts[i] as usize..obj_end(i) as usize]
                .iter()
                .all(|&b| b == 0)
    };

    // File-backed objects pack in three regions -- read-only prefix,
    // relro, writable -- the same regions-then-boundary layout the
    // multi-object link produces, so both paths hand the writers one
    // shape. `const`-qualified storage with no relocated slot forms the
    // prefix the writers map without write permission
    // (`Program::data_ro_len`). `const` storage whose slot a relocation
    // writes cannot ride it -- the loader patches such slots after
    // mapping -- so it forms the relro region
    // (`Program::data_relro_len`), which the writers re-protect before
    // the entry point runs. Object 0 must stay at offset 0 (see above),
    // so it leads the first non-empty region, and a region exists at all
    // only when object 0's bytes past the 8-byte NULL guard are recorded
    // alignment padding -- content glued onto it has no recorded start
    // and must stay writable.
    let guard_immutable = !has_reloc_slot[0] && {
        let end = obj_end(0);
        let mut covered = end.min(8);
        for &(lo, hi) in &program.data_pad_ranges {
            if lo <= covered && hi > covered {
                covered = hi;
            }
        }
        covered >= end
    };
    const REGION_RO: u8 = 0;
    const REGION_RELRO: u8 = 1;
    const REGION_RW: u8 = 2;
    let protected = |i: usize, reloc: bool| {
        live[i] && !is_bss(i) && is_readonly[i] && has_reloc_slot[i] == reloc
    };
    let any_ro = (1..n).any(|i| protected(i, false));
    let any_relro = (1..n).any(|i| protected(i, true));
    let region_of = |i: usize| -> u8 {
        if !guard_immutable {
            return REGION_RW;
        }
        if i == 0 {
            return if any_ro {
                REGION_RO
            } else if any_relro {
                REGION_RELRO
            } else {
                REGION_RW
            };
        }
        if !is_readonly[i] {
            REGION_RW
        } else if has_reloc_slot[i] {
            REGION_RELRO
        } else {
            REGION_RO
        }
    };

    // The packed layout invalidates the parse-recorded padding ranges;
    // rebuild them from the gaps this pass itself creates.
    let mut new_pad_ranges: Vec<(i64, i64)> = Vec::new();
    let mut new_base = alloc::vec![-1i64; n];
    let mut new_data: Vec<u8> = Vec::with_capacity(program.data.len());
    let mut data_ro_len: i64 = 0;
    let mut data_relro_len: i64 = 0;
    for pass in [REGION_RO, REGION_RELRO, REGION_RW] {
        for i in 0..n {
            if !live[i] || is_bss(i) || region_of(i) != pass {
                continue;
            }
            let a = obj_align[i];
            let want = starts[i].rem_euclid(a);
            let pad_start = new_data.len() as i64;
            while (new_data.len() as i64).rem_euclid(a) != want {
                new_data.push(0);
            }
            if (new_data.len() as i64) > pad_start {
                new_pad_ranges.push((pad_start, new_data.len() as i64));
            }
            new_base[i] = new_data.len() as i64;
            new_data.extend_from_slice(&program.data[starts[i] as usize..obj_end(i) as usize]);
        }
        // Each region ends on an `img_align` boundary so the next one's
        // packed residues hold at any aligned placement of it.
        if pass != REGION_RW && !new_data.is_empty() {
            let pad_start = new_data.len() as i64;
            while (new_data.len() as i64).rem_euclid(img_align) != 0 {
                new_data.push(0);
            }
            if (new_data.len() as i64) > pad_start {
                new_pad_ranges.push((pad_start, new_data.len() as i64));
            }
            if pass == REGION_RO {
                data_ro_len = new_data.len() as i64;
            }
            data_relro_len = new_data.len() as i64;
        }
    }
    // The `.bss` region begins immediately past the file image; an offset
    // into it is `>= new_data.len()`, which each writer maps to a vaddr the
    // loader zero-fills (p_memsz > p_filesz / VirtualSize > SizeOfRawData /
    // vmsize > filesize). Its base carries the strictest alignment the
    // zero-fill objects need: the linker and the per-format writers
    // address `.bss` relative to its own base, so each object's
    // bss-relative offset must carry the same alignment residue as its
    // `.data` offset, which only holds when the base is aligned.
    if (0..n).any(&is_bss) {
        let bss_align = (0..n)
            .filter(|&i| is_bss(i))
            .map(|i| obj_align[i])
            .max()
            .unwrap_or(0)
            .max(crate::c5::layout::BSS_ALIGN_MIN as i64);
        let pad_start = new_data.len() as i64;
        while (new_data.len() as i64).rem_euclid(bss_align) != 0 {
            new_data.push(0);
        }
        if (new_data.len() as i64) > pad_start {
            new_pad_ranges.push((pad_start, new_data.len() as i64));
        }
    }
    let bss_base = new_data.len() as i64;
    let mut bss_cursor = bss_base;
    for i in 0..n {
        if is_bss(i) {
            let a = obj_align[i];
            let want = starts[i].rem_euclid(a);
            let pad_start = bss_cursor;
            while bss_cursor.rem_euclid(a) != want {
                bss_cursor += 1;
            }
            if bss_cursor > pad_start {
                new_pad_ranges.push((pad_start, bss_cursor));
            }
            new_base[i] = bss_cursor;
            bss_cursor += obj_end(i) - starts[i];
        }
    }
    let bss_size = bss_cursor - bss_base;
    // The one description of where every object went. Every stored offset
    // -- symbol values, relocation slots and targets, AST references, IR
    // immediates, padding spans, alignment marks, object starts -- is
    // rewritten through it by `Program::remap_data_offsets`, whose
    // implementations destructure their types exhaustively.
    let obj_lens: Vec<i64> = (0..n).map(|i| obj_end(i) - starts[i]).collect();
    let map_to = PackedData {
        starts,
        new_base: &new_base,
        obj_lens: &obj_lens,
        data_len,
    };
    let map = |off: i64| remap_data_off(off, starts, &new_base, data_len);

    let mut out = program.clone();
    // A relocation whose slot lies in a dropped object drops with it:
    // emitting it would plant a reference -- for an extern target, an
    // undefined symbol -- from an object the unit cannot reach.
    let slot_live = |off: u64| {
        let off = off as i64;
        !(0..data_len).contains(&off) || live[interval_of(off)]
    };
    out.data_relocs.retain(|r| slot_live(r.data_offset));
    out.code_relocs.retain(|r| slot_live(r.data_offset));
    out.extern_data_relocs.retain(|r| slot_live(r.data_offset));
    out.finished_functions
        .retain(|f| live_func_pcs.contains(&f.ent_pc));
    crate::c5::layout::DataOffsets::remap_data_offsets(&mut out, &map_to);
    out.data = new_data;
    // The section's alignment is the maximum over the objects it keeps;
    // one the prune dropped no longer holds the section on its boundary.
    out.data_align = (0..n)
        .filter(|&i| live[i])
        .map(|i| obj_align[i] as usize)
        .max()
        .unwrap_or(crate::c5::layout::DATA_ALIGN_MIN);
    out.data_ro_len = data_ro_len as usize;
    out.data_relro_len = data_relro_len.max(data_ro_len) as usize;
    // The gaps this pass opened join the parse-recorded padding the remap
    // above carried over.
    out.data_pad_ranges.extend(new_pad_ranges);
    out.data_pad_ranges.sort_unstable();
    out.data_align_marks.sort_unstable();
    // A dropped object is named only by address materialisations nothing
    // consumes -- that is why it was dropped. Those become plain constants:
    // `ImmData` is deduplicated by key, so parking them all on one
    // placeholder offset would merge distinct dead materialisations into a
    // single value with live-looking uses.
    if let Some((funcs, space)) = ssa {
        for f in funcs {
            for inst in &mut f.insts {
                let crate::c5::ir::Inst::ImmData(packed) = *inst else {
                    continue;
                };
                // No covering object means the reference died in the
                // earlier pass already. Every `ImmData` payload is an object
                // base (an interior address is a separate `BinopI` add), so
                // a live one always resolves.
                let dead = match space.to_input(packed) {
                    Some(off) => {
                        if (0..data_len).contains(&off) && new_base[interval_of(off)] < 0 {
                            true
                        } else {
                            *inst = crate::c5::ir::Inst::ImmData(map(off));
                            false
                        }
                    }
                    None => true,
                };
                if dead {
                    *inst = crate::c5::ir::Inst::Imm(0);
                }
            }
            // A `&&label` slot rides its object: it follows the new base,
            // or goes with the object when that did not survive.
            f.label_data_relocs
                .retain_mut(|r| match space.to_input(r.data_offset as i64) {
                    Some(off)
                        if (0..data_len).contains(&off) && new_base[interval_of(off)] >= 0 =>
                    {
                        r.data_offset = map(off) as u64;
                        true
                    }
                    _ => false,
                });
        }
    }
    (out, bss_size, DataMap::new(starts, new_base, &obj_lens))
}

/// Read-only measurement of statically-dead data objects (no mutation,
/// no effect on codegen). Emits one line per translation unit to the
/// path in `BADC_DATA_DCE_LOG` when that variable is set, validating the
/// object-boundary model and the achievable `.data` reduction.
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
    let sets = compute_live_sets(funcs, program, false);
    let (starts, live) = (sets.starts, sets.data_live);
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

        let bss_off = compact_program_data(&program, target, false, false)
            .expect("compact")
            .bss_size;
        assert_eq!(bss_off, 0, "no bss region when segregation is off");

        let (compacted, bss_size) = {
            let c = compact_program_data(&program, target, true, false).expect("compact");
            (c.program, c.bss_size)
        };
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

    // File-backed objects pack into three regions bounded by
    // `Program::data_ro_len` and `Program::data_relro_len`: literals and
    // named const objects with no relocated slot form the prefix, a
    // const object holding a relocated slot forms the relro region, and
    // writable objects follow. Every recorded relocation slot sits past
    // the prefix.
    #[test]
    fn readonly_objects_pack_into_a_prefix() {
        let target = Target::LinuxX64;
        let src = "const int ck = 7; \
                   int wv = 3; \
                   char *msg = \"prefix-check\"; \
                   const char *const cp = \"demoted\"; \
                   int main(void) { return ck + wv + msg[0] + cp[0]; }";
        let compacted = compact_program_data(&compile(src, target), target, true, false)
            .expect("compact")
            .program;
        let ro = compacted.data_ro_len as i64;
        assert!(ro > 0, "const data must produce a read-only prefix");
        assert_eq!(ro % 16, 0, "prefix must end on the packing alignment");
        let lit = compacted
            .data
            .windows(12)
            .position(|w| w == b"prefix-check")
            .expect("literal") as i64;
        assert!(lit + 12 <= ro, "the literal must sit in the prefix");
        let sym = |name: &str| {
            compacted
                .symbols
                .iter()
                .find(|s| s.name == name)
                .unwrap_or_else(|| panic!("symbol {name}"))
                .val
        };
        let relro = compacted.data_relro_len as i64;
        assert!(relro > ro, "a relocated const must produce a relro region");
        assert_eq!(relro % 16, 0, "relro must end on the packing alignment");
        assert!(sym("ck") + 4 <= ro, "const object belongs to the prefix");
        assert!(sym("wv") >= relro, "writable object stays past relro");
        assert!(
            sym("cp") >= ro && sym("cp") + 8 <= relro,
            "a relocated const belongs to the relro region"
        );
        for off in compacted.data_reloc_offsets() {
            assert!(off >= ro, "relocated slot {off:#x} below the prefix");
        }
    }

    // A `_Thread_local` global's `val` is an offset into the TLS image, not
    // `.data`. When such an offset coincides with an interior byte of a real
    // `.data` object, the data-DCE interval model must not treat it as an
    // object boundary: doing so splits the object and lets the prune drop the
    // unreferenced tail, so a following literal is packed over it.
    #[test]
    fn thread_local_offset_does_not_split_data_object() {
        let target = Target::LinuxX64;
        // `tb` takes TLS offset 16, which lands inside `arr`'s 24-byte `.data`
        // span (`arr` is the first object past the 8-byte NULL guard).
        let src = "static _Thread_local char ta[16]; \
                   static _Thread_local long tb; \
                   long arr[3] = {1, 0, 0}; \
                   char *msg = \"abcdefgh\"; \
                   int main(void){ ta[0]=1; tb=2; \
                       return (int)arr[2] + msg[0] + (int)tb + ta[0]; }";
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .expect("compile");
        let compacted = compact_program_data(&program, target, true, false)
            .expect("compact")
            .program;

        // `arr` has external linkage, so its symbol survives with its remapped
        // `.data` offset. It must keep all 24 bytes, disjoint from the literal.
        let arr = compacted
            .symbols
            .iter()
            .find(|s| s.name == "arr")
            .expect("arr symbol");
        let arr_lo = arr.val as usize;
        let arr_hi = arr_lo + 24;
        let msg = compacted
            .data
            .windows(9)
            .position(|w| w == b"abcdefgh\0")
            .expect("string literal kept intact");
        assert!(
            msg + 9 <= arr_lo || msg >= arr_hi,
            "literal at {msg:#x} overlaps arr [{arr_lo:#x}, {arr_hi:#x})"
        );

        // A thread-local offset must never pass through the `.data` remap.
        for s in &compacted.symbols {
            if s.is_thread_local && s.defined_here {
                let orig = program
                    .symbols
                    .iter()
                    .find(|p| p.name == s.name && p.is_thread_local)
                    .expect("original TLS symbol");
                assert_eq!(
                    s.val, orig.val,
                    "thread-local `{}` val was remapped as .data",
                    s.name
                );
            }
        }
    }

    /// Offsets of the defined `.data` objects, keyed by name.
    fn data_syms(program: &Program) -> alloc::vec::Vec<(&str, i64, i64)> {
        use crate::c5::token::Token;
        program
            .symbols
            .iter()
            .filter(|s| {
                s.class == Token::Glo as i64
                    && s.defined_here
                    && !s.is_thread_local
                    && !s.name.is_empty()
            })
            .map(|s| (s.name.as_str(), s.val, s.data_align.max(1)))
            .collect()
    }

    // Every kept object sits on its own boundary, and no object pays the
    // section's alignment as padding: a unit whose strictest object is
    // page-aligned packs the rest at 8 and 64 (C99 6.2.8, and the
    // placement every toolchain emits).
    #[test]
    fn packing_uses_each_object_own_alignment() {
        let target = Target::LinuxX64;
        let mut src = alloc::string::String::from(
            "_Alignas(4096) char page[4096] = {1};\n\
             _Alignas(64) long cache[8] = {2};\n\
             long plain[3] = {3};\n",
        );
        for i in 0..200 {
            src += &alloc::format!("static long dead{i}[8] = {{{i}}};\n");
        }
        src += "int main(void) { return page[0] + (int)cache[0] + (int)plain[0]; }\n";
        let program = compile(&src, target);
        let c = compact_program_data(&program, target, true, false).expect("compact");
        let compacted = &c.program;

        for (name, val, align) in data_syms(compacted) {
            assert_eq!(
                val % align,
                0,
                "`{name}` at {val:#x} is not {align}-aligned"
            );
        }
        for &(off, align) in &compacted.data_align_marks {
            assert_eq!(off % align, 0, "align mark {off:#x} not on its {align}");
        }
        assert_eq!(
            compacted.data_align, 4096,
            "the section keeps the maximum over the objects it holds"
        );
        // Live content is 4096 + 64 + 24 bytes plus the NULL guard; one
        // gap ahead of the page-aligned object is the only padding a
        // per-object rule can owe. Padding every object to 4096 instead
        // packs the same set into more than five pages.
        let total = compacted.data.len() as i64 + c.bss_size;
        assert!(
            total <= 2 * 4096 + 512,
            "packed image {total} exceeds the per-object bound"
        );
        assert!(
            total < program.data.len() as i64,
            "packing must not grow the image"
        );
    }

    // The section's alignment is the maximum over the objects that
    // survive: dropping the only over-aligned one drops the requirement
    // with it, so the writers stop placing the section at a page.
    #[test]
    fn dropping_the_strictest_object_lowers_the_section_alignment() {
        let target = Target::LinuxX64;
        let src = "_Alignas(4096) static char page[4096] = {1};\n\
                   _Alignas(64) long cache[8] = {2};\n\
                   int main(void) { return (int)cache[0]; }\n";
        let program = compile(src, target);
        assert_eq!(program.data_align, 4096, "the parse records the page");
        let c = compact_program_data(&program, target, true, false).expect("compact");
        assert_eq!(c.program.data_align, 64, "kept objects need 64, not 4096");
        let total = c.program.data.len() as i64 + c.bss_size;
        assert!(total <= 256, "packed image {total} still carries the page");
        for (name, val, align) in data_syms(&c.program) {
            assert_eq!(val % align, 0, "`{name}` at {val:#x} lost its {align}");
        }
    }

    // Zero-fill objects pack in the `.bss` region under the same rule,
    // and the region base carries the strictest alignment they need so
    // each bss-relative offset keeps its residue.
    #[test]
    fn bss_objects_pack_at_their_own_alignment() {
        let target = Target::LinuxX64;
        let mut src = alloc::string::String::from(
            "_Alignas(4096) char page[4096] = {1};\n\
             long live_a[4];\n\
             _Alignas(64) long live_b[4];\n",
        );
        for i in 0..64 {
            src += &alloc::format!("static long dead{i}[8];\n");
        }
        src += "int main(void) { return page[0] + (int)live_a[0] + (int)live_b[0]; }\n";
        let program = compile(&src, target);
        let c = compact_program_data(&program, target, true, false).expect("compact");
        let compacted = &c.program;
        let file_len = compacted.data.len() as i64;
        assert!(c.bss_size > 0, "the zero-init globals must reach .bss");
        assert!(
            c.bss_size <= 64 + 32 + 64,
            "bss region {} exceeds the per-object bound",
            c.bss_size
        );
        for (name, val, align) in data_syms(compacted) {
            assert_eq!(val % align, 0, "`{name}` at {val:#x} lost its {align}");
            if val >= file_len {
                assert_eq!(
                    (val - file_len) % align,
                    0,
                    "`{name}` is misaligned within .bss"
                );
            }
        }
    }

    // The packed offsets themselves, for a unit whose objects span three
    // alignments. A narrower live set must not move a kept object further
    // out than its own boundary requires.
    #[test]
    fn packed_layout_offsets_are_stable() {
        let target = Target::LinuxX64;
        let src = "long a8 = 1;\n\
                   _Alignas(64) long a64 = 2;\n\
                   _Alignas(4096) long a4k = 3;\n\
                   static long dead[64] = {9};\n\
                   int main(void) { return (int)(a8 + a64 + a4k); }\n";
        let program = compile(src, target);
        let c = compact_program_data(&program, target, true, false).expect("compact");
        let at = |name: &str| -> i64 {
            data_syms(&c.program)
                .iter()
                .find(|(n, ..)| *n == name)
                .unwrap_or_else(|| panic!("symbol {name}"))
                .1
        };
        assert_eq!(at("a8"), 8, "the first object follows the NULL guard");
        // Each base is the first one past the preceding object that meets
        // the object's own alignment; the interval the pass copies carries
        // the parse-recorded padding that followed the object.
        assert_eq!(at("a64"), 128);
        assert_eq!(at("a4k"), 4096);
        // The image ends with the last object, not on the 4096 the
        // section is placed at.
        assert_eq!(c.program.data.len(), 4104);
        assert_eq!(c.bss_size, 0);
    }
}

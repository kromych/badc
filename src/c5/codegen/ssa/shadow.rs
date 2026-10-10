//! SSA-source selector for the codegen backends. The walker
//! drives every parsed function via its captured AST snapshot;
//! pre-built `synthetic_ssa_funcs` (sys-trampolines, CRT entry)
//! and `user_ssa_funcs` (archive reload) come through directly.

use crate::c5::Target;
use crate::c5::diag::Code;
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

/// `__attribute__((patchable_function_entry(N, M)))` per defined function.
fn function_patchable_entries(program: &Program) -> alloc::collections::BTreeMap<&str, (u32, u32)> {
    use crate::c5::token::Token;
    program
        .symbols
        .iter()
        .filter(|s| s.class == Token::Fun as i64 && s.defined_here)
        .filter_map(|s| Some((s.def_link_name(), s.patchable_function_entry?)))
        .collect()
}

/// Names of defined functions carrying `no_instrument_function`.
fn no_instrument_function_names(program: &Program) -> alloc::collections::BTreeSet<&str> {
    defined_function_names(program, |s| s.no_instrument_function)
}

/// Names of defined functions carrying `no_stack_protector`.
fn no_stack_protector_names(program: &Program) -> alloc::collections::BTreeSet<&str> {
    defined_function_names(program, |s| s.no_stack_protector)
}

fn defined_function_names(
    program: &Program,
    marked: impl Fn(&crate::c5::symbol::Symbol) -> bool,
) -> alloc::collections::BTreeSet<&str> {
    use crate::c5::token::Token;
    program
        .symbols
        .iter()
        .filter(|s| s.class == Token::Fun as i64 && s.defined_here && marked(s))
        .map(|s| s.def_link_name())
        .collect()
}

/// Assembler name per function identifier the unit emits under a name
/// other than the identifier: a GNU asm label, or an inline definition's
/// private body name. Only renamed entries appear; every other function
/// emits under its identifier.
fn renamed_functions(
    program: &Program,
) -> alloc::collections::BTreeMap<&str, &alloc::string::String> {
    program.symbols.iter().filter_map(function_rename).collect()
}

fn function_rename(s: &crate::c5::symbol::Symbol) -> Option<(&str, &alloc::string::String)> {
    use crate::c5::token::Token;
    if s.class != Token::Fun as i64 || s.name.is_empty() {
        return None;
    }
    Some((
        s.name.as_str(),
        s.inline_body_name.as_ref().or(s.asm_name.as_ref())?,
    ))
}

/// The assembler name [`walk_program`] emits `f` under.
fn emitted_name<'p>(
    renamed: &alloc::collections::BTreeMap<&str, &'p alloc::string::String>,
    f: &'p crate::c5::ast::FinishedFunction,
) -> &'p str {
    renamed
        .get(f.name.as_str())
        .map_or(f.name.as_str(), |&n| n.as_str())
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

/// Walks each entry of `program.finished_functions` that `reachable` holds
/// and adds the synthetic and linked bodies, in `ent_pc` order; a failed
/// walk leaves its function out and its error, by entry pc, in the second.
pub(crate) fn walk_program(
    program: &Program,
    target: Target,
    optimize: bool,
    jump_tables: bool,
    reachable: &alloc::collections::BTreeSet<usize>,
) -> (Vec<FunctionSsa>, Vec<(usize, C5Error)>) {
    // Walker entries from AST snapshots, keyed by ent_pc.
    let mut walker_pcs: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let weak_names = weak_function_names(program);
    let internal_names = internal_function_names(program);
    let sections = function_sections(program);
    let patchable_entries = function_patchable_entries(program);
    let no_instrument = no_instrument_function_names(program);
    let no_stack_protector = no_stack_protector_names(program);
    let renamed = renamed_functions(program);
    let mut out: Vec<FunctionSsa> = Vec::with_capacity(program.finished_functions.len());
    let mut failed = Vec::new();
    let mut ordered: Vec<usize> = (0..program.finished_functions.len()).collect();
    ordered.sort_by_key(|&i| program.finished_functions[i].ent_pc);
    for i in ordered {
        let f = &program.finished_functions[i];
        if !reachable.contains(&f.ent_pc) {
            continue;
        }
        walker_pcs.insert(f.ent_pc);
        let walked = crate::c5::irgen::walk_function(
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
            if e.is_internal() {
                C5Error::internal(alloc::format!(
                    "irgen: function `{}` (ent_pc={}): {}",
                    f.name,
                    f.ent_pc,
                    e,
                ))
            } else {
                C5Error::hard(
                    Code::UNSUPPORTED,
                    alloc::format!("in function `{}`: {}", f.name, e,),
                )
            }
        });
        let mut func = match walked {
            Ok(func) => func,
            Err(e) => {
                failed.push((f.ent_pc, e));
                continue;
            }
        };
        // `FunctionSsa::name` is the assembler name from here down: it feeds
        // `Build::func_names`, every writer's symbol table, and the bare-name
        // lookup an inline-asm `call`/`bl` resolves against. The identifier
        // stays available through `Program::symbols` for DWARF.
        func.name = alloc::string::String::from(emitted_name(&renamed, f));
        func.is_inline = f.is_inline;
        func.is_always_inline = f.is_always_inline;
        func.is_noinline = f.is_noinline;
        func.is_naked = f.is_naked;
        func.is_noreturn = f.is_noreturn;
        func.conv = f.conv;
        func.is_weak = weak_names.contains(func.name.as_str());
        func.is_internal = internal_names.contains(func.name.as_str());
        func.section = sections.get(func.name.as_str()).map(|s| (*s).clone());
        func.patchable_entry = patchable_entries.get(func.name.as_str()).copied();
        func.no_instrument = no_instrument.contains(func.name.as_str());
        func.no_stack_protector = no_stack_protector.contains(func.name.as_str());
        // Seed declared multi-cell extents alongside the synthetic ones the
        // walker recorded. Slot coalescing reserves every interior cell.
        func.multi_cell_slots.extend_from_slice(&f.multi_cell_slots);
        func.array_slots.extend_from_slice(&f.array_slots);
        // `n_params` on FinishedFunction is the parser's
        // declared count. The codegen prologue spills the
        // matching host-arg regs into slots [2, 2+n). Use the
        // max of the declared count and the touched count
        // (`walker_param_count`): a struct-by-value param
        // wraps its slot-2 read inside the entry-Mcpy whose
        // dst is `slot -N`, so the touched scan would miss
        // slot 2 and the codegen wouldn't spill the host arg
        // -- the callee then reads junk for the struct
        // address. The walker's count covers a hidden result pointer.
        let touched = walker_param_count(&func);
        func.n_params = touched.max(f.n_params).max(func.n_params);
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
    crate::c5::codegen::passes::noreturn::run(&mut out, program, false);
    crate::c5::codegen::passes::simplify_branches::run(&mut out);
    (out, failed)
}

/// Bodies handed to a lowering in place of the AST walk, plus the frame
/// slots the passes that produced them promoted out (the debug-info
/// emitter drops those stale locations).
#[derive(Debug, Default)]
pub(crate) struct PrebuiltSsa {
    pub funcs: Vec<FunctionSsa>,
    pub promoted_local_slots: alloc::collections::BTreeMap<usize, Vec<i64>>,
    /// The functions reachable before the -O pipeline ran, which the
    /// walk cannot re-derive from `funcs`: see
    /// [`compute_live_sets`]'s `reachable_owners`.
    pub reachable_owners: alloc::collections::BTreeSet<usize>,
    /// `passes::ipa_const_param`'s entry range per parameter, by entry
    /// PC, for the passes that run on these bodies and read ranges.
    pub param_ranges: ParamRanges,
}

/// Entry range of each parameter of a function, by entry PC.
pub(crate) type ParamRanges =
    alloc::collections::BTreeMap<usize, Vec<crate::c5::codegen::passes::value_range::Range>>;

/// The post-inline data-liveness report of a lowering's static DCE,
/// made by [`drop_unreachable_statics`]. The function set was mutated
/// (the -O pipeline's inliner and branch folds), so an object whose last
/// reference the inliner removed is live per the pre-inline call graph;
/// this names the reachable set the SSA bodies actually use. The caller
/// compacts `.data` to it and lowers `ssa` against the result. It must
/// lower `ssa` rather than re-walk: the ASTs describe the pre-inline
/// program, which still materialises the address of the object the
/// compaction drops.
#[derive(Debug)]
pub(crate) struct OrphanedData {
    pub sets: LiveSets,
    pub ssa: PrebuiltSsa,
}

/// Drop every `FunctionSsa` unreachable per [`compute_live_sets`], then
/// report the data objects the pruned bodies leave unreferenced. Runs
/// after the function set was mutated (the -O pipeline's inliner and
/// branch folds); at the default level the prune is the one
/// [`produce_ssa_funcs`] applies. `force` keeps the report when nothing
/// is dead: a probe caller compacts the program from this report alone,
/// so it needs the all-live set and the pruned function list even when
/// no object drops. A caller lowering an already-compacted image passes
/// `false`, and `None` then means the image is exactly the reachable set.
pub(crate) fn drop_unreachable_statics(
    funcs: &mut Vec<FunctionSsa>,
    program: &Program,
    reachable_owners: &alloc::collections::BTreeSet<usize>,
    force: bool,
) -> Option<OrphanedData> {
    let live = compute_live_sets(
        funcs,
        &Default::default(),
        program,
        true,
        Some(reachable_owners),
    )
    .func_pcs;
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
    let sets = compute_live_sets(
        funcs,
        &Default::default(),
        program,
        false,
        Some(reachable_owners),
    );
    if sets.data_live.iter().all(|&l| l) && !force {
        return None;
    }
    // The reported copy carries only the bodies the compacted lowering
    // emits.
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
            param_ranges: ParamRanges::new(),
            reachable_owners: reachable_owners.clone(),
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
        // The AST-level pass mirrors compute_live_sets and drops the
        // unit's dead functions before the walk, so the walk -- and the
        // -O passes over its bodies -- never see them. The SSA pass
        // below re-derives the set from the walked bodies; the assertion
        // catches an AST pass that dropped a function the SSA pass
        // keeps (a walked body still naming it).
        let reachable = super::ast_reach::reachable_functions(program);
        let (mut funcs, failed) = walk_program(program, target, optimize, jump_tables, &reachable);
        // C99 6.2.2: a function with internal linkage that no reachable
        // code or data references is unobservable; drop it before codegen
        // so the unused `static inline` helpers headers pull into every
        // unit do not reach the image.
        let unwalked = failed.iter().map(|&(pc, _)| pc).collect();
        let live = compute_live_sets(&funcs, &unwalked, program, false, None).func_pcs;
        // The AST set also holds functions only an unevaluated operand or a
        // folded arm names, so a failed walk is an error only once live.
        if let Some((_, e)) = failed.into_iter().find(|(pc, _)| live.contains(pc)) {
            return Err(e);
        }
        #[cfg(debug_assertions)]
        {
            let dropped = dropped_live_functions(program, &reachable, &live);
            assert!(
                dropped.is_empty(),
                "the AST reachability dropped functions the SSA liveness keeps: {dropped:?}"
            );
        }
        funcs.retain(|f| live.contains(&f.ent_pc));
        #[cfg(feature = "codegen_test")]
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

/// The finished functions the SSA liveness `live` keeps and `reachable` lacks.
#[cfg(any(debug_assertions, test))]
pub(crate) fn dropped_live_functions<'p>(
    program: &'p Program,
    reachable: &alloc::collections::BTreeSet<usize>,
    live: &alloc::collections::BTreeSet<usize>,
) -> Vec<&'p str> {
    program
        .finished_functions
        .iter()
        .filter(|f| live.contains(&f.ent_pc) && !reachable.contains(&f.ent_pc))
        .map(|f| f.name.as_str())
        .collect()
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
pub(crate) enum Node {
    Func(usize),
    Data(usize),
}

/// Sorted `.data` object boundaries: offset 0, every recorded object
/// start, and every named-global offset. The single boundary model for
/// both the liveness walk and the compaction that applies its result.
pub(crate) fn data_object_starts(program: &Program) -> Vec<i64> {
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

/// Function and data reachability of a unit (C99 6.2.2: an unreferenced internal
/// definition is dropped, as by gcc -O); a pass adds each function's own edges.
pub(crate) struct ReachGraph<'p> {
    program: &'p Program,
    data_len: i64,
    starts: Vec<i64>,
    /// Assembler names of the defined objects and finished functions.
    named: alloc::collections::BTreeMap<&'p str, Node>,
    code_edges: Vec<Vec<usize>>,
    data_edges: Vec<Vec<usize>>,
    /// What a symbol keeps; an object with its owner if block-scope.
    symbol_funcs: Vec<usize>,
    symbol_objects: Vec<(usize, Option<u64>)>,
}

impl<'p> ReachGraph<'p> {
    /// `funcs` add the names of the bodies with no AST.
    pub(crate) fn new(program: &'p Program, funcs: &'p [FunctionSsa]) -> Self {
        use crate::c5::symbol::Linkage;
        use crate::c5::token::Token;
        let starts = data_object_starts(program);
        let n = starts.len();
        let mut graph = ReachGraph {
            program,
            data_len: program.data.len() as i64,
            starts,
            named: alloc::collections::BTreeMap::new(),
            code_edges: alloc::vec![Vec::new(); n],
            data_edges: alloc::vec![Vec::new(); n],
            symbol_funcs: Vec::new(),
            symbol_objects: Vec::new(),
        };
        let mut renamed = alloc::collections::BTreeMap::new();
        for s in &program.symbols {
            let keeps = matches!(s.linkage, Linkage::External) || s.is_used;
            if s.class == Token::Glo as i64
                && s.defined_here
                && !s.is_thread_local
                && let Some(i) = graph.interval(s.val)
            {
                if !s.name.is_empty() {
                    graph.named.insert(s.link_name(), Node::Data(i));
                }
                if keeps {
                    graph.symbol_objects.push((i, s.owner_ent_pc));
                }
            }
            // A section attribute selects placement and keeps nothing (gcc).
            if s.class == Token::Fun as i64 && (keeps || s.is_alias) {
                graph.symbol_funcs.push(s.val as usize);
            }
            renamed.extend(function_rename(s));
        }
        for f in &program.finished_functions {
            if !f.name.is_empty() {
                graph
                    .named
                    .insert(emitted_name(&renamed, f), Node::Func(f.ent_pc));
            }
        }
        for f in funcs {
            if !f.name.is_empty() {
                graph.named.insert(f.name.as_str(), Node::Func(f.ent_pc));
            }
        }
        // A slot the loader binds to a binding holds no trampoline.
        for r in &program.code_relocs {
            if program.bound_trampoline(r.target_ent_pc).is_none()
                && let Some(i) = graph.interval(r.data_offset as i64)
            {
                graph.code_edges[i].push(r.target_ent_pc as usize);
            }
        }
        // A `&&label` slot keeps its function as a function pointer does.
        for (off, ent_pc) in program.label_data_slots() {
            if let Some(i) = graph.interval(off as i64) {
                graph.code_edges[i].push(ent_pc);
            }
        }
        // By the anchor: a one-past-the-end target is the next object's start.
        for r in &program.data_relocs {
            if let (Some(i), Some(t)) = (
                graph.interval(r.data_offset as i64),
                graph.interval(r.target_anchor as i64),
            ) {
                graph.data_edges[i].push(t);
            }
        }
        graph
    }

    fn interval(&self, off: i64) -> Option<usize> {
        (0..self.data_len)
            .contains(&off)
            .then(|| match self.starts.binary_search(&off) {
                Ok(i) => i,
                Err(i) => i.saturating_sub(1),
            })
    }

    pub(crate) fn data(&self, off: i64) -> Option<Node> {
        self.interval(off).map(Node::Data)
    }

    pub(crate) fn asm_names(&self, text: &[u8], work: &mut Vec<Node>) {
        push_asm_names(text, &self.named, work);
    }

    /// The roots, and the block-scope statics a symbol keeps by owner: an
    /// edge from the owner, or a root once `reachable_owners` holds it.
    fn roots(
        &self,
        defined: &alloc::collections::BTreeSet<usize>,
        reachable_owners: Option<&alloc::collections::BTreeSet<usize>>,
        assume_data_live: bool,
    ) -> (Vec<Node>, alloc::collections::BTreeMap<usize, Vec<usize>>) {
        let program = self.program;
        let mut work: Vec<Node> = Vec::new();
        let mut owner_deps: alloc::collections::BTreeMap<usize, Vec<usize>> =
            alloc::collections::BTreeMap::new();
        for &pc in &self.symbol_funcs {
            if defined.contains(&pc) {
                work.push(Node::Func(pc));
            }
        }
        for &(i, owner) in &self.symbol_objects {
            match owner {
                Some(pc) if !reachable_owners.is_some_and(|o| o.contains(&(pc as usize))) => {
                    owner_deps.entry(pc as usize).or_default().push(i);
                }
                _ => work.push(Node::Data(i)),
            }
        }
        // An alias chain's defined end (a weak alias's `val` is an import).
        for a in &program.function_aliases {
            let mut t = a.target.as_str();
            for _ in 0..program.function_aliases.len() {
                match program.function_aliases.iter().find(|x| x.name == t) {
                    Some(next) => t = next.target.as_str(),
                    None => break,
                }
            }
            if let Some(&Node::Func(pc)) = self.named.get(t) {
                work.push(Node::Func(pc));
            }
        }
        // Referenced from `.init_array`, the export table, the image header.
        for f in &program.init_funcs {
            work.push(Node::Func(f.ent_pc));
        }
        for e in &program.exports {
            work.push(Node::Func(e.ent_pc));
        }
        if program.entry_name.is_some() {
            work.push(Node::Func(program.entry_pc));
        }
        // The NULL guard.
        if !self.starts.is_empty() {
            work.push(Node::Data(0));
        }
        // The TLS template is kept whole.
        for r in &program.tls_data_relocs {
            work.extend(self.data(r.target_anchor as i64));
        }
        for r in &program.tls_code_relocs {
            work.push(Node::Func(r.target_ent_pc as usize));
        }
        // A name in a file-scope `asm()` keeps nothing: the assembler resolves
        // it, as for gcc, which parses no template; `used` keeps a definition.
        if assume_data_live {
            work.extend((0..self.starts.len()).map(Node::Data));
        }
        (work, owner_deps)
    }

    /// Close the roots over the `.data` edges and those `body_edges` pushes per
    /// reached pc: the reached pcs (import placeholders among them), live intervals.
    pub(crate) fn solve(
        &self,
        defined: &alloc::collections::BTreeSet<usize>,
        reachable_owners: Option<&alloc::collections::BTreeSet<usize>>,
        assume_data_live: bool,
        mut body_edges: impl FnMut(usize, &mut Vec<Node>),
    ) -> (alloc::collections::BTreeSet<usize>, Vec<bool>) {
        let (mut work, owner_deps) = self.roots(defined, reachable_owners, assume_data_live);
        let mut funcs = alloc::collections::BTreeSet::new();
        let mut data_live = alloc::vec![false; self.starts.len()];
        while let Some(node) = work.pop() {
            match node {
                Node::Func(pc) => {
                    if !funcs.insert(pc) {
                        continue;
                    }
                    if let Some(deps) = owner_deps.get(&pc) {
                        work.extend(deps.iter().map(|&d| Node::Data(d)));
                    }
                    body_edges(pc, &mut work);
                }
                Node::Data(i) => {
                    if core::mem::replace(&mut data_live[i], true) {
                        continue;
                    }
                    work.extend(self.code_edges[i].iter().map(|&t| Node::Func(t)));
                    work.extend(self.data_edges[i].iter().map(|&d| Node::Data(d)));
                }
            }
        }
        (funcs, data_live)
    }
}

/// [`ReachGraph`] solved over SSA bodies; `unwalked` are definitions with
/// no body to read. `assume_data_live` pre-marks all data
/// live for callers running after the `.data` image is final.
///
/// `reachable_owners` names functions reachable before the -O pipeline
/// rewrote the call graph. A `used` block-scope static of such an owner
/// is a root rather than an edge: the object is emitted once the owner
/// is reached, and inlining the owner into its callers -- or folding
/// away the branch its last call sat in -- leaves the owner's code in
/// the image with no call edge left to reach it by. `None` for a caller
/// running on the walker's own output, where the call graph is the
/// source's.
pub(crate) fn compute_live_sets(
    funcs: &[FunctionSsa],
    unwalked: &alloc::collections::BTreeSet<usize>,
    program: &Program,
    assume_data_live: bool,
    reachable_owners: Option<&alloc::collections::BTreeSet<usize>>,
) -> LiveSets {
    use crate::c5::ir::Inst;
    let graph = ReachGraph::new(program, funcs);
    let by_ent: alloc::collections::BTreeMap<usize, &FunctionSsa> =
        funcs.iter().map(|f| (f.ent_pc, f)).collect();
    let defined = by_ent.keys().chain(unwalked).copied().collect();
    let (func_pcs, data_live) =
        graph.solve(&defined, reachable_owners, assume_data_live, |pc, work| {
            let Some(f) = by_ent.get(&pc) else { return };
            // An address keeps its referent only if emitted: the use counts
            // behind the emitters' dead-code skip.
            let counts = super::reg_alloc::compute_use_counts(f);
            for blk in &f.blocks {
                for i in blk.inst_range.clone() {
                    match &f.insts[i as usize] {
                        Inst::Call { target_pc, .. } => work.push(Node::Func(*target_pc)),
                        Inst::ImmCode(t) if counts[i as usize] > 0 => work.push(Node::Func(*t)),
                        Inst::ImmData(off) if counts[i as usize] > 0 => {
                            work.extend(graph.data(*off));
                        }
                        Inst::InlineAsm { asm, args } => {
                            graph.asm_names(&asm.template, work);
                            // A static operand's referent has no counted use.
                            for (op, &a) in asm.operands.iter().zip(args) {
                                if !op.static_arg {
                                    continue;
                                }
                                let Some(crate::c5::asm::StaticOperand::Addr { base, .. }) =
                                    crate::c5::asm::asm_operand_static(f, a)
                                else {
                                    continue;
                                };
                                match f.insts.get(base as usize) {
                                    Some(Inst::ImmCode(t)) => work.push(Node::Func(*t)),
                                    Some(Inst::ImmData(off)) => work.extend(graph.data(*off)),
                                    _ => {}
                                }
                            }
                        }
                        _ => {}
                    }
                }
            }
        });
    LiveSets {
        func_pcs,
        starts: graph.starts,
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

/// Where each object of the input image landed in the packed one:
/// `(packed base, length, input offset)`, ascending by packed base, for
/// resolving a packed offset back.
pub(crate) struct DataMap {
    kept: Vec<(i64, i64, i64)>,
}

impl DataMap {
    fn new(starts: &[i64], new_base: &[i64], obj_len: &[i64]) -> DataMap {
        let mut kept: Vec<(i64, i64, i64)> = (0..starts.len())
            .filter(|&i| new_base[i] >= 0)
            .map(|i| (new_base[i], obj_len[i], starts[i]))
            .collect();
        kept.sort_unstable();
        DataMap { kept }
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

    /// The map of an image whose packed layout is its own: every input
    /// offset is its packed offset. Pairs SSA built against an uncompacted
    /// program with a compaction of that program, so
    /// [`apply_data_liveness`] carries each body's `ImmData` offsets
    /// straight onto the new layout.
    pub(crate) fn identity(program: &Program) -> DataMap {
        let starts = data_object_starts(program);
        let data_len = program.data.len() as i64;
        let obj_lens: Vec<i64> = (0..starts.len())
            .map(|i| if i + 1 < starts.len() { starts[i + 1] } else { data_len } - starts[i])
            .collect();
        DataMap::new(&starts, &starts, &obj_lens)
    }
}

/// What [`compact_program_data`] produced.
pub(crate) struct Compaction {
    pub program: Program,
    /// Size of the zero-fill region the packed layout moved past the
    /// file image. Read by the Mach-O writer's bss test; the other
    /// callers pack with `segregate` off, where it is 0.
    #[cfg_attr(not(all(test, target_os = "macos")), allow(dead_code))]
    pub bss_size: i64,
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
    };
    let data_len = program.data.len() as i64;
    if data_len == 0 || program.finished_functions.is_empty() {
        return Ok(unchanged());
    }
    // A/B measurement against the unpruned data. Diagnostic only: read
    // under the `codegen_test` feature so a production build never
    // consults the environment.
    #[cfg(feature = "codegen_test")]
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
    let sets = compute_live_sets(&funcs, &Default::default(), program, false, None);
    let (out, bss_size, _map) =
        apply_data_liveness(program.clone(), &sets, &live_func_pcs, segregate, None);
    Ok(Compaction {
        program: out,
        bss_size,
    })
}

/// Rewrite `out` in place to hold only the data objects `sets` marks live
/// and only the functions in `live_func_pcs`, packing `.data` and mapping
/// every offset surface -- symbol values, relocation slots, relocation
/// targets and their anchors, AST data references, recorded padding and
/// alignment marks, object starts -- onto the new layout. Split out of
/// [`compact_program_data`] so a caller holding a later, sharper live set
/// (post-inline reachability) applies it through the same code.
///
/// The program is taken by value: this is a whole-program rewrite, and
/// the symbol table and the AST bodies it copies dominate the cost of
/// producing one. A caller that still needs the original passes a clone.
///
/// `ssa` are bodies the caller lowers instead of re-walking the ASTs,
/// paired with the map of the image their offsets are in (itself produced
/// from the same program). Their `Inst::ImmData` offsets -- the only
/// `.data` offset the IR holds -- are carried back through that map and
/// forward through this one here, so no consumer is left on a stale
/// layout.
pub(crate) fn apply_data_liveness(
    mut out: Program,
    sets: &LiveSets,
    live_func_pcs: &alloc::collections::BTreeSet<usize>,
    segregate: bool,
    ssa: Option<(&mut [FunctionSsa], &DataMap)>,
) -> (Program, i64, DataMap) {
    let data_len = out.data.len() as i64;
    let starts = &sets.starts;
    let live = &sets.data_live;
    debug_assert_eq!(*starts, data_object_starts(&out));
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
    let cap = crate::c5::layout::bss_image_align(out.data_align);
    let obj_align = crate::c5::layout::data_object_aligns(&out, starts, cap);
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
        for sym in &out.symbols {
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
        for &(lo, hi) in &out.const_data_ranges {
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
    for off in out.data_reloc_offsets() {
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
            && out.data[starts[i] as usize..obj_end(i) as usize]
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
        for &(lo, hi) in &out.data_pad_ranges {
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
    let mut new_data: Vec<u8> = Vec::with_capacity(out.data.len());
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
            new_data.extend_from_slice(&out.data[starts[i] as usize..obj_end(i) as usize]);
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
    (out, bss_size, DataMap::new(starts, &new_base, &obj_lens))
}

/// Read-only measurement of statically-dead data objects (no mutation,
/// no effect on codegen). Emits one line per translation unit to the
/// path in `BADC_DATA_DCE_LOG` when that variable is set, validating the
/// object-boundary model and the achievable `.data` reduction. Read
/// under the `codegen_test` feature only, as every environment knob is.
#[cfg(feature = "codegen_test")]
fn measure_dead_data(funcs: &[FunctionSsa], program: &Program) {
    use std::io::Write;

    let Ok(log_path) = std::env::var("BADC_DATA_DCE_LOG") else {
        return;
    };
    let data_len = program.data.len() as i64;
    if data_len == 0 {
        return;
    }
    let sets = compute_live_sets(funcs, &Default::default(), program, false, None);
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

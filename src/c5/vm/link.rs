//! The interpreter's link step: the program and the on-demand sources it
//! pulls join into one function list, data image and binding table, each
//! unit's `ent_pc`s, offsets and binding indices past the previous units'.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::ssa;
use crate::c5::error::C5Error;
use crate::c5::ir::{FunctionSsa, Inst, Terminator};
use crate::c5::program::Program;
use crate::c5::symbol::Linkage;
use crate::c5::token::Token;

/// A definition's place in its unit: an `ent_pc`, a data or a TLS offset.
#[derive(Clone, Copy)]
enum Def {
    Code(usize),
    Data(u64),
    Tls(u64),
}

/// A program lifted, bound to its aliases and the interpreter's library.
pub(super) struct VmUnit {
    program: Program,
    funcs: Vec<FunctionSsa>,
    binding_names: Vec<String>,
    weak: BTreeSet<String>,
    /// Each extern function's placeholder `ent_pc`, weak ones included.
    imports: BTreeMap<usize, String>,
}

impl VmUnit {
    pub(super) fn lift(mut program: Program) -> Result<Self, C5Error> {
        use crate::c5::codegen::ssa::shadow;
        // A weak function nothing defines is the null address, as a link
        // resolves it; only a call to it, when made, fails.
        let weak: BTreeSet<String> = (program.weak_link_names().into_iter())
            .map(String::from)
            .collect();
        let imports: BTreeMap<usize, String> = (program.extern_function_imports.iter())
            .map(|(pc, name)| (*pc, name.clone()))
            .collect();
        let weak_fn_pcs: BTreeSet<usize> = (imports.iter())
            .filter(|(_, name)| weak.contains(name.as_str()))
            .map(|(&pc, _)| pc)
            .collect();
        let mut funcs = shadow::produce_ssa_funcs(&program, program.target, false, true)?;
        // TODO: structured exception handling under the interpreter.
        if let Some(f) = funcs.iter().find(|f| f.has_seh()) {
            return Err(crate::c5::error::C5Error::hard(
                crate::c5::diag::Code::UNSUPPORTED,
                alloc::format!(
                    "in function `{}`: SEH under the interpreter not implemented yet",
                    f.name
                ),
            ));
        }
        shadow::bind_alias_imports(&program, &mut funcs);
        for inst in funcs.iter_mut().flat_map(|f| f.insts.iter_mut()) {
            if matches!(inst, Inst::ImmCode(pc) if weak_fn_pcs.contains(pc)) {
                *inst = Inst::Imm(0);
            }
        }
        let mut code_relocs = core::mem::take(&mut program.code_relocs);
        crate::c5::codegen::bind_code_reloc_aliases(&program, &mut code_relocs);
        program.code_relocs = code_relocs;
        let mut tls_code_relocs = core::mem::take(&mut program.tls_code_relocs);
        crate::c5::codegen::bind_code_reloc_aliases(&program, &mut tls_code_relocs);
        program.tls_code_relocs = tls_code_relocs;
        let mut binding_names: Vec<String> = (program.dylibs.iter())
            .flat_map(|d| d.bindings.iter().map(|b| b.local_name.clone()))
            .collect();
        super::bind_interpreter_library(&program, &mut funcs, &weak_fn_pcs, &mut binding_names);
        Ok(Self {
            program,
            funcs,
            binding_names,
            weak,
            imports,
        })
    }

    /// Names no other unit's definition binds (C99 6.2.2p2).
    fn internal(&self) -> BTreeSet<&str> {
        (self.program.symbols.iter())
            .filter(|s| s.linkage == Linkage::Internal)
            .map(|s| s.link_name())
            .collect()
    }

    fn data_bound(&self, name: &str) -> bool {
        (self.program.dylibs.iter())
            .flat_map(|d| d.bindings.iter())
            .any(|b| b.is_data && b.local_name == name)
    }

    /// `sym`'s name unless the unit defines it: such a reference is to the
    /// function at `ent_pc` 0.
    fn undefined_symbol(&self, sym: u32) -> Option<&str> {
        let s = self.program.symbols.get(sym as usize)?;
        (!s.defined_here).then(|| s.link_name())
    }

    /// The definitions of external linkage, each with whether it is weak.
    fn definitions(&self) -> Vec<(String, Def, bool)> {
        let mut defs = Vec::new();
        for s in &self.program.symbols {
            if !s.defined_here || s.linkage != Linkage::External || s.name.is_empty() {
                continue;
            }
            let def = if s.is_fun_entity() && !s.is_alias {
                Def::Code(s.val as usize)
            } else if s.class == Token::Glo as i64 && s.is_thread_local {
                Def::Tls(s.val.max(0) as u64)
            } else if s.class == Token::Glo as i64 {
                Def::Data(s.val.max(0) as u64)
            } else {
                continue;
            };
            defs.push((s.link_name().to_string(), def, s.is_weak));
        }
        for a in &self.program.function_aliases {
            let target = defs
                .iter()
                .find(|(n, ..)| *n == a.target)
                .map(|&(_, d, _)| d);
            if let Some(def @ Def::Code(_)) = target {
                let weak = a.bind == crate::c5::program::AliasBind::Weak;
                defs.push((a.name.clone(), def, weak));
            }
        }
        defs
    }

    /// The strong external names referenced, neither defined, bound nor supplied.
    pub(super) fn undefined(&self) -> BTreeSet<String> {
        let mut names: BTreeSet<&str> = BTreeSet::new();
        for f in &self.funcs {
            for inst in &f.insts {
                if let Inst::Call { target_pc: pc, .. } | Inst::ImmCode(pc) = inst
                    && let Some(name) = self.imports.get(pc)
                {
                    names.insert(name);
                }
            }
            let refs = (f.extern_call_refs.iter())
                .chain(&f.extern_imm_code_refs)
                .chain(&f.extern_imm_data_refs)
                .chain(&f.extern_tls_refs);
            for &(_, sym) in refs {
                if let Some(s) = self.program.symbols.get(sym as usize)
                    && !s.defined_here
                {
                    names.insert(s.link_name());
                }
            }
        }
        let code_relocs = self
            .program
            .code_relocs
            .iter()
            .chain(&self.program.tls_code_relocs);
        for r in code_relocs {
            if let Some(name) = self.imports.get(&(r.target_ent_pc as usize)) {
                names.insert(name);
            }
        }
        for r in &self.program.extern_data_relocs {
            names.insert(&r.symbol_name);
        }
        let internal = self.internal();
        (names.into_iter())
            .filter(|n| {
                !self.weak.contains(*n)
                    && !internal.contains(n)
                    && !self.data_bound(n)
                    && !ssa::interp_supplies(n)
            })
            .map(String::from)
            .collect()
    }

    /// One past the highest `ent_pc` the unit uses.
    fn pc_extent(&self) -> usize {
        let funcs = self.funcs.iter().map(|f| f.end_pc.max(f.ent_pc + 1));
        let imports = self.imports.keys().map(|&pc| pc + 1);
        funcs.chain(imports).max().unwrap_or(0)
    }
}

/// The on-demand sources a run may join; there are none without the linker.
#[cfg(feature = "full")]
pub(super) type Sources<'a> = Option<&'a crate::c5::linker::OnDemandSources>;
#[cfg(not(feature = "full"))]
pub(super) type Sources<'a> = Option<&'a core::convert::Infallible>;

/// The run's units: the program, then the on-demand sources a native link
/// would join to it, offered once the program leaves a name undefined.
pub(super) fn join_on_demand(user: VmUnit, sources: Sources<'_>) -> Result<Vec<VmUnit>, C5Error> {
    match sources {
        #[cfg(feature = "full")]
        Some(sources) => pull_members(user, sources),
        _ => Ok(alloc::vec![user]),
    }
}

#[cfg(feature = "full")]
fn pull_members(
    user: VmUnit,
    sources: &crate::c5::linker::OnDemandSources,
) -> Result<Vec<VmUnit>, C5Error> {
    let mut undefined = user.undefined();
    let mut units = alloc::vec![user];
    if undefined.is_empty() {
        return Ok(units);
    }
    let (strong, weak) = units[0].program.external_definitions();
    let mut defined: BTreeSet<String> = strong.into_iter().chain(weak).collect();
    let members = sources.members()?;
    crate::c5::linker::on_demand::select(members, &mut defined, &mut undefined, |i| {
        let unit = VmUnit::lift(members[i].program.clone())?;
        let refs = unit.undefined().into_iter().collect();
        units.push(unit);
        Ok(refs)
    })?;
    Ok(units)
}

/// The run's units joined.
#[derive(Default)]
pub(super) struct Linked {
    pub(super) funcs: Vec<FunctionSsa>,
    pub(super) data: Vec<u8>,
    pub(super) tls_base: usize,
    pub(super) binding_names: Vec<String>,
    pub(super) entry_pc: usize,
    pub(super) init_pcs: Vec<usize>,
    pub(super) fini_pcs: Vec<usize>,
}

/// Where each unit starts in the joined program.
struct Bases {
    pc: usize,
    data: u64,
    tls: u64,
    binding: i64,
}

/// Each external name's defining unit, definition and weakness.
type Table = BTreeMap<String, (usize, Def, bool)>;

fn undefined(name: &str) -> C5Error {
    C5Error::Runtime(format!("undefined reference to `{name}`"))
}

/// An object nothing in the unit defines: host data the interpreter
/// cannot reach, or an undefined reference.
fn unreachable_object(unit: &VmUnit, name: &str) -> C5Error {
    if unit.data_bound(name) {
        return C5Error::Runtime(format!(
            "`{name}` is bound to host data; the interpreter cannot \
             reach host memory (use --jit or compile natively)"
        ));
    }
    undefined(name)
}

/// Join `units`, the program first; a reference nothing defines is refused
/// unless the name is weak, then the null address.
pub(super) fn link(units: Vec<VmUnit>) -> Result<Linked, C5Error> {
    let mut bases = Vec::with_capacity(units.len());
    let (mut pc, mut data, mut tls, mut binding) = (0usize, 0u64, 0u64, 0i64);
    let mut tls_align = 16;
    for u in &units {
        let align = u.program.data_align.max(16) as u64;
        let unit_tls_align = crate::c5::layout::tls_image_align(u.program.tls_align);
        tls_align = tls_align.max(unit_tls_align);
        data = data.next_multiple_of(align);
        tls = tls.next_multiple_of(unit_tls_align as u64);
        bases.push(Bases {
            pc,
            data,
            tls,
            binding,
        });
        pc += u.pc_extent();
        data += u.program.data.len() as u64;
        tls += u.program.tls_data.len() as u64;
        binding += u.binding_names.len() as i64;
    }
    let mut table = Table::new();
    for (k, u) in units.iter().enumerate() {
        for (name, def, weak) in u.definitions() {
            let replace = match table.get(&name) {
                None => true,
                Some(&(held, _, held_weak)) => held_weak && !weak && held != 0,
            };
            if replace {
                table.insert(name, (k, def, weak));
            }
        }
    }
    let address = |unit: usize, def: Def| -> i64 {
        let b = &bases[unit];
        match def {
            Def::Code(pc) => (pc + b.pc) as i64,
            Def::Data(off) => (off + b.data) as i64,
            Def::Tls(off) => (off + b.tls) as i64,
        }
    };
    let tls_block = (data as usize).next_multiple_of(tls_align);
    let mut image = alloc::vec![0u8; tls_block + tls as usize];
    let mut out = Linked {
        funcs: Vec::new(),
        data: Vec::new(),
        tls_base: tls_block,
        binding_names: Vec::new(),
        entry_pc: units.first().map_or(0, |u| u.program.entry_pc),
        init_pcs: Vec::new(),
        fini_pcs: Vec::new(),
    };
    let mut inits: Vec<(Option<u32>, bool, usize)> = Vec::new();
    for (k, mut u) in units.into_iter().enumerate() {
        let b = &bases[k];
        let internal: BTreeSet<String> = u.internal().into_iter().map(String::from).collect();
        let resolve = |name: &str| -> Option<(usize, Def)> {
            let &(unit, def, _) = table.get(name)?;
            (!internal.contains(name)).then_some((unit, def))
        };
        let code = |name: &str| match resolve(name) {
            Some((unit, def @ Def::Code(_))) => Some(address(unit, def) as usize),
            _ => None,
        };
        // Own references move with the unit; the others bind by name.
        let mut funcs = core::mem::take(&mut u.funcs);
        for f in &mut funcs {
            let mut named: BTreeSet<u32> = BTreeSet::new();
            for (v, sym) in core::mem::take(&mut f.extern_call_refs) {
                let Some(name) = u.undefined_symbol(sym) else {
                    continue;
                };
                let target = match code(name) {
                    Some(pc) => pc,
                    None if u.weak.contains(name) => usize::MAX,
                    None => return Err(undefined(name)),
                };
                if let Inst::Call { target_pc, .. } = &mut f.insts[v as usize] {
                    *target_pc = target;
                }
                named.insert(v);
            }
            for (v, sym) in core::mem::take(&mut f.extern_imm_code_refs) {
                let Some(name) = u.undefined_symbol(sym) else {
                    continue;
                };
                f.insts[v as usize] = match code(name) {
                    Some(pc) => Inst::ImmCode(pc),
                    None if u.weak.contains(name) => Inst::Imm(0),
                    None => return Err(undefined(name)),
                };
                named.insert(v);
            }
            let objects = (core::mem::take(&mut f.extern_imm_data_refs).into_iter())
                .map(|r| (r, false))
                .chain(
                    core::mem::take(&mut f.extern_tls_refs)
                        .into_iter()
                        .map(|r| (r, true)),
                );
            for ((v, sym), tls) in objects {
                let Some(name) = u.undefined_symbol(sym) else {
                    continue;
                };
                f.insts[v as usize] = match resolve(name) {
                    Some((unit, def @ Def::Data(_))) if !tls => Inst::ImmData(address(unit, def)),
                    Some((unit, def @ Def::Tls(_))) if tls => Inst::TlsAddr(address(unit, def)),
                    Some((unit, def @ Def::Code(_))) if !tls => {
                        Inst::ImmCode(address(unit, def) as usize)
                    }
                    _ if u.weak.contains(name) => Inst::Imm(0),
                    _ => return Err(unreachable_object(&u, name)),
                };
                named.insert(v);
            }
            for (i, inst) in f.insts.iter_mut().enumerate() {
                if named.contains(&(i as u32)) {
                    continue;
                }
                match inst {
                    Inst::Call { target_pc: pc, .. } | Inst::ImmCode(pc) => {
                        *pc = match u.imports.get(pc) {
                            Some(name) => match code(name) {
                                Some(at) => at,
                                None if u.weak.contains(name.as_str()) => usize::MAX,
                                None => return Err(undefined(name)),
                            },
                            None => *pc + b.pc,
                        };
                    }
                    Inst::ImmData(off) => *off += b.data as i64,
                    Inst::TlsAddr(off) => *off += b.tls as i64,
                    Inst::ParentLocalAddr { parent, .. } => *parent += b.pc,
                    Inst::CallExt { binding_idx, .. } => *binding_idx += b.binding,
                    Inst::ImmExtCode(idx) | Inst::TailExt(idx) => *idx += b.binding,
                    _ => {}
                }
            }
            for block in &mut f.blocks {
                block.start_pc += b.pc;
                if let Terminator::TailExt(idx) = &mut block.terminator {
                    *idx += b.binding;
                }
            }
            f.ent_pc += b.pc;
            f.end_pc += b.pc;
            for s in &mut f.seh_scopes {
                use crate::c5::ir::ScopeHandler;
                if let ScopeHandler::Filter(pc) | ScopeHandler::Finally(pc) = &mut s.handler {
                    *pc += b.pc;
                }
            }
            for r in &mut f.label_data_relocs {
                r.data_offset += b.data;
            }
        }
        // A slot naming a C-library binding holds `Inst::ImmExtCode`'s value.
        let program = &u.program;
        let slot_value = |r: &crate::c5::program::CodeReloc| -> Result<u64, C5Error> {
            let pc = r.target_ent_pc as usize;
            let binding = program
                .sys_trampolines
                .iter()
                .find(|t| t.0 == r.target_ent_pc);
            let raw = match (binding, u.imports.get(&pc)) {
                (Some(&(_, idx)), _) => (ssa::IMPORT_ADDR_TAG | (idx + b.binding)) as u64,
                (None, Some(name)) => match code(name) {
                    Some(at) => ssa::CODE_ADDR_TAG as u64 | at as u64,
                    None if u.weak.contains(name.as_str()) => 0,
                    None => return Err(undefined(name)),
                },
                (None, None) => ssa::CODE_ADDR_TAG as u64 | (pc + b.pc) as u64,
            };
            Ok(raw.wrapping_add_signed(r.addend))
        };
        let at = b.data as usize;
        image[at..at + program.data.len()].copy_from_slice(&program.data);
        let put = |image: &mut [u8], off: usize, v: u64| {
            image[off..off + 8].copy_from_slice(&v.to_le_bytes());
        };
        // A pointer-to-object slot holds the object's offset in the image.
        if b.data != 0 {
            for r in &program.data_relocs {
                put(
                    &mut image,
                    at + r.data_offset as usize,
                    r.target_offset + b.data,
                );
            }
        }
        for r in &program.code_relocs {
            put(&mut image, at + r.data_offset as usize, slot_value(r)?);
        }
        // A slot naming a weak object nothing defines holds the null
        // address plus its offset, as a link fills it.
        for r in &program.extern_data_relocs {
            let value = match resolve(&r.symbol_name) {
                Some((unit, def @ (Def::Data(_) | Def::Tls(_)))) => address(unit, def) as u64,
                Some((unit, def @ Def::Code(_))) => {
                    ssa::CODE_ADDR_TAG as u64 | address(unit, def) as u64
                }
                None if u.weak.contains(r.symbol_name.as_str()) => 0,
                None => return Err(unreachable_object(&u, &r.symbol_name)),
            };
            put(
                &mut image,
                at + r.data_offset as usize,
                value.wrapping_add_signed(r.addend),
            );
        }
        // The unit's thread-local template, at its offset in the block.
        let tls_at = tls_block + b.tls as usize;
        image[tls_at..tls_at + program.tls_data.len()].copy_from_slice(&program.tls_data);
        if b.data != 0 {
            for r in &program.tls_data_relocs {
                put(
                    &mut image,
                    tls_at + r.data_offset as usize,
                    r.target_offset + b.data,
                );
            }
        }
        for r in &program.tls_code_relocs {
            put(&mut image, tls_at + r.data_offset as usize, slot_value(r)?);
        }
        for f in &program.init_funcs {
            inits.push((f.priority, f.is_destructor, f.ent_pc + b.pc));
        }
        out.binding_names.append(&mut u.binding_names);
        out.funcs.append(&mut funcs);
    }
    // A `&&label` initializer slot holds the value a runtime label
    // address has: the code position `Inst::BlockAddr` materializes for
    // the label's block, which `GotoIndirect` decodes.
    for (func_idx, f) in out.funcs.iter().enumerate() {
        for r in &f.label_data_relocs {
            let off = r.data_offset as usize;
            let runtime = ssa::code_position(func_idx, r.block as usize, 0) as u64;
            image[off..off + 8].copy_from_slice(&runtime.to_le_bytes());
        }
    }
    // Constructors / destructors, ordered as the native `.init_array`
    // path runs them: prioritized ascending, then unprioritized (a
    // stable sort keeps source order within a priority).
    inits.sort_by_key(|&(p, ..)| (p.is_none(), p.unwrap_or(0)));
    for (_, dtor, pc) in inits {
        if dtor {
            out.fini_pcs.push(pc);
        } else {
            out.init_pcs.push(pc);
        }
    }
    out.data = image;
    Ok(out)
}

//! Control Flow Guard (`--guard-cf`): the functions of a PE image an
//! indirect call may enter. A function is one when the image takes its
//! address -- a reference other than a call names it -- or when something
//! outside the image's own code calls it: a constructor-table, TLS-callback
//! or `__try` handler entry. An object compiled for the guard lists the
//! functions it takes the address of instead (`.gfids$y`).

use alloc::collections::BTreeSet;
use alloc::string::{String, ToString};

use super::super::got_relax::{self, GotUse, is_x86_64_got_pcrel};
use super::super::object::{
    NativeMachine, NativeReloc, NativeSymSection, NativeSymbol, STT_FUNC, STT_SECTION,
    SectionFamily,
};
use super::{Link, MODULE, is_branch_reloc, link_err};
use crate::c5::codegen::{GuardSlot, GuardTableSymbol};
use crate::c5::diag::Code;
use crate::c5::error::C5Error;
use crate::c5::object::elf_reloc_types::{R_X86_64_PC32, aarch64_is_tls, x86_64_is_tls};

/// What a reference names: a function of the image at a merged text
/// offset, an import, or neither.
enum Named {
    Function(u64),
    Import(String),
    Other,
}

impl<'a> Link<'a> {
    /// Fill [`Link::guard_cf`]'s targets and imports.
    pub(super) fn collect_guard_targets(&mut self) -> Result<(), C5Error> {
        if !self.pe_image {
            let text = "`--guard-cf` lists the call targets of a PE image only";
            return Err(link_err(Code::LINK, MODULE, text));
        }
        let objs = self.objs;
        // A section-relative reference names a function only at one's entry.
        let mut entries = BTreeSet::new();
        for (i, o) in objs.iter().enumerate() {
            for s in o.symbols.iter().filter(|s| s.kind == STT_FUNC) {
                if s.section == NativeSymSection::Text
                    && let Some(at) = self.symbol_offset(i, s)
                {
                    entries.insert(at);
                }
            }
        }
        // The pointers the loader replaces with the system's check are not
        // calls a check sees, and the routines they start at are reached
        // only through them.
        let check_pointers: Vec<_> = (["__guard_check_icall_fptr", "__guard_dispatch_icall_fptr"])
            .iter()
            .filter_map(|name| self.defined.get(*name))
            .map(|d| d.value..d.value + d.size.max(8))
            .collect();
        let (mut targets, mut imports) = (BTreeSet::new(), BTreeSet::new());
        let mut add = |named: Named| match named {
            Named::Function(at) => {
                targets.insert(at);
            }
            Named::Import(name) => {
                imports.insert(name);
            }
            Named::Other => {}
        };
        for (i, o) in objs.iter().enumerate() {
            if let Some(fids) = &o.guard_fids {
                for &k in fids {
                    if let Some(sym) = o.symbols.get(k) {
                        add(self.guard_named(i, sym, 0, &entries));
                    }
                }
                continue;
            }
            let this = &*self;
            let kept = |fam| move |r: &&NativeReloc| !this.dropped_site(i, fam, r.offset);
            let relocs = (o.text_relocs.iter())
                .filter(kept(SectionFamily::Text))
                .map(|r| (r, None))
                .chain(
                    (o.relro_relocs.iter())
                        .filter(kept(SectionFamily::RelRo))
                        .map(|r| (r, Some(self.relro_map[i].at(r.offset)))),
                )
                .chain(
                    (o.data_relocs.iter())
                        .filter(kept(SectionFamily::Data))
                        .map(|r| (r, Some(self.rw_map[i].at(r.offset)))),
                );
            for (r, data_site) in relocs {
                if self.takes_no_address(i, r.rtype, r.offset, data_site.is_none())
                    || data_site.is_some_and(|at| check_pointers.iter().any(|p| p.contains(&at)))
                {
                    continue;
                }
                let Some(sym) = o.symbols.get(r.sym_idx) else {
                    continue;
                };
                // A PC-relative disp32 is measured from the instruction's
                // end, 4 bytes past the field where nothing follows it.
                let past = match self.machine {
                    NativeMachine::X86_64 if r.rtype == R_X86_64_PC32 => 4,
                    _ => 0,
                };
                add(self.guard_named(i, sym, r.addend + past, &entries));
            }
        }
        let init = (self.init_entries.iter())
            .chain(&self.fini_entries)
            .chain(&self.tls_callbacks);
        targets.extend(init.copied());
        let handlers = self.seh_rows.iter().filter_map(|row| row.2);
        targets.extend(handlers.map(u64::from));
        let guard = self.guard_cf.as_mut().unwrap();
        guard.targets = targets.into_iter().collect();
        guard.imports = imports.into_iter().collect();
        Ok(())
    }

    /// Whether the relocation at `offset` takes no function's address: a
    /// branch, a call or jump through a GOT slot, or a thread-local access.
    fn takes_no_address(&self, unit: usize, rtype: u32, offset: u64, in_text: bool) -> bool {
        match self.machine {
            NativeMachine::X86_64 if x86_64_is_tls(rtype) => true,
            NativeMachine::Aarch64 if aarch64_is_tls(rtype) => true,
            NativeMachine::X86_64 if in_text && is_x86_64_got_pcrel(rtype) => {
                let field = self.text_map[unit].at(offset) as usize;
                let how = got_relax::got_use(&self.text, field, rtype);
                matches!(how, GotUse::Call | GotUse::Jump)
            }
            machine => in_text && is_branch_reloc(machine, rtype),
        }
    }

    /// The function or import `sym + addend` names, as a unit references it.
    fn guard_named(
        &self,
        unit: usize,
        sym: &NativeSymbol,
        addend: i64,
        entries: &BTreeSet<u64>,
    ) -> Named {
        if sym
            .input_section
            .is_some_and(|k| self.comdats.dropped.contains(&(unit, k)))
        {
            return Named::Other;
        }
        if sym.kind == STT_SECTION {
            if sym.section != NativeSymSection::Text {
                return Named::Other;
            }
            let at = (self.symbol_offset(unit, sym)).map(|base| base.wrapping_add(addend as u64));
            return match at {
                Some(at) if entries.contains(&at) => Named::Function(at),
                _ => Named::Other,
            };
        }
        match self.reference_section(unit, sym) {
            NativeSymSection::Text => match self.symbol_offset(unit, sym) {
                Some(at) => Named::Function(at),
                None => Named::Other,
            },
            NativeSymSection::Undef => match self.defined.get(sym.name.as_str()) {
                Some(d) if d.section == NativeSymSection::Text => Named::Function(d.value),
                Some(_) => Named::Other,
                None if sym.name.is_empty()
                    || self.absolute_defined.contains_key(sym.name.as_str()) =>
                {
                    Named::Other
                }
                None => Named::Import(sym.name.to_string()),
            },
            _ => Named::Other,
        }
    }

    /// A data slot naming a guard symbol under `--guard-cf`, which the image
    /// writer fills once the table is placed. Only an 8-byte slot of the
    /// image's own data can hold one.
    pub(super) fn guard_slot(
        &self,
        sym: &NativeSymbol,
        data_offset: u64,
        addend: i64,
        in_tls: bool,
    ) -> Result<Option<GuardSlot>, C5Error> {
        let Some(symbol) = GuardTableSymbol::named(&sym.name).filter(|_| self.guard_cf.is_some())
        else {
            return Ok(None);
        };
        if in_tls {
            let text = alloc::format!("a thread-local slot names `{}`", sym.name);
            return Err(link_err(Code::UNSUPPORTED, MODULE, &text));
        }
        Ok(Some(GuardSlot {
            data_offset,
            symbol,
            addend,
        }))
    }
}

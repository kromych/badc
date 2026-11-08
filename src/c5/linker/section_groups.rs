//! The output section a grouped input section joins: in a PE image
//! `base$suffix` joins `base`, ordered by suffix (PE/COFF specification
//! 4.2), and link.exe's `/merge:from=to` moves `from` into `to`.

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::link_err;
use super::object::{InputSection, NativeObject, SectionFamily, coff_group_base, grouped_by_name};
use crate::c5::C5Error;
use crate::c5::diag::Code;

const MODULE: &str = "section_groups";

/// The sections the PE writer lays out itself.
fn standard(name: &str) -> bool {
    matches!(name, ".text" | ".rdata" | ".data" | ".bss")
}

/// Whether `to` keeps its protection with `family` contents merged in.
fn standard_holds(to: &str, family: SectionFamily) -> bool {
    use SectionFamily::*;
    match to {
        ".text" => family == Text,
        ".rdata" => matches!(family, RoData | RelRo),
        ".data" => matches!(family, Data | Bss),
        ".bss" => family == Bss,
        _ => true,
    }
}

pub(crate) struct SectionGroups {
    pe: bool,
    merges: BTreeMap<String, String>,
}

impl SectionGroups {
    pub(crate) fn new(objs: &[NativeObject], pe: bool) -> Result<Self, C5Error> {
        let mut merges: BTreeMap<String, String> = BTreeMap::new();
        for o in objs {
            for (from, to) in &o.section_merges {
                let refuse = |what: &str| {
                    let text = format!("`/merge:{from}={to}` in {}: {what}", o.source);
                    Err(link_err(Code::LINK, MODULE, &text))
                };
                if !pe {
                    return refuse("a section merge applies to a PE image only");
                }
                if standard(from) || from.starts_with(".idata") || from == ".pdata" {
                    return refuse("the image writer lays out that section itself");
                }
                match merges.get(from) {
                    Some(prev) if prev != to => {
                        return refuse(&format!("`{from}` is already merged into `{prev}`"));
                    }
                    _ => {
                        merges.insert(from.clone(), to.clone());
                    }
                }
            }
        }
        let groups = SectionGroups { pe, merges };
        for from in groups.merges.keys() {
            let mut at = from.as_str();
            for _ in 0..=groups.merges.len() {
                match groups.merges.get(at) {
                    Some(to) => at = to,
                    None => break,
                }
                if at == from {
                    let text = format!("`/merge` sends `{from}` back into itself");
                    return Err(link_err(Code::LINK, MODULE, &text));
                }
            }
        }
        groups.check_protection(objs)?;
        Ok(groups)
    }

    fn check_protection(&self, objs: &[NativeObject]) -> Result<(), C5Error> {
        for o in objs {
            for s in &o.sections {
                let base = s.name.split('$').next().unwrap_or_default();
                if !self.merges.contains_key(base) {
                    continue;
                }
                let to = self.output_of(base);
                if !standard_holds(to, s.family) {
                    use SectionFamily::*;
                    let what = match s.family {
                        Text => "code",
                        RoData | RelRo => "read-only data",
                        Data => "writable data",
                        Bss => "zero-fill data",
                        Tdata | Tbss => "thread-local data",
                        Discard => continue,
                    };
                    let text = format!(
                        "`/merge:{base}={to}`: `{}` in {} holds {what}, which `{to}` does not",
                        s.name, o.source
                    );
                    return Err(link_err(Code::UNSUPPORTED, MODULE, &text));
                }
            }
        }
        Ok(())
    }

    fn output_of<'a>(&'a self, mut name: &'a str) -> &'a str {
        while let Some(to) = self.merges.get(name) {
            name = to;
        }
        name
    }

    pub(crate) fn pe(&self) -> bool {
        self.pe
    }

    /// The output section the grouped input section `name` joins.
    pub(crate) fn output<'a>(&'a self, name: &'a str) -> &'a str {
        match self.pe {
            true => self.output_of(coff_group_base(name).unwrap_or(name)),
            false => name,
        }
    }

    /// Whether the output section `name` joins one the writer lays out.
    pub(crate) fn folded(&self, name: &str) -> bool {
        self.pe && standard(name)
    }

    /// Every unit's grouped `fam` sections by output section, its own ahead
    /// of merged ones, then name and link order. Folded groups adjoin their
    /// section's other bytes: behind the named code sections, which open the
    /// text stream, and ahead of the named data sections.
    pub(crate) fn order<'o>(
        &self,
        objs: &'o [NativeObject],
        fam: SectionFamily,
    ) -> Vec<(usize, &'o InputSection)> {
        let mut v: Vec<(usize, &'o InputSection)> = (objs.iter().enumerate())
            .flat_map(|(i, o)| o.sections.iter().map(move |s| (i, s)))
            .filter(|(_, s)| s.family == fam && grouped_by_name(&s.name))
            .collect();
        let folded_last = fam == SectionFamily::Text;
        v.sort_by_cached_key(|&(i, s)| {
            let out = self.output(&s.name);
            let own = coff_group_base(&s.name).unwrap_or(&s.name) == out || !self.pe;
            let rank = self.folded(out) == folded_last;
            (rank, String::from(out), !own, s.name.clone(), i)
        });
        v
    }
}

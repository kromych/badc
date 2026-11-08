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

/// A function-override table (`<f>_$fo_bdd$`, `<f>_$fo_rvas$`). link.exe's
/// image carries none in a section of its own, so its bytes join `.rdata`.
fn function_override_table(name: &str) -> bool {
    name.split_once('$')
        .is_some_and(|(_, suffix)| suffix.starts_with("fo_") || suffix == "fo$")
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
    /// The data family each output section is placed in: the widest of its
    /// contributions', so one output section is one region, as GNU ld and
    /// link.exe make one section of a name.
    placed: BTreeMap<String, SectionFamily>,
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
        let mut groups = SectionGroups {
            pe,
            merges,
            placed: BTreeMap::new(),
        };
        let rank = |f: SectionFamily| match f {
            SectionFamily::RoData => 0,
            SectionFamily::RelRo => 1,
            _ => 2,
        };
        for s in objs.iter().flat_map(|o| &o.sections) {
            use SectionFamily::*;
            if !matches!(s.family, RoData | RelRo | Data) || !grouped_by_name(&s.name) {
                continue;
            }
            let out = String::from(groups.output(&s.name));
            let at = groups.placed.entry(out).or_insert(s.family);
            if rank(s.family) > rank(*at) {
                *at = s.family;
            }
        }
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

    /// The family a grouped section is placed in: its output section's.
    fn placed_family(&self, s: &InputSection) -> SectionFamily {
        let at = || self.placed.get(self.output(&s.name)).copied();
        match s.family {
            SectionFamily::RoData | SectionFamily::RelRo | SectionFamily::Data => {
                at().unwrap_or(s.family)
            }
            other => other,
        }
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
            true if function_override_table(name) => ".rdata",
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
            .filter(|(_, s)| grouped_by_name(&s.name) && self.placed_family(s) == fam)
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

#[cfg(test)]
mod tests {
    use super::*;

    /// A function-override table joins `.rdata` in a PE image, where another
    /// `base$suffix` section joins `base`; elsewhere a name is its own.
    #[test]
    fn a_function_override_table_joins_rdata() {
        let pe = SectionGroups::new(&[], true).unwrap();
        for name in ["memcpy_$fo_bdd$", "memcpy_$fo_rvas$", "memcpy_$fo$"] {
            assert_eq!(pe.output(name), ".rdata", "{name}");
        }
        assert_eq!(pe.output("table$b"), "table");
        let elf = SectionGroups::new(&[], false).unwrap();
        assert_eq!(elf.output("memcpy_$fo_bdd$"), "memcpy_$fo_bdd$");
    }
}

//! Laying a parsed unit out: the label offsets a section's items
//! settle at, the parse-time constant folding and the branch relaxation
//! the measurement rounds converge, and the materialization that turns
//! the settled items into section bytes, relocations and symbols.

use super::*;
use crate::c5::codegen::map_syms::MapClass;
use crate::c5::codegen::ssa::cfi;

/// Section-relative offsets of the labels one materialize call defines.
/// A same-section label difference (`775f - 774f`, an alternatives
/// replacement length) folds to a constant from these even when the field
/// referencing it sits in another section, and the main stream's `.skip`
/// padding sizes itself from them. Offsets continue from the sink lengths
/// the call starts with, so they agree with the materialized layout.
#[derive(Default)]
pub(crate) struct SectionLabelOffsets {
    map: alloc::collections::BTreeMap<alloc::string::String, (alloc::string::String, i64)>,
    /// `.set` / `.equ` symbols assigned an expression over section-local
    /// locations, each holding the expression's value at its assignment.
    syms: alloc::collections::BTreeMap<alloc::string::String, i64>,
    /// Branches the layout keeps in their long form, by block and item index.
    /// Everything the arch encoder marked relaxable and that is absent here
    /// takes its short form; these offsets were measured under that choice,
    /// so the materializer has to encode from the same set.
    long: AsmRelaxSet,
    /// Section name -> its identity key. GNU as gives every section a
    /// symbol of the section's own name whose value is the section start,
    /// so a bare section name is usable in an expression.
    sections: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    /// Section-relative offset of each top-level item, by block and item
    /// index. A `.rept` body item is absent: its statements occupy one
    /// offset per repetition, so the location counter has no value there.
    places: alloc::collections::BTreeMap<(usize, usize), i64>,
    /// `.set name, symbol` assignments. A reference to one reads the
    /// location the chain ends at, as GNU as resolves it.
    aliases: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    /// Byte alignment of each alignment directive whose operand is an
    /// expression, by block and item index. Measured where the directive
    /// stands, against the labels placed before it, and read back by the
    /// materializer so both walks lay the same gap.
    aligns: alloc::collections::BTreeMap<(usize, usize), u32>,
}

impl SectionLabelOffsets {
    /// The section-relative offset of a label reference (`774f` / a name),
    /// or `None` when the name is not a label this call defines.
    pub(crate) fn offset(&self, name: &str) -> Option<i64> {
        self.map
            .get(numeric_label_digits(name).unwrap_or(name))
            .map(|(_, off)| *off)
    }
    /// The section key a label reference is defined in; two labels fold to a
    /// constant difference only when this agrees.
    pub(crate) fn section(&self, name: &str) -> Option<&str> {
        self.map
            .get(numeric_label_digits(name).unwrap_or(name))
            .map(|(s, _)| s.as_str())
    }
    /// The value of a `.set` symbol assigned a section-local expression.
    pub(crate) fn symbol(&self, name: &str) -> Option<i64> {
        self.syms.get(name).copied()
    }
    /// Whether a relaxable branch keeps its long form under these offsets.
    fn long_form(&self, site: (usize, usize)) -> bool {
        self.long.contains(&site)
    }
    /// The identity key of the section a bare section name refers to.
    pub(crate) fn section_named(&self, name: &str) -> Option<&str> {
        self.sections.get(name).map(|k| k.as_str())
    }
    /// The section-relative offset an item starts at, or `None` where the
    /// item has no single place.
    pub(crate) fn place(&self, site: (usize, usize)) -> Option<i64> {
        self.places.get(&site).copied()
    }
    /// The byte alignment measured for an expression-valued alignment
    /// directive.
    fn align_of(&self, site: (usize, usize)) -> Option<u32> {
        self.aligns.get(&site).copied()
    }
    /// The `.set name, symbol` target of a name, or `None` when the section
    /// defines the name itself -- a label or an assigned value wins over an
    /// assignment of the same name, as it does when valuing a `.set`.
    fn alias(&self, name: &str) -> Option<&str> {
        if self
            .map
            .contains_key(numeric_label_digits(name).unwrap_or(name))
            || self.syms.contains_key(name)
        {
            return None;
        }
        self.aliases.get(name).map(|t| t.as_str())
    }
    /// Follow a `.set` chain to the name it ends at; the depth limit ends a
    /// cycle. A name with no assignment is its own target.
    pub(crate) fn alias_target<'a>(&'a self, name: &'a str) -> &'a str {
        let mut t = name;
        for _ in 0..ASM_ALIAS_DEPTH_LIMIT {
            match self.alias(t) {
                Some(next) => t = next,
                None => break,
            }
        }
        t
    }
}

/// Relaxable branches identified by `(block index, item index)`.
type AsmRelaxSet = alloc::collections::BTreeSet<(usize, usize)>;

/// A relaxable branch as one measurement round placed it, by block and
/// item index, with the section offset the instruction starts at.
struct AsmRelaxSite {
    site: (usize, usize),
    at: i64,
}

/// Section name -> identity key over the blocks being laid out and the
/// sections the sink already holds, answered through the sink's name index
/// rather than by deriving a map per call.
struct SectionNames<'a> {
    blocks: &'a [AsmSectionBlock],
    sink: &'a AsmSectionSink,
}

impl SectionNames<'_> {
    /// The key of the section `name` stands for, the sink's answer winning
    /// over a block of the same name.
    fn get(&self, name: &str) -> Option<alloc::string::String> {
        sink_section_key(self.sink.section_names(), name)
            .map(alloc::string::String::from)
            .or_else(|| {
                self.blocks
                    .iter()
                    .rev()
                    .find(|b| b.name == name)
                    .map(section_key)
            })
    }
}

/// Evaluate a `.set` value over section-local locations: `.` is the offset at
/// the assignment, an identifier is a label, a symbol an earlier `.set`
/// assigned, or an operand constant. Only an absolute result is admitted --
/// same-space terms fold, anything symbolic is rejected. GNU as also gives a
/// location-valued assignment a section-relative symbol, which a referencing
/// field takes a relocation against. TODO location-valued section symbols.
/// Longest `.set name, symbol` chain followed when valuing an expression.
const ASM_ALIAS_DEPTH_LIMIT: usize = 16;

#[allow(clippy::too_many_arguments)]
fn eval_section_set_expr(
    name: &str,
    expr: &str,
    key: &str,
    at: i64,
    labels: &alloc::collections::BTreeMap<alloc::string::String, (alloc::string::String, i64)>,
    syms: &alloc::collections::BTreeMap<alloc::string::String, i64>,
    aliases: &alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    sections: &SectionNames<'_>,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<SectionSetValue, alloc::string::String> {
    let resolve = |t: &str| -> Option<AsmExprLeaf> {
        if t == "." {
            return Some(AsmExprLeaf::Loc(AsmExprTerm {
                space: Some((AsmSpace::Section(alloc::string::String::from(key)), at)),
                target: AsmSectionTarget::OwnSection(at as u32),
            }));
        }
        if let Some(v) = syms.get(t) {
            return Some(AsmExprLeaf::Abs(*v));
        }
        // Follow a `.set name, symbol` chain to the label it names.
        let mut t = t;
        for _ in 0..ASM_ALIAS_DEPTH_LIMIT {
            match labels.get(numeric_label_digits(t).unwrap_or(t)) {
                Some((sk, off)) => {
                    return Some(AsmExprLeaf::Loc(AsmExprTerm {
                        space: Some((AsmSpace::Section(sk.clone()), *off)),
                        target: AsmSectionTarget::Symbol(alloc::string::String::from(t)),
                    }));
                }
                None => match aliases.get(t) {
                    Some(next) => t = next.as_str(),
                    // Last, so a label of the same name wins.
                    None => return sections.get(t).map(|sk| section_start_leaf(&sk)),
                },
            }
        }
        None
    };
    let ctx = AsmExprCtx {
        resolve: &resolve,
        const_of,
        lax_div: false,
    };
    let v = eval_asm_value(expr, &ctx)
        .map_err(|e| alloc::format!("inline asm: `.set {name}, {expr}`: {e}"))?;
    if let Some(c) = v.to_abs() {
        return Ok(SectionSetValue::Abs(c));
    }
    // `.set x, .` and `.set x, label + k`: the name takes the location, and
    // reads of it resolve like a label's.
    match (&v.pos, &v.neg) {
        (
            Some(AsmExprTerm {
                space: Some((AsmSpace::Section(sk), off)),
                ..
            }),
            None,
        ) => Ok(SectionSetValue::Loc(sk.clone(), off + v.add)),
        // `.set x, sym + k` over a name this unit's layout does not define:
        // the name is an alias of `sym` at that offset, which the object
        // writer places against the definition wherever it lands.
        (
            Some(AsmExprTerm {
                space: None,
                target: AsmSectionTarget::Symbol(_),
            }),
            None,
        ) => Ok(SectionSetValue::Alias),
        _ => Err(alloc::format!(
            "inline asm: `.set {name}, {expr}` is not an absolute value or a location"
        )),
    }
}

/// A `.set` assignment's value: an absolute constant, a location of a
/// section of this unit, or a symbol the unit's layout does not place.
enum SectionSetValue {
    Abs(i64),
    Loc(alloc::string::String, i64),
    Alias,
}

/// Fold an instruction operand expression, assembled into section `key`, to
/// the absolute value GNU as requires there: an instruction field carries no
/// relocation, so the expression has to reduce to a literal, an assigned
/// symbol, or a difference of two labels of one section. `here` is the
/// section offset the instruction is placed at, the value of the location
/// counter; `None` where the statement has no single place.
pub(crate) fn fold_asm_operand_expr(
    expr: &str,
    key: &str,
    here: Option<i64>,
    measured: &SectionLabelOffsets,
) -> Result<i64, alloc::string::String> {
    let (labels, sections) = (AsmSinkLabels::new(), AsmSinkSectionNames::new());
    let sink_labels = AsmSinkNames {
        labels: &labels,
        sections: &sections,
    };
    let num_unique = alloc::collections::BTreeMap::new();
    let resolve = |t: &str| {
        let at = if t == "." { here? } else { 0 };
        section_expr_leaf(t, key, at, measured, &sink_labels, &num_unique, &|_| None)
    };
    let ctx = AsmExprCtx {
        resolve: &resolve,
        const_of: &|_| None,
        lax_div: false,
    };
    let v = eval_asm_value(expr, &ctx).map_err(|e| alloc::format!("inline asm: `{expr}`: {e}"))?;
    match resolve_asm_value(v, None) {
        Ok(AsmResolved::Abs(c)) => Ok(c),
        _ => Err(alloc::format!(
            "inline asm: `{expr}` is not an absolute value in an instruction operand"
        )),
    }
}

/// Resolve one leaf of a location expression evaluated inside section `key`
/// with the location counter at `here`: the counter itself, a `.set` value,
/// a template label of the enclosing statement, a section label of this
/// call, or a label an earlier statement left in the sink. A name none of
/// those define takes the value of the name its `.set name, symbol` chain
/// ends at; its relocation still names what the source wrote, as GNU as
/// resolves the chain for the value alone. `None` is an undefined symbol. A
/// numeric reference binds only within this call, per GNU as label locality.
fn section_expr_leaf(
    t: &str,
    key: &str,
    here: i64,
    measured: &SectionLabelOffsets,
    sink_labels: &AsmSinkNames<'_>,
    num_unique: &alloc::collections::BTreeMap<&str, alloc::string::String>,
    label_off: &dyn Fn(&str) -> Option<LabelLoc>,
) -> Option<AsmExprLeaf> {
    if t == "." {
        return Some(AsmExprLeaf::Loc(AsmExprTerm {
            space: Some((AsmSpace::Section(alloc::string::String::from(key)), here)),
            target: AsmSectionTarget::OwnSection(here as u32),
        }));
    }
    if let Some(leaf) = section_expr_defined_leaf(t, measured, sink_labels, num_unique, label_off) {
        return Some(leaf);
    }
    let mut cur = t;
    for _ in 0..ASM_ALIAS_DEPTH_LIMIT {
        let Some(next) = measured.alias(cur) else {
            break;
        };
        cur = next;
        if let Some(leaf) =
            section_expr_defined_leaf(cur, measured, sink_labels, num_unique, label_off)
        {
            return Some(leaf_named(leaf, t));
        }
    }
    // Last, so a label of the same name wins: a bare section name is that
    // section's start.
    sink_labels
        .section(cur)
        .or_else(|| measured.section_named(cur))
        .map(section_start_leaf)
}

/// A leaf reached through a `.set` chain, renamed to the symbol the source
/// wrote. An absolute value and a region reference name no symbol.
fn leaf_named(leaf: AsmExprLeaf, name: &str) -> AsmExprLeaf {
    match leaf {
        AsmExprLeaf::Loc(AsmExprTerm {
            space,
            target: AsmSectionTarget::Symbol(_),
        }) => AsmExprLeaf::Loc(AsmExprTerm {
            space,
            target: AsmSectionTarget::Symbol(alloc::string::String::from(name)),
        }),
        other => other,
    }
}

/// The leaf for a name the layout defines; `None` leaves the name to the
/// alias chain and the section names.
fn section_expr_defined_leaf(
    t: &str,
    measured: &SectionLabelOffsets,
    sink_labels: &AsmSinkNames<'_>,
    num_unique: &alloc::collections::BTreeMap<&str, alloc::string::String>,
    label_off: &dyn Fn(&str) -> Option<LabelLoc>,
) -> Option<AsmExprLeaf> {
    if let Some(v) = measured.symbol(t) {
        return Some(AsmExprLeaf::Abs(v));
    }
    if let Some(loc) = label_off(t) {
        return Some(AsmExprLeaf::Loc(match loc {
            LabelLoc::Text(off) => AsmExprTerm {
                space: Some((AsmSpace::Text, off as i64)),
                target: AsmSectionTarget::Text(off),
            },
            LabelLoc::Deferred { region, off } => AsmExprTerm {
                space: Some((AsmSpace::Deferred(region), off as i64)),
                target: AsmSectionTarget::DeferredText {
                    region,
                    off: off as u32,
                },
            },
        }));
    }
    if let (Some(sk), Some(off)) = (measured.section(t), measured.offset(t)) {
        let name = numeric_label_digits(t)
            .and_then(|d| num_unique.get(d).cloned())
            .unwrap_or_else(|| alloc::string::String::from(t));
        return Some(AsmExprLeaf::Loc(AsmExprTerm {
            space: Some((AsmSpace::Section(alloc::string::String::from(sk)), off)),
            target: AsmSectionTarget::Symbol(name),
        }));
    }
    if numeric_label_digits(t).is_none()
        && let Some((sk, off)) = sink_labels.label(t)
    {
        return Some(AsmExprLeaf::Loc(AsmExprTerm {
            space: Some((AsmSpace::Section(sk.clone()), *off)),
            target: AsmSectionTarget::Symbol(alloc::string::String::from(t)),
        }));
    }
    None
}

/// The start of the section with identity key `sk`, as an expression leaf.
fn section_start_leaf(sk: &str) -> AsmExprLeaf {
    AsmExprLeaf::Loc(AsmExprTerm {
        space: Some((AsmSpace::Section(alloc::string::String::from(sk)), 0)),
        target: AsmSectionTarget::SectionStart(alloc::string::String::from(sk)),
    })
}

/// Evaluate an `.org` target expression at offset `at` of section `key`:
/// an absolute value is a section offset, a location of this section is its
/// offset. `resolve` answers labels; `.` is supplied here.
///
/// A location of this section resolves to its offset, as GNU as does by
/// deferring an `.org` target to final symbol resolution: operator order
/// then does not decide whether the target reduces.
fn eval_org_target(
    expr: &str,
    key: &str,
    at: i64,
    resolve: &dyn Fn(&str) -> Option<AsmExprLeaf>,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<i64, alloc::string::String> {
    let leaf = |t: &str| -> Option<AsmExprLeaf> {
        if t == "." {
            return Some(AsmExprLeaf::Abs(at));
        }
        Some(match resolve(t)? {
            AsmExprLeaf::Loc(AsmExprTerm {
                space: Some((AsmSpace::Section(k), off)),
                target,
            }) => match k == key {
                true => AsmExprLeaf::Abs(off),
                false => AsmExprLeaf::Loc(AsmExprTerm {
                    space: Some((AsmSpace::Section(k), off)),
                    target,
                }),
            },
            other => other,
        })
    };
    let ctx = AsmExprCtx {
        resolve: &leaf,
        const_of,
        lax_div: false,
    };
    let v = eval_asm_value(expr, &ctx).map_err(|e| alloc::format!("inline asm: `.org`: {e}"))?;
    if let Some(n) = v.to_abs() {
        return Ok(n);
    }
    if let AsmExprValue {
        add,
        pos: Some(p),
        neg: None,
    } = &v
        && let Some((AsmSpace::Section(k), off)) = &p.space
        && k == key
    {
        return Ok(off + add);
    }
    Err(alloc::format!(
        "inline asm: `.org {expr}` is not a location of this section"
    ))
}

/// Byte length of one item inside a `.rept` body. Only fixed-length,
/// label-free items repeat; anything else is rejected.
fn rept_item_len(
    item: &AsmSectionItem,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<i64, alloc::string::String> {
    Ok(match item {
        AsmSectionItem::Data { width, values } => *width as i64 * values.len() as i64,
        AsmSectionItem::Bytes(bs) => bs.len() as i64,
        AsmSectionItem::CodeBytes { bytes, relocs, .. } if relocs.is_empty() => bytes.len() as i64,
        AsmSectionItem::Fill { count, unit, .. } => {
            eval_fill_count(count, const_of)? * *unit as i64
        }
        _ => {
            return Err(alloc::string::String::from(
                "inline asm: unsupported item inside `.rept`",
            ));
        }
    })
}

/// The mapping state an item leaves behind. Attribute-only items, `.org`
/// and an alignment of one leave it unchanged; a wider alignment directive
/// in an executable section leaves instructions even where it padded
/// nothing, so a following instruction is not realigned. An unresolved
/// alignment operand cannot be read here; the walks resolve it first.
pub(crate) fn step_map_state(
    item: &AsmSectionItem,
    cur: Option<MapClass>,
    exec: bool,
) -> Option<MapClass> {
    match item {
        AsmSectionItem::CodeBytes { .. } => Some(MapClass::Code),
        AsmSectionItem::Align {
            spec: AlignSpec::Bytes(n),
            ..
        } => (*n > 1)
            .then_some(if exec { MapClass::Code } else { MapClass::Data })
            .or(cur),
        AsmSectionItem::Data { .. } | AsmSectionItem::Fill { .. } | AsmSectionItem::Bytes(_) => {
            Some(MapClass::Data)
        }
        AsmSectionItem::Rept { items, .. } => items
            .iter()
            .fold(cur, |st, it| step_map_state(it, st, exec)),
        _ => cur,
    }
}

/// Whether `tok` names a layout directive: the alignment, space-and-fill and
/// `.org` families move the location counter instead of depositing an
/// encoding, so an instruction stream lays them down rather than assembling
/// them.
pub(crate) fn is_stream_layout_directive(tok: &str) -> bool {
    align_directive(tok).is_some() || tok == ".org" || is_fill_directive(tok)
}

/// Parse a layout directive to the section item describing it, so an
/// instruction stream and the section engine read one grammar. `None` when
/// `tok` is not a layout directive.
pub(crate) fn parse_stream_layout_item(
    tok: &str,
    rest: &str,
    is_aarch64: bool,
) -> Option<Result<AsmSectionItem, alloc::string::String>> {
    is_stream_layout_directive(tok).then(|| parse_section_item(tok, rest, is_aarch64))
}

/// Lay a layout directive into an AArch64 instruction stream at the end of
/// `out`, whose length is a section offset. `data` collects the runs that are
/// not instructions, for the mapping symbols; a `.org` records none, as in
/// GNU as, so the surrounding run covers its gap. `resolve` values a label
/// reference in a count or an `.org` target and `const_of` an `i`-class
/// operand. Returns the alignment the directive requests, which the caller
/// raises the section's by.
pub(crate) fn push_a64_stream_layout(
    item: &AsmSectionItem,
    out: &mut alloc::vec::Vec<u8>,
    data: &mut alloc::vec::Vec<(usize, usize)>,
    resolve: &dyn Fn(&str) -> Option<i64>,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<u32, alloc::string::String> {
    let at = out.len();
    fn align(
        out: &mut alloc::vec::Vec<u8>,
        data: &mut alloc::vec::Vec<(usize, usize)>,
        n: u32,
        fill: Option<AlignFill>,
        max: Option<u32>,
    ) -> Result<u32, alloc::string::String> {
        let at = out.len();
        let gap = align_gap(at as i64, n as i64, max) as usize;
        let (lead, _) = push_align_fill(out, gap, fill, true, AlignNops::A64, false)?;
        if lead > 0 {
            data.push((at, lead));
        }
        Ok(n)
    }
    // A `.org` target below the counter is an error in GNU as, not a rewind.
    fn org(
        out: &mut alloc::vec::Vec<u8>,
        target: i64,
        fill: u8,
    ) -> Result<u32, alloc::string::String> {
        if target < out.len() as i64 {
            return Err(alloc::string::String::from(
                "inline asm: `.org` moves backwards",
            ));
        }
        out.resize(target as usize, fill);
        Ok(1)
    }
    match item {
        AsmSectionItem::Align {
            spec, fill, max, ..
        } => align(out, data, spec.bytes(resolve)?, *fill, *max),
        AsmSectionItem::Fill { count, unit, value } => {
            let n = eval_fill_count_with(count, at as i64, const_of, resolve).ok_or_else(|| {
                alloc::format!("inline asm: fill count `{count}` is not a constant expression")
            })?;
            push_fill(out, n.max(0), *unit, *value);
            if out.len() > at {
                data.push((at, out.len() - at));
            }
            Ok(1)
        }
        AsmSectionItem::Org(n, fill) => org(out, *n as i64, *fill),
        AsmSectionItem::OrgLabel {
            label,
            addend,
            fill,
        } => {
            let base = resolve(label).ok_or_else(|| {
                alloc::format!("inline asm: `.org` label `{label}` is not defined above")
            })?;
            let add = eval_const_expr_ops(addend, const_of).ok_or_else(|| {
                alloc::string::String::from("inline asm: non-constant `.org` addend")
            })?;
            org(out, base + add, *fill)
        }
        AsmSectionItem::OrgExpr(expr, fill) => {
            let target = eval_fill_count_with(expr, at as i64, const_of, resolve)
                .ok_or_else(|| alloc::format!("inline asm: bad `.org` offset `{expr}`"))?;
            org(out, target, *fill)
        }
        _ => Err(alloc::string::String::from(
            "inline asm: unsupported layout directive",
        )),
    }
}

/// GNU as fixes a non-branch operand field's width when it parses the
/// instruction: the expression narrows only when it is a constant at that
/// point, which a difference of already-defined labels is exactly when the
/// items between them have parse-time fixed sizes. This context follows a
/// statement's blocks in source order, numbering each run of fixed-size
/// items and recording where every name is defined, so the arch encoder can
/// fold such an expression to its value before it chooses the encoding. A
/// branch carrying a short alternative, an alignment, an `.org`, and a fill
/// whose count does not fold end the run: a difference across one has a
/// layout-dependent value, and GNU as keeps the wide field there even when
/// the final layout would fit the narrow one.
///
/// The walk goes block by block, which within one chain is source order.
/// Across chains the blocks do not record how the source interleaved them,
/// so a reference to a label of another chain folds only when that chain
/// was walked already; where GNU as saw the definition earlier in the
/// source, the field stays wide. The value of every fold is exact -- a run
/// has one size in every layout -- so the boundary costs width only.
#[derive(Default)]
pub(crate) struct AsmParseFold {
    /// `(section key, subsection)` -> the chain's current run and offset.
    /// A chain re-entered after other sections continues where it left off.
    chains: alloc::collections::BTreeMap<(alloc::string::String, u32), (u32, i64)>,
    cur: (alloc::string::String, u32),
    runs: u32,
    names: alloc::collections::BTreeMap<alloc::string::String, AsmFoldDef>,
    /// Numeric label digits -> latest definition, for `Nb` references.
    numeric: alloc::collections::BTreeMap<alloc::string::String, (u32, i64)>,
}

/// What a name means to the fold: a location in a run, an absolute value,
/// or a definition it cannot value (which shadows an earlier one).
enum AsmFoldDef {
    Loc(u32, i64),
    Abs(i64),
    Opaque,
}

impl AsmParseFold {
    /// Continue (or open) the chain of `block`'s section and subsection.
    pub(crate) fn enter_block(&mut self, block: &AsmSectionBlock) {
        let key = (section_key(block), block.subsection);
        if !self.chains.contains_key(&key) {
            let id = self.next_run();
            self.chains.insert(key.clone(), (id, 0));
        }
        self.cur = key;
    }

    fn next_run(&mut self) -> u32 {
        self.runs += 1;
        self.runs
    }

    fn here(&self) -> Option<(u32, i64)> {
        self.chains.get(&self.cur).copied()
    }

    /// End the current run: what follows sits a layout-dependent distance
    /// from everything before this point.
    fn break_run(&mut self) {
        let id = self.next_run();
        if let Some(c) = self.chains.get_mut(&self.cur) {
            *c = (id, 0);
        }
    }

    fn advance(&mut self, n: i64) {
        if let Some(c) = self.chains.get_mut(&self.cur) {
            c.1 += n;
        }
    }

    /// The leaf a name means at this point of the walk: the location
    /// counter, a numeric `Nb` reference, or a recorded definition. `None`
    /// leaves the name symbolic, which keeps its expression out of the fold;
    /// a name an earlier statement of the unit defined stays symbolic too,
    /// as the distance to it spans items this walk never saw.
    fn leaf(&self, t: &str) -> Option<AsmExprLeaf> {
        let loc = |(run, off): (u32, i64)| {
            AsmExprLeaf::Loc(AsmExprTerm {
                space: Some((AsmSpace::Frag(run), off)),
                target: AsmSectionTarget::Symbol(alloc::string::String::from(t)),
            })
        };
        if t == "." {
            return self.here().map(loc);
        }
        if let Some(d) = numeric_label_digits(t) {
            if d.len() == t.len() || t.ends_with('f') {
                return None;
            }
            return self.numeric.get(d).copied().map(loc);
        }
        match self.names.get(t)? {
            AsmFoldDef::Loc(run, off) => Some(loc((*run, *off))),
            AsmFoldDef::Abs(v) => Some(AsmExprLeaf::Abs(*v)),
            AsmFoldDef::Opaque => None,
        }
    }

    /// The expression's value when it is a constant at this point of the
    /// parse, which is when GNU as folds it into the operand.
    pub(crate) fn fold(&self, expr: &str, const_of: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
        let ctx = AsmExprCtx {
            resolve: &|t| self.leaf(t),
            const_of,
            lax_div: false,
        };
        eval_asm_value(expr, &ctx).ok().and_then(|v| v.to_abs())
    }

    /// Record `item`'s effect on the walk: a definition, a fixed-size
    /// advance, or the end of the current run.
    pub(crate) fn note_item(
        &mut self,
        item: &AsmSectionItem,
        const_of: &dyn Fn(u8) -> Option<i64>,
    ) {
        match item {
            AsmSectionItem::Label(name) => {
                let Some(here) = self.here() else { return };
                match numeric_label_digits(name) {
                    Some(d) if d.len() == name.len() => {
                        self.numeric.insert(alloc::string::String::from(d), here);
                    }
                    _ => {
                        self.names
                            .insert(name.clone(), AsmFoldDef::Loc(here.0, here.1));
                    }
                }
            }
            AsmSectionItem::Data { width, values } => {
                self.advance(*width as i64 * values.len() as i64)
            }
            AsmSectionItem::Bytes(b) => self.advance(b.len() as i64),
            AsmSectionItem::Fill { count, unit, .. } => match self.fold(count, const_of) {
                Some(n) => self.advance(n.max(0) * *unit as i64),
                None => self.break_run(),
            },
            AsmSectionItem::CodeBytes {
                bytes, short: None, ..
            } => self.advance(bytes.len() as i64),
            AsmSectionItem::SymSet { name, target } => {
                let def = match self.leaf(target) {
                    Some(AsmExprLeaf::Loc(AsmExprTerm {
                        space: Some((AsmSpace::Frag(r), off)),
                        ..
                    })) => AsmFoldDef::Loc(r, off),
                    Some(AsmExprLeaf::Abs(v)) => AsmFoldDef::Abs(v),
                    _ => AsmFoldDef::Opaque,
                };
                self.names.insert(name.clone(), def);
            }
            AsmSectionItem::SetExpr { name, expr } => {
                let ctx = AsmExprCtx {
                    resolve: &|t| self.leaf(t),
                    const_of,
                    lax_div: false,
                };
                let def = match eval_asm_value(expr, &ctx) {
                    Ok(v) => fold_def_of(v),
                    Err(_) => AsmFoldDef::Opaque,
                };
                self.names.insert(name.clone(), def);
            }
            AsmSectionItem::AbsSet { name, value } => {
                self.names.insert(name.clone(), AsmFoldDef::Abs(*value));
            }
            // Symbol attributes and deferred diagnostics deposit no bytes.
            AsmSectionItem::Global(_)
            | AsmSectionItem::Local(_)
            | AsmSectionItem::Weak(_)
            | AsmSectionItem::Visibility { .. }
            | AsmSectionItem::Type { .. }
            | AsmSectionItem::Size { .. }
            | AsmSectionItem::CondDiag(_)
            | AsmSectionItem::Cfi(_)
            | AsmSectionItem::File(_)
            | AsmSectionItem::Ident(_)
            | AsmSectionItem::Reloc { .. } => {}
            // A branch both of whose widths ride into the layout, an
            // alignment, an `.org`, a deferred repeat, a literal pool, or
            // unencoded text: the layout owns the size.
            _ => self.break_run(),
        }
    }
}

/// The definition a `.set` expression value records: a constant, a location
/// offset into a run, or neither.
fn fold_def_of(v: AsmExprValue) -> AsmFoldDef {
    if let Some(c) = v.to_abs() {
        return AsmFoldDef::Abs(c);
    }
    match (&v.pos, &v.neg) {
        (
            Some(AsmExprTerm {
                space: Some((AsmSpace::Frag(r), off)),
                ..
            }),
            None,
        ) => AsmFoldDef::Loc(*r, off + v.add),
        _ => AsmFoldDef::Opaque,
    }
}

/// Measure the section-relative offset of every label the blocks define,
/// before the field values (or the main stream) are laid out. Each item's
/// byte length is structural -- data width times count, string length,
/// alignment / `.org` padding -- so a forward label difference and the
/// `.skip` replacement padding resolve without the values. A fill count
/// over label differences (the alternatives `.skip` padding sized by
/// labels of another section) resolves in a second round against the
/// first round's offsets.
///
/// A branch the arch encoder gave a short form starts short and is
/// lengthened, permanently, when the round's layout leaves its displacement
/// outside the short field. Each round either lengthens a branch or stops,
/// so the walk ends after at most one round per candidate, and the round it
/// stops on is a layout in which every short branch reaches -- the layout
/// the materializer lays down, since it encodes from this result.
/// Lengthening is what makes that sound: it never puts a displacement out
/// of reach that was in reach, while shortening can, through an alignment
/// or `.org` that absorbs the bytes saved ahead of it.
pub(crate) fn measure_asm_section_offsets(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    align_is_p2: bool,
    sink: &AsmSectionSink,
) -> Result<SectionLabelOffsets, alloc::string::String> {
    let mut long = AsmRelaxSet::new();
    let mut sites = alloc::vec::Vec::new();
    let mut m = measure_fill_rounds(blocks, const_of, align_is_p2, sink, &long, &mut sites)?;
    if sites.is_empty() {
        return Ok(m);
    }
    // A relaxable branch resolves in place against any same-section name the
    // link cannot rebind, so only weakness holds the long form here.
    let weak_only = asm_weak_only_names(blocks, sink);
    loop {
        let grown: AsmRelaxSet = sites
            .iter()
            .filter(|s| {
                !long.contains(&s.site)
                    && !short_form_fits(blocks, &m, &weak_only, s, const_of, sink)
            })
            .map(|s| s.site)
            .collect();
        if grown.is_empty() {
            m.long = long;
            return Ok(m);
        }
        long.extend(grown);
        sites.clear();
        m = measure_fill_rounds(blocks, const_of, align_is_p2, sink, &long, &mut sites)?;
    }
}

/// Whether the site's short branch reaches its target under `m`. Only a
/// target the materializer resolves in place qualifies; any other keeps a
/// relocation, which the link fills at the long form's width.
fn short_form_fits(
    blocks: &[AsmSectionBlock],
    m: &SectionLabelOffsets,
    rebindable: &AsmBindingNames<'_>,
    s: &AsmRelaxSite,
    const_of: &dyn Fn(u8) -> Option<i64>,
    sink: &AsmSectionSink,
) -> bool {
    let Some(AsmSectionItem::CodeBytes {
        short: Some(short), ..
    }) = blocks[s.site.0].items.get(s.site.1)
    else {
        return false;
    };
    let key = section_key(&blocks[s.site.0]);
    let place = s.at + short.reloc.offset as i64;
    let value = match &short.reloc.target {
        AsmSectionTarget::Symbol(name) => {
            // The reference takes the location of the name its `.set` chain
            // ends at and the binding of the name written, as the
            // materializer does. A `.set` expression name is an absolute
            // value, not a location in this section, and a rebindable name
            // may bind to another definition at link time, so either keeps a
            // relocation at the long form's width.
            if rebindable.contains(name.as_str()) {
                return false;
            }
            let name = m.alias_target(name.as_str());
            if m.symbol(name).is_some() {
                return false;
            }
            let (Some(sec), Some(off)) = (m.section(name), m.offset(name)) else {
                return false;
            };
            if sec != key {
                return false;
            }
            off + short.reloc.addend - place
        }
        // A branch to an expression reaches where the materializer folds it
        // to a constant; a symbol left in the value keeps its relocation.
        // The main stream's labels are not laid out yet, so a target naming
        // one takes the long form.
        AsmSectionTarget::Expr(text) => {
            let num_unique = alloc::collections::BTreeMap::new();
            let sink_names = AsmSinkNames {
                labels: &sink.labels,
                sections: sink.section_names(),
            };
            let resolve =
                |t: &str| section_expr_leaf(t, &key, s.at, m, &sink_names, &num_unique, &|_| None);
            let ctx = AsmExprCtx {
                resolve: &resolve,
                const_of,
                lax_div: false,
            };
            let space = AsmSpace::Section(key.clone());
            let folded = resolve_asm_field_expr(
                text,
                &ctx,
                &space,
                place,
                short.reloc.addend,
                true,
                rebindable,
            );
            match folded {
                Ok(AsmFieldTarget::Abs(c)) => c,
                _ => return false,
            }
        }
        _ => return false,
    };
    let lim = 1i64 << (8 * short.reloc.width as u32 - 1);
    (-lim..lim).contains(&value)
}

/// Names the unit binds weak, from the blocks and from what earlier
/// statements recorded. A weak definition never resolves in place: the link
/// may bind a different one, so every reference keeps its relocation,
/// relaxable branch included.
pub(crate) fn asm_weak_only_names<'a>(
    blocks: &'a [AsmSectionBlock],
    sink: &AsmSectionSink,
) -> AsmBindingNames<'a> {
    AsmBindingNames {
        stmt: stmt_binding_names(blocks, false),
        counts: sink.bind_counts(true),
    }
}

/// A binding test over the statement's own directives and the counts the
/// sink keeps for what earlier statements bound.
pub(crate) struct AsmBindingNames<'a> {
    stmt: alloc::collections::BTreeSet<&'a str>,
    counts: AsmBindCounts,
}

impl AsmBindingNames<'_> {
    pub(crate) fn contains(&self, name: &str) -> bool {
        self.stmt.contains(name) || self.counts.contains_key(name)
    }
}

/// The names a statement's own `.weak` -- and, with `global`, `.globl` --
/// directives bind.
fn stmt_binding_names(
    blocks: &[AsmSectionBlock],
    global: bool,
) -> alloc::collections::BTreeSet<&str> {
    blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::Weak(n) => Some(n.as_str()),
            AsmSectionItem::Global(n) if global => Some(n.as_str()),
            _ => None,
        })
        .collect()
}

/// Names the unit binds global or weak, from the blocks and from what
/// earlier statements recorded (a `.globl` / `.weak` may follow the
/// reference). A reference to one keeps its relocation so the link binds
/// the winning definition; only a local name resolves in place, as GNU
/// as resolves it.
fn asm_non_local_names<'a>(
    blocks: &'a [AsmSectionBlock],
    sink: &AsmSectionSink,
) -> AsmBindingNames<'a> {
    AsmBindingNames {
        stmt: stmt_binding_names(blocks, true),
        counts: sink.bind_counts(false),
    }
}

/// Measure with the branch forms `long` fixes, running the second round a
/// label-valued fill count needs. `sites` collects the relaxable branches
/// the settled round placed.
fn measure_fill_rounds(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    align_is_p2: bool,
    sink: &AsmSectionSink,
    long: &AsmRelaxSet,
    sites: &mut alloc::vec::Vec<AsmRelaxSite>,
) -> Result<SectionLabelOffsets, alloc::string::String> {
    match measure_round(blocks, const_of, align_is_p2, sink, None, long, sites) {
        (Ok(m), false) => Ok(m),
        // A fill count referenced a label: re-measure with the offsets the
        // first round produced. The referenced labels must not sit after an
        // unresolved fill of their own section, so one extra round settles
        // the layout or nothing does.
        (first, true) => {
            let prev = first.unwrap_or_default();
            sites.clear();
            match measure_round(
                blocks,
                const_of,
                align_is_p2,
                sink,
                Some(&prev),
                long,
                sites,
            ) {
                (Ok(m), false) => Ok(m),
                (Err(e), _) => Err(e),
                _ => Err(alloc::string::String::from(
                    "inline asm: fill count does not settle against the section layout",
                )),
            }
        }
        (Err(e), _) => Err(e),
    }
}

/// One measurement round. `prev` supplies label offsets for fill counts;
/// the second return reports whether a fill count needed a label the round
/// could not resolve (round one measures it as zero length).
#[allow(clippy::too_many_arguments)]
fn measure_round(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    align_is_p2: bool,
    sink: &AsmSectionSink,
    prev: Option<&SectionLabelOffsets>,
    long: &AsmRelaxSet,
    sites: &mut alloc::vec::Vec<AsmRelaxSite>,
) -> (Result<SectionLabelOffsets, alloc::string::String>, bool) {
    let mut unresolved_fill = false;
    let r = measure_round_inner(
        blocks,
        const_of,
        align_is_p2,
        sink,
        prev,
        &mut unresolved_fill,
        long,
        sites,
    );
    (r, unresolved_fill)
}

#[allow(clippy::too_many_arguments)]
fn measure_round_inner(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    align_is_p2: bool,
    sink: &AsmSectionSink,
    prev: Option<&SectionLabelOffsets>,
    unresolved_fill: &mut bool,
    long: &AsmRelaxSet,
    sites: &mut alloc::vec::Vec<AsmRelaxSite>,
) -> Result<SectionLabelOffsets, alloc::string::String> {
    let mut map: alloc::collections::BTreeMap<alloc::string::String, (alloc::string::String, i64)> =
        alloc::collections::BTreeMap::new();
    let mut lens: alloc::collections::BTreeMap<alloc::string::String, i64> =
        alloc::collections::BTreeMap::new();
    // `.set` assignments in source order with the offset each was written at;
    // evaluated below, once every label offset is known, so a value may name a
    // label defined later in the section.
    let mut sets: alloc::vec::Vec<(
        alloc::string::String,
        alloc::string::String,
        alloc::string::String,
        i64,
    )> = alloc::vec::Vec::new();
    // `.set name, symbol` aliases: an expression over one reads the target's
    // location, as GNU as resolves the chain.
    let mut aliases: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    let mut places: alloc::collections::BTreeMap<(usize, usize), i64> =
        alloc::collections::BTreeMap::new();
    let mut aligns: alloc::collections::BTreeMap<(usize, usize), u32> =
        alloc::collections::BTreeMap::new();
    // The mapping state each section was left in, so the instruction padding
    // measured here matches what the materializer lays down.
    let mut states: alloc::collections::BTreeMap<alloc::string::String, Option<MapClass>> =
        alloc::collections::BTreeMap::new();
    for &bi in &subsection_order(blocks) {
        let b = &blocks[bi];
        let key = section_key(b);
        let exec = b.flags.contains('x');
        // A section already holding bytes in the sink continues at its
        // current length, so measured offsets, alignment gaps, and the
        // location counter agree with the materialized layout.
        let mut at = *lens.entry(key.clone()).or_insert_with(|| {
            sink.index_of(b)
                .map_or(0, |i| sink.section(i).bytes.len() as i64)
        });
        let mut state = *states
            .entry(key.clone())
            .or_insert_with(|| sink.index_of(b).and_then(|i| sink.section(i).map_state));
        for (ii, item) in b.items.iter().enumerate() {
            if matches!(item, AsmSectionItem::CodeBytes { .. }) {
                at += insn_align_gap(at, state, exec, align_is_p2);
            }
            places.insert((bi, ii), at);
            // An alignment operand over labels reads the offsets this round
            // has already recorded, so every later reader of the item sees
            // one byte count. A first round measures an unresolved fill count
            // as zero length, which moves the offsets an operand reads, so it
            // defers a failure to the round that has them; the second round
            // reports it.
            let resolved = match resolve_align_item(item, &|t| {
                if t.bytes().all(|c| c.is_ascii_digit()) {
                    return None;
                }
                map.get(numeric_label_digits(t).unwrap_or(t))
                    .map(|(_, off)| *off)
            }) {
                Ok(r) => r,
                Err(e) if prev.is_some() => return Err(e),
                Err(_) => {
                    *unresolved_fill = true;
                    Some(AsmSectionItem::Align {
                        spec: AlignSpec::Bytes(1),
                        fill: None,
                        max: None,
                        nops: AlignNops::default(),
                    })
                }
            };
            if let Some(AsmSectionItem::Align {
                spec: AlignSpec::Bytes(n),
                ..
            }) = resolved
            {
                aligns.insert((bi, ii), n);
            }
            let item = resolved.as_ref().unwrap_or(item);
            match item {
                AsmSectionItem::Label(name) => {
                    let digits = numeric_label_digits(name).unwrap_or(name);
                    map.insert(alloc::string::String::from(digits), (key.clone(), at));
                }
                // Symbol attributes, not layout: no bytes.
                AsmSectionItem::Global(_)
                | AsmSectionItem::Type { .. }
                | AsmSectionItem::Size { .. }
                | AsmSectionItem::Weak(_)
                | AsmSectionItem::Local(_)
                | AsmSectionItem::Visibility { .. }
                | AsmSectionItem::CondDiag(_)
                | AsmSectionItem::Cfi(_)
                | AsmSectionItem::File(_)
                | AsmSectionItem::Ident(_)
                | AsmSectionItem::Reloc { .. } => {}
                AsmSectionItem::SymSet { name, target } => {
                    aliases.insert(name.clone(), target.clone());
                }
                AsmSectionItem::SetExpr { name, expr } => {
                    sets.push((name.clone(), expr.clone(), key.clone(), at));
                }
                // An absolute value, so its reads resolve like any other
                // assignment without depending on the layout.
                AsmSectionItem::AbsSet { name, value } => {
                    sets.push((name.clone(), alloc::format!("{value}"), key.clone(), at));
                }
                AsmSectionItem::LiteralPool(entries) => {
                    let (offs, end) = literal_pool_layout(entries, at);
                    for (e, off) in entries.iter().zip(&offs) {
                        map.insert(e.label.clone(), (key.clone(), *off));
                    }
                    at = end;
                }
                AsmSectionItem::Data { width, values } => {
                    at += *width as i64 * values.len() as i64;
                }
                AsmSectionItem::Fill { count, unit, .. } => {
                    // The count may reference labels (`744f - 743f`); resolve
                    // them from this round's map, the prior round's, or fail
                    // the round so a second one runs with full offsets.
                    let resolve = |t: &str| -> Option<i64> {
                        if t.bytes().all(|c| c.is_ascii_digit()) {
                            return None;
                        }
                        map.get(numeric_label_digits(t).unwrap_or(t))
                            .map(|(_, off)| *off)
                            .or_else(|| prev.and_then(|p| p.offset(t)))
                            .or_else(|| prev.and_then(|p| p.symbol(t)))
                    };
                    let n = match eval_fill_count_with(count, at, const_of, &resolve) {
                        Some(n) => n,
                        None => {
                            *unresolved_fill = true;
                            if prev.is_some() {
                                return Err(alloc::format!(
                                    "inline asm: fill count `{count}` is not a constant expression"
                                ));
                            }
                            0
                        }
                    };
                    at += n.max(0) * *unit as i64;
                }
                AsmSectionItem::Bytes(bs) => at += bs.len() as i64,
                AsmSectionItem::CodeBytes { bytes, short, .. } => {
                    at += match short {
                        None => bytes.len() as i64,
                        Some(s) => {
                            sites.push(AsmRelaxSite { site: (bi, ii), at });
                            if long.contains(&(bi, ii)) {
                                bytes.len() as i64
                            } else {
                                s.bytes.len() as i64
                            }
                        }
                    };
                }
                AsmSectionItem::Code(text) => {
                    return Err(alloc::format!(
                        "inline asm: replacement instruction `{text}` in a named section is not \
                         assembled for this target"
                    ));
                }
                AsmSectionItem::Align { spec, max, .. } => {
                    at += align_gap(at, spec.bytes(&|_| None)? as i64, *max);
                }
                AsmSectionItem::Org(n, _) => at = at.max(*n as i64),
                AsmSectionItem::OrgLabel { label, addend, .. } => {
                    let digits = numeric_label_digits(label).unwrap_or(label);
                    let base = map
                        .get(digits)
                        .filter(|(sk, _)| *sk == key)
                        .map(|(_, o)| *o)
                        .ok_or_else(|| {
                            alloc::format!(
                                "inline asm: `.org` label `{label}` is not defined above"
                            )
                        })?;
                    let add = eval_const_expr_ops(addend, &|i| const_of(i)).ok_or_else(|| {
                        alloc::string::String::from("inline asm: non-constant `.org` addend")
                    })?;
                    at = (base + add).max(at);
                }
                AsmSectionItem::OrgExpr(expr, _) => {
                    // A target referencing labels of a later subsection (the
                    // alternatives length equalizer) resolves in round two,
                    // like a fill count.
                    let resolve = |t: &str| -> Option<AsmExprLeaf> {
                        let loc = |k: &str, off: i64| {
                            AsmExprLeaf::Loc(AsmExprTerm {
                                space: Some((
                                    AsmSpace::Section(alloc::string::String::from(k)),
                                    off,
                                )),
                                target: AsmSectionTarget::Symbol(alloc::string::String::from(t)),
                            })
                        };
                        map.get(numeric_label_digits(t).unwrap_or(t))
                            .map(|(k, off)| loc(k, *off))
                            .or_else(|| {
                                let p = prev?;
                                Some(loc(p.section(t)?, p.offset(t)?))
                            })
                            .or_else(|| prev.and_then(|p| p.symbol(t).map(AsmExprLeaf::Abs)))
                    };
                    match eval_org_target(expr, &key, at, &resolve, const_of) {
                        Ok(target) => at = target.max(at),
                        Err(e) => {
                            *unresolved_fill = true;
                            if prev.is_some() {
                                return Err(e);
                            }
                        }
                    }
                }
                AsmSectionItem::Rept { count, items } => {
                    let resolve = |t: &str| -> Option<i64> {
                        if t.bytes().all(|c| c.is_ascii_digit()) {
                            return None;
                        }
                        map.get(numeric_label_digits(t).unwrap_or(t))
                            .map(|(_, off)| *off)
                            .or_else(|| prev.and_then(|p| p.offset(t)))
                            .or_else(|| prev.and_then(|p| p.symbol(t)))
                    };
                    let n = match eval_fill_count_with(count, at, const_of, &resolve) {
                        Some(n) => n,
                        None => {
                            *unresolved_fill = true;
                            if prev.is_some() {
                                return Err(alloc::format!(
                                    "inline asm: `.rept` count `{count}` is not constant"
                                ));
                            }
                            0
                        }
                    };
                    // Padding before an instruction depends on the offset the
                    // iteration starts at, so the body is measured per
                    // repetition where it can pad at all.
                    if items
                        .iter()
                        .any(|it| matches!(it, AsmSectionItem::CodeBytes { .. }))
                        && align_is_p2
                        && exec
                    {
                        for _ in 0..n.max(0) {
                            for it in items {
                                if matches!(it, AsmSectionItem::CodeBytes { .. }) {
                                    at += insn_align_gap(at, state, exec, align_is_p2);
                                }
                                at += rept_item_len(it, const_of)?;
                                state = step_map_state(it, state, exec);
                            }
                        }
                    } else {
                        let mut unit_len = 0i64;
                        for it in items {
                            unit_len += rept_item_len(it, const_of)?;
                        }
                        at += n.max(0) * unit_len;
                        if n > 0 {
                            state = step_map_state(item, state, exec);
                        }
                    }
                }
            }
            if !matches!(item, AsmSectionItem::Rept { .. }) {
                state = step_map_state(item, state, exec);
            }
        }
        lens.insert(key.clone(), at);
        states.insert(key, state);
    }
    let sections = SectionNames { blocks, sink };
    let block_sections: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String> =
        blocks
            .iter()
            .map(|b| (b.name.clone(), section_key(b)))
            .collect();
    let mut syms: alloc::collections::BTreeMap<alloc::string::String, i64> =
        alloc::collections::BTreeMap::new();
    // An assignment this round cannot value is deferred while a fill count
    // still needs a second round: aborting here would discard the label
    // offsets that round measures from. It is reported once the layout has
    // settled, or straight away when nothing is pending.
    let mut set_err = None;
    for (name, expr, key, at) in &sets {
        match eval_section_set_expr(
            name, expr, key, *at, &map, &syms, &aliases, &sections, const_of,
        ) {
            // The maps are read by every later expression, so a reassigned
            // name keeps only its last value's kind.
            Ok(SectionSetValue::Abs(v)) => {
                syms.insert(name.clone(), v);
                map.remove(name);
            }
            Ok(SectionSetValue::Loc(sk, off)) => {
                map.insert(name.clone(), (sk, off));
                syms.remove(name);
            }
            // Placed by the object writer against the target's definition,
            // so the layout records no value for it.
            Ok(SectionSetValue::Alias) => {
                map.remove(name);
                syms.remove(name);
            }
            Err(e) => set_err = set_err.or(Some(e)),
        }
    }
    if let Some(e) = set_err
        && (prev.is_some() || !*unresolved_fill)
    {
        return Err(e);
    }
    Ok(SectionLabelOffsets {
        map,
        syms,
        long: AsmRelaxSet::new(),
        sections: block_sections,
        places,
        aligns,
        aliases,
    })
}

/// A label defined by one `materialize_asm_sections` call, reported so a
/// main-stream reference to it (`jmp 6f` where `6:` sits in a pushed section)
/// binds across the section boundary. `name` is the source label name before
/// the per-instance rename; `section_index` and `offset` locate the definition
/// in the sink.
#[derive(Debug, Clone)]
pub(crate) struct MaterializedLabel {
    pub name: alloc::string::String,
    pub section_index: usize,
    pub offset: u32,
}

/// Materialize the parsed section blocks: resolve operand constants and
/// label references, lay out the bytes, and merge into the sink by
/// `(name, flags, sh_type)`. `const_of` yields an `i`-class operand's
/// constant; `label_off` resolves a template-label name to its location --
/// an emitted-stream text offset or a deferred replacement region
/// ([`LabelLoc`]); `None` means the name is a symbol. `operand_sym` yields
/// the relocation target of an `i`-class operand that names a link-time
/// address (`.long %c0 - .`) rather than a constant; `goto_block` yields
/// the block index of an `asm goto` label (`.long %l0 - .`). Returns the
/// labels defined this call so a main-stream reference resolves against a
/// definition placed in a section.
pub(crate) fn materialize_asm_sections(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    label_off: &dyn Fn(&str) -> Option<LabelLoc>,
    operand_sym: &dyn Fn(u8) -> Option<(AsmSectionTarget, i64)>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
    align_is_p2: bool,
    sink: &mut AsmSectionSink,
) -> Result<alloc::vec::Vec<MaterializedLabel>, alloc::string::String> {
    // GNU as numeric labels (`2:`, `14470:`) are local to one asm instance;
    // the same digits recur across every expansion of a macro like the bug
    // table, so the accumulating sink would collide them. Rename each
    // definition to a per-instance-unique symbol. Built once for the whole
    // call so a reference in one block resolves a definition in another (the
    // bug table's `.long 14472b - .` reaches a label defined in `.rodata.str`).
    let uniq = next_asm_instance();
    let mut num_unique: alloc::collections::BTreeMap<&str, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    for name in blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::Label(n) if is_numeric_label(n) => Some(n.as_str()),
            _ => None,
        })
    {
        if num_unique
            .insert(name, alloc::format!(".Lc5_asmsec_{uniq}_{name}"))
            .is_some()
        {
            return Err(alloc::format!(
                "inline asm: numeric label `{name}` defined twice in one asm instance"
            ));
        }
    }
    // Offsets of every section label, so a difference to a label defined in a
    // later block (the replacement length `775f - 774f`, whose field sits in
    // the earlier `.altinstructions`) folds to a constant. Seeded with the
    // sink lengths so the offsets are the materialized ones.
    let measured = measure_asm_section_offsets(blocks, const_of, align_is_p2, sink)?;
    let mut defined: alloc::vec::Vec<MaterializedLabel> = alloc::vec::Vec::new();
    // A same-section reference to a global or weak name keeps its
    // relocation, except on a relaxable branch, which resolves against any
    // name the link cannot rebind. The relaxation above uses the same two
    // sets, so a long form is in place wherever a relocation survives.
    let non_local = asm_non_local_names(blocks, sink);
    let weak_only = asm_weak_only_names(blocks, sink);
    let mut weak_names: alloc::vec::Vec<alloc::string::String> = alloc::vec::Vec::new();
    // `.globl` is a unit-level declaration in GNU as: the name it binds
    // external may be defined in any section of the unit, before or after.
    let mut global_names: alloc::vec::Vec<alloc::string::String> = alloc::vec::Vec::new();
    // Sections this call merges into, with the label count each had on
    // first touch. Pending entries never outlive a call, so this is also
    // the exact set the settle pass below has to inspect.
    let mut touched: alloc::vec::Vec<(usize, usize)> = alloc::vec::Vec::new();
    for &bi in &subsection_order(blocks) {
        let b = &blocks[bi];
        let sec_idx = sink.get_or_insert(b);
        // Labels earlier statements defined, resolvable by this call's
        // location expressions (`.size f, . - f` with `f:` in a prior
        // template). Borrowed apart from the section being laid out.
        let AsmSectionSink {
            sections,
            labels,
            by_name,
            cfi: sink_cfi,
            published,
            non_local: sink_non_local,
            weak: sink_weak,
            ..
        } = &mut *sink;
        let sink_labels = &AsmSinkNames {
            labels,
            sections: by_name,
        };
        if !touched.iter().any(|&(i, _)| i == sec_idx) {
            touched.push((sec_idx, sections.at(sec_idx).labels.len()));
        }
        // Labels of earlier calls, which a rebinding here has to move in
        // the sink's binding counts; this call's are counted when the call
        // publishes them.
        let counted = published[sec_idx];
        let block_key = section_key(b);
        let sec = sections.at_mut(sec_idx);
        for (ii, item) in b.items.iter().enumerate() {
            // An expression-valued alignment takes the byte count the measure
            // pass settled where the directive stands, so the gap laid down
            // here is the gap the offsets were measured under.
            let resolved;
            let item = match item {
                AsmSectionItem::Align {
                    spec: AlignSpec::Expr { text, .. },
                    fill,
                    max,
                    nops,
                } => {
                    let n = measured.align_of((bi, ii)).ok_or_else(|| {
                        alloc::format!("inline asm: alignment `{text}` was not measured")
                    })?;
                    resolved = AsmSectionItem::Align {
                        spec: AlignSpec::Bytes(n),
                        fill: *fill,
                        max: *max,
                        nops: *nops,
                    };
                    &resolved
                }
                other => other,
            };
            if matches!(item, AsmSectionItem::CodeBytes { .. }) {
                let pad = insn_align_gap(
                    sec.bytes.len() as i64,
                    sec.map_state,
                    b.flags.contains('x'),
                    align_is_p2,
                ) as usize;
                if pad > 0 {
                    sec.map.content(sec.bytes.len(), pad, MapClass::Data);
                    sec.bytes.resize(sec.bytes.len() + pad, 0);
                }
            }
            let map_at = sec.bytes.len();
            match item {
                // An alignment of one moves nothing, and GNU as builds no
                // frag for it: no padding, no section alignment, no run.
                AsmSectionItem::Align {
                    spec: AlignSpec::Bytes(n),
                    ..
                } if *n <= 1 => {}
                AsmSectionItem::Align {
                    spec,
                    fill,
                    max,
                    nops,
                } => {
                    let n = spec.bytes(&|_| None)?;
                    let gap = align_gap(sec.bytes.len() as i64, n as i64, None) as usize;
                    // GNU as records the requested alignment on the section
                    // even where a max skip drops the padding.
                    sec.align = sec.align.max(n);
                    let exec = b.flags.contains('x');
                    if max.is_none_or(|m| gap <= m as usize) {
                        let (lead, class) = push_align_fill(
                            &mut sec.bytes,
                            gap,
                            *fill,
                            exec,
                            *nops,
                            sec.after_insn,
                        )?;
                        if lead > 0 {
                            sec.map.align(map_at, MapClass::Data);
                        }
                        sec.map.align(map_at + lead, class);
                    }
                }
                AsmSectionItem::OrgLabel {
                    label,
                    addend,
                    fill,
                } => {
                    // Resolve the label's offset within this section (defined
                    // above), then pad to that plus the constant addend.
                    let lname = numeric_label_digits(label)
                        .and_then(|d| num_unique.get(d).map(alloc::string::String::as_str))
                        .unwrap_or(label);
                    let base = sec
                        .labels
                        .iter()
                        .find(|l| l.name == lname && l.offset != PENDING_LABEL)
                        .map(|l| l.offset)
                        .ok_or_else(|| {
                            alloc::format!(
                                "inline asm: `.org` label `{label}` is not defined above"
                            )
                        })?;
                    let add =
                        eval_const_expr_ops(addend, &|idx| const_of(idx)).ok_or_else(|| {
                            alloc::string::String::from("inline asm: non-constant `.org` addend")
                        })?;
                    let target = base as i64 + add;
                    if target < sec.bytes.len() as i64 {
                        return Err(alloc::string::String::from(
                            "inline asm: `.org` moves backwards",
                        ));
                    }
                    sec.bytes.resize(target as usize, *fill);
                }
                AsmSectionItem::Org(n, fill) => {
                    if (*n as usize) < sec.bytes.len() {
                        return Err(alloc::string::String::from(
                            "inline asm: `.org` moves backwards",
                        ));
                    }
                    sec.bytes.resize(*n as usize, *fill);
                }
                AsmSectionItem::OrgExpr(expr, fill) => {
                    let key = section_key(b);
                    let here = sec.bytes.len() as i64;
                    let resolve = |t: &str| {
                        section_expr_leaf(
                            t,
                            &key,
                            here,
                            &measured,
                            sink_labels,
                            &num_unique,
                            label_off,
                        )
                    };
                    let target = eval_org_target(expr, &key, here, &resolve, const_of)?;
                    if target < here {
                        return Err(alloc::string::String::from(
                            "inline asm: `.org` moves backwards",
                        ));
                    }
                    sec.bytes.resize(target as usize, *fill);
                }
                AsmSectionItem::Rept { count, items } => {
                    let n = eval_fill_count_with(count, sec.bytes.len() as i64, const_of, &|t| {
                        if t.bytes().all(|c| c.is_ascii_digit()) {
                            return None;
                        }
                        measured.offset(t).or_else(|| measured.symbol(t))
                    })
                    .ok_or_else(|| {
                        alloc::format!("inline asm: `.rept` count `{count}` is not constant")
                    })?;
                    for _ in 0..n.max(0) {
                        for it in items {
                            if matches!(it, AsmSectionItem::CodeBytes { .. }) {
                                let pad = insn_align_gap(
                                    sec.bytes.len() as i64,
                                    sec.map_state,
                                    b.flags.contains('x'),
                                    align_is_p2,
                                ) as usize;
                                if pad > 0 {
                                    sec.map.content(sec.bytes.len(), pad, MapClass::Data);
                                    sec.bytes.resize(sec.bytes.len() + pad, 0);
                                }
                            }
                            let rept_at = sec.bytes.len();
                            match it {
                                AsmSectionItem::Bytes(bs) => sec.bytes.extend_from_slice(bs),
                                AsmSectionItem::CodeBytes { bytes, relocs, .. }
                                    if relocs.is_empty() =>
                                {
                                    sec.bytes.extend_from_slice(bytes);
                                }
                                AsmSectionItem::Data { width, values } => {
                                    for v in values {
                                        let AsmSectionValue::Const(c) = v else {
                                            return Err(alloc::string::String::from(
                                                "inline asm: unsupported item inside `.rept`",
                                            ));
                                        };
                                        push_le(&mut sec.bytes, *c, *width as usize);
                                    }
                                }
                                AsmSectionItem::Fill { count, unit, value } => {
                                    let n = eval_fill_count(count, const_of)?;
                                    push_fill(&mut sec.bytes, n, *unit, *value);
                                }
                                _ => {
                                    return Err(alloc::string::String::from(
                                        "inline asm: unsupported item inside `.rept`",
                                    ));
                                }
                            }
                            let laid = sec.bytes.len() - rept_at;
                            sec.map.content(
                                rept_at,
                                laid,
                                match it {
                                    AsmSectionItem::CodeBytes { .. } => MapClass::Code,
                                    _ => MapClass::Data,
                                },
                            );
                            sec.map_state =
                                step_map_state(it, sec.map_state, b.flags.contains('x'));
                        }
                    }
                }
                AsmSectionItem::Bytes(bs) => sec.bytes.extend_from_slice(bs),
                AsmSectionItem::Fill { count, unit, value } => {
                    // The count may reference section labels; the measured
                    // offsets are final here.
                    let n = eval_fill_count_with(count, sec.bytes.len() as i64, const_of, &|t| {
                        if t.bytes().all(|c| c.is_ascii_digit()) {
                            return None;
                        }
                        measured.offset(t).or_else(|| measured.symbol(t))
                    })
                    .ok_or_else(|| {
                        alloc::format!(
                            "inline asm: fill count `{count}` is not a constant expression"
                        )
                    })?;
                    push_fill(&mut sec.bytes, n.max(0), *unit, *value);
                }
                AsmSectionItem::Label(name) => {
                    // A numeric label carries its per-instance-unique symbol.
                    let orig = name.clone();
                    let name = num_unique
                        .get(name.as_str())
                        .map(alloc::string::String::as_str)
                        .unwrap_or(name);
                    let at = sec.bytes.len() as u32;
                    // Only this call's entries can be pending; a definition
                    // an earlier call made in this section is a duplicate,
                    // which the label index answers without a walk.
                    match sec.labels[counted..].iter_mut().find(|l| l.name == *name) {
                        // A pending `.globl` entry is the definition site.
                        Some(l) if l.offset == PENDING_LABEL => l.offset = at,
                        Some(_) => {
                            return Err(alloc::format!(
                                "inline asm: duplicate label `{name}` in a named section"
                            ));
                        }
                        None if sink_labels
                            .label(name)
                            .is_some_and(|(k, _)| *k == block_key) =>
                        {
                            return Err(alloc::format!(
                                "inline asm: duplicate label `{name}` in a named section"
                            ));
                        }
                        None => sec.labels.push(AsmSectionLabel {
                            name: alloc::string::String::from(name),
                            offset: at,
                            global: false,
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: None,
                            absolute: None,
                        }),
                    }
                    defined.push(MaterializedLabel {
                        name: orig,
                        section_index: sec_idx,
                        offset: at,
                    });
                }
                AsmSectionItem::CondDiag(arms) => {
                    let key = section_key(b);
                    let here = sec.bytes.len() as i64;
                    let resolve = |t: &str| {
                        section_expr_leaf(
                            t,
                            &key,
                            here,
                            &measured,
                            sink_labels,
                            &num_unique,
                            label_off,
                        )
                    };
                    for arm in arms {
                        let taken = if arm.tok.is_empty() {
                            true
                        } else {
                            let ctx = AsmExprCtx {
                                resolve: &resolve,
                                const_of,
                                lax_div: false,
                            };
                            let v = eval_asm_value(&arm.cond, &ctx)
                                .ok()
                                .and_then(|v| v.to_abs())
                                .ok_or_else(|| {
                                    alloc::format!(
                                        "inline asm: non-constant `{}` condition `{}`",
                                        arm.tok,
                                        arm.cond
                                    )
                                })?;
                            gas_if_relation(&arm.tok, v)?
                        };
                        if taken {
                            if let Some(msg) = &arm.error {
                                return Err(alloc::format!("inline asm: `.error` {msg}"));
                            }
                            break;
                        }
                    }
                }
                AsmSectionItem::LiteralPool(entries) => {
                    let (offs, end) = literal_pool_layout(entries, sec.bytes.len() as i64);
                    sec.bytes.resize(end as usize, 0);
                    for (e, &off) in entries.iter().zip(&offs) {
                        sec.align = sec.align.max(e.size as u32);
                        sec.labels.push(AsmSectionLabel {
                            name: e.label.clone(),
                            offset: off as u32,
                            global: false,
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: None,
                            absolute: None,
                        });
                        match &e.value {
                            AsmPoolValue::Const(v) => {
                                let at = off as usize;
                                let n = e.size as usize;
                                sec.bytes[at..at + n].copy_from_slice(&v.to_le_bytes()[..n]);
                            }
                            AsmPoolValue::Sym { name, addend } => {
                                sec.relocs.push(AsmSectionReloc {
                                    offset: off as u32,
                                    width: e.size,
                                    kind: AsmRelocKind::Data,
                                    pcrel: false,
                                    branch: false,
                                    signed: false,
                                    target: AsmSectionTarget::Symbol(name.clone()),
                                    addend: *addend,
                                })
                            }
                        }
                    }
                    sec.after_insn = false;
                }
                // `.weak` binding applies to whatever definition the name has
                // (a section label here, or a symbol defined elsewhere in the
                // unit); resolved against the sink once all blocks are laid
                // out. `.set name, sym` is a unit-level alias; the file-scope
                // parse records both, the operand emit paths reject them.
                AsmSectionItem::Weak(name) => weak_names.push(name.clone()),
                // Visibility is carried by name to the object writer, which
                // sets `st_other` wherever the symbol is emitted.
                AsmSectionItem::Visibility { .. } => {}
                // Unit-level records: the file-scope parse collects them.
                AsmSectionItem::File(_) | AsmSectionItem::Ident(_) => {}
                // The rule takes effect at the location counter the directive
                // was written at, which is this section's current length.
                AsmSectionItem::Cfi(op) => sink_cfi.push(cfi::CfiRecord {
                    key: section_key(b),
                    offset: sec.bytes.len() as u32,
                    op: op.clone(),
                }),
                // `.reloc`: the offset is section-relative and independent of
                // the location counter, and no field is deposited.
                AsmSectionItem::Reloc {
                    offset,
                    rtype,
                    target,
                    addend,
                } => sec.relocs.push(AsmSectionReloc {
                    offset: *offset,
                    width: 0,
                    kind: AsmRelocKind::Explicit(*rtype),
                    pcrel: false,
                    branch: false,
                    signed: false,
                    target: if target.is_empty() {
                        AsmSectionTarget::OwnSection(0)
                    } else {
                        AsmSectionTarget::Symbol(target.clone())
                    },
                    addend: *addend,
                }),
                // `.set name, sym` is a unit-level alias; a `.set` over
                // section-local locations was valued during measurement.
                AsmSectionItem::SymSet { .. } => {}
                AsmSectionItem::SetExpr { .. } => {}
                // `.set name, <constant>` defines an absolute symbol, as in
                // GNU as. A later assignment to the same name wins.
                AsmSectionItem::AbsSet { name, value } => {
                    match sec.labels.iter_mut().find(|l| l.name == *name) {
                        Some(l) => {
                            l.offset = 0;
                            l.absolute = Some(*value);
                        }
                        None => sec.labels.push(AsmSectionLabel {
                            name: name.clone(),
                            absolute: Some(*value),
                            ..Default::default()
                        }),
                    }
                }
                // A section label is local unless `.globl` marked it; record a
                // pending entry so the definition below keeps that binding.
                AsmSectionItem::Local(name) => {
                    match sec
                        .labels
                        .iter_mut()
                        .enumerate()
                        .find(|(_, l)| l.name == *name)
                    {
                        Some((i, l)) => {
                            rebind_label(l, i < counted, sink_non_local, sink_weak, |l| {
                                l.global = false
                            })
                        }
                        None => sec.labels.push(AsmSectionLabel {
                            name: name.clone(),
                            offset: PENDING_LABEL,
                            global: false,
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: None,
                            absolute: None,
                        }),
                    }
                }
                AsmSectionItem::Global(name) => {
                    global_names.push(name.clone());
                    match sec
                        .labels
                        .iter_mut()
                        .enumerate()
                        .find(|(_, l)| l.name == *name)
                    {
                        // `.globl` may precede its label; record the pending name
                        // as a zero-length forward entry the definition fills in.
                        Some((i, l)) => {
                            rebind_label(l, i < counted, sink_non_local, sink_weak, |l| {
                                l.global = true
                            })
                        }
                        None => sec.labels.push(AsmSectionLabel {
                            name: name.clone(),
                            offset: PENDING_LABEL,
                            global: true,
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: None,
                            absolute: None,
                        }),
                    }
                }
                AsmSectionItem::Type { name, sym_type } => {
                    let lname = numeric_label_digits(name)
                        .and_then(|d| num_unique.get(d).map(alloc::string::String::as_str))
                        .unwrap_or(name);
                    match sec.labels.iter_mut().find(|l| l.name == *lname) {
                        // `.type` may precede its label (as `.globl` may): record
                        // it on a pending forward entry the definition fills in.
                        Some(l) => l.sym_type = *sym_type,
                        None => sec.labels.push(AsmSectionLabel {
                            name: alloc::string::String::from(lname),
                            offset: PENDING_LABEL,
                            global: false,
                            weak: false,
                            sym_type: *sym_type,
                            size: None,
                            absolute: None,
                        }),
                    }
                }
                AsmSectionItem::Size { name, expr } => {
                    // `.` is the offset at the directive; an identifier is a
                    // section label, a `.set` symbol, or an operand constant.
                    // The expression must fold to an absolute byte count.
                    let key = section_key(b);
                    let cur = sec.bytes.len() as i64;
                    let resolve = |t: &str| {
                        section_expr_leaf(
                            t,
                            &key,
                            cur,
                            &measured,
                            sink_labels,
                            &num_unique,
                            label_off,
                        )
                    };
                    let ctx = AsmExprCtx {
                        resolve: &resolve,
                        const_of,
                        lax_div: false,
                    };
                    let val = eval_asm_value(expr, &ctx)
                        .ok()
                        .and_then(|v| v.to_abs())
                        .ok_or_else(|| {
                            alloc::format!("inline asm: bad `.size` expression `{expr}`")
                        })?;
                    if val < 0 {
                        return Err(alloc::format!(
                            "inline asm: `.size` expression `{expr}` is negative"
                        ));
                    }
                    let tname = numeric_label_digits(name)
                        .and_then(|d| num_unique.get(d).map(alloc::string::String::as_str))
                        .unwrap_or(name);
                    // `.size` may precede its label, as `.globl` and `.type`
                    // may; carry the size on a pending entry until then.
                    match sec.labels.iter_mut().find(|l| l.name == *tname) {
                        Some(l) => l.size = Some(val as u64),
                        None => sec.labels.push(AsmSectionLabel {
                            name: alloc::string::String::from(tname),
                            offset: PENDING_LABEL,
                            global: false,
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: Some(val as u64),
                            absolute: None,
                        }),
                    }
                }
                AsmSectionItem::Data { width, values } => {
                    for v in values {
                        match v {
                            AsmSectionValue::Const(c) => {
                                push_le(&mut sec.bytes, *c, *width as usize)
                            }
                            AsmSectionValue::OperandConst(idx) => match const_of(*idx) {
                                Some(c) => sec.bytes.extend_from_slice(
                                    &(c as u64).to_le_bytes()[..*width as usize],
                                ),
                                // An `i`-class operand that is not an integer
                                // constant names a link-time address, as it
                                // does in the `%cN - .` form: the field takes
                                // an absolute relocation against it.
                                None => {
                                    let (target, add) = operand_sym(*idx).ok_or_else(|| {
                                        alloc::format!(
                                            "inline asm: section data value `%c{idx}` is neither \
                                             a constant nor a link-time address"
                                        )
                                    })?;
                                    if !matches!(width, 1 | 2 | 4 | 8) {
                                        return Err(alloc::string::String::from(
                                            "inline asm: section reference needs a 1-, 2-, 4-, or 8-byte field",
                                        ));
                                    }
                                    sec.relocs.push(AsmSectionReloc {
                                        offset: sec.bytes.len() as u32,
                                        width: *width,
                                        kind: AsmRelocKind::Data,
                                        pcrel: false,
                                        branch: false,
                                        signed: false,
                                        target,
                                        addend: add,
                                    });
                                    sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                                }
                            },
                            AsmSectionValue::Expr(text) => {
                                let text = subst_asm_idents(text, &|t| measured.symbol(t));
                                let c = eval_const_expr_ops(&text, &|idx| const_of(idx))
                                    .ok_or_else(|| {
                                        alloc::string::String::from(
                                            "inline asm: non-constant section data value",
                                        )
                                    })?;
                                push_le(&mut sec.bytes, c as i128, *width as usize);
                            }
                            AsmSectionValue::LocExpr(text) => {
                                let key = section_key(b);
                                let here = sec.bytes.len() as i64;
                                let resolve = |t: &str| {
                                    section_expr_leaf(
                                        t,
                                        &key,
                                        here,
                                        &measured,
                                        sink_labels,
                                        &num_unique,
                                        label_off,
                                    )
                                };
                                let ctx = AsmExprCtx {
                                    resolve: &resolve,
                                    const_of,
                                    lax_div: false,
                                };
                                let space = AsmSpace::Section(key.clone());
                                let v = eval_asm_value(text, &ctx)
                                    .and_then(|v| resolve_asm_value(v, Some((&space, here))))
                                    .map_err(|e| alloc::format!("inline asm: `{text}`: {e}"))?;
                                match v {
                                    AsmResolved::Abs(c) => {
                                        if !value_fits_width(c, *width) {
                                            return Err(alloc::format!(
                                                "inline asm: `{text}` = {c} does not fit a {width}-byte field"
                                            ));
                                        }
                                        push_le(&mut sec.bytes, c as i128, *width as usize);
                                    }
                                    AsmResolved::Reloc {
                                        target,
                                        addend,
                                        pcrel,
                                    } => {
                                        if !matches!(width, 1 | 2 | 4 | 8) {
                                            return Err(alloc::string::String::from(
                                                "inline asm: section reference needs a 1-, 2-, 4-, or 8-byte field",
                                            ));
                                        }
                                        sec.relocs.push(AsmSectionReloc {
                                            offset: sec.bytes.len() as u32,
                                            width: *width,
                                            kind: AsmRelocKind::Data,
                                            pcrel,
                                            branch: false,
                                            signed: false,
                                            target,
                                            addend,
                                        });
                                        sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                                    }
                                }
                            }
                            // A reference (`sym + 8`, `1b - .`) or a label
                            // difference (`775f - 774f`) evaluates under the
                            // location-value rules: a same-space result folds
                            // (gas folds `a - .` with `a` in this section), a
                            // symbolic one relocates.
                            AsmSectionValue::Ref { .. } | AsmSectionValue::LabelDiff { .. } => {
                                let key = section_key(b);
                                let here = sec.bytes.len() as i64;
                                let leaf = |n: &str| -> AsmExprValue {
                                    match section_expr_leaf(
                                        n,
                                        &key,
                                        here,
                                        &measured,
                                        sink_labels,
                                        &num_unique,
                                        label_off,
                                    ) {
                                        Some(AsmExprLeaf::Abs(c)) => AsmExprValue::abs(c),
                                        Some(AsmExprLeaf::Loc(t)) => AsmExprValue::from_term(t),
                                        None => AsmExprValue::from_term(AsmExprTerm {
                                            space: None,
                                            target: AsmSectionTarget::Symbol(
                                                alloc::string::String::from(n),
                                            ),
                                        }),
                                    }
                                };
                                let val = match v {
                                    AsmSectionValue::Ref {
                                        name,
                                        pcrel,
                                        addend,
                                    } => {
                                        let add = if addend.is_empty() {
                                            0
                                        } else {
                                            eval_const_expr_ops(addend, &|i| const_of(i))
                                                .ok_or_else(|| {
                                                    alloc::string::String::from(
                                                        "inline asm: non-constant section reloc addend",
                                                    )
                                                })?
                                        };
                                        let mut val = leaf(name)
                                            .combine(AsmExprValue::abs(add), false)
                                            .map_err(|e| alloc::format!("inline asm: {e}"))?;
                                        if *pcrel {
                                            val = val
                                                .combine(leaf("."), true)
                                                .map_err(|e| alloc::format!("inline asm: {e}"))?;
                                        }
                                        val
                                    }
                                    AsmSectionValue::LabelDiff {
                                        minuend,
                                        subtrahend,
                                    } => leaf(minuend)
                                        .combine(leaf(subtrahend), true)
                                        .map_err(|e| alloc::format!("inline asm: {e}"))?,
                                    _ => unreachable!("outer arm admits Ref and LabelDiff"),
                                };
                                let space = AsmSpace::Section(key.clone());
                                match resolve_asm_value(val, Some((&space, here)))
                                    .map_err(|e| alloc::format!("inline asm: {e}"))?
                                {
                                    AsmResolved::Abs(c) => {
                                        if !value_fits_width(c, *width) {
                                            return Err(alloc::format!(
                                                "inline asm: value {c} does not fit a {width}-byte field"
                                            ));
                                        }
                                        push_le(&mut sec.bytes, c as i128, *width as usize);
                                    }
                                    AsmResolved::Reloc {
                                        target,
                                        addend,
                                        pcrel,
                                    } => {
                                        if !matches!(width, 1 | 2 | 4 | 8) {
                                            return Err(alloc::string::String::from(
                                                "inline asm: section reference needs a 1-, 2-, 4-, or 8-byte field",
                                            ));
                                        }
                                        sec.relocs.push(AsmSectionReloc {
                                            offset: sec.bytes.len() as u32,
                                            width: *width,
                                            kind: AsmRelocKind::Data,
                                            pcrel,
                                            branch: false,
                                            signed: false,
                                            target,
                                            addend,
                                        });
                                        sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                                    }
                                }
                            }
                            AsmSectionValue::OperandReloc {
                                idx,
                                goto,
                                addend,
                                pcrel,
                            } => {
                                if !matches!(width, 1 | 2 | 4 | 8) {
                                    return Err(alloc::string::String::from(
                                        "inline asm: section reference needs a 1-, 2-, 4-, or 8-byte field",
                                    ));
                                }
                                let (target, base_add) = if *goto {
                                    let bid = goto_block(*idx).ok_or_else(|| {
                                        alloc::format!(
                                            "inline asm: `%l{idx}` names no `asm goto` label"
                                        )
                                    })?;
                                    (AsmSectionTarget::TextBlock(bid), 0)
                                } else {
                                    operand_sym(*idx).ok_or_else(|| {
                                        alloc::format!(
                                            "inline asm: operand `%c{idx}` does not name a link-time address"
                                        )
                                    })?
                                };
                                let add = base_add
                                    + if addend.is_empty() {
                                        0
                                    } else {
                                        eval_const_expr_ops(addend, &|i| const_of(i)).ok_or_else(
                                            || {
                                                alloc::string::String::from(
                                                    "inline asm: non-constant section reloc addend",
                                                )
                                            },
                                        )?
                                    };
                                sec.relocs.push(AsmSectionReloc {
                                    offset: sec.bytes.len() as u32,
                                    width: *width,
                                    kind: AsmRelocKind::Data,
                                    pcrel: *pcrel,
                                    branch: false,
                                    signed: false,
                                    target,
                                    addend: add,
                                });
                                sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                            }
                        }
                    }
                }
                AsmSectionItem::CodeBytes {
                    bytes,
                    relocs,
                    short,
                } => {
                    // A replacement instruction's relocs are at offsets within
                    // its own bytes; rebase each to the section offset the
                    // instruction lands at, then append the machine bytes. A
                    // PC-relative reference to a label of this section
                    // resolves here -- GNU as emits no relocation for it --
                    // by patching the instruction field; other targets keep
                    // their relocation (a numeric label's name rewritten to
                    // its per-instance symbol).
                    let base = sec.bytes.len() as u32;
                    let key = section_key(b);
                    // A relaxable branch takes the form the measurement
                    // settled on; anything else has one encoding.
                    let short = short.as_ref().filter(|_| !measured.long_form((bi, ii)));
                    let (bytes, relocs) = match short {
                        Some(s) => (&s.bytes, core::slice::from_ref(&s.reloc)),
                        None => (bytes, relocs.as_slice()),
                    };
                    let mut buf = bytes.clone();
                    for r in relocs {
                        let mut r = r.clone();
                        // An operand expression resolves against the layout
                        // here: what folds lands in the field, what keeps a
                        // symbol relocates against it.
                        // A relaxable branch binds any same-section name the
                        // link cannot rebind; every other field binds only a
                        // local one.
                        let rebindable = match r.kind {
                            AsmRelocKind::JumpRel => &weak_only,
                            _ => &non_local,
                        };
                        if let AsmSectionTarget::Expr(text) = &r.target {
                            let place = base as i64 + r.offset as i64;
                            // `.` in an operand is the instruction's own
                            // address, which is where this item starts.
                            let resolve = |t: &str| {
                                section_expr_leaf(
                                    t,
                                    &key,
                                    base as i64,
                                    &measured,
                                    sink_labels,
                                    &num_unique,
                                    label_off,
                                )
                            };
                            let ctx = AsmExprCtx {
                                resolve: &resolve,
                                const_of,
                                lax_div: false,
                            };
                            let space = AsmSpace::Section(key.clone());
                            match resolve_asm_field_expr(
                                text,
                                &ctx,
                                &space,
                                place,
                                r.addend,
                                r.pcrel || r.kind.self_relative(),
                                rebindable,
                            )? {
                                AsmFieldTarget::Abs(c) => {
                                    store_asm_insn_const(&mut buf, r.offset as usize, &r, c)
                                        .map_err(|e| alloc::format!("inline asm: `{text}`: {e}"))?;
                                    continue;
                                }
                                AsmFieldTarget::Reloc {
                                    target,
                                    addend,
                                    pcrel,
                                } => {
                                    r.target = target;
                                    r.addend = addend;
                                    // A data field's PC-relativity rides the
                                    // relocation; an instruction field's is
                                    // its kind's and stays as encoded.
                                    if let Some(p) = pcrel
                                        && matches!(
                                            r.kind,
                                            AsmRelocKind::Data | AsmRelocKind::JumpRel
                                        )
                                    {
                                        r.pcrel = p;
                                    }
                                }
                            }
                        }
                        let (leaf, local) = match &r.target {
                            // An instruction field resolves at the location
                            // its `.set` chain ends at, and binds as the name
                            // written does: an assignment gives the alias its
                            // own binding, and that is what decides whether
                            // the link may rebind the reference. A data
                            // directive's field keeps the name written.
                            AsmSectionTarget::Symbol(n) => (
                                section_expr_leaf(
                                    measured.alias_target(n.as_str()),
                                    &key,
                                    0,
                                    &measured,
                                    sink_labels,
                                    &num_unique,
                                    label_off,
                                ),
                                !rebindable.contains(n.as_str()),
                            ),
                            _ => (None, true),
                        };
                        match leaf {
                            Some(AsmExprLeaf::Loc(t)) => {
                                let same = matches!(
                                    &t.space,
                                    Some((AsmSpace::Section(k), _)) if *k == key
                                );
                                let off = match t.space {
                                    Some((_, off)) => off,
                                    None => 0,
                                };
                                let place = base as i64 + r.offset as i64;
                                if same
                                    && local
                                    && patch_asm_insn_field(
                                        &mut buf,
                                        r.offset as usize,
                                        r.kind,
                                        r.pcrel,
                                        r.width,
                                        off + r.addend - place,
                                    )?
                                {
                                    continue;
                                }
                                // The chain end replaces the name written
                                // where the link cannot rebind the reference,
                                // or where the end is a name the link binds
                                // too. Reducing a rebindable reference to a
                                // location pins it to this unit's definition.
                                let end_binds = matches!(
                                    &t.target,
                                    AsmSectionTarget::Symbol(e) if non_local.contains(e.as_str())
                                );
                                if local || end_binds {
                                    r.target = t.target;
                                }
                            }
                            Some(AsmExprLeaf::Abs(_)) => {
                                return Err(alloc::string::String::from(
                                    "inline asm: instruction relocates against an absolute symbol",
                                ));
                            }
                            None => {}
                        }
                        // The short form was chosen because the target is a
                        // label of this section the field reaches. A
                        // reference that instead needs a relocation would
                        // hand the link a field too narrow to fill.
                        if short.is_some() {
                            return Err(alloc::format!(
                                "inline asm: short branch to `{:?}` needs a relocation",
                                r.target
                            ));
                        }
                        r.offset += base;
                        sec.relocs.push(r);
                    }
                    sec.bytes.extend_from_slice(&buf);
                }
                AsmSectionItem::Code(text) => {
                    return Err(alloc::format!(
                        "inline asm: replacement instruction `{text}` in a named section is not \
                         assembled for this target"
                    ));
                }
            }
            // Alignment padding follows the instruction boundary the last
            // byte-emitting item left; the padding itself sets none.
            match item {
                AsmSectionItem::CodeBytes { .. } => {
                    sec.after_insn = true;
                    // gas gives a section holding instructions at least the
                    // architecture's instruction alignment (4 on AArch64,
                    // where `align_is_p2` holds; 1 on x86).
                    if align_is_p2 {
                        sec.align = sec.align.max(4);
                    }
                }
                AsmSectionItem::Data { .. }
                | AsmSectionItem::Fill { .. }
                | AsmSectionItem::Bytes(_)
                | AsmSectionItem::Org(..)
                | AsmSectionItem::OrgLabel { .. } => sec.after_insn = false,
                _ => {}
            }
            if !matches!(item, AsmSectionItem::Rept { .. }) {
                sec.map_state = step_map_state(item, sec.map_state, b.flags.contains('x'));
            }
            // Everything an item lays down other than an instruction is
            // data. `.align` recorded its own class above and `.rept` each
            // repetition's. A `.org` moves the location counter without
            // recording a run, as in GNU as, so the surrounding run covers
            // the gap.
            let laid = sec.bytes.len().saturating_sub(map_at);
            match item {
                AsmSectionItem::CodeBytes { .. } => sec.map.content(map_at, laid, MapClass::Code),
                AsmSectionItem::Align { .. }
                | AsmSectionItem::Rept { .. }
                | AsmSectionItem::Org(..)
                | AsmSectionItem::OrgLabel { .. }
                | AsmSectionItem::OrgExpr(..) => {}
                _ => sec.map.content(map_at, laid, MapClass::Data),
            }
        }
    }
    // `.weak` binds a matching section label weak; a name defined in no
    // section is a unit-level weak symbol the file-scope parse records.
    // TODO: this stays a whole-sink scan. The label index cannot serve it as
    // written: a `.weak` naming a label of its own statement has to see a
    // definition this call has not published yet. Templates carrying `.weak`
    // skip the loop entirely, so it is not on the export-table path.
    for name in &weak_names {
        let AsmSectionSink {
            sections,
            published,
            non_local,
            weak,
            ..
        } = &mut *sink;
        for (si, s) in sections.all_mut().iter_mut().enumerate() {
            for (i, l) in s
                .labels
                .iter_mut()
                .enumerate()
                .filter(|(_, l)| l.name == *name)
            {
                rebind_label(l, i < published[si], non_local, weak, |l| l.weak = true);
            }
        }
    }
    // The same for `.globl`, whose declaration and definition need not share
    // a section: the kernel's `vdso-wrap.S` declares in the default section
    // and defines in `.rodata`. The per-section pass above already bound the
    // same-section case; this reaches the rest.
    for name in &global_names {
        let AsmSectionSink {
            sections,
            published,
            non_local,
            weak,
            ..
        } = &mut *sink;
        for (si, s) in sections.all_mut().iter_mut().enumerate() {
            for (i, l) in s
                .labels
                .iter_mut()
                .enumerate()
                .filter(|(_, l)| l.name == *name && l.offset != PENDING_LABEL)
            {
                rebind_label(l, i < published[si], non_local, weak, |l| l.global = true);
            }
        }
    }
    // A `.globl` naming no label in the section declares an external symbol,
    // not a definition here; it defines no section symbol. A `.type` / `.size`
    // that stays pending named a label the section never defines -- rejected
    // (a forward `.type` before its label was filled in by the definition).
    // Only this call's sections can hold a pending entry: every call drops
    // its own below, so none survives into the next.
    // A `.set name, symbol` alias is a symbol of the unit with no label of
    // its own, so a `.type` / `.size` over one stays pending here; the alias
    // takes its target's attributes.
    let aliased: alloc::collections::BTreeSet<&str> = blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::SymSet { name, .. } => Some(name.as_str()),
            _ => None,
        })
        .collect();
    // A `.set` whose value reduced to a location defines the name as a
    // label of the owning section, as GNU as does, so a field referencing
    // it relocates against a definition.
    for name in blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::SetExpr { name, .. } => Some(name.as_str()),
            _ => None,
        })
    {
        let (Some(sk), Some(off)) = (measured.section(name), measured.offset(name)) else {
            continue;
        };
        let Some(&si) = sink.by_key.get(sk as &str) else {
            continue;
        };
        let s = sink.sections.at_mut(si);
        if !s.labels.iter().any(|l| l.name == name) {
            s.labels.push(AsmSectionLabel {
                name: alloc::string::String::from(name),
                offset: off as u32,
                global: false,
                weak: false,
                sym_type: AsmSymType::NoType,
                size: None,
                absolute: None,
            });
        }
    }
    for &(sec_idx, from) in &touched {
        let s = sink.sections.at_mut(sec_idx);
        if let Some(l) = s.labels[from..].iter().find(|l| {
            l.offset == PENDING_LABEL
                && (l.sym_type != AsmSymType::NoType || l.size.is_some())
                && !aliased.contains(l.name.as_str())
        }) {
            return Err(alloc::format!(
                "inline asm: `.type`/`.size` names undefined label `{}`",
                l.name
            ));
        }
        let mut keep = from;
        for i in from..s.labels.len() {
            if s.labels[i].offset != PENDING_LABEL {
                s.labels.swap(keep, i);
                keep += 1;
            }
        }
        s.labels.truncate(keep);
    }
    for &(sec_idx, from) in &touched {
        sink.publish_labels(sec_idx, from);
    }
    Ok(defined)
}

/// Reject the unit-level symbol directives an operand statement's sections
/// carry that no channel of the emit path takes. `.set name, sym` is an
/// object-level alias the file-scope parse records; `.weak` inside a section
/// binds a label the section defines but has no carrier for a name it does
/// not, which the code stream's declarations provide.
/// TODO accept both in a function-scope statement's sections.
pub(crate) fn reject_unit_symbol_items(
    blocks: &[AsmSectionBlock],
) -> Result<(), alloc::string::String> {
    for item in blocks.iter().flat_map(|b| &b.items) {
        match item {
            AsmSectionItem::Weak(n) => {
                return Err(alloc::format!(
                    "inline asm: `.weak {n}` outside file-scope asm"
                ));
            }
            AsmSectionItem::SymSet { name, .. } => {
                return Err(alloc::format!(
                    "inline asm: `.set {name}, ...` outside file-scope asm"
                ));
            }
            _ => {}
        }
    }
    Ok(())
}

/// Prepare a file-scope template for section extraction: strip comments,
/// expand GNU as macro directives (file scope has no operands to
/// substitute), and rename numeric labels defined more than once to
/// per-definition unique names, each `Nb` / `Nf` reference binding to the
/// nearest definition in its direction (GNU as redefinable local labels).
/// The parse stores the prepared text, so the codegen materialization and
/// the parse-time validation see identical statements.
pub(crate) fn prepare_file_asm_text(
    text: &str,
    comments: AsmComments,
) -> Result<alloc::string::String, alloc::string::String> {
    let stripped = strip_asm_comments(text, comments);
    let text = stripped.as_deref().unwrap_or(text);
    let expanded = expand_asm_gas_macros(text, 4, &|_| None)?;
    let text = expanded.as_deref().unwrap_or(text);
    let renamed = rewrite_multidef_local_labels(text);
    Ok(renamed.unwrap_or_else(|| alloc::string::String::from(text)))
}

/// Materialize a unit's file-scope `asm("...")` templates into `sink`.
/// The parse validated each template as section data directives only,
/// so there is no code stream: label references resolve as named-symbol
/// relocations and there are no operands.
pub(crate) fn materialize_file_asm(
    templates: &[alloc::string::String],
    align_is_p2: bool,
    comments: AsmComments,
    encode_code: &dyn Fn(&mut [AsmSectionBlock]) -> Result<(), alloc::string::String>,
    sink: &mut AsmSectionSink,
) -> Result<(), alloc::string::String> {
    for text in templates {
        let stripped = strip_asm_comments(text, comments);
        let text = stripped.as_deref().unwrap_or(text);
        // The stream outside pushed sections is either linkage-only (`.globl`,
        // no bytes to emit here) or a trampoline body assembled as `.text`.
        // The probe runs the function-scope extractor, which rejects forms
        // only the file-scope one accepts; its error falls through.
        let mut blocks = match extract_asm_sections(text, align_is_p2) {
            Ok(Some(ex)) if ex.is_linkage_only() => {
                let mut blocks = ex.blocks;
                // `.globl` is unit-level, so it binds a label this template
                // defines in one of its sections as well as the C symbol the
                // parse already applied it to.
                if let Some(first) = blocks.first_mut() {
                    for name in ex.sym_items {
                        first.items.push(name);
                    }
                }
                blocks
            }
            _ => extract_file_scope_asm_sections(text, align_is_p2)?,
        };
        // Assemble the section's instructions to bytes before layout; the
        // file-scope path has no operand context to resolve against.
        encode_code(&mut blocks)?;
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            align_is_p2,
            sink,
        )?;
    }
    Ok(())
}

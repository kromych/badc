//! The assembly listing `-S` writes. Each emitter describes an instruction
//! where it forms the bytes; the listing keeps the text beside the byte range
//! and resolves the symbolic operands once the object's bytes are final.
//!
//! A pc-relative operand is read from its field in the final bytes, so a
//! pass that patches a displacement needs no listing update. A pass that
//! drops bytes drops their rows ([`Listing::truncate`]); one that rewrites an
//! instruction into another re-describes it ([`Listing::retext`],
//! [`Listing::replace`]).

use alloc::string::String;

/// What the operand slot of an instruction's text names.
#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) enum Operand {
    /// The target of the pc-relative field `field` bytes into the
    /// instruction, `width` bytes wide and measured from its end (x86-64).
    PcRel { field: u8, width: u8 },
    /// The value of the field `field` bytes into the instruction, `width`
    /// bytes wide.
    Field { field: u8, width: u8 },
    /// The function whose entry is this bytecode PC.
    Func(usize),
    /// The import of this index.
    Import(usize),
    /// The data object at this data-stream offset.
    Data(i64),
    /// A symbol by name.
    Name(String),
    /// A field of the A64 instruction word.
    #[cfg_attr(not(feature = "listing"), allow(dead_code))]
    A64(A64Field),
}

/// A field of an A64 instruction word a relocation or a later pass may fill.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum A64Field {
    /// A branch target: the signed word offset `bits` wide at bit `lo`.
    Branch { lo: u8, bits: u8 },
    /// `adr`: the signed byte offset in `immhi:immlo`.
    Adr,
    /// `adrp`: the signed page offset in `immhi:immlo`.
    Adrp,
    /// The unsigned 12-bit immediate at bit 10, scaled by `1 << scale`: an
    /// `add`'s or, inside a memory operand (`mem`), a load's or a store's
    /// offset, where zero reads as no offset.
    Lo12 { scale: u8, mem: bool },
    /// The 16-bit immediate of a move-wide at bit 5.
    Imm16,
}

/// A relocation of a field of the text, as the listing names it.
#[cfg(feature = "listing")]
#[derive(Clone, Debug)]
pub(crate) struct Reloc {
    pub(crate) symbol: String,
    pub(crate) addend: i64,
    /// The field is measured from the instruction's end (x86-64).
    pub(crate) pcrel: bool,
    /// The operator ahead of the symbol, as `:lo12:`.
    pub(crate) spec: &'static str,
}

/// An instruction's text; its operand, when it has one, is inserted at byte
/// `slot` of `text`.
#[derive(Clone, Debug)]
pub(crate) struct Text {
    pub(crate) text: String,
    pub(crate) operand: Option<(usize, Operand)>,
}

/// How a prefix ahead of an instruction amends its text, with the prefix's
/// byte.
pub(crate) type Amend = fn(&mut Text, u8);

impl From<String> for Text {
    fn from(text: String) -> Self {
        Text {
            text,
            operand: None,
        }
    }
}

impl Text {
    /// Insert `s` at byte `at` of the text; an operand slot at or past `at`
    /// moves with the text after it.
    pub(crate) fn insert(&mut self, at: usize, s: &str) {
        self.text.insert_str(at, s);
        if let Some((slot, _)) = &mut self.operand
            && *slot >= at
        {
            *slot += s.len();
        }
    }

    /// `head`, the operand, then `tail`.
    pub(crate) fn with(head: &str, operand: Operand, tail: &str) -> Self {
        let mut text = String::with_capacity(head.len() + tail.len());
        text.push_str(head);
        text.push_str(tail);
        Text {
            text,
            operand: Some((head.len(), operand)),
        }
    }
}

#[cfg(feature = "listing")]
pub(crate) use rows::{Listing, render};

#[cfg(feature = "listing")]
mod rows {
    use alloc::collections::BTreeMap;
    use alloc::format;
    use alloc::string::String;
    use alloc::vec::Vec;
    use core::fmt::Write;

    use super::{A64Field, Amend, Operand, Reloc, Text};
    use crate::c5::codegen::Build;
    use crate::c5::program::Program;

    /// One instruction: its bytes are `at..end` of the unit's text.
    #[derive(Clone, Debug)]
    struct Row {
        at: usize,
        end: usize,
        text: Text,
    }

    /// A data directive's element width for bytes the unit placed in text.
    const DATA_DIRECTIVES: [(usize, &str); 3] = [(8, ".quad"), (4, ".long"), (1, ".byte")];

    /// The rows of a unit's text in offset order, the blocks' start offsets,
    /// and the bytes the object holds once its writer has them.
    #[derive(Clone, Debug, Default)]
    pub(crate) struct Listing {
        rows: Vec<Row>,
        labels: Vec<(usize, u32)>,
        text: Option<Vec<u8>>,
        /// Ranges of the text a section of their own holds: `(from, to,
        /// name, offset there)`.
        sections: Vec<(usize, usize, String, usize)>,
        /// A prefix the next instruction absorbs: where it begins, and how it
        /// amends the instruction's text.
        pending: Option<(usize, Amend, u8)>,
        /// The object's relocations by field offset.
        relocs: BTreeMap<usize, Reloc>,
        /// The text is A64 words, which print as words.
        words: bool,
    }

    impl Listing {
        pub(crate) fn push(&mut self, at: usize, end: usize, mut text: Text) {
            if at == end {
                return;
            }
            let at = match self.pending.take() {
                Some((from, amend, arg)) => {
                    amend(&mut text, arg);
                    from
                }
                None => at,
            };
            debug_assert!(
                self.rows.last().is_none_or(|r| r.end <= at) && at <= end,
                "listing row {at:#x}..{end:#x} `{}` overlaps the previous one",
                text.text
            );
            self.rows.push(Row { at, end, text });
        }

        /// The operand of the last instruction is `operand`.
        pub(crate) fn name_last(&mut self, operand: Operand) {
            let Some(row) = self.rows.last_mut() else {
                return;
            };
            match &mut row.text.operand {
                Some((_, o)) => *o = operand,
                None => debug_assert!(false, "`{}` has no operand slot", row.text.text),
            }
        }

        /// The bytes from `at` are a prefix of the next instruction, whose
        /// text `amend` rewrites with `arg`.
        pub(crate) fn prefix_next(&mut self, at: usize, amend: Amend, arg: u8) {
            if self.pending.is_none() {
                self.pending = Some((at, amend, arg));
            }
        }

        /// The rows and labels of `other`, whose bytes follow at `base`.
        pub(crate) fn append(&mut self, other: Listing, base: usize) {
            for r in other.rows {
                self.push(base + r.at, base + r.end, r.text);
            }
            (self.labels).extend(other.labels.into_iter().map(|(at, b)| (base + at, b)));
        }

        /// The operand of the instruction at `at` is `operand`.
        pub(crate) fn name_at(&mut self, at: usize, operand: Operand) {
            let Ok(i) = self.rows.binary_search_by_key(&at, |r| r.at) else {
                return;
            };
            if let Some((_, o)) = &mut self.rows[i].text.operand {
                *o = operand;
            }
        }

        /// Block `block` begins at `at`.
        pub(crate) fn label(&mut self, at: usize, block: u32) {
            self.labels.push((at, block));
        }

        /// The bytes from `len` on are dropped, and every row in them.
        pub(crate) fn truncate(&mut self, len: usize) {
            if self.pending.is_some_and(|(at, ..)| at >= len) {
                self.pending = None;
            }
            while self.rows.last().is_some_and(|r| r.end > len) {
                self.rows.pop();
            }
            while self.labels.last().is_some_and(|&(at, _)| at >= len) {
                self.labels.pop();
            }
        }

        /// The instruction at `at` was rewritten into one reading `text`,
        /// whose operand slot, at byte `slot`, keeps the operand it had.
        pub(crate) fn retext(&mut self, at: usize, text: String, slot: Option<usize>) {
            let Ok(i) = self.rows.binary_search_by_key(&at, |r| r.at) else {
                debug_assert!(false, "no listing row at {at:#x} to rewrite into `{text}`");
                return;
            };
            let row = &mut self.rows[i];
            let operand = row.text.operand.take().map(|(_, o)| o);
            row.text = Text {
                text,
                operand: slot.zip(operand),
            };
        }

        /// The instruction at `at` was rewritten into one reading `text`.
        pub(crate) fn replace(&mut self, at: usize, text: Text) {
            match self.rows.binary_search_by_key(&at, |r| r.at) {
                Ok(i) => self.rows[i].text = text,
                Err(_) => debug_assert!(false, "no listing row at {at:#x} to rewrite"),
            }
        }

        /// The object holds `text`, A64 words when `words` is set,
        /// `sections` move ranges of it into sections of their own, and
        /// `relocs` name the symbol each field at an offset resolves
        /// against.
        pub(crate) fn set_final(
            &mut self,
            text: Vec<u8>,
            words: bool,
            sections: Vec<(usize, usize, String, usize)>,
            relocs: Vec<(usize, Reloc)>,
        ) {
            self.text = Some(text);
            self.words = words;
            self.sections = sections;
            self.relocs = relocs.into_iter().collect();
        }
    }

    /// The names the operands resolve to.
    struct Names<'a> {
        /// Function entries by text offset.
        entries: BTreeMap<usize, &'a str>,
        /// Function names by bytecode entry PC, defined or not.
        by_pc: BTreeMap<usize, &'a str>,
        /// Data objects by data-stream offset, with their sizes.
        data: BTreeMap<u64, (&'a str, u64)>,
        /// Labels by text offset: blocks and the synthesized ones.
        labels: BTreeMap<usize, String>,
        relocs: &'a BTreeMap<usize, Reloc>,
        build: &'a Build,
    }

    impl Names<'_> {
        fn target(&self, at: usize) -> String {
            if let Some(name) = self.entries.get(&at) {
                return String::from(*name);
            }
            match self.labels.get(&at) {
                Some(l) => l.clone(),
                None => format!("{at:#x}"),
            }
        }

        fn data(&self, off: i64) -> String {
            let b = self.build;
            if let Ok(u) = u64::try_from(off)
                && let Some((&start, &(name, size))) = self.data.range(..=u).next_back()
                && u < start + size.max(1)
            {
                return with_addend(name, (u - start) as i64);
            }
            let off = off.max(0) as usize;
            let (start, section) = if off < b.data_ro_len {
                (0, ".rodata")
            } else if off < b.data_relro_len {
                (b.data_ro_len, ".data.rel.ro")
            } else if off < b.data.len() {
                (b.data_relro_len, ".data")
            } else {
                (b.data.len(), ".bss")
            };
            with_addend(section, (off - start) as i64)
        }

        fn operand(&self, row: &Row, bytes: &[u8], o: &Operand) -> String {
            // A relocated field names the relocation's symbol.
            if let Operand::PcRel { field, .. } | Operand::Field { field, .. } = o {
                let at = row.at + usize::from(*field);
                if let Some(r) = self.relocs.get(&at) {
                    let a = if r.pcrel {
                        r.addend + (row.end - at) as i64
                    } else {
                        r.addend
                    };
                    return with_addend(plain(&r.symbol), a);
                }
            }
            match o {
                Operand::PcRel { field, width } => match field_value(row, bytes, *field, *width) {
                    Some(disp) => self.target((row.end as i64 + disp) as usize),
                    None => String::from("?"),
                },
                Operand::Field { field, width } => match field_value(row, bytes, *field, *width) {
                    Some(v) if v < 0 => format!("-{:#x}", v.unsigned_abs()),
                    Some(v) => format!("{v:#x}"),
                    None => String::from("?"),
                },
                Operand::Func(pc) => match self.by_pc.get(pc) {
                    Some(name) => String::from(*name),
                    None => format!("<pc {pc}>"),
                },
                Operand::Import(i) => match self.build.imports.imports.get(*i) {
                    Some(imp) => String::from(plain(&imp.local_name)),
                    None => format!("<import {i}>"),
                },
                Operand::Data(off) => self.data(*off),
                Operand::Name(name) => String::from(plain(name)),
                Operand::A64(f) => self.a64(row, bytes, *f),
            }
        }

        /// An A64 field: the relocation's symbol, else the value the word
        /// holds.
        fn a64(&self, row: &Row, bytes: &[u8], f: A64Field) -> String {
            let lead = match f {
                A64Field::Lo12 { mem: true, .. } => ", ",
                _ => "",
            };
            if let Some(r) = self.relocs.get(&row.at) {
                return format!(
                    "{lead}{}{}",
                    r.spec,
                    with_addend(plain(&r.symbol), r.addend)
                );
            }
            let Some(word) = a64_word(row, bytes) else {
                return String::from("?");
            };
            match (a64_target(row.at, word, f), f) {
                (Some(at), A64Field::Adrp) => format!("{at:#x}"),
                (Some(at), _) => self.target(at),
                (None, A64Field::Lo12 { scale, .. }) => match ((word >> 10) & 0xfff) << scale {
                    0 if !lead.is_empty() => String::new(),
                    v => format!("{lead}#{v:#x}"),
                },
                (None, _) => format!("#{:#x}", (word >> 5) & 0xffff),
            }
        }
    }

    /// The A64 word of `row`.
    fn a64_word(row: &Row, bytes: &[u8]) -> Option<u32> {
        let w = bytes.get(row.at..row.at + 4)?;
        Some(u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
    }

    /// The offset the pc-relative field `f` of `word` at `at` reaches; `None`
    /// for an immediate.
    fn a64_target(at: usize, word: u32, f: A64Field) -> Option<usize> {
        let sext = |v: u32, bits: u32| i64::from(((v << (32 - bits)) as i32) >> (32 - bits));
        let imm21 = sext((((word >> 5) & 0x7_FFFF) << 2) | ((word >> 29) & 3), 21);
        let off = match f {
            A64Field::Branch { lo, bits } => {
                let (lo, bits) = (u32::from(lo), u32::from(bits));
                sext((word >> lo) & ((1 << bits) - 1), bits) * 4
            }
            A64Field::Adr => imm21,
            A64Field::Adrp => return Some(((at as i64 & !0xfff) + (imm21 << 12)) as usize),
            A64Field::Lo12 { .. } | A64Field::Imm16 => return None,
        };
        Some((at as i64 + off) as usize)
    }

    /// The signed value of the `width`-byte field `field` bytes into `row`.
    fn field_value(row: &Row, bytes: &[u8], field: u8, width: u8) -> Option<i64> {
        let at = row.at + usize::from(field);
        match (width, bytes.get(at..at + usize::from(width))?) {
            (1, f) => Some(i64::from(f[0] as i8)),
            (4, f) => Some(i64::from(i32::from_le_bytes([f[0], f[1], f[2], f[3]]))),
            _ => None,
        }
    }

    /// A symbol's name as an assembler spells it: a leading `\x01`, which
    /// marks a name the object format takes without its prefix, is not
    /// part of it.
    fn plain(name: &str) -> &str {
        name.strip_prefix('\u{1}').unwrap_or(name)
    }

    fn with_addend(name: &str, addend: i64) -> String {
        match addend {
            0 => String::from(name),
            a if a > 0 => format!("{name}+{a:#x}"),
            a => format!("{name}-{:#x}", a.unsigned_abs()),
        }
    }

    /// The listing of a unit's text: each function's instructions with
    /// their offsets, bytes and text, the blocks' labels, and data the unit
    /// placed in the text as directives. A byte no row describes prints as
    /// `.byte` marked `# no text`.
    pub(crate) fn render(listing: &Listing, program: &Program, build: &Build) -> String {
        use crate::c5::token::Token;
        let bytes = listing.text.as_deref().unwrap_or(&build.text);
        let entries: BTreeMap<usize, &str> = (build.func_ent_pcs.iter().zip(&build.func_names))
            .filter_map(|(&pc, name)| {
                let at = *build.pc_to_native.get(pc)?;
                (at != usize::MAX && !name.is_empty()).then_some((at, plain(name)))
            })
            .collect();
        let mut by_pc: BTreeMap<usize, &str> = (program.symbols.iter())
            .filter(|s| s.is_fun_entity() && !s.name.is_empty())
            .map(|s| (s.val as usize, plain(s.link_name())))
            .collect();
        by_pc.extend((program.extern_function_imports.iter()).map(|(pc, name)| (*pc, plain(name))));
        // Funclets carry names no symbol does.
        for (&pc, name) in build.func_ent_pcs.iter().zip(&build.func_names) {
            by_pc.entry(pc).or_insert(plain(name));
        }
        let data: BTreeMap<u64, (&str, u64)> = (program.symbols.iter())
            .filter(|s| {
                s.class == Token::Glo as i64
                    && s.defined_here
                    && !s.is_alias
                    && !s.is_thread_local
                    && !s.name.is_empty()
            })
            .map(|s| {
                let size = s.data_byte_size.max(0) as u64;
                (s.val.max(0) as u64, (plain(s.link_name()), size))
            })
            .collect();
        let func_at: Vec<usize> = entries.keys().copied().collect();
        let func_of = |at: usize| func_at.partition_point(|&e| e <= at).saturating_sub(1);
        let mut labels: BTreeMap<usize, String> = BTreeMap::new();
        for &(at, block) in &listing.labels {
            if !entries.contains_key(&at) {
                labels
                    .entry(at)
                    .or_insert_with(|| format!(".LBB{}_{block}", func_of(at)));
            }
        }
        let mut names = Names {
            entries,
            by_pc,
            data,
            labels,
            relocs: &listing.relocs,
            build,
        };
        // A pc-relative target no block names takes a label of its own.
        let mut tmp = 0;
        for row in &listing.rows {
            let target = match &row.text.operand {
                Some((_, Operand::PcRel { field, width })) => {
                    if listing.relocs.contains_key(&(row.at + usize::from(*field))) {
                        continue;
                    }
                    let Some(disp) = field_value(row, bytes, *field, *width) else {
                        continue;
                    };
                    (row.end as i64 + disp) as usize
                }
                Some((_, Operand::A64(f @ (A64Field::Branch { .. } | A64Field::Adr)))) => {
                    if listing.relocs.contains_key(&row.at) {
                        continue;
                    }
                    match a64_word(row, bytes).and_then(|w| a64_target(row.at, w, *f)) {
                        Some(at) => at,
                        None => continue,
                    }
                }
                _ => continue,
            };
            if target <= bytes.len()
                && !names.entries.contains_key(&target)
                && !names.labels.contains_key(&target)
            {
                names.labels.insert(target, format!(".Ltmp{tmp}"));
                tmp += 1;
            }
        }
        let data_ranges: BTreeMap<usize, usize> = build.text_data_ranges.iter().copied().collect();
        // The section an offset of the text lands in, and its offset there.
        let place = |at: usize| match (listing.sections.iter()).find(|s| (s.0..s.1).contains(&at)) {
            Some((from, _, name, base)) => (name.as_str(), at - from + base),
            None => (".text", at),
        };
        let mut out = String::new();
        let mut section = "";
        let mut rows = listing.rows.iter().peekable();
        let mut at = 0;
        let end = build.pc_to_native.last().copied().unwrap_or(bytes.len());
        let end = end.min(bytes.len());
        while at < end {
            let (s, offset) = place(at);
            if s != section {
                let _ = writeln!(out, "\t.section\t{s}");
                section = s;
            }
            if let Some(name) = names.entries.get(&at) {
                let _ = writeln!(out, "\n{name}:");
            } else if let Some(label) = names.labels.get(&at) {
                let _ = writeln!(out, "{label}:");
            }
            while rows.peek().is_some_and(|r| r.at < at) {
                rows.next();
            }
            let (to, text) = match rows.peek() {
                Some(r) if r.at == at && r.end > at => {
                    let mut text = r.text.text.clone();
                    if let Some((slot, o)) = &r.text.operand {
                        text.insert_str(*slot, &names.operand(r, bytes, o));
                    }
                    (r.end, text)
                }
                _ => match data_ranges.get(&at) {
                    // Data the unit placed in the text.
                    Some(&len) => {
                        let to = (at + len).min(end);
                        let &(width, directive) = (DATA_DIRECTIVES.iter())
                            .find(|(w, _)| (to - at) % w == 0)
                            .unwrap_or(&(1, ".byte"));
                        let mut text = format!("{directive}\t");
                        for (k, chunk) in bytes[at..to].chunks(width).enumerate() {
                            if k > 0 {
                                text.push_str(", ");
                            }
                            let mut v = 0u64;
                            for (i, b) in chunk.iter().enumerate() {
                                v |= u64::from(*b) << (8 * i);
                            }
                            let _ = write!(text, "{v:#x}");
                        }
                        (to, text)
                    }
                    None => (at + 1, format!(".byte\t{:#x}\t# no text", bytes[at])),
                },
            };
            let _ = write!(out, "{offset:>8x}:  ");
            let mut col = 0;
            if listing.words && to - at == 4 && !text.starts_with('.') {
                let w =
                    u32::from_le_bytes([bytes[at], bytes[at + 1], bytes[at + 2], bytes[at + 3]]);
                let _ = write!(out, "{w:08x} ");
                col = 9;
            } else {
                for b in &bytes[at..to] {
                    let _ = write!(out, "{b:02x} ");
                    col += 3;
                }
            }
            for _ in col..30 {
                out.push(' ');
            }
            let _ = writeln!(out, " {text}");
            at = to;
        }
        out
    }

    #[cfg(test)]
    mod tests {
        use super::super::super::ssa::code_buf::CodeBuf;
        use super::*;

        fn rows(code: &mut CodeBuf) -> Vec<(usize, usize, String)> {
            let l = code.take_listing().unwrap();
            let rows = l
                .rows
                .iter()
                .map(|r| (r.at, r.end, r.text.text.clone()))
                .collect();
            *code = CodeBuf::listed(true);
            rows
        }

        fn insn(code: &mut CodeBuf, bytes: &[u8], text: &str) {
            let at = code.len();
            code.extend_from_slice(bytes);
            code.describe(at, || String::from(text));
        }

        /// Truncated and split-off bytes drop their rows; a prefix joins the
        /// next instruction; an appended probe keeps its rows past the bytes
        /// ahead of it.
        #[test]
        fn rows_follow_the_bytes() {
            let mut code = CodeBuf::listed(true);
            insn(&mut code, &[0x90], "nop");
            insn(&mut code, &[0xC3], "retq");
            code.truncate(1);
            insn(&mut code, &[0xCC], "int3");
            let _ = code.split_off(1);
            code.push(0xF0);
            code.prefix_next(1, |t, _| t.insert(0, "lock "), 0);
            insn(&mut code, &[0x01, 0x07], "addl %eax, (%rdi)");
            let mut probe = code.probe();
            insn(&mut probe, &[0x90], "nop");
            code.append(probe);
            assert_eq!(
                rows(&mut code),
                [
                    (0, 1, String::from("nop")),
                    (1, 4, String::from("lock addl %eax, (%rdi)")),
                    (4, 5, String::from("nop")),
                ]
            );
        }
    }
}

//! Directive parsing: a prepared statement stream is read into section
//! blocks and the items each directive contributes -- data, strings,
//! fill, symbol declarations, relocations and the section switches
//! themselves.

use super::*;
use crate::c5::codegen::ssa::cfi;

/// Split a template into its code text and its section blocks. Returns
/// `None` when the template has no section directives (the common case).
/// The section stack starts at the code stream; `.pushsection` pushes a
/// named section, `.popsection` pops, `.section` replaces the top, and
/// `.previous` swaps the top two.
pub(crate) fn extract_asm_sections(
    text: &str,
    is_aarch64: bool,
) -> Result<Option<AsmExtract>, alloc::string::String> {
    extract_asm_sections_impl(text, is_aarch64, false)
}

/// What a function-scope template splits into: the code stream the arch
/// backend encodes, the named-section blocks, and the symbol directives the
/// code stream carried, which GNU as scopes to the unit rather than to a
/// section.
#[derive(Debug)]
pub(crate) struct AsmExtract {
    pub code: alloc::string::String,
    pub blocks: alloc::vec::Vec<AsmSectionBlock>,
    pub sym_items: alloc::vec::Vec<AsmSectionItem>,
}

impl AsmExtract {
    /// The linkage-only form of a file-scope template: outside its sections
    /// it declares external names and defines nothing, so there is no
    /// trampoline body to assemble as `.text`. `.globl` is the only such
    /// declaration a C symbol of the unit takes; the others bind a symbol the
    /// file-scope parse records on its own channels.
    pub(crate) fn is_linkage_only(&self) -> bool {
        self.code.trim().is_empty()
            && self
                .sym_items
                .iter()
                .all(|i| matches!(i, AsmSectionItem::Global(_)))
    }

    /// The names its `.globl` / `.global` statements declare.
    pub(crate) fn globl_names(&self) -> impl Iterator<Item = &str> {
        self.sym_items.iter().filter_map(|i| match i {
            AsmSectionItem::Global(n) => Some(n.as_str()),
            _ => None,
        })
    }
}

/// File-scope variant: the whole template is section-scoped, starting in
/// `.text`, so a trampoline body (labels + instructions in the default
/// section) is assembled into a `.text` block rather than left in the code
/// stream. `.text`/`.data`/`.rodata`/`.bss` switch the base section.
pub(crate) fn extract_file_scope_asm_sections(
    text: &str,
    is_aarch64: bool,
) -> Result<alloc::vec::Vec<AsmSectionBlock>, alloc::string::String> {
    Ok(extract_asm_sections_impl(text, is_aarch64, true)?
        .expect("file-scope extraction always yields sections")
        .blocks)
}

/// ELF relocation type number for a `.reloc` type name. The names are
/// architecture-qualified, so one table serves every target.
fn elf_reloc_type_by_name(name: &str) -> Option<u32> {
    Some(match name {
        "R_X86_64_NONE" | "R_386_NONE" | "R_AARCH64_NONE" => 0,
        "R_X86_64_64" | "R_386_32" => 1,
        "R_X86_64_PC32" | "R_386_PC32" => 2,
        "R_X86_64_GOT32" | "R_386_GOT32" => 3,
        "R_X86_64_PLT32" | "R_386_PLT32" => 4,
        "R_X86_64_GOTPCREL" => 9,
        "R_X86_64_32" | "R_386_GOTPC" => 10,
        "R_X86_64_32S" => 11,
        "R_X86_64_16" => 12,
        "R_X86_64_PC16" => 13,
        "R_X86_64_8" => 14,
        "R_X86_64_PC8" => 15,
        "R_386_16" => 20,
        "R_386_PC16" => 21,
        "R_386_8" => 22,
        "R_386_PC8" => 23,
        "R_X86_64_PC64" => 24,
        "R_AARCH64_ABS64" => 257,
        "R_AARCH64_ABS32" => 258,
        "R_AARCH64_ABS16" => 259,
        "R_AARCH64_PREL64" => 260,
        "R_AARCH64_PREL32" => 261,
        "R_AARCH64_PREL16" => 262,
        _ => return None,
    })
}

/// Parse `.reloc offset, TYPE[, expression]`. The offset is measured from the
/// start of the section the directive sits in, not from the location counter;
/// the expression is a symbol with an optional constant addend, a bare
/// constant (the section itself), or absent. The directive deposits no bytes.
fn parse_reloc_directive(rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let bad = || alloc::format!("inline asm: `.reloc {rest}` is not `offset, TYPE[, expr]`");
    let mut args = split_top_commas(rest).into_iter();
    let (Some(off), Some(ty)) = (args.next(), args.next()) else {
        return Err(bad());
    };
    let offset = eval_const_expr(off).filter(|&v| (0..=u32::MAX as i64).contains(&v));
    let (Some(offset), Some(rtype)) = (offset, elf_reloc_type_by_name(ty)) else {
        return Err(bad());
    };
    let expr = args.next().unwrap_or("").trim();
    if args.next().is_some() {
        return Err(bad());
    }
    // `sym`, `sym +/- <const expr>`, or a bare constant.
    let split = expr
        .char_indices()
        .skip(1)
        .find(|&(_, c)| c == '+' || c == '-');
    let (name, addend) = match split {
        Some((i, sign)) => {
            let a = eval_const_expr(&expr[i + 1..]).ok_or_else(bad)?;
            (expr[..i].trim(), if sign == '-' { -a } else { a })
        }
        None => (expr, 0),
    };
    let (target, addend) = match eval_const_expr(name) {
        Some(v) => (alloc::string::String::new(), v + addend),
        None if is_asm_symbol_name(name) => (alloc::string::String::from(name), addend),
        None if name.is_empty() => (alloc::string::String::new(), addend),
        None => return Err(bad()),
    };
    Ok(AsmSectionItem::Reloc {
        offset: offset as u32,
        rtype,
        target,
        addend,
    })
}

/// Directives GNU as resolves against the unit's symbol table rather than
/// against the section they sit in. An assignment is one: it defines a
/// symbol of the unit, not a location in the stream it sits in.
fn is_asm_sym_directive(tok: &str) -> bool {
    matches!(
        tok,
        ".globl"
            | ".global"
            | ".weak"
            | ".local"
            | ".hidden"
            | ".internal"
            | ".protected"
            | ".type"
            | ".size"
            | ".set"
            | ".equ"
            | ".equiv"
    )
}

/// Whether a template's statements hold one. A spelling test gates the
/// statement scan: a template with none keeps its text verbatim, since
/// extraction reconstructs the code stream it returns.
fn asm_text_has_sym_directive(text: &str) -> bool {
    if !(text.contains(".glob")
        || text.contains(".weak")
        || text.contains(".local")
        || text.contains(".hidden")
        || text.contains(".internal")
        || text.contains(".protected")
        || text.contains(".type")
        || text.contains(".size")
        || text.contains(".set")
        || text.contains(".equ"))
    {
        return false;
    }
    split_asm_statements(text).into_iter().any(|stmt| {
        let mut s = stmt.trim();
        while let Some((_, rest)) = peel_leading_label(s) {
            s = rest;
        }
        is_asm_sym_directive(split_first_token(s).0)
    })
}

/// Parse one symbol directive into items. `.globl a, b` declares each name;
/// the rest take a name plus their own arguments.
fn push_sym_directive_items(
    tok: &str,
    rest: &str,
    is_aarch64: bool,
    out: &mut alloc::vec::Vec<AsmSectionItem>,
) -> Result<(), alloc::string::String> {
    if matches!(
        tok,
        ".globl" | ".global" | ".weak" | ".local" | ".hidden" | ".internal" | ".protected"
    ) && rest.contains(',')
    {
        for name in rest.split(',') {
            out.push(parse_section_item(tok, name.trim(), is_aarch64)?);
        }
        return Ok(());
    }
    out.push(parse_section_item(tok, rest, is_aarch64)?);
    Ok(())
}

/// A bare section directive naming a well-known section (`.text` == `.section
/// .text`). GNU as accepts these shorthands; file-scope asm uses them to place
/// a trampoline body. The dotted-suffix form is not a shorthand.
fn base_section_shorthand(tok: &str) -> bool {
    matches!(
        tok,
        ".text" | ".data" | ".data1" | ".sdata" | ".rodata" | ".bss" | ".sbss"
    )
}

fn extract_asm_sections_impl(
    text: &str,
    is_aarch64: bool,
    file_scope: bool,
) -> Result<Option<AsmExtract>, alloc::string::String> {
    if !file_scope
        && !text.contains(".pushsection")
        && !text.contains(".section")
        && !text.contains(".subsection")
        && !asm_text_has_sym_directive(text)
    {
        return Ok(None);
    }
    let mut code = alloc::string::String::with_capacity(text.len());
    let mut sym_items: alloc::vec::Vec<AsmSectionItem> = alloc::vec::Vec::new();
    let mut blocks: alloc::vec::Vec<AsmSectionBlock> = alloc::vec::Vec::new();
    // Stack of indices into `blocks`; `None` is the code stream. File-scope asm
    // has no code stream: the base is a `.text` section from the start.
    let mut stack: alloc::vec::Vec<Option<usize>> = if file_scope {
        blocks.push(parse_section_args(".text")?);
        alloc::vec![Some(0)]
    } else {
        alloc::vec![None]
    };
    // The section left by the most recent change of any kind. GNU as keeps
    // this slot beside the `.pushsection` stack and `.previous` swaps the two,
    // so a `.section` / `.previous` pair nested inside a pushed region returns
    // to the pushed section rather than unwinding the stack.
    let mut prev_top: Option<Option<usize>> = None;
    // Encoding mode over the linear input, and the mode each block was
    // last told about.
    let mut code_mode: Option<&str> = None;
    let mut block_code_mode: alloc::collections::BTreeMap<usize, &str> =
        alloc::collections::BTreeMap::new();
    // Open `.rept` bodies of the current section; items nest into the top
    // until `.endr` closes it into a `Rept` item.
    let mut rept_stack: alloc::vec::Vec<(alloc::string::String, alloc::vec::Vec<AsmSectionItem>)> =
        alloc::vec::Vec::new();
    // Arms of an open deferred conditional; `None` outside one.
    let mut cond_arms: Option<alloc::vec::Vec<AsmCondArm>> = None;
    for piece in split_asm_statements(text) {
        let piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // Peel any leading `name:` labels: GNU as treats them as statements
        // preceding the rest of the line, so a section directive or an
        // instruction may follow a label on the same line, with or without
        // whitespace after the colon (`1:\t.pushsection ...`, `name:push %rcx`).
        // A label goes to the current stream; a leading token that is not a
        // valid label is left in place as the statement.
        let mut stmt = piece;
        while let Some((name, rest)) = peel_leading_label(stmt) {
            if !rept_stack.is_empty() {
                return Err(alloc::format!(
                    "inline asm: label `{name}` inside `.rept` would be defined repeatedly"
                ));
            }
            match *stack.last().unwrap() {
                None => {
                    code.push_str(name);
                    code.push_str(":\n");
                }
                Some(idx) => blocks[idx]
                    .items
                    .push(AsmSectionItem::Label(alloc::string::String::from(name))),
            }
            stmt = rest;
        }
        if stmt.is_empty() {
            continue;
        }
        let (tok, rest) = split_first_token(stmt);
        // A `.rept` body collects items until its `.endr`; section switches
        // inside it have no GNU as meaning worth carrying.
        if !rept_stack.is_empty() {
            match tok {
                ".endr" => {
                    let (count, items) = rept_stack.pop().expect("nonempty checked");
                    let item = AsmSectionItem::Rept { count, items };
                    match rept_stack.last_mut() {
                        Some((_, outer)) => outer.push(item),
                        None => match *stack.last().unwrap() {
                            Some(idx) => blocks[idx].items.push(item),
                            None => {
                                return Err(alloc::string::String::from(
                                    "inline asm: `.rept` outside a section",
                                ));
                            }
                        },
                    }
                }
                ".rept" | ".rep" => {
                    rept_stack.push((alloc::string::String::from(rest), alloc::vec::Vec::new()))
                }
                ".pushsection" | ".section" | ".popsection" | ".previous" | ".subsection" => {
                    return Err(alloc::format!(
                        "inline asm: `{tok}` inside `.rept` is not supported"
                    ));
                }
                _ => {
                    let item = parse_section_item(tok, rest, is_aarch64)?;
                    rept_stack
                        .last_mut()
                        .expect("nonempty checked")
                        .1
                        .push(item);
                }
            }
            continue;
        }
        // A conditional the expansion deferred: its condition reads section
        // labels and its branches emit no bytes, so the arms accumulate into
        // one item the layout values.
        if let Some(arms) = &mut cond_arms {
            match tok {
                ".endif" => {
                    let item = AsmSectionItem::CondDiag(core::mem::take(arms));
                    cond_arms = None;
                    match *stack.last().unwrap() {
                        Some(idx) => blocks[idx].items.push(item),
                        None => {
                            return Err(alloc::string::String::from(
                                "inline asm: `.if` outside a section",
                            ));
                        }
                    }
                }
                ".else" | ".elseif" => arms.push(AsmCondArm {
                    tok: alloc::string::String::from(if tok == ".else" { "" } else { ".if" }),
                    cond: alloc::string::String::from(rest.trim()),
                    error: None,
                }),
                ".error" => {
                    let arm = arms.last_mut().expect("an arm is open");
                    if arm.error.is_none() {
                        arm.error =
                            Some(alloc::string::String::from(rest.trim().trim_matches('"')));
                    }
                }
                _ => {
                    return Err(alloc::format!(
                        "inline asm: `{tok}` inside a conditional over section labels would emit bytes"
                    ));
                }
            }
            continue;
        }
        if matches!(
            tok,
            ".if" | ".ifeq" | ".ifne" | ".ifgt" | ".iflt" | ".ifge" | ".ifle"
        ) {
            cond_arms = Some(alloc::vec![AsmCondArm {
                tok: alloc::string::String::from(tok),
                cond: alloc::string::String::from(rest.trim()),
                error: None,
            }]);
            continue;
        }
        if matches!(tok, ".rept" | ".rep") && (*stack.last().unwrap()).is_some() {
            rept_stack.push((alloc::string::String::from(rest), alloc::vec::Vec::new()));
            continue;
        }
        match tok {
            ".pushsection" | ".section" => {
                let block = parse_section_args(rest)?;
                let idx = blocks.len();
                blocks.push(block);
                prev_top = Some(*stack.last().unwrap());
                if tok == ".pushsection" {
                    stack.push(Some(idx));
                } else {
                    *stack.last_mut().unwrap() = Some(idx);
                }
                continue;
            }
            ".popsection" => {
                if stack.len() < 2 {
                    return Err(alloc::string::String::from(
                        "inline asm: `.popsection` without `.pushsection`",
                    ));
                }
                prev_top = Some(*stack.last().unwrap());
                stack.pop();
                continue;
            }
            ".previous" => {
                match prev_top {
                    Some(p) => {
                        prev_top = Some(*stack.last().unwrap());
                        *stack.last_mut().unwrap() = p;
                    }
                    // Nothing was left yet. A function-body template starts in
                    // the code stream, which is where `.previous` returns to;
                    // file-scope asm has no code stream, so the current
                    // section stands.
                    None if !file_scope => stack[0] = None,
                    None => {}
                }
                continue;
            }
            // File-scope base-section shorthands (`.text`, `.data`, ...): switch
            // the current base to that section, reusing an existing block of the
            // same name so repeated switches accumulate into one section.
            _ if file_scope && base_section_shorthand(tok) => {
                let idx = match blocks
                    .iter()
                    .position(|b| b.name == tok && b.subsection == 0)
                {
                    Some(i) => i,
                    None => {
                        blocks.push(parse_section_args(tok)?);
                        blocks.len() - 1
                    }
                };
                prev_top = Some(*stack.last().unwrap());
                *stack.last_mut().unwrap() = Some(idx);
                continue;
            }
            // `.subsection N` switches to the numbered subsection of the
            // current section: same identity and address space, laid out
            // after every lower-numbered block. The function-body path
            // handles its ALTERNATIVE `.subsection` in the deferred-region
            // splitter before extraction; one reaching here is rejected
            // rather than emitted inline (both sequences would execute).
            ".subsection" => {
                if !file_scope {
                    return Err(alloc::string::String::from(
                        "inline asm: `.subsection` is not supported (deferred replacement code)",
                    ));
                }
                let n: u32 = rest
                    .trim()
                    .parse()
                    .map_err(|_| alloc::format!("inline asm: bad `.subsection` number `{rest}`"))?;
                let cur = stack
                    .last()
                    .unwrap()
                    .expect("file scope always in a section");
                let (name, flags, sh_type) = (
                    blocks[cur].name.clone(),
                    blocks[cur].flags.clone(),
                    blocks[cur].sh_type.clone(),
                );
                blocks.push(AsmSectionBlock {
                    name,
                    flags,
                    sh_type,
                    subsection: n,
                    items: alloc::vec::Vec::new(),
                });
                let idx = blocks.len() - 1;
                prev_top = Some(Some(cur));
                *stack.last_mut().unwrap() = Some(idx);
                continue;
            }
            _ => {}
        }
        match *stack.last().unwrap() {
            // A symbol directive names a symbol of the unit, not a location in
            // the stream it sits in, so it leaves the code stream here as it
            // leaves the instruction stream of a section.
            None if is_asm_sym_directive(tok) => {
                push_sym_directive_items(tok, rest, is_aarch64, &mut sym_items)?;
            }
            // The remaining statement is an instruction, kept verbatim for the
            // arch backend to encode.
            None => {
                code.push_str(stmt);
                code.push('\n');
            }
            // GNU as assembles instructions in any section (the x86 ALTERNATIVE
            // replacement in an `"ax"` section, a trampoline body in
            // `.rodata`); the section flags set the object section's
            // attributes, not whether code is admitted.
            Some(idx) => {
                // `.code16` / `.code32` / `.code64` is assembler state over the
                // linear input, not a property of a section: GNU as keeps it
                // across section switches. Blocks accumulate per section name,
                // so re-entering one re-asserts the mode in effect.
                if is_code_mode_directive(tok) {
                    code_mode = Some(tok);
                    block_code_mode.insert(idx, tok);
                } else if let Some(m) = code_mode
                    && block_code_mode.get(&idx) != Some(&m)
                {
                    blocks[idx]
                        .items
                        .push(AsmSectionItem::Code(alloc::string::String::from(m)));
                    block_code_mode.insert(idx, m);
                }
                push_sym_directive_items(tok, rest, is_aarch64, &mut blocks[idx].items)?;
            }
        }
    }
    if !rept_stack.is_empty() {
        return Err(alloc::string::String::from(
            "inline asm: `.rept` without `.endr`",
        ));
    }
    Ok(Some(AsmExtract {
        code,
        blocks,
        sym_items,
    }))
}

/// Whether a directive selects the x86 encoding mode.
fn is_code_mode_directive(tok: &str) -> bool {
    matches!(tok, ".code16" | ".code32" | ".code64")
}

/// Parse the argument list of `.pushsection` / `.section`:
/// `name[,"flags"[,@type]]`.
fn parse_section_args(rest: &str) -> Result<AsmSectionBlock, alloc::string::String> {
    let mut parts = rest.split(',').map(str::trim);
    // The name may be quoted (`.section ".export_symbol","a"`); the quotes
    // are syntax, not part of the section name.
    let name = parts
        .next()
        .map(|n| {
            n.strip_prefix('"')
                .and_then(|n| n.strip_suffix('"'))
                .unwrap_or(n)
        })
        .filter(|n| !n.is_empty())
        .ok_or_else(|| alloc::string::String::from("inline asm: section name expected"))?;
    let mut flags = alloc::string::String::new();
    let mut sh_type = None;
    for p in parts {
        if let Some(f) = p.strip_prefix('"').and_then(|p| p.strip_suffix('"')) {
            flags = alloc::string::String::from(f);
        } else if let Some(t) = p.strip_prefix('@').or_else(|| p.strip_prefix('%')) {
            sh_type = Some(alloc::string::String::from(t));
        } else if parse_raw_int(p).is_some() {
            // The entsize of a `M`-flagged mergeable section
            // (`.rodata.str,"aMS",@progbits,1`). The merge/strings flags are
            // dropped for a relocatable object, so its entsize is too.
        } else if !p.is_empty() {
            return Err(alloc::format!("inline asm: bad section argument `{p}`"));
        }
    }
    if flags.is_empty() {
        flags = alloc::string::String::from(default_section_flags(name));
    }
    Ok(AsmSectionBlock {
        name: alloc::string::String::from(name),
        flags,
        sh_type,
        subsection: 0,
        items: alloc::vec::Vec::new(),
    })
}

/// GNU as default attributes for a well-known section name, used when the
/// directive gives no explicit `"flags"`. GNU as knows these names carry
/// allocation, write, and execute attributes; a `.pushsection .rodata`
/// without flags is allocatable, an unknown name defaults to none. The
/// match is exact or on the dotted-suffix form (`.rodata.str1.1`).
fn default_section_flags(name: &str) -> &'static str {
    // The leading `.` and first dotted component: `.rodata.str1.1` -> `.rodata`.
    let base = match name.get(1..).and_then(|r| r.find('.')) {
        Some(i) => &name[..1 + i],
        None => name,
    };
    match base {
        ".text" => "ax",
        ".rodata" => "a",
        ".data" | ".data1" | ".sdata" => "aw",
        ".bss" | ".sbss" => "aw",
        ".init_array" | ".fini_array" | ".preinit_array" => "aw",
        _ => "",
    }
}

/// Parse one directive inside a named section. A non-directive token is an
/// instruction kept as text for the arch backend to encode.
pub(crate) fn parse_section_item(
    tok: &str,
    rest: &str,
    is_aarch64: bool,
) -> Result<AsmSectionItem, alloc::string::String> {
    // `.inst`'s bytes are an instruction, not a data directive.
    if tok == INST_BYTES_DIRECTIVE {
        let mut bytes = alloc::vec::Vec::new();
        for arg in split_top_commas(rest) {
            bytes.push(
                eval_const_expr(arg).ok_or_else(|| {
                    alloc::format!("inline asm: `.inst` byte `{arg}` is not constant")
                })? as u8,
            );
        }
        return Ok(AsmSectionItem::CodeBytes {
            bytes,
            relocs: alloc::vec::Vec::new(),
            short: None,
        });
    }
    if let Some(w) = data_directive_width(tok) {
        // `.word` is target-dependent: 2 bytes on x86 ELF, 4 on AArch64.
        let w = if tok == ".word" && is_aarch64 { 4 } else { w };
        let mut values = alloc::vec::Vec::new();
        // Split the value list on commas outside double quotes (a quoted
        // symbol name may contain any character).
        let (mut start, mut quoted) = (0usize, false);
        for (i, c) in rest.bytes().enumerate() {
            match c {
                b'"' => quoted = !quoted,
                b',' if !quoted => {
                    values.push(parse_section_value(rest[start..i].trim())?);
                    start = i + 1;
                }
                _ => {}
            }
        }
        values.push(parse_section_value(rest[start..].trim())?);
        return Ok(AsmSectionItem::Data {
            width: w as u8,
            values,
        });
    }
    if let Some((kind, width)) = align_directive(tok) {
        return parse_align_item(kind, width, rest, is_aarch64);
    }
    match tok {
        ".org" => {
            // `.org new-lc[, fill]`. The fill byte is the last top-level
            // comma-separated argument; the origin keeps the rest, which is
            // itself an expression and may contain commas in no other form.
            let parts = split_top_commas(rest);
            let (rest, fill) = match parts.as_slice() {
                [_] => (rest, 0u8),
                [org, f] => {
                    let v = eval_const_expr(f)
                        .ok_or_else(|| alloc::format!("inline asm: bad `.org` fill `{f}`"))?;
                    (*org, v as u8)
                }
                _ => return Err(alloc::format!("inline asm: bad `.org` operands `{rest}`")),
            };
            let rest = rest.trim();
            if let Some(n) = parse_raw_int(rest).filter(|&n| n >= 0) {
                return Ok(AsmSectionItem::Org(n as u32, fill));
            }
            // `.org label + expr`: the target is a section-local label's offset
            // plus a constant. Split on the first `+`; the label must be a
            // backward numeric reference or a symbol name. `.` is the location
            // counter, not a symbol, so it takes the expression form below.
            let (label, addend) = rest
                .split_once('+')
                .map(|(l, r)| (l.trim(), r.trim()))
                .unwrap_or((rest, "0"));
            if label != "." && (numeric_label_digits(label).is_some() || is_asm_symbol_name(label))
            {
                return Ok(AsmSectionItem::OrgLabel {
                    label: alloc::string::String::from(label),
                    addend: alloc::string::String::from(addend),
                    fill,
                });
            }
            // A general location expression, deferred to layout.
            let probe = AsmExprCtx {
                resolve: &|_| Some(AsmExprLeaf::Abs(1)),
                const_of: &|_| Some(1),
                lax_div: true,
            };
            if eval_asm_value(rest, &probe).is_ok() {
                return Ok(AsmSectionItem::OrgExpr(
                    alloc::string::String::from(rest),
                    fill,
                ));
            }
            Err(alloc::format!("inline asm: bad `.org` offset `{rest}`"))
        }
        // The space-and-fill family. `.skip` and `.space` are the same
        // directive on ELF targets; `.zero` fixes the fill at zero; `.fill`
        // repeats a multi-byte unit.
        ".skip" | ".space" | ".zero" | ".fill" => parse_fill_directive(tok, rest),
        ".ascii" | ".asciz" | ".string" => parse_string_directive(tok, rest),
        ".globl" | ".global" => {
            let name = rest.trim();
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`"));
            }
            Ok(AsmSectionItem::Global(alloc::string::String::from(name)))
        }
        // `.ltorg` flushes the AArch64 literal pool accumulated since the
        // previous flush. The arch backend fills the entries in before
        // layout; on a target without a pool the directive deposits nothing.
        ".ltorg" if is_aarch64 => Ok(AsmSectionItem::LiteralPool(alloc::vec::Vec::new())),
        // Assembler-state directives with no effect on the emitted object:
        // `.extern` declares what an unresolved name already is; the arch
        // selectors admit no more than the encoder's table does. `.loc`
        // names a source location for the debug line table, which badc
        // does not emit for asm bodies.
        ".extern" | ".arch" | ".arch_extension" | ".cpu" | ".ltorg" | ".loc" => {
            Ok(AsmSectionItem::Bytes(alloc::vec::Vec::new()))
        }
        // `.file "name"` names the unit's STT_FILE symbol; the numbered
        // DWARF form is line-table input like `.loc` and deposits nothing.
        ".file" => {
            if rest.trim_start().starts_with('"') {
                Ok(AsmSectionItem::File(parse_quoted_text(tok, rest)?))
            } else {
                Ok(AsmSectionItem::Bytes(alloc::vec::Vec::new()))
            }
        }
        ".ident" => Ok(AsmSectionItem::Ident(parse_quoted_text(tok, rest)?)),
        // `.cfi_*` describes unwind state to a DWARF consumer and deposits no
        // bytes in this section; it is carried to the frame-table builder,
        // which pairs it with the offset the materializer reaches it at.
        _ if tok.starts_with(".cfi_") => {
            // A frame operand is absolute: no leaf resolves, so an
            // expression naming a label folds to nothing and is rejected.
            let ctx = AsmExprCtx {
                resolve: &|_| None,
                const_of: &|_| None,
                lax_div: false,
            };
            let eval = |s: &str| eval_asm_value(s, &ctx).ok().and_then(|v| v.to_abs());
            match cfi::parse_cfi_directive(tok, rest, &eval) {
                Ok(Some(op)) => Ok(AsmSectionItem::Cfi(op)),
                Ok(None) => Ok(AsmSectionItem::Bytes(alloc::vec::Vec::new())),
                Err(m) => Err(alloc::format!("inline asm: {m}")),
            }
        }
        // `.code16` / `.code32` / `.code64` select the x86 encoding mode for
        // the instructions that follow. The directive deposits no bytes; it
        // reaches the arch backend as a code item, which reads it as the
        // encoder state the rest of the stream assembles under.
        ".code16" | ".code32" | ".code64" if !is_aarch64 => {
            Ok(AsmSectionItem::Code(alloc::string::String::from(tok)))
        }
        ".weak" => {
            let name = rest.trim();
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`"));
            }
            Ok(AsmSectionItem::Weak(alloc::string::String::from(name)))
        }
        ".local" => {
            let name = rest.trim();
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`"));
            }
            Ok(AsmSectionItem::Local(alloc::string::String::from(name)))
        }
        ".hidden" | ".internal" | ".protected" => {
            let name = rest.trim();
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`"));
            }
            use crate::c5::program::SymVisibility;
            let vis = match tok {
                ".internal" => SymVisibility::Internal,
                ".protected" => SymVisibility::Protected,
                _ => SymVisibility::Hidden,
            };
            Ok(AsmSectionItem::Visibility {
                name: alloc::string::String::from(name),
                vis,
            })
        }
        ".reloc" => parse_reloc_directive(rest),
        // A `.set` / `.equ` names a symbol (`.set alias, target`, a unit-level
        // alias), an absolute value (a constant the expander re-emitted for a
        // name with external linkage), or an expression over section-local
        // locations (`.set .Lsz, . - f`). `.equiv` assigns the same way and
        // adds a redefinition error. TODO diagnose a redefinition.
        ".set" | ".equ" | ".equiv" => {
            // `.set ., expr` moves the location counter, as `.org` does; the
            // kernel's exception-vector table places its entries that way.
            if let Some(v) = rest.trim_start().strip_prefix('.')
                && let Some(v) = v.trim_start().strip_prefix(',')
            {
                return parse_section_item(".org", v.trim(), is_aarch64);
            }
            let (name, value) = rest
                .split_once(',')
                .map(|(n, t)| (n.trim(), t.trim()))
                .filter(|(n, t)| is_asm_symbol_name(n) && !t.is_empty())
                .ok_or_else(|| alloc::format!("inline asm: `{tok} {rest}` is not `name, value`"))?;
            let name = alloc::string::String::from(name);
            // `.set name, .` values the location counter, not an alias.
            if is_asm_symbol_name(value) && value != "." {
                return Ok(AsmSectionItem::SymSet {
                    name,
                    target: alloc::string::String::from(value),
                });
            }
            if let Some(v) = parse_raw_int(value) {
                return Ok(AsmSectionItem::AbsSet { name, value: v });
            }
            Ok(AsmSectionItem::SetExpr {
                name,
                expr: alloc::string::String::from(value),
            })
        }
        ".incbin" => parse_incbin_directive(rest),
        ".type" => parse_type_directive(rest),
        ".size" => parse_size_directive(rest),
        // `name = expr` in a section is the assignment spelling of `.set`
        // (the piggyback length constants). The expander folds the constant
        // form it sees; one reaching here carries an expression or a symbol.
        _ if !tok.starts_with('.')
            && (rest.starts_with('=') && !rest.starts_with("==")
                || tok
                    .split_once('=')
                    .is_some_and(|(n, e)| is_asm_symbol_name(n) && !e.starts_with('='))) =>
        {
            let (name, expr) = match rest.strip_prefix('=') {
                Some(e) => (tok, alloc::string::String::from(e.trim())),
                None => {
                    let (n, e) = tok.split_once('=').expect("guard admits an assignment");
                    (n, alloc::format!("{} {rest}", e.trim()))
                }
            };
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad assignment `{tok} {rest}`"));
            }
            let expr = alloc::string::String::from(expr.trim());
            if is_asm_symbol_name(&expr) && expr != "." {
                return Ok(AsmSectionItem::SymSet {
                    name: alloc::string::String::from(name),
                    target: expr,
                });
            }
            Ok(AsmSectionItem::SetExpr {
                name: alloc::string::String::from(name),
                expr,
            })
        }
        // A non-directive token is an instruction: the ALTERNATIVE replacement
        // in `.altinstr_replacement,"ax"`, or a trampoline body assembled into
        // `.rodata`. Keep it as text; the arch backend encodes it to bytes and
        // relocations. A token spelled as a directive (`.`-prefixed) that is
        // not recognized is rejected below.
        _ if !tok.starts_with('.') => {
            let line = if rest.is_empty() {
                alloc::string::String::from(tok)
            } else {
                alloc::format!("{tok} {rest}")
            };
            Ok(AsmSectionItem::Code(line))
        }
        _ => Err(alloc::format!(
            "inline asm: unsupported directive `{tok}` in a named section"
        )),
    }
}

/// Parse the space-and-fill family into a single repetition item.
///
/// `.skip count[, fill]` and `.space count[, fill]` repeat one fill byte
/// (zero by default). `.zero count` fixes the fill at zero. `.fill
/// repeat[, size[, value]]` repeats the low `size` bytes of `value`, with
/// `size` defaulting to one and clamped to eight as GNU as does. The count is
/// kept as an expression: it may reference an operand constant, and is
/// resolved once the operand values are known.
pub(crate) fn parse_fill_operands<'a>(
    tok: &str,
    rest: &'a str,
) -> Result<(&'a str, u8, u32), alloc::string::String> {
    let mut fields = rest.split(',').map(str::trim);
    let count = fields.next().unwrap_or("").trim();
    if count.is_empty() {
        return Err(alloc::format!("inline asm: `{tok}` needs a count"));
    }
    let num = |f: Option<&str>| -> Result<Option<i64>, alloc::string::String> {
        match f {
            Some(s) if !s.is_empty() => Ok(Some(parse_raw_int(s).ok_or_else(|| {
                alloc::format!("inline asm: `{tok}` operand `{s}` is not a constant")
            })?)),
            _ => Ok(None),
        }
    };
    let (unit, value) = match tok {
        ".fill" => {
            let size = num(fields.next())?.unwrap_or(1);
            if size < 0 {
                return Err(alloc::format!("inline asm: bad `.fill` size `{size}`"));
            }
            // GNU as clamps a unit above eight rather than rejecting it.
            (size.min(8) as u8, num(fields.next())?.unwrap_or(0) as u32)
        }
        ".zero" => (1u8, 0u32),
        _ => (1u8, num(fields.next())?.unwrap_or(0) as u32 & 0xff),
    };
    if fields.next().is_some() {
        return Err(alloc::format!("inline asm: too many `{tok}` operands"));
    }
    Ok((count, unit, value))
}

/// True for a directive of the space-and-fill family.
pub(crate) fn is_fill_directive(tok: &str) -> bool {
    matches!(tok, ".skip" | ".space" | ".zero" | ".fill")
}

/// `.ascii` / `.asciz` / `.string`: a comma-separated list of string
/// operands. Adjacent literals within one operand concatenate; `.asciz` and
/// `.string` append one NUL per operand, `.ascii` appends none (GNU as).
/// Escapes are the assembler's: the C parse already consumed one level, so
/// `\\n` in source arrives here as `\n`.
/// The text of a directive taking one quoted string (`.file`, `.ident`),
/// with GNU as escape processing.
fn parse_quoted_text(
    tok: &str,
    rest: &str,
) -> Result<alloc::string::String, alloc::string::String> {
    match parse_string_directive(".ascii", rest) {
        Ok(AsmSectionItem::Bytes(b)) => Ok(alloc::string::String::from_utf8_lossy(&b).into_owned()),
        Ok(_) => unreachable!(),
        Err(_) => Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`")),
    }
}

pub(crate) fn parse_string_directive(
    tok: &str,
    rest: &str,
) -> Result<AsmSectionItem, alloc::string::String> {
    let b = rest.as_bytes();
    let mut bytes: alloc::vec::Vec<u8> = alloc::vec::Vec::new();
    let mut i = 0usize;
    let skip_ws = |i: &mut usize| {
        while *i < b.len() && b[*i].is_ascii_whitespace() {
            *i += 1;
        }
    };
    loop {
        // One operand: one or more adjacent string literals.
        let mut any = false;
        loop {
            skip_ws(&mut i);
            if b.get(i) != Some(&b'"') {
                break;
            }
            i += 1;
            loop {
                let c = *b.get(i).ok_or_else(|| {
                    alloc::format!("inline asm: unterminated string in `{tok} {rest}`")
                })?;
                i += 1;
                match c {
                    b'"' => break,
                    b'\\' => {
                        let e = *b.get(i).ok_or_else(|| {
                            alloc::format!("inline asm: unterminated escape in `{tok} {rest}`")
                        })?;
                        i += 1;
                        match e {
                            b'n' => bytes.push(b'\n'),
                            b't' => bytes.push(b'\t'),
                            b'r' => bytes.push(b'\r'),
                            b'b' => bytes.push(8),
                            b'f' => bytes.push(12),
                            // Up to three octal digits.
                            b'0'..=b'7' => {
                                let mut v = (e - b'0') as u32;
                                for _ in 0..2 {
                                    match b.get(i) {
                                        Some(&d @ b'0'..=b'7') => {
                                            v = v * 8 + (d - b'0') as u32;
                                            i += 1;
                                        }
                                        _ => break,
                                    }
                                }
                                bytes.push(v as u8);
                            }
                            b'x' => {
                                // GNU as folds any run of hex digits mod 256.
                                let mut v = 0u32;
                                let mut n = 0;
                                while let Some(d) = b.get(i).and_then(|c| (*c as char).to_digit(16))
                                {
                                    v = (v * 16 + d) & 0xff;
                                    i += 1;
                                    n += 1;
                                }
                                if n == 0 {
                                    return Err(alloc::format!(
                                        "inline asm: `\\x` without hex digits in `{tok} {rest}`"
                                    ));
                                }
                                bytes.push(v as u8);
                            }
                            // `\"`, `\\`, and any other escape: the character.
                            _ => bytes.push(e),
                        }
                    }
                    _ => bytes.push(c),
                }
            }
            any = true;
        }
        if !any {
            return Err(alloc::format!(
                "inline asm: string literal expected in `{tok} {rest}`"
            ));
        }
        if tok != ".ascii" {
            bytes.push(0);
        }
        skip_ws(&mut i);
        match b.get(i) {
            None => break,
            Some(b',') => i += 1,
            Some(_) => {
                return Err(alloc::format!(
                    "inline asm: junk after string in `{tok} {rest}`"
                ));
            }
        }
    }
    Ok(AsmSectionItem::Bytes(bytes))
}

fn parse_fill_directive(tok: &str, rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let (count, unit, value) = parse_fill_operands(tok, rest)?;
    Ok(AsmSectionItem::Fill {
        count: alloc::string::String::from(count),
        unit,
        value,
    })
}

/// Resolve a `.skip` / `.fill` repetition count. A negative count emits
/// nothing, as GNU as does for `.skip` of a negative expression.
pub(crate) fn eval_fill_count(
    expr: &str,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<i64, alloc::string::String> {
    let n = eval_asm_count(expr, const_of).ok_or_else(|| {
        alloc::format!("inline asm: fill count `{expr}` is not a constant expression")
    })?;
    Ok(n.max(0))
}

/// Fill-count evaluation with label leaves resolved through `resolve`
/// (section-relative offsets, so same-section differences fold) and the
/// location counter `.` at section offset `here` (`.fill sym - ., 1, 0xcc`
/// pads to a label).
pub(crate) fn eval_fill_count_with(
    expr: &str,
    here: i64,
    const_of: &dyn Fn(u8) -> Option<i64>,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> Option<i64> {
    let leaf = |t: &str| {
        if t == "." {
            return Some(AsmExprLeaf::Abs(here));
        }
        resolve(t).map(AsmExprLeaf::Abs)
    };
    let ctx = AsmExprCtx {
        resolve: &leaf,
        const_of,
        lax_div: false,
    };
    eval_asm_value(expr, &ctx).ok().and_then(|v| v.to_abs())
}

/// Append `count` repetitions of one fill unit: the low `unit` bytes of the
/// value zero-extended to eight, little-endian, as GNU as renders it.
pub(crate) fn push_fill(out: &mut alloc::vec::Vec<u8>, count: i64, unit: u8, value: u32) {
    let bytes = (value as u64).to_le_bytes();
    for _ in 0..count {
        out.extend_from_slice(&bytes[..unit as usize]);
    }
}

/// Split a directive's leading symbol name from the rest of its operands.
/// GNU as ends the name at the first non-symbol character and then skips one
/// optional comma, so `name, rest` and `name rest` are the same input.
fn split_symbol_operand(rest: &str) -> (&str, &str) {
    let rest = rest.trim();
    let end = rest
        .find(|c: char| !(c.is_ascii_alphanumeric() || matches!(c, '_' | '.' | '$')))
        .unwrap_or(rest.len());
    let (name, tail) = rest.split_at(end);
    let tail = tail.trim_start();
    (name, tail.strip_prefix(',').unwrap_or(tail).trim())
}

/// `.type name[,] type`. GNU as makes the comma optional and reads the type
/// word bare or behind one `@` / `%` / `#` / `"` sigil, so `.type f STT_FUNC`
/// and `.type f, @function` name the same type. Each ELF type has a bare and
/// an `STT_` spelling; badc's symbol model covers function, object, and
/// untyped, and any other type is rejected.
pub(crate) fn parse_type_directive(rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let (name, ty) = split_symbol_operand(rest);
    if !is_asm_symbol_name(name) {
        return Err(alloc::format!("inline asm: bad `.type` symbol `{name}`"));
    }
    if ty.is_empty() {
        return Err(alloc::format!(
            "inline asm: `.type` expects `name, @type`, got `{rest}`"
        ));
    }
    let word = ty
        .strip_prefix(['@', '%', '#', '"'])
        .unwrap_or(ty)
        .trim_end_matches('"');
    let sym_type = match word {
        "function" | "STT_FUNC" => AsmSymType::Func,
        "object" | "STT_OBJECT" => AsmSymType::Object,
        "notype" | "STT_NOTYPE" => AsmSymType::NoType,
        _ => return Err(alloc::format!("inline asm: unsupported `.type` `{ty}`")),
    };
    Ok(AsmSectionItem::Type {
        name: alloc::string::String::from(name),
        sym_type,
    })
}

/// `.size name, expr`. The expression is a byte count evaluated at
/// materialize time; parsing keeps it as text since label offsets are not
/// yet known.
fn parse_size_directive(rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let (name, expr) = rest
        .split_once(',')
        .ok_or_else(|| alloc::format!("inline asm: `.size` expects `name, expr`, got `{rest}`"))?;
    let name = name.trim();
    let expr = expr.trim();
    if !is_asm_symbol_name(name) {
        return Err(alloc::format!("inline asm: bad `.size` symbol `{name}`"));
    }
    if expr.is_empty() {
        return Err(alloc::string::String::from(
            "inline asm: empty `.size` expression",
        ));
    }
    Ok(AsmSectionItem::Size {
        name: alloc::string::String::from(name),
        expr: alloc::string::String::from(expr),
    })
}

/// `.incbin "path"[, skip[, count]]`: splice the named file's raw bytes at
/// this point in the section image. The path resolves as GNU as resolves it,
/// against the assembler's working directory; badc compiles from the same
/// directory, so a relative path reads relative to the compile cwd.
fn parse_incbin_directive(rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let rest = rest.trim();
    let (path, args) = rest
        .strip_prefix('"')
        .and_then(|r| r.split_once('"'))
        .ok_or_else(|| {
            alloc::format!("inline asm: `.incbin` expects a quoted path, got `{rest}`")
        })?;
    let args = args.trim().trim_start_matches(',').trim();
    if !args.is_empty() {
        // TODO `.incbin` skip / count arguments.
        return Err(alloc::format!(
            "inline asm: `.incbin` skip/count arguments are not supported (`{rest}`)"
        ));
    }
    #[cfg(feature = "std")]
    {
        let bytes = std::fs::read(path).map_err(|e| {
            let resolved = std::env::current_dir()
                .map(|d| d.join(path).display().to_string())
                .unwrap_or_else(|_| alloc::string::String::from(path));
            alloc::format!("inline asm: `.incbin \"{path}\"`: cannot read `{resolved}`: {e}")
        })?;
        Ok(AsmSectionItem::Bytes(bytes))
    }
    #[cfg(not(feature = "std"))]
    {
        Err(alloc::format!(
            "inline asm: `.incbin \"{path}\"` needs host filesystem access"
        ))
    }
}

/// If `s` is a single parenthesised group (the leading `(` matches the
/// trailing `)`), return its interior; otherwise `None`.
fn enclosed_by_parens(s: &str) -> Option<&str> {
    let b = s.as_bytes();
    if b.first() != Some(&b'(') || b.last() != Some(&b')') {
        return None;
    }
    let mut depth = 0u32;
    for (i, &c) in b.iter().enumerate() {
        match c {
            b'(' => depth += 1,
            b')' => depth = depth.checked_sub(1)?,
            _ => {}
        }
        if depth == 0 && i + 1 < b.len() {
            return None; // the leading paren closed before the end
        }
    }
    (depth == 0).then(|| s[1..s.len() - 1].trim())
}

/// Strip fully-enclosing parentheses from a label operand. `_ASM_EXTABLE`
/// wraps its label in parentheses (`.long (1b) - .`); the parentheses are
/// grouping, so `(1b)` names the same label as `1b`.
fn strip_label_parens(s: &str) -> &str {
    let mut s = s.trim();
    while let Some(inner) = enclosed_by_parens(s) {
        s = inner;
    }
    s
}

/// If `s` ends with `- .` (subtract the field's own position), return the
/// base expression before it; otherwise `None`.
fn strip_trailing_pcrel(s: &str) -> Option<&str> {
    let base = s
        .trim_end()
        .strip_suffix('.')?
        .trim_end()
        .strip_suffix('-')?;
    Some(base.trim_end())
}

/// Parse an operand / goto-label relocation value: a `%cN` operand address
/// or `%lN` goto label, with an optional `+ addend` constant expression and
/// `- .` PC-relative marker. Returns `None` when `a` is not such a form (a
/// bare `%cN` stays a constant operand handled by the caller).
fn parse_operand_reloc(a: &str) -> Option<Result<AsmSectionValue, alloc::string::String>> {
    // The operand reference may be wrapped in one paren and subtract the
    // field's own position (`.long (%l[label]) - .`, canonicalized to
    // `(%l0) - .`); the closing paren must follow the operand index.
    let (a, paren) = match a.trim().strip_prefix('(') {
        Some(r) => (r.trim_start(), true),
        None => (a, false),
    };
    let rest = a.strip_prefix('%')?;
    let (goto, rest) = if let Some(r) = rest.strip_prefix('l') {
        (true, r)
    } else {
        // `%c` / `%P` name an operand address; anything else is not this form.
        (
            false,
            rest.strip_prefix('c').or_else(|| rest.strip_prefix('P'))?,
        )
    };
    let end = rest
        .bytes()
        .position(|c| !c.is_ascii_digit())
        .unwrap_or(rest.len());
    let idx: u8 = rest.get(..end)?.parse().ok()?;
    let after = rest[end..].trim_start();
    let after = if paren {
        after.strip_prefix(')')?.trim_start()
    } else {
        after
    };
    let (tail, pcrel) = match strip_trailing_pcrel(after.trim()) {
        Some(base) => (base, true),
        None => (after.trim(), false),
    };
    // A `%l` goto label always relocates; a `%c` operand only when it is
    // PC-relative or carries an addend (a bare `%cN` is a plain constant).
    let addend = match tail.strip_prefix('+') {
        Some(rest) => rest.trim(),
        None if tail.is_empty() => "",
        None => return None,
    };
    if !goto && !pcrel && addend.is_empty() {
        return None;
    }
    Some(Ok(AsmSectionValue::OperandReloc {
        idx,
        goto,
        addend: alloc::string::String::from(addend),
        pcrel,
    }))
}

/// Parse one data-directive value: a constant, an operand reference, or
/// a label / symbol reference (optionally `- .` PC-relative).
pub(crate) fn parse_section_value(a: &str) -> Result<AsmSectionValue, alloc::string::String> {
    if let Some(v) = eval_const_expr_wide(a) {
        return Ok(AsmSectionValue::Const(v));
    }
    // A fully-enclosing parenthesis group is grouping only; strip it so
    // `((insn) - .)` (the aarch64 exception table) reduces like `(insn) - .`
    // and `(((x)))` like `x`. A group that closes before the end
    // (`(a) - (b)`, `(1 << 15) | (%0)`) is left for the handling below.
    let a = strip_label_parens(a);
    // `%c0 - .` / `%c0 + %c1 - .` / `%l0 - .`: a relocation to an operand's
    // link-time address or an `asm goto` label.
    if let Some(v) = parse_operand_reloc(a) {
        return v;
    }
    if let Some(rest) = a.strip_prefix('%') {
        let body = rest
            .strip_prefix('c')
            .or_else(|| rest.strip_prefix('P'))
            .unwrap_or(rest);
        if !body.is_empty() && body.bytes().all(|c| c.is_ascii_digit()) {
            let idx: u8 = body
                .parse()
                .map_err(|_| alloc::format!("inline asm: bad operand reference `{a}`"))?;
            return Ok(AsmSectionValue::OperandConst(idx));
        }
        return Err(alloc::format!("inline asm: bad section value `{a}`"));
    }
    // A constant expression mixing integer literals with `%N` operand
    // constants (`(1 << 15) | (%0)`); deferred as text and resolved at
    // materialize time. Label / symbol references are not constants and fall
    // through to the forms below.
    if a.contains('%') && eval_const_expr_ops(a, &|_| Some(0)).is_some() {
        return Ok(AsmSectionValue::Expr(alloc::string::String::from(a)));
    }
    // A relocatable expression: one symbolic base (a label or symbol) plus a
    // constant addend, optionally `- .` PC-relative; or `label_a - label_b`, a
    // constant distance.
    match parse_reloc_expr(a) {
        Ok(v) => Ok(v),
        // Anything richer defers to the location-value evaluator at
        // materialize time, when label offsets and the location counter are
        // known. Placeholder leaves check the syntax only.
        Err(e) => {
            let probe = AsmExprCtx {
                resolve: &|_| Some(AsmExprLeaf::Abs(1)),
                const_of: &|_| Some(1),
                lax_div: true,
            };
            match eval_asm_value(a, &probe) {
                Ok(_) => Ok(AsmSectionValue::LocExpr(alloc::string::String::from(a))),
                Err(_) => Err(e),
            }
        }
    }
}

/// Whether `s` has a `+` or `-` at parenthesis depth zero past its first byte:
/// a real additive split rather than a leading sign on a single leaf.
fn has_top_level_addsub(s: &str) -> bool {
    let mut depth = 0i32;
    for (i, &c) in s.as_bytes().iter().enumerate() {
        match c {
            b'(' => depth += 1,
            b')' => depth -= 1,
            b'+' | b'-' if depth == 0 && i > 0 => return true,
            _ => {}
        }
    }
    false
}

/// Append one additive term to `out`, distributing a `- ( ... )` sign into a
/// parenthesised sub-sum; a group wrapping a single leaf (`(1b)`) is unwrapped
/// and kept whole. Returns false on a malformed (empty) term.
fn push_reloc_term<'a>(
    term: &'a str,
    neg: bool,
    out: &mut alloc::vec::Vec<(bool, &'a str)>,
) -> bool {
    let t = term.trim();
    if t.is_empty() {
        return false;
    }
    if let Some(inner) = enclosed_by_parens(t)
        && has_top_level_addsub(inner)
    {
        return flatten_addsub_terms(inner, neg, out);
    }
    out.push((neg, strip_label_parens(t)));
    true
}

/// Flatten `s` into its additive terms, each tagged with whether it is
/// subtracted from the whole value. `outer_neg` is the sign inherited from an
/// enclosing `- ( ... )`. A double-quoted run is opaque (a quoted symbol name
/// may contain any character). Returns false on unbalanced parentheses or an
/// unterminated quote.
pub(crate) fn flatten_addsub_terms<'a>(
    s: &'a str,
    outer_neg: bool,
    out: &mut alloc::vec::Vec<(bool, &'a str)>,
) -> bool {
    let b = s.as_bytes();
    let mut i = 0usize;
    while i < b.len() && b[i].is_ascii_whitespace() {
        i += 1;
    }
    let mut neg = outer_neg ^ (b.get(i) == Some(&b'-'));
    if matches!(b.get(i), Some(b'+' | b'-')) {
        i += 1;
    }
    let (mut depth, mut start, mut quoted) = (0i32, i, false);
    while i < b.len() {
        match b[i] {
            b'"' => quoted = !quoted,
            _ if quoted => {}
            b'(' => depth += 1,
            b')' => {
                depth -= 1;
                if depth < 0 {
                    return false;
                }
            }
            b'+' | b'-' if depth == 0 => {
                if !push_reloc_term(&s[start..i], neg, out) {
                    return false;
                }
                neg = outer_neg ^ (b[i] == b'-');
                start = i + 1;
            }
            _ => {}
        }
        i += 1;
    }
    depth == 0 && !quoted && push_reloc_term(&s[start..], neg, out)
}

/// Parse a section data value as a relocatable expression: a single symbolic
/// base (a label or symbol) plus a constant addend that folds literals and
/// `%cN` operand constants, optionally `- .` PC-relative. Two bare labels with
/// no addend are a constant distance ([`AsmSectionValue::LabelDiff`]).
fn parse_reloc_expr(a: &str) -> Result<AsmSectionValue, alloc::string::String> {
    let unsupported = || alloc::format!("inline asm: unsupported expression `{a}`");
    let mut terms = alloc::vec::Vec::new();
    if !flatten_addsub_terms(a, false, &mut terms) {
        return Err(unsupported());
    }
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let is_name = |s: &str| !s.is_empty() && s.bytes().all(ident);
    // GNU as accepts a double-quoted symbol name wherever a bare one is
    // valid; the quotes are not part of the name.
    fn unquote(s: &str) -> Option<&str> {
        s.strip_prefix('"')
            .and_then(|r| r.strip_suffix('"'))
            .filter(|n| !n.is_empty() && !n.contains('"'))
    }
    // A term is a constant when it evaluates with the operand resolver treated
    // as present; a label or symbol reference does not.
    let is_const = |t: &str| eval_const_expr_ops(t, &|_| Some(0)).is_some();
    let (mut base, mut neg_name) = (None, None);
    let (mut names, mut dots) = (0usize, 0usize);
    let mut addend = alloc::string::String::new();
    for &(neg, t) in &terms {
        let (t, quoted) = match unquote(t) {
            Some(n) => (n, true),
            None => (t, false),
        };
        if quoted {
            names += 1;
            if neg {
                neg_name = Some(t);
            } else {
                base = Some(t);
            }
        } else if t == "." {
            dots += 1;
            if !neg {
                return Err(unsupported());
            }
        } else if is_const(t) {
            addend.push_str(if neg { " - " } else { " + " });
            addend.push_str(t);
        } else if is_name(t) {
            names += 1;
            if neg {
                neg_name = Some(t);
            } else {
                base = Some(t);
            }
        } else {
            return Err(alloc::format!("inline asm: bad section value `{t}`"));
        }
    }
    // `label_a - label_b`: a constant distance, no PC-relative term or addend.
    if names == 2
        && dots == 0
        && addend.is_empty()
        && let (Some(m), Some(s)) = (base, neg_name)
    {
        return Ok(AsmSectionValue::LabelDiff {
            minuend: alloc::string::String::from(m),
            subtrahend: alloc::string::String::from(s),
        });
    }
    // A single relocation base with a folded constant addend. `- .` marks it
    // PC-relative; the addend is prefixed with `0` so its leading sign parses.
    match base {
        Some(name) if names == 1 && dots <= 1 => Ok(AsmSectionValue::Ref {
            name: alloc::string::String::from(name),
            pcrel: dots == 1,
            addend: if addend.is_empty() {
                addend
            } else {
                alloc::format!("0{addend}")
            },
        }),
        _ => Err(unsupported()),
    }
}

/// Whether a signed constant fits a data-directive field of `width` bytes,
/// accepting either a signed or an unsigned reading (`-128..=255` for a byte,
/// and so on). An 8-byte field holds any `i64`.
pub(crate) fn value_fits_width(v: i64, width: u8) -> bool {
    let bits = width as u32 * 8;
    if bits >= 64 {
        return true;
    }
    let signed_min = -(1i64 << (bits - 1));
    let unsigned_max = (1i64 << bits) - 1;
    (signed_min..=unsigned_max).contains(&v)
}

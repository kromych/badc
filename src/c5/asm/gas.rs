//! The GNU as preprocessing layer: constant conditionals, `.macro` /
//! `.rept` / `.irp` expansion with their argument binding, and the
//! subsection split. Runs over the source text before it is parsed
//! into section items.

use super::*;

/// Resolve constant assembler conditionals (`.if` / `.elseif` / `.else` /
/// `.endif`), keeping only the taken branch. `.if <expr>` and `.ifeq` /
/// `.ifne` / `.ifgt` / `.iflt` / `.ifge` / `.ifle` test a constant expression;
/// a non-constant condition is an error. Returns `None` when the template has
/// no conditional. This runs before section extraction so a dropped branch
/// takes its `.pushsection` with it. Statements are the `;` / newline pieces
/// the rest of the pipeline splits on, rejoined with newlines.
pub(crate) fn strip_asm_conditionals(
    text: &str,
) -> Result<Option<alloc::string::String>, alloc::string::String> {
    if !text.contains(".if") {
        return Ok(None);
    }
    // Each open conditional: (this branch emits, some branch already taken).
    let mut stack: alloc::vec::Vec<(bool, bool)> = alloc::vec::Vec::new();
    let emitting = |st: &[(bool, bool)]| st.iter().all(|&(on, _)| on);
    let cond_of = |tok: &str, rest: &str| -> Result<bool, alloc::string::String> {
        let v = eval_asm_if_condition(rest)
            .ok_or_else(|| alloc::format!("inline asm: non-constant `{tok}` condition `{rest}`"))?;
        Ok(match tok {
            ".ifeq" => v == 0,
            ".ifne" | ".if" => v != 0,
            ".ifgt" => v > 0,
            ".iflt" => v < 0,
            ".ifge" => v >= 0,
            ".ifle" => v <= 0,
            _ => {
                return Err(alloc::format!(
                    "inline asm: unsupported conditional `{tok}`"
                ));
            }
        })
    };
    let mut out = alloc::string::String::with_capacity(text.len());
    for piece in split_asm_statements(text) {
        let trimmed = piece.trim();
        let (tok, rest) = match trimmed.find(char::is_whitespace) {
            Some(p) => (&trimmed[..p], trimmed[p..].trim()),
            None => (trimmed, ""),
        };
        match tok {
            ".if" | ".ifeq" | ".ifne" | ".ifgt" | ".iflt" | ".ifge" | ".ifle" => {
                let taken = emitting(&stack) && cond_of(tok, rest)?;
                stack.push((taken, taken));
            }
            ".elseif" => {
                let outer = emitting(&stack[..stack.len().saturating_sub(1)]);
                let frame = stack
                    .last_mut()
                    .ok_or("inline asm: `.elseif` without `.if`")?;
                let taken = outer && !frame.1 && cond_of(".if", rest)?;
                frame.0 = taken;
                frame.1 |= taken;
            }
            ".else" => {
                let outer = emitting(&stack[..stack.len().saturating_sub(1)]);
                let frame = stack
                    .last_mut()
                    .ok_or("inline asm: `.else` without `.if`")?;
                frame.0 = outer && !frame.1;
                frame.1 = true;
            }
            ".endif" => {
                stack.pop().ok_or("inline asm: `.endif` without `.if`")?;
            }
            _ => {
                if !trimmed.is_empty() && emitting(&stack) {
                    out.push_str(trimmed);
                    out.push('\n');
                }
            }
        }
    }
    if !stack.is_empty() {
        return Err(alloc::string::String::from(
            "inline asm: unterminated `.if`",
        ));
    }
    Ok(Some(out))
}

/// One `.macro` parameter: its name, the `=default` bound when the
/// invocation supplies no argument, and whether `:vararg` makes it swallow
/// the remaining argument text.
#[derive(Clone)]
struct GasParam {
    name: alloc::string::String,
    default: alloc::string::String,
    vararg: bool,
}

type GasParams = alloc::vec::Vec<GasParam>;

/// A local macro defined by `.macro` inside one inline-asm block.
struct GasMacro {
    params: GasParams,
    body: alloc::vec::Vec<alloc::string::String>,
}

const GAS_MACRO_DEPTH_LIMIT: usize = 64;

/// Expand the GNU as macro directives an inline-asm block uses to generate
/// instructions: `.rept`/`.rep`/`.irp`/`.irpc`/`.endr` (repeat),
/// `.macro`/`.endm`/`.purgem`
/// (local macro definition, invocation, removal), `.equ`/`.set` (symbol
/// assignment), and `.inst` (emit an `inst_width`-byte instruction word).
/// `.inst` expressions fold to a `.byte` run, macro invocations to their
/// expanded bodies, and `.equ` symbols resolve in every expression. `None`
/// when the template uses none of these (the common case).
///
/// `subst` resolves an operand reference (`%0` / `%w0` / `%c0`) to its
/// register-name or constant text, applied across the template before the
/// directives run -- mirroring the compiler substitution that precedes the
/// assembler, so an operand register is concrete before the `.equ`
/// register-number table (`.L__gpr_num_x1 = 1`) resolves it. The macro and
/// symbol tables are call-local, giving two expansions in one unit the
/// independence GNU as gives a `.purgem`'d macro.
pub(crate) fn expand_asm_gas_macros(
    text: &str,
    inst_width: usize,
    subst: &dyn Fn(&str) -> Option<alloc::string::String>,
) -> Result<Option<alloc::string::String>, alloc::string::String> {
    expand_gas_macros(text, inst_width, subst, false)
}

/// As [`expand_asm_gas_macros`], over a unit's file-scope text. Every folded
/// assignment stays in the stream there: GNU as records an assembly-time
/// assignment as an `SHN_ABS` symbol of the object, and the section layer
/// defines it from the directive. A function body's template is an
/// instruction stream with no carrier for such a symbol, so the entry point
/// above keeps only the assignments a later read needs.
pub(crate) fn expand_file_asm_gas_macros(
    text: &str,
    inst_width: usize,
) -> Result<Option<alloc::string::String>, alloc::string::String> {
    expand_gas_macros(text, inst_width, &|_| None, true)
}

fn expand_gas_macros(
    text: &str,
    inst_width: usize,
    subst: &dyn Fn(&str) -> Option<alloc::string::String>,
    keep_sets: bool,
) -> Result<Option<alloc::string::String>, alloc::string::String> {
    if !(text.contains(".irp")
        || text.contains(".rep")
        || text.contains(".macro")
        || text.contains(".inst")
        || text.contains(".equ")
        || text.contains(".set")
        || text.contains(".purgem")
        || text.contains(".req")
        || text.contains(".if")
        || has_gas_assignment(text))
    {
        return Ok(None);
    }
    let substituted = subst_asm_operands(text, subst);
    let stmts: alloc::vec::Vec<alloc::string::String> = split_asm_statements(&substituted)
        .into_iter()
        .map(|s| alloc::string::String::from(s.trim()))
        .collect();
    let mut st = GasExpandState {
        keep_sets,
        exported: gas_exported_names(&stmts),
        forward_set: gas_forward_set_names(&stmts),
        ..Default::default()
    };
    let mut out = alloc::string::String::with_capacity(text.len());
    expand_gas_statements(&stmts, &mut st, &mut out, inst_width, 0)?;
    Ok(Some(out))
}

/// State a macro expansion carries and mutates: the macro table, `.equ`
/// values, `.req` register aliases, and whether `.altmacro` is in effect.
/// Nested expansions share one instance, so a definition or a mode change
/// inside a macro body is visible to what it invokes.
#[derive(Default)]
struct GasExpandState {
    macros: alloc::collections::BTreeMap<alloc::string::String, GasMacro>,
    equ: alloc::collections::BTreeMap<alloc::string::String, i64>,
    aliases: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    altmacro: bool,
    /// Whether every folded assignment is re-emitted, which the file-scope
    /// stream takes and a function body's does not.
    keep_sets: bool,
    /// Names the unit declares `.globl` / `.global` / `.weak`. A folded
    /// `.set` over one of them stays in the stream so the section parse
    /// defines the absolute symbol the declaration promises; folding it
    /// away would leave the declaration naming nothing.
    exported: alloc::collections::BTreeSet<alloc::string::String>,
    /// Names an earlier statement read before any `.set` assigned them.
    /// Folding such an assignment away would leave that read naming nothing,
    /// so it stays in the stream for the section layer to define.
    forward_set: alloc::collections::BTreeSet<alloc::string::String>,
    /// Names defined by the statements expanded so far, which is what
    /// `.ifdef` answers against: a label, an assignment, or a common block,
    /// in any section, taken only from branches that emit. A declaration
    /// (`.globl`) or a reference to an undefined name defines nothing.
    defined: alloc::collections::BTreeSet<alloc::string::String>,
}

impl GasExpandState {
    /// Re-emit a folded assignment the stream still needs: every one where
    /// the name becomes a symbol of the object, else one with external
    /// linkage or one an earlier statement already referenced.
    fn keep_exported_set(&self, name: &str, value: i64, out: &mut alloc::string::String) {
        if self.keep_sets || self.exported.contains(name) || self.forward_set.contains(name) {
            out.push_str(&alloc::format!(".set {name}, {value}\n"));
        }
    }
}

/// Names a statement reads before any `.set` / `.equ` assigns them. The
/// expander has no value to substitute at such a read, so it passes the name
/// through and the later assignment has to stay in the stream to define it.
/// A reassignment is not one of these: every read after the first assignment
/// folds, so re-emitting it would put a directive in a stream that only holds
/// instructions.
fn gas_forward_set_names(
    stmts: &[alloc::string::String],
) -> alloc::collections::BTreeSet<alloc::string::String> {
    let ident = |c: char| c.is_ascii_alphanumeric() || matches!(c, '_' | '.' | '$');
    let mut used: alloc::collections::BTreeSet<&str> = alloc::collections::BTreeSet::new();
    let mut assigned: alloc::collections::BTreeSet<&str> = alloc::collections::BTreeSet::new();
    let mut out = alloc::collections::BTreeSet::new();
    for s in stmts {
        let (_, body) = split_leading_labels(s);
        let (tok, rest) = split_first_token(body);
        if matches!(tok, ".equ" | ".set" | ".equiv")
            && let Some((sym, _)) = rest.split_once(',')
        {
            let sym = sym.trim();
            if used.contains(sym) && !assigned.contains(sym) {
                out.insert(alloc::string::String::from(sym));
            }
            assigned.insert(sym);
        }
        used.extend(body.split(|c: char| !ident(c)).filter(|t| !t.is_empty()));
    }
    out
}

/// The `.globl` / `.global` / `.weak` names a statement list declares.
fn gas_exported_names(
    stmts: &[alloc::string::String],
) -> alloc::collections::BTreeSet<alloc::string::String> {
    let mut out = alloc::collections::BTreeSet::new();
    for s in stmts {
        let (_, s) = split_leading_labels(s);
        let (tok, rest) = split_first_token(s);
        if matches!(tok, ".globl" | ".global" | ".weak") {
            for name in rest.split(',') {
                let name = name.trim();
                if is_asm_symbol_name(name) {
                    out.insert(alloc::string::String::from(name));
                }
            }
        }
    }
    out
}

fn expand_gas_statements(
    stmts: &[alloc::string::String],
    st: &mut GasExpandState,
    out: &mut alloc::string::String,
    inst_width: usize,
    depth: usize,
) -> Result<(), alloc::string::String> {
    if depth > GAS_MACRO_DEPTH_LIMIT {
        return Err(alloc::string::String::from(
            "inline asm: macro expansion nested too deep",
        ));
    }
    // Conditional-assembly stack, evaluated as the macro expands so a `.ifc` /
    // `.if` can test a `.set` symbol or a substituted operand: each frame is
    // (this branch emits, some branch already taken).
    let mut cond: alloc::vec::Vec<(bool, bool)> = alloc::vec::Vec::new();
    let emitting = |c: &[(bool, bool)]| c.iter().all(|&(on, _)| on);
    let mut i = 0usize;
    while i < stmts.len() {
        let s = stmts[i].as_str();
        i += 1;
        if s.is_empty() {
            continue;
        }
        // Labels may share a statement with what follows them
        // (`1: .irp ...`). Peel them so the directive is the first token;
        // one statement each names the same address.
        let (labels, s) = split_leading_labels(s);
        if emitting(&cond) {
            for l in &labels {
                st.defined
                    .insert(alloc::string::String::from(l.trim_end_matches(':')));
                out.push_str(l);
                out.push('\n');
            }
        }
        if s.is_empty() {
            continue;
        }
        let (tok, rest) = split_first_token(s);
        // A common block defines its name, whichever branch below routes the
        // statement itself.
        if emitting(&cond)
            && matches!(tok, ".comm" | ".lcomm")
            && let Some(name) = rest.split(',').next()
        {
            st.defined.insert(alloc::string::String::from(name.trim()));
        }
        // GNU as ends a directive or macro name at the first character that
        // cannot be part of one, so no space is needed before a parenthesized
        // operand list: `.inst(expr)`, and a macro invoked in the C-macro
        // spelling (`STACK_FRAME_NON_STANDARD(func)`).
        let (tok, rest) = match tok.find('(') {
            Some(p)
                if (tok.starts_with(".inst") && p >= 5) || st.macros.contains_key(&tok[..p]) =>
            {
                (&tok[..p], &s[p..])
            }
            _ => (tok, rest),
        };
        // Conditional directives are tracked whether or not the enclosing
        // branch emits, so nesting stays balanced across dead branches.
        match tok {
            ".if" | ".ifeq" | ".ifne" | ".ifgt" | ".iflt" | ".ifge" | ".ifle" => {
                // A condition over names only the layout can value, guarding
                // branches that emit no bytes: copy the region through so the
                // section layer values it once the labels are placed. GNU as
                // reads the same difference at the `.if`, which it can only
                // do while the two labels sit in one fixed-size run.
                if emitting(&cond)
                    && gas_cond_reads_symbols(rest, &st.equ)
                    && let Some(next) = gas_cond_region_is_diagnostic_only(stmts, i)
                {
                    for s in &stmts[i - 1..next] {
                        out.push_str(s);
                        out.push('\n');
                    }
                    i = next;
                    continue;
                }
                let taken = emitting(&cond) && gas_if_taken(tok, rest, &st.equ)?;
                cond.push((taken, taken));
                continue;
            }
            ".ifc" | ".ifnc" => {
                let taken = emitting(&cond) && gas_ifc_taken(tok, rest);
                cond.push((taken, taken));
                continue;
            }
            // Blank test: true when the argument is empty after macro
            // substitution (`.ifb \tmp`).
            ".ifb" | ".ifnb" => {
                let taken = emitting(&cond) && (rest.trim().is_empty() == (tok == ".ifb"));
                cond.push((taken, taken));
                continue;
            }
            // Defined test against what the expansion has defined so far
            // (`.ifdef .Lframe_regcount`, a label an earlier macro expansion
            // placed). GNU as answers it one-pass, so a definition further
            // down the stream does not count.
            ".ifdef" | ".ifndef" | ".ifnotdef" => {
                let defined = st.defined.contains(rest.trim());
                let taken = emitting(&cond) && (defined == (tok == ".ifdef"));
                cond.push((taken, taken));
                continue;
            }
            ".elseif" => {
                let outer = emitting(&cond[..cond.len().saturating_sub(1)]);
                let f = cond
                    .last_mut()
                    .ok_or("inline asm: `.elseif` without `.if`")?;
                let taken = outer && !f.1 && gas_if_taken(".if", rest, &st.equ)?;
                f.0 = taken;
                f.1 |= taken;
                continue;
            }
            ".else" => {
                let outer = emitting(&cond[..cond.len().saturating_sub(1)]);
                let f = cond.last_mut().ok_or("inline asm: `.else` without `.if`")?;
                f.0 = outer && !f.1;
                f.1 = true;
                continue;
            }
            ".endif" => {
                cond.pop().ok_or("inline asm: `.endif` without `.if`")?;
                continue;
            }
            _ => {}
        }
        if !emitting(&cond) {
            // A dead branch: skip it, but consume any macro / repeat body so its
            // `.endm` / `.endr` does not leak into the enclosing stream.
            match tok {
                ".macro" => i = collect_gas_body(stmts, i, ".macro", ".endm")?.1,
                ".irp" | ".irpc" | ".rept" | ".rep" => i = collect_gas_repeat_body(stmts, i)?.1,
                _ => {}
            }
            continue;
        }
        match tok {
            ".error" => {
                let msg = rest.trim().trim_matches('"');
                return Err(alloc::format!("inline asm: `.error` {msg}"));
            }
            ".macro" => {
                let (name, params) = parse_gas_macro_header(rest)?;
                let (body, next) = collect_gas_body(stmts, i, ".macro", ".endm")?;
                st.macros.insert(name, GasMacro { params, body });
                i = next;
            }
            ".endm" => {
                return Err(alloc::string::String::from(
                    "inline asm: `.endm` without `.macro`",
                ));
            }
            ".purgem" => {
                let name = rest.trim();
                if st.macros.remove(name).is_none() {
                    return Err(alloc::format!(
                        "inline asm: `.purgem` of undefined macro `{name}`"
                    ));
                }
            }
            // Alternate macro syntax. Only the `%expr` argument evaluation is
            // interpreted; the mode carries into nested expansions, which is
            // where an invocation written inside a macro body reads it.
            ".altmacro" | ".noaltmacro" => st.altmacro = tok == ".altmacro",
            ".irp" | ".irpc" => {
                let (var, values) = parse_gas_irp_header(rest, tok == ".irpc")?;
                let (body, next) = collect_gas_repeat_body(stmts, i)?;
                i = next;
                for val in &values {
                    let mut map = alloc::collections::BTreeMap::new();
                    map.insert(var.clone(), val.clone());
                    let expanded = subst_gas_body(&body, &map, None);
                    expand_gas_statements(&expanded, st, out, inst_width, depth + 1)?;
                }
            }
            ".rept" | ".rep" => {
                let table = &st.equ;
                let (body, next) = collect_gas_repeat_body(stmts, i)?;
                i = next;
                match eval_asm_expr_with_labels(rest, &|t| table.get(t).copied()) {
                    Some(n) => {
                        for _ in 0..n.max(0) {
                            expand_gas_statements(&body, st, out, inst_width, depth + 1)?;
                        }
                    }
                    // A count over labels (`(662b-661b) / 4`) defers to the
                    // section layer, which knows the offsets; the body
                    // expands once here.
                    None => {
                        out.push_str(".rept ");
                        out.push_str(rest);
                        out.push('\n');
                        expand_gas_statements(&body, st, out, inst_width, depth + 1)?;
                        out.push_str(".endr\n");
                    }
                }
            }
            ".endr" => {
                return Err(alloc::string::String::from(
                    "inline asm: `.endr` without `.rept` or `.irp`",
                ));
            }
            ".equ" | ".set" | ".equiv" => {
                // A single-argument `.set` (`.set noreorder`) is not a symbol
                // assignment; pass it through unchanged.
                let Some((sym, expr)) = rest.split_once(',') else {
                    out.push_str(s);
                    out.push('\n');
                    continue;
                };
                st.defined.insert(alloc::string::String::from(sym.trim()));
                let table = &st.equ;
                match eval_asm_expr_with_labels(expr.trim(), &|t| table.get(t).copied()) {
                    Some(v) => {
                        st.equ.insert(alloc::string::String::from(sym.trim()), v);
                        st.keep_exported_set(sym.trim(), v, out);
                    }
                    None if bind_register_equate(sym.trim(), expr.trim(), st) => {}
                    // A value the expander cannot fold names a symbol or reads
                    // the location counter; neither is known before layout, so
                    // pass it through for the section parser.
                    None => {
                        out.push_str(s);
                        out.push('\n');
                    }
                }
            }
            ".inst" | ".inst.n" | ".inst.w" => {
                for arg in split_top_commas(rest) {
                    let table = &st.equ;
                    let v = eval_asm_expr_with_labels(arg, &|t| table.get(t).copied()).ok_or_else(
                        || alloc::format!("inline asm: `.inst` operand `{arg}` is not constant"),
                    )?;
                    let bytes = (v as u64).to_le_bytes();
                    out.push_str(INST_BYTES_DIRECTIVE);
                    out.push(' ');
                    for (k, b) in bytes.iter().take(inst_width).enumerate() {
                        if k > 0 {
                            out.push_str(", ");
                        }
                        out.push_str(&alloc::format!("0x{b:02x}"));
                    }
                    out.push('\n');
                }
            }
            ".unreq" => {
                st.aliases.remove(rest.trim());
            }
            _ => {
                // `name = expr`: the GNU as assignment spelling of `.set`.
                // A foldable value joins the symbol table; one over
                // locations is rewritten to `.set` for the section parser.
                let assign = if is_asm_symbol_name(tok) {
                    rest.strip_prefix('=')
                        .filter(|r| !r.starts_with('='))
                        .map(|e| (tok, alloc::string::String::from(e.trim())))
                } else {
                    tok.split_once('=')
                        .filter(|(n, e)| is_asm_symbol_name(n) && !e.starts_with('='))
                        .map(|(n, e)| (n, alloc::format!("{e} {rest}")))
                };
                if let Some((aname, aexpr)) = assign {
                    let aexpr = aexpr.trim();
                    st.defined.insert(alloc::string::String::from(aname));
                    let table = &st.equ;
                    match eval_asm_expr_with_labels(aexpr, &|t| table.get(t).copied()) {
                        Some(v) => {
                            st.equ.insert(alloc::string::String::from(aname), v);
                            st.keep_exported_set(aname, v, out);
                        }
                        None if bind_register_equate(aname, aexpr, st) => {}
                        None => {
                            out.push_str(&alloc::format!(".set {aname}, {aexpr}\n"));
                        }
                    }
                    continue;
                }
                // `alias .req reg` defines a register alias; every later
                // identifier use of the alias substitutes the register.
                if let Some(reg) = rest.strip_prefix(".req").and_then(|r| {
                    let reg = r.trim();
                    (r.starts_with(char::is_whitespace) && !reg.is_empty()).then_some(reg)
                }) {
                    let resolved = st.aliases.get(reg).cloned();
                    st.aliases.insert(
                        alloc::string::String::from(tok),
                        resolved.unwrap_or_else(|| alloc::string::String::from(reg)),
                    );
                } else if st.macros.contains_key(tok) {
                    // Bind arguments to parameters, then expand and re-process
                    // the body (which may define, invoke, or purge st.macros).
                    // Each invocation takes a fresh `\@` instance number.
                    let def = &st.macros[tok];
                    let params = def.params.clone();
                    let body = def.body.clone();
                    let map = bind_gas_macro_args(&params, rest, st.altmacro);
                    let inst = next_asm_instance();
                    let expanded = subst_gas_body(&body, &map, Some(inst));
                    expand_gas_statements(&expanded, st, out, inst_width, depth + 1)?;
                } else {
                    // A pass-through line. Resolve any `.equ` symbol and
                    // register alias so a `.short`/`.long` value (the
                    // exception-table register field) is constant and an
                    // aliased operand names its register when the section
                    // pass reads it. An alias with an arrangement suffix
                    // (`cbciv.16b`) substitutes the register part.
                    if st.equ.is_empty() && st.aliases.is_empty() {
                        out.push_str(s);
                    } else {
                        out.push_str(&subst_asm_idents_text(s, &|t| {
                            if let Some(a) = st.aliases.get(t) {
                                return Some(a.clone());
                            }
                            if let Some((head, tail)) = t.split_once('.')
                                && let Some(a) = st.aliases.get(head)
                            {
                                return Some(alloc::format!("{a}.{tail}"));
                            }
                            st.equ.get(t).map(|v| alloc::format!("{v}"))
                        }));
                    }
                    out.push('\n');
                }
            }
        }
    }
    if !cond.is_empty() {
        return Err(alloc::string::String::from(
            "inline asm: unterminated `.if` in macro expansion",
        ));
    }
    Ok(())
}

/// Whether the text holds a `name = expr` assignment, the GNU as spelling of
/// `.set`. An `=` that is part of a comparison or a compound operator is not
/// one, and neither is a macro parameter's `=default`, which the directives
/// above already trigger on.
fn has_gas_assignment(text: &str) -> bool {
    const OPS: &[u8] = b"=!<>+-*/%&|^";
    let b = text.as_bytes();
    (0..b.len()).any(|i| {
        b[i] == b'='
            && b.get(i + 1) != Some(&b'=')
            && !i.checked_sub(1).is_some_and(|p| OPS.contains(&b[p]))
    })
}

/// `name = %reg` / `.set name, %reg`: the GNU as register equate, the same
/// binding `name .req reg` makes. Records the alias and reports that the
/// assignment defined no symbol; a value that is neither a register name nor
/// an established alias leaves the assignment for the section parser.
fn bind_register_equate(name: &str, expr: &str, st: &mut GasExpandState) -> bool {
    let reg = match st.aliases.get(expr) {
        Some(r) => r.clone(),
        None => {
            let bare = expr.strip_prefix('%').unwrap_or("");
            if bare.is_empty() || !bare.bytes().all(|c| c.is_ascii_alphanumeric()) {
                return false;
            }
            alloc::string::String::from(expr)
        }
    };
    st.aliases.insert(alloc::string::String::from(name), reg);
    true
}

/// Whether a GNU as `.if`-family directive takes its branch: evaluate the
/// condition expression against the current `.set` symbol table and apply the
/// directive's relation to zero.
fn gas_if_taken(
    tok: &str,
    rest: &str,
    equ: &alloc::collections::BTreeMap<alloc::string::String, i64>,
) -> Result<bool, alloc::string::String> {
    let v = eval_asm_expr_with_labels(rest, &|t| equ.get(t).copied())
        .ok_or_else(|| alloc::format!("inline asm: non-constant `{tok}` condition `{rest}`"))?;
    gas_if_relation(tok, v)
}

/// The relation to zero a `.if`-family directive applies to its condition's
/// value.
pub(crate) fn gas_if_relation(tok: &str, v: i64) -> Result<bool, alloc::string::String> {
    Ok(match tok {
        ".ifeq" => v == 0,
        ".ifne" | ".if" => v != 0,
        ".ifgt" => v > 0,
        ".iflt" => v < 0,
        ".ifge" => v >= 0,
        ".ifle" => v <= 0,
        _ => {
            return Err(alloc::format!(
                "inline asm: unsupported conditional `{tok}`"
            ));
        }
    })
}

/// Whether a `.if` condition reads a name the expansion cannot value: a
/// label, or a symbol defined elsewhere in the unit. Numeric literals,
/// assignments the expansion has made, and the register text a `%`-prefixed
/// name spells are all valued here.
fn gas_cond_reads_symbols(
    rest: &str,
    equ: &alloc::collections::BTreeMap<alloc::string::String, i64>,
) -> bool {
    let b = rest.as_bytes();
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let mut i = 0usize;
    while i < b.len() {
        if !ident(b[i]) {
            i += 1;
            continue;
        }
        let start = i;
        while i < b.len() && ident(b[i]) {
            i += 1;
        }
        let tok = &rest[start..i];
        let register_text = start > 0 && b[start - 1] == b'%';
        let numeric = tok.as_bytes()[0].is_ascii_digit()
            && numeric_label_digits(tok).is_none_or(|d| d.len() == tok.len())
            && parse_asm_number(tok).is_some();
        if !register_text && !numeric && !equ.contains_key(tok) {
            return true;
        }
    }
    false
}

/// Statement index just past the `.endif` of a conditional region whose
/// branches emit no bytes, so its outcome cannot change the section layout
/// and the condition may be valued after it. `from` is the statement after
/// the `.if`. `None` when a branch emits, or when the region nests another
/// conditional, whose liveness the outer condition would decide.
fn gas_cond_region_is_diagnostic_only(
    stmts: &[alloc::string::String],
    from: usize,
) -> Option<usize> {
    for (n, s) in stmts.iter().enumerate().skip(from) {
        let (labels, s) = split_leading_labels(s);
        if !labels.is_empty() {
            return None;
        }
        if s.is_empty() {
            continue;
        }
        match split_first_token(s).0 {
            ".endif" => return Some(n + 1),
            ".error" | ".else" | ".elseif" => {}
            _ => return None,
        }
    }
    None
}

/// Whether a GNU as `.ifc` / `.ifnc` string-comparison takes its branch. The
/// two arguments are separated by a comma and compared after trimming
/// surrounding whitespace (`.ifc %eax, %eax`).
fn gas_ifc_taken(tok: &str, rest: &str) -> bool {
    let (a, b) = match rest.split_once(',') {
        Some((a, b)) => (a.trim(), b.trim()),
        None => (rest.trim(), ""),
    };
    (a == b) == (tok == ".ifc")
}

/// Replace each character constant in a macro argument with its numeric
/// value, as GNU as does when it binds one (`m 'r'` binds `114`).
fn fold_char_consts(a: &str) -> alloc::string::String {
    if !a.contains('\'') {
        return alloc::string::String::from(a);
    }
    let b = a.as_bytes();
    let mut out = alloc::string::String::with_capacity(a.len());
    let mut i = 0usize;
    while i < b.len() {
        match parse_asm_char_const(b, i) {
            Some((v, next)) => {
                out.push_str(&alloc::format!("{v}"));
                i = next;
            }
            None => {
                out.push(b[i] as char);
                i += 1;
            }
        }
    }
    out
}

/// Strip one level of enclosing double quotes from a macro / `.irp`
/// argument, as GNU as does when binding it.
fn unquote_gas_arg(a: &str) -> &str {
    a.strip_prefix('"')
        .and_then(|r| r.strip_suffix('"'))
        .unwrap_or(a)
}

/// Bind a GNU as macro invocation's arguments to its parameters. A `key=value`
/// argument whose key names a parameter binds by keyword; the rest fill the
/// still-unbound parameters positionally, in order. An enclosing quote pair
/// is stripped from each bound value. An unsupplied parameter binds to its
/// `=default`, or to the empty string; a `:vararg` parameter takes the whole
/// remaining argument text.
fn bind_gas_macro_args(
    params: &GasParams,
    rest: &str,
    altmacro: bool,
) -> alloc::collections::BTreeMap<alloc::string::String, alloc::string::String> {
    let args = split_macro_args(rest);
    // Under `.altmacro` a `%`-led argument is an expression evaluated at the
    // invocation and bound as its decimal value. A `:vararg` parameter takes
    // the raw text, so this applies only where a single argument binds.
    let value = |a: &str| match altmacro.then(|| a.strip_prefix('%')).flatten() {
        Some(e) => match eval_const_expr(e) {
            Some(v) => alloc::format!("{v}"),
            None => alloc::string::String::from(unquote_gas_arg(a)),
        },
        None => fold_char_consts(unquote_gas_arg(a)),
    };
    let is_keyword = |a: &str| {
        a.split_once('=')
            .is_some_and(|(k, _)| params.iter().any(|p| p.name == k.trim()))
    };
    let mut map = alloc::collections::BTreeMap::new();
    for a in &args {
        if is_keyword(a) {
            let (k, v) = a.split_once('=').unwrap();
            map.insert(alloc::string::String::from(k.trim()), value(v.trim()));
        }
    }
    let unbound: alloc::vec::Vec<&GasParam> = params
        .iter()
        .filter(|p| !map.contains_key(&p.name))
        .collect();
    let mut positional = args.iter().enumerate().filter(|(_, a)| !is_keyword(a));
    for p in unbound {
        if p.vararg {
            // The raw remaining argument text, separators included.
            let text = match positional.next() {
                Some((i, a)) => {
                    let off = a.as_ptr() as usize - rest.as_ptr() as usize;
                    let _ = i;
                    alloc::string::String::from(rest[off..].trim())
                }
                None => alloc::string::String::new(),
            };
            map.insert(p.name.clone(), text);
            break;
        }
        // An argument supplied empty takes the parameter's default, as GNU as
        // binds it; a parameter with no default takes the empty string either
        // way.
        match positional.next() {
            Some((_, a)) if !a.is_empty() => {
                map.insert(p.name.clone(), value(a));
            }
            _ => {
                map.insert(p.name.clone(), p.default.clone());
            }
        }
    }
    for p in params {
        map.entry(p.name.clone())
            .or_insert_with(|| p.default.clone());
    }
    map
}

/// The directive a statement names, with any leading labels peeled as the
/// expansion loop peels them (`1: .endr`).
fn stmt_directive(s: &str) -> &str {
    split_first_token(split_leading_labels(s).1).0
}

/// Collect a `.macro` body up to its matching `close`, nesting-aware.
fn collect_gas_body(
    stmts: &[alloc::string::String],
    start: usize,
    open: &str,
    close: &str,
) -> Result<(alloc::vec::Vec<alloc::string::String>, usize), alloc::string::String> {
    let mut depth = 1i32;
    let mut body = alloc::vec::Vec::new();
    let mut i = start;
    while i < stmts.len() {
        let first = stmt_directive(stmts[i].as_str());
        if first == open {
            depth += 1;
        } else if first == close {
            depth -= 1;
            if depth == 0 {
                return Ok((body, i + 1));
            }
        }
        body.push(stmts[i].clone());
        i += 1;
    }
    Err(alloc::format!("inline asm: `{open}` without `{close}`"))
}

/// Collect a `.rept` / `.irp` body up to its matching `.endr`. GNU as closes
/// every repeat directive with `.endr`, so the nesting count spans the family
/// rather than one spelling: a `.rept` inside an `.irp` closes first.
fn collect_gas_repeat_body(
    stmts: &[alloc::string::String],
    start: usize,
) -> Result<(alloc::vec::Vec<alloc::string::String>, usize), alloc::string::String> {
    let mut depth = 1i32;
    let mut body = alloc::vec::Vec::new();
    let mut i = start;
    while i < stmts.len() {
        match stmt_directive(stmts[i].as_str()) {
            ".rept" | ".rep" | ".irp" | ".irpc" => depth += 1,
            ".endr" => {
                depth -= 1;
                if depth == 0 {
                    return Ok((body, i + 1));
                }
            }
            _ => {}
        }
        body.push(stmts[i].clone());
        i += 1;
    }
    Err(alloc::string::String::from(
        "inline asm: `.rept` / `.irp` without `.endr`",
    ))
}

/// Parse a `.macro` header `NAME[,] p1[, p2 ...]`. A parameter may carry a
/// `=default` (bound when the invocation supplies no argument), a `:req`
/// qualifier (dropped; binding is positional either way), or `:vararg`
/// (binds the rest of the argument text).
fn parse_gas_macro_header(
    rest: &str,
) -> Result<(alloc::string::String, GasParams), alloc::string::String> {
    // Parameters split like invocation arguments: a parenthesised
    // `=default` may contain spaces.
    let toks = split_macro_args(rest);
    let mut it = toks.into_iter().filter(|t| !t.is_empty());
    let name = it.next().ok_or("inline asm: `.macro` without a name")?;
    let params = it
        .map(|p| {
            // GNU as scans the formal name, then the `=` / `:` separator and
            // the text after it as separate tokens, so whitespace may border
            // either (`regsize = 64`, `tsk : req`).
            let (head, default) = match p.split_once('=') {
                Some((h, d)) => (h.trim_end(), alloc::string::String::from(d.trim())),
                None => (p, alloc::string::String::new()),
            };
            let (pname, qual) = match head.split_once(':') {
                Some((n, q)) => (n.trim_end(), q.trim()),
                None => (head, ""),
            };
            GasParam {
                name: alloc::string::String::from(pname),
                default,
                vararg: qual == "vararg",
            }
        })
        .collect();
    Ok((alloc::string::String::from(name), params))
}

/// Parse a `.irp` header `VAR,v1,v2,...`; with no values the body expands once
/// with the symbol empty (GNU as convention). `per_char` selects `.irpc`,
/// whose values are the individual characters of the operands.
fn parse_gas_irp_header(
    rest: &str,
    per_char: bool,
) -> Result<
    (
        alloc::string::String,
        alloc::vec::Vec<alloc::string::String>,
    ),
    alloc::string::String,
> {
    let rest = rest.trim();
    let end = rest
        .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_'))
        .unwrap_or(rest.len());
    if end == 0 {
        return Err(alloc::string::String::from(
            "inline asm: `.irp` without a symbol",
        ));
    }
    let var = alloc::string::String::from(&rest[..end]);
    let items = rest[end..].split(|c: char| c == ',' || c.is_whitespace());
    let mut values: alloc::vec::Vec<alloc::string::String> = if per_char {
        items.flat_map(|t| t.chars()).map(Into::into).collect()
    } else {
        items
            .filter(|t| !t.is_empty())
            .map(alloc::string::String::from)
            .collect()
    };
    if values.is_empty() {
        values.push(alloc::string::String::new());
    }
    Ok((var, values))
}

/// Substitute a macro / `.irp` body's parameters and re-split the result into
/// statements. An argument may itself hold `;`-separated statements (the
/// kernel's ALTERNATIVE macros pass a whole instruction sequence as one
/// argument), and GNU as re-scans the expansion, so a separator that arrives
/// through a parameter separates.
fn subst_gas_body(
    body: &[alloc::string::String],
    map: &alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    instance: Option<u32>,
) -> alloc::vec::Vec<alloc::string::String> {
    let mut out = alloc::vec::Vec::with_capacity(body.len());
    for line in body {
        let line = subst_gas_params(line, map, instance);
        if line.contains(';') {
            out.extend(
                split_asm_statements(&line)
                    .into_iter()
                    .map(|s| alloc::string::String::from(s.trim())),
            );
        } else {
            out.push(line);
        }
    }
    out
}

/// Substitute `\param` in a macro / `.irp` body with its bound value. `\()`
/// is an empty name separator; `\@` is the macro-instance counter when one
/// is given (a macro invocation); an unbound `\name` stays verbatim.
fn subst_gas_params(
    line: &str,
    map: &alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    instance: Option<u32>,
) -> alloc::string::String {
    if !line.contains('\\') {
        return alloc::string::String::from(line);
    }
    let mut out = alloc::string::String::with_capacity(line.len());
    let mut rest = line;
    while let Some(pos) = rest.find('\\') {
        out.push_str(&rest[..pos]);
        let after = &rest[pos + 1..];
        if let Some(tail) = after.strip_prefix("()") {
            rest = tail;
            continue;
        }
        if let Some(tail) = after.strip_prefix('@')
            && let Some(n) = instance
        {
            out.push_str(&alloc::format!("{n}"));
            rest = tail;
            continue;
        }
        let end = after
            .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_'))
            .unwrap_or(after.len());
        let name = &after[..end];
        match map.get(name) {
            Some(v) => {
                out.push_str(v);
                rest = &after[end..];
            }
            None => {
                out.push('\\');
                rest = after;
            }
        }
    }
    out.push_str(rest);
    out
}

/// Substitute operand references (`%0` / `%w0` / `%c0`) with the text `subst`
/// yields; `%%` is a literal percent. An unresolved reference stays a bare `%`,
/// which the downstream parser rejects rather than mis-encodes.
fn subst_asm_operands(
    text: &str,
    subst: &dyn Fn(&str) -> Option<alloc::string::String>,
) -> alloc::string::String {
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut rest = text;
    while let Some(pos) = rest.find('%') {
        out.push_str(&rest[..pos]);
        let after = &rest[pos + 1..];
        let ab = after.as_bytes();
        if ab.first() == Some(&b'%') {
            out.push('%');
            rest = &after[1..];
            continue;
        }
        // `%` + optional modifier letter + digits.
        let mut j = 0;
        if ab.first().is_some_and(u8::is_ascii_alphabetic) {
            j += 1;
        }
        let dig = j;
        while j < ab.len() && ab[j].is_ascii_digit() {
            j += 1;
        }
        if j > dig
            && let Some(r) = subst(&rest[pos..pos + 1 + j])
        {
            out.push_str(&r);
            rest = &after[j..];
            continue;
        }
        out.push('%');
        rest = after;
    }
    out.push_str(rest);
    out
}

/// Split a macro invocation's arguments as GNU as scans them: commas
/// separate; whitespace separates unless it borders an expression operator
/// (`ldr_l x1, sym + 24` keeps `sym + 24` whole, `m 3 4` splits) or the
/// argument began with `(` (`nops (662b-661b) / 4`). Quoted runs and
/// bracketed groups are opaque. A comma with no argument before it supplies
/// an empty one (`m 1,,3` binds three), so only whitespace runs collapse.
fn split_macro_args(s: &str) -> alloc::vec::Vec<&str> {
    let b = s.as_bytes();
    // `%` is not one of them: GNU as splits `m 1 % 2` into three arguments,
    // and an AT&T register operand leads with it (`m %r8 %r9` is two).
    let is_op = |c: u8| {
        matches!(
            c,
            b'+' | b'-' | b'*' | b'/' | b'|' | b'&' | b'^' | b'~' | b'<' | b'>' | b'='
        )
    };
    let mut parts: alloc::vec::Vec<&str> = alloc::vec::Vec::new();
    let mut depth = 0i32;
    let mut quoted = false;
    let mut start = 0usize;
    let mut paren_led = false;
    let mut in_arg = false;
    // Whether whitespace closed the previous argument, so a comma reaching
    // this one is its separator rather than an empty argument.
    let mut ws_terminated = false;
    let mut last_comma = false;
    let mut i = 0usize;
    while i < b.len() {
        let c = b[i];
        // A character constant is one token, separators included: GNU as
        // binds `m 'r', ' ', ':'` as three arguments.
        if !quoted
            && c == b'\''
            && let Some((_, next)) = parse_asm_char_const(b, i)
        {
            in_arg = true;
            i = next;
            continue;
        }
        if !in_arg && !c.is_ascii_whitespace() {
            in_arg = true;
            paren_led = c == b'(';
        }
        let split = match c {
            b'"' => {
                quoted = !quoted;
                false
            }
            _ if quoted => false,
            b'(' | b'[' | b'{' => {
                depth += 1;
                false
            }
            b')' | b']' | b'}' => {
                depth -= 1;
                false
            }
            b',' => depth == 0,
            _ if depth == 0 && c.is_ascii_whitespace() && in_arg && !paren_led => {
                let prev = b[..i].iter().rev().find(|c| !c.is_ascii_whitespace());
                let next = b[i..].iter().find(|c| !c.is_ascii_whitespace());
                !(prev.copied().is_some_and(is_op) || next.copied().is_some_and(is_op))
            }
            _ => false,
        };
        if split {
            let p = s[start..i].trim();
            let comma = c == b',';
            // A comma terminates an argument even when it is empty, except
            // where whitespace already terminated the one before it
            // (`m 1 , 2` is two arguments, `m 1,,2` is three).
            if !p.is_empty() || (comma && !ws_terminated) {
                parts.push(p);
                ws_terminated = !comma;
            } else if comma {
                ws_terminated = false;
            }
            last_comma = comma;
            start = i + 1;
            in_arg = false;
        }
        i += 1;
    }
    let p = s[start..].trim();
    if !p.is_empty() || last_comma {
        parts.push(p);
    }
    parts
}

/// Split a directive argument list on top-level commas, ignoring commas
/// nested in `()` / `[]` / `{}` or inside a double-quoted run (an
/// ALTERNATIVE macro argument quotes a whole instruction, commas included).
/// Empty pieces are dropped.
pub(crate) fn split_top_commas(s: &str) -> alloc::vec::Vec<&str> {
    let mut parts = alloc::vec::Vec::new();
    let b = s.as_bytes();
    let mut depth = 0i32;
    let mut quoted = false;
    let mut start = 0usize;
    for (i, &c) in b.iter().enumerate() {
        match c {
            b'"' => quoted = !quoted,
            _ if quoted => {}
            b'(' | b'[' | b'{' => depth += 1,
            b')' | b']' | b'}' => depth -= 1,
            b',' if depth == 0 => {
                let p = s[start..i].trim();
                if !p.is_empty() {
                    parts.push(p);
                }
                start = i + 1;
            }
            _ => {}
        }
    }
    let p = s[start..].trim();
    if !p.is_empty() {
        parts.push(p);
    }
    parts
}

/// Split an AArch64 ALTERNATIVE template into its main stream and the
/// `.subsection` replacement code GNU as appends to the section after the
/// main content. The kernel `ALTERNATIVE` macro places the replacement in
/// `.subsection 1` bracketed by `.previous`, out of the main sequence's
/// fall-through path. Returns `(main, deferred)`; `deferred` is empty (and
/// `main` is `text` unchanged) when there is no `.subsection` or when its
/// shape is one this pass does not lift: nested in a `.pushsection`, without
/// a closing `.previous`, a second region in the same template, or a
/// non-numeric subsection number. `extract_asm_sections` then rejects the
/// left-in `.subsection` rather than this dropping it silently.
pub(crate) fn split_asm_subsections(text: &str) -> (alloc::string::String, alloc::string::String) {
    let unchanged = || {
        (
            alloc::string::String::from(text),
            alloc::string::String::new(),
        )
    };
    if !text.contains(".subsection") {
        return unchanged();
    }
    let mut main = alloc::string::String::with_capacity(text.len());
    let mut deferred = alloc::string::String::new();
    // `.pushsection` / `.popsection` nesting; a `.subsection` is a code-stream
    // directive only at depth 0. `seen` guards against a second region.
    let mut push_depth: i32 = 0;
    let mut in_deferred = false;
    let mut seen = false;
    for line in text.split('\n') {
        let t = line.trim();
        let tok = t.split(char::is_whitespace).next().unwrap_or("");
        match tok {
            ".pushsection" | ".section" if !in_deferred => {
                push_depth += 1;
            }
            ".popsection" if !in_deferred => {
                push_depth -= 1;
            }
            ".subsection" if push_depth == 0 && !in_deferred && !seen => {
                let n = t[tok.len()..].trim();
                match n.parse::<u32>() {
                    Ok(0) => return unchanged(),
                    Ok(_) => {
                        in_deferred = true;
                        seen = true;
                        continue;
                    }
                    Err(_) => return unchanged(),
                }
            }
            ".subsection" => return unchanged(),
            ".previous" if in_deferred => {
                in_deferred = false;
                continue;
            }
            _ => {}
        }
        if in_deferred {
            deferred.push_str(line);
            deferred.push('\n');
        } else {
            main.push_str(line);
            main.push('\n');
        }
    }
    // A region left open (no `.previous`) is a shape this pass does not lift.
    if in_deferred {
        return unchanged();
    }
    (main, deferred)
}

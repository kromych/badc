//! Global / TLS initializer parser: the right-hand side of a
//! static-storage scalar's `=`.
//!
//! What the initializer *is* comes from `initializer.rs`'s
//! `parse_constant_init_value`, the same constant-expression evaluator
//! aggregate elements take, so both contexts accept one grammar. What
//! stays here is how a scalar slot *stores* the result: the `.data` /
//! `.tdata` split, the slot width, which relocation list a slot's
//! address constant joins, and the type-mismatch warning. mod.rs's only
//! role is to call `parse_global_initializer` from the file-scope decl
//! loop.

use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::const_expr::ConstVal;
use super::initializer::InitElemReloc;
use super::types::{is_pointer_ty, strip_unsigned};

impl Compiler {
    /// After a leading `(TYPE)` cast in an initializer, returns true
    /// when the cast applies to a relocation-bearing leaf (`&x`, a
    /// string literal, or a function / global-array name) rather than an
    /// arithmetic value. Reloc leaves keep the address-folding path; an
    /// arithmetic cast must instead reach the const-expr evaluator, which
    /// narrows per C99 6.3.1.3. Entry is positioned just inside the cast
    /// paren (depth 1); the lexer is restored before returning.
    pub(super) fn post_cast_is_reloc_leaf(&mut self) -> Result<bool, C5Error> {
        let snap = self.lex.snapshot();
        // The scan may lex a string literal, whose bytes the lexer
        // appends to the data segment; the snapshot does not cover
        // the data segment, so truncate it back before returning.
        let data_snap = self.data.len();
        let mut depth: i64 = 1;
        while depth > 0 && self.lex.tk != 0 {
            if self.lex.tk == '(' {
                depth += 1;
            } else if self.lex.tk == ')' {
                depth -= 1;
                if depth == 0 {
                    self.next()?;
                    break;
                }
            }
            self.next()?;
        }
        // The leaf may sit behind grouping parens and further casts
        // (`(T)(((U)(fn)))`); skip both to reach it.
        loop {
            if self.lex.tk != '(' {
                break;
            }
            self.next()?;
            if self.lex_is_type_start() {
                let mut d: i64 = 1;
                while d > 0 && self.lex.tk != 0 {
                    if self.lex.tk == '(' {
                        d += 1;
                    } else if self.lex.tk == ')' {
                        d -= 1;
                        if d == 0 {
                            self.next()?;
                            break;
                        }
                    }
                    self.next()?;
                }
            }
        }
        let reloc = self.lex.tk == Token::AndOp
            || self.lex.tk == '"'
            || (self.lex.tk == Token::Id && {
                let c = self.symbols[self.lex.curr_id_idx].class;
                c == Token::Fun as i64
                    || c == Token::Sys as i64
                    || (c == Token::Glo as i64
                        && self.symbols[self.lex.curr_id_idx].array_size != 0)
            });
        self.restore_lex(snap);
        self.truncate_data(data_snap);
        Ok(reloc)
    }

    /// True when the identifier under the cursor is the whole
    /// initializer. A function designator names its address only when
    /// nothing follows it: `f(...)` is a call, whose value the constant
    /// evaluator decides. The cursor is left where it was.
    fn id_ends_initializer(&mut self) -> Result<bool, C5Error> {
        let snap = self.lex.snapshot();
        self.next()?;
        let ends = self.at_initializer_end();
        self.restore_lex(snap);
        Ok(ends)
    }

    /// True when the cursor sits on a token that ends a scalar
    /// initializer: the declarator list's `,` / `;`, the `}` of a
    /// `{ value }` wrapper, or the `)` of a parenthesized initializer.
    /// Anything else means the value parsed so far is a sub-operand of a
    /// larger expression.
    fn at_initializer_end(&self) -> bool {
        self.lex.tk == ';' || self.lex.tk == ',' || self.lex.tk == '}' || self.lex.tk == ')'
    }

    /// Emit the link-time relocation for a data object's address stored
    /// into the 8-byte slot at `var_offset`. `target_offset` is the
    /// object's byte address plus any constant addend. An undefined extern
    /// is resolved by name (`ExternDataReloc`); a defined object writes its
    /// data-segment offset and a `DataReloc` the native writer / linker
    /// patches to the runtime address (ELF resolves the VA; Mach-O / PE
    /// emit a rebase / .reloc entry for the load slide). Under
    /// `is_thread_local` the slot is in the `_Thread_local`
    /// initialization template instead; the relocation is the same.
    fn emit_addr_reloc(
        &mut self,
        var_offset: i64,
        target_idx: usize,
        target_offset: i64,
        is_thread_local: bool,
    ) -> Result<(), C5Error> {
        // `is_thread_local` is the slot's storage, not the target's.
        self.reject_thread_local_addr_const(target_idx)?;
        // A block-scope static's address anchors to its emission record;
        // the binding slot is restored at scope exit (see `ast_emit_ident`).
        let target_idx = self.symbols[target_idx]
            .static_local_record
            .map_or(target_idx, |r| r as usize);
        self.symbols[target_idx].was_referenced = true;
        if !is_thread_local {
            self.note_init_reloc(var_offset as usize);
        }
        let t = &self.symbols[target_idx];
        let is_extern_data = t.is_extern_decl
            && t.linkage == crate::c5::symbol::Linkage::External
            && !t.has_initializer;
        if is_extern_data {
            let name = self.symbols[target_idx].link_name().into();
            let reloc = crate::c5::program::ExternDataReloc {
                data_offset: var_offset as u64,
                symbol_name: name,
                // The symbol's own `val` is a parse-time tentative slot
                // cleared at finalize; the addend is the byte offset alone.
                addend: target_offset - self.symbols[target_idx].val,
            };
            if is_thread_local {
                self.tls_extern_data_relocs.push(reloc);
            } else {
                self.extern_data_relocs.push(reloc);
            }
            return Ok(());
        }
        let bytes = (target_offset as u64).to_le_bytes();
        let reloc = crate::c5::program::DataReloc {
            data_offset: var_offset as u64,
            target_offset: target_offset as u64,
            target_anchor: self.symbols[target_idx].val as u64,
        };
        if is_thread_local {
            self.tls_data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
            self.tls_data_relocs.push(reloc);
            self.tls_data_reloc_sym_idx.push(target_idx);
        } else {
            self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
            self.data_relocs.push(reloc);
            self.data_reloc_sym_idx.push(target_idx);
        }
        Ok(())
    }

    /// Mark `tls_data[..off + 8]` as part of the loader's initialization
    /// template: a relocated slot must be file-backed `.tdata`, never
    /// `.tbss`.
    fn note_tls_init(&mut self, off: i64) {
        let end = off as usize + 8;
        if end > self.tls_init_size {
            self.tls_init_size = end;
        }
    }

    /// Store the shared constant-initializer evaluator's result into the
    /// `_Thread_local` template at `off`, routing the relocation, if any,
    /// to the TLS lists. Mirrors `write_init_value` for `.data`.
    fn write_tls_init_value(
        &mut self,
        line: usize,
        off: i64,
        value: i128,
        reloc: InitElemReloc,
        var_ty: i64,
    ) -> Result<(), C5Error> {
        let bits = self.to_storage_bits(value, reloc, var_ty);
        let at = off as usize;
        self.tls_data[at..at + 8].copy_from_slice(&(bits as u64).to_le_bytes());
        self.note_tls_init(off);
        match reloc {
            InitElemReloc::None | InitElemReloc::Float64Bits => {}
            InitElemReloc::Data(src_sym) => match src_sym {
                Some(sym_idx) => self.emit_addr_reloc(off, sym_idx, value as i64, true)?,
                // A string literal owns no symbol; the target is its own
                // staged offset in `data`.
                None => {
                    self.tls_data_relocs.push(crate::c5::program::DataReloc {
                        data_offset: off as u64,
                        target_offset: value as u64,
                        target_anchor: value as u64,
                    });
                    self.tls_data_reloc_sym_idx.push(usize::MAX);
                }
            },
            InitElemReloc::Code(sym_idx) => {
                self.symbols[sym_idx].was_referenced = true;
                self.tls_code_relocs.push(crate::c5::program::CodeReloc {
                    data_offset: off as u64,
                    target_ent_pc: value as u64,
                });
                self.tls_code_reloc_sym_idx.push(sym_idx);
            }
            // `&&label` names a block in the function being parsed; a
            // file-scope `_Thread_local` has no enclosing function.
            InitElemReloc::Label(_) => {
                return Err(self.compile_err_at(
                    line,
                    "`&&label` initializer for `_Thread_local` is not an address constant \
                     at file scope",
                ));
            }
        }
        Ok(())
    }

    /// Parse a global / TLS initializer's right-hand side and stash the
    /// bytes into [`Self::data`] / [`Self::tls_data`] at `var_offset`.
    /// An address constant (C99 6.6p9) comes from the shared
    /// constant-initializer evaluator; the arithmetic paths below fold
    /// the integer and floating cases.
    pub(super) fn parse_global_initializer(
        &mut self,
        var_ty: i64,
        var_offset: i64,
        is_thread_local: bool,
    ) -> Result<(), C5Error> {
        // A static object's initializer is a value position: block-scope
        // `const` scalar objects fold (`static int x = h;` inside a
        // function), as GCC accepts. No-op at file scope, where no
        // block-scope object is live.
        self.const_object_fold += 1;
        let r = self.with_nesting("initializer", |c| {
            c.parse_global_initializer_inner(var_ty, var_offset, is_thread_local)
        });
        self.const_object_fold -= 1;
        r
    }

    fn parse_global_initializer_inner(
        &mut self,
        var_ty: i64,
        var_offset: i64,
        is_thread_local: bool,
    ) -> Result<(), C5Error> {
        let line = self.lex.line;
        // C11 6.5.1.1 generic selection as a static initializer element:
        // select the association, initialize this slot from the winning
        // expression, then resume past the `_Generic(...)`.
        if self.lex.tk == Token::Generic {
            let after = self.generic_select_to_winner()?;
            self.parse_global_initializer_inner(var_ty, var_offset, is_thread_local)?;
            self.restore_lex(after);
            return Ok(());
        }
        // C99 6.7.8p11 allows a scalar initializer to be enclosed
        // in a single pair of braces: `int x = { 42 };`. Adjacent
        // string-literal concatenation may produce a multi-piece
        // RHS the lexer joins before this parser sees it. Strip
        // the wrapper and recurse.
        if self.lex.tk == '{' {
            self.next()?;
            self.parse_global_initializer(var_ty, var_offset, is_thread_local)?;
            // A trailing `,` before `}` is allowed in C99.
            self.accept(',')?;
            if self.lex.tk != '}' {
                return Err(self.compile_err_at(
                    line,
                    "scalar initializer wrapped in `{{ ... }}` must hold a single value",
                ));
            }
            self.next()?; // consume `}`
            return Ok(());
        }
        // C99 6.6p9 address constant. The shared constant-initializer
        // evaluator -- the one aggregate elements take -- decides which
        // construct this is, and sees the initializer whole because a leading
        // cast sets the stride of a trailing `+ n` (6.5.6p8). Anything else
        // rewinds to the arithmetic paths below. Thread storage duration
        // takes the same initializer forms as static (6.7.8p4); the
        // relocation lands on the initialization template instead of `.data`.
        {
            let cp = self.init_checkpoint();
            match self.parse_constant_init_value() {
                Ok((value, reloc))
                    if !matches!(reloc, InitElemReloc::None | InitElemReloc::Float64Bits)
                        && self.at_initializer_end() =>
                {
                    if is_thread_local {
                        self.write_tls_init_value(line, var_offset, value, reloc, var_ty)?;
                    } else {
                        self.write_init_value(var_offset as usize, 8, value, reloc, var_ty)?;
                    }
                    return Ok(());
                }
                _ => self.restore_init_checkpoint(cp),
            }
        }
        // Optional `(TYPE)` cast prefix. const-init only cares about
        // the resulting value, not the cast type, so we skip the
        // type spec and re-enter from the post-cast token. Common
        // in dispatch tables that cast each entry to a stub type
        // (`(SYSCALL)funcname`).
        // Detection is the same `lex_is_type_start` predicate the
        // runtime cast handler in `expr()` uses; if the inner token
        // isn't a type start, this is a parenthesised expression --
        // recurse on the inner and require the closing `)`.
        if self.lex.tk == '(' {
            let pre_paren = self.lex.snapshot();
            self.next()?;
            if self.lex_is_type_start() {
                // Fold the whole expression with the cast applied first: a
                // cast participating in arithmetic (`(char *)&s.b -
                // (char *)&s.a` strides by the cast's pointee, C99 6.5.6)
                // must not be discarded by the reloc-leaf shortcut below.
                // An arithmetic result that consumes the whole initializer
                // routes to the shared evaluator tail, which refolds it.
                let cp = self.init_checkpoint();
                let data_before = self.data.len();
                self.restore_lex(pre_paren);
                let whole = self.parse_const_expr_cond_val();
                // A parse that staged data (a string or compound literal)
                // folded an address needing its relocation; only a
                // stage-free arithmetic result takes the evaluator tail.
                let arithmetic = matches!(whole, Ok(ConstVal::Int { .. }) | Ok(ConstVal::Float(_)))
                    && self.at_initializer_end()
                    && self.data.len() == data_before;
                self.restore_init_checkpoint(cp);
                if arithmetic {
                    self.restore_lex(pre_paren);
                } else
                // A leading `(TYPE)` cast. When it applies to a
                // relocation leaf (`&x`, a string, a function or
                // global-array name) the value is the leaf's address and
                // the cast type is irrelevant, so skip the cast tokens and
                // recurse (the abstract-declarator grammar need not be
                // modelled twice). When it casts an arithmetic operand the
                // cast narrows (C99 6.3.1.3), so route the whole expression
                // through the const-expr evaluator below, which applies the
                // narrowing, instead of discarding the cast.
                if self.post_cast_is_reloc_leaf()? {
                    let mut depth: i64 = 1;
                    while depth > 0 && self.lex.tk != 0 {
                        if self.lex.tk == '(' {
                            depth += 1;
                        } else if self.lex.tk == ')' {
                            depth -= 1;
                            if depth == 0 {
                                self.next()?;
                                break;
                            }
                        }
                        self.next()?;
                    }
                    return self.parse_global_initializer(var_ty, var_offset, is_thread_local);
                }
                self.restore_lex(pre_paren);
            } else {
                // Parenthesised expression. Peek past the matching `)`: a
                // trailing operator means the parentheses wrap a sub-operand of a
                // larger constant expression (`(1) << 5`), which the
                // constant-expression evaluator below folds with full operator
                // precedence. A complete value -- `(&x)`, `(func)`, `(123)`, with
                // `,` / `;` / `}` next -- keeps the local recursion that handles
                // address and function-reference constants.
                let after_open = self.lex.snapshot();
                let mut depth: i64 = 1;
                while depth > 0 && self.lex.tk != 0 {
                    if self.lex.tk == '(' {
                        depth += 1;
                    } else if self.lex.tk == ')' {
                        depth -= 1;
                    }
                    self.next()?;
                }
                let trailing_operator = !(self.lex.tk == ','
                    || self.lex.tk == ';'
                    || self.lex.tk == '}'
                    || self.lex.tk == ')'
                    || self.lex.tk == 0);
                if trailing_operator {
                    // Re-parse the whole initializer through the float / integer
                    // constant-expression path below.
                    self.restore_lex(pre_paren);
                } else {
                    self.restore_lex(after_open);
                    self.parse_global_initializer(var_ty, var_offset, is_thread_local)?;
                    self.accept(')')?;
                    return Ok(());
                }
            }
        }
        // Bare function reference in a global initializer:
        // `static int (*fp)() = func;`. The value is the function's
        // ent_pc; a CodeReloc patches the slot to the runtime
        // code address at load time. Token::Sys (a libc-bound name)
        // routes through `ensure_sys_trampoline_sym` first to get a
        // synthetic Token::Fun whose val is filled in later by
        // `emit_sys_trampolines`; from that point on it follows the
        // same CodeReloc path as a user-defined function.
        if self.lex.tk == Token::Id
            && (self.symbols[self.lex.curr_id_idx].class == Token::Fun as i64
                || self.symbols[self.lex.curr_id_idx].class == Token::Sys as i64)
            && self.id_ends_initializer()?
        {
            let mut sym_idx = self.lex.curr_id_idx;
            if self.symbols[sym_idx].class == Token::Sys as i64 {
                sym_idx = self.ensure_sys_trampoline_sym(sym_idx);
            }
            self.symbols[sym_idx].was_referenced = true;
            let ent_pc = self.symbols[sym_idx].val;
            self.next()?;
            let bytes = (ent_pc as u64).to_le_bytes();
            let reloc = crate::c5::program::CodeReloc {
                data_offset: var_offset as u64,
                target_ent_pc: ent_pc as u64,
            };
            if is_thread_local {
                self.tls_data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
                self.note_tls_init(var_offset);
                self.tls_code_relocs.push(reloc);
                self.tls_code_reloc_sym_idx.push(sym_idx);
            } else {
                self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
                self.note_init_reloc(var_offset as usize);
                self.code_relocs.push(reloc);
                self.code_reloc_sym_idx.push(sym_idx);
            }
            return Ok(());
        }
        // Bare global array reference in a pointer initializer:
        // `int arr[N] = ...; int *p = arr;`. C99 6.3.2.1p3: an
        // lvalue of array type decays to a pointer to its first
        // element in every non-lvalue context, including a
        // global initializer. Emit the same `DataReloc` shape as
        // `&arr[0]` would: the slot holds the array's
        // data-segment offset; the writer / linker patches the
        // runtime VA at image-load time.
        if self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].class == Token::Glo as i64
            && self.symbols[self.lex.curr_id_idx].array_size != 0
            && is_pointer_ty(var_ty)
        {
            let target_idx = self.lex.curr_id_idx;
            self.next()?;
            // An extern array (`extern T a[]`) decays to a link-time
            // reference resolved by name; a local array decays to its own
            // data-segment offset. Both shapes are the address of the
            // symbol itself, so the addend is zero.
            let target_offset = self.symbols[target_idx].val;
            if is_thread_local {
                self.note_tls_init(var_offset);
            }
            self.emit_addr_reloc(var_offset, target_idx, target_offset, is_thread_local)?;
            return Ok(());
        }
        // `T *p = g.arr;` / `T *p = g.member.arr[i];` -- a bare designation of
        // a global's array sub-object decays to the address of its first
        // element (C99 6.3.2.1p3), an address constant. The whole-array case
        // above and the `&`-forms below cover their shapes; here the base is
        // any global (a union or a struct) reached through a `.`/`[` chain. A
        // chain ending in a non-array sub-object is a non-constant load and
        // falls through to the diagnostic below.
        if self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].class == Token::Glo as i64
            && is_pointer_ty(var_ty)
        {
            let snap = self.lex.snapshot();
            let data_snap = self.data.len();
            if let Some((off, sym_idx, is_array)) = self.parse_const_address()?
                && is_array
                && (self.lex.tk == ';' || self.lex.tk == ',')
            {
                if is_thread_local {
                    self.note_tls_init(var_offset);
                }
                self.emit_addr_reloc(var_offset, sym_idx, off, is_thread_local)?;
                return Ok(());
            }
            self.restore_lex(snap);
            self.truncate_data(data_snap);
        }
        // String literal in a `char *p` global initializer. Only when the
        // literal is the whole initializer: a trailing token (a `[i]`
        // subscript, an operator) makes it an operand of a larger constant
        // expression, which the evaluator tail folds.
        if self.lex.tk == '"' && is_pointer_ty(var_ty) {
            let cp = self.init_checkpoint();
            let addr = self.lex.ival;
            self.next()?;
            while self.lex.tk == '"' {
                self.next()?;
            }
            self.push_literal_nul();
            if !self.at_initializer_end() {
                self.restore_init_checkpoint(cp);
            } else {
                let bytes = (addr as u64).to_le_bytes();
                let reloc = crate::c5::program::DataReloc {
                    data_offset: var_offset as u64,
                    target_offset: addr as u64,
                    target_anchor: addr as u64,
                };
                // String-literal target -- no originating
                // symbol; sentinel marks the entry as
                // intra-unit only.
                if is_thread_local {
                    self.tls_data[var_offset as usize..var_offset as usize + 8]
                        .copy_from_slice(&bytes);
                    self.note_tls_init(var_offset);
                    self.tls_data_relocs.push(reloc);
                    self.tls_data_reloc_sym_idx.push(usize::MAX);
                } else {
                    self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
                    self.note_init_reloc(var_offset as usize);
                    self.data_relocs.push(reloc);
                    self.data_reloc_sym_idx.push(usize::MAX);
                }
                return Ok(());
            }
        }
        // `&`-rooted address constant (C99 6.6p9). What the operand is --
        // an object, a sub-object, a compound literal, or a function
        // designator, at any depth of parentheses (6.5.1p5) -- is decided by
        // the shared constant-initializer evaluator, the same one aggregate
        // elements take, so both contexts accept the same grammar. Only the
        // scalar storage rules stay here.
        if self.lex.tk == Token::AndOp {
            // The address may instead be the operand of a larger constant
            // expression (`&s.b - &s.a` folds to an integer, C99 6.5.6p9);
            // an incomplete parse rewinds to the arithmetic evaluator below.
            let cp = self.init_checkpoint();
            match self.parse_constant_init_value() {
                Ok((value, reloc)) if self.at_initializer_end() => {
                    if is_thread_local {
                        self.write_tls_init_value(line, var_offset, value, reloc, var_ty)?;
                    } else {
                        self.write_init_value(var_offset as usize, 8, value, reloc, var_ty)?;
                    }
                    return Ok(());
                }
                _ => self.restore_init_checkpoint(cp),
            }
        }

        // Float / double scalar global with a constant-foldable
        // float expression: `static float gamma = 1.0f / 2.2f;` and
        // similar. The integer constant evaluator can't see through
        // `/`, `*`, etc. on float operands, so route through the
        // f64 folder in initializer.rs. The result is stored as the
        // full 8 bytes the slot was sized for; a future
        // f32-narrow-storage path would shrink it for `float`.
        let var_is_float = {
            let stripped = strip_unsigned(var_ty);
            stripped == Ty::Float as i64 || stripped == Ty::Double as i64
        };
        // Constant expression, evaluated at compile time. Handles
        // integer literals, unary `+`/`-`, casts (`(size_t)expr`),
        // arithmetic, parens, identifiers bound as `Token::Num`
        // (enum / `#define`d constants), the conditional operator
        // (`static int n = A > B ? A : B;`), and the offsetof shape.
        let cv = self.parse_const_expr_cond_val()?;
        // C99 6.6 / 6.3.2.3: an address constant cast to a pointer-width
        // integer slot (`unsigned long x = (unsigned long)&obj;`, an object,
        // array, or function name) is a link-time relocation, not a
        // compile-time integer -- gcc / clang accept it and the linker
        // resolves the address. Emit the same relocation the pointer-typed
        // slot would. Restricted to a bare designator (offset equal to the
        // symbol's own address): a symbol-relative addend from a const-expr
        // `+`/`-` is not scaled by the pointee size here, so it stays rejected
        // rather than stored with a wrong offset. A `&sym[i]` / `&sym.field`
        // suffix, and any narrower slot, are handled by the paths above; the
        // rest falls through to the reject below, which gcc / clang also
        // apply to a sub-pointer-width slot.
        if let ConstVal::Addr(a) = cv
            && let Some(sym_idx) = a.root.sym()
            && a.value == self.symbols[sym_idx].val
            && !var_is_float
            && self.size_of_type(var_ty) == 8
        {
            if matches!(a.root, super::const_expr::ConstRoot::Code(_)) {
                self.symbols[sym_idx].was_referenced = true;
                let ent_pc = self.symbols[sym_idx].val;
                let bytes = (ent_pc as u64).to_le_bytes();
                let reloc = crate::c5::program::CodeReloc {
                    data_offset: var_offset as u64,
                    target_ent_pc: ent_pc as u64,
                };
                if is_thread_local {
                    self.tls_data[var_offset as usize..var_offset as usize + 8]
                        .copy_from_slice(&bytes);
                    self.note_tls_init(var_offset);
                    self.tls_code_relocs.push(reloc);
                    self.tls_code_reloc_sym_idx.push(sym_idx);
                } else {
                    self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
                    self.note_init_reloc(var_offset as usize);
                    self.code_relocs.push(reloc);
                    self.code_reloc_sym_idx.push(sym_idx);
                }
            } else {
                if is_thread_local {
                    self.note_tls_init(var_offset);
                }
                self.emit_addr_reloc(var_offset, sym_idx, a.value, is_thread_local)?;
            }
            return Ok(());
        }
        // A bare symbol address in a narrower-than-pointer integer slot is
        // not a relocation-bearing initializer; reject it rather than store
        // the addend with no relocation.
        let cv = self.require_integer_const(cv)?;

        // C99 6.7.8p11 / 6.3.1.4: a constant initializing a floating
        // object takes the floating value. Coerce the ConstVal to f64
        // here rather than through `as_int` first, which truncated the
        // fraction of a float-valued expression whose leading token is
        // an integer (e.g. `3 * 0.5`). Narrow to the slot width (f32
        // for `float`, f64 for `double`).
        let value = if var_is_float {
            self.to_storage_bits(
                cv.as_float().to_bits() as i128,
                InitElemReloc::Float64Bits,
                var_ty,
            )
        } else {
            cv.as_i128()
        };
        // Integer slots are preallocated 8 bytes wide; the 16-byte
        // integer needs both halves written.
        let write_size = if var_is_float || self.is_int128_ty(var_ty) {
            self.size_of_type(var_ty)
        } else {
            8
        };

        let bytes = value.to_le_bytes();
        let segment = if is_thread_local {
            &mut self.tls_data
        } else {
            &mut self.data
        };
        let off = var_offset as usize;
        // Both segments preallocated 8 zero bytes for this
        // variable; we overwrite the slot with the
        // initializer's bytes.
        debug_assert!(off + write_size <= segment.len());
        segment[off..off + write_size].copy_from_slice(&bytes[..write_size]);

        if is_thread_local {
            // Move the .tdata/.tbss boundary so this slot is
            // part of the loader's initial template. Once any
            // TLS init lands, every TLS byte before it (and
            // the trailing zero-init bytes too, eventually)
            // gets routed through the template path; that's
            // fine because the bytes are still byte-for-byte
            // correct. Per-format writers handle the layout.
            let end = off + 8;
            if end > self.tls_init_size {
                self.tls_init_size = end;
            }
        }

        // Type-check: warn (don't error) if the constant doesn't match
        // the declared type. Only pointer-vs-int mismatches are
        // diagnosed here, matching the assignment path. `init_ty` is
        // synthesized from the folded constant rather than carried from
        // the initializer expression, so it is too coarse to raise a
        // 6.7.8p11 constraint error on; the aggregate initializer path
        // checks element types against real ones.
        let init_ty = if value == 0 { 0 } else { Ty::Int as i64 };
        if let Some(m) = Self::type_warning(&self.structs, var_ty, init_ty, value == 0) {
            let var_s = super::types::format_type(var_ty, &self.structs);
            let init_s = super::types::format_type(init_ty, &self.structs);
            self.warn_at(
                line,
                format!(
                    "{} in global initializer (var={var_s}, value={init_s})",
                    m.reason
                ),
            );
        }
        Ok(())
    }
}

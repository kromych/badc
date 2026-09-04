//! Global / TLS initializer parser: the right-hand side of a
//! static-storage scalar's `=`.
//!
//! What the initializer is comes from `initializer.rs`'s
//! `parse_constant_init_value`, the constant-expression evaluator
//! aggregate elements take, so both contexts accept one grammar. How a
//! scalar slot stores the result stays here: the `.data` / `.tdata`
//! split, the slot width, which relocation list a slot's address
//! constant joins, and the type-mismatch warning.

use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::const_expr::ConstVal;
use super::initializer::InitElemReloc;
use super::types::{is_pointer_ty, strip_unsigned};

impl Compiler {
    /// True when the cast under the cursor applies to a
    /// relocation-bearing leaf (`&x`, a string literal, or a function /
    /// global-array name) rather than an arithmetic value: a reloc leaf
    /// keeps the address-folding path, an arithmetic cast reaches the
    /// const-expr evaluator, which narrows per C99 6.3.1.3. Entered just
    /// inside the cast paren; the lexer is restored before returning.
    pub(super) fn post_cast_is_reloc_leaf(&mut self) -> Result<bool, C5Error> {
        let snap = self.lex.snapshot();
        // The scan may lex a string literal, whose bytes the lexer
        // appends to the data segment, which the snapshot does not cover.
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
    /// into the 8-byte slot at `var_offset`, where `target_offset` is the
    /// object's byte address plus any constant addend. An undefined
    /// extern resolves by name (`ExternDataReloc`); a defined object
    /// writes its data-segment offset plus a `DataReloc` the writer
    /// patches to the runtime address. `is_thread_local` puts the slot in
    /// the initialization template; the relocation is the same.
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
        // A block-scope `const` scalar object folds into a static
        // object's initializer, as GCC accepts. No-op at file scope.
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
        // C99 6.7.8p11: a scalar initializer may be enclosed in one
        // pair of braces. Strip the wrapper and recurse.
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
        // C99 6.6p9 address constant, decided by the shared
        // constant-initializer evaluator, which sees the initializer
        // whole because a leading cast sets the stride of a trailing
        // `+ n` (6.5.6p8). Anything else rewinds to the arithmetic paths
        // below. Thread storage duration takes the same forms (6.7.8p4)
        // with the relocation on the initialization template.
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
        // A leading `(` is a cast prefix, a compound literal or a
        // parenthesized constant expression.
        if self.lex.tk == '('
            && self.write_global_paren_initializer(var_ty, var_offset, is_thread_local)?
        {
            return Ok(());
        }
        // A bare function name (`static int (*fp)() = func;`) is its
        // ent_pc plus a CodeReloc. A libc-bound name takes a trampoline
        // symbol first, then the same path.
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
        // C99 6.3.2.1p3: an array lvalue decays to a pointer to its
        // first element, here as the `&arr[0]` relocation shape -- the
        // slot holds the data-segment offset the writer patches.
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
        // A string literal is the slot's value only when it is the whole
        // initializer; a trailing `[i]` or operator makes it an operand
        // the evaluator tail folds.
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
                // A string literal owns no symbol; the sentinel marks
                // the entry intra-unit.
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

        self.write_global_scalar_initializer(var_ty, var_offset, is_thread_local, line)
    }

    /// A parenthesized scalar initializer: a `(T)expr` cast, an array or
    /// struct compound literal whose address the slot takes, or a
    /// parenthesized constant expression (C99 6.6).
    fn write_global_paren_initializer(
        &mut self,
        var_ty: i64,
        var_offset: i64,
        is_thread_local: bool,
    ) -> Result<bool, C5Error> {
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
            // A cast over a relocation leaf (`&x`, a string, a
            // function or global-array name) contributes nothing to the
            // value, so the cast tokens are skipped. A cast over an
            // arithmetic operand narrows (C99 6.3.1.3) and goes to the
            // const-expr evaluator, which applies it.
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
                self.parse_global_initializer(var_ty, var_offset, is_thread_local)?;
                return Ok(true);
            }
            self.restore_lex(pre_paren);
        } else {
            // A parenthesized expression. An operator past the matching
            // `)` makes it a sub-operand of a larger constant expression
            // (`(1) << 5`), which the evaluator below folds with full
            // precedence; a complete value keeps the local recursion,
            // which handles the address and function-reference forms.
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
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// The scalar tail: fold the initializer as an arithmetic or address
    /// constant expression and write it into the object's slot.
    fn write_global_scalar_initializer(
        &mut self,
        var_ty: i64,
        var_offset: i64,
        is_thread_local: bool,
        line: usize,
    ) -> Result<(), C5Error> {
        // A floating destination takes the f64 folder: the integer
        // constant evaluator does not fold arithmetic on float
        // operands. The result fills the 8 bytes the slot was sized for.
        let var_is_float = {
            let stripped = strip_unsigned(var_ty);
            stripped == Ty::Float as i64 || stripped == Ty::Double as i64
        };
        // C99 6.6 constant expression.
        let cv = self.parse_const_expr_cond_val()?;
        // C99 6.6 / 6.3.2.3: an address constant in a pointer-width
        // integer slot is a link-time relocation, and takes the one a
        // pointer-typed slot would; gcc and clang accept it. Restricted
        // to a bare designator, whose offset is the symbol's own address:
        // a const-expr addend is not scaled by the pointee size here, so
        // it stays rejected rather than stored at a wrong offset.
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

        // C99 6.7.9p11 initializes as if by assignment, so the constant
        // converts to the declared type. A floating constant keeps its
        // floating form to here: an `as_int` first would truncate the
        // fraction of `3 * 0.5`, and 6.3.1.2 has a `_Bool` destination
        // test the value against 0 rather than truncate it.
        let value = if var_is_float || matches!(cv, ConstVal::Float(_)) {
            self.to_storage_bits(
                cv.as_float().to_bits() as i128,
                InitElemReloc::Float64Bits,
                var_ty,
            )
        } else {
            self.to_storage_bits(cv.as_i128(), InitElemReloc::None, var_ty)
        };
        // An integer slot is 8 bytes wide, so a 16-byte value needs
        // both halves written.
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
        // The slot is 8 preallocated zero bytes in either segment.
        debug_assert!(off + write_size <= segment.len());
        segment[off..off + write_size].copy_from_slice(&bytes[..write_size]);

        if is_thread_local {
            // A written slot has to be file-backed `.tdata`, so move
            // the boundary past it.
            let end = off + 8;
            if end > self.tls_init_size {
                self.tls_init_size = end;
            }
        }

        // Pointer-vs-integer mismatches warn, as the assignment path
        // does. `init_ty` is synthesized from the folded constant rather
        // than carried from the expression, so it is too coarse for a
        // 6.7.8p11 constraint error; the aggregate path checks element
        // types against real ones.
        let init_ty = if value == 0 { 0 } else { Ty::Int as i64 };
        if let Some(m) = Self::type_warning(&self.structs, var_ty, init_ty, value == 0) {
            let var_s = super::types::format_type(var_ty, &self.structs);
            let init_s = super::types::format_type(init_ty, &self.structs);
            self.warn_at(
                m.code,
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

//! `sizeof` and `_Alignof` operands (C99 6.5.3.4), shared by the
//! runtime and constant-expression parsers, and the GCC builtins that
//! read an operand unevaluated: `__builtin_object_size`,
//! `__builtin_choose_expr`, `__builtin_has_attribute`,
//! `__builtin_constant_p`.

use super::super::diag::Code;
use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::expr::TypeName;
use super::types::{is_struct_value_ty, struct_id_of, struct_ptr_depth};
use super::{Compiler, StructField};

impl Compiler {
    /// Whether `sizeof ( id )` is the bare-identifier form: the identifier
    /// is followed by `)` and no postfix operator follows that. Otherwise
    /// the parentheses belong to a unary-expression (`sizeof(a)[i]` is
    /// `sizeof((a)[i])`, C99 6.5.3.4). The lexer position is unchanged.
    fn sizeof_bare_id_paren_ok(&mut self) -> Result<bool, C5Error> {
        let snap = self.lex.snapshot();
        self.next()?; // past the identifier
        let mut ok = false;
        if self.lex.tk == ')' {
            self.next()?; // past the close paren
            ok = self.lex.tk != Token::Brak
                && self.lex.tk != Token::Dot
                && self.lex.tk != Token::Arrow;
        }
        self.restore_lex(snap);
        Ok(ok)
    }

    /// C11 6.5.3.4p1: neither operator applies to an incomplete type. A
    /// pointer to an incomplete tag is itself complete, so the callers
    /// check only where no pointer decoration was parsed.
    fn require_complete_operand(&self, ty: i64, op: &str) -> Result<(), C5Error> {
        match self.incomplete_aggregate_tag(ty) {
            Some(_) => Err(self.compile_err(
                Code::INVALID_DECLARATION,
                alloc::format!("`{op}` applied to an incomplete type"),
            )),
            None => Ok(()),
        }
    }

    /// The byte count of a `sizeof` operand, the keyword consumed: a
    /// parenthesized type name, a bare identifier, or a unary-expression
    /// parsed unevaluated. `self.ty` is restored on return.
    pub(super) fn sizeof_operand_bytes(&mut self) -> Result<i64, C5Error> {
        // Cleared each call; set only when the operand is a VLA whose
        // size the `sizeof` site must read at runtime (C99 6.5.3.4p2).
        self.pending.sizeof_vla_size_slot = None;
        // C99 6.5.3.4 admits `sizeof unary-expression` and
        // `sizeof ( type-name )`: a `(` consumed for a type name is put back
        // when the content is an expression, so a trailing `->` / `.` / `[`
        // stays with the operand.
        let pre_paren_snap = self.lex.snapshot();
        let leading_paren = self.lex.tk == '(';
        if leading_paren {
            self.next()?;
        }
        let saved_ty = self.ty;
        // `had_paren`: the closing `)` is this operator's to consume.
        let mut had_paren = leading_paren;
        let total: i64 = if had_paren && self.lex_is_type_start() {
            let type_name = self.parse_type_name()?;
            self.sizeof_type_name(&type_name)?
        } else if self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].class != 0
            && !self.lex.peek_after_whitespace(b'-')
            && !self.lex.peek_after_whitespace(b'.')
            && !self.lex.peek_after_whitespace(b'[')
            && (!had_paren || self.sizeof_bare_id_paren_ok()?)
        {
            // A declared identifier is looked up directly, so an array yields
            // its whole size; a postfix form or an undeclared name (C99 6.5.1p2)
            // takes the expression path and its diagnostics.
            let idx = self.lex.curr_id_idx;
            let var_ty = self.symbols[idx].type_;
            let arr = self.symbols[idx].array_size;
            // An array declared with an unspecified bound (`extern T x[];`,
            // C99 6.7.5.2p4) has no size here either; a zero-length array
            // is a complete type.
            self.require_complete_operand(var_ty, "sizeof")?;
            if arr < 0 && !self.symbols[idx].is_zero_len_array {
                return Err(self.compile_err(
                    Code::INVALID_DECLARATION,
                    "`sizeof` applied to an incomplete type",
                ));
            }
            // C99 6.5.3.4p2: `sizeof` of a VLA is loaded from its size slot;
            // the constant returned is unused then.
            if self.symbols[idx].is_vla {
                self.pending.sizeof_vla_size_slot = Some(self.symbols[idx].vla_size_slot);
            }
            self.next()?;
            if self.symbols[idx].is_zero_len_array {
                // `T x[] = {}`: 0 bytes; the `array_size == 0` scalar encoding
                // would report `sizeof(T)`.
                0
            } else if arr > 0 {
                arr * self.size_of_type(var_ty) as i64
            } else {
                self.size_of_type(var_ty) as i64
            }
        } else {
            // The operand is parsed and everything it emitted dropped (C99
            // 6.5.3.4: unevaluated); the array-decay hints carry a decayed
            // array's shape. The PC counter and the relocation symbol shadow,
            // parallel to the relocations, are rewound with the code.
            let saved_text_len = self.next_ent_pc;
            let saved_code_reloc_sym_idx = self.code_reloc_sym_idx.len();
            // The `(` belongs to the operand: restore it for the expression
            // parser's own postfix loop.
            if had_paren {
                self.restore_lex(pre_paren_snap);
                had_paren = false;
            }
            let lev = Token::Inc as i64;
            self.pending.last_array_decay_size = 0;
            self.pending.last_array_decay_bytes = 0;
            self.pending.last_array_decay_member = None;
            self.expr(lev)?;
            let array_count = self.pending.last_array_decay_size;
            let array_bytes = self.pending.last_array_decay_bytes;
            let expr_ty = self.ty;
            self.next_ent_pc = saved_text_len;
            self.clear_recent_emits();
            self.code_reloc_sym_idx.truncate(saved_code_reloc_sym_idx);
            self.pending.last_array_decay_size = 0;
            self.pending.last_array_decay_bytes = 0;
            self.pending.last_array_decay_member = None;
            if array_bytes > 0 {
                // A row of a pointer to an array or of a multi-dimensional array:
                // its byte count, which the flat type cannot express.
                array_bytes
            } else if array_count > 0 {
                // A decayed 1D array: `N * sizeof(T)` from the `T *` type.
                let elem_ty = expr_ty - Ty::Ptr as i64;
                array_count * self.size_of_type(elem_ty) as i64
            } else if array_count < 0 {
                // A decayed zero-length array: 0 bytes.
                0
            } else {
                // An expression operand reaches the same constraint
                // (`sizeof(*p)` for a pointer to an incomplete tag).
                self.require_complete_operand(expr_ty, "sizeof")?;
                self.size_of_type(expr_ty) as i64
            }
        };
        if had_paren {
            if self.lex.tk == ')' {
                self.next()?;
            } else {
                return Err(self.compile_err(Code::SYNTAX, "close paren expected in sizeof"));
            }
        }
        self.ty = saved_ty;
        Ok(total)
    }

    /// GCC `__builtin_object_size(ptr, type)`, `type` in 0..=3: a
    /// `size_t` constant. The pointer operand is unevaluated, like a
    /// `sizeof` operand. Types 0 and 2 ask for the whole object, 1 and
    /// 3 for the closest enclosing subobject; "unknown" is `(size_t)-1`
    /// for the maximum forms (0 and 1) and 0 for the minimum forms. A
    /// declared array, string literal or compound literal is the whole
    /// object. An array member of a declared object is bounded by the
    /// object; through a pointer the whole object is unknown and the
    /// member answers its size unless `member_is_unbounded`. A member
    /// with no declared bound answers the space remaining in the object
    /// holding it, for the subobject forms as well as the whole-object
    /// ones, since it has no extent of its own to narrow to.
    pub(super) fn parse_object_size_builtin(&mut self) -> Result<(), C5Error> {
        // The call dispatch consumed `__builtin_object_size (`.
        let saved_ty = self.ty;
        let saved_text_len = self.next_ent_pc;
        let saved_reloc = self.code_reloc_sym_idx.len();
        let saved_acc = self.ast_acc.take();
        let vstack_depth = self.ast_vstack.len();
        self.pending.last_array_decay_size = 0;
        self.pending.last_array_decay_bytes = 0;
        self.pending.last_array_decay_member = None;
        self.expr(Token::Assign as i64)?;
        let array_count = self.pending.last_array_decay_size;
        let array_bytes = self.pending.last_array_decay_bytes;
        let member = self.pending.last_array_decay_member.take();
        let expr_ty = self.ty;
        self.next_ent_pc = saved_text_len;
        self.clear_recent_emits();
        self.code_reloc_sym_idx.truncate(saved_reloc);
        self.ast_vstack.truncate(vstack_depth);
        self.ast_acc = saved_acc;
        self.pending.last_array_decay_size = 0;
        self.pending.last_array_decay_bytes = 0;
        self.ty = saved_ty;
        if self.lex.tk != ',' {
            return Err(self.compile_err(Code::SYNTAX, "`,` expected in `__builtin_object_size`"));
        }
        self.next()?;
        let kind = self.parse_constant_int()?;
        if !(0..=3).contains(&kind) {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                "`__builtin_object_size` type must be 0..=3",
            ));
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err(
                Code::SYNTAX,
                "`)` expected to close `__builtin_object_size`",
            ));
        }
        self.next()?;
        // `-1` marks an array with no declared bound: a flexible array
        // member (C99 6.7.2.1p16) or a zero-length one.
        let flexible = array_count < 0;
        let known: Option<i64> = if array_bytes > 0 {
            Some(array_bytes)
        } else if array_count > 0 {
            let elem_ty = expr_ty - Ty::Ptr as i64;
            Some(array_count * self.size_of_type(elem_ty) as i64)
        } else if flexible {
            // Zero-length array: a known object of 0 bytes.
            Some(0)
        } else {
            None
        };
        let unknown = if kind <= 1 { -1 } else { 0 };
        let v = match (known, member) {
            (None, _) => unknown,
            // TODO: a row reached through a pointer to an array answers
            // the row's size, where the object holding it is unknown.
            (Some(n), None) => n,
            (Some(n), Some(m)) if kind & 1 == 1 => {
                if m.unbounded {
                    unknown
                } else if flexible {
                    // A member with no declared bound has no extent of its
                    // own, so the closest surrounding subobject with one is
                    // the object holding it -- when the chain started at a
                    // declared object. Answering the member's nominal 0
                    // there reports that no byte may be written, which is
                    // what FORTIFY_SOURCE reads to reject every write into
                    // a flexible array member. Through a pointer there is
                    // no such object, and the declared extent stands.
                    m.decl_remaining.unwrap_or(n)
                } else {
                    n
                }
            }
            (Some(_), Some(m)) => m.decl_remaining.unwrap_or(unknown),
        };
        self.emit_imm(v);
        self.ty = self.size_t_ty();
        self.ast_emit_int_lit(v, self.ty);
        Ok(())
    }

    /// How many struct (not union) containers member `idx` of aggregate
    /// `sid` lies in, the aggregate itself and the anonymous aggregates
    /// the member was promoted from included, and whether each of them
    /// holds the member, or the anonymous aggregate holding it, last.
    pub(super) fn member_nesting(&self, sid: usize, idx: usize) -> (u32, bool) {
        let (mut sid, mut idx) = (sid, idx as u32);
        let (mut records, mut at_end) = (0, true);
        loop {
            let s = &self.structs[sid];
            let anon = s
                .anon_members
                .iter()
                .find(|m| (m.first..m.first + m.count).contains(&idx));
            let end = anon.map_or(idx + 1, |m| m.first + m.count) as usize;
            if !s.is_union {
                records += 1;
                at_end &= end == s.fields.len();
            }
            match anon {
                Some(m) => (sid, idx) = (m.inner, idx - m.first),
                None => return (records, at_end),
            }
        }
    }

    /// gcc's rule for an array member reached through a pointer: it has
    /// no bound the object can be held to when its type is incomplete,
    /// or when `-fstrict-flex-arrays` admits its bound and it is the last
    /// member of every container on the way, at most one of which is a
    /// struct (`records` and `at_end` as `member_nesting` counts them,
    /// accumulated over the chain).
    pub(super) fn member_is_unbounded(&self, f: &StructField, records: u32, at_end: bool) -> bool {
        if f.array_size < 0 && !f.zero_len {
            return true;
        }
        let outer = if f.array_dims.len() >= 2 {
            f.array_dims[0]
        } else {
            f.array_size
        };
        let admitted = match self.strict_flex_arrays {
            0 => true,
            1 => outer <= 1,
            2 => f.array_size < 0,
            _ => false,
        };
        admitted && records <= 1 && at_end
    }

    /// GCC `__builtin_choose_expr(const, e1, e2)`: the chosen operand
    /// IS the expression -- its exact type carries through (no `?:`
    /// arithmetic conversions) and the other operand is parsed but not
    /// evaluated. The condition must fold to an integer constant.
    pub(super) fn parse_choose_expr_builtin(&mut self) -> Result<(), C5Error> {
        // The call dispatch consumed `__builtin_choose_expr (`.
        let cond = self.parse_constant_int()?;
        if self.lex.tk != ',' {
            return Err(self.compile_err(Code::SYNTAX, "`,` expected in `__builtin_choose_expr`"));
        }
        self.next()?;
        let parse_arm = |me: &mut Self, live: bool| -> Result<(), C5Error> {
            if live {
                return me.expr(Token::Assign as i64);
            }
            // Discarded operand: parse for syntax, drop every emission
            // (same rollback set as the unevaluated `sizeof` operand).
            let saved_ty = me.ty;
            let saved_text_len = me.next_ent_pc;
            let saved_reloc = me.code_reloc_sym_idx.len();
            let saved_acc = me.ast_acc.take();
            let vstack_depth = me.ast_vstack.len();
            me.expr(Token::Assign as i64)?;
            me.next_ent_pc = saved_text_len;
            me.clear_recent_emits();
            me.code_reloc_sym_idx.truncate(saved_reloc);
            me.ast_vstack.truncate(vstack_depth);
            me.ast_acc = saved_acc;
            me.ty = saved_ty;
            Ok(())
        };
        parse_arm(self, cond != 0)?;
        if self.lex.tk != ',' {
            return Err(self.compile_err(Code::SYNTAX, "`,` expected in `__builtin_choose_expr`"));
        }
        self.next()?;
        parse_arm(self, cond == 0)?;
        if self.lex.tk != ')' {
            return Err(self.compile_err(
                Code::SYNTAX,
                "`)` expected to close `__builtin_choose_expr`",
            ));
        }
        self.next()?;
        Ok(())
    }

    /// GCC `__builtin_has_attribute(operand, attribute)`: an `int`
    /// constant. badc does not model the queried attributes on objects or
    /// types, so under its own semantics no operand carries one -- the
    /// answer is 0. Both operands are consumed unevaluated.
    pub(super) fn parse_has_attribute_builtin(&mut self) -> Result<(), C5Error> {
        // The call dispatch consumed `__builtin_has_attribute (`.
        self.skip_balanced_to_comma()?;
        if self.lex.tk != ',' {
            return Err(self.compile_err(Code::SYNTAX, "`,` expected in `__builtin_has_attribute`"));
        }
        self.next()?;
        self.skip_balanced_to_close_paren()?;
        self.ty = Ty::Int as i64;
        self.emit_imm(0);
        self.ast_emit_int_lit(0, self.ty);
        Ok(())
    }

    /// GCC `__builtin_constant_p(x)`: an `int`, 1 when the unevaluated
    /// operand folds to a constant value. A parse-time constant answers
    /// 1, which no later phase revises. A non-constant operand can still
    /// become one after inlining and constant propagation, so where
    /// deferring is sound it becomes an `Intrinsic::ConstantP` for the
    /// SSA folds; otherwise the conservative 0 stands.
    pub(super) fn parse_constant_p_builtin(&mut self) -> Result<(), C5Error> {
        // The call dispatch consumed `__builtin_constant_p (`.
        let snap = self.lex.snapshot();
        if self.eval_constant_p_operand()? == 1 {
            self.emit_imm(1);
            self.ty = Ty::Int as i64;
            self.ast_emit_int_lit(1, self.ty);
            return Ok(());
        }
        self.restore_lex(snap);
        self.expr(Token::Assign as i64)?;
        if self.lex.tk != ')' {
            return Err(
                self.compile_err(Code::SYNTAX, "`)` expected to close `__builtin_constant_p`")
            );
        }
        self.next()?;
        let operand = self.ast_acc.take();
        self.ty = Ty::Int as i64;
        match operand {
            Some(id) if self.constant_p_operand_defers(id) => {
                let pos = self.ast_src_pos();
                let node = self.ast.push_expr(
                    super::super::ast::Expr::Intrinsic {
                        kind: crate::c5::op::Intrinsic::ConstantP as i64,
                        args: alloc::vec![id],
                        ty: self.ty,
                    },
                    pos,
                );
                self.ast_acc = Some(node);
                self.mark_emit_other();
            }
            _ => {
                // The parsed operand is dropped unreferenced: its side
                // effects are never walked, matching GCC's unevaluated
                // operand.
                self.emit_imm(0);
                self.ast_emit_int_lit(0, self.ty);
            }
        }
        Ok(())
    }

    /// Whether a non-constant `__builtin_constant_p` operand may defer to
    /// the SSA folds. Deferring lowers the operand so the inliner's
    /// argument substitution can reach it, which is sound only when that
    /// lowering neither has side effects nor traps: scalar locals and
    /// parameters qualify; calls, pointer loads, volatile and
    /// address-space-qualified accesses, and division do not.
    fn constant_p_operand_defers(&self, id: super::super::ast::ExprId) -> bool {
        use super::super::ast::{Expr, UnOp};
        use super::super::ir::BinOp;
        use super::types::{is_struct_value_ty, is_volatile_ty, segment_of_ty};
        match self.ast.expr(id) {
            Expr::IntLit { .. } | Expr::FloatLit { .. } | Expr::Sizeof(_) => true,
            Expr::Ident {
                sym,
                ty,
                class,
                array_size,
                is_thread_local,
                ..
            } => {
                *class == Token::Loc as i64
                    && *array_size == 0
                    && !*is_thread_local
                    && !is_volatile_ty(*ty)
                    && segment_of_ty(*ty).is_none()
                    && !is_struct_value_ty(*ty)
                    && !self
                        .symbols
                        .get(*sym as usize)
                        .is_some_and(|s| s.is_global_register)
            }
            Expr::Unary {
                op: UnOp::Neg | UnOp::BitNot | UnOp::LogNot,
                child,
                ..
            } => self.constant_p_operand_defers(*child),
            Expr::Binary { op, lhs, rhs, .. } => {
                !matches!(op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu)
                    && self.constant_p_operand_defers(*lhs)
                    && self.constant_p_operand_defers(*rhs)
            }
            Expr::ShortCircuit { lhs, rhs, .. } => {
                self.constant_p_operand_defers(*lhs) && self.constant_p_operand_defers(*rhs)
            }
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                ..
            } => {
                self.constant_p_operand_defers(*cond)
                    && self.constant_p_operand_defers(*then_e)
                    && self.constant_p_operand_defers(*else_e)
            }
            Expr::Cast { child, to_ty } => {
                !is_struct_value_ty(*to_ty) && self.constant_p_operand_defers(*child)
            }
            _ => false,
        }
    }

    /// C11 6.5.3.4 `_Alignof ( type-name )`, and GCC's `__alignof__` on an
    /// expression (both spellings share the token). An array's alignment
    /// is its element's (C11 6.2.8); a pointer's is the pointer's.
    pub(super) fn alignof_operand_bytes(&mut self) -> Result<i64, C5Error> {
        // An unparenthesized operand: an expression, parsed unevaluated at
        // unary precedence as for `sizeof`.
        if self.lex.tk != '(' {
            if let Some(align) = self.alignof_object_walk(false)? {
                return Ok(align);
            }
            let saved_ty = self.ty;
            let saved_text_len = self.next_ent_pc;
            let saved_reloc = self.code_reloc_sym_idx.len();
            self.expr(Token::Inc as i64)?;
            let expr_ty = self.ty;
            self.next_ent_pc = saved_text_len;
            self.clear_recent_emits();
            self.code_reloc_sym_idx.truncate(saved_reloc);
            self.ty = saved_ty;
            self.require_complete_operand(expr_ty, "_Alignof")?;
            return Ok(self.align_of_type(expr_ty) as i64);
        }
        self.next()?;
        // A parenthesized expression, parsed unevaluated.
        if !self.lex_is_type_start() {
            if let Some(align) = self.alignof_object_walk(true)? {
                self.next()?; // consume `)`
                return Ok(align);
            }
            let saved_ty = self.ty;
            let saved_text_len = self.next_ent_pc;
            let saved_reloc = self.code_reloc_sym_idx.len();
            self.expr(Token::Assign as i64)?;
            let expr_ty = self.ty;
            self.next_ent_pc = saved_text_len;
            self.clear_recent_emits();
            self.code_reloc_sym_idx.truncate(saved_reloc);
            self.ty = saved_ty;
            if self.lex.tk != ')' {
                return Err(self.compile_err(Code::SYNTAX, "`)` expected to close `_Alignof`"));
            }
            self.next()?;
            self.require_complete_operand(expr_ty, "_Alignof")?;
            return Ok(self.align_of_type(expr_ty) as i64);
        }
        let type_name = self.parse_type_name()?;
        if self.lex.tk != ')' {
            return Err(self.compile_err(Code::SYNTAX, "`)` expected to close `_Alignof`"));
        }
        self.next()?;
        // A typedef base may carry an explicit type alignment (GNU
        // `aligned(N)`). It applies to the type and to an array of it
        // (C11 6.2.8: an array's alignment is its element's), but a
        // pointer to it has pointer alignment.
        let is_pointer = type_name.ptr_levels > 0;
        if !is_pointer {
            self.require_complete_operand(type_name.ty, "_Alignof")?;
        }
        Ok(if type_name.type_align > 0 && !is_pointer {
            type_name.type_align
        } else {
            self.align_of_type(type_name.ty) as i64
        })
    }

    /// The byte count of a type name (C99 6.5.3.4p1, p4): the element
    /// size times every array bound; an unspecified bound is an
    /// incomplete type.
    fn sizeof_type_name(&mut self, type_name: &TypeName) -> Result<i64, C5Error> {
        if type_name.ptr_levels == 0 {
            self.require_complete_operand(type_name.ty, "sizeof")?;
            if type_name.dims.iter().any(|&d| d < 0) {
                return Err(self.compile_err(
                    Code::INVALID_DECLARATION,
                    "`sizeof` applied to an incomplete type",
                ));
            }
        }
        let elem_size = self.size_of_type(type_name.ty) as i64;
        Ok(type_name.dims.iter().fold(elem_size, |n, &d| n * d))
    }

    /// `__alignof__` on an object or a member chain (`name`, `name.f`,
    /// `name->f.g`): the declared alignment of the designated object,
    /// which the flat type tag cannot carry -- a typedef-carried
    /// `aligned(N)` on the object or an explicit / typedef-carried
    /// alignment on the final member. Consumes the chain and returns its
    /// alignment, or rewinds and returns `None` for any other operand
    /// shape (subscripts, calls, bitfield members, non-object names),
    /// which the general-expression path then reports at the type's
    /// natural alignment. `parenthesized` requires the chain to end at
    /// `)`, left for the caller to consume.
    fn alignof_object_walk(&mut self, parenthesized: bool) -> Result<Option<i64>, C5Error> {
        let snap = self.lex.snapshot();
        // Leading parentheses around the chain (`((name))`, `(name.f)`).
        let mut inner_parens = 0usize;
        while self.lex.tk == '(' {
            inner_parens += 1;
            self.next()?;
        }
        if self.lex.tk != Token::Id {
            self.restore_lex(snap);
            return Ok(None);
        }
        let idx = self.lex.curr_id_idx;
        let class = self.symbols[idx].class;
        if class != Token::Loc as i64 && class != Token::Glo as i64 {
            self.restore_lex(snap);
            return Ok(None);
        }
        let mut align = if self.symbols[idx].type_align > 0 {
            self.symbols[idx].type_align
        } else {
            self.align_of_type(self.symbols[idx].type_) as i64
        };
        let mut cur_ty = self.symbols[idx].type_;
        self.next()?;
        loop {
            let arrow = self.lex.tk == Token::Arrow;
            if arrow || self.lex.tk == Token::Dot {
                // `.` selects from a struct value, `->` from a pointer to
                // one; anything else is not a plain member chain.
                let depth = struct_ptr_depth(cur_ty);
                let sel_ok = if arrow {
                    depth == 1
                } else {
                    is_struct_value_ty(cur_ty)
                };
                self.next()?;
                if !sel_ok || self.lex.tk != Token::Id {
                    self.restore_lex(snap);
                    return Ok(None);
                }
                let sid = struct_id_of(cur_ty);
                let name = self.symbols[self.lex.curr_id_idx].name.clone();
                let found = self.structs[sid]
                    .fields
                    .iter()
                    .find(|f| f.name == name)
                    .map(|f| (f.ty, f.align, f.bit_width));
                let Some((fty, falign, bit_width)) = found else {
                    self.restore_lex(snap);
                    return Ok(None);
                };
                if bit_width > 0 {
                    self.restore_lex(snap);
                    return Ok(None);
                }
                align = if falign > 0 {
                    falign as i64
                } else {
                    self.align_of_type(fty) as i64
                };
                cur_ty = fty;
                self.next()?;
                continue;
            }
            break;
        }
        // Close any leading parentheses.
        while inner_parens > 0 && self.lex.tk == ')' {
            inner_parens -= 1;
            self.next()?;
        }
        if inner_parens != 0 {
            self.restore_lex(snap);
            return Ok(None);
        }
        // The operand must be exactly the chain: a continuing postfix
        // (subscript, call, `++`/`--`) or, in the parenthesized form,
        // anything but `)` rewinds to the generic path.
        let ends_operand = if parenthesized {
            self.lex.tk == ')'
        } else {
            self.lex.tk != Token::Brak
                && self.lex.tk != '('
                && self.lex.tk != Token::Inc
                && self.lex.tk != Token::Dec
        };
        if !ends_operand {
            self.restore_lex(snap);
            return Ok(None);
        }
        Ok(Some(align))
    }
}

//! Expression parser: C99 6.5 as a primary / unary layer and a
//! precedence-climbing layer over the postfix and binary operators.
//! `expr(lev)` parses an expression whose operators bind at least as
//! tightly as `lev`; the operand's type is left in `self.ty` and its
//! node in `self.ast_acc`.

use alloc::format;
use alloc::string::String;
use alloc::string::ToString;
use alloc::vec::Vec;

use super::super::diag::Code;
use super::super::error::C5Error;
use super::super::ir::LoadKind;
use super::super::token::{Token, Ty};
use super::CODE_BASE;
use super::Compiler;

/// Largest byte count `__builtin_memcpy` is expanded inline for; gcc's
/// threshold on both supported targets. The copy rides `Inst::Mcpy`,
/// which streams, so the bound is on bytes rather than accesses.
const MAX_MEM_TRANSFER_BYTES: i64 = 256;
/// Largest number of stores the `__builtin_memset` expansion emits.
const MAX_MEM_FILL_ACCESSES: i64 = super::super::ast::MAX_MEM_FILL_ACCESSES;
/// Same for `__builtin_memmove`, whose expansion holds every loaded
/// unit live at once so the objects may overlap; the bound is on
/// simultaneously live values.
const MAX_MEM_MOVE_ACCESSES: i64 = 8;
/// Alignment ceiling for the derived endpoint alignment: the widest
/// access `Inst::Mcpy` and the inline expansions use.
pub(super) const MAX_MEM_TRANSFER_ALIGN: u32 = 8;

/// Whether a transfer of `size` bytes at `align`-byte endpoint
/// alignment expands inline, or has to be a library call.
pub(super) fn mem_transfer_fits(
    op: super::super::ast::MemTransferOp,
    size: i64,
    align: u32,
) -> bool {
    use super::super::ast::MemTransferOp;
    size >= 0
        && match op {
            MemTransferOp::Copy => size <= MAX_MEM_TRANSFER_BYTES,
            MemTransferOp::Move => {
                super::super::ast::mem_transfer_accesses(size, align) <= MAX_MEM_MOVE_ACCESSES
            }
            MemTransferOp::Fill => {
                super::super::ast::mem_transfer_accesses(size, align) <= MAX_MEM_FILL_ACCESSES
            }
        }
}

/// Library function a declined expansion calls (C99 7.21.2.1,
/// 7.21.2.2, 7.21.6.1).
pub(super) fn mem_transfer_lib_name(op: super::super::ast::MemTransferOp) -> &'static str {
    use super::super::ast::MemTransferOp;
    match op {
        MemTransferOp::Copy => "memcpy",
        MemTransferOp::Move => "memmove",
        MemTransferOp::Fill => "memset",
    }
}
use super::types::{
    UNSIGNED_BIT, VOLATILE_BIT, add_ptr_level, apply_qual_bits, format_type, fp_result_ty,
    integer_promote, is_bool_ty, is_float_ty, is_floating_scalar, is_long_double_ty, is_pointer_ty,
    is_struct_ty, is_struct_value_ty, is_unsigned_ty, is_vector_ty, is_void_ptr_ty,
    narrow_const_int, object_segment_bits, segment_of_ty, struct_id_of, struct_ptr_depth,
};

impl Compiler {
    /// C99 6.4.4.1p5: the type of an integer constant of value `ival` under
    /// the lexer's `u` / `l` / `ll` suffix: the first of `int`, `long`,
    /// `long long` whose range holds the magnitude, at or above the rank
    /// the suffix names, unsigned where the suffix or a non-decimal base
    /// allows it. A value above INT_MAX must not stay `int`: the post-binop
    /// mask in `convert.rs` would truncate it.
    pub(super) fn literal_auto_promoted_type(&self, ival: i64) -> i64 {
        let suffix_long = self.lex.int_suffix_long;
        let mut is_unsigned = self.lex.int_suffix_unsigned;
        // C99 6.4.4.1: a hexadecimal, octal, or binary constant may take
        // an unsigned type at a rank when no signed type at that rank
        // fits; a decimal constant with no `u` suffix never does.
        let allow_unsigned_fallback = !self.lex.int_is_decimal;
        let sizes = [
            self.size_of_type(Ty::Int as i64),
            self.size_of_type(Ty::Long as i64),
            self.size_of_type(Ty::LongLong as i64),
        ];
        // A constant is non-negative (a leading `-` is a separate operator),
        // so the magnitude is the unsigned reading of the lexer's value.
        let mag = (ival as u64) as u128;
        let fits = |size_bytes: usize, signed: bool| -> bool {
            let bits = (size_bytes as u32) * 8;
            if signed {
                if bits >= 128 {
                    true
                } else {
                    // Signed max is 2^(bits-1) - 1; 2^31 / 2^63 exactly
                    // must move to the next rank (or unsigned type).
                    mag < (1u128 << (bits - 1))
                }
            } else if bits >= 128 {
                true
            } else if bits == 0 {
                false
            } else {
                mag <= ((1u128 << bits) - 1u128)
            }
        };
        let mut rank: usize = (suffix_long as usize).min(2);
        loop {
            let size = sizes[rank];
            if !is_unsigned && fits(size, true) {
                break;
            }
            if (is_unsigned || allow_unsigned_fallback) && fits(size, false) {
                is_unsigned = true;
                break;
            }
            if rank >= 2 {
                // C99 6.4.4.1p5 lists no unsigned type for a decimal constant; one
                // past the widest signed type takes the unsigned type of that rank,
                // as gcc and clang do.
                is_unsigned = is_unsigned || allow_unsigned_fallback || fits(sizes[rank], false);
                break;
            }
            rank += 1;
        }
        let mut ty = match rank {
            2 => Ty::LongLong as i64,
            1 => Ty::Long as i64,
            _ => Ty::Int as i64,
        };
        if is_unsigned {
            ty |= UNSIGNED_BIT;
        }
        ty
    }

    /// Type of the `Token::Num` the lexer just produced. C11 6.4.4.4p2-p4
    /// fix a character constant's type by its encoding prefix, so the
    /// value never selects it; only an integer constant takes the
    /// value-driven rank selection of 6.4.4.1p5.
    pub(super) fn num_token_type(&self, val: i64) -> i64 {
        use crate::c5::lexer::StrPrefix;
        if !self.lex.num_is_char {
            return self.literal_auto_promoted_type(val);
        }
        match self.lex.char_prefix {
            // `char16_t` is `uint_least16_t` and `char32_t` is
            // `uint_least32_t`: unsigned, and the same width on every
            // target. `wchar_t` takes both its width and its signedness
            // from the target ABI, so neither is derived from the other.
            StrPrefix::Char16 => Ty::Short as i64 | UNSIGNED_BIT,
            StrPrefix::Char32 => Ty::Int as i64 | UNSIGNED_BIT,
            StrPrefix::Wide => {
                let base = if self.lex.wchar_bytes == 2 {
                    Ty::Short as i64
                } else {
                    Ty::Int as i64
                };
                if self.lex.wchar_signed {
                    base
                } else {
                    base | UNSIGNED_BIT
                }
            }
            // Unprefixed is `int` (6.4.4.4p10).
            _ => Ty::Int as i64,
        }
    }

    /// Parse a C11 7.17 atomic builtin call. The opening `(` has
    /// already been consumed. The first operand is the atomic-object
    /// pointer; its pointee type sets the operand width. The result
    /// type follows C11 7.17.7: the pointee value for the load /
    /// exchange / fetch forms, `int` for compare-exchange (the
    /// predicate) and for store (used in statement position).
    fn parse_atomic_builtin(
        &mut self,
        kind: super::super::ast::AtomicKind,
        id_idx: usize,
    ) -> Result<(), C5Error> {
        use super::super::ast::{AtomicKind, Expr};
        let fn_name = self.symbols[id_idx].name.clone();
        let want = atomic_arity(kind);
        let mut args: Vec<super::super::ast::ExprId> = Vec::new();
        self.expr(Token::Assign as i64)?;
        let ptr_ty = self.ty;
        if let Some(a) = self.ast_acc {
            args.push(a);
        }
        if !is_pointer_ty(ptr_ty) {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("`{fn_name}` first argument must be a pointer to the atomic object"),
            ));
        }
        let elem_ty = ptr_ty - Ty::Ptr as i64;
        while args.len() < want {
            if self.lex.tk != ',' {
                return Err(self.compile_err(
                    Code::INVALID_ARGUMENTS,
                    format!("`{fn_name}` takes {want} arguments"),
                ));
            }
            self.next()?;
            self.expr(Token::Assign as i64)?;
            if let Some(a) = self.ast_acc {
                args.push(a);
            }
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("`{fn_name}` takes {want} arguments"),
            ));
        }
        self.next()?;
        self.mark_emit_other();
        let result_ty = match kind {
            AtomicKind::Store | AtomicKind::CompareExchangeStrong => Ty::Int as i64,
            _ => elem_ty,
        };
        self.ty = result_ty;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::Atomic {
                kind,
                args,
                elem_ty,
                ty: result_ty,
            },
            pos,
        );
        self.ast_acc = Some(id);
        Ok(())
    }

    /// Fetch a required GCC-builtin operand or report an arity error.
    fn require_gcc_arg(
        &self,
        a: Option<super::super::ast::ExprId>,
        name: &str,
    ) -> Result<super::super::ast::ExprId, C5Error> {
        a.ok_or_else(|| {
            self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("`{name}` -- too few arguments"),
            )
        })
    }

    /// A GCC checked-arithmetic builtin
    /// `__builtin_{add,sub,mul}_overflow(a, b, dst)`, the `(` consumed. The
    /// pointee type of the result pointer sets the operation's width and
    /// signedness; the value is the `int` overflow flag.
    fn parse_overflow_builtin(&mut self, name: &str) -> Result<(), C5Error> {
        use super::super::ast::{Expr, ExprId};
        let typed = typed_overflow_builtin(name);
        let op = match typed {
            Some((op, _, _)) => op,
            None => match name {
                "__builtin_add_overflow" => 0i64,
                "__builtin_sub_overflow" => 1,
                _ => 2,
            },
        };
        let mut args: Vec<ExprId> = Vec::new();
        let mut dst_ty = 0i64;
        if self.lex.tk != ')' {
            loop {
                self.expr(Token::Assign as i64)?;
                if let Some(a) = self.ast_acc {
                    args.push(a);
                }
                dst_ty = self.ty;
                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }
        }
        if self.lex.tk != ')' || args.len() != 3 {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("`{name}` expects (a, b, result pointer)"),
            ));
        }
        self.next()?; // consume ')'
        if !is_pointer_ty(dst_ty) {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("`{name}` third argument must be a result pointer"),
            ));
        }
        let elem_ty = dst_ty - Ty::Ptr as i64;
        // A type-specific form names the operand and result type, so the
        // pointee must be that type rather than any integer type.
        if let Some((_, unsigned, rank)) = typed {
            let want = self.overflow_rank_width(rank);
            if self.size_of_type(elem_ty) != want || is_unsigned_ty(elem_ty) != unsigned {
                return Err(self.compile_err(
                    Code::INVALID_ARGUMENTS,
                    format!(
                        "`{name}` result pointer must be `{}{} *`",
                        if unsigned { "unsigned " } else { "" },
                        match rank {
                            b'l' => "long",
                            b'q' => "long long",
                            _ => "int",
                        }
                    ),
                ));
            }
        }
        self.mark_emit_other();
        let ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::CheckedArith {
                op,
                a: args[0],
                b: args[1],
                dst: args[2],
                elem_ty,
                ty,
            },
            pos,
        );
        self.ty = ty;
        self.ast_acc = Some(id);
        Ok(())
    }

    /// Byte width of the integer rank a type-specific checked-arithmetic
    /// builtin names.
    fn overflow_rank_width(&self, rank: u8) -> usize {
        match rank {
            b'l' => self.target.long_width_bytes(),
            b'q' => 8,
            _ => 4,
        }
    }

    /// Parse an x86 SIMD builtin call (`__builtin_ia32_*`), the opening
    /// `(` already consumed. Operand count and kinds come from the table
    /// row; the immediate operand of the forms that take one must be an
    /// integer constant expression, as it does in gcc.
    fn parse_x86_simd_builtin(&mut self, op: u32, name: &str) -> Result<(), C5Error> {
        use super::super::ast::{Expr, ExprId};
        use super::super::x86_simd::{self, Form, Sem};
        let row = x86_simd::get(op);
        if !self.target.is_x86_64() {
            return Err(self.compile_err(
                Code::UNSUPPORTED,
                format!("`{name}` requires an x86 target"),
            ));
        }
        let mut args: Vec<ExprId> = Vec::new();
        let mut arg_tys: Vec<i64> = Vec::new();
        if self.lex.tk != ')' {
            loop {
                self.expr(Token::Assign as i64)?;
                if let Some(a) = self.ast_acc {
                    args.push(a);
                    arg_tys.push(self.ty);
                }
                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }
        }
        if self.lex.tk != ')' || args.len() != row.form.arity() {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("`{name}` expects {} arguments", row.form.arity()),
            ));
        }
        self.next()?; // consume ')'
        let v128 = self.make_vector_type(Ty::LongLong as i64, 16);
        // Operand kinds: a 128-bit vector where the row wants one, a
        // pointer for the transfer and rdrand forms, an integer otherwise.
        for (i, &ty) in arg_tys.iter().enumerate() {
            let wants_vector = match row.form {
                Form::V
                | Form::VI
                | Form::Shift
                | Form::Extract
                | Form::Insert
                | Form::MoveMask => i == 0,
                Form::Vv | Form::VvI => i < 2,
                Form::Store => i == 1,
                Form::Load | Form::RdRand => false,
            };
            let wants_pointer = matches!(row.form, Form::Load | Form::RdRand)
                || (row.form == Form::Store && i == 0);
            if wants_vector && !(is_vector_ty(&self.structs, ty) && self.size_of_type(ty) == 16) {
                return Err(self.compile_err(
                    Code::INVALID_ARGUMENTS,
                    format!("`{name}` argument {} must be a 16-byte vector", i + 1),
                ));
            }
            if wants_pointer && !is_pointer_ty(ty) {
                return Err(self.compile_err(
                    Code::INVALID_ARGUMENTS,
                    format!("`{name}` argument {} must be a pointer", i + 1),
                ));
            }
        }
        // The immediate is the last operand; it leaves the argument list
        // and rides the node, as the instruction encodes it in place. A
        // shift count folds the same way when it is a constant that the
        // 8-bit field can hold, and stays an operand otherwise.
        let mut imm = None;
        if row.form.takes_imm() {
            let last = args.len() - 1;
            let Some(n) = self.expr_const_int(args[last]) else {
                return Err(self.compile_err(
                    Code::CONSTANT_EXPRESSION,
                    format!("`{name}` last argument must be an integer constant expression"),
                ));
            };
            imm = Some(n as u8);
            args.truncate(last);
        } else if row.form == Form::Shift {
            // The byte-granular shifts encode a byte count while their
            // builtins take bits, as gcc's do; they have no register-count
            // form, so the operand must be constant.
            let bits_per_unit = if matches!(row.sem, Sem::ShlBytes | Sem::ShrBytes) {
                8
            } else {
                1
            };
            match self.expr_const_int(args[1]) {
                Some(n) if (0..=255 * bits_per_unit).contains(&n) => {
                    imm = Some((n / bits_per_unit) as u8);
                    args.truncate(1);
                }
                // Any count at or past the lane width yields zero, which
                // the widest encodable immediate also produces.
                Some(_) => {
                    imm = Some(255);
                    args.truncate(1);
                }
                None if bits_per_unit != 1 => {
                    return Err(self.compile_err(
                        Code::CONSTANT_EXPRESSION,
                        format!("`{name}` count must be an integer constant expression"),
                    ));
                }
                None => {}
            }
        }
        self.mark_emit_other();
        let ty = if row.form.returns_vector() {
            v128
        } else if row.form == Form::Store {
            super::types::void_ty()
        } else {
            Ty::Int as i64
        };
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::X86Simd { op, args, imm, ty }, pos);
        self.ty = ty;
        self.ast_acc = Some(id);
        Ok(())
    }

    /// Parse a GCC memory-transfer builtin (`__builtin_memcpy`,
    /// `__builtin_memmove`, `__builtin_memset`) with the opening `(`
    /// already consumed. A byte count that is an integer constant
    /// expression within the expansion cap builds the inline-expansion
    /// node; any other count builds a call to the library function of
    /// the same name -- the split gcc makes between an expanded and a
    /// called transfer. The decision is per call site, so one declined
    /// count in a translation unit does not withdraw the expansion from
    /// the rest.
    fn parse_mem_transfer_builtin(
        &mut self,
        op: super::super::ast::MemTransferOp,
        name: &str,
    ) -> Result<(), C5Error> {
        use super::super::ast::{Expr, ExprId, MemTransferOp};
        let mut args: Vec<ExprId> = Vec::new();
        let mut ptr_align = MAX_MEM_TRANSFER_ALIGN;
        if self.lex.tk != ')' {
            loop {
                self.expr(Token::Assign as i64)?;
                // The pointer operands guarantee their pointee type's
                // alignment (C99 6.3.2.3p7); the fill byte contributes
                // nothing. `void *` is `unsigned char *` here, so an
                // untyped endpoint yields 1.
                if args.len() < 2 && !(op == MemTransferOp::Fill && args.len() == 1) {
                    let a = if is_pointer_ty(self.ty) {
                        self.align_of_type(self.ty - Ty::Ptr as i64) as u32
                    } else {
                        1
                    };
                    ptr_align = ptr_align.min(a.max(1));
                }
                if let Some(a) = self.ast_acc {
                    args.push(a);
                }
                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }
        }
        if self.lex.tk != ')' || args.len() != 3 {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("`{name}` expects (dst, src, count)"),
            ));
        }
        self.next()?;
        // Both forms yield the destination address (C99 7.21.2.1p2).
        let ty = Ty::Char as i64 + UNSIGNED_BIT + Ty::Ptr as i64;
        let size = match self.expr_const_int(args[2]) {
            Some(n) if mem_transfer_fits(op, n, ptr_align) => n,
            _ => return self.emit_mem_transfer_libcall(op, &args, ty),
        };
        self.mark_emit_other();
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::MemTransfer {
                op,
                dst: args[0],
                src: args[1],
                size,
                align: ptr_align,
                ty,
            },
            pos,
        );
        self.ty = ty;
        self.ast_acc = Some(id);
        Ok(())
    }

    /// The symbol-table index of `name` when the unit declared it as
    /// something callable.
    pub(super) fn callable_symbol(&self, name: &str) -> Option<usize> {
        super::super::lexer::find_symbol(&self.symbols, &self.symbol_index, name).filter(|&i| {
            self.symbols[i].class == Token::Fun as i64 || self.symbols[i].class == Token::Sys as i64
        })
    }

    /// Symbol of the library function a synthesized transfer calls.
    /// `None` where the name may not be assumed to be the library's
    /// (`-fno-builtin` / `-ffreestanding`), where the unit declared no
    /// such function, or inside that function's own definition, where
    /// the call would be recursion.
    pub(super) fn mem_transfer_lib_symbol(
        &self,
        op: super::super::ast::MemTransferOp,
    ) -> Option<usize> {
        let name = mem_transfer_lib_name(op);
        if self.library_name_is_opaque(name) || self.current_function_name == name {
            return None;
        }
        self.callable_symbol(name)
    }

    /// The symbol-table index of `name`, creating an unbound entry when
    /// the translation unit has not mentioned it. Reaching a name this
    /// way bypasses the preprocessor, so no macro of that name applies.
    pub(super) fn resolve_symbol_named(&mut self, name: &str) -> usize {
        let bytes = name.as_bytes();
        let hash = super::super::lexer::hash_name(bytes);
        super::super::lexer::resolve_symbol(&mut self.symbols, &mut self.symbol_index, bytes, hash)
    }

    /// Redirect a builtin's library-function binding away from a
    /// unit-local inline definition of the same name.
    ///
    /// `__builtin_<fn>` denotes the library function, which has
    /// external linkage. An inline definition provides no external
    /// definition (C99 6.7.4p6), so it is not what the builtin names,
    /// and the body badc emits for it calls the builtin in turn --
    /// binding there leaves the body calling itself. A fortified header
    /// defining `memcmp` as a wrapper over `__builtin_memcmp` is the
    /// shape that reaches.
    ///
    /// The reference goes to the external name through a slot carrying
    /// only that reference. `.` cannot occur in a C identifier, so the
    /// slot collides with nothing the source can declare and ordinary
    /// lookups still find the inline definition; its assembler name is
    /// the library name, so the call relocates against the one external
    /// definition the program links.
    fn builtin_library_symbol(&mut self, idx: usize) -> usize {
        let sym = &self.symbols[idx];
        if sym.class != Token::Fun as i64
            || sym.saw_static_decl
            || !crate::c5::symbol::inline_definition(sym, self.inline_model)
        {
            return idx;
        }
        let link_name = sym.link_name().to_string();
        let (type_, params, is_variadic) = (sym.type_, sym.params.clone(), sym.is_variadic);
        let slot = self.resolve_symbol_named(&alloc::format!("{link_name}.builtin"));
        let sym = &mut self.symbols[slot];
        if sym.class == 0 {
            sym.class = Token::Fun as i64;
            sym.type_ = type_;
            sym.params = params;
            sym.is_variadic = is_variadic;
            sym.asm_name = Some(link_name);
            sym.linkage = crate::c5::symbol::Linkage::External;
            sym.defined_here = false;
        }
        slot
    }

    /// Build the call a declined memory-transfer expansion falls back
    /// to: the library function of the same name, with the arguments
    /// already parsed. An undeclared library name reports the same
    /// "unknown function" the ordinary call path does, so the
    /// auto-include retry brings its header in (C99 7.1.4p2).
    fn emit_mem_transfer_libcall(
        &mut self,
        op: super::super::ast::MemTransferOp,
        args: &[super::super::ast::ExprId],
        ty: i64,
    ) -> Result<(), C5Error> {
        let name = mem_transfer_lib_name(op);
        let callable = self.callable_symbol(name);
        let retry_unavailable = self.nostdinc || self.library_name_is_opaque(name);
        let idx = match callable {
            Some(i) => i,
            // The `__builtin_` spelling stays callable in every mode
            // (gcc documents the fallback call for freestanding units).
            // Where the auto-include retry would decline the name, an
            // undeclared library name binds here as the extern function
            // the builtin implies and the environment defines it at link
            // time; otherwise the error stands so the retry installs the
            // header's own library binding.
            None if retry_unavailable => {
                let i = self.resolve_symbol_named(name);
                if self.symbols[i].class != 0 {
                    return Err(self.compile_err(
                        Code::UNDECLARED_IDENTIFIER,
                        format!("unknown function `{name}`"),
                    ));
                }
                self.symbols[i].class = Token::Fun as i64;
                self.symbols[i].type_ = ty;
                self.symbols[i].linkage = crate::c5::symbol::Linkage::External;
                self.symbols[i].defined_here = false;
                i
            }
            None => {
                let suggestion = self.include_hint(name);
                return Err(self.compile_err(
                    Code::UNDECLARED_IDENTIFIER,
                    format!("unknown function `{name}`{suggestion}"),
                ));
            }
        };
        let idx = self.builtin_library_symbol(idx);
        self.symbols[idx].was_referenced = true;
        self.flush_pending_stores();
        self.pending.last_emit_was_indirect_call = false;
        self.mark_emit_other();
        let callee_ty = self.symbols[idx].type_;
        let callee = self.ast_synthesize_callee(idx as u32, callee_ty);
        self.ast_acc = None;
        self.ast_emit_call(callee, args.iter().map(|a| Some(*a)).collect(), ty);
        self.ty = ty;
        Ok(())
    }

    /// A GCC `__atomic_*` / `__sync_*` builtin call, the `(` consumed,
    /// lowered onto the C11 7.17 atomic operations. The `memory_order`
    /// and `weak` operands are parsed and dropped: every operation is
    /// seq_cst.
    fn parse_gcc_atomic_builtin(&mut self, name: &str, id_idx: usize) -> Result<(), C5Error> {
        use super::super::ast::{AtomicKind, Expr, ExprId};
        let _ = id_idx;
        let mut args: Vec<ExprId> = Vec::new();
        let mut first_ty = 0i64;
        if self.lex.tk != ')' {
            loop {
                self.expr(Token::Assign as i64)?;
                if args.is_empty() {
                    first_ty = self.ty;
                }
                if let Some(a) = self.ast_acc {
                    args.push(a);
                }
                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("`{name}` -- malformed argument list"),
            ));
        }
        self.next()?;
        self.mark_emit_other();
        let int_ty = Ty::Int as i64;

        // Fences (C11 7.17.4): a full barrier with no pointer operand.
        // `__atomic_signal_fence` is a compiler-only barrier; a real
        // fence is a safe superset.
        if matches!(
            name,
            "__sync_synchronize" | "__atomic_thread_fence" | "__atomic_signal_fence"
        ) {
            let pos = self.ast_src_pos();
            let id = self.ast.push_expr(
                Expr::Intrinsic {
                    kind: crate::c5::op::Intrinsic::AtomicThreadFence as i64,
                    args: Vec::new(),
                    ty: int_ty,
                },
                pos,
            );
            self.ty = int_ty;
            self.ast_acc = Some(id);
            return Ok(());
        }

        // `__atomic_is_lock_free(size, ptr)` / `__atomic_always_lock_free`
        // (C11 7.17.5): a compile-time predicate, true for the widths that
        // lower to a lock-free instruction. A size that is not a constant,
        // or one with no such form, reports false -- the caller then takes
        // its locked path, which is correct for every width.
        if matches!(name, "__atomic_is_lock_free" | "__atomic_always_lock_free") {
            let size = args.first().and_then(|a| self.expr_const_int(*a));
            let val = matches!(size, Some(1 | 2 | 4 | 8)) as i64;
            let pos = self.ast_src_pos();
            let id = self.ast.push_expr(Expr::IntLit { val, ty: int_ty }, pos);
            self.ty = int_ty;
            self.ast_acc = Some(id);
            return Ok(());
        }

        // Every remaining form takes the atomic-object pointer first; its
        // pointee type drives the load / store / RMW width.
        if args.is_empty() || !is_pointer_ty(first_ty) {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("`{name}` first argument must be a pointer to the atomic object"),
            ));
        }
        let elem_ty = first_ty - Ty::Ptr as i64;
        let ptr = args[0];
        let val1 = args.get(1).copied();
        let val2 = args.get(2).copied();
        let pos = self.ast_src_pos();

        let (kind, op_args, result_ty): (AtomicKind, Vec<ExprId>, i64) = match name {
            "__atomic_load_n" => (AtomicKind::Load, alloc::vec![ptr], elem_ty),
            "__atomic_store_n" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::Store, alloc::vec![ptr, v], int_ty)
            }
            // Generic forms: the value moves through a pointer rather than
            // by value, so they work for any-size objects.
            "__atomic_load" => {
                let ret = self.require_gcc_arg(val1, name)?;
                (AtomicKind::LoadInto, alloc::vec![ptr, ret], int_ty)
            }
            "__atomic_store" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::StoreFrom, alloc::vec![ptr, v], int_ty)
            }
            "__atomic_exchange_n" | "__sync_lock_test_and_set" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::Exchange, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_add" | "__sync_fetch_and_add" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchAdd, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_sub" | "__sync_fetch_and_sub" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchSub, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_and" | "__sync_fetch_and_and" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchAnd, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_or" | "__sync_fetch_and_or" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchOr, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_xor" | "__sync_fetch_and_xor" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchXor, alloc::vec![ptr, v], elem_ty)
            }
            // The C11 `__atomic_*_fetch` forms return the new (post-op)
            // value and take a memory-order argument; the `__sync_*_and_fetch`
            // forms are the older two-argument spelling. Both map to the same
            // read-modify-write returning the updated value.
            "__atomic_add_fetch" | "__sync_add_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::AddFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_sub_fetch" | "__sync_sub_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::SubFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_and_fetch" | "__sync_and_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::AndFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_or_fetch" | "__sync_or_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::OrFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_xor_fetch" | "__sync_xor_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::XorFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_compare_exchange_n" => {
                let exp = self.require_gcc_arg(val1, name)?;
                let des = self.require_gcc_arg(val2, name)?;
                (
                    AtomicKind::CompareExchangeStrong,
                    alloc::vec![ptr, exp, des],
                    int_ty,
                )
            }
            "__sync_val_compare_and_swap" => {
                let old = self.require_gcc_arg(val1, name)?;
                let new = self.require_gcc_arg(val2, name)?;
                (AtomicKind::SyncCasVal, alloc::vec![ptr, old, new], elem_ty)
            }
            "__sync_bool_compare_and_swap" => {
                let old = self.require_gcc_arg(val1, name)?;
                let new = self.require_gcc_arg(val2, name)?;
                (AtomicKind::SyncCasBool, alloc::vec![ptr, old, new], int_ty)
            }
            // `__atomic_test_and_set(ptr, mo)` -- set the byte to 1 and
            // yield the prior contents (callers test for non-zero).
            "__atomic_test_and_set" => {
                let one = self.ast.push_expr(Expr::IntLit { val: 1, ty: int_ty }, pos);
                (AtomicKind::Exchange, alloc::vec![ptr, one], elem_ty)
            }
            // `__atomic_clear(ptr, mo)` / `__sync_lock_release(ptr)` --
            // store 0 to the object.
            "__atomic_clear" | "__sync_lock_release" => {
                let zero = self.ast.push_expr(Expr::IntLit { val: 0, ty: int_ty }, pos);
                (AtomicKind::Store, alloc::vec![ptr, zero], int_ty)
            }
            _ => {
                return Err(self.compile_err(
                    Code::UNSUPPORTED,
                    format!("`{name}` -- unsupported atomic builtin"),
                ));
            }
        };

        self.ty = result_ty;
        let id = self.ast.push_expr(
            Expr::Atomic {
                kind,
                args: op_args,
                elem_ty,
                ty: result_ty,
            },
            pos,
        );
        self.ast_acc = Some(id);
        Ok(())
    }

    /// C99 6.5.5-6.5.14: the arithmetic, bitwise, shift, relational,
    /// equality and logical operators take scalar operands; a struct or
    /// union value is rejected rather than operated on by address.
    fn reject_aggregate_binop(&self, lhs_ty: i64, rhs_ty: i64, op: &str) -> Result<(), C5Error> {
        // GCC vector extension: the element-wise operators and the
        // comparisons take a vector operand pair or a vector against a
        // broadcast scalar. The logical operators, and every other
        // aggregate operand, reject.
        if self.vector_binop_ty(lhs_ty, rhs_ty, op).is_some() {
            return Ok(());
        }
        if matches!(op, "==" | "!=" | "<" | ">" | "<=" | ">=")
            && self.vector_binop_ty(lhs_ty, rhs_ty, "+").is_some()
        {
            return Ok(());
        }
        // The GCC 128-bit integer shares the aggregate layout machinery
        // but is an integer type: the walker expands each operator over
        // its two 64-bit halves.
        if self.is_int128_ty(lhs_ty) || self.is_int128_ty(rhs_ty) {
            return Ok(());
        }
        if is_struct_value_ty(lhs_ty) || is_struct_value_ty(rhs_ty) {
            return Err(self.compile_err(
                Code::INVALID_OPERANDS,
                format!("invalid operands to binary `{op}`"),
            ));
        }
        Ok(())
    }

    /// Result type of a GCC vector-extension binary operation, or `None` when
    /// the operand pair is not one. `+ - * / %`, `& | ^` and the shifts take
    /// two vectors of the same byte width and the same element width and
    /// kind, or a vector against a scalar that broadcasts to every lane.
    /// `% & | ^ << >>` need integer elements, and an integer-element vector
    /// does not take a floating scalar. The comparisons share the operand
    /// rule through [`Self::vector_compare_ty`].
    fn vector_binop_ty(&self, lhs_ty: i64, rhs_ty: i64, op: &str) -> Option<i64> {
        if !matches!(
            op,
            "+" | "-" | "*" | "/" | "%" | "&" | "|" | "^" | "<<" | ">>"
        ) {
            return None;
        }
        let lhs_vec = is_vector_ty(&self.structs, lhs_ty);
        let rhs_vec = is_vector_ty(&self.structs, rhs_ty);
        let vec_ty = if lhs_vec {
            lhs_ty
        } else if rhs_vec {
            rhs_ty
        } else {
            return None;
        };
        let elem_ty = self.structs[struct_id_of(vec_ty)].fields[0].ty;
        let integer_only = matches!(op, "%" | "&" | "|" | "^" | "<<" | ">>");
        if integer_only && is_floating_scalar(elem_ty) {
            return None;
        }
        if lhs_vec && rhs_vec {
            let (l, r) = (struct_id_of(lhs_ty), struct_id_of(rhs_ty));
            let (le, re) = (self.structs[l].fields[0].ty, self.structs[r].fields[0].ty);
            if self.structs[l].size != self.structs[r].size
                || self.size_of_type(le) != self.size_of_type(re)
                || is_floating_scalar(le) != is_floating_scalar(re)
            {
                return None;
            }
            return Some(lhs_ty);
        }
        let scalar_ty = if lhs_vec { rhs_ty } else { lhs_ty };
        if is_struct_value_ty(scalar_ty)
            || is_pointer_ty(scalar_ty)
            || self.is_int128_ty(scalar_ty)
            || (!is_floating_scalar(elem_ty) && is_floating_scalar(scalar_ty))
        {
            return None;
        }
        Some(vec_ty)
    }

    /// Result type of a GCC vector-extension comparison, or `None` when
    /// the operand pair is not one. The operand rule is the arithmetic
    /// one; the result is a vector of the same byte width whose elements
    /// are the signed integer type of the operands' element width, each
    /// lane 0 or -1 (gcc 16, measured).
    fn vector_compare_ty(&mut self, lhs_ty: i64, rhs_ty: i64) -> Option<i64> {
        let vec_ty = self.vector_binop_ty(lhs_ty, rhs_ty, "+")?;
        let elem_ty = self.structs[struct_id_of(vec_ty)].fields[0].ty;
        let signed = match self.size_of_type(elem_ty) {
            1 => Ty::Char as i64,
            2 => Ty::Short as i64,
            4 => Ty::Int as i64,
            _ => Ty::LongLong as i64,
        };
        let bytes = self.structs[struct_id_of(vec_ty)].size as i64;
        Some(self.make_vector_type(signed, bytes))
    }

    /// Comparison opcode flavour for a vector operand pair: floating by
    /// the element type; between two integer vectors unsigned when either
    /// element is (6.3.1.8 common type, as gcc compares); against a
    /// broadcast scalar the vector's element decides, since the scalar
    /// converts to it first.
    fn vector_compare_op(
        &self,
        lhs_ty: i64,
        rhs_ty: i64,
        signed_op: super::super::ir::BinOp,
        unsigned_op: super::super::ir::BinOp,
        fp_op: super::super::ir::BinOp,
    ) -> super::super::ir::BinOp {
        let lhs_vec = is_vector_ty(&self.structs, lhs_ty);
        let rhs_vec = is_vector_ty(&self.structs, rhs_ty);
        let elem_of = |ty: i64| {
            if is_vector_ty(&self.structs, ty) {
                self.structs[struct_id_of(ty)].fields[0].ty
            } else {
                ty
            }
        };
        let (le, re) = (elem_of(lhs_ty), elem_of(rhs_ty));
        let vec_elem = if lhs_vec { le } else { re };
        if is_floating_scalar(vec_elem) {
            return fp_op;
        }
        let unsigned = if lhs_vec && rhs_vec {
            is_unsigned_ty(le) || is_unsigned_ty(re)
        } else {
            is_unsigned_ty(vec_elem)
        };
        if unsigned { unsigned_op } else { signed_op }
    }

    /// Opcode for `E1 op= E2` given the operand types. C99 6.5.16.2p3:
    /// the operation is `E1 op E2`, so divide / modulo signedness
    /// follows the 6.3.1.8 common type of both operands, not the lvalue
    /// alone (`int x; x /= 2u` divides unsigned). Pointer operands keep
    /// the lvalue's signedness (no arithmetic common type). The shift
    /// operators take the lvalue's signedness alone (6.5.7 promotes the
    /// operands separately).
    fn compound_assign_binop(
        &self,
        binop: i64,
        lhs_ty: i64,
        rhs_ty: i64,
        op_is_fp: bool,
    ) -> Result<super::super::ir::BinOp, C5Error> {
        let div_unsigned = if op_is_fp || is_pointer_ty(lhs_ty) || is_pointer_ty(rhs_ty) {
            is_unsigned_ty(lhs_ty)
        } else {
            is_unsigned_ty(self.arith_common_ty(lhs_ty, rhs_ty))
        };
        use super::super::ir::BinOp as B;
        Ok(match binop {
            x if x == Token::AddOp as i64 => {
                if op_is_fp {
                    B::Fadd
                } else {
                    B::Add
                }
            }
            x if x == Token::SubOp as i64 => {
                if op_is_fp {
                    B::Fsub
                } else {
                    B::Sub
                }
            }
            x if x == Token::MulOp as i64 => {
                if op_is_fp {
                    B::Fmul
                } else {
                    B::Mul
                }
            }
            x if x == Token::DivOp as i64 => {
                if op_is_fp {
                    B::Fdiv
                } else if div_unsigned {
                    B::Divu
                } else {
                    B::Div
                }
            }
            x if x == Token::ModOp as i64 => {
                if div_unsigned {
                    B::Modu
                } else {
                    B::Mod
                }
            }
            x if x == Token::AndOp as i64 => B::And,
            x if x == Token::OrOp as i64 => B::Or,
            x if x == Token::XorOp as i64 => B::Xor,
            x if x == Token::ShlOp as i64 => B::Shl,
            x if x == Token::ShrOp as i64 => {
                if is_unsigned_ty(lhs_ty) {
                    B::Shru
                } else {
                    B::Shr
                }
            }
            _ => {
                return Err(
                    self.compile_err(Code::INVALID_OPERANDS, "unknown compound-assign opcode")
                );
            }
        })
    }

    /// The lvalue and type for a `++` / `--` operand that cannot use the
    /// generic trailing-load rewrite and must build `Expr::PreInc` /
    /// `Expr::PostInc` directly: a bitfield member (its load is a
    /// shift-and-mask sequence, not one scalar load) and the GCC 128-bit
    /// integer (its lvalue's value is its address, so there is no
    /// trailing load at all).
    fn direct_inc_lvalue(&self) -> Option<(super::super::ast::ExprId, i64)> {
        let lv = self.ast_acc?;
        if let super::super::ast::Expr::Member {
            bitfield: Some(_),
            ty,
            ..
        } = self.ast.expr(lv)
        {
            return Some((lv, *ty));
        }
        if self.is_int128_ty(self.ty) {
            return Some((lv, self.ty));
        }
        None
    }

    /// A value-producing operator (function call, conditional, ...) yields a
    /// fresh rvalue whose type is its own, never an array-decayed operand.
    /// Drop the pending array-decay hints an array / string operand left set
    /// so `sizeof` / `typeof` of the result read the result type, not the
    /// operand's array shape (C99 6.3.2.1p3). Mirrors the cast and binary-
    /// operator sites.
    fn drop_operand_array_decay(&mut self) {
        self.pending.last_array_decay_size = 0;
        self.pending.last_array_decay_bytes = 0;
        self.pending.last_array_decay_dims.clear();
    }

    pub(super) fn expr(&mut self, lev: i64) -> Result<(), C5Error> {
        self.with_nesting("expression", |c| c.expr_inner(lev))
    }

    fn expr_inner(&mut self, lev: i64) -> Result<(), C5Error> {
        self.parse_unary()?;
        while self.lex.tk >= lev || self.lex.tk == '(' {
            self.parse_operator()?;
        }
        self.end_expression();
        Ok(())
    }

    /// C99 6.5.1-6.5.3: a primary expression, or a unary operator applied
    /// to one; the postfix operators are read by the precedence-climbing
    /// loop, except a call on a bare identifier, which the identifier arm
    /// takes so it can read the callee's declaration.
    fn parse_unary(&mut self) -> Result<(), C5Error> {
        if self.lex.tk == 0 {
            Err(self.compile_err(Code::SYNTAX, "unexpected eof in expression"))
        } else if self.lex.tk == Token::Num {
            self.parse_int_literal()
        } else if self.lex.tk == Token::FloatNum {
            self.parse_float_literal()
        } else if self.lex.tk == '"' {
            self.parse_string_literal()
        } else if self.lex.tk == Token::Sizeof {
            self.parse_sizeof_expr()
        } else if self.lex.tk == Token::Alignof {
            self.parse_alignof_expr()
        } else if self.lex.tk == Token::Generic {
            self.parse_generic_selection()
        } else if self.lex.tk == Token::BuiltinTypesCompatible {
            self.parse_types_compatible_expr()
        } else if self.lex.tk == Token::BuiltinOffsetof {
            self.parse_offsetof_expr()
        } else if self.is_func_name_ident() {
            self.parse_func_name()
        } else if let Some(v) = self.try_fold_string_compare_builtin()? {
            // A string comparison of two literals is a constant here as
            // well as in a constant expression, which is what makes a
            // comparison against a literal a translation-time selector.
            self.emit_int_constant(v, Ty::Int as i64);
            Ok(())
        } else if let Some(v) = self.try_fold_strlen_builtin()? {
            // Likewise the length of a literal, which gcc folds at every
            // optimization level; folding it here lets a `sizeof` over it see a
            // constant.
            let ty = self.size_t_ty();
            self.emit_int_constant(v.as_int(), ty);
            Ok(())
        } else if self.lex.tk == Token::Id {
            self.parse_identifier()
        } else if self.lex.tk == '(' {
            self.parse_parenthesized()
        } else if self.lex.tk == Token::MulOp {
            self.parse_deref()
        } else if self.lex.tk == Token::Lan {
            self.parse_label_address()
        } else if self.lex.tk == Token::AndOp {
            self.parse_address_of()
        } else if self.lex.tk == '!' {
            self.parse_logical_not()
        } else if self.lex.tk == '~' {
            self.parse_bit_not()
        } else if self.lex.tk == Token::AddOp {
            self.parse_unary_plus()
        } else if self.lex.tk == Token::SubOp {
            self.parse_unary_minus()
        } else if self.lex.tk == Token::Inc || self.lex.tk == Token::Dec {
            self.parse_prefix_inc_dec()
        } else {
            let func = self.current_function_name.clone();
            let id_suffix = if self.lex.tk == Token::Id {
                format!(" `{}`", self.symbols[self.lex.curr_id_idx].name)
            } else {
                String::new()
            };
            Err(self.compile_err(
                Code::SYNTAX,
                format!(
                    "bad expression: got {}{id_suffix} (in {func})",
                    super::super::token::describe(self.lex.tk),
                ),
            ))
        }
    }

    /// An integer constant: the immediate, the type, and the AST literal.
    fn emit_int_constant(&mut self, val: i64, ty: i64) {
        self.emit_imm(val);
        self.ty = ty;
        self.ast_emit_int_lit(val, ty);
    }

    fn parse_int_literal(&mut self) -> Result<(), C5Error> {
        let val = self.lex.ival;
        let ty = self.num_token_type(val);
        self.emit_int_constant(val, ty);
        self.next()
    }

    fn parse_float_literal(&mut self) -> Result<(), C5Error> {
        // C99 6.4.4.2p4: unsuffixed is `double`, `f` is `float`, `l` is
        // `long double` (binary64 here); the lexer stored the bits in `ival`.
        let bits = self.lex.ival as u64;
        self.emit_imm(self.lex.ival);
        self.ty = if self.lex.float_suffix_f32 {
            Ty::Float as i64
        } else {
            Ty::Double as i64
        };
        self.ast_emit_float_lit(bits, self.ty);
        self.next()?;
        Ok(())
    }

    fn parse_string_literal(&mut self) -> Result<(), C5Error> {
        // C99 6.4.5p6: the literal is a `char[N+1]` that decays to `char *`
        // here; `sizeof("...")` reads the array size through
        // `last_array_decay_bytes`.
        let start_offset = self.lex.ival;
        // Adjacent literals concatenate (6.4.5p4). The lexer terminates a
        // wide literal itself and leaves a narrow one open, so the NUL is
        // added once the parts are in.
        let is_wide = self.lex.str_is_wide;
        self.emit_data_imm(start_offset);
        self.next()?;
        while self.lex.tk == '"' {
            self.next()?;
        }
        if !is_wide {
            self.push_literal_nul();
        }
        self.pending.last_array_decay_bytes = (self.data.len() as i64) - start_offset;
        self.ty = Ty::Ptr as i64;
        self.ast_emit_str_lit(start_offset, self.ty);
        Ok(())
    }

    fn parse_sizeof_expr(&mut self) -> Result<(), C5Error> {
        self.next()?;
        let total_bytes = self.sizeof_operand_bytes()?;
        self.emit_imm(total_bytes);
        self.ty = self.size_t_ty();
        // C99 6.5.3.4p2: `sizeof` of a VLA is a runtime value, loaded from
        // the VLA's byte-count slot.
        if let Some(size_slot) = self.pending.sizeof_vla_size_slot.take() {
            self.ast_emit_vla_sizeof(size_slot);
        } else {
            self.ast_emit_int_lit(total_bytes, self.ty);
        }
        Ok(())
    }

    fn parse_alignof_expr(&mut self) -> Result<(), C5Error> {
        self.next()?;
        let align = self.alignof_operand_bytes()?;
        self.emit_imm(align);
        self.ty = self.size_t_ty();
        self.ast_emit_int_lit(align, self.ty);
        Ok(())
    }

    fn parse_types_compatible_expr(&mut self) -> Result<(), C5Error> {
        self.next()?;
        let v = self.parse_types_compatible_p()?;
        self.emit_imm(v);
        self.ty = Ty::Int as i64;
        self.ast_emit_int_lit(v, self.ty);
        Ok(())
    }

    fn parse_offsetof_expr(&mut self) -> Result<(), C5Error> {
        // A constant unless a designator subscript is a runtime value (GCC
        // extension), which the parser emitted onto the accumulator.
        self.next()?;
        match self.parse_builtin_offsetof(true)? {
            Some(v) => {
                self.emit_imm(v);
                self.ty = self.size_t_ty();
                self.ast_emit_int_lit(v, self.ty);
            }
            None => {
                self.ty = self.size_t_ty();
            }
        }
        Ok(())
    }

    fn parse_func_name(&mut self) -> Result<(), C5Error> {
        // C99 6.4.2.2: `__func__` is `static const char[]` in the data
        // segment; `__FUNCTION__` / `__PRETTY_FUNCTION__` are the GCC aliases.
        let offset = self.intern_func_name();
        self.emit_data_imm(offset);
        self.next()?;
        self.ty = Ty::Char as i64 + Ty::Ptr as i64;
        // The array size reaches an enclosing `sizeof` as for any decayed
        // array.
        self.pending.last_array_decay_size = self.current_function_name.len() as i64 + 1;
        self.ast_emit_str_lit(offset, self.ty);
        Ok(())
    }

    fn parse_identifier(&mut self) -> Result<(), C5Error> {
        let id_idx = self.lex.curr_id_idx;
        self.next()?;
        if self.lex.tk == '(' {
            self.next()?;
            return self.parse_call(id_idx);
        }
        let class = self.symbols[id_idx].class;
        if class == Token::Num as i64 {
            self.parse_enum_constant(id_idx)
        } else if class == Token::Fun as i64 || class == Token::Sys as i64 {
            self.parse_function_designator(id_idx)
        } else if class == Token::Loc as i64
            && matches!(
                self.symbols[id_idx].asm_register,
                Some(
                    crate::c5::symbol::AsmRegister::StackPointer
                        | crate::c5::symbol::AsmRegister::FramePointer
                )
            )
        {
            self.parse_register_variable(id_idx)
        } else {
            self.parse_variable(id_idx)
        }
    }

    /// A call on a bare identifier, the `(` consumed: a builtin lowered
    /// at the call site, or a call to the declared function.
    fn parse_call(&mut self, id_idx: usize) -> Result<(), C5Error> {
        let id_idx = self.bind_call_target(id_idx)?;
        match self.builtin_call(id_idx) {
            Some(BuiltinCall::Simd(op)) => {
                let name = self.symbols[id_idx].name.clone();
                self.parse_x86_simd_builtin(op, &name)
            }
            Some(BuiltinCall::MemTransfer(op)) => {
                let name = self.symbols[id_idx].name.clone();
                self.parse_mem_transfer_builtin(op, &name)
            }
            Some(BuiltinCall::ChooseExpr) => self.parse_choose_expr_builtin(),
            Some(BuiltinCall::ConstantP) => self.parse_constant_p_builtin(),
            Some(BuiltinCall::HasAttribute) => self.parse_has_attribute_builtin(),
            Some(BuiltinCall::ObjectSize) => self.parse_object_size_builtin(),
            Some(BuiltinCall::Overflow) => {
                let name = self.symbols[id_idx].name.clone();
                self.parse_overflow_builtin(&name)
            }
            Some(BuiltinCall::GccAtomic) => {
                let name = self.symbols[id_idx].name.clone();
                self.parse_gcc_atomic_builtin(&name, id_idx)
            }
            Some(BuiltinCall::Atomic(kind)) => self.parse_atomic_builtin(kind, id_idx),
            Some(BuiltinCall::Intrinsic(id)) => self.parse_intrinsic_call(id_idx, id),
            None => self.parse_direct_call(id_idx),
        }
    }

    /// The symbol a call binds to: a `__builtin_*` alias of a library
    /// function binds to that function, and a name the driver listed for
    /// C89 6.3.2.2 implicit declaration is declared here.
    fn bind_call_target(&mut self, id_idx: usize) -> Result<usize, C5Error> {
        let mut id_idx = id_idx;
        // A `__builtin_*` alias of a library function binds to the function
        // itself, past any macro of the library name.
        if self.symbols[id_idx].class == 0 {
            let alias =
                super::super::preprocessor::builtins::library_alias(&self.symbols[id_idx].name);
            if let Some(fn_name) = alias {
                id_idx = self.resolve_symbol_named(fn_name);
                id_idx = self.builtin_library_symbol(id_idx);
            }
        }
        // C89 6.3.2.2 implicit declaration, for the names the driver listed:
        // the call binds `extern int name();` against the link set's own
        // definition.
        if self.symbols[id_idx].class == 0
            && !self.implicit_extern_fns.is_empty()
            && self
                .implicit_extern_fns
                .iter()
                .any(|n| n == &self.symbols[id_idx].name)
        {
            // The declaration lands in the innermost block and unbinds at its
            // exit; the entity stays on the slot for link resolution.
            self.rebind_scoped(id_idx)?;
            self.symbols[id_idx].class = Token::Fun as i64;
            self.symbols[id_idx].scoped_fn_decl = true;
            self.symbols[id_idx].type_ = Ty::Int as i64;
            self.symbols[id_idx].implicit_return_int = true;
            self.symbols[id_idx].linkage = crate::c5::symbol::Linkage::External;
            self.symbols[id_idx].defined_here = false;
        }
        Ok(id_idx)
    }

    /// The builtin a call on `id_idx` lowers to, or `None` for a call to
    /// a declared function. A name bound to a real function is not a
    /// builtin, except that a registered intrinsic is lowered whatever
    /// the name is bound to.
    fn builtin_call(&self, id_idx: usize) -> Option<BuiltinCall> {
        let name = self.symbols[id_idx].name.as_str();
        let class = self.symbols[id_idx].class;
        let intrinsic_id = self.pp_intrinsics.get(name).copied();
        let not_real_fn = class != Token::Fun as i64 && class != Token::Sys as i64;
        if not_real_fn {
            if let Some(op) = super::super::x86_simd::lookup(name) {
                return Some(BuiltinCall::Simd(op));
            }
            if let Some(op) = mem_transfer_op(name) {
                return Some(BuiltinCall::MemTransfer(op));
            }
            match name {
                "__builtin_choose_expr" => return Some(BuiltinCall::ChooseExpr),
                "__builtin_constant_p" => return Some(BuiltinCall::ConstantP),
                "__builtin_has_attribute" => return Some(BuiltinCall::HasAttribute),
                "__builtin_object_size" => return Some(BuiltinCall::ObjectSize),
                "__builtin_add_overflow" | "__builtin_sub_overflow" | "__builtin_mul_overflow" => {
                    return Some(BuiltinCall::Overflow);
                }
                _ => {}
            }
            if typed_overflow_builtin(name).is_some() {
                return Some(BuiltinCall::Overflow);
            }
            if name.starts_with("__atomic_") || name.starts_with("__sync_") {
                return Some(BuiltinCall::GccAtomic);
            }
            if let Some(kind) = intrinsic_id.and_then(atomic_kind_from_intrinsic) {
                return Some(BuiltinCall::Atomic(kind));
            }
        }
        intrinsic_id.map(BuiltinCall::Intrinsic)
    }

    fn parse_intrinsic_call(&mut self, id_idx: usize, intrinsic_id: i64) -> Result<(), C5Error> {
        use crate::c5::op::Intrinsic;
        let is = |k: Intrinsic| intrinsic_id == k as i64;
        let fn_name = self.symbols[id_idx].name.clone();
        // `__builtin_trap()` is the only nullary intrinsic;
        // every other one needs at least one argument.
        if self.lex.tk == ')' && intrinsic_id != crate::c5::op::Intrinsic::Trap as i64 {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("intrinsic `{fn_name}` requires one argument"),
            ));
        }
        let IntrinsicOperands {
            args: ast_intrinsic_args,
            va_arg_result_ty,
            frame_walk_levels,
            walked_return_slot,
        } = self.parse_intrinsic_operands(intrinsic_id, &fn_name)?;
        if self.lex.tk != ')' {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("intrinsic `{fn_name}` arity mismatch at close paren"),
            ));
        }
        self.next()?;
        self.mark_emit_other();
        // The alloca arena is placed at function end, below every local
        // declared after this point.
        if is(Intrinsic::Alloca) {
            self.uses_alloca_in_current_fn = true;
        }
        self.ty = self.intrinsic_result_ty(intrinsic_id);
        let intr_ty = self.ty;
        let pos = self.ast_src_pos();
        // A walked return address starts from the frame address.
        let node_kind = if walked_return_slot {
            Intrinsic::FrameAddress as i64
        } else {
            intrinsic_id
        };
        let id = self.ast.push_expr(
            super::super::ast::Expr::Intrinsic {
                kind: node_kind,
                args: ast_intrinsic_args,
                ty: intr_ty,
            },
            pos,
        );
        self.ast_acc = Some(id);
        // `__builtin_va_arg` yields the argument as a value of `T`: the slot
        // address the intrinsic returns is read through `T *`.
        if let Some(res_ty) = va_arg_result_ty {
            if let Some(child) = self.ast_acc {
                self.ast_emit_cast(child, res_ty + Ty::Ptr as i64);
            }
            if !(is_struct_value_ty(res_ty)) {
                self.mark_emit_scalar_load();
            }
            self.ty = res_ty;
            self.ast_apply_unary(super::super::ast::UnOp::Deref);
        }
        // A frame record holds the caller's frame pointer at offset 0, so
        // each level above 0 is one load through the level below; the
        // return-address form then reads the return slot of the record
        // reached, as the level-0 intrinsic does.
        let void_ptr_ty = (Ty::Char as i64) + (Ty::Ptr as i64);
        for _ in 0..frame_walk_levels {
            if let Some(child) = self.ast_acc {
                self.ast_emit_cast(child, void_ptr_ty + Ty::Ptr as i64);
            }
            self.mark_emit_scalar_load();
            self.ty = void_ptr_ty;
            self.ast_apply_unary(super::super::ast::UnOp::Deref);
        }
        if walked_return_slot && let Some(walked) = self.ast_acc {
            let pos = self.ast_src_pos();
            let id = self.ast.push_expr(
                super::super::ast::Expr::Intrinsic {
                    kind: Intrinsic::ReturnAddress as i64,
                    args: alloc::vec![walked],
                    ty: void_ptr_ty,
                },
                pos,
            );
            self.ast_acc = Some(id);
            self.ty = void_ptr_ty;
        }
        Ok(())
    }

    /// The operands of an intrinsic call, parsed in source order with the
    /// conversions the intrinsic's operand types call for.
    fn parse_intrinsic_operands(
        &mut self,
        intrinsic_id: i64,
        fn_name: &str,
    ) -> Result<IntrinsicOperands, C5Error> {
        use crate::c5::op::Intrinsic;
        let is = |k: Intrinsic| intrinsic_id == k as i64;
        let intr_kind = crate::c5::op::Intrinsic::from_i64(intrinsic_id);
        let is_fp_unary = intr_kind.is_some_and(|i| i.is_fp_unary());
        let is_int_bit_unary = intr_kind.is_some_and(|i| i.is_int_bit_unary());
        let is_bit_unary_64 = intr_kind.is_some_and(|i| i.is_bit_unary_64());
        let is_bswap = intr_kind.is_some_and(|i| i.is_bswap());
        let mut va_arg_result_ty: Option<i64> = None;
        let mut frame_walk_levels: i64 = 0;
        let mut walked_return_slot = false;
        let mut ast_intrinsic_args: alloc::vec::Vec<super::super::ast::ExprId> =
            alloc::vec::Vec::new();
        if is(Intrinsic::Trap) {
            // __builtin_trap() -- no arguments.
        } else if is(Intrinsic::Fma) || is(Intrinsic::Fmaf) {
            // C99 7.12.13.1 `fma` / `fmaf`: three operands in the result
            // precision, lowered to one `Inst::Fma`.
            let elem_ty = if is(Intrinsic::Fmaf) {
                Ty::Float as i64
            } else {
                Ty::Double as i64
            };
            let mut count = 0;
            loop {
                self.parse_converted_operand(elem_ty, &mut ast_intrinsic_args)?;
                count += 1;
                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }
            if count != 3 {
                return Err(self.compile_err(
                    Code::INVALID_ARGUMENTS,
                    format!("intrinsic `{fn_name}` takes (x, y, z)"),
                ));
            }
        } else if is_fp_unary {
            // One floating operand in the result precision, lowered to the
            // hardware instruction.
            let elem_ty = if intr_kind.is_some_and(|i| i.is_single_precision()) {
                Ty::Float as i64
            } else {
                Ty::Double as i64
            };
            self.parse_converted_operand(elem_ty, &mut ast_intrinsic_args)?;
        } else if is_int_bit_unary || is_bswap {
            // `__builtin_clz` / `ctz` / `popcount` and `__builtin_bswap*`: one
            // integer operand, zero-extended to the operation width so the count
            // or byte reversal covers exactly that width.
            let is_clrsb = intr_kind.is_some_and(|i| i.is_clrsb());
            let elem_ty = if is_bswap {
                let base = match intr_kind {
                    Some(crate::c5::op::Intrinsic::Bswap16) => Ty::Short as i64,
                    Some(crate::c5::op::Intrinsic::Bswap64) => Ty::LongLong as i64,
                    _ => Ty::Int as i64,
                };
                base | super::types::UNSIGNED_BIT
            } else if is_clrsb {
                // clrsb counts sign bits: the operand is signed,
                // so sign-extend into the register.
                if is_bit_unary_64 {
                    Ty::LongLong as i64
                } else {
                    Ty::Int as i64
                }
            } else if is_bit_unary_64 {
                Ty::LongLong as i64 | super::types::UNSIGNED_BIT
            } else {
                Ty::Int as i64 | super::types::UNSIGNED_BIT
            };
            self.parse_converted_operand(elem_ty, &mut ast_intrinsic_args)?;
        } else if is(Intrinsic::VaArg) {
            va_arg_result_ty = Some(self.parse_va_arg_operands(fn_name, &mut ast_intrinsic_args)?);
        } else if is(Intrinsic::VaStart) || is(Intrinsic::VaCopy) {
            // The `va_list`, then the rightmost fixed parameter (`va_start`, C99
            // 7.15.1.4) or the source `va_list` (`va_copy`), both as addresses.
            self.expr(Token::Assign as i64)?;
            self.va_list_operand_address();
            if let Some(a) = self.ast_acc {
                ast_intrinsic_args.push(a);
            }
            self.ast_psh();
            if self.lex.tk != ',' {
                return Err(self.compile_err(
                    Code::INVALID_ARGUMENTS,
                    format!("intrinsic `{fn_name}` takes two operands"),
                ));
            }
            self.next()?;
            self.expr(Token::Assign as i64)?;
            if is(Intrinsic::VaCopy) {
                self.va_list_operand_address();
            } else {
                self.va_operand_take_address();
            }
            if let Some(a) = self.ast_acc {
                ast_intrinsic_args.push(a);
            }
        } else if is(Intrinsic::VaEnd) {
            self.expr(Token::Assign as i64)?;
            self.va_list_operand_address();
            if let Some(a) = self.ast_acc {
                ast_intrinsic_args.push(a);
            }
        } else if is(Intrinsic::LongjmpAArch64) {
            // `env` is pushed and `val` left in the accumulator for the AArch64
            // lowering.
            self.expr(Token::Assign as i64)?;
            if let Some(a) = self.ast_acc {
                ast_intrinsic_args.push(a);
            }
            self.ast_psh();
            if self.lex.tk != ',' {
                return Err(self.compile_err(
                    Code::INVALID_ARGUMENTS,
                    format!("intrinsic `{fn_name}` takes (env, val)"),
                ));
            }
            self.next()?;
            self.expr(Token::Assign as i64)?;
            if let Some(a) = self.ast_acc {
                ast_intrinsic_args.push(a);
            }
            if is_floating_scalar(self.ty) {
                self.ast_fpcast();
                self.ty = Ty::Int as i64;
            }
        } else if is(Intrinsic::FrameAddress) || is(Intrinsic::ReturnAddress) {
            // GCC defines the operand as the number of frames to walk up: level
            // 0 reads this function's own frame record.
            let level = self.parse_frame_level(fn_name)?;
            if level > 0 {
                frame_walk_levels = level;
                walked_return_slot = is(Intrinsic::ReturnAddress);
            }
        } else {
            self.expr(Token::Assign as i64)?;
            if let Some(a) = self.ast_acc {
                ast_intrinsic_args.push(a);
            }
            // The remaining intrinsics take an integer or pointer operand.
            if is_floating_scalar(self.ty) {
                self.ast_fpcast();
                self.ty = Ty::Int as i64;
            }
        }
        Ok(IntrinsicOperands {
            args: ast_intrinsic_args,
            va_arg_result_ty,
            frame_walk_levels,
            walked_return_slot,
        })
    }

    /// One operand converted to `to_ty` (C99 6.3.1.4 / 6.3.1.5), so the
    /// node sees operands of the width it computes in.
    fn parse_converted_operand(
        &mut self,
        to_ty: i64,
        args: &mut alloc::vec::Vec<super::super::ast::ExprId>,
    ) -> Result<(), C5Error> {
        self.expr(Token::Assign as i64)?;
        if let Some(child) = self.ast_acc {
            let pos = self.ast_src_pos();
            let cast_id = self
                .ast
                .push_expr(super::super::ast::Expr::Cast { child, to_ty }, pos);
            args.push(cast_id);
        }
        Ok(())
    }

    /// The operands of `__builtin_va_arg(ap, T)`: the `va_list` address
    /// and the packed descriptor of `T`. Returns `T`.
    fn parse_va_arg_operands(
        &mut self,
        fn_name: &str,
        args: &mut alloc::vec::Vec<super::super::ast::ExprId>,
    ) -> Result<i64, C5Error> {
        // The first operand is reduced to the `va_list`'s storage address;
        // the second is the descriptor `(kind << 16) | size`, `kind` 1 for a
        // floating argument. The System V x86_64 ABI (3.5.7) routes the read
        // to the gp or fp save area by `kind`; the cursor targets ignore it.
        self.expr(Token::Assign as i64)?;
        self.va_list_operand_address();
        if let Some(a) = self.ast_acc {
            args.push(a);
        }
        if self.lex.tk != ',' {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("intrinsic `{fn_name}` takes (ap, type)"),
            ));
        }
        self.next()?;
        if !self.lex_is_type_start() {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("intrinsic `{fn_name}` second operand must be a type name"),
            ));
        }
        let type_name = self.parse_type_name()?;
        let arg_ty = type_name.ty;
        let is_pointer = type_name.ptr_levels > 0;
        let size = self.size_of_type(arg_ty) as i64;
        // C99 6.5.2.2p6: a floating argument past the promotions is `double`
        // and rides the fp save area; a pointer or integer the gp save area.
        let kind = if !is_pointer && is_floating_scalar(arg_ty) {
            1i64
        } else {
            0i64
        };
        let descriptor = (kind << 16) | (size & 0xffff);
        let desc_id = self.ast_emit_int_lit(descriptor, Ty::Int as i64);
        args.push(desc_id);
        Ok(arg_ty)
    }

    /// The level operand of `__builtin_frame_address` /
    /// `__builtin_return_address`: a non-negative integer constant,
    /// consumed at parse time.
    fn parse_frame_level(&mut self, fn_name: &str) -> Result<i64, C5Error> {
        self.expr(Token::Assign as i64)?;
        let level = self.ast_acc.and_then(|a| self.expr_const_int(a));
        self.ast_acc = None;
        match level {
            Some(n) if n >= 0 => Ok(n),
            Some(n) => Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!("invalid argument to `{fn_name}`: the level must not be negative, got {n}"),
            )),
            None => Err(self.compile_err(
                Code::CONSTANT_EXPRESSION,
                format!("invalid argument to `{fn_name}`: the level must be an integer constant"),
            )),
        }
    }

    /// The type of an intrinsic call's value.
    fn intrinsic_result_ty(&self, intrinsic_id: i64) -> i64 {
        use crate::c5::op::Intrinsic;
        let is = |k: Intrinsic| intrinsic_id == k as i64;
        let intr_kind = crate::c5::op::Intrinsic::from_i64(intrinsic_id);
        let is_fp_unary = intr_kind.is_some_and(|i| i.is_fp_unary());
        let is_int_bit_unary = intr_kind.is_some_and(|i| i.is_int_bit_unary());
        let is_bswap = intr_kind.is_some_and(|i| i.is_bswap());
        // `alloca` returns `void *`; the setjmp / longjmp / `va_*` forms are
        // `int` so a statement-context call typechecks.
        if is(Intrinsic::Trap) {
            // `__builtin_trap` and `__builtin_unreachable` are `void`, so
            // `return __builtin_unreachable();` is the 6.8.6.4p1 void form.
            super::types::void_ty()
        } else if is(Intrinsic::SetjmpAArch64)
            || is(Intrinsic::LongjmpAArch64)
            || is(Intrinsic::VaStart)
            || is(Intrinsic::VaEnd)
            || is(Intrinsic::VaCopy)
        {
            Ty::Int as i64
        } else if is(Intrinsic::VaArg) {
            // The address of the just-vacated slot; the `<stdarg.h>` macro
            // dereferences it as the requested type.
            (Ty::Char as i64) + (Ty::Ptr as i64)
        } else if is(Intrinsic::Fma) {
            Ty::Double as i64
        } else if is(Intrinsic::Fmaf) {
            Ty::Float as i64
        } else if is_fp_unary {
            if intr_kind.is_some_and(|i| i.is_single_precision()) {
                Ty::Float as i64
            } else {
                Ty::Double as i64
            }
        } else if is_int_bit_unary {
            // C99 has no such builtin; GCC defines the result
            // type as `int` for every form.
            Ty::Int as i64
        } else if is_bswap {
            // GCC types the result as the unsigned operand
            // width: uint16_t / uint32_t / uint64_t.
            (match intr_kind {
                Some(crate::c5::op::Intrinsic::Bswap16) => Ty::Short as i64,
                Some(crate::c5::op::Intrinsic::Bswap64) => Ty::LongLong as i64,
                _ => Ty::Int as i64,
            }) | super::types::UNSIGNED_BIT
        } else {
            (Ty::Char as i64) + (Ty::Ptr as i64)
        }
    }

    fn parse_direct_call(&mut self, id_idx: usize) -> Result<(), C5Error> {
        let callee = DirectCallee {
            params: self.symbols[id_idx].params.clone(),
            is_variadic: self.symbols[id_idx].is_variadic,
            name: self.symbols[id_idx].name.clone(),
            is_sys_call: self.symbols[id_idx].class == Token::Sys as i64,
            ret_ty: self.symbols[id_idx].type_,
            returns_struct: self.symbols[id_idx].class == Token::Fun as i64
                && is_struct_value_ty(self.symbols[id_idx].type_),
        };
        // A callee left at the implicit `int` (a `#pragma binding` with no
        // prototype, or a C89 implicit declaration) truncates a wider return
        // to 32 bits; warn once.
        if self.symbols[id_idx].implicit_return_int && self.warned_implicit_ret.insert(id_idx) {
            let name = self.symbols[id_idx].name.clone();
            let line = self.lex.line;
            self.warn_at(
                Code::IMPLICIT_FUNCTION_DECLARATION,
                line,
                alloc::format!(
                    "`{name}` is called without a return-type prototype; assuming `int`"
                ),
            );
        }
        let mut nargs = 0;
        // The per-argument stores consume the AST vstack slots they push;
        // the right-to-left re-push and the out-pointer push do not, so the
        // vstack is truncated back to this depth before the call node is
        // built.
        let saved_ast_vstack_depth = self.ast_vstack.len();
        let saved_loc_offs_for_result = self.loc_offs;
        let result_temp_off: i64 = if callee.returns_struct {
            let slots = self.slots_of_type(callee.ret_ty);
            let off = self.reserve_slots(slots);
            if slots >= 1 {
                self.multi_cell_temps.push((off, slots));
            }
            off
        } else {
            0
        };
        // Arguments are evaluated left to right into staging slots (side
        // effects in source order) and pushed right to left, so the first
        // declared parameter sits on top of the c5 stack.
        let saved_loc_offs = self.loc_offs;
        let mut temp_offsets: Vec<i64> = Vec::new();
        // The call node takes the per-argument nodes in source order; an
        // argument without a node leaves the call without one.
        let mut ast_arg_ids: Vec<Option<super::super::ast::ExprId>> = Vec::new();
        while self.lex.tk != ')' {
            let (temp_off, arg_ast) = self.parse_call_argument(&callee, nargs)?;
            temp_offsets.push(temp_off);
            ast_arg_ids.push(arg_ast);
            nargs += 1;
            self.accept(',')?;
        }
        for &temp_off in temp_offsets.iter().rev() {
            self.emit_lea(temp_off);
            self.mark_emit_other();
            self.ast_psh();
        }
        // The hidden out-pointer goes ahead of the first declared argument;
        // the callee's `return s` writes through it.
        if callee.returns_struct {
            self.emit_lea(result_temp_off);
            self.ast_psh();
        }
        // The staging slots are released; the result temp stays reserved
        // until the enclosing expression consumes it.
        let target_loc_offs = if callee.returns_struct {
            saved_loc_offs_for_result + self.slots_of_type(callee.ret_ty)
        } else {
            saved_loc_offs
        };
        // A compound literal reserved while evaluating the arguments has
        // block lifetime (C99 6.5.2.5p5) and is never reclaimed here.
        self.loc_offs = target_loc_offs.max(self.committed_loc_offs);
        if !callee.is_variadic
            && !callee.params.is_empty()
            && (nargs as usize) < callee.params.len()
        {
            let line = self.lex.line;
            self.warn_at(
                Code::TOO_FEW_ARGUMENTS,
                line,
                format!(
                    "too few arguments to `{}` (expected {}, got {})",
                    callee.name,
                    callee.params.len(),
                    nargs,
                ),
            );
        }
        self.next()?;
        if self.symbols[id_idx].class == Token::Sys as i64
            || self.symbols[id_idx].class == Token::Fun as i64
        {
            // A binding the unit defines later becomes one of its
            // functions, so a call made while it was bound counts too.
            self.symbols[id_idx].was_referenced = true;
            self.flush_pending_stores();
            self.pending.last_emit_was_indirect_call = false;
            self.ast_acc = None;
        } else if self.symbols[id_idx].class == Token::Loc as i64
            || self.symbols[id_idx].class == Token::Glo as i64
        {
            // A call through a function-pointer variable: the read counts for
            // the dead-store diagnostic.
            if self.symbols[id_idx].class == Token::Loc as i64 {
                self.symbols[id_idx].was_referenced = true;
                self.symbols[id_idx].was_read = true;
            } else {
                self.glo_imm_refs.push(id_idx);
            }
            self.flush_pending_stores();
            self.pending.last_emit_was_indirect_call = true;
            self.ast_acc = None;
        } else {
            let name = self.symbols[id_idx].name.clone();
            let suggestion = self.include_hint(&name);
            return Err(self.compile_err(
                Code::UNDECLARED_IDENTIFIER,
                format!("unknown function `{name}`{suggestion}"),
            ));
        }
        self.ast_vstack.truncate(saved_ast_vstack_depth);
        self.emit_direct_call_ast(id_idx, &callee, ast_arg_ids, result_temp_off);
        Ok(())
    }

    /// One argument of a direct call, evaluated into its staging slot.
    /// Returns the slot and the argument's AST node.
    fn parse_call_argument(
        &mut self,
        callee: &DirectCallee,
        nargs: i64,
    ) -> Result<(i64, Option<super::super::ast::ExprId>), C5Error> {
        let arg_line = self.lex.line;
        let temp_off = self.reserve_slots(1);

        self.emit_lea(temp_off);
        self.ast_psh();
        self.expr(Token::Assign as i64)?;

        // A `long double` that reaches a platform-libc callee as such is
        // decoded there in the ABI's wider format, not the binary64 c5
        // supplies; an argument converted to a `double` parameter is exact.
        // Past the fixed parameters 6.5.2.2p6 leaves the type alone.
        let reaches_callee_as_long_double = match callee.params.get(nargs as usize) {
            Some(want) => is_long_double_ty(*want),
            None => is_long_double_ty(self.ty),
        };
        if callee.is_sys_call
            && reaches_callee_as_long_double
            && let Some(platform_fmt) = self.target.platform_long_double_abi()
        {
            self.warn_at(
                Code::LONG_DOUBLE_ABI,
                arg_line,
                format!(
                    "`long double` argument {} of `{}` is passed as 8-byte \
                         binary64; this target's ABI passes {platform_fmt}",
                    nargs + 1,
                    callee.name,
                ),
            );
        }

        if (nargs as usize) < callee.params.len() {
            self.convert_declared_argument(callee, nargs, arg_line)?;
        } else {
            if !callee.params.is_empty() && !callee.is_variadic {
                self.warn_at(
                    Code::TOO_MANY_ARGUMENTS,
                    arg_line,
                    format!(
                        "too many arguments to `{}` (expected {}, got at least {})",
                        callee.name,
                        callee.params.len(),
                        nargs + 1,
                    ),
                );
            }
            // C99 6.5.2.2p6: an argument past the declared parameters, or to a
            // callee with no prototype, undergoes the default argument
            // promotions; `float` becomes `double`.
            if is_float_ty(self.ty) {
                self.convert_assign_rhs(Ty::Double as i64);
            }
        }

        let arg_ast = self.ast_acc;
        self.ast_assign();
        Ok((temp_off, arg_ast))
    }

    /// C99 6.5.2.2p7: an argument to a declared parameter undergoes the
    /// assignment conversion to the parameter type; a GNU `transparent_union`
    /// parameter takes the member the argument converts to.
    fn convert_declared_argument(
        &mut self,
        callee: &DirectCallee,
        nargs: i64,
        arg_line: usize,
    ) -> Result<(), C5Error> {
        let want = callee.params[nargs as usize];
        let arg_ty = self.ty;
        let zero = self.last_emit_is_zero();
        let untyped = self.last_emit_was_indirect_call();
        // A GNU `transparent_union` parameter accepts an argument compatible
        // with any member and takes it as that member.
        let tu_member = Self::transparent_union_member(&self.structs, want, self.ty, zero);
        if tu_member.is_none()
            && let Some(m) =
                Self::type_warning_with_flags(&self.structs, want, self.ty, zero, untyped)
        {
            let got = self.ty;
            let want_s = format_type(want, &self.structs);
            let got_s = format_type(got, &self.structs);
            let text = format!(
                "{} in argument {} of `{}` (param={want_s}, arg={got_s})",
                m.reason,
                nargs + 1,
                callee.name,
            );
            // A `Token::Sys` prototype approximates the platform libc (`char *`
            // for `void *`, `int` for `size_t`), so only a declared prototype
            // raises the 6.5.2.2p2 constraint.
            if m.no_conversion && !callee.is_sys_call {
                return Err(self.compile_err_at(Code::INCOMPATIBLE_TYPES, arg_line, text));
            }
            self.warn_at(m.code, arg_line, text);
        }
        if let Some(member_ty) = tu_member {
            // The member is materialized in an anonymous union object, so every
            // backend passes the union, as GCC does.
            self.convert_assign_rhs(member_ty);
            let slots = self.slots_of_type(want);
            let off = self.reserve_slots(slots);
            if slots >= 1 {
                self.multi_cell_temps.push((off, slots));
            }
            if let Some(value) = self.ast_acc.take() {
                let init = super::super::ast::LocalInit::Runtime {
                    zero_init: None,
                    elements: alloc::vec![super::super::ast::RuntimeInitElement {
                        offset: 0,
                        value: super::super::ast::RuntimeInitValue::Expr(value,),
                        ty: member_ty,
                        bitfield: None,
                    }],
                };
                self.ast_emit_compound_literal(off, want, 0, init);
            }
            self.ty = want;
        } else {
            self.convert_assign_rhs(want);
        }
        // C99 6.5.2.2p4: a libc import reads the argument at the full
        // register width, so an argument wider than an integer parameter is
        // narrowed here; a c5 callee narrows in its own parameter load.
        if callee.is_sys_call
            && !is_pointer_ty(want)
            && !is_floating_scalar(want)
            && !is_struct_ty(want)
            && self.size_of_type(arg_ty) > self.size_of_type(want)
        {
            self.renormalize_to_width(want);
        }
        Ok(())
    }

    fn emit_direct_call_ast(
        &mut self,
        id_idx: usize,
        callee: &DirectCallee,
        ast_arg_ids: Vec<Option<super::super::ast::ExprId>>,
        result_temp_off: i64,
    ) {
        // The result type of a call through a function-pointer variable is
        // the pointer's type less one level (`int (*)()` is `int`); a
        // variable that is not a function pointer calls as `int`.
        let is_var_call = self.symbols[id_idx].class == Token::Loc as i64
            || self.symbols[id_idx].class == Token::Glo as i64;
        let result_ty = if is_var_call {
            let vt = self.symbols[id_idx].type_;
            if self.symbols[id_idx].fn_ptr_indirection > 0 && is_pointer_ty(vt) {
                vt - Ty::Ptr as i64
            } else {
                Ty::Int as i64
            }
        } else {
            callee.ret_ty
        };
        // For a struct type the walker allocates the hidden out-pointer's
        // object and yields its address as the call's value.
        let callee_ty = self.symbols[id_idx].type_;
        let callee_id = self.ast_synthesize_callee(id_idx as u32, callee_ty);
        // A variadic function-pointer variable records its fixed count now,
        // while its block-scope binding is live (C99 6.2.1p4); the walker
        // runs after the scope is gone.
        if is_var_call && self.symbols[id_idx].is_variadic {
            self.ast
                .variadic_indirect_callees
                .push((callee_id, self.symbols[id_idx].params.len() as u32));
        }
        if is_var_call && self.symbols[id_idx].conv != crate::c5::codegen::CallConv::Target {
            self.ast
                .conv_indirect_callees
                .push((callee_id, self.symbols[id_idx].conv));
        }
        self.ast_emit_call(callee_id, ast_arg_ids.clone(), result_ty);
        // A struct result is its temp's address (the address-as-value rule).
        if callee.returns_struct {
            self.emit_lea(result_temp_off);
        }
        self.ty = result_ty;
        self.drop_operand_array_decay();
        // A callee returning a function pointer leaves a function-pointer
        // value, so a following unary `*` is the C99 6.3.2.1p4 no-op.
        if self.symbols[id_idx].class == Token::Fun as i64
            && self.symbols[id_idx].fn_ptr_indirection > 0
        {
            self.pending.fn_ptr_chain_depth = 0;
        } else if is_var_call && self.symbols[id_idx].fn_ptr_ret_indirection > 0 {
            self.pending.fn_ptr_chain_depth = self.symbols[id_idx].fn_ptr_ret_indirection - 1;
        }
    }

    fn parse_enum_constant(&mut self, id_idx: usize) -> Result<(), C5Error> {
        let val = self.symbols[id_idx].val;
        // The registration typed the constant: `int`, or wider / unsigned for
        // an enumerator outside `int`'s range (GCC extension).
        let ty = self.symbols[id_idx].type_;
        self.emit_int_constant(val, ty);
        Ok(())
    }

    /// A function name used as a value (C99 6.3.2.1p4): the function's
    /// address, typed as the return type at one pointer level. A `Token::Sys`
    /// import has no compile-time address; the walker materializes its stub.
    fn parse_function_designator(&mut self, id_idx: usize) -> Result<(), C5Error> {
        if self.symbols[id_idx].class == Token::Fun as i64 {
            self.symbols[id_idx].was_referenced = true;
            // The `CODE_BASE` bias tells the VM a function pointer from a data
            // pointer; the walker resolves the address on the SSA side.
            self.emit_imm(CODE_BASE as i64 + self.symbols[id_idx].val);
            self.ty = self.symbols[id_idx].type_ + Ty::Ptr as i64;
            self.ast_emit_ident(id_idx as u32, self.ty);
            // A following unary `*` is the C99 6.3.2.1p4 no-op at every level
            // (`(****g)(...)` calls `g`).
            self.pending.fn_ptr_chain_depth = 0;
        } else {
            // An import has no compile-time address; the walker materializes the
            // import's stub address from the binding index in `val`.
            self.emit_imm(CODE_BASE as i64);
            self.ty = self.symbols[id_idx].type_ + Ty::Ptr as i64;
            self.ast_emit_ident(id_idx as u32, self.ty);
            self.pending.fn_ptr_chain_depth = 0;
        }
        Ok(())
    }

    fn parse_register_variable(&mut self, id_idx: usize) -> Result<(), C5Error> {
        // A stack- or frame-pointer register variable reads as a register
        // move; a write has no meaning.
        if self.lex.tk == Token::Assign
            || self.lex.tk == Token::AssignOp
            || self.lex.tk == Token::Inc
            || self.lex.tk == Token::Dec
        {
            return Err(self.compile_err(
                Code::INVALID_OPERANDS,
                format!(
                    "cannot write register variable `{}`",
                    self.symbols[id_idx].name
                ),
            ));
        }
        self.symbols[id_idx].was_referenced = true;
        self.symbols[id_idx].was_read = true;
        self.mark_emit_other();
        self.ty = self.symbols[id_idx].type_;
        let kind = match self.symbols[id_idx].asm_register {
            Some(crate::c5::symbol::AsmRegister::FramePointer) => {
                crate::c5::op::Intrinsic::FrameAddress
            }
            _ => crate::c5::op::Intrinsic::StackPointer,
        };
        let args = alloc::vec::Vec::new();
        let intr_ty = self.ty;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            super::super::ast::Expr::Intrinsic {
                kind: kind as i64,
                args,
                ty: intr_ty,
            },
            pos,
        );
        self.ast_acc = Some(id);
        Ok(())
    }

    fn parse_variable(&mut self, id_idx: usize) -> Result<(), C5Error> {
        let identifier_is_local = self.symbols[id_idx].class == Token::Loc as i64;
        if identifier_is_local {
            self.symbols[id_idx].was_referenced = true;
            self.emit_lea(self.symbols[id_idx].val);
        } else if self.symbols[id_idx].class == Token::Glo as i64
            && self.symbols[id_idx].is_thread_local
        {
            // A `_Thread_local` object is reached through the target's TLS
            // sequence; the operand is its offset in the TLS block.
            self.mark_emit_other();
        } else if self.symbols[id_idx].class == Token::Glo as i64 {
            self.emit_data_imm(self.symbols[id_idx].val);
            self.glo_imm_refs.push(id_idx);
        } else {
            return Err(self.compile_err(
                Code::UNDECLARED_IDENTIFIER,
                format!("undefined variable {}", self.symbols[id_idx].name),
            ));
        }
        self.ty = self.symbols[id_idx].type_;
        let is_struct_value = is_struct_value_ty(self.ty);
        // A declared struct object starts a member chain.
        self.pending.member_base = if is_struct_value {
            Some(super::MemberBase {
                decl_size: Some(self.size_of_type(self.ty) as i64),
                ..super::MemberBase::UNKNOWN
            })
        } else {
            None
        };
        let is_array_var =
            self.symbols[id_idx].array_size != 0 || self.symbols[id_idx].is_zero_len_array;
        let is_vla_var = self.symbols[id_idx].is_vla;
        // A function-pointer variable carries its prototype so `(*fp)(args)`,
        // which reaches the postfix call, converts each argument (C99
        // 6.5.2.2p7).
        if !is_array_var && !is_struct_value && !self.symbols[id_idx].params.is_empty() {
            self.pending.indirect_callee_params = Some(self.symbols[id_idx].params.clone());
            self.pending.indirect_callee_is_variadic = self.symbols[id_idx].is_variadic;
            self.pending.indirect_callee_conv = self.symbols[id_idx].conv;
            self.pending.indirect_callee_fn_ptr_depth = self.symbols[id_idx].fn_ptr_indirection;
            self.pending.indirect_callee_ret_fn_ptr = self.symbols[id_idx].fn_ptr_ret_indirection;
        }
        if is_vla_var {
            // C99 6.3.2.1p3: a VLA decays to its runtime base pointer, loaded
            // from the hidden slot.
            let ptr_slot = self.symbols[id_idx].vla_ptr_slot;
            self.ty += Ty::Ptr as i64;
            self.ast_emit_vla_base(ptr_slot, self.ty);
        } else if is_array_var {
            self.decay_array_variable(id_idx, identifier_is_local);
        } else if is_struct_value {
            if identifier_is_local {
                // A struct object's value is its address, with no load to track a
                // read by; the object counts as address-escaped.
                self.symbols[id_idx].address_escaped = true;
            }
            self.ast_emit_ident(id_idx as u32, self.ty);
        } else {
            self.load_scalar_variable(id_idx, identifier_is_local);
        }
        Ok(())
    }

    /// C99 6.3.2.1p3: an array object used as a value is the address of
    /// its first element, typed one pointer level up, with the shape
    /// left for an enclosing `sizeof`, `typeof` or subscript to read.
    fn decay_array_variable(&mut self, id_idx: usize, identifier_is_local: bool) {
        if identifier_is_local {
            // The decayed address may be indexed, passed or stored, none of
            // which is tracked; the array counts as address-escaped.
            self.symbols[id_idx].address_escaped = true;
        }
        self.ty += Ty::Ptr as i64;
        self.ast_emit_ident(id_idx as u32, self.ty);
        // The element count reaches an enclosing `sizeof`. `array_size` is
        // `-1` for `extern T x[]`, whose size this unit does not know (C99
        // 6.7.5.2); the hint stays clear.
        if self.symbols[id_idx].array_size > 0 {
            self.pending.last_array_decay_size = self.symbols[id_idx].array_size;
        } else if self.symbols[id_idx].is_zero_len_array {
            // A zero-length array signals its array-ness with the `-1`
            // sentinel; its count of 0 would read as no hint.
            self.pending.last_array_decay_size = -1;
        }
        let elem_ty = self.symbols[id_idx].type_;
        let elem_size = self.size_of_type(elem_ty) as i64;
        let dims = self.symbols[id_idx].array_dims.clone();
        // The dimension list lets `&arr` and `typeof` rebuild the array
        // type; a zero-length array records its bound so `typeof` reads
        // `T[0]`.
        self.pending.last_array_decay_dims =
            if dims.is_empty() && self.symbols[id_idx].is_zero_len_array {
                alloc::vec![0]
            } else {
                dims.clone()
            };
        self.seed_multi_dim_strides(&dims, elem_size);
        // A function-pointer element keeps its prototype for `arr[i](args)`
        // and its decay depth for `(*arr[i])(...)`: the subscript consumes
        // an array level, not an indirection level.
        let fpi = self.symbols[id_idx].fn_ptr_indirection;
        if fpi > 0 {
            self.pending.fn_ptr_chain_depth = fpi - 1;
            self.pending.fn_ptr_depth_is_array_elem = true;
        }
        if fpi > 0 || !self.symbols[id_idx].params.is_empty() {
            self.pending.indirect_callee_params = Some(self.symbols[id_idx].params.clone());
            self.pending.indirect_callee_is_variadic = self.symbols[id_idx].is_variadic;
            self.pending.indirect_callee_conv = self.symbols[id_idx].conv;
            self.pending.indirect_callee_fn_ptr_depth = fpi;
            self.pending.indirect_callee_ret_fn_ptr = self.symbols[id_idx].fn_ptr_ret_indirection;
        }
    }

    /// A scalar or pointer object: its value is loaded, and the load is
    /// left as the trailing emit so an assignment or `&` can retract it.
    fn load_scalar_variable(&mut self, id_idx: usize, identifier_is_local: bool) {
        self.mark_emit_scalar_load();
        self.ast_emit_ident(id_idx as u32, self.ty);
        if identifier_is_local {
            // The read is tentative: an assignment or `&` that retracts the load
            // restores `was_read` and the pending stores through
            // `last_loaded_local`.
            self.pending.last_loaded_local = Some(id_idx);
            self.pending.last_loaded_local_prior_was_read = self.symbols[id_idx].was_read;
            self.pending.last_loaded_local_prior_pending =
                core::mem::take(&mut self.symbols[id_idx].pending_stores);
            self.symbols[id_idx].was_read = true;
        }
        // `mark_emit_scalar_load` cleared the decay depth; the load consumed
        // one indirection level of the symbol's `fn_ptr_indirection`.
        let fpi = self.symbols[id_idx].fn_ptr_indirection;
        if fpi > 0 {
            self.pending.fn_ptr_chain_depth = fpi - 1;
        }
        // A parameter declared `T name[A][B][C]` keeps its dimensions but
        // decayed to a pointer (C99 6.7.5.3p7): the loaded value is one level
        // below the array, so the strides come from the pointee.
        let dims = self.symbols[id_idx].array_dims.clone();
        if !dims.is_empty() && is_pointer_ty(self.ty) {
            if dims[0] == 0 {
                // For `T name[][M...]` the outermost dimension is the decayed
                // pointer itself, so the inner strides come from the scalar element.
                let scalar_ty = self.symbols[id_idx].type_ - (Ty::Ptr as i64);
                let elem_size = self.size_of_type(scalar_ty) as i64;
                self.seed_multi_dim_strides(&dims, elem_size);
            } else {
                let elem_size = self.pointee_size(self.ty);
                self.seed_multi_dim_strides(&dims, elem_size);
            }
        }
    }

    fn parse_parenthesized(&mut self) -> Result<(), C5Error> {
        self.next()?;
        if self.lex.tk == '{' {
            self.parse_stmt_expr_body()?;
        } else if self.lex_is_type_start() {
            self.parse_cast_or_compound_literal()?;
        } else {
            self.expr(Token::Assign as i64)?;
            // C99 6.5.17: a comma chain, reached only in parentheses because
            // `expr(Assign)` leaves `,` to its caller. `Expr::Comma` keeps the
            // left operand's side effects for the walker.
            while self.lex.tk == ',' {
                let lhs_ast = self.ast_acc;
                self.next()?;
                self.expr(Token::Assign as i64)?;
                let rhs_ast = self.ast_acc;
                if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                    let pos = self.ast_src_pos();
                    let ty = self.ty;
                    let id = self
                        .ast
                        .push_expr(super::super::ast::Expr::Comma { lhs, rhs, ty }, pos);
                    self.ast_acc = Some(id);
                }
            }
            if self.lex.tk == ')' {
                self.next()?;
            } else {
                return Err(self.compile_err(Code::SYNTAX, "close paren expected"));
            }
            // The inner expression's unconsumed strides carry on to this
            // expression's postfix operators, as in `(*p)[k]`.
            self.pending.index_stride = core::mem::take(&mut self.pending.end_of_expr_stride);
            self.pending.index_strides_tail =
                core::mem::take(&mut self.pending.end_of_expr_strides_tail);
        }
        Ok(())
    }

    fn parse_cast_or_compound_literal(&mut self) -> Result<(), C5Error> {
        let type_name = self.parse_type_name()?;
        self.note_cast_type_name(type_name.base);
        if self.lex.tk == ')' {
            self.next()?;
        } else {
            return Err(self.compile_err(Code::INVALID_OPERANDS, "bad cast"));
        }
        if self.lex.tk == '{' {
            // C99 6.5.2.5 compound literal: `(type){ init }`. An array
            // typedef's dimensions complete the type from the inside:
            // `(row[2]){...}` with `typedef int row[3]` is `int[2][3]`
            // (C99 6.7.7); a `*` absorbed the typedef array into the
            // pointee instead.
            return self.parse_block_compound_literal(type_name.ty, &type_name.dims);
        }
        self.parse_cast_operand(type_name)
    }

    /// The operand of a cast and its conversion to the named type
    /// (C99 6.5.4).
    fn parse_cast_operand(&mut self, type_name: TypeName) -> Result<(), C5Error> {
        let t = type_name.ty;
        self.expr(Token::Inc as i64)?;
        let cast_child_ast = self.ast_acc;
        // A cast between floating and integer converts; one within a class
        // (integer / pointer, float / double) keeps the bit pattern.
        let target_is_fp = is_floating_scalar(t);
        let source_is_fp = is_floating_scalar(self.ty);
        if target_is_fp ^ source_is_fp {
            self.ast_fpcast();
        } else if !target_is_fp && !source_is_fp && !is_pointer_ty(t) && !is_pointer_ty(self.ty) {
            // Values are kept sign- or zero-extended to 64 bits, so a narrowing
            // cast re-extends to the target width: a mask for an unsigned
            // target, a shift pair for a signed one.
            let target_size = self.size_of_type(t);
            let source_size = self.size_of_type(self.ty);
            if is_unsigned_ty(t) {
                let mask: i64 = match target_size {
                    1 => 0xff,
                    2 => 0xffff,
                    4 => 0xffff_ffff,
                    _ => -1,
                };
                if mask != -1 {
                    self.emit_binop_with_imm(crate::c5::ir::BinOp::And, mask);
                }
            } else if target_size == 1 || target_size == 2 || target_size == 4 {
                // Needed when the cast narrows, or when the source is unsigned at
                // the same width (`(signed char)(unsigned char)` must turn values
                // at or above 0x80 negative, C99 6.3.1.3); a widening or same-width
                // signed source is already extended.
                let source_is_unsigned = is_unsigned_ty(self.ty);
                let needs_extend =
                    target_size < source_size || (target_size == source_size && source_is_unsigned);
                if needs_extend {
                    let bits = 64i64 - (target_size as i64) * 8;
                    self.emit_binop_with_imm(crate::c5::ir::BinOp::Shl, bits);
                    self.emit_binop_with_imm(crate::c5::ir::BinOp::Shr, bits);
                }
            }
        }
        self.ty = t;
        // C99 6.5.4: the value has the cast type, so an operand's array
        // shape does not reach an enclosing `sizeof` / `typeof`.
        self.pending.last_array_decay_size = 0;
        self.pending.last_array_decay_bytes = 0;
        // The cast node replaces the conversion's intermediate nodes, which
        // have no consumer.
        if let Some(child) = cast_child_ast {
            self.ast_emit_cast(child, t);
        }
        // The cast destination's function-pointer lineage lets a following
        // unary `*` chain decay, as in `(**(finder_type*)p)(...)`.
        if let Some(fpi) = type_name.fn_ptr_indirection
            && fpi > 0
        {
            self.pending.fn_ptr_chain_depth = fpi - 1;
        }
        // C99 6.5.2.2p7: a call through the cast uses the cast's prototype,
        // whatever the operand declared; `typeof(<cast>)` recovers it
        // through `last_fn_ptr_cast`.
        if let Some(pp) = type_name.proto {
            self.pending.last_fn_ptr_cast = Some((
                t,
                pp.types.clone(),
                pp.is_variadic,
                type_name.fn_ptr_indirection.unwrap_or(1).max(1),
            ));
            self.pending.indirect_callee_is_variadic = pp.is_variadic;
            self.pending.indirect_callee_conv = core::mem::take(&mut self.pending.attr_call_conv);
            self.pending.indirect_callee_fn_ptr_depth =
                type_name.fn_ptr_indirection.unwrap_or(1).max(1);
            self.pending.indirect_callee_ret_fn_ptr = 0;
            self.pending.indirect_callee_params = if pp.types.is_empty() {
                None
            } else {
                Some(pp.types)
            };
        }
        Ok(())
    }

    fn parse_deref(&mut self) -> Result<(), C5Error> {
        self.next()?;
        // The operand's unconsumed strides, read from the end-of-expression
        // snapshot its nested `expr` leaves, tell a pointer-to-array row
        // dereference from a scalar one; the enclosing snapshot is kept.
        let saved_eos_stride = core::mem::take(&mut self.pending.end_of_expr_stride);
        let saved_eos_tail = core::mem::take(&mut self.pending.end_of_expr_strides_tail);
        self.expr(Token::Inc as i64)?;
        let leftover_stride = core::mem::take(&mut self.pending.end_of_expr_stride);
        let leftover_tail = core::mem::take(&mut self.pending.end_of_expr_strides_tail);
        self.pending.end_of_expr_stride = saved_eos_stride;
        self.pending.end_of_expr_strides_tail = saved_eos_tail;
        if let Some(id) = self.ptr_array_id_depth1(self.ty) {
            // A pointer-to-array tag is never a function pointer, and a cast
            // leaves the decay depth at 0, so this is tested first: `*p` reaches
            // the array, which decays to the element pointer (C99 6.3.2.1p3)
            // with no load.
            self.decay_ptr_array_value(id);
        } else if self.pending.fn_ptr_chain_depth == 0 {
            // C99 6.3.2.1p4: `*` on a function pointer yields the function
            // pointer; the depth stays 0 so further `*`s decay too.
        } else if let Some(id) = self.ptr_array_id_depth1(self.ty) {
            self.decay_ptr_array_value(id);
        } else if leftover_stride > 0 {
            // `*p` on a pointer-to-array row is `p[0]`: no load, the head
            // stride is consumed and the rest queued for a following `[k]`;
            // the row size reaches an enclosing `sizeof`.
            self.pending.last_array_decay_bytes = leftover_stride;
            let mut tail = leftover_tail;
            self.pending.index_stride = if tail.is_empty() { 0 } else { tail.remove(0) };
            self.pending.index_strides_tail = tail;
        } else {
            if is_pointer_ty(self.ty) {
                self.ty -= Ty::Ptr as i64;
            } else {
                return Err(self.compile_err(Code::INVALID_OPERANDS, "bad dereference"));
            }
            // A struct value is its address: no load.
            let result_is_struct_value = is_struct_value_ty(self.ty);
            let deref_child_ast = self.ast_acc;
            if !result_is_struct_value {
                let prior_depth = self.pending.fn_ptr_chain_depth;
                self.mark_emit_scalar_load();
                // A real dereference consumes one indirection level toward the
                // function pointer; -1 (untracked) stays.
                if prior_depth > 0 {
                    self.pending.fn_ptr_chain_depth = prior_depth - 1;
                }
            }
            if let Some(child) = deref_child_ast {
                let result_ty = self.ty;
                let pos = self.ast_src_pos();
                let id = self.ast.push_expr(
                    super::super::ast::Expr::Unary {
                        op: super::super::ast::UnOp::Deref,
                        child,
                        ty: result_ty,
                    },
                    pos,
                );
                self.ast_acc = Some(id);
            }
            // `*arr` is the first element, not the array: an enclosing
            // `sizeof` reads `sizeof(T)`.
            self.pending.last_array_decay_size = 0;
            self.pending.last_array_decay_bytes = 0;
        }
        Ok(())
    }

    fn parse_label_address(&mut self) -> Result<(), C5Error> {
        // GCC labels as values: `&&label` is the label's address as
        // `void *`; a forward reference is interned and resolved by the
        // walker.
        let label = self.parse_label_addr_operand()?;
        let pos = self.ast_src_pos();
        let id = self
            .ast
            .push_expr(super::super::ast::Expr::LabelAddr(label), pos);
        self.ast_acc = Some(id);
        self.ty = Ty::Char as i64 + Ty::Ptr as i64;
        Ok(())
    }

    fn parse_address_of(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.expr(Token::Inc as i64)?;
        // The result type is set before the trailing load is dropped, so
        // the `AddrOf` node built there carries the pointer type. A struct
        // value's address is already the value, and a load emitted earlier
        // in its chain (`p` for `p->mutex`) must stay, so the struct case is
        // decided on the type before any load is popped.
        let pre_addr_ty = self.ty;
        self.ty += Ty::Ptr as i64;
        if is_struct_value_ty(pre_addr_ty) {
            // The address stands; an `AddrOf` node over the lvalue forms the
            // walker handles records the pointer type, so a consumer tells a
            // struct pointer from a by-value struct. A compound literal is an
            // lvalue (C99 6.5.2.5p4); a call result keeps its struct type.
            let wrappable = match self.ast_acc {
                Some(id) => matches!(
                    self.ast.expr(id),
                    super::super::ast::Expr::Ident { .. }
                        | super::super::ast::Expr::Member { .. }
                        | super::super::ast::Expr::Index { .. }
                        | super::super::ast::Expr::Binary { .. }
                        | super::super::ast::Expr::CompoundLiteral { .. }
                        | super::super::ast::Expr::Unary {
                            op: super::super::ast::UnOp::Deref,
                            ..
                        }
                ),
                None => false,
            };
            if wrappable {
                self.ast_apply_unary(super::super::ast::UnOp::AddrOf);
            }
        } else if self.pop_trailing_scalar_load() {
            // A scalar or pointer lvalue: dropping the load leaves its address.
        } else if is_pointer_ty(pre_addr_ty) {
            // A decayed array: its address was the value already, so `&` emits
            // nothing. C99 6.5.3.2p3: the type is pointer to the array, rebuilt
            // for a known-size 1D array (`index_stride == 0`) so `(*p)[i]`,
            // `sizeof(&arr)` and `typeof(&arr)` see it.
            let n = self.pending.last_array_decay_size;
            let decay_dims = core::mem::take(&mut self.pending.last_array_decay_dims);
            if decay_dims.len() >= 2 {
                // For a multi-dimensional array the pointee is the whole aggregate;
                // the seeded strides belong to the decayed operand and are cleared.
                let elem_ty = pre_addr_ty - Ty::Ptr as i64;
                let agg = self.array_agg_type(elem_ty, &decay_dims);
                self.ty = agg + Ty::Ptr as i64;
                self.pending.index_stride = 0;
                self.pending.index_strides_tail.clear();
            } else if n > 0 && self.pending.index_stride == 0 {
                let elem_ty = pre_addr_ty - Ty::Ptr as i64;
                let agg = self.array_agg_type(elem_ty, &[n]);
                self.ty = agg + Ty::Ptr as i64;
            }
            self.pending.last_array_decay_size = 0;
            self.pending.last_array_decay_bytes = 0;
        } else if matches!(
            self.ast_acc,
            Some(id) if matches!(
                self.ast.expr(id),
                super::super::ast::Expr::CompoundLiteral { .. }
            )
        ) {
            // C99 6.5.2.5p4: a compound literal is an lvalue. A scalar literal
            // was materialized without a trailing load, so the walker's lvalue
            // path yields its slot address.
            self.ast_apply_unary(super::super::ast::UnOp::AddrOf);
        } else {
            return Err(self.compile_err(Code::INVALID_OPERANDS, "bad address-of"));
        }
        // `&` adds one level toward a tracked function pointer; -1
        // (untracked) stays.
        if self.pending.fn_ptr_chain_depth >= 0 {
            self.pending.fn_ptr_chain_depth += 1;
        }
        Ok(())
    }

    fn parse_logical_not(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.expr(Token::Inc as i64)?;
        // C99 6.5.3.3p1 requires a scalar operand; the GCC vector
        // extension does not extend `!` to a vector either.
        if is_struct_value_ty(self.ty) && !self.is_int128_ty(self.ty) {
            return Err(self.compile_err(
                Code::INVALID_OPERANDS,
                "invalid operand to unary `!` (aggregate type)",
            ));
        }
        self.emit_binop_with_imm(crate::c5::ir::BinOp::Eq, 0);
        self.ty = Ty::Int as i64;
        Ok(())
    }

    fn parse_bit_not(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.expr(Token::Inc as i64)?;
        // GCC vector extension: `~v` is element-wise over an integer
        // vector and the result keeps the vector type (no promotion).
        if is_vector_ty(&self.structs, self.ty) {
            let elem_ty = self.structs[struct_id_of(self.ty)].fields[0].ty;
            if is_floating_scalar(elem_ty) {
                return Err(self.compile_err(
                    Code::INVALID_OPERANDS,
                    "invalid operand to unary `~` (vector of float)",
                ));
            }
            self.ast_apply_unary(super::super::ast::UnOp::BitNot);
        } else {
            self.emit_binop_with_imm(crate::c5::ir::BinOp::Xor, -1);
            // C99 6.5.3.3p4: the result has the promoted operand type, so a
            // `long` keeps its width and signedness for a following `>>`. A
            // 4-byte unsigned result is masked back: the xor set all 64 bits.
            let promoted = integer_promote(self.ty);
            if is_unsigned_ty(promoted) && self.size_of_type(promoted) == 4 {
                self.emit_binop_with_imm(crate::c5::ir::BinOp::And, 0xffff_ffff);
            }
            self.ty = promoted;
        }
        Ok(())
    }

    fn parse_unary_plus(&mut self) -> Result<(), C5Error> {
        // C99 6.5.3.3p2: the result has the promoted operand type; a
        // floating operand keeps its type.
        self.next()?;
        self.expr(Token::Inc as i64)?;
        if !is_floating_scalar(self.ty) {
            self.ty = integer_promote(self.ty);
        }
        Ok(())
    }

    fn parse_unary_minus(&mut self) -> Result<(), C5Error> {
        self.next()?;
        // `-<integer constant>` folds; a floating constant does not, its
        // negation applies to the f64 bits.
        if self.lex.tk == Token::Num {
            let val = self.lex.ival;
            // C99 6.5.3.3p3: the promoted type of the constant's 6.4.4.1p5 type,
            // so a value past INT_MAX does not stay `int`.
            self.ty = integer_promote(self.num_token_type(val));
            // 6.2.5p9: an unsigned negation wraps modulo 2^N (`-1U` is
            // UINT_MAX).
            let negated = narrow_const_int(
                self.size_of_type(self.ty),
                is_unsigned_ty(self.ty),
                false,
                i128::from(val.wrapping_neg()),
            ) as i64;
            self.emit_imm(negated);
            self.ast_emit_int_lit(negated, self.ty);
            self.next()?;
        } else {
            self.expr(Token::Inc as i64)?;
            if is_vector_ty(&self.structs, self.ty) {
                // GCC vector extension: `-v` is element-wise and the
                // result keeps the vector type (no promotion).
                self.ast_apply_unary(super::super::ast::UnOp::Neg);
            } else if is_floating_scalar(self.ty) {
                self.ast_fneg();
            } else {
                // C99 6.5.3.3p3: the result has the promoted operand type.
                let operand_ty = self.ty;
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, -1);
                self.ty = integer_promote(operand_ty);
                // Negating the type minimum overflows the width, so a 32-bit
                // result is renormalized for a later 64-bit read.
                if self.size_of_type(self.ty) == 4 {
                    self.renormalize_to_width(self.ty);
                }
            }
        }
        Ok(())
    }

    /// C99 6.5.3.1: prefix `++` / `--`. The operand is parsed by a nested
    /// `expr`, so a pointer-to-array operand's stride sits in the
    /// end-of-expression snapshot.
    fn parse_prefix_inc_dec(&mut self) -> Result<(), C5Error> {
        let is_inc = self.lex.tk == Token::Inc;
        self.next()?;
        self.expr(Token::Inc as i64)?;
        if let Some((lvalue, ty)) = self.direct_inc_lvalue() {
            return self.emit_direct_inc_dec(lvalue, ty, is_inc, false);
        }
        let (lvalue, fn_ptr_step) = self.inc_dec_lvalue("pre-increment")?;
        let step = if fn_ptr_step {
            1
        } else {
            self.pointer_to_array_arith_stride(
                self.pending.end_of_expr_stride,
                self.ty,
                self.pointee_step(self.ty),
            )
        };
        self.emit_imm(step);
        self.ast_binop(if is_inc {
            super::super::ir::BinOp::Add
        } else {
            super::super::ir::BinOp::Sub
        });
        self.ast_assign();
        let ty = self.ty;
        if let Some(lvalue) = lvalue {
            self.ast_emit_pre_inc(lvalue, if is_inc { step } else { -step }, ty);
        }
        Ok(())
    }

    /// The lvalue of a `++` / `--` that reads and stores through the
    /// trailing load: the load becomes a push of the address, and the
    /// local it read is recorded as read and written. Returns the lvalue
    /// node and whether the value is a function pointer, which steps by
    /// one byte.
    fn inc_dec_lvalue(
        &mut self,
        what: &str,
    ) -> Result<(Option<super::super::ast::ExprId>, bool), C5Error> {
        let lvalue = self.ast_acc;
        let fn_ptr_step = self.value_is_function_pointer();
        self.rewrite_trailing_load_as_psh().ok_or_else(|| {
            self.compile_err(Code::INVALID_OPERANDS, format!("bad lvalue in {what}"))
        })?;
        let line = self.lex.line;
        if let Some(idx) = self.take_last_loaded_local() {
            self.symbols[idx].was_read = true;
            self.symbols[idx].was_written = true;
            self.record_local_read(idx);
            self.record_local_store(idx, line);
        }
        self.mark_emit_other();
        self.ast_psh();
        Ok((lvalue, fn_ptr_step))
    }

    /// A `++` / `--` on a bitfield member or a 128-bit integer, whose
    /// read is not one scalar load: the node is built over the lvalue and
    /// the walker performs the read-modify-write.
    fn emit_direct_inc_dec(
        &mut self,
        lvalue: super::super::ast::ExprId,
        ty: i64,
        is_inc: bool,
        postfix: bool,
    ) -> Result<(), C5Error> {
        let by = if is_inc { 1 } else { -1 };
        let src = self.ast_src_pos();
        let expr = if postfix {
            self.next()?;
            super::super::ast::Expr::PostInc { lvalue, by, ty }
        } else {
            super::super::ast::Expr::PreInc { lvalue, by, ty }
        };
        let id = self.ast.push_expr(expr, src);
        self.ast_acc = Some(id);
        self.ty = ty;
        Ok(())
    }

    /// One step of the precedence-climbing loop: the postfix or binary
    /// operator at the current token, applied to the operand the loop holds.
    fn parse_operator(&mut self) -> Result<(), C5Error> {
        let lhs_ty = self.ty;
        // An operator consumes the operand, so its array shape does not
        // reach an enclosing `sizeof`.
        self.pending.last_array_decay_size = 0;
        self.pending.last_array_decay_bytes = 0;
        self.pending.last_array_decay_dims.clear();
        let row_member = self.pending.last_array_decay_member.take();
        let member_base = self.pending.member_base.take();
        // C99 6.5: a struct or union value is not an operand of the
        // arithmetic, bitwise, shift, relational, equality or logical
        // operators (the token range `Lor..=ModOp`); a pointer to one is.
        if is_struct_value_ty(lhs_ty)
            && self.lex.tk >= Token::Lor as i64
            && self.lex.tk <= Token::ModOp as i64
            // GCC vector extension: a vector takes the element-wise operators
            // and the comparisons; the operator arm checks the right operand.
            && !(is_vector_ty(&self.structs, lhs_ty)
                && (is_vector_binop_token(self.lex.tk.raw())
                    || is_vector_compare_token(self.lex.tk.raw())))
            // The GCC 128-bit integer is an integer type.
            && !self.is_int128_ty(lhs_ty)
        {
            return Err(self.compile_err(
                Code::INVALID_OPERANDS,
                "invalid operands to binary operator (aggregate type)",
            ));
        }
        if self.lex.tk == '(' {
            self.parse_indirect_call()
        } else if self.lex.tk == Token::Assign {
            self.parse_assignment(lhs_ty)
        } else if self.lex.tk == Token::AssignOp {
            self.parse_compound_assignment(lhs_ty)
        } else if self.lex.tk == Token::Cond {
            self.parse_conditional()
        } else if let Some(op) = binary_op(self.lex.tk.raw()) {
            self.parse_binary(lhs_ty, op)
        } else if self.lex.tk == Token::Inc || self.lex.tk == Token::Dec {
            self.parse_postfix_inc_dec()
        } else if self.lex.tk == Token::Brak {
            self.parse_subscript(lhs_ty, row_member)
        } else if self.lex.tk == Token::Arrow || self.lex.tk == Token::Dot {
            self.parse_member_access(lhs_ty, member_base)
        } else {
            Err(self.compile_err(
                Code::INTERNAL,
                format!(
                    "compiler error: unexpected {}",
                    super::super::token::describe(self.lex.tk)
                ),
            ))
        }
    }

    fn end_expression(&mut self) {
        // Strides an array decay seeded and no subscript consumed must not
        // reach the next expression; they are snapshotted for one level so
        // an enclosing unary `*` can read what its operand left.
        self.pending.end_of_expr_stride = self.pending.index_stride;
        self.pending.end_of_expr_strides_tail =
            core::mem::take(&mut self.pending.index_strides_tail);
        self.pending.index_stride = 0;
        self.pending.member_base = None;
    }

    fn parse_indirect_call(&mut self) -> Result<(), C5Error> {
        let callee_ast = self.ast_acc;
        let ast_vstack_snapshot = self.ast_vstack.len();
        let mut indirect_arg_ids: alloc::vec::Vec<Option<super::super::ast::ExprId>> =
            alloc::vec::Vec::new();
        // A call on a function-pointer value: `s.fp(args)`, `arr[i](args)`,
        // `(*fp)(args)`, `(**fpp)(args)`. Unary `*` cannot know that its
        // operand will be called and loads through the last pointer level
        // regardless; when the type ended below a pointer and the last emit
        // was a pointer-sized load, that load is dropped and the level
        // restored (C99 6.3.2.1p4).
        if !is_pointer_ty(self.ty) {
            let trailing = self.current_scalar_load_kind();
            let is_load = matches!(
                trailing,
                Some(LoadKind::I64)
                    | Some(LoadKind::U8)
                    | Some(LoadKind::I32)
                    | Some(LoadKind::U32)
            );
            if is_load {
                self.clear_recent_emits();
                self.ty += Ty::Ptr as i64;
            }
        }
        self.next()?;
        // The result type is the function pointer's type less one level
        // (`int (*)()` is `int`); a non-pointer callee calls as `int`.
        let callee_fp_ty = self.ty;
        // A pointer to a function pointer through a function-type typedef
        // (`typedef RET F(args); F *m;`) strips its whole chain, so the
        // result is `RET`; restricted to a struct callee and capped by the
        // pointer depth so a stale chain count cannot over-strip.
        let chain = self.pending.fn_ptr_chain_depth;
        let strip =
            if chain > 0 && is_struct_ty(callee_fp_ty) && struct_ptr_depth(callee_fp_ty) > chain {
                chain + 1
            } else {
                1
            };
        let indirect_ret_ty = if is_pointer_ty(callee_fp_ty) {
            callee_fp_ty - strip * Ty::Ptr as i64
        } else {
            Ty::Int as i64
        };
        let fp_temp = self.reserve_slots(1);
        self.mark_emit_other();
        // Arguments are evaluated left to right into staging slots and
        // converted to the declared parameter types the operand carried
        // (C99 6.5.2.2p7), as for a direct call.
        let callee_params = self.pending.indirect_callee_params.take();
        let callee_is_variadic = core::mem::take(&mut self.pending.indirect_callee_is_variadic);
        let callee_conv = core::mem::take(&mut self.pending.indirect_callee_conv);
        let callee_ret_fn_ptr = core::mem::take(&mut self.pending.indirect_callee_ret_fn_ptr);
        let callee_fixed = callee_params.as_ref().map_or(0, |p| p.len()) as u32;
        let mut arg_idx: usize = 0;
        while self.lex.tk != ')' {
            let temp_off = self.reserve_slots(1);
            self.emit_lea(temp_off);
            self.ast_psh();
            self.expr(Token::Assign as i64)?;
            if let Some(params) = &callee_params
                && arg_idx < params.len()
            {
                self.convert_assign_rhs(params[arg_idx]);
            }
            indirect_arg_ids.push(self.ast_acc);
            self.ast_assign();
            arg_idx += 1;
            self.accept(',')?;
        }
        self.next()?; // consume `)`
        self.flush_pending_stores();
        self.pending.last_emit_was_indirect_call = true;
        self.ast_acc = None;
        let _ = fp_temp;
        self.ty = indirect_ret_ty;
        // A callee returning a function pointer leaves one, so a following
        // unary `*` is the C99 6.3.2.1p4 no-op.
        if callee_ret_fn_ptr > 0 {
            self.pending.fn_ptr_chain_depth = callee_ret_fn_ptr - 1;
        }
        self.drop_operand_array_decay();
        self.ast_vstack.truncate(ast_vstack_snapshot);
        self.emit_indirect_call_ast(
            callee_ast,
            indirect_arg_ids,
            callee_is_variadic,
            callee_fixed,
            callee_conv,
        );
        Ok(())
    }

    fn emit_indirect_call_ast(
        &mut self,
        callee_ast: Option<super::super::ast::ExprId>,
        indirect_arg_ids: alloc::vec::Vec<Option<super::super::ast::ExprId>>,
        callee_is_variadic: bool,
        callee_fixed: u32,
        callee_conv: crate::c5::codegen::CallConv,
    ) {
        let return_ty = self.ty;
        if let Some(callee_id) = callee_ast {
            let pos = self.ast_src_pos();
            let mut resolved: alloc::vec::Vec<super::super::ast::ExprId> =
                alloc::vec::Vec::with_capacity(indirect_arg_ids.len());
            let mut all_some = true;
            for a in indirect_arg_ids {
                match a {
                    Some(id) => resolved.push(id),
                    None => {
                        all_some = false;
                        break;
                    }
                }
            }
            if all_some {
                // A variadic callee records its fixed count for the walker, whose
                // symbol (a member, element or dereferenced pointer) carries none.
                if callee_is_variadic {
                    self.ast
                        .variadic_indirect_callees
                        .push((callee_id, callee_fixed));
                }
                // A calling convention other than the target's is recorded on the
                // callee node; the declaration's scope is gone by the walk.
                if callee_conv != crate::c5::codegen::CallConv::Target {
                    self.ast
                        .conv_indirect_callees
                        .push((callee_id, callee_conv));
                }
                let id = self.ast.push_expr(
                    super::super::ast::Expr::Call {
                        callee: callee_id,
                        args: resolved,
                        ty: return_ty,
                    },
                    pos,
                );
                self.ast_acc = Some(id);
            } else {
                self.ast_acc = None;
            }
        } else {
            self.ast_acc = None;
        }
    }

    fn parse_assignment(&mut self, lhs_ty: i64) -> Result<(), C5Error> {
        self.next()?;
        // A parenthesized bitfield lvalue (`(s.f) = v`, C99 6.5.1p5) arrives
        // as the read node the member parser built, since the parentheses
        // hid the `=`; it becomes a bitfield store.
        let bf_lvalue = self
            .ast_acc
            .and_then(|id| match &self.ast.exprs[id as usize] {
                super::super::ast::Expr::Member {
                    obj,
                    field_off,
                    bitfield: Some(desc),
                    ..
                } => Some((*obj, *field_off, *desc)),
                _ => None,
            });
        let lhs_is_struct_value = is_struct_value_ty(lhs_ty);
        if let Some((obj, field_off, desc)) = bf_lvalue {
            self.expr(Token::Assign as i64)?;
            if let Some(rhs) = self.ast_acc {
                self.ty = Ty::Int as i64;
                let res_ty = self.ty;
                self.ast_emit_bitfield_assign(obj, field_off, desc, rhs, res_ty);
            }
        } else if lhs_is_struct_value {
            self.parse_struct_assignment(lhs_ty)?;
        } else if self.rewrite_trailing_load_as_psh().is_some() {
            // The trailing load becomes a push of the address. The dead-store
            // record follows the right operand's parse: `x = x + 1` reads the
            // prior value.
            let line = self.lex.line;
            let assigned_local = self.take_last_loaded_local();
            if let Some(idx) = assigned_local {
                self.symbols[idx].was_written = true;
            }
            self.expr(Token::Assign as i64)?;
            let rhs_is_zero = self.last_emit_is_zero();
            let rhs_is_untyped = self.last_emit_was_indirect_call();
            if let Some(m) = Self::type_warning_with_flags(
                &self.structs,
                lhs_ty,
                self.ty,
                rhs_is_zero,
                rhs_is_untyped,
            ) {
                let lhs_s = format_type(lhs_ty, &self.structs);
                let rhs_s = format_type(self.ty, &self.structs);
                let text = format!("{} in assignment (lhs={lhs_s}, rhs={rhs_s})", m.reason);
                if m.no_conversion {
                    return Err(self.compile_err_at(Code::INVALID_OPERANDS, line, text));
                }
                self.warn_at(m.code, line, text);
            }
            self.convert_assign_rhs(lhs_ty);
            self.ty = lhs_ty;
            self.ast_assign();
            if let Some(idx) = assigned_local {
                self.record_local_store(idx, line);
            }
        } else {
            return Err(self.compile_err(Code::INVALID_OPERANDS, "bad lvalue in assignment"));
        }
        Ok(())
    }

    fn parse_struct_assignment(&mut self, lhs_ty: i64) -> Result<(), C5Error> {
        // The walker emits the copy from the node and yields the
        // destination address. The lvalue is not pushed on the AST vstack:
        // a subexpression leaves the vstack as found, or an enclosing
        // assignment pops the stray entry as its own lvalue. Decided before
        // the scalar rewrite: `*p = s` on a struct pointer leaves the
        // pointer's load tag, which the scalar path would rewrite.
        let struct_lhs_ast = self.ast_acc.take();
        self.mark_emit_other();
        self.expr(Token::Assign as i64)?;
        let mut struct_rhs_ast = self.ast_acc;
        if !is_struct_ty(self.ty) || struct_ptr_depth(self.ty) != 0 {
            // A scalar assigned to a 128-bit integer is widened by a cast; any
            // other struct rejects a non-struct operand (C99 6.5.16.1p1).
            if self.is_int128_ty(lhs_ty) {
                if let Some(rhs) = struct_rhs_ast {
                    let pos = self.ast_src_pos();
                    struct_rhs_ast = Some(self.ast.push_expr(
                        super::super::ast::Expr::Cast {
                            child: rhs,
                            to_ty: lhs_ty,
                        },
                        pos,
                    ));
                }
                self.ty = lhs_ty;
            } else {
                return Err(self.compile_err(
                    Code::INVALID_OPERANDS,
                    "cannot assign non-struct value to a struct",
                ));
            }
        }
        // C99 6.5.16.1p1: compatible unqualified struct types; lvalue
        // conversion (6.3.2.1p2) dropped the qualifiers, and the 128-bit
        // integer's signedness bit converts by a bit copy (6.3.1.3).
        if super::types::strip_unsigned(lhs_ty) != super::types::strip_unsigned(self.ty) {
            let lhs_s = format_type(lhs_ty, &self.structs);
            let rhs_s = format_type(self.ty, &self.structs);
            return Err(self.compile_err(
                Code::INCOMPATIBLE_TYPES,
                format!(
                    "struct types differ on either side of `=` \
                 (lhs={lhs_s}, rhs={rhs_s})"
                ),
            ));
        }
        self.mark_emit_other();
        self.ty = lhs_ty;
        if let (Some(lhs), Some(rhs)) = (struct_lhs_ast, struct_rhs_ast) {
            let pos = self.ast_src_pos();
            let id = self.ast.push_expr(
                super::super::ast::Expr::Assign {
                    lhs,
                    rhs,
                    ty: lhs_ty,
                },
                pos,
            );
            self.ast_acc = Some(id);
        } else {
            self.ast_acc = None;
        }
        Ok(())
    }

    fn parse_compound_assignment(&mut self, lhs_ty: i64) -> Result<(), C5Error> {
        // The lexer left the operator's token in `lex.ival`.
        let binop = self.lex.ival;
        let compound_lhs_ast = self.ast_acc;
        // GCC vector extension: `v OP= w` is `v = v OP w` (C99 6.5.16.2p3),
        // with the side-effect-free lvalue as both store target and
        // operand.
        if is_vector_ty(&self.structs, lhs_ty) && is_vector_binop_token(binop) {
            return self.parse_vector_compound_assignment(lhs_ty, binop, compound_lhs_ast);
        }
        // The 128-bit integer's lvalue is an address with no scalar load
        // to rewrite; the walker evaluates it once (C99 6.5.16.2p3).
        if self.is_int128_ty(lhs_ty) {
            return self.parse_int128_compound_assignment(lhs_ty, binop, compound_lhs_ast);
        }
        // A parenthesized bitfield lvalue (`(s.f) OP= x`) arrives as the
        // read node the member parser built; C99 6.5.16.2: `s.f = s.f OP x`
        // with the field evaluated once.
        let bf_lvalue = compound_lhs_ast.and_then(|id| match self.ast.expr(id) {
            super::super::ast::Expr::Member {
                obj,
                field_off,
                bitfield: Some(desc),
                ty,
                ..
            } => Some((id, *obj, *field_off, *desc, *ty)),
            _ => None,
        });
        if let Some(bf) = bf_lvalue {
            return self.parse_bitfield_compound_assignment(binop, bf);
        }
        self.parse_scalar_compound_assignment(binop, compound_lhs_ast)
    }

    fn parse_vector_compound_assignment(
        &mut self,
        lhs_ty: i64,
        binop: i64,
        compound_lhs_ast: Option<super::super::ast::ExprId>,
    ) -> Result<(), C5Error> {
        let vec_ty = lhs_ty;
        let op_name = vector_binop_name(binop);
        let lhs_node = compound_lhs_ast.ok_or_else(|| {
            self.compile_err(Code::INVALID_OPERANDS, "bad lvalue in compound assignment")
        })?;
        let pos = self.ast_src_pos();
        self.next()?; // consume `OP=`
        self.expr(Token::Assign as i64)?; // parse the rhs
        let rhs_node = self.ast_acc.ok_or_else(|| {
            self.compile_err(Code::INVALID_OPERANDS, "bad operand in compound assignment")
        })?;
        if self.vector_binop_ty(vec_ty, self.ty, op_name) != Some(vec_ty) {
            return Err(self.compile_err(
                Code::INVALID_OPERANDS,
                format!("invalid operands to vector compound `{op_name}=`"),
            ));
        }
        // The nominal opcode; the walker picks the signed /
        // unsigned / floating flavour from the element type.
        let bop = vector_binop_op(binop);
        let bin = self.ast.push_expr(
            super::super::ast::Expr::Binary {
                op: bop,
                lhs: lhs_node,
                rhs: rhs_node,
                ty: vec_ty,
            },
            pos,
        );
        let asg = self.ast.push_expr(
            super::super::ast::Expr::Assign {
                lhs: lhs_node,
                rhs: bin,
                ty: vec_ty,
            },
            pos,
        );
        self.ast_acc = Some(asg);
        self.ty = vec_ty;
        Ok(())
    }

    fn parse_int128_compound_assignment(
        &mut self,
        lhs_ty: i64,
        binop: i64,
        compound_lhs_ast: Option<super::super::ast::ExprId>,
    ) -> Result<(), C5Error> {
        let lhs_node = compound_lhs_ast.ok_or_else(|| {
            self.compile_err(Code::INVALID_OPERANDS, "bad lvalue in compound assignment")
        })?;
        let pos = self.ast_src_pos();
        self.next()?;
        self.expr(Token::Assign as i64)?;
        let rhs_node = self.ast_acc.ok_or_else(|| {
            self.compile_err(Code::INVALID_OPERANDS, "bad rhs in compound assignment")
        })?;
        let bop = self.compound_assign_binop(binop, lhs_ty, self.ty, false)?;
        let node = self.ast.push_expr(
            super::super::ast::Expr::CompoundAssign {
                op: bop,
                lhs: lhs_node,
                rhs: rhs_node,
                ty: lhs_ty,
            },
            pos,
        );
        self.ast_acc = Some(node);
        self.ty = lhs_ty;
        Ok(())
    }

    fn parse_bitfield_compound_assignment(
        &mut self,
        binop: i64,
        (read, obj, field_off, desc, field_ty): (
            super::super::ast::ExprId,
            super::super::ast::ExprId,
            i64,
            super::super::ast::BitfieldDesc,
            i64,
        ),
    ) -> Result<(), C5Error> {
        let pos = self.ast_src_pos();
        self.next()?;
        self.expr(Token::Assign as i64)?;
        let rhs = self.ast_acc.ok_or_else(|| {
            self.compile_err(Code::INVALID_OPERANDS, "bad rhs in compound assignment")
        })?;
        let op = self.compound_assign_binop(binop, field_ty, self.ty, false)?;
        let combined = self.ast.push_expr(
            super::super::ast::Expr::Binary {
                op,
                lhs: read,
                rhs,
                ty: field_ty,
            },
            pos,
        );
        self.ast_emit_bitfield_assign(obj, field_off, desc, combined, field_ty);
        self.ty = field_ty;
        Ok(())
    }

    fn parse_scalar_compound_assignment(
        &mut self,
        binop: i64,
        compound_lhs_ast: Option<super::super::ast::ExprId>,
    ) -> Result<(), C5Error> {
        self.next()?;
        let lhs_fn_ptr = self.value_is_function_pointer();
        self.rewrite_trailing_load_as_psh().ok_or_else(|| {
            self.compile_err(Code::INVALID_OPERANDS, "bad lvalue in compound assignment")
        })?;
        // The operand is read and stored; the dead-store record follows
        // the operator so a self-referencing right operand does not cancel
        // the store.
        let line = self.lex.line;
        let assigned_local = self.take_last_loaded_local();
        if let Some(idx) = assigned_local {
            self.symbols[idx].was_read = true;
            self.symbols[idx].was_written = true;
            self.record_local_read(idx);
        }
        self.mark_emit_other();
        self.ast_psh();
        let lhs_ty = self.ty;
        self.expr(Token::Assign as i64)?;
        let pre_scale_rhs_ast = self.ast_acc;
        // Read before a conversion rewrites `self.ty`: an integer lvalue
        // with a floating operand computes in the floating type (C99
        // 6.5.16.2).
        let rhs_ty = self.ty;
        let rhs_is_fp = is_floating_scalar(rhs_ty);
        if (binop == Token::AddOp as i64 || binop == Token::SubOp as i64)
            && is_pointer_ty(lhs_ty)
            && !is_floating_scalar(lhs_ty)
        {
            let elem_ty = lhs_ty - Ty::Ptr as i64;
            let elem_size = self.size_of_type(elem_ty) as i64;
            if !lhs_fn_ptr && elem_size > 1 {
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, elem_size);
            }
        }
        // The scaled operand, so the walker re-emits the same `Mul` rather
        // than scaling again.
        let mut compound_rhs_ast = self.ast_acc.or(pre_scale_rhs_ast);
        let lhs_is_fp = is_floating_scalar(lhs_ty);
        // C99 6.5.16.2: `E1 OP= E2` computes in the type of `E1 OP E2`, so
        // an integer operand of a floating lvalue is converted first.
        if lhs_is_fp {
            self.require_both_float(lhs_ty, "compound assign")?;
            compound_rhs_ast = self.ast_acc.or(compound_rhs_ast);
        }
        // For an integer lvalue with a floating operand the walker converts
        // the lvalue, computes, and converts back.
        let op_is_fp = lhs_is_fp || rhs_is_fp;
        let bop = self.compound_assign_binop(binop, lhs_ty, rhs_ty, op_is_fp)?;
        self.ast_binop(bop);
        self.ty = lhs_ty;
        self.ast_assign();
        if let Some(idx) = assigned_local {
            self.record_local_store(idx, line);
        }
        if let (Some(lhs), Some(rhs)) = (compound_lhs_ast, compound_rhs_ast) {
            let ca_ty = self.ty;
            self.ast_emit_compound_assign(bop, lhs, rhs, ca_ty);
        }
        Ok(())
    }

    fn parse_conditional(&mut self) -> Result<(), C5Error> {
        let cond_ast = self.ast_acc;
        self.next()?; // consume `?`
        self.flush_pending_stores();
        // GNU `a ?: b`: the condition's own value is the result when
        // nonzero; the then-arm mirrors the condition for the conversions.
        let elvis = self.lex.tk == ':';
        let mut then_ast = cond_ast;
        if !elvis {
            self.expr(Token::Assign as i64)?;
            then_ast = self.ast_acc;
        }
        // C99 6.5.15: the middle operand is an expression, so a comma chain
        // is legal there; `expr(Assign)` stops at `,`.
        while self.lex.tk == ',' {
            self.next()?;
            let lhs_ast = then_ast;
            self.expr(Token::Assign as i64)?;
            let rhs_ast = self.ast_acc;
            if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                let pos = self.ast_src_pos();
                let ty = self.ty;
                let id = self
                    .ast
                    .push_expr(super::super::ast::Expr::Comma { lhs, rhs, ty }, pos);
                self.ast_acc = Some(id);
                then_ast = Some(id);
            } else {
                then_ast = self.ast_acc;
            }
        }
        let then_ty = self.ty;
        if self.lex.tk == ':' {
            self.next()?;
        } else {
            return Err(self.compile_err(Code::SYNTAX, "conditional missing colon"));
        }
        self.flush_pending_stores();
        self.expr(Token::Cond as i64)?;
        let mut else_ast = self.ast_acc;
        let else_ty = self.ty;
        let result_ty = self.conditional_result_ty(then_ty, else_ty, then_ast, else_ast);
        // Both arms convert to the result type, so the join stores one
        // width and signedness.
        if then_ty != result_ty && then_ast.is_some() {
            let pos = self.ast_src_pos();
            then_ast = Some(self.ast.push_expr(
                super::super::ast::Expr::Cast {
                    child: then_ast.unwrap(),
                    to_ty: result_ty,
                },
                pos,
            ));
        }
        if else_ty != result_ty && else_ast.is_some() {
            let pos = self.ast_src_pos();
            else_ast = Some(self.ast.push_expr(
                super::super::ast::Expr::Cast {
                    child: else_ast.unwrap(),
                    to_ty: result_ty,
                },
                pos,
            ));
        }
        if let (Some(cond), Some(then_e), Some(else_e)) = (cond_ast, then_ast, else_ast) {
            let pos = self.ast_src_pos();
            let id = self.ast.push_expr(
                super::super::ast::Expr::Ternary {
                    cond,
                    then_e,
                    else_e,
                    ty: result_ty,
                    elvis,
                },
                pos,
            );
            self.ast_acc = Some(id);
        }
        self.drop_operand_array_decay();
        self.ty = result_ty;
        Ok(())
    }

    fn conditional_result_ty(
        &self,
        then_ty: i64,
        else_ty: i64,
        then_ast: Option<super::super::ast::ExprId>,
        else_ast: Option<super::super::ast::ExprId>,
    ) -> i64 {
        let mut result_ty = else_ty;
        let arith = |t: i64| !is_pointer_ty(t) && !is_struct_ty(t);
        let arms_fp = is_floating_scalar(then_ty) || is_floating_scalar(else_ty);
        let then_ptr = is_pointer_ty(then_ty);
        let else_ptr = is_pointer_ty(else_ty);
        if (arms_fp || then_ty != else_ty) && arith(then_ty) && arith(else_ty) {
            result_ty = if arms_fp {
                fp_result_ty(then_ty, else_ty)
            } else {
                self.arith_common_ty(then_ty, else_ty)
            };
        } else if then_ptr || else_ptr {
            // C99 6.5.15p6: a null pointer constant arm takes the other arm's
            // type, else a `void *` arm yields `void *`. The null pointer test
            // is a value test: `(void*)0` qualifies, `(void*)(x * 0)` does not.
            let then_npc = then_ast.is_some_and(|e| self.expr_is_null_pointer_constant(e));
            let else_npc = else_ast.is_some_and(|e| self.expr_is_null_pointer_constant(e));
            let then_sp = is_struct_ty(then_ty) && struct_ptr_depth(then_ty) > 0;
            let else_sp = is_struct_ty(else_ty) && struct_ptr_depth(else_ty) > 0;
            // A `void *` result carries both arms' qualifiers (only `volatile`
            // is modelled on tags).
            result_ty = if then_ptr && else_ptr && then_npc && !else_npc {
                else_ty
            } else if then_ptr && else_ptr && else_npc && !then_npc {
                then_ty
            } else if then_ptr && else_ptr && is_void_ptr_ty(then_ty) {
                then_ty | (else_ty & VOLATILE_BIT)
            } else if then_ptr && else_ptr && is_void_ptr_ty(else_ty) {
                else_ty | (then_ty & VOLATILE_BIT)
            } else if then_sp && !else_sp {
                then_ty
            } else if else_sp && !then_sp {
                else_ty
            } else if then_ptr && !else_ptr {
                then_ty
            } else {
                else_ty
            };
        }
        result_ty
    }

    fn parse_binary(&mut self, lhs_ty: i64, op: &BinaryOp) -> Result<(), C5Error> {
        match op.kind {
            BinaryKind::ShortCircuit(sc) => self.parse_short_circuit(lhs_ty, op, sc),
            BinaryKind::Bitwise(bop) => self.parse_bitwise(lhs_ty, op, bop),
            BinaryKind::Equality { int, fp } => self.parse_equality(lhs_ty, op, int, fp),
            BinaryKind::Relational {
                signed,
                unsigned,
                fp,
            } => self.parse_relational(lhs_ty, op, signed, unsigned, fp),
            BinaryKind::Shift { signed, unsigned } => {
                self.parse_shift(lhs_ty, op, signed, unsigned)
            }
            BinaryKind::Additive { int, fp } => self.parse_additive(lhs_ty, op, int, fp),
            BinaryKind::Multiplicative {
                signed,
                unsigned,
                fp,
            } => self.parse_multiplicative(lhs_ty, op, signed, unsigned, fp),
        }
    }

    /// C99 6.5.13 / 6.5.14: `&&` and `||`. Either operand may be
    /// evaluated only after the other, so the pending stores are
    /// flushed at the sequence point.
    fn parse_short_circuit(
        &mut self,
        lhs_ty: i64,
        op: &BinaryOp,
        sc: super::super::ast::ShortCircuitOp,
    ) -> Result<(), C5Error> {
        let lhs_ast = self.ast_acc;
        self.next()?;
        self.flush_pending_stores();
        self.expr(op.rhs_lev as i64)?;
        self.reject_aggregate_binop(lhs_ty, self.ty, op.name)?;
        let rhs_ast = self.ast_acc;
        self.ty = Ty::Int as i64;
        if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
            self.ast_emit_short_circuit(sc, lhs, rhs, Ty::Int as i64);
        }
        Ok(())
    }

    /// C99 6.5.10-6.5.12: `&`, `^`, `|`. The result has the common type
    /// of the usual arithmetic conversions; forcing `int` would drop the
    /// upper half of a 64-bit operand when a following operator narrows.
    /// The result type is set before the node is built because the
    /// walker reads the node type as the cast source type.
    fn parse_bitwise(
        &mut self,
        lhs_ty: i64,
        op: &BinaryOp,
        bop: super::super::ir::BinOp,
    ) -> Result<(), C5Error> {
        self.next()?;
        self.ast_psh();
        self.expr(op.rhs_lev as i64)?;
        self.reject_aggregate_binop(lhs_ty, self.ty, op.name)?;
        self.ty = match self.vector_binop_ty(lhs_ty, self.ty, op.name) {
            Some(vty) => vty,
            None => self.arith_common_ty(lhs_ty, self.ty),
        };
        self.ast_binop(bop);
        Ok(())
    }

    /// C99 6.5.9: `==` and `!=`.
    fn parse_equality(
        &mut self,
        lhs_ty: i64,
        op: &BinaryOp,
        int: super::super::ir::BinOp,
        fp: super::super::ir::BinOp,
    ) -> Result<(), C5Error> {
        let invert = op.tok == Token::NeOp;
        self.next()?;
        self.ast_psh();
        self.expr(op.rhs_lev as i64)?;
        self.reject_aggregate_binop(lhs_ty, self.ty, op.name)?;
        if let Some(vty) = self.vector_compare_ty(lhs_ty, self.ty) {
            let vop = self.vector_compare_op(lhs_ty, self.ty, int, int, fp);
            self.ty = vty;
            self.ast_binop(vop);
        } else if is_floating_scalar(lhs_ty) || is_floating_scalar(self.ty) {
            self.require_both_float(lhs_ty, op.name)?;
            self.ast_binop(fp);
            self.ty = Ty::Int as i64;
        } else {
            self.emit_eq_with_common_width(lhs_ty, invert);
            self.ty = Ty::Int as i64;
        }
        Ok(())
    }

    /// C99 6.5.8: the relational operators. Addresses order by unsigned
    /// magnitude: the common-type rule does not apply to pointers, and a
    /// signed compare misorders any address with bit 63 set.
    fn parse_relational(
        &mut self,
        lhs_ty: i64,
        op: &BinaryOp,
        signed: super::super::ir::BinOp,
        unsigned: super::super::ir::BinOp,
        fp: super::super::ir::BinOp,
    ) -> Result<(), C5Error> {
        self.next()?;
        self.ast_psh();
        self.expr(op.rhs_lev as i64)?;
        self.reject_aggregate_binop(lhs_ty, self.ty, op.name)?;
        if let Some(vty) = self.vector_compare_ty(lhs_ty, self.ty) {
            let vop = self.vector_compare_op(lhs_ty, self.ty, signed, unsigned, fp);
            self.ty = vty;
            self.ast_binop(vop);
            return Ok(());
        }
        if is_floating_scalar(lhs_ty) || is_floating_scalar(self.ty) {
            self.require_both_float(lhs_ty, op.name)?;
            self.ast_binop(fp);
        } else if is_pointer_ty(lhs_ty)
            || is_pointer_ty(self.ty)
            || is_unsigned_ty(self.arith_common_ty(lhs_ty, self.ty))
        {
            self.ast_binop(unsigned);
        } else {
            self.ast_binop(signed);
        }
        self.ty = Ty::Int as i64;
        Ok(())
    }

    /// C99 6.5.7: `E1 << E2` and `E1 >> E2` have the type of `E1` after
    /// integer promotion; the shift count does not participate. The
    /// result type is set before the node is built so a later cast reads
    /// the right signedness. A left shift can carry bits past a 32-bit
    /// result's width, so that result is renormalized as the arithmetic
    /// operators do.
    fn parse_shift(
        &mut self,
        lhs_ty: i64,
        op: &BinaryOp,
        signed: super::super::ir::BinOp,
        unsigned: super::super::ir::BinOp,
    ) -> Result<(), C5Error> {
        self.next()?;
        self.ast_psh();
        self.expr(op.rhs_lev as i64)?;
        self.reject_aggregate_binop(lhs_ty, self.ty, op.name)?;
        if let Some(vty) = self.vector_binop_ty(lhs_ty, self.ty, op.name) {
            self.ty = vty;
            self.ast_binop(signed);
            return Ok(());
        }
        let result_ty = if self.size_of_type(lhs_ty) <= 2 {
            Ty::Int as i64
        } else {
            lhs_ty
        };
        self.ty = result_ty;
        self.ast_binop(if is_unsigned_ty(lhs_ty) {
            unsigned
        } else {
            signed
        });
        if op.tok == Token::ShlOp && self.size_of_type(result_ty) == 4 {
            self.renormalize_to_width(result_ty);
            self.ty = result_ty;
        }
        Ok(())
    }

    /// C99 6.5.6: `+` and `-`. The left operand's pointer-to-array stride
    /// and function-pointer lineage are read before the right operand's
    /// parse overwrites them; a stride wider than the pointee carries into
    /// the next arithmetic step so `p + i - j` keeps the array element
    /// size.
    fn parse_additive(
        &mut self,
        lhs_ty: i64,
        op: &BinaryOp,
        int: super::super::ir::BinOp,
        fp: super::super::ir::BinOp,
    ) -> Result<(), C5Error> {
        self.next()?;
        let lhs_stride = self.pending.index_stride;
        let lhs_fn_ptr = self.value_is_function_pointer();
        self.ast_psh();
        self.expr(op.rhs_lev as i64)?;
        let fn_ptr_arith = lhs_fn_ptr || self.value_is_function_pointer();
        self.reject_aggregate_binop(lhs_ty, self.ty, op.name)?;
        if let Some(vty) = self.vector_binop_ty(lhs_ty, self.ty, op.name) {
            self.ty = vty;
            self.ast_binop(int);
            return Ok(());
        }
        if is_floating_scalar(lhs_ty) || is_floating_scalar(self.ty) {
            self.require_both_float(lhs_ty, op.name)?;
            self.ast_binop(fp);
            self.ty = fp_result_ty(lhs_ty, self.ty);
            return Ok(());
        }
        let carry_stride = if op.tok == Token::AddOp {
            self.add_values(lhs_ty, lhs_stride, fn_ptr_arith)
        } else {
            self.sub_values(lhs_ty, lhs_stride, fn_ptr_arith)
        };
        if carry_stride > 1 {
            self.pending.index_stride = carry_stride;
        }
        Ok(())
    }

    /// Integer and pointer addition (C99 6.5.6p8). Returns the stride to
    /// carry into the next arithmetic step.
    fn add_values(&mut self, lhs_ty: i64, lhs_stride: i64, fn_ptr_arith: bool) -> i64 {
        let mut carry_stride: i64 = 0;
        if !is_pointer_ty(lhs_ty) && is_pointer_ty(self.ty) {
            // `int + ptr` has the pointer type. A pointee wider than a byte
            // scales the integer, which sits on the c5 stack: the pointer is
            // spilled, the integer scaled and pushed, and the pointer reloaded.
            let rhs_ty = self.ty;
            if !fn_ptr_arith && self.is_ptr_scaling_nontrivial(rhs_ty) {
                // The scaling sequence's intermediate stores consume AST vstack
                // slots: the operands are taken off first, the sequence runs against
                // a sentinel, and the node is rebuilt.
                let lhs_ast = self.ast_vstack.pop().flatten();
                let rhs_ast = self.ast_acc.take();
                let saved_vstack = core::mem::take(&mut self.ast_vstack);
                self.ast_vstack.push(None);
                // A pointer-to-array operand left its array stride in the
                // end-of-expression snapshot.
                let scale = self.pointer_to_array_arith_stride(
                    self.pending.end_of_expr_stride,
                    rhs_ty,
                    self.pointee_size(rhs_ty),
                );
                if scale > self.pointee_size(rhs_ty) {
                    carry_stride = scale;
                }
                let rhs_temp = self.reserve_slots(1);
                self.mark_emit_other();
                self.emit_imm(0);
                self.ast_binop(crate::c5::ir::BinOp::Or);
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, scale);
                self.ast_psh();
                self.emit_lea(rhs_temp);
                self.mark_emit_other();
                self.ast_binop(crate::c5::ir::BinOp::Add);
                self.ast_vstack.clear();
                self.ast_vstack.extend(saved_vstack);
                // C99 6.5.6p8: the result has the pointer type.
                self.ty = rhs_ty;
                if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                    let pos = self.ast_src_pos();
                    let scale_lit = self.ast.push_expr(
                        super::super::ast::Expr::IntLit {
                            val: scale,
                            ty: super::super::token::Ty::Int as i64,
                        },
                        pos,
                    );
                    let scaled = self.ast.push_expr(
                        super::super::ast::Expr::Binary {
                            op: super::super::ir::BinOp::Mul,
                            lhs,
                            rhs: scale_lit,
                            ty: lhs_ty,
                        },
                        pos,
                    );
                    let added = self.ast.push_expr(
                        super::super::ast::Expr::Binary {
                            op: super::super::ir::BinOp::Add,
                            lhs: scaled,
                            rhs,
                            ty: rhs_ty,
                        },
                        pos,
                    );
                    self.ast_acc = Some(added);
                } else {
                    self.ast_acc = None;
                }
            } else {
                self.ast_binop(crate::c5::ir::BinOp::Add);
                self.ty = rhs_ty;
            }
        } else {
            let rhs_ty = self.ty;
            if !fn_ptr_arith && self.is_ptr_scaling_nontrivial(lhs_ty) {
                let scale = self.pointer_to_array_arith_stride(
                    lhs_stride,
                    lhs_ty,
                    self.pointee_size(lhs_ty),
                );
                if scale > self.pointee_size(lhs_ty) {
                    carry_stride = scale;
                }
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, scale);
            }
            // The result type is set before the node is built, so the node
            // carries the C99 6.3.1.8 common type.
            if is_pointer_ty(lhs_ty) {
                self.ty = lhs_ty;
            } else {
                self.ty = self.arith_common_ty(lhs_ty, rhs_ty);
            }
            self.ast_binop(crate::c5::ir::BinOp::Add);
            if !is_pointer_ty(lhs_ty) {
                self.maybe_mask_to_unsigned_width(lhs_ty, rhs_ty);
            }
        }
        carry_stride
    }

    /// Integer and pointer subtraction (C99 6.5.6p8-p9). Returns the stride
    /// to carry into the next arithmetic step.
    fn sub_values(&mut self, lhs_ty: i64, lhs_stride: i64, fn_ptr_arith: bool) -> i64 {
        let mut carry_stride: i64 = 0;
        if is_pointer_ty(lhs_ty) && self.ptr_diff_compatible(lhs_ty, self.ty) {
            // C99 6.5.6p9: `ptr - ptr` is the element distance, the byte
            // distance divided by the pointee size both operands share. The
            // type is set before the node is built.
            self.ty = Ty::Int as i64;
            self.ast_binop(crate::c5::ir::BinOp::Sub);
            if !fn_ptr_arith && self.is_ptr_scaling_nontrivial(lhs_ty) {
                let scale = self.pointer_to_array_arith_stride(
                    lhs_stride,
                    lhs_ty,
                    self.pointee_size(lhs_ty),
                );
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Div, scale);
            }
        } else if !fn_ptr_arith && self.is_ptr_scaling_nontrivial(lhs_ty) {
            let scale =
                self.pointer_to_array_arith_stride(lhs_stride, lhs_ty, self.pointee_size(lhs_ty));
            if scale > self.pointee_size(lhs_ty) {
                carry_stride = scale;
            }
            self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, scale);
            // C99 6.5.6p8: the result has the pointer type, set before the node
            // is built.
            self.ty = lhs_ty;
            self.ast_binop(crate::c5::ir::BinOp::Sub);
        } else {
            let rhs_ty = self.ty;
            // The result type is set before the node is built, so the node
            // carries the C99 6.3.1.8 common type.
            if is_pointer_ty(lhs_ty) {
                self.ty = lhs_ty;
            } else {
                self.ty = self.arith_common_ty(lhs_ty, rhs_ty);
            }
            self.ast_binop(crate::c5::ir::BinOp::Sub);
            if !is_pointer_ty(lhs_ty) {
                self.maybe_mask_to_unsigned_width(lhs_ty, rhs_ty);
            }
        }
        carry_stride
    }

    /// C99 6.5.5: `*`, `/`, `%`. An operator with no floating form
    /// rejects a floating operand; the left one before the right operand
    /// is parsed, as the source order reads. Division follows the
    /// 6.3.1.8 common type's signedness, masking the operands to that
    /// width first so a sign-extended `-1` enters an unsigned divide as
    /// the narrow value.
    fn parse_multiplicative(
        &mut self,
        lhs_ty: i64,
        op: &BinaryOp,
        signed: super::super::ir::BinOp,
        unsigned: Option<super::super::ir::BinOp>,
        fp: Option<super::super::ir::BinOp>,
    ) -> Result<(), C5Error> {
        self.next()?;
        if fp.is_none() && is_floating_scalar(lhs_ty) {
            return Err(self.compile_err(
                Code::INVALID_OPERANDS,
                format!("`{}` is not defined on floating-point operands", op.name),
            ));
        }
        self.ast_psh();
        self.expr(op.rhs_lev as i64)?;
        self.reject_aggregate_binop(lhs_ty, self.ty, op.name)?;
        if let Some(vty) = self.vector_binop_ty(lhs_ty, self.ty, op.name) {
            self.ty = vty;
            self.ast_binop(signed);
            return Ok(());
        }
        if is_floating_scalar(lhs_ty) || is_floating_scalar(self.ty) {
            let Some(fp) = fp else {
                return Err(self.compile_err(
                    Code::INVALID_OPERANDS,
                    format!("`{}` is not defined on floating-point operands", op.name),
                ));
            };
            self.require_both_float(lhs_ty, op.name)?;
            self.ast_binop(fp);
            self.ty = fp_result_ty(lhs_ty, self.ty);
            return Ok(());
        }
        let rhs_ty = self.ty;
        let common = self.arith_common_ty(lhs_ty, rhs_ty);
        let Some(unsigned) = unsigned else {
            self.ty = common;
            self.ast_binop(signed);
            self.maybe_mask_to_unsigned_width(lhs_ty, rhs_ty);
            return Ok(());
        };
        if is_unsigned_ty(common) {
            self.emit_unsigned_division(lhs_ty, rhs_ty, unsigned, common);
        } else {
            self.ty = common;
            self.ast_binop(signed);
        }
        self.ty = common;
        Ok(())
    }

    /// An unsigned divide or remainder. The operand masking routes
    /// intermediate emits through the AST tracker, which would consume
    /// the outer expression's operands: the operands are taken off the
    /// tracker first, the sequence runs against a sentinel, and the node
    /// is rebuilt from the taken operands.
    fn emit_unsigned_division(
        &mut self,
        lhs_ty: i64,
        rhs_ty: i64,
        op: super::super::ir::BinOp,
        common: i64,
    ) {
        let lhs_ast = self.ast_vstack.pop().flatten();
        let rhs_ast = self.ast_acc.take();
        let saved_vstack = core::mem::take(&mut self.ast_vstack);
        self.ast_vstack.push(None);
        self.maybe_mask_operands_to_unsigned_common(lhs_ty, rhs_ty);
        self.ast_binop(op);
        self.ast_vstack.clear();
        self.ast_vstack.extend(saved_vstack);
        if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
            let pos = self.ast_src_pos();
            let id = self.ast.push_expr(
                super::super::ast::Expr::Binary {
                    op,
                    lhs,
                    rhs,
                    ty: common,
                },
                pos,
            );
            self.ast_acc = Some(id);
        } else {
            self.ast_acc = None;
        }
    }

    /// C99 6.5.2.4: postfix `++` / `--`. The value is the operand before
    /// the update: the updated value is stored, then stepped back on the
    /// accumulator. The operand was parsed in this scope, so a
    /// pointer-to-array stride sits in the current stride slot.
    fn parse_postfix_inc_dec(&mut self) -> Result<(), C5Error> {
        let is_inc = self.lex.tk == Token::Inc;
        if let Some((lvalue, ty)) = self.direct_inc_lvalue() {
            return self.emit_direct_inc_dec(lvalue, ty, is_inc, true);
        }
        let (lvalue, fn_ptr_step) = self.inc_dec_lvalue("post-increment")?;
        self.emit_imm(if fn_ptr_step {
            1
        } else {
            self.pointee_step(self.ty)
        });
        self.ast_binop(if is_inc {
            super::super::ir::BinOp::Add
        } else {
            super::super::ir::BinOp::Sub
        });
        self.ast_assign();
        self.ast_psh();
        let step = if fn_ptr_step {
            1
        } else {
            self.pointer_to_array_arith_stride(
                self.pending.index_stride,
                self.ty,
                self.pointee_step(self.ty),
            )
        };
        self.emit_imm(step);
        self.ast_binop(if is_inc {
            super::super::ir::BinOp::Sub
        } else {
            super::super::ir::BinOp::Add
        });
        let ty = self.ty;
        if let Some(lvalue) = lvalue {
            self.ast_emit_post_inc(lvalue, if is_inc { step } else { -step }, ty);
        }
        self.next()
    }

    fn parse_subscript(
        &mut self,
        lhs_ty: i64,
        row_member: Option<super::ArrayMember>,
    ) -> Result<(), C5Error> {
        let mut lhs_ty = lhs_ty;
        self.next()?;
        self.pending.last_array_decay_dims.clear();
        // GCC vector extension: `v[i]` is lane `i`, an element-typed
        // lvalue; the vector's address is its value, as for an array.
        if is_vector_ty(&self.structs, lhs_ty) {
            let elem_ty = self.structs[struct_id_of(lhs_ty)].fields[0].ty;
            lhs_ty = elem_ty + Ty::Ptr as i64;
            self.ty = lhs_ty;
        }
        let array_ast = self.ast_acc;
        let SubscriptIndex {
            idx_ast,
            multi_dim_stride,
            fn_ptr_chain_depth: saved_fn_ptr_chain,
        } = self.parse_subscript_index()?;
        if self.lex.tk == ']' {
            self.next()?;
        } else {
            return Err(self.compile_err(Code::SYNTAX, "close bracket expected"));
        }
        if !is_pointer_ty(lhs_ty) {
            return Err(self.compile_err(Code::INVALID_OPERANDS, "pointer type expected"));
        }
        if let Some(id) = self.ptr_array_id_depth1(lhs_ty) {
            // `p[i]` on a single-level pointer to an array selects row `i` and
            // decays to the element pointer with no load (C99 6.3.2.1p3).
            let row = self.structs[id].size as i64;
            if row > 1 {
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, row);
            }
            self.ast_binop(crate::c5::ir::BinOp::Add);
            self.decay_ptr_array_value(id);
        } else if multi_dim_stride > 0 {
            self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, multi_dim_stride);
            self.ast_binop(crate::c5::ir::BinOp::Add);
            // A row of a multi-dimensional array keeps the pointer level; the
            // innermost subscript decays to the element.
            self.ty = lhs_ty;
            // The row's byte count reaches an enclosing `sizeof`; a row may
            // itself be multi-dimensional, which the flat type cannot express.
            self.pending.last_array_decay_bytes = multi_dim_stride;
            // A row of an array member is unbounded when the member is.
            self.pending.last_array_decay_member = row_member.map(|m| super::ArrayMember {
                decl_remaining: None,
                unbounded: m.unbounded,
            });
        } else {
            if self.is_ptr_scaling_nontrivial(lhs_ty) {
                let scale = self.pointee_size(lhs_ty);
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, scale);
            }
            // The scaled index, so the walker adds without re-deriving the
            // pointee size.
            let idx_ast_scaled = if self.is_ptr_scaling_nontrivial(lhs_ty) {
                self.ast_acc.or(idx_ast)
            } else {
                idx_ast
            };
            self.ast_binop(crate::c5::ir::BinOp::Add);
            self.ty = lhs_ty - Ty::Ptr as i64;
            // A struct element is its address: no load.
            let elem_is_struct_value = is_struct_value_ty(self.ty);
            if !elem_is_struct_value {
                self.mark_emit_scalar_load();
                // A subscript consumes an array level, not an indirection level,
                // so the decay depth parked before the index parse still holds
                // (`(*fparr[i])()`).
                if saved_fn_ptr_chain >= 0 {
                    self.pending.fn_ptr_chain_depth = saved_fn_ptr_chain;
                }
            }
            if let (Some(array), Some(idx)) = (array_ast, idx_ast_scaled) {
                let idx_ty = self.ty;
                self.ast_emit_index(array, idx, idx_ty);
            }
        }
        Ok(())
    }

    fn parse_subscript_index(&mut self) -> Result<SubscriptIndex, C5Error> {
        // The stride queue the operand seeded is parked across the index
        // parse, which clears the pending state at its exit, and shifted
        // one level afterwards.
        let multi_dim_stride = self.pending.index_stride;
        let saved_tail = core::mem::take(&mut self.pending.index_strides_tail);
        self.pending.index_stride = 0;
        // The element keeps the callee prototype and decay depth the array
        // decay left; the index expression must neither consume nor clear
        // them.
        let saved_callee_params = self.pending.indirect_callee_params.take();
        let saved_callee_variadic = core::mem::take(&mut self.pending.indirect_callee_is_variadic);
        let saved_callee_conv = core::mem::take(&mut self.pending.indirect_callee_conv);
        let saved_callee_depth = core::mem::take(&mut self.pending.indirect_callee_fn_ptr_depth);
        let saved_callee_ret = core::mem::take(&mut self.pending.indirect_callee_ret_fn_ptr);
        let saved_fn_ptr_chain = self.pending.fn_ptr_chain_depth;
        self.ast_psh();
        self.expr(Token::Assign as i64)?;
        let idx_ast = self.ast_acc;
        self.pending.indirect_callee_params = saved_callee_params;
        self.pending.indirect_callee_is_variadic = saved_callee_variadic;
        self.pending.indirect_callee_conv = saved_callee_conv;
        self.pending.indirect_callee_fn_ptr_depth = saved_callee_depth;
        self.pending.indirect_callee_ret_fn_ptr = saved_callee_ret;
        self.pending.fn_ptr_chain_depth = saved_fn_ptr_chain;
        self.pending.index_strides_tail = saved_tail;
        self.pending.index_stride = if self.pending.index_strides_tail.is_empty() {
            0
        } else {
            self.pending.index_strides_tail.remove(0)
        };
        Ok(SubscriptIndex {
            idx_ast,
            multi_dim_stride,
            fn_ptr_chain_depth: saved_fn_ptr_chain,
        })
    }

    fn parse_member_access(
        &mut self,
        lhs_ty: i64,
        member_base: Option<super::MemberBase>,
    ) -> Result<(), C5Error> {
        // `->` runs on a struct pointer the operand loaded; `.` on a struct
        // value, whose address is already the value.
        let obj_ast = self.ast_acc;
        let is_dot = self.lex.tk == Token::Dot;
        let valid = if is_dot {
            is_struct_value_ty(lhs_ty)
        } else {
            is_struct_ty(lhs_ty) && struct_ptr_depth(lhs_ty) == 1
        };
        if !valid {
            let want = if is_dot {
                "struct value"
            } else {
                "single-level struct pointer"
            };
            let op = if is_dot { "." } else { "->" };
            return Err(self.compile_err(Code::INVALID_OPERANDS, format!("{op} requires a {want}")));
        }
        self.next()?;
        if self.lex.tk != Token::Id {
            let op = if is_dot { "." } else { "->" };
            return Err(self.compile_err(Code::SYNTAX, format!("field name expected after {op}")));
        }
        let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
        self.next()?;

        let sid = struct_id_of(lhs_ty);
        let field_idx = self.structs[sid]
            .fields
            .iter()
            .position(|f| f.name == field_name)
            .ok_or_else(|| {
                self.compile_err(
                    Code::UNDECLARED_IDENTIFIER,
                    format!(
                        "struct {} has no field {}",
                        self.structs[sid].name, field_name
                    ),
                )
            })?;
        let field = self.structs[sid].fields[field_idx].clone();
        let base = if is_dot { member_base } else { None };
        let base = base.unwrap_or(super::MemberBase::UNKNOWN);
        let (records, at_end) = self.member_nesting(sid, field_idx);
        let step = super::MemberBase {
            decl_size: base.decl_size,
            offset: base.offset + field.offset as i64,
            records: base.records + records,
            at_end: base.at_end && at_end,
        };

        // A function-pointer member carries its prototype for a following
        // call (C99 6.5.2.2p7); any other member clears the channel.
        let field_is_fn_ptr = field.fn_ptr_indirection > 0 || !field.params.is_empty();
        self.pending.indirect_callee_params = if field_is_fn_ptr {
            Some(field.params.clone())
        } else {
            None
        };
        self.pending.indirect_callee_is_variadic = field_is_fn_ptr && field.is_variadic;
        self.pending.indirect_callee_conv = if field_is_fn_ptr {
            field.conv
        } else {
            crate::c5::codegen::CallConv::Target
        };
        self.pending.indirect_callee_fn_ptr_depth = if field_is_fn_ptr {
            field.fn_ptr_indirection
        } else {
            0
        };
        self.pending.indirect_callee_ret_fn_ptr = if field_is_fn_ptr {
            field.fn_ptr_ret_indirection
        } else {
            0
        };

        if field.offset > 0 {
            self.emit_binop_with_imm(crate::c5::ir::BinOp::Add, field.offset as i64);
        }
        // A named address space is a property of the object, so a member
        // of a segment-qualified struct is reached through the same segment.
        let obj_seg_bits = object_segment_bits(if is_dot {
            lhs_ty
        } else {
            lhs_ty - Ty::Ptr as i64
        });
        let field_ty = if obj_seg_bits != 0 {
            if segment_of_ty(field.ty).is_some() {
                return Err(self.compile_err(
                    Code::INVALID_DECLARATION,
                    "segment-qualified member of a segment-qualified object",
                ));
            }
            apply_qual_bits(field.ty, obj_seg_bits)
        } else {
            field.ty
        };
        self.ty = field_ty;

        if field.bit_width > 0 {
            self.parse_bitfield_member(obj_ast, &field, field_ty)?;
        } else {
            self.member_value(&field, step);
        }
        if field.bit_width == 0
            && let Some(obj) = obj_ast
        {
            let mty = self.ty;
            self.ast_emit_member(obj, field.offset as i64, None, mty, field.array_size);
        }
        Ok(())
    }

    fn parse_bitfield_member(
        &mut self,
        obj_ast: Option<super::super::ast::ExprId>,
        field: &super::StructField,
        field_ty: i64,
    ) -> Result<(), C5Error> {
        // The token after the member decides between a store, which
        // preserves the other bits of the storage unit, and an extraction.
        let is_bf_assign = self.lex.tk == Token::Assign;
        let is_bf_compound = self.lex.tk == Token::AssignOp;
        let is_bf_incdec = self.lex.tk == Token::Inc || self.lex.tk == Token::Dec;
        let bf_desc = super::super::ast::BitfieldDesc {
            bit_offset: field.bit_offset as u8,
            bit_width: field.bit_width as u8,
            unit_size: field.bit_unit_size,
            // C99 6.2.5p2: a `_Bool` bitfield is unsigned even at width 1.
            signed: !is_unsigned_ty(field.ty) && !is_bool_ty(field.ty),
            ty: field_ty,
        };
        let bf_field_off = field.offset as i64;
        // The node carries the access type the integer promotions may
        // narrow (C99 6.3.1.1p2).
        let bf_field_ty = super::emit::bitfield_value_ty(field.bit_width, field_ty);
        self.pending.bf_assign_rhs = None;
        self.pending.bf_compound_assign = None;
        // `emit_bitfield_access` runs the c5 stack through stores the AST
        // tracker reads as assignments; its vstack pushes are dropped and
        // the one node this access needs is built below.
        let bf_vstack_depth = self.ast_vstack.len();
        self.emit_bitfield_access(field.bit_offset, field.bit_width, field_ty)?;
        if self.ast_vstack.len() > bf_vstack_depth {
            self.ast_vstack.truncate(bf_vstack_depth);
        }
        self.ast_acc = None;
        if let Some(obj) = obj_ast {
            if is_bf_assign {
                // The stored value was parsed inside `emit_bitfield_access` and
                // kept in `pending.bf_assign_rhs`.
                if let Some(rhs) = self.pending.bf_assign_rhs.take() {
                    let res_ty = self.ty;
                    self.ast_emit_bitfield_assign(obj, bf_field_off, bf_desc, rhs, res_ty);
                }
            } else if is_bf_compound {
                // C99 6.5.16.2: `E1 OP= E2` is `E1 = E1 OP E2` with `E1` evaluated
                // once.
                if let Some((rhs, ir_op)) = self.pending.bf_compound_assign.take() {
                    let src = self.ast_src_pos();
                    let read = self.ast.push_expr(
                        super::super::ast::Expr::Member {
                            obj,
                            field_off: bf_field_off,
                            bitfield: Some(bf_desc),
                            ty: bf_field_ty,
                            array_size: 0,
                        },
                        src,
                    );
                    let combined = self.ast.push_expr(
                        super::super::ast::Expr::Binary {
                            op: ir_op,
                            lhs: read,
                            rhs,
                            ty: bf_field_ty,
                        },
                        src,
                    );
                    let res_ty = self.ty;
                    self.ast_emit_bitfield_assign(obj, bf_field_off, bf_desc, combined, res_ty);
                }
            } else if is_bf_incdec {
                // Postfix `++` / `--` on the member: the access ran in read mode
                // and left the token.
                let by = if self.lex.tk == Token::Inc { 1 } else { -1 };
                self.next()?;
                let src = self.ast_src_pos();
                let lvalue = self.ast.push_expr(
                    super::super::ast::Expr::Member {
                        obj,
                        field_off: bf_field_off,
                        bitfield: Some(bf_desc),
                        ty: bf_field_ty,
                        array_size: 0,
                    },
                    src,
                );
                let id = self.ast.push_expr(
                    super::super::ast::Expr::PostInc {
                        lvalue,
                        by,
                        ty: bf_field_ty,
                    },
                    src,
                );
                self.ast_acc = Some(id);
            } else {
                self.ast_emit_member(obj, bf_field_off, Some(bf_desc), bf_field_ty, 0);
            }
        }
        Ok(())
    }

    fn member_value(&mut self, field: &super::StructField, step: super::MemberBase) {
        // A scalar member is loaded, the load left for an assignment to
        // rewrite; a struct member's address propagates so `s.inner.field`
        // chains; an array member decays as an array object does.
        let field_is_struct_value = is_struct_value_ty(self.ty);
        if field.array_size != 0 {
            self.ty += Ty::Ptr as i64;
            if field.array_size > 0 {
                // The element count reaches an enclosing `sizeof`.
                self.pending.last_array_decay_size = field.array_size;
                let dims = field.array_dims.clone();
                let elem_size = self.size_of_type(field.ty) as i64;
                // The dimension list lets `typeof(s.xs)` rebuild the array type.
                self.pending.last_array_decay_dims = dims.clone();
                self.seed_multi_dim_strides(&dims, elem_size);
            } else {
                // A flexible array member (C99 6.7.2.1p16) is an incomplete array,
                // signalled to `typeof` / `__builtin_types_compatible_p` with the
                // `-1` sentinel as for a zero-length array object.
                self.pending.last_array_decay_size = -1;
                // A multi-dimensional flexible member records a 0 placeholder for
                // its outer dimension; the strides read only the inner ones.
                let dims = field.array_dims.clone();
                let elem_size = self.size_of_type(field.ty) as i64;
                self.seed_multi_dim_strides(&dims, elem_size);
            }
            self.pending.last_array_decay_member = Some(super::ArrayMember {
                decl_remaining: step.decl_size.map(|size| size - step.offset),
                unbounded: step.decl_size.is_none()
                    && self.member_is_unbounded(field, step.records, step.at_end),
            });
        } else if !field_is_struct_value {
            self.mark_emit_scalar_load();
            // A function-pointer member's lineage lets a following unary `*`
            // decay (C99 6.3.2.1p4), as for a variable.
            if field.fn_ptr_indirection > 0 {
                self.pending.fn_ptr_chain_depth = field.fn_ptr_indirection - 1;
            }
            // A pointer-to-array member (`T (*m)[M1]...[Mn]`) records its
            // dimensions as `[0, M1, ...]` and one pointer level per `[Mi]` on
            // its type as a positional record of the shape; those levels
            // collapse to the one decayed pointer to the element.
            if field.array_dims.len() >= 2 && field.array_dims[0] == 0 && is_pointer_ty(self.ty) {
                let dims = field.array_dims.clone();
                let array_ptrs = (dims.len() as i64) - 1;
                let scalar_ty = field.ty - (dims.len() as i64) * (Ty::Ptr as i64);
                self.ty -= array_ptrs * (Ty::Ptr as i64);
                let elem_size = self.size_of_type(scalar_ty) as i64;
                self.seed_multi_dim_strides(&dims, elem_size);
            }
        } else {
            self.pending.member_base = Some(step);
        }
    }

    /// C99 6.3.2.1p3 at the last level of a pointer to an array: the
    /// value holds the array's address, so the dereference decays to the
    /// element pointer with no load; the remaining strides and the row
    /// size are left for the following subscripts and `sizeof`.
    fn decay_ptr_array_value(&mut self, id: usize) {
        let f = &self.structs[id].fields[0];
        let elem_ty = f.ty;
        let dims: alloc::vec::Vec<i64> = if f.array_dims.len() >= 2 {
            f.array_dims.clone()
        } else {
            alloc::vec![f.array_size]
        };
        let elem_size = self.size_of_type(elem_ty) as i64;
        self.seed_multi_dim_strides(&dims, elem_size);
        self.pending.last_array_decay_bytes = self.structs[id].size as i64;
        if self.structs[id].size == 0 {
            // A zero-size or unspecified row (`T (*p)[0]`, `T (*p)[]`): the
            // byte channel cannot say 0, so the sentinel does.
            self.pending.last_array_decay_size = -1;
        }
        // Exact row dimensions (-1 = unspecified bound, C99 6.7.5.2p4)
        // for `typeof` / `&` recovery of the undecayed array type.
        self.pending.last_array_decay_dims = dims;
        self.ty = elem_ty + Ty::Ptr as i64;
    }

    /// The subscript strides of an N-dimensional array of `elem_size`
    /// elements: for `T[A][B][C]` they are `[B*C*s, C*s]`, the head in
    /// `index_stride` and the rest queued. A 1D shape seeds none.
    pub(super) fn seed_multi_dim_strides(&mut self, dims: &[i64], elem_size: i64) {
        self.pending.index_stride = 0;
        self.pending.index_strides_tail.clear();
        if dims.len() < 2 || elem_size <= 0 {
            return;
        }
        // strides[k] = elem_size * product(dims[k+1..]) for k in 0..N-1.
        let n = dims.len();
        let mut strides: Vec<i64> = Vec::with_capacity(n - 1);
        let mut running: i64 = elem_size;
        for k in (0..n - 1).rev() {
            running = running.saturating_mul(dims[k + 1]);
            strides.push(running);
        }
        strides.reverse();
        if let Some((&head, tail)) = strides.split_first() {
            self.pending.index_stride = head;
            self.pending.index_strides_tail.extend_from_slice(tail);
        }
    }

    /// C11 6.5.1.1 `_Generic(controlling-expr, T1: e1, ..., default: eN)`.
    /// The controlling expression is parsed for its type only and its
    /// emitted state rewound; the association list is scanned by bracket
    /// depth, and only the selected expression is parsed live, through a
    /// lexer snapshot taken at its start.
    pub(super) fn parse_generic_selection(&mut self) -> Result<(), C5Error> {
        let after = self.generic_select_to_winner()?;
        self.expr(Token::Assign as i64)?;
        self.restore_lex(after);
        Ok(())
    }

    /// Shared front half of `_Generic` for the runtime and constant
    /// paths. Consumes `_Generic ( controlling , assoc-list )`, selects
    /// the association, and leaves the lexer positioned at the selected
    /// expression's first token so the caller can parse it with either
    /// the runtime or the constant grammar. Returns the lexer snapshot
    /// just past the closing `)`, to restore after parsing the winner.
    pub(super) fn generic_select_to_winner(
        &mut self,
    ) -> Result<super::super::lexer::LexerSnapshot, C5Error> {
        self.next()?; // _Generic
        self.consume(b'(', "`(` expected after `_Generic`")?;

        // The lexer appends string-literal bytes to the data section as it
        // scans the associations; they are rewound before the selected
        // expression is parsed.
        let data_start = self.data.len();

        // Controlling expression: recover its type, discard everything
        // the parse pushed (unevaluated per 6.5.1.1p2).
        let saved_text_len = self.next_ent_pc;
        let saved_reloc = self.code_reloc_sym_idx.len();
        let saved_ast_acc = self.ast_acc;
        let saved_vstack = self.ast_vstack.len();
        self.expr(Token::Assign as i64)?;
        let ctrl_ty = self.ty;
        self.next_ent_pc = saved_text_len;
        self.clear_recent_emits();
        self.code_reloc_sym_idx.truncate(saved_reloc);
        self.ast_acc = saved_ast_acc;
        self.ast_vstack.truncate(saved_vstack);
        self.consume(b',', "`,` expected after `_Generic` controlling expression")?;

        // A type match wins over `default` in any order (6.5.1.1p3). The
        // snapshot is taken at the `:`, before the expression's first token
        // is lexed, so re-lexing appends its string data after the rewind.
        let mut winner = None;
        let mut default_assoc = None;
        loop {
            if self.lex.tk == Token::Default {
                self.next()?; // default
                if default_assoc.is_none() {
                    default_assoc = Some(self.lex.snapshot());
                }
                self.consume(b':', "`:` expected after `default`")?;
            } else {
                let assoc_ty = self.parse_type_name()?.ty;
                let is_match = winner.is_none() && self.tags_compatible(ctrl_ty, assoc_ty);
                if is_match {
                    winner = Some(self.lex.snapshot());
                }
                self.consume(b':', "`:` expected after generic association type")?;
            }
            self.skip_generic_assoc_expr()?;
            if self.lex.tk == ',' {
                self.next()?;
                continue;
            }
            break;
        }
        self.consume(b')', "`)` expected to close `_Generic`")?;
        let after = self.lex.snapshot();

        let Some(chosen) = winner.or(default_assoc) else {
            return Err(self.compile_err(
                Code::INVALID_OPERANDS,
                "no `_Generic` association matches the controlling type",
            ));
        };
        // Drop the data the scan appended, then position at the selected
        // association's `:`; the following `next` re-lexes its first
        // token, appending any string data at `data_start`.
        self.truncate_data(data_start);
        self.restore_lex(chosen);
        self.next()?; // the `:` -> the expression's first token
        Ok(after)
    }

    /// Parse one assignment-expression for its type only. The lexer
    /// position and every emitted artifact (code, data, relocs, AST)
    /// are rewound, as for a `_Generic` controlling expression (C99
    /// 6.5.1.1p2 unevaluated semantics).
    pub(super) fn peek_expr_type(&mut self) -> Result<i64, C5Error> {
        let snap = self.lex.snapshot();
        let data_start = self.data.len();
        let saved_text_len = self.next_ent_pc;
        let saved_reloc = self.code_reloc_sym_idx.len();
        let saved_ast_acc = self.ast_acc;
        let saved_vstack = self.ast_vstack.len();
        let saved_ty = self.ty;
        let result = self.expr(Token::Assign as i64);
        let ty = self.ty;
        self.ty = saved_ty;
        self.next_ent_pc = saved_text_len;
        self.clear_recent_emits();
        self.code_reloc_sym_idx.truncate(saved_reloc);
        self.ast_acc = saved_ast_acc;
        self.ast_vstack.truncate(saved_vstack);
        self.truncate_data(data_start);
        self.restore_lex(snap);
        result.map(|_| ty)
    }

    /// Parse `__builtin_types_compatible_p ( type-name , type-name )`
    /// (GCC) and return 1 when the two type names are compatible (flat
    /// tags equal after dropping top-level qualifiers), else 0. The
    /// leading keyword has been consumed.
    pub(super) fn parse_types_compatible_p(&mut self) -> Result<i64, C5Error> {
        self.consume(b'(', "`(` expected after `__builtin_types_compatible_p`")?;
        let a = self.parse_type_name()?;
        self.consume(b',', "`,` expected between type names")?;
        let b = self.parse_type_name()?;
        self.consume(b')', "`)` expected after `__builtin_types_compatible_p`")?;
        // C99 6.7.6.2: an array type and a pointer type are never
        // compatible, even when the element / pointee coincide -- the flat
        // type collapses both to the element pointer, so the recorded
        // dimensions carry the array-vs-pointer distinction a compile-time
        // element-count macro depends on. The flat tag likewise holds only
        // a function type's return type, so the signature settles the rest.
        Ok((self.tags_compatible(a.ty, b.ty)
            && array_dims_match(&a.dims, &b.dims)
            && fn_type_match(&a.fn_ty, &b.fn_ty)) as i64)
    }

    /// Flat-tag compatibility for `_Generic` association selection and
    /// `__builtin_types_compatible_p`: equal tags with qualifiers
    /// dropped, or pointers at equal depth to array pointees whose
    /// element types match and whose bounds are compatible (C99
    /// 6.7.5.1p2, 6.7.5.2p6: an unspecified bound is compatible with
    /// any). Distinct bounds intern distinct aggregate tags, so the
    /// second test is what lets `T (*)[]` match `T (*)[N]`.
    pub(super) fn tags_compatible(&self, a: i64, b: i64) -> bool {
        if generic_type_match(a, b) {
            return true;
        }
        let (Some(ia), Some(ib)) = (self.ptr_array_id(a), self.ptr_array_id(b)) else {
            return false;
        };
        if struct_ptr_depth(a) != struct_ptr_depth(b) {
            return false;
        }
        let dims_of = |id: usize| -> alloc::vec::Vec<i64> {
            let f = &self.structs[id].fields[0];
            if f.array_dims.len() >= 2 {
                f.array_dims.clone()
            } else {
                alloc::vec![f.array_size]
            }
        };
        generic_type_match(self.structs[ia].fields[0].ty, self.structs[ib].fields[0].ty)
            && array_dims_match(&dims_of(ia), &dims_of(ib))
    }

    /// `__builtin_offsetof ( type-name , member-designator )` (GCC / C11
    /// 7.19), the keyword consumed; the designator is a member name and
    /// a chain of `.field` and `[index]` steps. Returns `Some(off)` for a
    /// constant offset. Under `allow_runtime` a non-constant subscript
    /// (GCC extension) makes the offset a `size_t` value emitted onto the
    /// accumulator, and `None` is returned.
    pub(super) fn parse_builtin_offsetof(
        &mut self,
        allow_runtime: bool,
    ) -> Result<Option<i64>, C5Error> {
        use super::super::ir::BinOp;
        self.consume(b'(', "`(` expected after `__builtin_offsetof`")?;
        let ty = self.parse_type_name()?.ty;
        if !is_struct_ty(ty) || struct_ptr_depth(ty) != 0 {
            return Err(self.compile_err(
                Code::INVALID_OPERANDS,
                "`__builtin_offsetof` requires a struct or union type",
            ));
        }
        self.consume(b',', "`,` expected after the `__builtin_offsetof` type")?;
        // Resolve the leading member and then each `.field` / `[index]` step,
        // accumulating the byte offset. `cur_ty` / `cur_dims` track the
        // element type and remaining array dimensions of the current member.
        let field_dims = |f: &super::StructField| -> alloc::vec::Vec<i64> {
            if !f.array_dims.is_empty() {
                f.array_dims.clone()
            } else if f.array_size > 0 {
                alloc::vec![f.array_size]
            } else {
                alloc::vec![]
            }
        };
        let mut offset: i64 = 0;
        // Set once a non-constant subscript term has been emitted onto the
        // accumulator; later runtime terms add to it, and the constant
        // `offset` is added at the end.
        let mut have_runtime = false;
        let mut sid = struct_id_of(ty);
        let f = self.offsetof_member(sid)?;
        offset += f.offset as i64;
        let mut cur_ty = f.ty;
        let mut cur_dims = field_dims(&f);
        loop {
            if self.lex.tk == Token::Dot {
                self.next()?;
                if !cur_dims.is_empty() || !is_struct_ty(cur_ty) || struct_ptr_depth(cur_ty) != 0 {
                    return Err(self.compile_err(
                        Code::INVALID_ARGUMENTS,
                        "`.` in `__builtin_offsetof` on a non-struct member",
                    ));
                }
                sid = struct_id_of(cur_ty);
                let f = self.offsetof_member(sid)?;
                offset += f.offset as i64;
                cur_ty = f.ty;
                cur_dims = field_dims(&f);
            } else if self.lex.tk == Token::Brak {
                self.next()?;
                // The row stride: the product of the dimensions below this one
                // times the element size. A flexible or zero-length trailing array
                // records no dimension; its stride is the element's size.
                let inner: i64 = if cur_dims.is_empty() {
                    1
                } else {
                    cur_dims[1..].iter().product::<i64>().max(1)
                };
                let stride = inner * self.size_of_type(cur_ty) as i64;
                match self.try_parse_constant_dim()? {
                    Some(idx) => offset += idx * stride,
                    None => {
                        // GCC extension: a runtime array subscript contributes
                        // `(size_t)i * stride`; multiple runtime subscripts sum.
                        if !allow_runtime {
                            return Err(self.compile_err(
                                Code::CONSTANT_EXPRESSION,
                                "constant integer expected in `__builtin_offsetof` subscript",
                            ));
                        }
                        if have_runtime {
                            self.ast_psh();
                        }
                        self.expr(Token::Assign as i64)?;
                        self.ast_apply_assign_conv(self.size_t_ty());
                        self.ty = self.size_t_ty();
                        self.emit_binop_with_imm(BinOp::Mul, stride);
                        if have_runtime {
                            self.ast_binop(BinOp::Add);
                        }
                        have_runtime = true;
                    }
                }
                self.consume(b']', "`]` expected after `__builtin_offsetof` subscript")?;
                if !cur_dims.is_empty() {
                    cur_dims.remove(0);
                }
            } else {
                break;
            }
        }
        self.consume(b')', "`)` expected after `__builtin_offsetof`")?;
        if have_runtime {
            if offset != 0 {
                self.emit_binop_with_imm(BinOp::Add, offset);
            }
            self.ty = self.size_t_ty();
            return Ok(None);
        }
        Ok(Some(offset))
    }

    /// Consume one member name and return its `StructField` in struct `sid`.
    fn offsetof_member(&mut self, sid: usize) -> Result<super::StructField, C5Error> {
        if self.lex.tk != Token::Id {
            return Err(
                self.compile_err(Code::SYNTAX, "member name expected in `__builtin_offsetof`")
            );
        }
        let name = self.symbols[self.lex.curr_id_idx].name.clone();
        self.next()?;
        self.structs[sid]
            .fields
            .iter()
            .find(|f| f.name == name)
            .cloned()
            .ok_or_else(|| {
                self.compile_err(
                    Code::UNDECLARED_IDENTIFIER,
                    format!("struct {} has no member {name}", self.structs[sid].name),
                )
            })
    }

    /// C99 6.7.6 type-name: a specifier-qualifier-list and an optional
    /// abstract declarator, entered on the first specifier and left on the
    /// token after the declarator. The type carriers the base parse seeds
    /// are consumed here, so none reaches a following declarator.
    pub(super) fn parse_type_name(&mut self) -> Result<TypeName, C5Error> {
        self.pending.typeof_operand_was_array = false;
        self.pending.typedef_base_array_size = 0;
        self.pending.typedef_base_array_dims.clear();
        self.pending.typedef_base_zero_len = false;
        let base = self.parse_decl_base_type()?;
        let mut ty = base;
        let base_is_fn = core::mem::take(&mut self.pending.base_is_function_type);
        let base_variadic = matches!(self.pending.typedef_fn_proto.take(), Some((_, true)));
        let base_params = self.pending.fn_ptr_param_types.take();
        self.pending.fn_ptr_ret_indirection = 0;
        let mut fn_ptr_indirection = self.pending.fn_ptr_indirection.take();
        let mut fn_ty = fn_ptr_indirection.map(|depth| FnTypeName {
            ptr_depth: if base_is_fn { 0 } else { depth.max(0) as usize },
            params: Some(base_params.unwrap_or_default()),
            variadic: base_variadic,
        });
        let type_align = core::mem::take(&mut self.pending.type_align);
        let base_extent = core::mem::take(&mut self.pending.typedef_base_array_size);
        let base_dims = core::mem::take(&mut self.pending.typedef_base_array_dims);
        let base_zero_len = core::mem::take(&mut self.pending.typedef_base_zero_len);
        let mut dims = if base_extent == 0 && !base_zero_len {
            alloc::vec::Vec::new()
        } else if !base_dims.is_empty() {
            base_dims
        } else if base_zero_len {
            alloc::vec![0]
        } else {
            alloc::vec![if base_extent > 0 { base_extent } else { -1 }]
        };
        // A function-type typedef already encodes one pointer level, so
        // the first `*` forms the pointer to function rather than adding
        // a level, as the declarator path reads it.
        let mut absorb_fn_type_ptr = base_is_fn;
        let mut ptr_levels: i64 = 0;
        while self.lex.tk == Token::MulOp {
            self.next()?;
            if absorb_fn_type_ptr {
                absorb_fn_type_ptr = false;
            } else {
                // `A *` over an array base names a pointer to the array
                // (C99 6.7.7p3): the extent folds into the pointee.
                if !dims.is_empty() {
                    ty = self.array_agg_type(ty, &dims);
                    dims.clear();
                }
                ty = add_ptr_level(ty);
                ptr_levels += 1;
                if let Some(f) = fn_ty.as_mut() {
                    f.ptr_depth += 1;
                }
                if let Some(fpi) = fn_ptr_indirection.as_mut() {
                    *fpi += 1;
                }
            }
            while self.lex.tk == Token::TypeQual {
                ty = apply_qual_bits(ty, self.lex_qualifier_bits());
                self.next()?;
            }
        }
        // Abstract function declarator (C99 6.7.6): `T (*)(params)` names
        // a pointer to function, `T (params)` the function type itself,
        // spelled as the return type at one pointer level; `T (*)[N]` a
        // pointer to an array, whose pointee keeps its dimensions.
        let mut proto = None;
        if self.lex.tk == '(' {
            let (levels, pp, ptr_dims) = if self.lex.peek_after_whitespace(b'*') {
                self.parse_abstract_ptr_declarator(true)?
            } else if fn_ty.is_none() {
                self.next()?;
                (
                    0,
                    Some(self.parse_type_name_params()?),
                    alloc::vec::Vec::new(),
                )
            } else {
                (0, None, alloc::vec::Vec::new())
            };
            if let Some(pp) = pp {
                ty += levels.max(1) * Ty::Ptr as i64;
                dims.clear();
                fn_ty = Some(FnTypeName {
                    ptr_depth: levels as usize,
                    params: pp.is_prototyped.then(|| pp.types.clone()),
                    variadic: pp.is_variadic,
                });
                proto = Some(pp);
            } else if !ptr_dims.is_empty() && levels > 0 {
                let mut pointee = ptr_dims;
                pointee.append(&mut dims);
                ty = self.array_agg_type(ty, &pointee) + levels * Ty::Ptr as i64;
            } else {
                ty += levels * Ty::Ptr as i64;
            }
            if levels > 0 {
                fn_ptr_indirection = Some(levels);
            }
            ptr_levels += levels;
        }
        // Abstract array declarator `T []` / `T [N]`. Only the outermost
        // bound may be omitted (C99 6.7.5.2p1: the element type shall be
        // complete); an array typedef base supplies the inner bounds.
        let mut outer = alloc::vec::Vec::new();
        while self.lex.tk == Token::Brak {
            self.next()?;
            let n = if self.lex.tk == ']' {
                if !outer.is_empty() {
                    return Err(self.compile_err(
                        Code::INVALID_DECLARATION,
                        "array type has an incomplete inner dimension",
                    ));
                }
                -1
            } else {
                let n = self.with_const_object_fold_masked(|c| c.parse_constant_int())?;
                if n < 0 {
                    return Err(self.compile_err(
                        Code::INVALID_DECLARATION,
                        "array dimension in a type name must not be negative",
                    ));
                }
                n
            };
            if self.lex.tk != ']' {
                return Err(
                    self.compile_err(Code::SYNTAX, "close bracket expected in an array type name")
                );
            }
            self.next()?;
            outer.push(n);
        }
        if !outer.is_empty() {
            outer.append(&mut dims);
            dims = outer;
        }
        Ok(TypeName {
            base,
            ty,
            dims,
            ptr_levels,
            fn_ty,
            proto,
            fn_ptr_indirection,
            type_align,
        })
    }

    /// The parameter list of an abstract function declarator, entered
    /// after its `(`. C99 6.2.1p4: parameter names in a type name have no
    /// scope, so their types are recorded without binding the names.
    fn parse_type_name_params(&mut self) -> Result<super::function::ParsedParams, C5Error> {
        let saved = self.pending.parsing_fn_ptr_proto;
        self.pending.parsing_fn_ptr_proto = true;
        let pp = self.parse_function_params();
        self.pending.parsing_fn_ptr_proto = saved;
        pp
    }

    /// Advance the lexer past one generic association's expression to
    /// the terminating top-level `,` or `)`, tracking bracket depth so
    /// commas and parens inside the expression do not end the scan.
    fn skip_generic_assoc_expr(&mut self) -> Result<(), C5Error> {
        let mut depth = 0i32;
        loop {
            let tk = self.lex.tk;
            if depth == 0 && (tk == ',' || tk == ')') {
                return Ok(());
            }
            // The lexer emits `Token::Brak` for a subscript `[` (not the
            // raw `[` byte), so an arm containing `&x[i]` must count it or
            // the bracket depth unbalances and the scan stops at the wrong
            // `)` / `,`.
            if tk == '(' || tk == '[' || tk == Token::Brak || tk == '{' {
                depth += 1;
            } else if tk == ')' || tk == ']' || tk == '}' {
                depth -= 1;
            }
            self.next()?;
        }
    }
}

/// C11 6.5.1.1p2 type match for a generic association: compare the flat
/// type tags after dropping the qualifier bits. `unsigned`-ness and the
/// pointer level / aggregate identity stay significant so
/// `unsigned int` and `T *` select distinct associations.
fn generic_type_match(ctrl: i64, assoc: i64) -> bool {
    (ctrl & !super::types::VOLATILE_MASK) == (assoc & !super::types::VOLATILE_MASK)
}

/// A binary operator of C99 6.5.5-6.5.14 as the precedence-climbing loop
/// applies it: its token and spelling, the level its right operand is
/// parsed at, and the opcodes its kind distinguishes.
struct BinaryOp {
    tok: Token,
    name: &'static str,
    rhs_lev: Token,
    kind: BinaryKind,
}

#[derive(Copy, Clone, PartialEq)]
enum BinaryKind {
    ShortCircuit(super::super::ast::ShortCircuitOp),
    Bitwise(super::super::ir::BinOp),
    Equality {
        int: super::super::ir::BinOp,
        fp: super::super::ir::BinOp,
    },
    Relational {
        signed: super::super::ir::BinOp,
        unsigned: super::super::ir::BinOp,
        fp: super::super::ir::BinOp,
    },
    Shift {
        signed: super::super::ir::BinOp,
        unsigned: super::super::ir::BinOp,
    },
    Additive {
        int: super::super::ir::BinOp,
        fp: super::super::ir::BinOp,
    },
    /// `unsigned` is `None` for multiplication, whose low bits do not
    /// depend on signedness; `fp` is `None` for `%`, which has no
    /// floating form.
    Multiplicative {
        signed: super::super::ir::BinOp,
        unsigned: Option<super::super::ir::BinOp>,
        fp: Option<super::super::ir::BinOp>,
    },
}

impl BinaryKind {
    /// The opcode the GCC vector extension lowers element-wise; the
    /// walker picks the signed, unsigned or floating flavour from the
    /// element type. `None` for an operator the extension does not take.
    fn vector_op(self) -> Option<super::super::ir::BinOp> {
        match self {
            BinaryKind::Bitwise(op) => Some(op),
            BinaryKind::Shift { signed, .. }
            | BinaryKind::Additive { int: signed, .. }
            | BinaryKind::Multiplicative { signed, .. } => Some(signed),
            BinaryKind::ShortCircuit(_)
            | BinaryKind::Equality { .. }
            | BinaryKind::Relational { .. } => None,
        }
    }
}

impl BinaryOp {
    const fn new(tok: Token, name: &'static str, rhs_lev: Token, kind: BinaryKind) -> Self {
        BinaryOp {
            tok,
            name,
            rhs_lev,
            kind,
        }
    }
}

static BINARY_OPS: [BinaryOp; 18] = {
    use super::super::ast::ShortCircuitOp as S;
    use super::super::ir::BinOp as B;
    use BinaryKind as K;
    use BinaryOp as Op;
    [
        Op::new(Token::Lor, "||", Token::Lan, K::ShortCircuit(S::Lor)),
        Op::new(Token::Lan, "&&", Token::OrOp, K::ShortCircuit(S::Lan)),
        Op::new(Token::OrOp, "|", Token::XorOp, K::Bitwise(B::Or)),
        Op::new(Token::XorOp, "^", Token::AndOp, K::Bitwise(B::Xor)),
        Op::new(Token::AndOp, "&", Token::EqOp, K::Bitwise(B::And)),
        Op::new(
            Token::EqOp,
            "==",
            Token::LtOp,
            K::Equality {
                int: B::Eq,
                fp: B::Feq,
            },
        ),
        Op::new(
            Token::NeOp,
            "!=",
            Token::LtOp,
            K::Equality {
                int: B::Ne,
                fp: B::Fne,
            },
        ),
        Op::new(
            Token::LtOp,
            "<",
            Token::ShlOp,
            K::Relational {
                signed: B::Lt,
                unsigned: B::Ult,
                fp: B::Flt,
            },
        ),
        Op::new(
            Token::GtOp,
            ">",
            Token::ShlOp,
            K::Relational {
                signed: B::Gt,
                unsigned: B::Ugt,
                fp: B::Fgt,
            },
        ),
        Op::new(
            Token::LeOp,
            "<=",
            Token::ShlOp,
            K::Relational {
                signed: B::Le,
                unsigned: B::Ule,
                fp: B::Fle,
            },
        ),
        Op::new(
            Token::GeOp,
            ">=",
            Token::ShlOp,
            K::Relational {
                signed: B::Ge,
                unsigned: B::Uge,
                fp: B::Fge,
            },
        ),
        Op::new(
            Token::ShlOp,
            "<<",
            Token::AddOp,
            K::Shift {
                signed: B::Shl,
                unsigned: B::Shl,
            },
        ),
        Op::new(
            Token::ShrOp,
            ">>",
            Token::AddOp,
            K::Shift {
                signed: B::Shr,
                unsigned: B::Shru,
            },
        ),
        Op::new(
            Token::AddOp,
            "+",
            Token::MulOp,
            K::Additive {
                int: B::Add,
                fp: B::Fadd,
            },
        ),
        Op::new(
            Token::SubOp,
            "-",
            Token::MulOp,
            K::Additive {
                int: B::Sub,
                fp: B::Fsub,
            },
        ),
        Op::new(
            Token::MulOp,
            "*",
            Token::Inc,
            K::Multiplicative {
                signed: B::Mul,
                unsigned: None,
                fp: Some(B::Fmul),
            },
        ),
        Op::new(
            Token::DivOp,
            "/",
            Token::Inc,
            K::Multiplicative {
                signed: B::Div,
                unsigned: Some(B::Divu),
                fp: Some(B::Fdiv),
            },
        ),
        Op::new(
            Token::ModOp,
            "%",
            Token::Inc,
            K::Multiplicative {
                signed: B::Mod,
                unsigned: Some(B::Modu),
                fp: None,
            },
        ),
    ]
};

fn binary_op(tk: i64) -> Option<&'static BinaryOp> {
    BINARY_OPS.iter().find(|op| op.tok as i64 == tk)
}

fn is_vector_binop_token(tk: i64) -> bool {
    binary_op(tk).is_some_and(|op| op.kind.vector_op().is_some())
}

fn is_vector_compare_token(tk: i64) -> bool {
    binary_op(tk).is_some_and(|op| {
        matches!(
            op.kind,
            BinaryKind::Equality { .. } | BinaryKind::Relational { .. }
        )
    })
}

fn vector_binop_name(tk: i64) -> &'static str {
    binary_op(tk).map_or("", |op| op.name)
}

fn vector_binop_op(tk: i64) -> super::super::ir::BinOp {
    binary_op(tk)
        .and_then(|op| op.kind.vector_op())
        .unwrap_or(super::super::ir::BinOp::Add)
}

/// A builtin recognized at a call on a bare identifier.
enum BuiltinCall {
    Simd(u32),
    MemTransfer(super::super::ast::MemTransferOp),
    ChooseExpr,
    ConstantP,
    HasAttribute,
    ObjectSize,
    Overflow,
    GccAtomic,
    Atomic(super::super::ast::AtomicKind),
    Intrinsic(i64),
}

/// What the intrinsic-operand parse hands the node build: the operands,
/// the type `__builtin_va_arg` yields, and the frame-walk level of the
/// frame builtins.
struct IntrinsicOperands {
    args: alloc::vec::Vec<super::super::ast::ExprId>,
    va_arg_result_ty: Option<i64>,
    frame_walk_levels: i64,
    walked_return_slot: bool,
}

/// The declaration of a direct call's callee, read once before the
/// arguments are parsed: a recursive call cannot change it under the
/// per-argument checks.
struct DirectCallee {
    params: Vec<i64>,
    is_variadic: bool,
    name: String,
    /// A libc import reads each argument at the ABI register width and
    /// never re-narrows to its declared parameter type, so the caller
    /// narrows for it; a c5 callee narrows in its own prologue.
    is_sys_call: bool,
    ret_ty: i64,
    /// The struct result goes through a hidden out-pointer the caller
    /// allocates; for a `Token::Sys` callee the walker tags the call
    /// `ret_agg` instead and the emitter gathers the platform-ABI return
    /// registers into that object.
    returns_struct: bool,
}

/// What a subscript's index parse hands back: the index expression, the
/// row stride the operand seeded for this level, and the function-pointer
/// decay depth parked across the parse.
struct SubscriptIndex {
    idx_ast: Option<super::super::ast::ExprId>,
    multi_dim_stride: i64,
    fn_ptr_chain_depth: i64,
}

/// A C99 6.7.6 type name as its consumers read it.
pub(super) struct TypeName {
    /// The specifier-qualifier-list's type, before the declarator.
    pub base: i64,
    /// The named type: an array type name carries its element type here
    /// and its bounds in `dims`; a pointer to an array carries the
    /// aggregate-backed pointee.
    pub ty: i64,
    /// Bounds of an array type name, outermost first, `-1` for an
    /// unspecified bound; empty for a non-array.
    pub dims: alloc::vec::Vec<i64>,
    /// Pointer levels the declarator added.
    pub ptr_levels: i64,
    /// The function type the name denotes or points to.
    pub fn_ty: Option<FnTypeName>,
    /// The parameter list of a `(*)(params)` declarator, for a call
    /// through a cast value.
    pub proto: Option<super::function::ParsedParams>,
    /// Function-pointer lineage of the named type, as
    /// `Symbol::fn_ptr_indirection` counts it.
    pub fn_ptr_indirection: Option<i64>,
    /// Explicit alignment a typedef base carries (GNU `aligned(N)`).
    pub type_align: i64,
}

/// A function type named by a type name. The flat type tag carries only
/// the return type, so C99 6.7.5.3 compatibility needs the parameter list
/// and the indirection above the function alongside it.
pub(super) struct FnTypeName {
    /// Pointer levels applied to the function type: 0 names a function
    /// type, 1 a pointer to function.
    ptr_depth: usize,
    /// Parameter type tags, or `None` for a declarator with no prototype
    /// (`T ()`). TODO: a typedef records only its parameter types, not
    /// whether they came from a prototype, so a `T (*)()` alias reads as
    /// an empty prototype here; the distinction survives only when the
    /// declarator is spelled out.
    params: Option<alloc::vec::Vec<i64>>,
    variadic: bool,
}

/// C99 6.7.5.3p15 function-type compatibility, given that the caller has
/// already matched the return types through the flat tag. Two prototypes
/// agree on arity, variadic-ness, and pairwise parameter types. A
/// declarator with no prototype agrees with a non-variadic prototype whose
/// parameters are unchanged by the default argument promotions. A function
/// type is never compatible with a non-function type, nor with a different
/// depth of pointer to itself.
fn fn_type_match(a: &Option<FnTypeName>, b: &Option<FnTypeName>) -> bool {
    let (a, b) = match (a, b) {
        (None, None) => return true,
        (Some(a), Some(b)) => (a, b),
        _ => return false,
    };
    if a.ptr_depth != b.ptr_depth {
        return false;
    }
    match (&a.params, &b.params) {
        (Some(pa), Some(pb)) => {
            a.variadic == b.variadic
                && pa.len() == pb.len()
                && pa.iter().zip(pb).all(|(x, y)| generic_type_match(*x, *y))
        }
        (Some(p), None) | (None, Some(p)) => {
            !a.variadic && !b.variadic && p.iter().copied().all(promotes_unchanged)
        }
        (None, None) => true,
    }
}

/// True when the default argument promotions (C99 6.5.2.2p6) leave `ty`
/// unchanged: integer types of rank below `int` promote to `int` and
/// `float` promotes to `double`, so only those four scalars are altered.
/// A pointer to one of them sits at a different tag and is unaffected.
fn promotes_unchanged(ty: i64) -> bool {
    let ty = super::types::strip_unsigned(ty);
    ![Ty::Char, Ty::Short, Ty::Bool, Ty::Float]
        .iter()
        .any(|&t| ty == t as i64)
}

/// C99 6.7.5.2p6 array compatibility: two array types are compatible when
/// they have the same rank and, for each dimension where both bounds are
/// specified, the bounds agree. An unspecified bound (`-1`) matches any.
/// A rank mismatch also covers array-vs-non-array, since a non-array type
/// name has rank 0. The flat type tag does not carry the element type of
/// an inner dimension, so the rank comparison stands in for it: `int[2][3]`
/// and `int[]` differ in rank and are correctly incompatible.
fn array_dims_match(a: &[i64], b: &[i64]) -> bool {
    a.len() == b.len() && a.iter().zip(b).all(|(x, y)| *x < 0 || *y < 0 || x == y)
}

/// Map an atomic-operation [`Intrinsic`](crate::c5::op::Intrinsic)
/// discriminant to its AST [`AtomicKind`](super::super::ast::AtomicKind).
/// Returns `None` for any non-atomic intrinsic. The `#pragma intrinsic`
/// registry stores the atomic operations under these discriminants; the
/// call site converts them here for `parse_atomic_builtin`.
fn atomic_kind_from_intrinsic(id: i64) -> Option<super::super::ast::AtomicKind> {
    use super::super::ast::AtomicKind;
    use crate::c5::op::Intrinsic;
    Some(match Intrinsic::from_i64(id)? {
        Intrinsic::AtomicLoad => AtomicKind::Load,
        Intrinsic::AtomicStore => AtomicKind::Store,
        Intrinsic::AtomicExchange => AtomicKind::Exchange,
        Intrinsic::AtomicFetchAdd => AtomicKind::FetchAdd,
        Intrinsic::AtomicFetchSub => AtomicKind::FetchSub,
        Intrinsic::AtomicFetchAnd => AtomicKind::FetchAnd,
        Intrinsic::AtomicFetchOr => AtomicKind::FetchOr,
        Intrinsic::AtomicFetchXor => AtomicKind::FetchXor,
        Intrinsic::AtomicCompareExchangeStrong => AtomicKind::CompareExchangeStrong,
        _ => return None,
    })
}

/// A type-specific checked-arithmetic builtin
/// (`__builtin_{s,u}{add,sub,mul}{,l,ll}_overflow`), as
/// `(op, unsigned, rank)`; `op` matches [`Expr::CheckedArith`] and `rank`
/// is `i` / `l` / `q` for int / long / long long. gcc documents the
/// family from 5.1; the generic three take any integer type instead.
fn typed_overflow_builtin(name: &str) -> Option<(i64, bool, u8)> {
    let rest = name.strip_prefix("__builtin_")?;
    let (unsigned, rest) = match rest.strip_prefix('s') {
        Some(r) => (false, r),
        None => (true, rest.strip_prefix('u')?),
    };
    let (op, rest) = if let Some(r) = rest.strip_prefix("add") {
        (0i64, r)
    } else if let Some(r) = rest.strip_prefix("sub") {
        (1, r)
    } else {
        (2, rest.strip_prefix("mul")?)
    };
    let rank = match rest {
        "_overflow" => b'i',
        "l_overflow" => b'l',
        "ll_overflow" => b'q',
        _ => return None,
    };
    Some((op, unsigned, rank))
}

/// The transfer kind of a GCC memory-transfer builtin name.
fn mem_transfer_op(name: &str) -> Option<super::super::ast::MemTransferOp> {
    use super::super::ast::MemTransferOp;
    Some(match name {
        "__builtin_memcpy" => MemTransferOp::Copy,
        "__builtin_memmove" => MemTransferOp::Move,
        "__builtin_memset" => MemTransferOp::Fill,
        _ => return None,
    })
}

/// Argument count for each atomic operation: the object pointer
/// plus the operation's value / expected / desired operands.
fn atomic_arity(kind: super::super::ast::AtomicKind) -> usize {
    use super::super::ast::AtomicKind;
    match kind {
        AtomicKind::Load => 1,
        AtomicKind::CompareExchangeStrong => 3,
        _ => 2,
    }
}

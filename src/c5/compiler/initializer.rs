//! Initializer parsing and packing.
//!
//! Static initializers ride a different value-shape than ordinary
//! expressions: every leaf has to fold to a constant (or a relocatable
//! address) at parse time so the per-target writers can lay the bytes
//! into the data segment with whatever rebase entries they need at
//! load time. This module hosts the eight methods that handle that
//! shape end to end:
//!
//! * [`Compiler::collect_array_initializer`] reads either a string
//!   literal or a brace list and returns a `Vec<(value, reloc-kind)>`.
//! * [`Compiler::pack_initializer_into_data`] writes that list into
//!   `self.data`, tracking per-element relocations.
//! * [`Compiler::parse_constant_init_value`] handles one initializer
//!   leaf -- integer / float literal, string, `&global`, function
//!   pointer, enum constant, parenthesised constant expression, or
//!   `(T)expr` cast.
//! * [`Compiler::collect_struct_initializer`] consumes a `{ .. }`
//!   struct/union initializer with designated and positional entries,
//!   nested initializers, array-fields, and recursive struct fields.
//! * [`Compiler::write_init_value`] / `write_array_init_into_data`
//!   are the per-byte LE writers that record DataReloc / CodeReloc
//!   entries for pointer-typed elements.
//! * [`Compiler::emit_local_array_init`] / `emit_local_init_store`
//!   emit the bytecode that drives array / scalar local initialisers
//!   into their stack slot at runtime.
//!
//! Lives next to `compiler/mod.rs` because the cluster only made
//! sense as a unit once `collect_struct_initializer` started
//! recursing into `collect_array_initializer` for `T arr[N]`-shaped
//! struct fields. Splitting it out cuts ~500 lines from mod.rs's
//! tail without changing any caller.

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::op::Op;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{UNSIGNED_BIT, is_struct_ty, struct_id_of, struct_ptr_depth};

/// Relocation kind for one initializer-element value. Tracks
/// whether the bytes need to be patched at link / load time so
/// the per-format writer can emit the right rebase entry.
#[derive(Debug, Clone, Copy)]
pub(super) enum InitElemReloc {
    /// Plain integer constant; bytes are final.
    None,
    /// Value is a data-segment offset; needs a DataReloc. The
    /// optional payload is the originating `Token::Glo`
    /// symbol's index (for `&global` initializers) or `None`
    /// for string-literal addresses where no source symbol
    /// owns the bytes. Cross-TU link-unit assembly reads this
    /// to convert `Some(sym)` entries against undefined
    /// externals into `DataDataAbs64` relocations.
    Data(Option<usize>),
    /// Value is a function ent_pc; needs a CodeReloc. The
    /// payload is the function's symbol index, captured at parse
    /// time so the post-body fixup pass can look up the
    /// resolved ent_pc and patch both the data bytes and
    /// the matching `Program::code_relocs` entry.
    Code(usize),
    /// Value is an IEEE-754 f64 bit pattern produced by a float
    /// literal or a constant-folded float arithmetic expression.
    /// The writer narrows to f32 when the element type is
    /// `float` (4 bytes) and stores the full pattern when it's
    /// `double` (8 bytes). No on-image relocation; the marker
    /// only flows through to disambiguate `static float a[] = {
    /// 1.0f, ... }` (f64 bit pattern) from `static float a[] = {
    /// 1, ... }` (raw int that still has to be converted to
    /// f32 bits, since the storage slot is FP, not integer).
    Float64Bits,
}

impl Compiler {
    /// Push the relocation entry that an initializer element needs
    /// at byte offset `here` within `self.data`.
    ///   * `None`        -- plain integer constant, no entry.
    ///   * `Data`        -- data-segment offset, push a DataReloc
    ///                      so the per-format writer can patch the
    ///                      slot to the runtime address.
    ///   * `Code(sym)`   -- function ent_pc, push a CodeReloc
    ///                      and stash the symbol index for the
    ///                      post-body fixup pass.
    fn push_init_reloc(&mut self, here: usize, value: i64, reloc: InitElemReloc) {
        match reloc {
            InitElemReloc::None | InitElemReloc::Float64Bits => {}
            InitElemReloc::Data(src_sym) => {
                self.data_relocs.push(crate::c5::program::DataReloc {
                    data_offset: here as u64,
                    target_offset: value as u64,
                });
                self.data_reloc_sym_idx.push(src_sym.unwrap_or(usize::MAX));
            }
            InitElemReloc::Code(sym_idx) => {
                self.code_relocs.push(crate::c5::program::CodeReloc {
                    data_offset: here as u64,
                    target_ent_pc: value as u64,
                });
                self.code_reloc_sym_idx.push(sym_idx);
            }
        }
    }

    /// Convert an initializer element's `(value, reloc)` to the
    /// bit pattern that should land in the data segment for an
    /// element of type `elem_ty`. c5 models every FP slot as
    /// `f64` bits in an 8-byte slot (sizeof(float) returns 8),
    /// so:
    ///   * `Float64Bits` value -- already f64 bits, pass through.
    ///   * Plain integer constant in a float/double element --
    ///     convert int -> f64 bits so e.g.
    ///     `static float a[] = { 1 }` ends up as the bit pattern
    ///     of `1.0`, not `0x0000000000000001`.
    /// Non-FP elem types and FP values destined for pointer
    /// slots (Data / Code relocs) pass through unchanged.
    fn to_storage_bits(&self, value: i64, reloc: InitElemReloc, elem_ty: i64) -> i64 {
        let stripped = elem_ty & !UNSIGNED_BIT;
        let is_float = stripped == Ty::Float as i64;
        let is_double = stripped == Ty::Double as i64;
        if !is_float && !is_double {
            return value;
        }
        // Compute the canonical f64 bit pattern from the source
        // value first, then narrow to f32 for the `Ty::Float` case.
        // The 4-byte single-precision storage slot can only hold the
        // narrowed bits -- a direct truncation of the f64 pattern
        // (the bug this branch fixes) would zero out the entire
        // low mantissa for any non-tiny value, e.g. `1.0` ->
        // `0x3FF0_0000_0000_0000` -> low 4 bytes = `0x0000_0000`
        // = `+0.0f`. Any `static float arr[N] = { 1.0f, ... }`
        // initializer would collapse every non-zero entry to
        // `+0.0f` under that path.
        let f64_bits = match reloc {
            InitElemReloc::Float64Bits => value,
            InitElemReloc::None => (value as f64).to_bits() as i64,
            // Data / Code relocs land in pointer-typed slots, not
            // FP slots; the upstream paths reject the type mix
            // before reaching here.
            _ => return value,
        };
        if is_float {
            let f = f64::from_bits(f64_bits as u64) as f32;
            return f.to_bits() as i64;
        }
        f64_bits
    }

    /// Write `n_bytes` little-endian bytes of `value` into
    /// `self.data` at byte offset `here`. Caller has already
    /// grown `self.data` to at least `here + n_bytes`.
    fn write_init_bytes(&mut self, here: usize, value: i64, n_bytes: usize) {
        if n_bytes == 1 {
            self.data[here] = value as u8;
        } else {
            for i in 0..n_bytes {
                self.data[here + i] = ((value >> (i * 8)) & 0xFF) as u8;
            }
        }
    }

    /// Collect an array initializer into a flat list of per-element
    /// values together with a "needs data relocation" flag. Two
    /// shapes are accepted:
    ///   * `"string"` -- valid only for `char[]`-shaped targets;
    ///     each byte (including the trailing NUL) is one element,
    ///     none needing relocation.
    ///   * `{ v1, v2, ... }` -- brace list of integer constants or
    ///     string-literal addresses. String literals produce a
    ///     data-segment offset and a `needs_reloc = true` flag so
    ///     the native writers can emit the right rebase entry;
    ///     integer constants are left as-is.
    pub(super) fn collect_array_initializer(
        &mut self,
        elem_ty: i64,
    ) -> Result<Vec<(i64, InitElemReloc)>, C5Error> {
        // 2D inner-dim hint -- callers set this when the declarator
        // shape is `T xs[N][M]` so a nested `{ row }` that lists
        // fewer than M values gets zero-padded per C99 6.7.8p21
        // (the remaining elements of an aggregate are initialised
        // implicitly to zero). Without padding, subsequent rows
        // shift into the previous row's tail and `xs[i][j]` reads
        // garbage. Read-and-clear so a recursive call into an
        // inner brace doesn't inherit it.
        let inner_dim = core::mem::take(&mut self.pending.init_inner_dim);
        let target_size = core::mem::take(&mut self.pending.init_target_array_size);
        if self.lex.tk == '"' && (elem_ty & !UNSIGNED_BIT) == Ty::Char as i64 {
            let start_addr = self.lex.ival as usize;
            self.next()?;
            while self.lex.tk == '"' {
                self.next()?;
            }
            let char_count = self.data.len() - start_addr;
            // C99 6.7.8p14: a string-literal initializer for a
            // bounded char array stores the literal's bytes
            // including the terminating NUL when the array has
            // room. When the literal is exactly `array_size`
            // characters long, the NUL is omitted (the array
            // holds the characters and nothing else).
            let store_nul = target_size <= 0 || char_count < target_size as usize;
            if store_nul {
                self.data.push(0);
            }
            let elems: Vec<(i64, InitElemReloc)> = self.data[start_addr..]
                .iter()
                .map(|&b| (b as i64, InitElemReloc::None))
                .collect();
            return Ok(elems);
        }
        if self.lex.tk != '{' {
            return Err(
                self.compile_err("array initializer must be a string literal or `{{ ... }}`")
            );
        }
        self.next()?;
        let mut elements: Vec<(i64, InitElemReloc)> = Vec::new();
        // C99 6.7.8 designated initializers: a `[N] = ...` clause
        // sets the write position to N; subsequent positional
        // entries (and chained `[K] = ...` clauses) continue
        // from there. Track the cursor here so designated and
        // positional entries can interleave per 6.7.8p17.
        let mut cursor: usize = 0;
        while self.lex.tk != '}' {
            // Array designator `[N] = ...`. Single-level only --
            // nested designators (`[N].field = ...`) aren't
            // supported yet; a constraint violation falls through
            // to `parse_constant_init_value` and surfaces as a
            // parse error.
            if self.lex.tk == Token::Brak {
                self.next()?;
                let n = self.parse_constant_int()?;
                if n < 0 {
                    return Err(self.compile_err(format!(
                        "array designator index must be non-negative (got {n})"
                    )));
                }
                if self.lex.tk != ']' {
                    return Err(self.compile_err("`]` expected after array designator index"));
                }
                self.next()?;
                if self.lex.tk != Token::Assign {
                    return Err(self.compile_err("`=` expected after `[N]` designator"));
                }
                self.next()?;
                cursor = n as usize;
            }
            // Nested brace list (multi-dim array): `{ {1,2}, {3,4}, ... }`.
            // c5's array-symbol storage carries a single flat
            // dimension, so we flatten the rows by recursing and
            // concatenating element vectors. When `inner_dim > 0`
            // the caller has told us the row width, so a short
            // inner list gets padded with zero-valued elements
            // before the next row starts.
            if self.lex.tk == '{' {
                let before = cursor;
                let inner = self.collect_array_initializer(elem_ty)?;
                let written = inner.len();
                if elements.len() < before + written {
                    elements.resize(before + written, (0, InitElemReloc::None));
                }
                for (i, entry) in inner.into_iter().enumerate() {
                    elements[before + i] = entry;
                }
                cursor = before + written;
                if inner_dim > 0 {
                    let pad = (inner_dim as usize).saturating_sub(written);
                    if pad > 0 {
                        if elements.len() < cursor + pad {
                            elements.resize(cursor + pad, (0, InitElemReloc::None));
                        }
                        cursor += pad;
                    }
                }
                if self.lex.tk == ',' {
                    self.next()?;
                }
                continue;
            }
            // Each element rides the same parser as struct field
            // initializers -- handles bare integers, string
            // literals, `&id`, function references, casts (`(u8*)"..."`),
            // negative numbers, and offsetof. The reloc kind is
            // mapped onto the array's `(value, needs_reloc)` shape:
            // both `Data` (string / `&global`) and `Code` (function
            // pointer) get a true reloc; integer constants don't.
            let (value, reloc) = self.parse_constant_init_value()?;
            if elements.len() <= cursor {
                elements.resize(cursor + 1, (0, InitElemReloc::None));
            }
            elements[cursor] = (value, reloc);
            cursor += 1;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        self.next()?; // consume `}`
        Ok(elements)
    }

    /// Pack array initializer elements into the data segment so a
    /// later Mcpy or direct write can lay them out at the target
    /// location. Returns `(start_addr, total_bytes)`. Element
    /// values are little-endian (c5 only runs on LE hosts). For
    /// each pointer-into-data element (flagged `needs_reloc`), a
    /// `DataReloc` entry is recorded so the per-format writers can
    /// patch the runtime address at link time.
    pub(super) fn pack_initializer_into_data(
        &mut self,
        elem_ty: i64,
        elements: &[(i64, InitElemReloc)],
    ) -> (usize, usize) {
        let elem_size = self.size_of_type(elem_ty);
        let start_addr = self.data.len();
        if elem_size == 1 {
            for &(v, _) in elements {
                self.data.push(v as u8);
            }
        } else {
            // Grow once to the final size, then lay bytes by index
            // so we can share the LE-write + reloc-push helpers
            // with `write_array_init_into_data` and
            // `write_init_value`.
            self.data.resize(start_addr + elements.len() * elem_size, 0);
            for (idx, &(v, reloc)) in elements.iter().enumerate() {
                let here = start_addr + idx * elem_size;
                let bits = self.to_storage_bits(v, reloc, elem_ty);
                self.write_init_bytes(here, bits, elem_size);
                self.push_init_reloc(here, v, reloc);
            }
        }
        (start_addr, elements.len() * elem_size)
    }

    /// Parse one constant-expression initializer value, returning
    /// the bytes-as-i64 + a relocation kind. Accepted shapes:
    ///   * integer literal (with optional unary `-`)
    ///   * string literal -> data offset, needs `Data` reloc
    ///   * `&id` -> data offset of a global, needs `Data` reloc
    ///   * bare identifier -> if it's a function, code PC, needs
    ///     `Code` reloc; if it's a `Token::Num`-class symbol
    ///     (enum value, `#define`d constant), use its `val`
    ///   * `0` is special -- a NULL pointer / zero scalar, no reloc.
    pub(super) fn parse_constant_init_value(&mut self) -> Result<(i64, InitElemReloc), C5Error> {
        // Float literal -- store the f64 bit pattern. The element
        // type drives the runtime interpretation; the on-disk
        // image is just bytes.
        //
        // C99 6.6 defines arithmetic constant expressions over
        // floating-point operands. A trailing `+ - * /` after the
        // literal continues the chain; fold it in `f64`
        // precision since the integer const-expr evaluator can't
        // see through float operands.
        if self.lex.tk == Token::FloatNum {
            let v = self.lex.ival;
            self.next()?;
            if self.tk_is_float_arith_op() {
                let bits = self.parse_const_float_add_from(f64::from_bits(v as u64))?;
                return Ok((bits.to_bits() as i64, InitElemReloc::Float64Bits));
            }
            return Ok((v, InitElemReloc::Float64Bits));
        }
        // Negative float / integer literal: `-1.5e+020` lexes as
        // `-` followed by FloatNum, and `-42` as `-` followed by
        // Num. The integer-only fallback at the tail of this
        // function (`parse_constant_int`) handles `-(expr)` and
        // `-IDENT_MACRO` via its own unary-minus path; here we
        // only intercept when the byte after `-` is the start of
        // a literal, so we don't disturb the existing routes.
        // C99 6.6 admits unary `-` on a numeric literal as a
        // constant expression -- the float case has to flip the
        // IEEE-754 sign bit rather than negate an integer value.
        if self.lex.tk == Token::SubOp && self.lex.peek_after_whitespace_starts_digit() {
            self.next()?; // consume `-`
            if self.lex.tk == Token::FloatNum {
                let bits = (self.lex.ival as u64) ^ (1u64 << 63);
                self.next()?;
                if self.tk_is_float_arith_op() {
                    let folded = self.parse_const_float_add_from(f64::from_bits(bits))?;
                    return Ok((folded.to_bits() as i64, InitElemReloc::Float64Bits));
                }
                return Ok((bits as i64, InitElemReloc::Float64Bits));
            }
            if self.lex.tk == Token::Num {
                let v = -self.lex.ival;
                self.next()?;
                return Ok((v, InitElemReloc::None));
            }
            // peek said "digit next", so the lexer must have
            // produced a numeric token. Anything else is a bug.
            return Err(self.compile_err(format!(
                "expected numeric literal after `-` in initializer (got {})",
                super::super::token::describe(self.lex.tk)
            )));
        }
        // `(type)expr` cast or `(expr)` parenthesized constant in a
        // static initializer. After consuming `(`, peek the next
        // token: if it starts a type, treat as a cast and recurse on
        // the value (c5's i64-shaped representation makes integer /
        // pointer casts no-ops). Otherwise it's a parenthesized
        // constant expression -- evaluate it and expect `)`.
        if self.lex.tk == '(' {
            // Cast / float-content detection both need to look
            // past the `(`. Snapshot so we can rewind for the
            // integer-expression fall-through, which has to see
            // `(` to absorb both the parenthesised sub-expression
            // *and* any trailing operators -- a struct initialiser
            // entry like `{ (127-13) << 23 }` needs the integer
            // const-expr evaluator to start outside the parens so
            // the `<< 23` after `)` joins the chain.
            let snap = self.lex.snapshot();
            self.next()?;
            if self.lex_is_type_start() {
                let _ = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp || self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
                // Optional function-pointer abstract declarator
                // `(*)(args)` after the base type. Same treatment
                // as in the expression-level cast handler: scan
                // counted parens until the cast's outer `)`,
                // then skip the trailing `(args)` arg-list shape.
                if self.lex.tk == '(' {
                    let mut depth: i64 = 1;
                    self.next()?;
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
                    if self.lex.tk == '(' {
                        self.next()?;
                        self.skip_balanced_parens_after_open()?;
                    }
                }
                if self.lex.tk != ')' {
                    return Err(self.compile_err("close paren expected after cast in initializer"));
                }
                self.next()?;
                return self.parse_constant_init_value();
            }
            // Sub-expression in parens. Peek for any FloatNum
            // token inside (up to the matching `)`); if present,
            // fold the whole sub-expression in f64 precision so
            // shapes like `(1.0f + 2.0f) * 4.0f` round-trip
            // exactly. Pure-integer parens fall through to the
            // integer expression evaluator below so trailing
            // `<<`, `+`, ... operators after `)` are absorbed too.
            if self.contents_until_close_paren_have_float()? {
                let seed = self.parse_const_float_unary()?;
                let v = self.parse_const_float_add_from(seed)?;
                if self.lex.tk != ')' {
                    return Err(self.compile_err("close paren expected in initializer"));
                }
                self.next()?;
                // The result of the parens is itself a float
                // value; any trailing `+ / - / * / /` continues
                // the float expression chain.
                if self.tk_is_float_arith_op() {
                    let folded = self.parse_const_float_add_from(v)?;
                    return Ok((folded.to_bits() as i64, InitElemReloc::Float64Bits));
                }
                return Ok((v.to_bits() as i64, InitElemReloc::Float64Bits));
            }
            // Nested cast around a string literal:
            // `((const T *)"...")` is a common header idiom for
            // building a pointer-typed constant from a string
            // literal. The outer `(` isn't a cast start, but the
            // inner one is, and the cast wraps a string literal
            // -- so the result must carry a Data reloc. The
            // integer evaluator would drop the reloc and bake
            // the parse-time data offset into the slot. Peek for
            // the exact shape `(<type-tokens>*) "..."` before
            // routing through the recursive primary parser.
            if self.lex.tk == '(' {
                let peek_snap = self.lex.snapshot();
                self.next()?; // consume inner `(`
                let inner_is_cast = self.lex_is_type_start();
                let mut is_cast_of_string = false;
                if inner_is_cast {
                    let _ = self.parse_decl_base_type()?;
                    while self.lex.tk == Token::MulOp || self.lex.tk == Token::TypeQual {
                        self.next()?;
                    }
                    if self.lex.tk == ')' {
                        self.next()?;
                        is_cast_of_string = self.lex.tk == '"';
                    }
                }
                self.lex.restore(peek_snap);
                if is_cast_of_string {
                    let (value, reloc) = self.parse_constant_init_value()?;
                    if self.lex.tk != ')' {
                        return Err(self.compile_err("close paren expected in initializer"));
                    }
                    self.next()?;
                    return Ok((value, reloc));
                }
            }
            // Rewind so the integer evaluator below absorbs the
            // whole `(expr) op rhs` chain as one expression. The
            // string-literal and offsetof primaries are picked up
            // through `parse_const_expr_primary_val`, so a static
            // initializer can use `((char *)"...")` and
            // `&((T *)0)->field` shapes inside arithmetic.
            self.lex.restore(snap);
            let v = self.parse_constant_int()?;
            return Ok((v, InitElemReloc::None));
        }
        if self.lex.tk == '"' {
            let addr = self.lex.ival;
            self.next()?;
            while self.lex.tk == '"' {
                self.next()?;
            }
            self.data.push(0);
            return Ok((addr, InitElemReloc::Data(None)));
        }
        if self.lex.tk == Token::AndOp {
            // A static initializer leaf that begins with `&` is
            // either a relocation-bearing pointer (`&global` or
            // `&func`, equivalent under C99 6.3.2.1p4) or a
            // constant arithmetic expression whose value is a
            // byte offset (the canonical case is the C99 7.19 /
            // GCC `offsetof` macro expansion
            // `&((T *)0)->field`). Peek past the `&` to decide:
            // if the next token is an identifier bound to a Glo
            // or Fun symbol, take the reloc path; otherwise the
            // integer constant-expression evaluator folds the
            // whole expression (including the surrounding casts
            // and pointer-difference of the offsetof macro).
            let amp_snap = self.lex.snapshot();
            self.next()?;
            if self.lex.tk == Token::Id {
                let target_idx = self.lex.curr_id_idx;
                let class = self.symbols[target_idx].class;
                if class == Token::Fun as i64 {
                    self.symbols[target_idx].was_referenced = true;
                    let ent_pc = self.symbols[target_idx].val;
                    self.next()?;
                    return Ok((ent_pc, InitElemReloc::Code(target_idx)));
                }
                if class == Token::Glo as i64 {
                    let off = self.symbols[target_idx].val;
                    self.next()?;
                    return Ok((off, InitElemReloc::Data(Some(target_idx))));
                }
            }
            // Not a relocation-bearing shape -- restore so the
            // integer evaluator sees the leading `&` and routes
            // through `parse_const_offsetof`.
            self.lex.restore(amp_snap);
            let v = self.parse_constant_int()?;
            return Ok((v, InitElemReloc::None));
        }
        if self.lex.tk == Token::Id {
            let idx = self.lex.curr_id_idx;
            let class = self.symbols[idx].class;
            // Forward-referenced function pointer in a static
            // initializer: dispatch tables that list functions
            // defined later in the same TU. The post-parse
            // [`Compiler::resolve_code_relocs`] pass rewrites
            // each `code_relocs[i].target_ent_pc` from the
            // originating symbol's now-resolved `Symbol::val`,
            // so we bind the identifier as `Token::Fun` with
            // val=0 here and let the resolve pass fill in the
            // CodeReloc once the body has been emitted. The
            // forward-ref heuristic only fires when the next
            // token is `,` / `}` -- i.e., the identifier is the
            // entire init slot, not the start of an expression
            // that happens to use an undeclared name.
            if class == 0
                && (self.lex.peek_after_whitespace(b',') || self.lex.peek_after_whitespace(b'}'))
            {
                self.symbols[idx].class = Token::Fun as i64;
                self.symbols[idx].type_ = Ty::Int as i64;
                self.symbols[idx].was_referenced = true;
                self.next()?;
                return Ok((0, InitElemReloc::Code(idx)));
            }
            if class == Token::Fun as i64 {
                self.symbols[idx].was_referenced = true;
                let ent_pc = self.symbols[idx].val;
                self.next()?;
                return Ok((ent_pc, InitElemReloc::Code(idx)));
            }
            if class == Token::Num as i64 {
                // Integer constant -- either a bare enum / macro
                // value or the head of a constant arithmetic
                // expression (`E_A | E_B`, `K << 4`, ...). Defer
                // to the full integer-constant evaluator so any
                // trailing operator chain is folded in per C99
                // 6.6, instead of returning the head value and
                // leaving the operator to fail downstream.
                let v = self.parse_constant_int()?;
                return Ok((v, InitElemReloc::None));
            }
            if class == Token::Sys as i64 {
                // Address of a libc binding in a static initializer.
                // The real address lives in the loader's GOT/IAT and
                // can't be folded in at compile time, so we route the
                // slot through a per-Sys trampoline (a tiny synthetic
                // c5 function that re-pushes its declared args and
                // re-dispatches via `Op::JsrExt`). The CodeReloc
                // points at the trampoline's synthetic symbol; its
                // `.val` holds the trampoline's `ent_pc` once
                // [`Compiler::emit_sys_trampolines`] runs in the
                // post-parse fixup pass. From the call site's view
                // -- e.g., a vtable consumer reading
                // `dispatch_table[7].pCurrent` through an
                // `(int(*)(...))` cast and invoking it -- it's an
                // ordinary function pointer.
                let tr_idx = self.ensure_sys_trampoline_sym(idx);
                self.next()?;
                return Ok((0, InitElemReloc::Code(tr_idx)));
            }
            if class == Token::Glo as i64 {
                // Bare global identifier in a static initializer.
                // For array globals (`static const char name[] =
                // "..."`) this is the array-decay rule: the value
                // is the array's data-segment offset; a DataReloc
                // patches it to the runtime address.
                let mut off = self.symbols[idx].val;
                let array_size = self.symbols[idx].array_size;
                let inner_dim = self.symbols[idx].inner_array_size;
                let elem_ty = self.symbols[idx].type_;
                self.next()?;
                // Optional `[N]...` postfixes -- decay-to-address-
                // of-element. `arr[N]` is equivalent to `&arr[N]`
                // in a constant initializer (C99 6.3.2.1p3 array-
                // to-pointer conversion); a chain of `[N]`s
                // navigates further into a multi-dim array
                // before taking its address.
                //
                // c5 only tracks `inner_array_size` (the second
                // dim of `T name[A][B]`), so for the third index
                // of a 3D `T name[A][B][C]` we don't have a stride
                // to multiply by. The common static-init shape is
                // `arr[0][0]` (a row pointer through a 2D or 3D
                // table) which only matters as the base address;
                // we accept further `[0]` postfixes without error
                // and reject `[non-zero]` past the second index.
                let mut depth: usize = 0;
                while self.lex.tk == Token::Brak {
                    self.next()?;
                    let n = self.parse_constant_int()?;
                    if self.lex.tk != ']' {
                        return Err(self.compile_err(format!(
                            "close bracket expected in `{}[...]` initializer",
                            self.symbols[idx].name
                        )));
                    }
                    self.next()?;
                    let stride: i64 = if depth == 0 {
                        if inner_dim > 0 {
                            // 2D / 3D: first index strides over rows.
                            inner_dim * self.size_of_type(elem_ty) as i64
                        } else if array_size > 0 {
                            self.size_of_type(elem_ty) as i64
                        } else {
                            1
                        }
                    } else if depth == 1 {
                        // Second index: scalar element stride.
                        self.size_of_type(elem_ty) as i64
                    } else {
                        // Beyond 2D, c5 has no per-dim stride.
                        if n != 0 {
                            return Err(self.compile_err(format!(
                                "static initializer index past 2D for `{}` -- \
                                 c5 only tracks two dimensions, only `[0]` is \
                                 accepted beyond that",
                                self.symbols[idx].name
                            )));
                        }
                        0
                    };
                    off += n * stride;
                    depth += 1;
                }
                return Ok((off, InitElemReloc::Data(Some(idx))));
            }
            return Err(self.compile_err(format!(
                "identifier `{}` is not a constant-expression value",
                self.symbols[idx].name
            )));
        }
        // Fall back to integer literal (with optional unary `-`).
        let v = self.parse_constant_int()?;
        Ok((v, InitElemReloc::None))
    }

    /// Collect a `{ ... }` struct initializer. Each entry can be
    /// designated (`.field = value`) or positional. Entries are
    /// returned in source order with their resolved field offset
    /// + size. Designators advance the running positional index
    /// to "the field after the named one".
    pub(super) fn collect_struct_initializer(
        &mut self,
        struct_id: usize,
        var_offset: i64,
    ) -> Result<(), C5Error> {
        if self.lex.tk != '{' {
            return Err(self.compile_err("struct initializer must start with `{{`"));
        }
        self.next()?;
        let mut pos: usize = 0;
        while self.lex.tk != '}' {
            // Designator?
            let field_idx = if self.lex.tk == Token::Dot {
                self.next()?;
                if self.lex.tk != Token::Id {
                    return Err(self.compile_err("field name expected after `.`"));
                }
                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                if self.lex.tk != Token::Assign {
                    return Err(
                        self.compile_err(format!("`=` expected after `.{field_name}` designator"))
                    );
                }
                self.next()?;

                self.structs[struct_id]
                    .fields
                    .iter()
                    .position(|f| f.name == field_name)
                    .ok_or_else(|| {
                        self.compile_err(format!(
                            "struct {} has no field {}",
                            self.structs[struct_id].name, field_name
                        ))
                    })?
            } else {
                pos
            };
            if field_idx >= self.structs[struct_id].fields.len() {
                return Err(self.compile_err(format!(
                    "too many initializers for struct {}",
                    self.structs[struct_id].name
                )));
            }
            let field = self.structs[struct_id].fields[field_idx].clone();
            let field_base = (var_offset as usize) + field.offset;
            // Three field shapes get nested `{ ... }` initializers:
            //   * array field (`T xs[N]`)
            //   * value-typed nested struct
            //   * value-typed nested union
            // Pointer / scalar / bitfield fields read a single
            // constant-expression value via parse_constant_init_value.
            if field.array_size > 0
                && self.lex.tk == '"'
                && (field.ty & !UNSIGNED_BIT) == Ty::Char as i64
            {
                // `struct S { char a[N]; } x = { "..." };` -- copy the
                // string bytes (including the trailing NUL) into the
                // char-array field, padding the remainder with zeroes.
                // Without this branch the parser falls into the
                // single-value path and writes the *pointer* to the
                // string's data-segment slot into the field's first
                // 8 bytes, which produces garbage at read time.
                let start_addr = self.lex.ival as usize;
                self.next()?;
                while self.lex.tk == '"' {
                    self.next()?;
                }
                self.data.push(0); // ensure NUL terminator
                let max = field.array_size as usize;
                let mut idx = 0usize;
                while idx < max {
                    let b = if start_addr + idx < self.data.len() {
                        self.data[start_addr + idx]
                    } else {
                        0
                    };
                    self.write_init_value(
                        field_base + idx,
                        1,
                        b as i64,
                        super::initializer::InitElemReloc::None,
                    );
                    idx += 1;
                    if start_addr + idx >= self.data.len() {
                        // Past the string; remainder stays zero.
                        // Still walk the loop so all `max` bytes are
                        // explicitly written (zeroed above by
                        // write_init_value when source byte is 0).
                    }
                }
            } else if field.array_size > 0 && self.lex.tk == '{' {
                self.next()?;
                let elem_size = self.size_of_type(field.ty);
                let elem_is_struct = is_struct_ty(field.ty) && struct_ptr_depth(field.ty) == 0;
                let elem_sid = if elem_is_struct {
                    Some(struct_id_of(field.ty))
                } else {
                    None
                };
                let mut idx: usize = 0;
                while self.lex.tk != '}' {
                    if idx as i64 >= field.array_size {
                        return Err(self.compile_err(format!(
                            "too many initializers for `{}.{}`",
                            self.structs[struct_id].name, field.name
                        )));
                    }
                    let here = field_base + idx * elem_size;
                    // C99 6.7.8p20: an array-of-struct field accepts
                    // a nested brace-enclosed initializer for each
                    // element. Route the inner `{ ... }` through the
                    // struct collector so the per-field offsets are
                    // honoured; scalar element types fall through to
                    // the constant-value path.
                    if elem_is_struct && self.lex.tk == '{' {
                        self.collect_struct_initializer(
                            elem_sid.expect("elem_is_struct implies a struct id"),
                            here as i64,
                        )?;
                    } else {
                        let (value, reloc) = self.parse_constant_init_value()?;
                        self.write_init_value(here, elem_size, value, reloc);
                    }
                    idx += 1;
                    if self.lex.tk == ',' {
                        self.next()?;
                    }
                }
                self.next()?; // consume `}`
            } else if field.array_size > 0 {
                // C99 6.7.8p20 "implicit braces removed": a flat
                // value list inside a struct initializer can fill
                // an array field directly, without nested braces.
                // Absorb up to `array_size` values from the
                // surrounding brace list; the outer struct loop
                // then advances to the next field on the
                // following `,`. A canonical instance is
                //   struct { unsigned char c[4]; } v = { 1,2,3,4 };
                // where the inner array's brace pair is elided.
                let elem_size = self.size_of_type(field.ty);
                let mut idx: usize = 0;
                while (idx as i64) < field.array_size && self.lex.tk != '}' {
                    let (value, reloc) = self.parse_constant_init_value()?;
                    let here = field_base + idx * elem_size;
                    self.write_init_value(here, elem_size, value, reloc);
                    idx += 1;
                    if idx as i64 >= field.array_size {
                        break;
                    }
                    if self.lex.tk == ',' {
                        self.next()?;
                    } else {
                        break;
                    }
                }
            } else if is_struct_ty(field.ty)
                && struct_ptr_depth(field.ty) == 0
                && self.lex.tk == '{'
            {
                let nested_sid = struct_id_of(field.ty);
                self.collect_struct_initializer(nested_sid, field_base as i64)?;
            } else if field.bit_width > 0 {
                // Bitfield brace-initializer entry. C99 6.7.8 says
                // the initializer's value is converted to the
                // bitfield's type as if assigned. A naive
                // `write_init_value(field_base, sizeof(base), value)`
                // would clobber every other bitfield sharing the
                // same storage unit -- adjacent fields in the same
                // brace list each rewrite the entire unit. Merge
                // the bitfield's bits into the existing storage
                // unit instead.
                let (value, _reloc) = self.parse_constant_init_value()?;
                // C99 6.7.2.1p11: the bitfield's addressable storage
                // unit width is determined by the declared base type;
                // the RMW span must match `bit_unit_size` so it does
                // not read or write outside the unit.
                let unit_bytes = field.bit_unit_size as usize;
                let mut unit_value: i64 = 0;
                for i in 0..unit_bytes {
                    unit_value |= (self.data[field_base + i] as i64) << (i * 8);
                }
                let bit_width = field.bit_width;
                let bit_offset = field.bit_offset;
                let mask: i64 = if bit_width >= 64 {
                    -1
                } else {
                    (1i64 << bit_width) - 1
                };
                let cleared = unit_value & !(mask << bit_offset);
                let merged = cleared | ((value & mask) << bit_offset);
                for i in 0..unit_bytes {
                    self.data[field_base + i] = ((merged >> (i * 8)) & 0xFF) as u8;
                }
            } else {
                let (value, reloc) = self.parse_constant_init_value()?;
                let field_size = self.size_of_type(field.ty);
                self.write_init_value(field_base, field_size, value, reloc);
            }
            pos = field_idx + 1;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        self.next()?; // consume `}`
        Ok(())
    }

    /// Write `field_size` little-endian bytes of `value` into
    /// `self.data` at byte offset `here`, then push the
    /// appropriate relocation if the value is a data offset
    /// (string / `&global`) or a code PC (function pointer).
    pub(super) fn write_init_value(
        &mut self,
        here: usize,
        field_size: usize,
        value: i64,
        reloc: InitElemReloc,
    ) {
        self.write_init_bytes(here, value, field_size);
        self.push_init_reloc(here, value, reloc);
    }

    /// Write packed initializer bytes into `self.data` at
    /// `var_offset` -- the address of a freshly allocated global
    /// array. Element values are little-endian; `elem_size`
    /// determines whether each value writes one byte (char arrays)
    /// or `elem_size` bytes (int / pointer arrays). Pointer-into-
    /// data elements record a DataReloc so the native writers
    /// patch the runtime address.
    pub(super) fn write_array_init_into_data(
        &mut self,
        var_offset: i64,
        elem_ty: i64,
        elements: &[(i64, InitElemReloc)],
    ) {
        let elem_size = self.size_of_type(elem_ty);
        let mut byte_off = var_offset as usize;
        for &(v, reloc) in elements {
            let bits = self.to_storage_bits(v, reloc, elem_ty);
            self.write_init_bytes(byte_off, bits, elem_size);
            // char-element arrays never carry a relocation kind --
            // the elements are bare bytes from a string literal --
            // so the reloc-push helper's None branch is the only
            // one that fires for elem_size == 1. Keeping the call
            // unconditional drops the size-1 special case.
            self.push_init_reloc(byte_off, v, reloc);
            byte_off += elem_size;
        }
    }

    /// Emit a Mcpy that copies `total_bytes` from `src_data_addr`
    /// (a position in self.data) to the local at `local_val`. The
    /// usual Lea/Psh/data_imm/Mcpy shape so the runtime VM and the
    /// native codegen don't need new ops.
    pub(super) fn emit_local_array_init(
        &mut self,
        local_val: i64,
        src_data_addr: usize,
        total_bytes: usize,
    ) {
        if total_bytes == 0 {
            return;
        }
        self.emit_lea(local_val);
        self.emit_op(Op::Psh);
        self.emit_data_imm(src_data_addr as i64);
        self.emit_op(Op::Mcpy);
        self.emit_val(total_bytes as i64);
        // Dual-emit: record the Mcpy source descriptor so the
        // surrounding decl-site caller can build
        // `Decl::Local { init: Aggregate { src_data_off,
        // size_bytes } }`.
        self.pending_local_aggregate_ast = Some((src_data_addr as i64, total_bytes as i64));
    }

    /// Emit the store sequence for a local-variable initializer:
    ///   Lea local_val ; Psh ; <init expr> ; Si | Sc | Mcpy
    /// On entry `tk` is positioned just past the `=`; on exit it
    /// is at the comma or semicolon following the initializer.
    pub(super) fn emit_local_init_store(&mut self, local_val: i64, ty: i64) -> Result<(), C5Error> {
        self.emit_lea(local_val);
        self.emit_op(Op::Psh);
        self.expr(Token::Assign as i64)?;
        // C99 6.5.16.1p2: the RHS of an assignment is converted
        // to the unqualified LHS type. For a float / double
        // destination with an integer-typed initializer (a
        // common case: `float r = data[i];` where `data[i]` is
        // `unsigned char`), the bit pattern in `a` is an int
        // that has to be lifted to an IEEE-754 f64 before the
        // store lands. Mirror logic for the reverse direction
        // (int destination, float source).
        self.convert_assign_rhs(ty);
        // Dual-emit: capture the init expression's ExprId for
        // `Decl::Local { init: Some(...) }`. Capture after the
        // convert so a `Cast { child, to_ty }` wrapper from
        // `convert_assign_rhs` (when the implicit conversion
        // fires) flows through to the walker. The Si below
        // already runs through `ast_apply_assign`, but the
        // lvalue is `emit_lea`-shaped (no AST counterpart), so
        // the assign drops. The caller pushes a `Decl::Local`
        // wrapping `init_ast` so the walker can issue the
        // canonical `store_local` directly.
        self.pending_local_init_ast = self.ast_acc;
        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
            self.emit_op(Op::Mcpy);
            self.emit_val(self.size_of_type(ty) as i64);
        } else if (ty & !UNSIGNED_BIT) == Ty::Char as i64 {
            self.emit_op(Op::Sc);
        } else if (ty & !UNSIGNED_BIT) == Ty::Float as i64 {
            // `float`-typed local: narrow the accumulator (an f64
            // bit pattern from the RHS) to single-precision and
            // store 4 bytes. The slot reserved by
            // `local_storage_slots` is still an 8-byte c5 stack
            // word, so the upper 4 bytes stay whatever they were;
            // the matching `Op::Lf` reads only the low 4 and
            // widens them back to f64.
            self.emit_op(Op::Sf);
        } else {
            // Local int / long / pointer: the slot is a full c5
            // stack word (8 bytes), so a single `Si` writes the
            // whole slot. The narrower-width `Sw` would only
            // write the low 4 bytes and leave the high half as
            // whatever was in the slot, which would surface on
            // a later 8-byte Li -- but no caller of this helper
            // re-reads via Li, so the wide store is fine and the
            // existing optimizer recognises Si patterns.
            self.emit_op(Op::Si);
        }
        Ok(())
    }

    /// Peek tokens from the current position (just past an
    /// already-consumed `(`) up to the matching `)`; returns true
    /// if any FloatNum literal appears inside. Used by the
    /// initializer paren branch to decide between the integer
    /// constant evaluator and the f64 folder. Snapshots /
    /// restores the lexer so the caller's position is unchanged.
    fn contents_until_close_paren_have_float(&mut self) -> Result<bool, C5Error> {
        let snap = self.lex.snapshot();
        let mut depth: i64 = 1;
        let mut has_float = false;
        while depth > 0 && self.lex.tk != 0 {
            if self.lex.tk == '(' {
                depth += 1;
            } else if self.lex.tk == ')' {
                depth -= 1;
                if depth == 0 {
                    break;
                }
            } else if self.lex.tk == Token::FloatNum {
                has_float = true;
                break;
            }
            self.next()?;
        }
        self.lex.restore(snap);
        Ok(has_float)
    }

    /// True when `self.lex.tk` is `+ / - / * / /` -- the binary
    /// float operators the constant-initializer evaluator
    /// recognises. Whitespace-only check; doesn't consume.
    fn tk_is_float_arith_op(&self) -> bool {
        self.lex.tk == Token::AddOp
            || self.lex.tk == Token::SubOp
            || self.lex.tk == Token::MulOp
            || self.lex.tk == Token::DivOp
    }

    /// Continue an in-flight float constant expression from a
    /// seed `left` value. Used by `parse_constant_init_value`
    /// after it consumed a leading `FloatNum` and noticed an
    /// arithmetic operator next: the caller hands the already-
    /// loaded value here and we drive the remaining `+ / - / *
    /// / /` operators at the standard C precedences. Mixed
    /// integer literals are widened to `f64`.
    /// Entry point for callers that don't have an already-loaded
    /// seed: read a float-typed constant expression starting from
    /// the current token. Used by `parse_global_initializer` to
    /// fold `static float x = 1.0f / 2.2f;` at parse time.
    pub(super) fn parse_const_float_expr(&mut self) -> Result<f64, C5Error> {
        let seed = self.parse_const_float_unary()?;
        self.parse_const_float_add_from(seed)
    }

    /// Public wrapper around `contents_until_close_paren_have_float`
    /// so `global_init.rs` can use the same peek when deciding
    /// between integer and float constant evaluators for a
    /// parenthesised initializer.
    pub(super) fn contents_until_close_paren_have_float_pub(&mut self) -> Result<bool, C5Error> {
        self.contents_until_close_paren_have_float()
    }

    fn parse_const_float_add_from(&mut self, left: f64) -> Result<f64, C5Error> {
        let mut acc = self.parse_const_float_mul_from(left)?;
        loop {
            if self.lex.tk == Token::AddOp {
                self.next()?;
                let seed = self.parse_const_float_unary()?;
                let r = self.parse_const_float_mul_from(seed)?;
                acc += r;
            } else if self.lex.tk == Token::SubOp {
                self.next()?;
                let seed = self.parse_const_float_unary()?;
                let r = self.parse_const_float_mul_from(seed)?;
                acc -= r;
            } else {
                break;
            }
        }
        Ok(acc)
    }

    /// Continue a mul/div chain from a seed `left` value. Same
    /// helper shape as `parse_const_float_add_from`; consumes
    /// the current `* / /` operators and stops at the first
    /// lower-precedence token.
    fn parse_const_float_mul_from(&mut self, mut acc: f64) -> Result<f64, C5Error> {
        loop {
            if self.lex.tk == Token::MulOp {
                self.next()?;
                let r = self.parse_const_float_unary()?;
                acc *= r;
            } else if self.lex.tk == Token::DivOp {
                self.next()?;
                let r = self.parse_const_float_unary()?;
                if r == 0.0 {
                    return Err(self.compile_err("division by zero in constant float expression"));
                }
                acc /= r;
            } else {
                break;
            }
        }
        Ok(acc)
    }

    fn parse_const_float_unary(&mut self) -> Result<f64, C5Error> {
        if self.lex.tk == Token::SubOp {
            self.next()?;
            return Ok(-self.parse_const_float_unary()?);
        }
        if self.lex.tk == Token::AddOp {
            self.next()?;
            return self.parse_const_float_unary();
        }
        self.parse_const_float_primary()
    }

    fn parse_const_float_primary(&mut self) -> Result<f64, C5Error> {
        if self.lex.tk == '(' {
            self.next()?;
            // C-style cast in a constant float expression:
            // `(float)EXPR` / `(double)EXPR`. C99 6.5.4 allows the
            // operand of a cast in a constant expression; we
            // recognise the form so the surrounding constant
            // folder treats it as a pin on the result width.
            // Pointer / non-arithmetic types in this position
            // would be a type error.
            if self.lex_is_type_start() {
                let _ = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp || self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
                if self.lex.tk != ')' {
                    return Err(self.compile_err(
                        "close paren expected after cast in constant float expression",
                    ));
                }
                self.next()?;
                return self.parse_const_float_unary();
            }
            // Parenthesized sub-expression: recurse at the top of
            // the precedence chain so a fully-nested `(a + b) * c`
            // parses associativity-correctly.
            let inner_left = self.parse_const_float_unary()?;
            let v = self.parse_const_float_add_from(inner_left)?;
            if self.lex.tk != ')' {
                return Err(self.compile_err("close paren expected in constant float expression"));
            }
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::FloatNum {
            let v = f64::from_bits(self.lex.ival as u64);
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::Num {
            // Integer literal in a float context -- promote to
            // f64. The runtime conversion is exact for values
            // that fit a double's mantissa (the only ones c5
            // accepts as constant integers anyway).
            let v = self.lex.ival as f64;
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::Id && self.symbols[self.lex.curr_id_idx].class == Token::Num as i64
        {
            // `#define`d integer constants and enum values used
            // inside a float initializer (rare but legal). C99
            // 6.6 lets a constant expression include any value
            // that's a compile-time constant of arithmetic type.
            let v = self.symbols[self.lex.curr_id_idx].val as f64;
            self.next()?;
            return Ok(v);
        }
        Err(self.compile_err(format!(
            "constant float expression expected (got {})",
            super::super::token::describe(self.lex.tk)
        )))
    }
}

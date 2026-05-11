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
use super::types::{UNSIGNED_BIT, is_struct_ty, struct_id_of, struct_ptr_depth};
use super::{Compiler, InitElemReloc};

impl Compiler {
    /// Push the relocation entry that an initializer element needs
    /// at byte offset `here` within `self.data`.
    ///   * `None`        -- plain integer constant, no entry.
    ///   * `Data`        -- data-segment offset, push a DataReloc
    ///                      so the per-format writer can patch the
    ///                      slot to the runtime address.
    ///   * `Code(sym)`   -- function bytecode PC, push a CodeReloc
    ///                      and stash the symbol index for the
    ///                      post-body fixup pass.
    fn push_init_reloc(&mut self, here: usize, value: i64, reloc: InitElemReloc) {
        match reloc {
            InitElemReloc::None | InitElemReloc::Float64Bits => {}
            InitElemReloc::Data => {
                self.data_relocs.push(crate::c5::program::DataReloc {
                    data_offset: here as u64,
                    target_offset: value as u64,
                });
            }
            InitElemReloc::Code(sym_idx) => {
                self.code_relocs.push(crate::c5::program::CodeReloc {
                    data_offset: here as u64,
                    target_bc_pc: value as u64,
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
        let is_fp = stripped == Ty::Float as i64 || stripped == Ty::Double as i64;
        if !is_fp {
            return value;
        }
        match reloc {
            InitElemReloc::Float64Bits => value,
            InitElemReloc::None => (value as f64).to_bits() as i64,
            // Data / Code relocs land in pointer-typed slots, not
            // FP slots; the upstream paths reject the type mix
            // before reaching here.
            _ => value,
        }
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
        // fewer than M values gets zero-padded; without padding,
        // subsequent rows shift into the previous row's tail and
        // `xs[i][j]` reads garbage. stb_perlin's
        //   static float basis[12][4] = { {1,1,0}, {-1,1,0}, ... };
        // hit this. Read-and-clear so a recursive call into an
        // inner brace doesn't inherit it.
        let inner_dim = core::mem::take(&mut self.pending_init_inner_dim);
        if self.lex.tk == '"' as i64 && (elem_ty & !UNSIGNED_BIT) == Ty::Char as i64 {
            let start_addr = self.lex.ival as usize;
            self.next()?;
            while self.lex.tk == '"' as i64 {
                self.next()?;
            }
            self.data.push(0);
            let elems: Vec<(i64, InitElemReloc)> = self.data[start_addr..]
                .iter()
                .map(|&b| (b as i64, InitElemReloc::None))
                .collect();
            return Ok(elems);
        }
        if self.lex.tk != '{' as i64 {
            return Err(
                self.compile_err("array initializer must be a string literal or `{{ ... }}`")
            );
        }
        self.next()?;
        let mut elements = Vec::new();
        while self.lex.tk != '}' as i64 {
            // Nested brace list (multi-dim array): `{ {1,2}, {3,4}, ... }`.
            // c5's array-symbol storage carries a single flat
            // dimension, so we flatten the rows by recursing and
            // concatenating element vectors. When `inner_dim > 0`
            // the caller has told us the row width, so a short
            // inner list gets padded with zero-valued elements
            // before the next row starts.
            if self.lex.tk == '{' as i64 {
                let before = elements.len();
                let mut inner = self.collect_array_initializer(elem_ty)?;
                elements.append(&mut inner);
                if inner_dim > 0 {
                    let written = (elements.len() - before) as i64;
                    if written < inner_dim {
                        for _ in 0..(inner_dim - written) {
                            elements.push((0, InitElemReloc::None));
                        }
                    }
                }
                if self.lex.tk == ',' as i64 {
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
            elements.push((value, reloc));
            if self.lex.tk == ',' as i64 {
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
        // Float literal -- store the f64 bit pattern. The struct
        // field's declared type drives the runtime interpretation;
        // the on-disk image is just bytes.
        //
        // If a binary float operator follows (`+ - * /`), fold the
        // whole expression in `f64` precision -- stb_image_write's
        // `aasf[]` table declares each element as
        // `1.387039845f * 2.828427125f` etc., which the integer
        // const-expr evaluator can't traverse.
        if self.lex.tk == Token::FloatNum as i64 {
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
        // stb_sprintf's `stbsp__negboterr[]` array leads every row
        // with `-d.dddd...e+NNN`; without this branch the whole
        // TU rejects on the first negative element.
        if self.lex.tk == Token::SubOp as i64 && self.lex.peek_after_whitespace_starts_digit() {
            self.next()?; // consume `-`
            if self.lex.tk == Token::FloatNum as i64 {
                let bits = (self.lex.ival as u64) ^ (1u64 << 63);
                self.next()?;
                if self.tk_is_float_arith_op() {
                    let folded = self.parse_const_float_add_from(f64::from_bits(bits))?;
                    return Ok((folded.to_bits() as i64, InitElemReloc::Float64Bits));
                }
                return Ok((bits as i64, InitElemReloc::Float64Bits));
            }
            if self.lex.tk == Token::Num as i64 {
                let v = -self.lex.ival;
                self.next()?;
                return Ok((v, InitElemReloc::None));
            }
            // peek said "digit next", so the lexer must have
            // produced a numeric token. Anything else is a bug.
            return Err(self.compile_err(format!(
                "expected numeric literal after `-` in initializer (got tk={})",
                self.lex.tk
            )));
        }
        // `(type)expr` cast or `(expr)` parenthesized constant in a
        // static initializer. After consuming `(`, peek the next
        // token: if it starts a type, treat as a cast and recurse on
        // the value (c5's i64-shaped representation makes integer /
        // pointer casts no-ops). Otherwise it's a parenthesized
        // constant expression -- evaluate it and expect `)`.
        if self.lex.tk == '(' as i64 {
            // Cast / float-content detection both need to look
            // past the `(`. Snapshot so we can rewind for the
            // integer-expression fall-through, which has to see
            // `(` to absorb both the parenthesised sub-expression
            // *and* any trailing operators -- stb_image_resize2's
            //   static const stbir__FP32 minval = { (127-13) << 23 };
            // needs `parse_const_expr_or` to start outside the
            // parens so the `<< 23` after `)` joins the chain.
            let snap = self.lex.snapshot();
            self.next()?;
            if self.lex_is_type_start() {
                let _ = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp as i64 || self.lex.tk == Token::TypeQual as i64 {
                    self.next()?;
                }
                // Optional function-pointer abstract declarator
                // `(*)(args)` after the base type. Same treatment
                // as in the expression-level cast handler: scan
                // counted parens until the cast's outer `)`,
                // then skip the trailing `(args)` arg-list shape.
                if self.lex.tk == '(' as i64 {
                    let mut depth: i64 = 1;
                    self.next()?;
                    while depth > 0 && self.lex.tk != 0 {
                        if self.lex.tk == '(' as i64 {
                            depth += 1;
                        } else if self.lex.tk == ')' as i64 {
                            depth -= 1;
                            if depth == 0 {
                                self.next()?;
                                break;
                            }
                        }
                        self.next()?;
                    }
                    if self.lex.tk == '(' as i64 {
                        self.next()?;
                        self.skip_balanced_parens_after_open()?;
                    }
                }
                if self.lex.tk != ')' as i64 {
                    return Err(self.compile_err("close paren expected after cast in initializer"));
                }
                self.next()?;
                return self.parse_constant_init_value();
            }
            // Sub-expression in parens. Peek for any FloatNum
            // token inside (up to the matching `)`); if present,
            // fold the whole sub-expression in f64 precision so
            // shapes like `(1.0f + 2.0f) * 4.0f` from
            // stb_image_write's `aasf[]` round-trip exactly.
            // Pure-integer parens fall through to the integer
            // expression evaluator below so trailing `<<`, `+`,
            // ... operators after `)` are absorbed too.
            if self.contents_until_close_paren_have_float()? {
                let seed = self.parse_const_float_unary()?;
                let v = self.parse_const_float_add_from(seed)?;
                if self.lex.tk != ')' as i64 {
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
            // Rewind so the integer evaluator below absorbs the
            // whole `(expr) op rhs` chain as one expression.
            self.lex.restore(snap);
            let v = self.parse_constant_int()?;
            return Ok((v, InitElemReloc::None));
        }
        if self.lex.tk == '"' as i64 {
            let addr = self.lex.ival;
            self.next()?;
            while self.lex.tk == '"' as i64 {
                self.next()?;
            }
            self.data.push(0);
            return Ok((addr, InitElemReloc::Data));
        }
        if self.lex.tk == Token::AndOp as i64 {
            // `&global` -- address-of-global pointer init.
            self.next()?;
            if self.lex.tk != Token::Id as i64 {
                return Err(self.compile_err("identifier expected after `&` in initializer"));
            }
            let target_idx = self.lex.curr_id_idx;
            let class = self.symbols[target_idx].class;
            if class != Token::Glo as i64 {
                return Err(self.compile_err(format!(
                    "`&{}` -- only addresses of globals are accepted in static initializers",
                    self.symbols[target_idx].name
                )));
            }
            let off = self.symbols[target_idx].val;
            self.next()?;
            return Ok((off, InitElemReloc::Data));
        }
        if self.lex.tk == Token::Id as i64 {
            let idx = self.lex.curr_id_idx;
            let class = self.symbols[idx].class;
            // Forward-referenced function pointer in a static
            // initializer: dispatch tables that list functions
            // defined later in the same TU. The post-parse
            // `apply_fn_call_fixups` pass already resolves
            // `target_bc_pc` from each symbol's final `val`, so
            // we bind the identifier as `Token::Fun` with val=0
            // here and let the fixup pass patch both the data
            // bytes and the CodeReloc entry once the body has
            // been emitted. The forward-ref heuristic only
            // fires when the next token is `,` / `}` -- i.e.,
            // the identifier is the entire init slot, not the
            // start of an expression that happens to use an
            // undeclared name.
            if class == 0
                && (self.lex.peek_after_whitespace(b',') || self.lex.peek_after_whitespace(b'}'))
            {
                self.symbols[idx].class = Token::Fun as i64;
                self.symbols[idx].type_ = Ty::Int as i64;
                self.next()?;
                return Ok((0, InitElemReloc::Code(idx)));
            }
            if class == Token::Fun as i64 {
                let bc_pc = self.symbols[idx].val;
                self.next()?;
                return Ok((bc_pc, InitElemReloc::Code(idx)));
            }
            if class == Token::Num as i64 {
                let v = self.symbols[idx].val;
                self.next()?;
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
                // `.val` holds the trampoline's `bc_pc` once
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
                // to-pointer conversion). Used by
                // stb_voxel_render's `stbvox_uniform_info[]` table
                // to point at row 0 of 2D / 3D dummy arrays.
                //
                // c5 only tracks `inner_array_size` (the second
                // dim of `T name[A][B]`), so for the third index
                // of a 3D `T name[A][B][C]` we don't have a stride
                // to multiply by. The common static-init shape is
                // `arr[0][0]` which only matters as the base
                // address; we accept further `[0]` postfixes
                // without error and reject `[non-zero]` past the
                // second index.
                let mut depth: usize = 0;
                while self.lex.tk == Token::Brak as i64 {
                    self.next()?;
                    let n = self.parse_constant_int()?;
                    if self.lex.tk != ']' as i64 {
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
                return Ok((off, InitElemReloc::Data));
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
        if self.lex.tk != '{' as i64 {
            return Err(self.compile_err("struct initializer must start with `{{`"));
        }
        self.next()?;
        let mut pos: usize = 0;
        while self.lex.tk != '}' as i64 {
            // Designator?
            let field_idx = if self.lex.tk == Token::Dot as i64 {
                self.next()?;
                if self.lex.tk != Token::Id as i64 {
                    return Err(self.compile_err("field name expected after `.`"));
                }
                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                if self.lex.tk != Token::Assign as i64 {
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
                && self.lex.tk == '"' as i64
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
                while self.lex.tk == '"' as i64 {
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
            } else if field.array_size > 0 && self.lex.tk == '{' as i64 {
                self.next()?;
                let elem_size = self.size_of_type(field.ty);
                let mut idx: usize = 0;
                while self.lex.tk != '}' as i64 {
                    if idx as i64 >= field.array_size {
                        return Err(self.compile_err(format!(
                            "too many initializers for `{}.{}`",
                            self.structs[struct_id].name, field.name
                        )));
                    }
                    let (value, reloc) = self.parse_constant_init_value()?;
                    let here = field_base + idx * elem_size;
                    self.write_init_value(here, elem_size, value, reloc);
                    idx += 1;
                    if self.lex.tk == ',' as i64 {
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
                // following `,`. stb_easy_font's
                //   stb_easy_font_color c = { 255,255,255,255 };
                // (where the struct's sole field is `unsigned char
                // c[4]`) lands here.
                let elem_size = self.size_of_type(field.ty);
                let mut idx: usize = 0;
                while (idx as i64) < field.array_size && self.lex.tk != '}' as i64 {
                    let (value, reloc) = self.parse_constant_init_value()?;
                    let here = field_base + idx * elem_size;
                    self.write_init_value(here, elem_size, value, reloc);
                    idx += 1;
                    if idx as i64 >= field.array_size {
                        break;
                    }
                    if self.lex.tk == ',' as i64 {
                        self.next()?;
                    } else {
                        break;
                    }
                }
            } else if is_struct_ty(field.ty)
                && struct_ptr_depth(field.ty) == 0
                && self.lex.tk == '{' as i64
            {
                let nested_sid = struct_id_of(field.ty);
                self.collect_struct_initializer(nested_sid, field_base as i64)?;
            } else {
                let (value, reloc) = self.parse_constant_init_value()?;
                let field_size = self.size_of_type(field.ty);
                self.write_init_value(field_base, field_size, value, reloc);
            }
            pos = field_idx + 1;
            if self.lex.tk == ',' as i64 {
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
    }

    /// Emit the store sequence for a local-variable initializer:
    ///   Lea local_val ; Psh ; <init expr> ; Si | Sc | Mcpy
    /// On entry `tk` is positioned just past the `=`; on exit it
    /// is at the comma or semicolon following the initializer.
    pub(super) fn emit_local_init_store(&mut self, local_val: i64, ty: i64) -> Result<(), C5Error> {
        self.emit_lea(local_val);
        self.emit_op(Op::Psh);
        self.expr(Token::Assign as i64)?;
        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
            self.emit_op(Op::Mcpy);
            self.emit_val(self.size_of_type(ty) as i64);
        } else if (ty & !UNSIGNED_BIT) == Ty::Char as i64 {
            self.emit_op(Op::Sc);
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
            if self.lex.tk == '(' as i64 {
                depth += 1;
            } else if self.lex.tk == ')' as i64 {
                depth -= 1;
                if depth == 0 {
                    break;
                }
            } else if self.lex.tk == Token::FloatNum as i64 {
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
        self.lex.tk == Token::AddOp as i64
            || self.lex.tk == Token::SubOp as i64
            || self.lex.tk == Token::MulOp as i64
            || self.lex.tk == Token::DivOp as i64
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
            if self.lex.tk == Token::AddOp as i64 {
                self.next()?;
                let seed = self.parse_const_float_unary()?;
                let r = self.parse_const_float_mul_from(seed)?;
                acc += r;
            } else if self.lex.tk == Token::SubOp as i64 {
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
            if self.lex.tk == Token::MulOp as i64 {
                self.next()?;
                let r = self.parse_const_float_unary()?;
                acc *= r;
            } else if self.lex.tk == Token::DivOp as i64 {
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
        if self.lex.tk == Token::SubOp as i64 {
            self.next()?;
            return Ok(-self.parse_const_float_unary()?);
        }
        if self.lex.tk == Token::AddOp as i64 {
            self.next()?;
            return self.parse_const_float_unary();
        }
        self.parse_const_float_primary()
    }

    fn parse_const_float_primary(&mut self) -> Result<f64, C5Error> {
        if self.lex.tk == '(' as i64 {
            self.next()?;
            // C-style cast in a constant float expression:
            // `(float)EXPR` / `(double)EXPR`. Recognised so
            // stb sources that pin the result width explicitly
            // still fold. Pointer / non-arithmetic types in
            // this position would be a type error.
            if self.lex_is_type_start() {
                let _ = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp as i64 || self.lex.tk == Token::TypeQual as i64 {
                    self.next()?;
                }
                if self.lex.tk != ')' as i64 {
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
            if self.lex.tk != ')' as i64 {
                return Err(self.compile_err("close paren expected in constant float expression"));
            }
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::FloatNum as i64 {
            let v = f64::from_bits(self.lex.ival as u64);
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::Num as i64 {
            // Integer literal in a float context -- promote to
            // f64. The runtime conversion is exact for values
            // that fit a double's mantissa (the only ones c5
            // accepts as constant integers anyway).
            let v = self.lex.ival as f64;
            self.next()?;
            return Ok(v);
        }
        if self.lex.tk == Token::Id as i64
            && self.symbols[self.lex.curr_id_idx].class == Token::Num as i64
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
            "constant float expression expected (got tk={})",
            self.lex.tk
        )))
    }
}

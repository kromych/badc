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
//!   build the AST shape that drives array / scalar local
//!   initialisers into their stack slot at runtime.
//!
//! Lives next to `compiler/mod.rs` because the cluster only made
//! sense as a unit once `collect_struct_initializer` started
//! recursing into `collect_array_initializer` for `T arr[N]`-shaped
//! struct fields. Splitting it out cuts ~500 lines from mod.rs's
//! tail without changing any caller.

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::const_expr::ConstVal;
use super::types::{
    UNSIGNED_BIT, VOLATILE_BIT, is_pointer_ty, is_struct_ty, is_unsigned_ty, struct_id_of,
    struct_ptr_depth,
};

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

/// Where an initializer engine writes its leaves. The aggregate
/// walk (field / element traversal, designators, brace elision,
/// anonymous-group descent) is identical for both; only the leaf
/// store and value parse differ, so the walk is written once and
/// parameterized by this target.
///
/// `base` is the aggregate's own start: an absolute `self.data`
/// index for `Data`, a byte offset relative to `local_val` for
/// `Runtime`. A leaf at `base + field.offset` is therefore a data
/// index or a local-relative offset respectively.
#[derive(Clone, Copy)]
pub(super) enum InitTarget {
    /// Stage constant bytes into `self.data` (file-scope, `static`,
    /// and the constant-local fast path that later `Mcpy`s the blob).
    Data { base: usize },
    /// Emit runtime store elements at `local_val + offset` for a
    /// stack local whose initializer is not all compile-time constant.
    Runtime { local_val: i64, base: i64 },
}

impl InitTarget {
    /// The aggregate's start offset (data index for `Data`,
    /// local-relative for `Runtime`).
    fn base(self) -> i64 {
        match self {
            InitTarget::Data { base } => base as i64,
            InitTarget::Runtime { base, .. } => base,
        }
    }

    /// Same kind, re-based to `new_base` for descent into a member /
    /// element sub-object at that offset.
    fn rebased(self, new_base: i64) -> InitTarget {
        match self {
            InitTarget::Data { .. } => InitTarget::Data {
                base: new_base as usize,
            },
            InitTarget::Runtime { local_val, .. } => InitTarget::Runtime {
                local_val,
                base: new_base,
            },
        }
    }

    fn is_runtime(self) -> bool {
        matches!(self, InitTarget::Runtime { .. })
    }
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
                // A target defined in another unit (`extern T x;` with no
                // definition here) resolves by name at link time, not
                // against this unit's `.data`. The scalar `T *p = &x;`
                // path routes through `extern_data_relocs`; a `&x` inside
                // a brace-list / struct initializer reaches here and must
                // do the same, otherwise the reloc lands on the extern's
                // permissive local fallback slot instead of the defining
                // unit's object.
                if let Some(sym_idx) = src_sym {
                    let t = &self.symbols[sym_idx];
                    let is_extern_data = t.is_extern_decl
                        && t.linkage == crate::c5::symbol::Linkage::External
                        && !t.has_initializer;
                    if is_extern_data {
                        let name = t.name.clone();
                        let addend = value - self.symbols[sym_idx].val;
                        self.symbols[sym_idx].was_referenced = true;
                        self.extern_data_relocs
                            .push(crate::c5::program::ExternDataReloc {
                                data_offset: here as u64,
                                symbol_name: name,
                                addend,
                            });
                        return;
                    }
                }
                let anchor = match src_sym {
                    Some(sym_idx) => self.symbols[sym_idx].val,
                    None => value,
                };
                self.data_relocs.push(crate::c5::program::DataReloc {
                    data_offset: here as u64,
                    target_offset: value as u64,
                    target_anchor: anchor as u64,
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

    /// Drop any initializer relocation already recorded in the byte range
    /// `[lo, hi)`. A later designator for the same subobject (`[N].p = q`
    /// after a range fill already wrote `[N].p`) overwrites the bytes; the
    /// stale relocation must go too, or both apply and corrupt the slot.
    fn clear_init_relocs_in(&mut self, lo: usize, hi: usize) {
        let (lo, hi) = (lo as u64, hi as u64);
        let hit = |off: u64| off >= lo && off < hi;
        if self.code_relocs.iter().any(|r| hit(r.data_offset)) {
            let keep: alloc::vec::Vec<bool> = self
                .code_relocs
                .iter()
                .map(|r| !hit(r.data_offset))
                .collect();
            let mut it = keep.iter();
            self.code_relocs.retain(|_| *it.next().unwrap());
            let mut it = keep.iter();
            self.code_reloc_sym_idx.retain(|_| *it.next().unwrap());
        }
        if self.data_relocs.iter().any(|r| hit(r.data_offset)) {
            let keep: alloc::vec::Vec<bool> = self
                .data_relocs
                .iter()
                .map(|r| !hit(r.data_offset))
                .collect();
            let mut it = keep.iter();
            self.data_relocs.retain(|_| *it.next().unwrap());
            let mut it = keep.iter();
            self.data_reloc_sym_idx.retain(|_| *it.next().unwrap());
        }
        self.extern_data_relocs.retain(|r| !hit(r.data_offset));
    }

    /// C99 6.4.2.2 predefined identifier `__func__` (with the GCC
    /// `__FUNCTION__` / `__PRETTY_FUNCTION__` aliases), valid only inside a
    /// function body. The cursor must be on the identifier token.
    pub(super) fn is_func_name_ident(&self) -> bool {
        self.lex.tk == Token::Id
            && !self.current_function_name.is_empty()
            && matches!(
                self.symbols[self.lex.curr_id_idx].name.as_str(),
                "__func__" | "__FUNCTION__" | "__PRETTY_FUNCTION__"
            )
    }

    /// Materialise the enclosing function's name as the bytes of an implicit
    /// `static const char[]` (C99 6.4.2.2) in the data segment and return the
    /// offset of the first byte. The caller advances past the identifier.
    pub(super) fn intern_func_name(&mut self) -> i64 {
        let offset = self.data.len() as i64;
        let name = self.current_function_name.clone();
        self.data.extend_from_slice(name.as_bytes());
        self.data.push(0);
        self.data_object_starts.push(offset);
        offset
    }

    /// Convert an initializer element's `(value, reloc)` to the
    /// bit pattern that should land in the data segment for an
    /// element of type `elem_ty`:
    ///   * `Float64Bits` value in a `double` element -- pass through.
    ///   * `Float64Bits` value in a `float` element -- narrow to the
    ///     f32 pattern (in the low 32 bits) so a 4-byte load reads the
    ///     right value.
    ///   * Plain integer constant in a float/double element --
    ///     convert int -> the floating bit pattern so e.g.
    ///     `static float a[] = { 1 }` ends up as the bits of `1.0f`,
    ///     not `0x0000000000000001`.
    /// Non-FP elem types and FP values destined for pointer
    /// slots (Data / Code relocs) pass through unchanged. Callers
    /// write `size_of_type(elem_ty)` low bytes of the result.
    pub(super) fn to_storage_bits(&self, value: i64, reloc: InitElemReloc, elem_ty: i64) -> i64 {
        let stripped = elem_ty & !(UNSIGNED_BIT | VOLATILE_BIT);
        let is_float = stripped == Ty::Float as i64;
        let is_double = stripped == Ty::Double as i64;
        if !is_float && !is_double {
            // A floating constant initializing an integer element
            // converts to the integer value (C99 6.3.1.4, truncation
            // toward zero); without this the raw IEEE-754 bit pattern
            // would land in the slot (e.g. `int a[] = {1.5}` -> 0).
            if matches!(reloc, InitElemReloc::Float64Bits) {
                return f64::from_bits(value as u64) as i64;
            }
            return value;
        }
        // Compute the canonical f64 bit pattern from the source
        // value first, then narrow to f32 for the `Ty::Float` case.
        // The 4-byte single-precision storage slot can only hold the
        // narrowed bits. A direct truncation of the f64 pattern would
        // zero out the entire low mantissa for any non-tiny value,
        // e.g. `1.0` -> `0x3FF0_0000_0000_0000` -> low 4 bytes =
        // `0x0000_0000` = `+0.0f`, collapsing every non-zero entry of
        // a `static float arr[N] = { 1.0f, ... }` initializer.
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
        // `value` carries at most 8 significant bytes; zero a wider
        // destination's tail rather than wrapping the shift count.
        for i in 0..n_bytes {
            self.data[here + i] = if i < 8 { (value >> (i * 8)) as u8 } else { 0 };
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
    /// Consume the closing `}` (and an optional trailing comma) of a
    /// brace-wrapped string-literal array initializer (`{"abc"}`).
    fn expect_close_brace_after_wrapped_string(&mut self) -> Result<(), C5Error> {
        self.accept(',')?;
        if self.lex.tk != '}' {
            return Err(self.compile_err("`}` expected after brace-wrapped string initializer"));
        }
        self.next()?;
        Ok(())
    }

    /// Consume `depth` closing parentheses after a parenthesized string
    /// literal initializer (`char x[] = ("abc")`).
    fn expect_close_parens(&mut self, depth: usize) -> Result<(), C5Error> {
        for _ in 0..depth {
            if self.lex.tk != ')' {
                return Err(
                    self.compile_err("`)` expected to close a parenthesized string initializer")
                );
            }
            self.next()?;
        }
        Ok(())
    }

    pub(super) fn collect_array_initializer(
        &mut self,
        elem_ty: i64,
    ) -> Result<Vec<(i64, InitElemReloc)>, C5Error> {
        self.with_nesting("initializer", |c| {
            c.collect_array_initializer_inner(elem_ty)
        })
    }

    fn collect_array_initializer_inner(
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
        let inner_dims = core::mem::take(&mut self.pending.init_inner_dims);
        // Scalars each nested brace at this level spans: the product of
        // the dimensions below it. The empty product is 1, which is
        // also the designator scale for the innermost (scalar) level.
        let child_span: usize = inner_dims.iter().map(|&d| d as usize).product();
        let target_size = core::mem::take(&mut self.pending.init_target_array_size);
        // C99 6.7.8p14: a string-literal initializer for a character
        // array may be enclosed in braces (`char x[] = {"abc"}`).
        // Unwrap a single brace whose first token is a string literal so
        // the string paths below see the literal directly; the closing
        // `}` is consumed before each returns. A non-string brace list
        // is left untouched (the speculative `{` is restored).
        let mut brace_wrapped = false;
        if self.lex.tk == '{' {
            let snap = self.lex.snapshot();
            // Lexing the inner string token appends its bytes to the
            // data segment; restore the data length too so the
            // speculative peek leaves no orphaned literal behind.
            let data_snap = self.data.len();
            self.next()?;
            // Only a one-dimensional character array (narrow string) or
            // `wchar_t` array (wide string) takes a brace-wrapped
            // string. A pointer array (`char *names[] = {"a", "b"}`) or
            // a multi-dimensional char array (`char c[2][6] = {"a",
            // "b"}`, one string per row) has a string as its first
            // element and must stay a brace list.
            let is_char_array = (elem_ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64;
            if inner_dims.is_empty()
                && self.lex.tk == '"'
                && (self.lex.str_is_wide || is_char_array)
            {
                brace_wrapped = true;
            } else {
                self.lex.restore(snap);
                self.data.truncate(data_snap);
            }
        }
        // A string-literal array initializer may be parenthesized
        // (`char x[] = ("abc")`, the form a macro produces). Skip the
        // leading `(` so the string paths below see the literal; the
        // matching `)`s are consumed before each return.
        let mut paren_depth = 0usize;
        if inner_dims.is_empty() && self.lex.tk == '(' {
            let snap = self.lex.snapshot();
            let data_snap = self.data.len();
            let mut depth = 0usize;
            while self.lex.tk == '(' {
                depth += 1;
                self.next()?;
            }
            let is_char_array = (elem_ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64;
            if self.lex.tk == '"' && (self.lex.str_is_wide || is_char_array) {
                paren_depth = depth;
            } else {
                self.lex.restore(snap);
                self.data.truncate(data_snap);
            }
        }
        if self.lex.tk == '"' && self.lex.str_is_wide {
            // C99 6.4.5 / 6.7.8p14: a wide string literal initializes a
            // `wchar_t`-shaped array. The lexer stored one code point
            // per element plus a terminator at the target's `wchar_t`
            // width; read them back at that stride.
            let w = self.lex.wchar_bytes;
            let start_addr = self.take_concat_string_literal()?;
            let byte_count = self.data.len() - start_addr;
            let mut elem_count = byte_count / w;
            // The trailing NUL is dropped when the literal exactly fills
            // a bounded array (the array holds the characters and nothing
            // else); the lexer pushed it unconditionally, so trim it here.
            if elem_count > 0 {
                let chars = elem_count - 1;
                let store_nul = target_size <= 0 || chars < target_size as usize;
                if !store_nul {
                    elem_count -= 1;
                    self.data.truncate(start_addr + elem_count * w);
                }
            }
            let elems: Vec<(i64, InitElemReloc)> = (0..elem_count)
                .map(|k| {
                    let base = start_addr + k * w;
                    let mut v: i64 = 0;
                    for b in 0..w {
                        v |= (self.data[base + b] as i64) << (b * 8);
                    }
                    (v, InitElemReloc::None)
                })
                .collect();
            if brace_wrapped {
                self.expect_close_brace_after_wrapped_string()?;
            }
            self.expect_close_parens(paren_depth)?;
            return Ok(elems);
        }
        if self.lex.tk == '"' && (elem_ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64 {
            let start_addr = self.take_concat_string_literal()?;
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
            if brace_wrapped {
                self.expect_close_brace_after_wrapped_string()?;
            }
            self.expect_close_parens(paren_depth)?;
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
        // Set by a GCC range designator `[a ... b] = value` to the
        // one-past-the-last scalar index the next value fills.
        let mut desig_range_end: Option<usize> = None;
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
                // GCC range designator `[a ... b] = value`: fill every
                // sub-array in `[a, b]` with the value.
                let mut hi = n;
                if self.lex.tk == Token::Ellipsis {
                    self.next()?;
                    hi = self.parse_constant_int()?;
                    if hi < n {
                        return Err(self.compile_err(format!(
                            "array range designator high {hi} below low {n}"
                        )));
                    }
                }
                if self.lex.tk != ']' {
                    return Err(self.compile_err("`]` expected after array designator index"));
                }
                self.next()?;
                if self.lex.tk != Token::Assign {
                    return Err(self.compile_err("`=` expected after `[N]` designator"));
                }
                self.next()?;
                // A designator names the N-th sub-array at this level,
                // which spans `child_span` scalars (1 at the innermost
                // level).
                cursor = n as usize * child_span.max(1);
                desig_range_end = if hi > n {
                    Some((hi as usize + 1) * child_span.max(1))
                } else {
                    None
                };
            }
            // Nested brace list (multi-dim array): `{ {1,2}, {3,4}, ... }`.
            // c5's array-symbol storage carries a single flat
            // dimension, so the rows are flattened by recursing and
            // concatenating element vectors. The nested list is padded
            // to `child_span` (the scalar count its sub-array spans) so
            // a short list keeps subsequent sub-arrays on the right
            // stride; the recursion receives the dimensions below the
            // current level.
            if self.lex.tk == '{' {
                let before = cursor;
                self.pending.init_inner_dims = if inner_dims.is_empty() {
                    alloc::vec::Vec::new()
                } else {
                    inner_dims[1..].to_vec()
                };
                let inner = self.collect_array_initializer(elem_ty)?;
                let written = inner.len();
                if elements.len() < before + written {
                    elements.resize(before + written, (0, InitElemReloc::None));
                }
                for (i, entry) in inner.into_iter().enumerate() {
                    elements[before + i] = entry;
                }
                cursor = before + written;
                if child_span > written {
                    let pad = child_span - written;
                    if elements.len() < cursor + pad {
                        elements.resize(cursor + pad, (0, InitElemReloc::None));
                    }
                    cursor += pad;
                }
                self.accept(',')?;
                continue;
            }
            // A string literal initializing a row of a multi-dimensional
            // char array fills that row (C99 6.7.8p14): its bytes, then a
            // NUL if the row has room, padded to the row width. The child
            // is a one-dimensional char array exactly when `inner_dims`
            // has a single entry. A one-dimensional char array took the
            // brace-wrap / bare-string paths above instead.
            if self.lex.tk == '"'
                && !self.lex.str_is_wide
                && inner_dims.len() == 1
                && (elem_ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64
            {
                let row = inner_dims[0] as usize;
                let start_addr = self.take_concat_string_literal()?;
                let avail = self.data.len() - start_addr;
                let before = cursor;
                if elements.len() < before + row {
                    elements.resize(before + row, (0, InitElemReloc::None));
                }
                for k in 0..row {
                    let b = if k < avail {
                        self.data[start_addr + k] as i64
                    } else {
                        0
                    };
                    elements[before + k] = (b, InitElemReloc::None);
                }
                // The string's bytes were appended to the data segment by
                // the lexer; they are copied into `elements` now, so drop
                // them to avoid an orphaned literal.
                self.data.truncate(start_addr);
                cursor = before + row;
                self.accept(',')?;
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
            // A range designator fills `[cursor, end)` with the value;
            // a plain entry fills the single slot at `cursor`.
            let end = desig_range_end.take().unwrap_or(cursor + 1);
            if elements.len() < end {
                elements.resize(end, (0, InitElemReloc::None));
            }
            elements[cursor..end].fill((value, reloc));
            cursor = end;
            self.accept(',')?;
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
    /// Parse a static initializer leaf that is a constant address of a
    /// global object's sub-object: `&g.field`, `g.array_field`,
    /// `&arr[i].field`, or the parenthesised `(&buf[i])->field` form a
    /// `#define`d stream macro expands to. Returns `(byte offset into
    /// the global's data, owning Glo symbol index)` for a `Data`
    /// relocation, or `None` (with the lexer restored) when the leaf is
    /// not this shape. Consumed grammar:
    ///
    ///   addr   := ('&' | '(')* Glo postfix*
    ///   postfix := '[' const ']' | '.' field | '->' field | ')'
    ///
    /// The leading `&` / `(` and a balancing `)` are skipped; the byte
    /// offset accumulates the array-index strides and field offsets.
    fn parse_const_address(&mut self) -> Result<Option<(i64, usize)>, C5Error> {
        let snap = self.lex.snapshot();
        // The speculative scan may lex a string literal (whose bytes are
        // appended to the data segment) before deciding this is not an
        // address constant; the lexer snapshot does not cover the data
        // segment, so truncate it back on every bail-out.
        let data_snap = self.data.len();
        // Byte stride for a trailing `+ N` / `- N` (C99 6.6 address
        // constant `&object + integer`). A pointer cast before the `&`
        // (`(uint8_t*)&g + offsetof(...)`) sets the stride to its
        // pointee size; without a cast the symbol's element size is
        // used. `None` until a cast or the base symbol resolves it.
        let mut cast_stride: Option<i64> = None;
        // Count of leading grouping `(` that must be balanced by trailing
        // `)`. Only that many `)` are consumed at the end, so a `)` that
        // belongs to an enclosing construct (a conditional arm's closing
        // paren) is left for the caller rather than greedily eaten.
        let mut group_depth: i64 = 0;
        // Skip the `&` and any leading grouping parentheses. A `(` that
        // opens a cast (`(T*)&g`) is skipped whole -- the cast only
        // retypes the address, which is the same constant value. A
        // grouping `(` is matched by the trailing `)` consumed below.
        loop {
            if self.lex.tk == Token::AndOp {
                self.next()?;
            } else if self.lex.tk == '(' {
                let paren_snap = self.lex.snapshot();
                self.next()?;
                if self.lex_is_type_start() {
                    let base = self.parse_decl_base_type()?;
                    let _ = core::mem::take(&mut self.pending.typedef_base_array_size);
                    let mut stars: i64 = 0;
                    while self.lex.tk == Token::MulOp || self.lex.tk == Token::TypeQual {
                        if self.lex.tk == Token::MulOp {
                            stars += 1;
                        }
                        self.next()?;
                    }
                    if stars >= 1 && self.lex.tk == ')' {
                        // Simple pointer cast: record the pointee size so
                        // a following `+ N` strides by it.
                        let pointee = base + (stars - 1) * (Ty::Ptr as i64);
                        cast_stride = Some(self.size_of_type(pointee) as i64);
                        self.next()?; // consume `)`
                    } else {
                        // A more elaborate abstract declarator (function
                        // pointer, array). Skip the whole group by token
                        // balance; such casts do not appear before a
                        // pointer-arithmetic address constant.
                        self.lex.restore(paren_snap);
                        self.next()?; // re-consume `(`
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
                    }
                } else {
                    // A grouping `(` (not a cast). Record it so exactly
                    // the matching `)` is consumed below -- a `)` that
                    // closes an enclosing construct (e.g. a conditional
                    // arm) is left for the caller.
                    group_depth += 1;
                }
            } else {
                break;
            }
        }
        if self.lex.tk != Token::Id {
            self.lex.restore(snap);
            self.data.truncate(data_snap);
            return Ok(None);
        }
        let sym_idx = self.lex.curr_id_idx;
        if self.symbols[sym_idx].class != Token::Glo as i64 {
            self.lex.restore(snap);
            self.data.truncate(data_snap);
            return Ok(None);
        }
        let mut off = self.symbols[sym_idx].val;
        let mut cur_ty = self.symbols[sym_idx].type_;
        // A subscript at level `i` of a multi-dimensional array strides by
        // `product(array_dims[i+1..]) * sizeof(element)` -- the first index
        // spans whole sub-arrays, the innermost one element (C99
        // 6.5.2.1p2). An empty `array_dims` is the 1D case. A `.field`
        // selection resets the dimension ladder to the field's own type.
        let mut cur_dims = self.symbols[sym_idx].array_dims.clone();
        let mut level = 0usize;
        let elem_stride_at = |cur_ty: i64, cur_dims: &[i64], level: usize, this: &Self| -> i64 {
            let elem = this.size_of_type(cur_ty) as i64;
            if level < cur_dims.len() {
                cur_dims[level + 1..].iter().product::<i64>() * elem
            } else {
                elem
            }
        };
        self.next()?; // consume the identifier
        loop {
            if self.lex.tk == Token::Brak {
                self.next()?;
                let n = self.parse_constant_int()?;
                if self.lex.tk != ']' {
                    self.lex.restore(snap);
                    self.data.truncate(data_snap);
                    return Ok(None);
                }
                self.next()?;
                off += n * elem_stride_at(cur_ty, &cur_dims, level, self);
                level += 1;
            } else if self.lex.tk == Token::Dot || self.lex.tk == Token::Arrow {
                self.next()?;
                if self.lex.tk != Token::Id
                    || !(is_struct_ty(cur_ty) && struct_ptr_depth(cur_ty) == 0)
                {
                    self.lex.restore(snap);
                    self.data.truncate(data_snap);
                    return Ok(None);
                }
                let fname = self.symbols[self.lex.curr_id_idx].name.clone();
                let sid = struct_id_of(cur_ty);
                let Some(fpos) = self.structs[sid]
                    .fields
                    .iter()
                    .position(|f| f.name == fname)
                else {
                    self.lex.restore(snap);
                    self.data.truncate(data_snap);
                    return Ok(None);
                };
                let field = self.structs[sid].fields[fpos].clone();
                off += field.offset as i64;
                cur_ty = field.ty;
                cur_dims = field.array_dims.clone();
                level = 0;
                self.next()?;
            } else if self.lex.tk == Token::AddOp || self.lex.tk == Token::SubOp {
                // C99 6.6: `&object + integer-constant`. The stride is
                // the cast's pointee size when present (the common
                // `(uint8_t*)&g + offset` byte form), else the size of the
                // current sub-object (one element at the current level).
                let subtract = self.lex.tk == Token::SubOp;
                self.next()?;
                let n = self.parse_constant_int()?;
                let stride =
                    cast_stride.unwrap_or_else(|| elem_stride_at(cur_ty, &cur_dims, level, self));
                off += if subtract { -n } else { n } * stride;
            } else if self.lex.tk == ')' && group_depth > 0 {
                group_depth -= 1;
                self.next()?;
            } else {
                break;
            }
        }
        Ok(Some((off, sym_idx)))
    }

    /// Try to parse `cond ? A : B )` as a constant-init value, with the
    /// opening `(` already consumed. The condition is a constant integer;
    /// each arm is a constant-init value (an address constant or an
    /// integer). Returns the selected arm and consumes the closing `)`,
    /// or restores the lexer and returns `None` when the parens do not
    /// hold a conditional (so the caller's other paren handling runs).
    fn try_const_cond_init_value(&mut self) -> Result<Option<(i64, InitElemReloc)>, C5Error> {
        let snap = self.lex.snapshot();
        let data_snap = self.data.len();
        let restore = |s: &mut Self| {
            s.lex.restore(snap);
            s.data.truncate(data_snap);
        };
        // The condition runs up to `?` (a logical-OR expression). A
        // non-integer leaf (e.g. a bare `(T*)&g` with no conditional)
        // makes the evaluator error; treat that as "not a conditional".
        let cond = match self.parse_const_expr_or() {
            Ok(c) => c,
            Err(_) => {
                restore(self);
                return Ok(None);
            }
        };
        if self.lex.tk != Token::Cond {
            restore(self);
            return Ok(None);
        }
        self.next()?; // consume `?`
        // Both arms are parsed so their tokens are consumed; only the
        // arm the condition selects contributes its value and reloc. A
        // parse failure in either arm means this was not the address-
        // conditional shape -- restore and let the caller continue.
        let then_arm = match self.parse_constant_init_value() {
            Ok(v) => v,
            Err(_) => {
                restore(self);
                return Ok(None);
            }
        };
        if self.lex.tk != ':' {
            restore(self);
            return Ok(None);
        }
        self.next()?; // consume `:`
        let else_arm = match self.parse_constant_init_value() {
            Ok(v) => v,
            Err(_) => {
                restore(self);
                return Ok(None);
            }
        };
        if self.lex.tk != ')' {
            restore(self);
            return Ok(None);
        }
        self.next()?; // consume the closing `)`
        Ok(Some(if cond != 0 { then_arm } else { else_arm }))
    }

    pub(super) fn parse_constant_init_value(&mut self) -> Result<(i64, InitElemReloc), C5Error> {
        // C11 6.5.1.1 generic selection as an aggregate initializer
        // element: select the association, then evaluate the winning
        // expression as a constant (which may itself be an address).
        if self.lex.tk == Token::Generic {
            let after = self.generic_select_to_winner()?;
            let result = self.parse_constant_init_value()?;
            self.lex.restore(after);
            return Ok(result);
        }
        // A constant address of a global's sub-object: `&g.field`,
        // `g.array_field`, `(&buf[i])->field`. Takes priority over the
        // integer / `&global` leaves below, which only handle a whole
        // symbol with no member or index chain.
        if self.lex.tk == Token::AndOp || self.lex.tk == Token::Id || self.lex.tk == '(' {
            let snap = self.lex.snapshot();
            // A `:` or `)` terminator appears when this value is a
            // conditional arm (`cond ? &a : &b`) or a parenthesised leaf;
            // `,` / `}` terminate a brace-list element.
            if let Some((off, sym_idx)) = self.parse_const_address()?
                && (self.lex.tk == ','
                    || self.lex.tk == '}'
                    || self.lex.tk == ':'
                    || self.lex.tk == ')')
            {
                return Ok((off, InitElemReloc::Data(Some(sym_idx))));
            }
            self.lex.restore(snap);
        }
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
                let bits = self
                    .parse_const_expr_add_from(ConstVal::Float(f64::from_bits(v as u64)))?
                    .as_float();
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
        // Unary `+` on a numeric literal is the identity (C99 6.5.3.3p2);
        // mirror the unary-minus route below but leave the value
        // unchanged. Without this a `+0.7` array element falls through
        // to the integer path and stores 0.
        if self.lex.tk == Token::AddOp && self.lex.peek_after_whitespace_starts_digit() {
            let snap = self.lex.snapshot();
            self.next()?; // consume `+`
            if self.lex.tk == Token::FloatNum {
                let bits = self.lex.ival;
                self.next()?;
                if self.tk_is_float_arith_op() {
                    let folded = self
                        .parse_const_expr_add_from(ConstVal::Float(f64::from_bits(bits as u64)))?
                        .as_float();
                    return Ok((folded.to_bits() as i64, InitElemReloc::Float64Bits));
                }
                return Ok((bits, InitElemReloc::Float64Bits));
            }
            if self.lex.tk == Token::Num {
                self.lex.restore(snap);
                let v = self.parse_constant_int()?;
                return Ok((v, InitElemReloc::None));
            }
            return Err(self.compile_err(format!(
                "expected numeric literal after `+` in initializer (got {})",
                super::super::token::describe(self.lex.tk)
            )));
        }
        if self.lex.tk == Token::SubOp && self.lex.peek_after_whitespace_starts_digit() {
            let snap = self.lex.snapshot();
            self.next()?; // consume `-`
            if self.lex.tk == Token::FloatNum {
                let bits = (self.lex.ival as u64) ^ (1u64 << 63);
                self.next()?;
                if self.tk_is_float_arith_op() {
                    let folded = self
                        .parse_const_expr_add_from(ConstVal::Float(f64::from_bits(bits)))?
                        .as_float();
                    return Ok((folded.to_bits() as i64, InitElemReloc::Float64Bits));
                }
                return Ok((bits as i64, InitElemReloc::Float64Bits));
            }
            if self.lex.tk == Token::Num {
                // Leading `-Num` may head a binary integer chain
                // (`-N * M`, `-N + M`, ...). Without restarting the
                // const-expression evaluator on the whole input the
                // trailing operator escapes into the outer
                // brace-list parser and the brace list miscounts
                // its entries. Rewind to the `-` and route through
                // `parse_constant_int`, which honours the C99 6.6
                // precedence chain.
                self.lex.restore(snap);
                let v = self.parse_constant_int()?;
                return Ok((v, InitElemReloc::None));
            }
            // peek said "digit next", so the lexer must have
            // produced a numeric token. Anything else is a bug.
            return Err(self.compile_err(format!(
                "expected numeric literal after `-` in initializer (got {})",
                super::super::token::describe(self.lex.tk)
            )));
        }
        // Signed parenthesized float expression: `-(1.0e+308 * 10.0)`,
        // the expansion of `-INFINITY`. The `-FloatNum` / `+FloatNum`
        // cases above only fire when a digit follows the sign; a sign
        // before a parenthesized float expression needs the f64 folder,
        // which applies the sign itself. The integer fallback would
        // coerce the float result to an `i64` and store a garbage bit
        // pattern.
        if self.lex.tk == Token::SubOp || self.lex.tk == Token::AddOp {
            let snap = self.lex.snapshot();
            self.next()?; // consume the sign
            let signed_float_paren =
                self.lex.tk == '(' && self.contents_until_close_paren_have_float()?;
            self.lex.restore(snap);
            if signed_float_paren {
                let bits = self.parse_const_expr_add_val()?.as_float();
                return Ok((bits.to_bits() as i64, InitElemReloc::Float64Bits));
            }
        }
        // `(type)expr` cast or `(expr)` parenthesized constant in a
        // static initializer. After consuming `(`, peek the next
        // token: if it starts a type, treat as a cast -- arithmetic
        // operands go through the const-expr evaluator (which applies
        // the cast's conversion), relocation-bearing leaves recurse
        // with the cast dropped. Otherwise it's a parenthesized
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
                let mut cast_ty = self.parse_decl_base_type()?;
                // The cast type is discarded here rather than bound through a
                // declarator, so clear the function-type side channels it may
                // have set. A cast to a function-type-typedef pointer
                // (`(FnT *)expr`) otherwise leaves base_is_function_type set,
                // and the next pointer declaration absorbs its `*`.
                self.pending.base_is_function_type = false;
                self.pending.bare_function_type_declarator = false;
                self.pending.fn_ptr_indirection = None;
                self.pending.typedef_fn_proto = None;
                self.pending.fn_ptr_param_types = None;
                while self.lex.tk == Token::MulOp || self.lex.tk == Token::TypeQual {
                    if self.lex.tk == Token::MulOp {
                        cast_ty += Ty::Ptr as i64;
                    }
                    self.next()?;
                }
                // C99 6.5.2.5 array-typed compound literal:
                // `(T[]){...}` / `(T[N]){...}`. The array name decays to a
                // pointer to its first element, so the literal contributes
                // an anonymous static array and the element stores its
                // address. Distinguished from a plain cast by the `[`.
                if self.lex.tk == Token::Brak {
                    return self.parse_array_compound_literal(cast_ty);
                }
                // A cast of an arithmetic operand converts to the target
                // type (C99 6.5.4, 6.3.1.3); route the element through the
                // constant-expression evaluator, which applies every cast
                // in the chain at its own width, so
                // `(long)(int)0x92492493` sign-extends through `int`.
                // Only a cast of a relocation-bearing leaf keeps the
                // skip-and-recurse path below, where the value is the
                // leaf's address and the cast merely retypes it.
                if !self.post_cast_is_reloc_leaf()? {
                    self.lex.restore(snap);
                    return Ok(match self.parse_const_expr_cond_val()? {
                        ConstVal::Float(f) => (f.to_bits() as i64, InitElemReloc::Float64Bits),
                        v @ ConstVal::Int { .. } => (v.as_int(), InitElemReloc::None),
                    });
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
            // `(cond ? A : B)` -- a constant conditional whose arms may be
            // address constants (C99 6.6: a conditional expression with a
            // constant condition is itself a constant expression). The
            // integer evaluator below can fold the value but not carry an
            // address-valued arm's relocation, so select the arm here and
            // keep its reloc. Falls through when the parens hold a plain
            // arithmetic expression.
            if let Some(res) = self.try_const_cond_init_value()? {
                return Ok(res);
            }
            // A parenthesised relocation-bearing leaf -- `(func)`,
            // `(&global)`, possibly multiply parenthesised, as produced
            // by the `(PyCFunction)(((void(*)(void))((fn))))` method-table
            // idiom. Recurse on the inner value and consume the matching
            // `)` when it carries a relocation; a parenthesised arithmetic
            // constant rewinds and falls through to the folders below,
            // which must start outside the parens to absorb trailing
            // operators.
            {
                let inner_snap = self.lex.snapshot();
                let (v, reloc) = self.parse_constant_init_value()?;
                if !matches!(reloc, InitElemReloc::None | InitElemReloc::Float64Bits)
                    && self.lex.tk == ')'
                {
                    self.next()?; // consume the matching `)`
                    return Ok((v, reloc));
                }
                self.lex.restore(inner_snap);
            }
            // Sub-expression in parens. Peek for any FloatNum
            // token inside (up to the matching `)`); if present,
            // fold the whole sub-expression in f64 precision so
            // shapes like `(1.0f + 2.0f) * 4.0f` round-trip
            // exactly. Pure-integer parens fall through to the
            // integer expression evaluator below so trailing
            // `<<`, `+`, ... operators after `)` are absorbed too.
            if self.contents_until_close_paren_have_float()? {
                let seed = self.parse_const_expr_unary_val()?;
                let v = self.parse_const_expr_add_from(seed)?.as_float();
                if self.lex.tk != ')' {
                    return Err(self.compile_err("close paren expected in initializer"));
                }
                self.next()?;
                // The result of the parens is itself a float
                // value; any trailing `+ / - / * / /` continues
                // the float expression chain.
                if self.tk_is_float_arith_op() {
                    let folded = self
                        .parse_const_expr_add_from(ConstVal::Float(v))?
                        .as_float();
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
            // A static initializer leaf that begins with `&` folds to a
            // constant address (C99 6.6p9): either a relocation-bearing
            // pointer (`&global` / `&func`, equivalent under C99 6.3.2.1p4)
            // or a byte offset (the C99 7.19 / GCC `offsetof` expansion
            // `&((T *)0)->field`). The designation grammar in `const_expr`
            // recurses through parentheses and casts, so `&foo`, `&(foo)`,
            // and `&arr[i]` all fold uniformly; a symbol root yields a Code /
            // Data relocation, and the offsetof form yields a bare offset.
            let a = self.parse_const_address_of()?;
            let reloc = match a.sym {
                Some(idx) if a.sym_code => InitElemReloc::Code(idx),
                Some(idx) => InitElemReloc::Data(Some(idx)),
                None => InitElemReloc::None,
            };
            return Ok((a.value, reloc));
        }
        if self.lex.tk == Token::Id {
            let idx = self.lex.curr_id_idx;
            let class = self.symbols[idx].class;
            // C99 6.4.2.2: __func__ / __FUNCTION__ / __PRETTY_FUNCTION__
            // decay to a pointer to the enclosing function's name; resolve
            // them here so the undeclared name is not taken as a forward fn.
            if self.is_func_name_ident() {
                let off = self.intern_func_name();
                self.next()?;
                return Ok((off, InitElemReloc::Data(None)));
            }
            // C99 6.5.1: an identifier must be declared before use. An
            // undeclared identifier as an initializer element has no
            // resolvable value, so reject it rather than bind a placeholder
            // that resolves to a silent zero; name the header that declares
            // it when one is known. A function referenced before its
            // definition reaches the `Token::Fun` branch below through its
            // prototype (C99 6.7p7 -- a prior declaration satisfies the
            // type), so this rejects only genuinely undeclared names.
            if class == 0 {
                let name = self.symbols[idx].name.clone();
                return Err(self.compile_err(
                    match super::super::headers::header_declaring(&name) {
                        Some(h) => format!(
                            "use of undeclared identifier `{name}` in an initializer -- try `#include <{h}>`"
                        ),
                        None => {
                            format!("use of undeclared identifier `{name}` in an initializer")
                        }
                    },
                ));
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
                // re-dispatches via an external call. The CodeReloc
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

    /// C99 6.5.2.5 array-typed compound literal in a static initializer:
    /// `(T[]){ ... }` / `(T[N]){ ... }`. The array name decays to a
    /// pointer to its first element, so the literal contributes an
    /// anonymous static array and the enclosing element stores its
    /// address. On entry the current token is the leading `[` of the
    /// array declarator; `elem_ty` is the element type.
    fn parse_array_compound_literal(
        &mut self,
        elem_ty: i64,
    ) -> Result<(i64, InitElemReloc), C5Error> {
        self.next()?; // consume `[`
        let declared_size: i64 = if self.lex.tk == ']' {
            -1
        } else {
            self.parse_constant_int()?
        };
        if self.lex.tk != ']' {
            return Err(self.compile_err("`]` expected in array compound-literal type"));
        }
        self.next()?; // consume `]`
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected to close compound-literal type"));
        }
        self.next()?; // consume `)`
        if self.lex.tk != '{' {
            return Err(self.compile_err("`{` expected to start compound-literal initializer"));
        }
        let elem_size = self.size_of_type(elem_ty);
        let elem_is_struct = is_struct_ty(elem_ty) && struct_ptr_depth(elem_ty) == 0;
        // The element count must be known before the storage is reserved:
        // a struct element with a string-literal or `&global` field
        // appends to the data segment as it is filled, so per-element
        // offsets are computed as `off + i * elem_size`, not from the
        // live `self.data` length.
        let (scanned, _) = self.scan_array_init()?;
        let count = scanned.max(declared_size).max(0) as usize;
        self.align_data_to_8();
        let off = self.data.len() as i64;
        for _ in 0..(count * elem_size) {
            self.data.push(0);
        }
        if elem_is_struct {
            let sid = struct_id_of(elem_ty);
            self.next()?; // consume the outer `{`
            let mut idx: usize = 0;
            while self.lex.tk != '}' {
                if idx >= count {
                    return Err(
                        self.compile_err("too many initializers for array compound literal")
                    );
                }
                let here = off as usize + idx * elem_size;
                if self.lex.tk == '{' {
                    self.collect_struct_initializer(sid, here as i64)?;
                } else {
                    self.fill_struct_fields(sid, here as i64, false)?;
                }
                idx += 1;
                self.accept(',')?;
            }
            self.next()?; // consume the outer `}`
        } else {
            self.pending.init_target_array_size = count as i64;
            let elements = self.collect_array_initializer(elem_ty)?;
            self.write_array_init_into_data(off, elem_ty, &elements);
        }
        // Pad the anonymous array's storage up to an 8-byte boundary.
        while (self.data.len() as i64 - off) % 8 != 0 {
            self.data.push(0);
        }
        let sym_idx = self.intern_compound_literal_symbol(off, elem_ty);
        Ok((off, InitElemReloc::Data(Some(sym_idx))))
    }

    /// Create a synthetic internal `__compound.N` symbol anchored at
    /// data offset `off`, used as the relocation target for an
    /// anonymous compound literal stored in the data segment. Returns
    /// its symbol index.
    pub(super) fn intern_compound_literal_symbol(&mut self, off: i64, ty: i64) -> usize {
        let counter = self.next_compound_literal_id;
        self.next_compound_literal_id += 1;
        let sym_name = alloc::format!("__compound.{counter}");
        let new_idx = self.symbols.len();
        let hash = crate::c5::lexer::hash_name(sym_name.as_bytes());
        let sym = crate::c5::symbol::Symbol {
            name: sym_name,
            token: Token::Id as i64,
            class: Token::Glo as i64,
            type_: ty,
            val: off,
            linkage: crate::c5::symbol::Linkage::Internal,
            defined_here: true,
            has_initializer: true,
            ..Default::default()
        };
        self.symbols.push(sym);
        self.symbol_index.record(hash);
        new_idx
    }

    /// Walk a C99 6.7.8p7 designator-chain tail (the part after the
    /// first `.field` has already been consumed) and resolve it down
    /// to the final member: its absolute byte offset and its
    /// `StructField` record (so the caller sees array / bitfield
    /// shape, not just the element type). Accepts further `.member`
    /// steps; `[index]` sub-array designators surface as a parse
    /// error until they are wired up. The current type must be a
    /// value-typed struct or union for any `.` step.
    pub(super) fn resolve_nested_designator_chain(
        &mut self,
        mut cur_offset: i64,
        mut cur_ty: i64,
        entry_field: Option<super::StructField>,
    ) -> Result<(i64, super::StructField), C5Error> {
        // `entry_field` seeds the current object so a leading `[N]` step can
        // index an array member the caller already consumed (`.member[i]`,
        // where `.member` was read before this call). A `.member` step
        // overwrites it.
        let mut last: Option<super::StructField> = entry_field;
        let mut took_step = false;
        while self.lex.tk == Token::Dot || self.lex.tk == Token::Brak {
            if self.lex.tk == Token::Dot {
                if !is_struct_ty(cur_ty) || struct_ptr_depth(cur_ty) != 0 {
                    return Err(
                        self.compile_err("`.` designator on a non-struct / non-union field")
                    );
                }
                let sid = struct_id_of(cur_ty);
                self.next()?;
                if self.lex.tk != Token::Id {
                    return Err(self.compile_err("field name expected after `.`"));
                }
                let sub_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                let sub_idx = self.structs[sid]
                    .fields
                    .iter()
                    .position(|f| f.name == sub_name)
                    .ok_or_else(|| {
                        self.compile_err(format!(
                            "struct {} has no field {}",
                            self.structs[sid].name, sub_name
                        ))
                    })?;
                let sub = self.structs[sid].fields[sub_idx].clone();
                cur_offset += sub.offset as i64;
                cur_ty = sub.ty;
                last = Some(sub);
            } else {
                // C99 6.7.8p7 `.member[i]`: index the current array member.
                // Its element type is `cur_ty`; its dimension is on the
                // field record (`array_size`, with the element type stored
                // separately, so the stride is `sizeof(element)`).
                let arr = match &last {
                    Some(f) if f.array_size > 0 => f.clone(),
                    _ => return Err(self.compile_err("`[N]` designator on a non-array field")),
                };
                if arr.inner_array_size != 0 {
                    return Err(self.compile_err(
                        "multi-dimensional `[N]` sub-designator is not yet supported",
                    ));
                }
                self.next()?;
                let m = self.parse_constant_int()?;
                if m < 0 || m >= arr.array_size {
                    return Err(self.compile_err(format!(
                        "array designator index {m} out of bounds [0, {})",
                        arr.array_size
                    )));
                }
                if self.lex.tk != ']' {
                    return Err(self.compile_err("`]` expected after sub-designator index"));
                }
                self.next()?;
                cur_offset += m * self.size_of_type(cur_ty) as i64;
                // The indexed element is one `cur_ty`; strip the array so the
                // leaf initializes a single element.
                let mut elem = arr;
                elem.array_size = 0;
                last = Some(elem);
            }
            took_step = true;
        }
        if !took_step {
            return Err(self.compile_err("empty designator chain after `.field`"));
        }
        let field =
            last.ok_or_else(|| self.compile_err("empty designator chain after `.field`"))?;
        Ok((cur_offset, field))
    }

    /// A compound array-element designator `[N].field... = v` in a const
    /// struct array, entered with the cursor just past `[N]` on the leading
    /// `.`/`[`. Resolves the field chain from the element's base and writes
    /// one value there, overriding only that field. QEMU's MemoryRegionOps
    /// tables fill every element with `[lo ... hi] = { ... }`, then override
    /// `[k].endianness = ...` per element.
    pub(super) fn fill_element_field_designator(
        &mut self,
        struct_id: usize,
        elem_ty: i64,
        elem_base: i64,
    ) -> Result<(), C5Error> {
        let (final_offset, final_field) =
            self.resolve_nested_designator_chain(elem_base, elem_ty, None)?;
        if self.lex.tk != Token::Assign {
            return Err(self.compile_err("`=` expected after `[N].field` designator"));
        }
        self.next()?;
        // A pointer final member stores the address of a compound literal, so
        // keep the cast for the scalar leaf; a value member drops it.
        if is_pointer_ty(final_field.ty) || struct_ptr_depth(final_field.ty) > 0 {
            self.pending.compound_lit_close_parens = 0;
        } else {
            self.skip_opt_compound_literal_cast()?;
        }
        let close_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
        let elem = self.size_of_type(final_field.ty);
        let span = if final_field.array_size > 0 {
            final_field.array_size as usize * elem
        } else {
            elem
        };
        self.clear_init_relocs_in(final_offset as usize, final_offset as usize + span);
        self.fill_member_value_t(
            struct_id,
            &final_field,
            InitTarget::Data {
                base: elem_base as usize,
            },
            final_offset as usize,
            false,
        )?;
        for _ in 0..close_parens {
            self.accept(')')?;
        }
        Ok(())
    }

    /// Collect a `{ ... }` struct initializer. Each entry can be
    /// designated (`.field = value`) or positional. Entries are
    /// returned in source order with their resolved field offset
    /// + size. Designators advance the running positional index
    /// to "the field after the named one".
    /// Number of scalar initializer positions a struct consumes in a
    /// brace-elided (flat) list (C99 6.7.8p20). A scalar / pointer /
    /// bitfield field is one; an array of N elements is N times the
    /// element type's count; a nested struct recurses; a union --
    /// named or anonymous -- contributes its first member's count
    /// only (6.7.8p17: one initializer, for the first named member).
    pub(super) fn struct_flat_init_slots(&self, struct_id: usize) -> usize {
        let fields = self.structs[struct_id].fields.clone();
        let is_union = self.structs[struct_id].is_union;
        let mut total = 0usize;
        let mut i = 0;
        while i < fields.len() && (!is_union || i == 0) {
            let f = &fields[i];
            let elem = if is_struct_ty(f.ty) && struct_ptr_depth(f.ty) == 0 {
                self.struct_flat_init_slots(struct_id_of(f.ty))
            } else {
                1
            };
            total += if f.array_size > 0 {
                (f.array_size as usize) * elem
            } else {
                elem
            };
            let group = f.anon_union_group;
            i += 1;
            if group != 0 {
                while i < fields.len() && fields[i].anon_union_group == group {
                    i += 1;
                }
            }
        }
        total
    }

    pub(super) fn collect_struct_initializer(
        &mut self,
        struct_id: usize,
        var_offset: i64,
    ) -> Result<(), C5Error> {
        self.collect_struct_initializer_t(
            struct_id,
            InitTarget::Data {
                base: var_offset as usize,
            },
        )
    }

    pub(super) fn collect_struct_initializer_t(
        &mut self,
        struct_id: usize,
        target: InitTarget,
    ) -> Result<(), C5Error> {
        self.with_nesting("initializer", |c| {
            c.collect_struct_initializer_inner_t(struct_id, target)
        })
    }

    /// Runtime struct initialization at `local_val + base`. With
    /// `braced` true an explicit `{ ... }` is consumed; with `braced`
    /// false the struct's fields are filled from a brace-elided flat
    /// list (C99 6.7.8p20). The single entry point for a local struct
    /// / struct-array element whose initializer isn't all constant.
    pub(super) fn emit_struct_runtime_at(
        &mut self,
        local_val: i64,
        base: i64,
        sid: usize,
        braced: bool,
    ) -> Result<(), C5Error> {
        let target = InitTarget::Runtime { local_val, base };
        if braced {
            self.collect_struct_initializer_t(sid, target)
        } else {
            self.fill_struct_fields_t(sid, target, false)
        }
    }

    fn collect_struct_initializer_inner_t(
        &mut self,
        struct_id: usize,
        target: InitTarget,
    ) -> Result<(), C5Error> {
        if self.lex.tk != '{' {
            return Err(self.compile_err("struct initializer must start with `{{`"));
        }
        self.next()?;
        self.fill_struct_fields_t(struct_id, target, true)?;
        self.next()?; // consume `}`
        Ok(())
    }

    /// Fill a multi-dimensional array of structs from a brace list, recursing
    /// per inner dimension. `dims` lists the remaining dimensions, outermost
    /// first; `struct_size` is the element struct's size. Consumes the opening
    /// `{` through the matching `}`. Positional only -- a designator at the
    /// outermost level is handled by the caller.
    pub(super) fn collect_struct_array_data(
        &mut self,
        struct_id: usize,
        base: i64,
        dims: &[i64],
        struct_size: i64,
    ) -> Result<(), C5Error> {
        if self.lex.tk != '{' {
            return Err(self.compile_err("array initializer must start with `{{`"));
        }
        self.next()?;
        let stride = struct_size * dims[1..].iter().product::<i64>();
        let mut i: i64 = 0;
        while self.lex.tk != '}' {
            if i >= dims[0] {
                return Err(self.compile_err("too many initializers for array"));
            }
            let here = base + i * stride;
            if dims.len() == 1 {
                if self.lex.tk == '{' {
                    self.collect_struct_initializer(struct_id, here)?;
                } else {
                    self.fill_struct_fields(struct_id, here, false)?;
                }
            } else {
                self.collect_struct_array_data(struct_id, here, &dims[1..], struct_size)?;
            }
            i += 1;
            self.accept(',')?;
        }
        self.next()?; // consume `}`
        Ok(())
    }

    /// C99 6.5.2.5: an initializer element may be written as a compound
    /// literal `(Type){ ... }`. When it appears as an aggregate member's
    /// value the cast type names the member's own type, so the `(Type)`
    /// prefix is redundant; consume it and leave the `{ ... }` for the
    /// brace path to handle as a nested initializer. Returns true when a
    /// cast was skipped. The lexer is restored when the `(` opens an
    /// ordinary parenthesised expression or a scalar cast instead.
    pub(super) fn skip_opt_compound_literal_cast(&mut self) -> Result<bool, C5Error> {
        self.pending.compound_lit_close_parens = 0;
        if self.lex.tk != '(' {
            return Ok(false);
        }
        let snap = self.lex.snapshot();
        // C99 6.5.1/6.5.2.5: a compound literal is a primary expression and
        // may be wrapped in grouping parentheses (`((T){...})`), a common
        // macro-body shape. Consume any leading grouping parens (a `(` not
        // immediately starting a type) before the cast; the matching close
        // parens are consumed by the aggregate-initializer dispatch after
        // the literal's brace list, via `compound_lit_close_parens`.
        let mut grouping: i64 = 0;
        loop {
            self.next()?; // consume `(`
            if self.lex_is_type_start() {
                break;
            }
            if self.lex.tk == '(' {
                grouping += 1;
                continue;
            }
            self.lex.restore(snap);
            return Ok(false);
        }
        // Skip the balanced token run to the matching `)`. The type name
        // plus any abstract declarator (pointers, array brackets) is a
        // no-op here; only the following `{` decides a compound literal.
        let mut depth: i64 = 1;
        while depth > 0 && self.lex.tk != 0 {
            if self.lex.tk == '(' {
                depth += 1;
            } else if self.lex.tk == ')' {
                depth -= 1;
                if depth == 0 {
                    self.next()?; // consume the matching `)`
                    break;
                }
            }
            self.next()?;
        }
        if self.lex.tk == '{' {
            self.pending.compound_lit_close_parens = grouping;
            return Ok(true);
        }
        self.lex.restore(snap);
        Ok(false)
    }

    /// Write a flexible array member's static initializer (a GCC/clang
    /// extension over C99 6.7.2.1p18) at `field_base`, growing
    /// `self.data` to hold the trailing elements. The member's element
    /// type is `elem_ty`. The cursor is positioned at the member's
    /// initializer (a brace list, or a string literal for a char member)
    /// and is left at the following `,` / `}`.
    fn fill_flexible_array_member(
        &mut self,
        field_base: usize,
        elem_ty: i64,
    ) -> Result<(), C5Error> {
        let elem_size = self.size_of_type(elem_ty);
        let grow_to = |data: &mut alloc::vec::Vec<u8>, end: usize| {
            if data.len() < end {
                data.resize(end, 0);
            }
        };
        if self.lex.tk == '"' && (elem_ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64 {
            let start_addr = self.take_concat_string_literal()?;
            self.data.push(0); // ensure NUL terminator in the literal's bytes
            let mut idx = 0usize;
            while start_addr + idx < self.data.len() {
                let b = self.data[start_addr + idx];
                grow_to(&mut self.data, field_base + idx + 1);
                self.data[field_base + idx] = b;
                idx += 1;
                if b == 0 {
                    break;
                }
            }
            return Ok(());
        }
        if self.lex.tk != '{' {
            return Err(self
                .compile_err("flexible array member initializer must be a brace list or string"));
        }
        self.next()?;
        let elem_is_struct = is_struct_ty(elem_ty) && struct_ptr_depth(elem_ty) == 0;
        let mut idx = 0usize;
        while self.lex.tk != '}' {
            let here = field_base + idx * elem_size;
            grow_to(&mut self.data, here + elem_size);
            if elem_is_struct {
                let sid = struct_id_of(elem_ty);
                if self.lex.tk == '{' {
                    self.collect_struct_initializer(sid, here as i64)?;
                } else {
                    self.fill_struct_fields(sid, here as i64, false)?;
                }
            } else {
                let (value, reloc) = self.parse_constant_init_value()?;
                self.write_init_value(here, elem_size, value, reloc, elem_ty);
            }
            idx += 1;
            self.accept(',')?;
        }
        self.next()?; // consume `}`
        Ok(())
    }

    /// Fill the fields of a struct from the current brace-list position.
    /// With `braced` true the caller has already consumed the opening
    /// `{` and consumes the matching `}` after this returns; the loop
    /// runs until that `}`. With `braced` false (C99 6.7.8p20 brace
    /// elision) there is no enclosing `{ }`: the loop returns as soon as
    /// every field is filled, leaving the remaining initializers for the
    /// surrounding aggregate's next sub-object.
    pub(super) fn fill_struct_fields(
        &mut self,
        struct_id: usize,
        var_offset: i64,
        braced: bool,
    ) -> Result<(), C5Error> {
        self.fill_struct_fields_t(
            struct_id,
            InitTarget::Data {
                base: var_offset as usize,
            },
            braced,
        )
    }

    pub(super) fn fill_struct_fields_t(
        &mut self,
        struct_id: usize,
        target: InitTarget,
        braced: bool,
    ) -> Result<(), C5Error> {
        let var_offset = target.base();
        let mut pos: usize = 0;
        while self.lex.tk != '}' && (braced || pos < self.structs[struct_id].fields.len()) {
            // Designator?
            let designated = self.lex.tk == Token::Dot;
            let field_idx = if self.lex.tk == Token::Dot {
                self.next()?;
                if self.lex.tk != Token::Id {
                    return Err(self.compile_err("field name expected after `.`"));
                }
                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                let outer_idx = self.structs[struct_id]
                    .fields
                    .iter()
                    .position(|f| f.name == field_name)
                    .ok_or_else(|| {
                        self.compile_err(format!(
                            "struct {} has no field {}",
                            self.structs[struct_id].name, field_name
                        ))
                    })?;
                // C99 6.7.8p7: a designator list may be a chain of
                // `.member` and `[index]` steps. `.outer.inner = v`
                // is equivalent to `.outer = { .inner = v }`. Walk
                // the chain to the final member, then initialize it
                // through the shared member dispatch so a char-array
                // member takes a string literal (6.7.8p14) and a
                // bitfield merges into its unit, exactly as when the
                // member is named directly. Falls through to the
                // single-level path when no extra steps follow.
                if self.lex.tk == Token::Dot || self.lex.tk == Token::Brak {
                    let outer = self.structs[struct_id].fields[outer_idx].clone();
                    let chain_base = (var_offset as usize) + outer.offset;
                    let (final_offset, final_field) = self.resolve_nested_designator_chain(
                        chain_base as i64,
                        outer.ty,
                        Some(outer.clone()),
                    )?;
                    if self.lex.tk != Token::Assign {
                        return Err(self.compile_err("`=` expected after nested-designator chain"));
                    }
                    self.next()?;
                    // See the single-level path below: keep the cast for a
                    // pointer final member (address-of a compound literal).
                    if is_pointer_ty(final_field.ty) || struct_ptr_depth(final_field.ty) > 0 {
                        self.pending.compound_lit_close_parens = 0;
                    } else {
                        self.skip_opt_compound_literal_cast()?;
                    }
                    let chain_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
                    self.fill_member_value_t(
                        struct_id,
                        &final_field,
                        target,
                        final_offset as usize,
                        false,
                    )?;
                    for _ in 0..chain_parens {
                        self.accept(')')?;
                    }
                    pos = outer_idx + 1;
                    self.accept(',')?;
                    continue;
                }
                if self.lex.tk != Token::Assign {
                    return Err(
                        self.compile_err(format!("`=` expected after `.{field_name}` designator"))
                    );
                }
                self.next()?;
                outer_idx
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
            // A member value written as a compound literal `(Type){ ... }`
            // (C99 6.5.2.5) that names the member's own type is dropped so
            // the brace paths below initialize the member in place. A
            // pointer member instead stores the ADDRESS of the literal
            // (`.fields = (const T[]){ ... }`, ubiquitous in QEMU's
            // VMStateDescription / TypeInfo tables); there the cast carries
            // the literal's type, so leave it for the scalar leaf to consume
            // via `parse_constant_init_value`.
            if is_pointer_ty(field.ty) || struct_ptr_depth(field.ty) > 0 {
                self.pending.compound_lit_close_parens = 0;
            } else {
                self.skip_opt_compound_literal_cast()?;
            }
            let close_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
            // C11 6.7.2.1: an anonymous struct flattened into the parent may
            // take a brace-enclosed sub-initializer that fills its members in
            // order (`union { struct { int a, b; }; ... } x = { { 1, 2 } }`).
            // The grouped members are contiguous; fill each from the brace,
            // then advance past the whole group. Skipped for a field reached
            // by an explicit `.name` designator: the brace then initializes
            // that member's own type (handled by the recursion below).
            if !designated && field.anon_struct_group != 0 && self.lex.tk == '{' {
                self.next()?; // consume `{`
                let group = field.anon_struct_group;
                let mut mem_pos = field_idx;
                while self.lex.tk != '}' {
                    // C99 6.7.8p7: a `.member` designator inside the group's
                    // brace selects one flattened member; a positional entry
                    // advances to the next group member. Either way the
                    // cursor continues past the written member.
                    let mem_idx = if self.lex.tk == Token::Dot {
                        self.next()?;
                        if self.lex.tk != Token::Id {
                            return Err(self.compile_err("field name expected after `.`"));
                        }
                        let nm = self.symbols[self.lex.curr_id_idx].name.clone();
                        self.next()?;
                        if self.lex.tk != Token::Assign {
                            return Err(
                                self.compile_err(format!("`=` expected after `.{nm}` designator"))
                            );
                        }
                        self.next()?;
                        self.structs[struct_id]
                            .fields
                            .iter()
                            .position(|f| f.anon_struct_group == group && f.name == nm)
                            .ok_or_else(|| {
                                self.compile_err(format!("anonymous member {nm} not found"))
                            })?
                    } else {
                        while mem_pos < self.structs[struct_id].fields.len()
                            && self.structs[struct_id].fields[mem_pos].anon_struct_group != group
                        {
                            mem_pos += 1;
                        }
                        if mem_pos >= self.structs[struct_id].fields.len() {
                            return Err(
                                self.compile_err("too many initializers for anonymous struct")
                            );
                        }
                        mem_pos
                    };
                    let mem = self.structs[struct_id].fields[mem_idx].clone();
                    let mem_base = (var_offset as usize) + mem.offset;
                    if is_struct_ty(mem.ty) && struct_ptr_depth(mem.ty) == 0 && self.lex.tk == '{' {
                        self.collect_struct_initializer_t(
                            struct_id_of(mem.ty),
                            target.rebased(mem_base as i64),
                        )?;
                    } else {
                        self.init_leaf_scalar(target, mem_base as i64, mem.ty)?;
                    }
                    mem_pos = mem_idx + 1;
                    self.accept(',')?;
                }
                self.next()?; // consume `}`
                pos = field_idx;
                while pos < self.structs[struct_id].fields.len()
                    && self.structs[struct_id].fields[pos].anon_struct_group == group
                {
                    pos += 1;
                }
                for _ in 0..close_parens {
                    self.accept(')')?;
                }
                self.accept(',')?;
                continue;
            }
            // C11 6.7.2.1: an anonymous union/struct member whose members are
            // flattened into the parent (shared anon_union_group) may take a
            // brace-enclosed sub-initializer (`{ .member = v }` or `{ v }`).
            // The brace selects one group member rather than a nested object;
            // fill it, then advance past the whole group. Skipped for a field
            // reached by an explicit `.name` designator: the brace then
            // initializes that member's own type (handled below).
            if !designated && field.anon_union_group != 0 && self.lex.tk == '{' {
                self.next()?; // consume `{`
                let group = field.anon_union_group;
                while self.lex.tk != '}' {
                    let mem_idx = if self.lex.tk == Token::Dot {
                        self.next()?;
                        if self.lex.tk != Token::Id {
                            return Err(self.compile_err("field name expected after `.`"));
                        }
                        let nm = self.symbols[self.lex.curr_id_idx].name.clone();
                        self.next()?;
                        if self.lex.tk != Token::Assign {
                            return Err(
                                self.compile_err(format!("`=` expected after `.{nm}` designator"))
                            );
                        }
                        self.next()?;
                        self.structs[struct_id]
                            .fields
                            .iter()
                            .position(|f| f.anon_union_group == group && f.name == nm)
                            .ok_or_else(|| {
                                self.compile_err(format!("anonymous member {nm} not found"))
                            })?
                    } else {
                        field_idx
                    };
                    let mem = self.structs[struct_id].fields[mem_idx].clone();
                    let mem_base = (var_offset as usize) + mem.offset;
                    if is_struct_ty(mem.ty) && struct_ptr_depth(mem.ty) == 0 && self.lex.tk == '{' {
                        self.collect_struct_initializer_t(
                            struct_id_of(mem.ty),
                            target.rebased(mem_base as i64),
                        )?;
                    } else {
                        self.init_leaf_scalar(target, mem_base as i64, mem.ty)?;
                    }
                    self.accept(',')?;
                }
                self.next()?; // consume `}`
                pos = field_idx + 1;
                while pos < self.structs[struct_id].fields.len()
                    && self.structs[struct_id].fields[pos].anon_union_group == group
                {
                    pos += 1;
                }
                for _ in 0..close_parens {
                    self.accept(')')?;
                }
                self.accept(',')?;
                continue;
            }
            // Flexible array member (`T v[]`, array_size == -1) with a
            // static initializer. C99 6.7.2.1p18 forbids initializing a
            // FAM, but GCC and clang accept it for a top-level object,
            // laying the object out as if the member were a fixed array
            // sized to the initializer. Such an object cannot be nested
            // (6.7.2.1: a FAM-bearing struct is not a member or array
            // element), so its storage is the last region in `self.data`;
            // the trailing element bytes extend the tail beyond the fixed
            // struct size reserved by the caller, so grow `self.data` as
            // each element is written.
            if field.array_size < 0 {
                if target.is_runtime() {
                    return Err(self.compile_err(
                        "non-constant flexible array member initializer not yet supported",
                    ));
                }
                self.fill_flexible_array_member(field_base, field.ty)?;
                pos = field_idx + 1;
                self.accept(',')?;
                continue;
            }
            // A brace-elided first field may take a whole struct value
            // by copy (Runtime only); when it does, the object is filled.
            let first_elided = !braced && field_idx == 0 && field.offset == 0;
            let whole_object_done =
                self.fill_member_value_t(struct_id, &field, target, field_base, first_elided)?;
            // Consume the grouping `)` that wrapped a parenthesized
            // compound literal element (`((T){...})`), counted while the
            // cast was stripped above.
            for _ in 0..close_parens {
                self.accept(')')?;
            }
            if whole_object_done {
                return Ok(());
            }
            // A positional initializer fills the first member of an
            // anonymous union (C99 6.7.8); the remaining members share
            // its storage, so advance past the whole group rather than
            // landing on the next alternative.
            pos = field_idx + 1;
            let group = field.anon_union_group;
            if group != 0 {
                let fields = &self.structs[struct_id].fields;
                while pos < fields.len() && fields[pos].anon_union_group == group {
                    pos += 1;
                }
            }
            self.accept(',')?;
            // C99 6.7.8p17: without designators a union takes a single
            // initializer, for its first named member; in a brace-elided
            // context stop there rather than consuming values meant for
            // the surrounding aggregate's next members.
            if !braced && self.structs[struct_id].is_union {
                break;
            }
        }
        Ok(())
    }

    /// Initialize one member at `field_base` from the current token
    /// position, dispatching on the member's shape:
    ///   * char-array member from a string literal (C99 6.7.8p14),
    ///     optionally brace- or paren-wrapped
    ///   * array member from a brace list or a brace-elided flat list
    ///     (6.7.8p20)
    ///   * nested struct / union member, braced or brace-elided
    ///   * bitfield member (read-modify-write of its storage unit)
    ///   * scalar / pointer member from a single constant expression
    /// Shared by the positional walk in `fill_struct_fields` and the
    /// nested-designator path, so `.outer.inner = value` takes the
    /// same shapes as a directly named member. `struct_id` is the
    /// containing aggregate (error text only).
    /// Initialize one member. Returns `true` when a whole-object copy
    /// (a brace-elided struct value filling the first field) consumed
    /// the entire enclosing object, so the field walk must stop.
    /// `first_elided` marks the position where such a copy is legal
    /// (`!braced && field_idx == 0`); it only matters for `Runtime`.
    fn fill_member_value_t(
        &mut self,
        struct_id: usize,
        field: &super::StructField,
        target: InitTarget,
        field_base: usize,
        first_elided: bool,
    ) -> Result<bool, C5Error> {
        if let InitTarget::Runtime { local_val, .. } = target {
            return self.fill_member_value_runtime(
                struct_id,
                field,
                local_val,
                field_base as i64,
                first_elided,
            );
        }
        let mut char_array_brace_string = false;
        if field.array_size > 0
            && field.inner_array_size == 0
            && (field.ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64
            && self.lex.tk == '{'
        {
            let snap = self.lex.snapshot();
            // Peeking the inner string token appends its bytes to the
            // data segment; restore the length too if it is not a
            // brace-wrapped string after all.
            let data_snap = self.data.len();
            self.next()?;
            if self.lex.tk == '"' {
                char_array_brace_string = true;
            } else {
                self.lex.restore(snap);
                self.data.truncate(data_snap);
            }
        }
        // A string literal initializing a char array may be enclosed
        // in parentheses (C99 6.5.1 -- a parenthesized expression has
        // the same value; `._data = ("str")` is the form a macro
        // produces). Skip the leading `(` so the string-copy path
        // below sees the literal; the matching `)`s are consumed after
        // the copy. Without this the parenthesized leaf falls into the
        // single-value path and stores the string's pointer.
        let mut char_array_paren_depth = 0usize;
        if field.array_size > 0
            && field.inner_array_size == 0
            && (field.ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64
            && self.lex.tk == '('
        {
            let snap = self.lex.snapshot();
            let data_snap = self.data.len();
            let mut depth = 0usize;
            while self.lex.tk == '(' {
                depth += 1;
                self.next()?;
            }
            if self.lex.tk == '"' {
                char_array_paren_depth = depth;
            } else {
                self.lex.restore(snap);
                self.data.truncate(data_snap);
            }
        }
        if field.array_size > 0
            && self.lex.tk == '"'
            && (field.ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64
        {
            // `struct S { char a[N]; } x = { "..." };` -- copy the
            // string bytes (including the trailing NUL) into the
            // char-array field, padding the remainder with zeroes.
            // Without this branch the parser falls into the
            // single-value path and writes the *pointer* to the
            // string's data-segment slot into the field's first
            // 8 bytes, which produces garbage at read time.
            let start_addr = self.take_concat_string_literal()?;
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
                    field.ty,
                );
                idx += 1;
                if start_addr + idx >= self.data.len() {
                    // Past the string; remainder stays zero.
                    // Still walk the loop so all `max` bytes are
                    // explicitly written (zeroed above by
                    // write_init_value when source byte is 0).
                }
            }
            if char_array_brace_string {
                self.expect_close_brace_after_wrapped_string()?;
            }
            for _ in 0..char_array_paren_depth {
                if self.lex.tk != ')' {
                    return Err(self
                        .compile_err("`)` expected to close a parenthesized string initializer"));
                }
                self.next()?;
            }
        } else if field.array_size > 0
            && field.inner_array_size == 0
            && self.lex.tk == '"'
            && self.lex.str_is_wide
        {
            // `struct S { wchar_t w[N]; } = { L"..." }`: store each wide
            // code point at its element stride, NUL-padding the tail.
            // Mirrors the bare wide-array path; a narrow-width element
            // cannot hold a wide code point (C99 6.7.8p15). Without this
            // branch the leaf falls to the single-value path and stores
            // the string's pointer.
            let w = self.lex.wchar_bytes;
            if self.size_of_type(field.ty) != w {
                return Err(self
                    .compile_err("wide string initializer requires a wchar_t-width array member"));
            }
            let start_addr = self.take_concat_string_literal()?;
            for _ in 0..w {
                self.data.push(0); // terminator slot
            }
            for idx in 0..field.array_size as usize {
                let base = start_addr + idx * w;
                let mut v: i64 = 0;
                if base + w <= self.data.len() {
                    for b in 0..w {
                        v |= (self.data[base + b] as i64) << (b * 8);
                    }
                }
                self.write_init_value(field_base + idx * w, w, v, InitElemReloc::None, field.ty);
            }
        } else if field.array_size > 0 && self.lex.tk == '{' {
            self.next()?;
            let elem_size = self.size_of_type(field.ty);
            // C99 6.7.8p21: a brace-enclosed initializer for the
            // array member initializes every element; positions not
            // named by a designator -- and any value left by an
            // overridden duplicate initializer (6.7.8p19) -- are set
            // to zero. Clear the member's region before applying the
            // listed values.
            let region = elem_size * field.array_size as usize;
            for b in &mut self.data[field_base..field_base + region] {
                *b = 0;
            }
            let elem_is_struct = is_struct_ty(field.ty) && struct_ptr_depth(field.ty) == 0;
            let elem_sid = if elem_is_struct {
                Some(struct_id_of(field.ty))
            } else {
                None
            };
            let mut idx: usize = 0;
            while self.lex.tk != '}' {
                // C99 6.7.8p7 array designator inside an array
                // field's nested initializer. `[N] = value`
                // jumps the write cursor to N; subsequent
                // positional entries (or further `[K] = ...`
                // clauses) continue from there. Mirrors the
                // top-level array-init path in
                // `collect_array_initializer`.
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
                    idx = n as usize;
                }
                if idx as i64 >= field.array_size {
                    return Err(self.compile_err(format!(
                        "too many initializers for `{}.{}`",
                        self.structs[struct_id].name, field.name
                    )));
                }
                let here = field_base + idx * elem_size;
                // C99 6.7.8p20: an array-of-struct field accepts a
                // nested brace-enclosed initializer for each element,
                // and the element's braces may be elided. A `{ ... }`
                // element routes through the struct collector; a
                // brace-elided element consumes exactly that element's
                // fields from the flat list via `fill_struct_fields`.
                // Scalar element types fall through to the constant-
                // value path. (Without the elided-element branch a
                // flat list wrote a single scalar with the struct's
                // byte width, overflowing `write_init_bytes`.)
                if let Some(sid) = elem_sid {
                    if self.lex.tk == '{' {
                        self.collect_struct_initializer(sid, here as i64)?;
                    } else {
                        self.fill_struct_fields(sid, here as i64, false)?;
                    }
                } else {
                    let (value, reloc) = self.parse_constant_init_value()?;
                    self.write_init_value(here, elem_size, value, reloc, field.ty);
                }
                idx += 1;
                self.accept(',')?;
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
                self.write_init_value(here, elem_size, value, reloc, field.ty);
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
        } else if is_struct_ty(field.ty) && struct_ptr_depth(field.ty) == 0 {
            let nested_sid = struct_id_of(field.ty);
            if self.lex.tk == '{' {
                self.collect_struct_initializer(nested_sid, field_base as i64)?;
            } else {
                // C99 6.7.8p20: a nested aggregate field's braces may be
                // elided, filling its members from the surrounding flat
                // list. Mirrors the array-of-struct element path. For a
                // union the recursion converts and stores one value into
                // the first named member (6.7.8p17) and returns.
                self.fill_struct_fields(nested_sid, field_base as i64, false)?;
            }
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
            // C99 6.7.9p11: a scalar member's initializer may be
            // enclosed in braces (`{ .field = { expr } }`); strip a
            // single wrapper, matching the runtime scalar path.
            let braced_scalar = self.lex.tk == '{';
            if braced_scalar {
                self.next()?;
            }
            let (value, reloc) = self.parse_constant_init_value()?;
            let field_size = self.size_of_type(field.ty);
            self.write_init_value(field_base, field_size, value, reloc, field.ty);
            if braced_scalar {
                self.accept(',')?;
                if self.lex.tk != '}' {
                    return Err(self.compile_err(
                        "scalar initializer wrapped in `{ ... }` must hold a single value",
                    ));
                }
                self.next()?; // consume `}`
            }
        }
        Ok(false)
    }

    /// Runtime leaf for one struct member: evaluates the initializer
    /// as an assignment-expression and records the store element(s).
    /// Handles a narrow-string char-array member, a braced nested
    /// aggregate (via the shared traversal), a whole-object struct
    /// copy at a brace-elided first field (returns `true`), and the
    /// scalar / pointer leaf. Wide strings, non-char arrays, flexible
    /// array members, and bitfields aren't modeled yet.
    fn fill_member_value_runtime(
        &mut self,
        struct_id: usize,
        field: &super::StructField,
        local_val: i64,
        field_base: i64,
        first_elided: bool,
    ) -> Result<bool, C5Error> {
        // A bitfield member falls through to the scalar leaf below (its
        // value parses like any scalar); the element it records is tagged
        // with the bitfield descriptor so the walker emits a
        // read-modify-write of the storage unit instead of a full store.
        if field.array_size > 0 {
            // C99 6.7.8p14 char array from a narrow string literal:
            // emit a per-byte constant store, remainder zero-filled.
            if self.lex.tk == '"'
                && !self.lex.str_is_wide
                && (field.ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64
            {
                let start_addr = self.take_concat_string_literal()?;
                self.data.push(0); // ensure NUL terminator
                let max = field.array_size as usize;
                for k in 0..max {
                    let b = if start_addr + k < self.data.len() {
                        self.data[start_addr + k] as i64
                    } else {
                        0
                    };
                    let value = self.ast_emit_int_lit(b, Ty::Char as i64);
                    self.pending_local_runtime_elements.push(
                        super::super::ast::RuntimeInitElement {
                            offset: field_base + k as i64,
                            value,
                            ty: Ty::Char as i64,
                            bitfield: None,
                        },
                    );
                }
                return Ok(false);
            }
            // Wide string into a wchar_t-width member (C99 6.7.8p15): a
            // per-element constant store at the element's stride.
            if self.lex.tk == '"' && self.lex.str_is_wide && field.inner_array_size == 0 {
                let w = self.lex.wchar_bytes;
                if self.size_of_type(field.ty) != w {
                    return Err(self.compile_err(
                        "wide string initializer requires a wchar_t-width array member",
                    ));
                }
                let start_addr = self.take_concat_string_literal()?;
                for _ in 0..w {
                    self.data.push(0); // terminator slot
                }
                for k in 0..field.array_size as usize {
                    let base = start_addr + k * w;
                    let mut v: i64 = 0;
                    if base + w <= self.data.len() {
                        for b in 0..w {
                            v |= (self.data[base + b] as i64) << (b * 8);
                        }
                    }
                    let value = self.ast_emit_int_lit(v, field.ty);
                    self.pending_local_runtime_elements.push(
                        super::super::ast::RuntimeInitElement {
                            offset: field_base + (k * w) as i64,
                            value,
                            ty: field.ty,
                            bitfield: None,
                        },
                    );
                }
                return Ok(false);
            }
            // C99 6.7.8p13: an array member initialized by a brace list of
            // non-constant elements, or that same list with the member's
            // braces elided into the enclosing struct's list (6.7.8p20).
            // The struct slot is already zero-seeded, so positions left
            // unwritten stay zero (6.7.8p21). Route through the runtime
            // local-array filler at the member's byte offset.
            let elem_size = self.size_of_type(field.ty) as i64;
            let inner_dim = field.inner_array_size;
            if self.lex.tk == '{' {
                let inner: &[i64] = if inner_dim > 0 {
                    core::slice::from_ref(&inner_dim)
                } else {
                    &[]
                };
                self.emit_local_array_init_runtime(
                    local_val,
                    field_base,
                    field.ty,
                    field.array_size,
                    inner,
                    "<array member>",
                )?;
            } else {
                self.fill_array_leaves_runtime(
                    local_val,
                    field_base,
                    field.array_size,
                    field.ty,
                    elem_size,
                )?;
            }
            return Ok(false);
        }
        // A nested aggregate member initialized by a brace list (or a
        // compound literal naming its type) recurses through the shared
        // traversal at the member's offset (C99 6.7.8p13).
        if is_struct_ty(field.ty) && struct_ptr_depth(field.ty) == 0 && self.lex.tk == '{' {
            self.collect_struct_initializer_t(
                struct_id_of(field.ty),
                InitTarget::Runtime {
                    local_val,
                    base: field_base,
                },
            )?;
            return Ok(false);
        }
        // Scalar / pointer leaf, or a whole-object struct copy.
        self.emit_lea(local_val);
        if field_base > 0 {
            self.ast_psh();
            self.emit_imm(field_base);
            self.ast_binop(crate::c5::ir::BinOp::Add);
        }
        self.ast_psh();
        self.expr(Token::Assign as i64)?;
        // C99 6.7.9p13: a brace-elided first field taking an expression
        // of the enclosing struct's own type is a whole-object copy, not
        // elision into the first scalar field. Copy the bytes and stop.
        if first_elided
            && is_struct_ty(self.ty)
            && struct_ptr_depth(self.ty) == 0
            && struct_id_of(self.ty) == struct_id
        {
            let value = self.ast_acc;
            let elem_ty = self.ty;
            self.ast_assign();
            if let Some(value) = value {
                self.pending_local_runtime_elements
                    .push(super::super::ast::RuntimeInitElement {
                        offset: field_base,
                        value,
                        ty: elem_ty,
                        bitfield: None,
                    });
            }
            return Ok(true);
        }
        // C99 6.7.8p13: a struct member may be initialized by a single
        // compatible struct expression (copied); a scalar value would be
        // brace elision into its sub-fields, which this path can't model.
        if is_struct_ty(field.ty)
            && struct_ptr_depth(field.ty) == 0
            && !(is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0)
        {
            return Err(self
                .compile_err("brace elision into a non-constant struct member is not supported"));
        }
        self.convert_assign_rhs(field.ty);
        let field_ast = self.ast_acc;
        self.ast_assign();
        if let Some(value) = field_ast {
            // A bitfield member records its storage-unit descriptor so the
            // walker read-modify-writes the unit; a regular scalar stores
            // full-width.
            let bitfield = if field.bit_width > 0 {
                Some(super::super::ast::BitfieldDesc {
                    bit_offset: field.bit_offset as u8,
                    bit_width: field.bit_width as u8,
                    unit_size: field.bit_unit_size,
                    signed: !is_unsigned_ty(field.ty),
                })
            } else {
                None
            };
            self.pending_local_runtime_elements
                .push(super::super::ast::RuntimeInitElement {
                    offset: field_base,
                    value,
                    ty: field.ty,
                    bitfield,
                });
        }
        Ok(false)
    }

    /// Initialize one scalar / pointer leaf of type `ty` at target
    /// offset `at` (an absolute `self.data` index for `Data`, a byte
    /// offset relative to `local_val` for `Runtime`) from the current
    /// initializer position. The `Data` arm folds a constant leaf and
    /// stages its bytes; the `Runtime` arm evaluates the leaf as an
    /// assignment-expression and records a runtime store element.
    pub(super) fn init_leaf_scalar(
        &mut self,
        target: InitTarget,
        at: i64,
        ty: i64,
    ) -> Result<(), C5Error> {
        match target {
            InitTarget::Data { .. } => {
                let (value, reloc) = self.parse_constant_init_value()?;
                let size = self.size_of_type(ty);
                self.write_init_value(at as usize, size, value, reloc, ty);
                Ok(())
            }
            InitTarget::Runtime { local_val, .. } => {
                self.emit_lea(local_val);
                if at > 0 {
                    self.ast_psh();
                    self.emit_imm(at);
                    self.ast_binop(crate::c5::ir::BinOp::Add);
                }
                self.ast_psh();
                // Assignment precedence: a `,` between entries is the
                // list delimiter, not a comma operator.
                self.expr(Token::Assign as i64)?;
                // C99 6.7.9p11: convert as in assignment (integer leaf
                // of a floating member rounds through IEEE-754).
                self.convert_assign_rhs(ty);
                let v = self.ast_acc;
                self.ast_assign();
                if let Some(value) = v {
                    self.pending_local_runtime_elements.push(
                        super::super::ast::RuntimeInitElement {
                            offset: at,
                            value,
                            ty,
                            bitfield: None,
                        },
                    );
                }
                Ok(())
            }
        }
    }

    /// Emit one runtime scalar store `local[off] = expr` for an array
    /// element -- the shared runtime leaf, used by the array filler.
    pub(super) fn emit_array_leaf_runtime(
        &mut self,
        local_val: i64,
        off: i64,
        ty: i64,
    ) -> Result<(), C5Error> {
        self.init_leaf_scalar(InitTarget::Runtime { local_val, base: 0 }, off, ty)
    }

    /// Write `field_size` little-endian bytes of an initializer
    /// element of type `elem_ty` into `self.data` at byte offset
    /// `here`, then push the appropriate relocation if the value is a
    /// data offset (string / `&global`) or a code PC (function
    /// pointer). The value is converted to its storage bit pattern
    /// for `elem_ty` first (narrowing an f64 literal to f32 for a
    /// `float` element per C99 6.7.9), so a `float` struct field or
    /// designated element lands as the 4-byte f32 pattern rather than
    /// the low half of the f64 pattern. `to_storage_bits` is the
    /// identity for non-floating element types, so integer and
    /// pointer fields are unchanged.
    pub(super) fn write_init_value(
        &mut self,
        here: usize,
        field_size: usize,
        value: i64,
        reloc: InitElemReloc,
        elem_ty: i64,
    ) {
        let bits = self.to_storage_bits(value, reloc, elem_ty);
        self.write_init_bytes(here, bits, field_size);
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
        self.ast_psh();
        self.emit_data_imm(src_data_addr as i64);
        self.mark_emit_other();
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
        self.ast_psh();
        // C99 6.7.8p11: a scalar initializer is a single expression,
        // optionally enclosed in braces (`int x = { 42 };`, `char *p =
        // { "s" };`). Strip a single brace wrapper here so the scalar
        // path matches the file-scope handler in `parse_global_initializer`.
        let braced = self.lex.tk == '{';
        if braced {
            self.next()?; // consume `{`
        }
        self.expr(Token::Assign as i64)?;
        if braced {
            // A trailing `,` before `}` is allowed in C99.
            self.accept(',')?;
            if self.lex.tk != '}' {
                return Err(self.compile_err(
                    "scalar initializer wrapped in `{ ... }` must hold a single value",
                ));
            }
            self.next()?; // consume `}`
        }
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
            self.mark_emit_other();
        } else if (ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Char as i64 {
            self.ast_assign();
        } else if (ty & !(UNSIGNED_BIT | VOLATILE_BIT)) == Ty::Float as i64 {
            // `float`-typed local: narrow the accumulator (an f64
            // bit pattern from the RHS) to single-precision and
            // store 4 bytes. The slot reserved by
            // `local_storage_slots` is still an 8-byte c5 stack
            // word, so the upper 4 bytes stay whatever they were;
            // the matching `LoadKind::F32` reads only the low 4 and
            // widens them back to f64.
            self.ast_assign();
        } else {
            // Local int / long / pointer: the slot is a full c5
            // stack word (8 bytes), so a single `Si` writes the
            // whole slot. The narrower-width `Sw` would only
            // write the low 4 bytes and leave the high half as
            // whatever was in the slot, which would surface on
            // a later 8-byte Li -- but no caller of this helper
            // re-reads via Li, so the wide store is fine and the
            // existing optimizer recognises Si patterns.
            self.ast_assign();
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
}

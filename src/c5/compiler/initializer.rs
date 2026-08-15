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
use super::super::lexer::LexerSnapshot;
use super::super::token::{Token, Ty};
use super::AnonMember;
use super::Compiler;
use super::const_expr::ConstVal;
use super::types::{
    is_pointer_ty, is_struct_ty, is_struct_value_ty, is_unsigned_ty, narrow_const_int,
    strip_unsigned, struct_id_of, struct_ptr_depth,
};

/// A resolved chained array designator `[i][j]...`: `base` and
/// `range_end` are flat element indices at the level the run started
/// (`range_end == 0` for the single form), `depth` the levels it
/// descended below that level, and `element_chain` an unconsumed
/// `[` / `.` continuation into the element (the `=` was consumed
/// otherwise).
pub(super) struct ArrayDesignator {
    pub(super) base: i64,
    pub(super) range_end: i64,
    pub(super) depth: usize,
    pub(super) element_chain: bool,
}

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
    /// Value is a `&&label` block address (GCC labels as values) in the
    /// function being parsed; needs a `LabelReloc`. The payload is the
    /// label id, which the walker resolves to a basic block and native
    /// emit to a text offset.
    Label(crate::c5::ast::LabelId),
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

/// The sub-object a C99 6.7.8p7 designator list resolves to: its byte
/// offset and field record, plus the run a GNU `[lo ... hi]` step selects
/// (`extra` sub-objects after the first, `stride` bytes apart), which the
/// caller fills by re-parsing the entry value once per index.
pub(super) struct DesignatedSubobject {
    pub offset: i64,
    pub field: super::StructField,
    pub extra: i64,
    pub stride: i64,
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

/// Lengths of the append-only initializer output buffers plus the lexer
/// position, captured so a speculative measuring parse can be undone
/// exactly. See [`Compiler::init_checkpoint`].
pub(super) struct InitCheckpoint {
    lex: LexerSnapshot,
    next_ent_pc: usize,
    data: usize,
    data_object_starts: usize,
    data_relocs: usize,
    data_reloc_sym_idx: usize,
    code_relocs: usize,
    code_reloc_sym_idx: usize,
    extern_data_relocs: usize,
    pending_label_relocs: usize,
}

/// A `&&label` element staged while parsing a function body: the data
/// slot at `data_offset` holds the address of `label`'s code location
/// plus `addend`. Moved onto the finished function so the walk can
/// resolve the label to a basic block.
#[derive(Debug, Clone, Copy)]
pub(crate) struct PendingLabelReloc {
    pub data_offset: u64,
    pub label: crate::c5::ast::LabelId,
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
    ///   * `Label(id)`   -- `&&label`, stage a pending label reloc the
    ///                      function's walk resolves to a basic block.
    fn push_init_reloc(&mut self, here: usize, value: i64, reloc: InitElemReloc) {
        match reloc {
            InitElemReloc::None | InitElemReloc::Float64Bits => {}
            InitElemReloc::Data(src_sym) => {
                self.note_init_reloc(here);
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
                        let name: alloc::string::String = t.link_name().into();
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
                self.note_init_reloc(here);
                self.code_relocs.push(crate::c5::program::CodeReloc {
                    data_offset: here as u64,
                    target_ent_pc: value as u64,
                });
                self.code_reloc_sym_idx.push(sym_idx);
            }
            InitElemReloc::Label(label) => {
                self.note_init_reloc(here);
                self.pending_label_relocs.push(PendingLabelReloc {
                    data_offset: here as u64,
                    label,
                });
            }
        }
    }

    /// Record that a relocation now covers the data slot at `off`.
    pub(super) fn note_init_reloc(&mut self, off: usize) {
        self.init_reloc_slots.insert(off as u64);
    }

    /// True when a recorded initializer relocation lies in `[lo, hi)`.
    fn init_reloc_in(&self, lo: usize, hi: usize) -> bool {
        self.init_reloc_slots
            .range(lo as u64..hi as u64)
            .next()
            .is_some()
    }

    /// Release the slots in `[lo, hi)`.
    fn forget_init_relocs_in(&mut self, lo: usize, hi: usize) {
        let doomed: alloc::vec::Vec<u64> = self
            .init_reloc_slots
            .range(lo as u64..hi as u64)
            .copied()
            .collect();
        for off in doomed {
            self.init_reloc_slots.remove(&off);
        }
    }

    /// Drop any initializer relocation already recorded in the byte range
    /// `[lo, hi)`. A later designator for the same subobject (`[N].p = q`
    /// after a range fill already wrote `[N].p`) overwrites the bytes; the
    /// stale relocation must go too, or both apply and corrupt the slot.
    fn clear_init_relocs_in(&mut self, lo: usize, hi: usize) {
        self.forget_init_relocs_in(lo, hi);
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
        if self.extern_data_relocs.iter().any(|r| hit(r.data_offset)) {
            self.extern_data_relocs.retain(|r| !hit(r.data_offset));
        }
        if self.pending_label_relocs.iter().any(|r| hit(r.data_offset)) {
            self.pending_label_relocs.retain(|r| !hit(r.data_offset));
        }
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
        // A `static const char[]` (C99 6.4.2.2): its image is its value.
        self.const_data_ranges
            .push((offset, self.data.len() as i64));
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
    pub(super) fn to_storage_bits(&self, value: i128, reloc: InitElemReloc, elem_ty: i64) -> i128 {
        let stripped = strip_unsigned(elem_ty);
        let is_float = stripped == Ty::Float as i64;
        let is_double = stripped == Ty::Double as i64;
        if !is_float && !is_double {
            // A floating constant initializing an integer element
            // converts to the integer value (C99 6.3.1.4, truncation
            // toward zero); without this the raw IEEE-754 bit pattern
            // would land in the slot (e.g. `int a[] = {1.5}` -> 0).
            if matches!(reloc, InitElemReloc::Float64Bits) {
                return f64::from_bits(value as u64) as i128;
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
            InitElemReloc::None => (value as f64).to_bits() as i128,
            // Data / Code relocs land in pointer-typed slots, not
            // FP slots; the upstream paths reject the type mix
            // before reaching here.
            _ => return value,
        };
        if is_float {
            let f = f64::from_bits(f64_bits as u64) as f32;
            return f.to_bits() as i128;
        }
        f64_bits
    }

    /// Write `n_bytes` little-endian bytes of `value` into
    /// `self.data` at byte offset `here`. Caller has already
    /// grown `self.data` to at least `here + n_bytes`.
    fn write_init_bytes(&mut self, here: usize, value: i128, n_bytes: usize) {
        // C99 6.7.8p19: a later initializer for a subobject overrides the
        // earlier one. The bytes are about to be replaced, so the relocation
        // an overridden initializer recorded for them is stale and goes too.
        if self.init_reloc_in(here, here + n_bytes) {
            self.clear_init_relocs_in(here, here + n_bytes);
        }
        // `value` carries at most 16 significant bytes; zero a wider
        // destination's tail rather than wrapping the shift count.
        for i in 0..n_bytes {
            self.data[here + i] = if i < 16 { (value >> (i * 8)) as u8 } else { 0 };
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
    ) -> Result<Vec<(i128, InitElemReloc)>, C5Error> {
        self.with_nesting("initializer", |c| {
            c.collect_array_initializer_inner(elem_ty)
        })
    }

    /// Consume a chained array designator `[a][b]...` at a brace level
    /// whose dimensions below are `inner_dims` (C99 6.7.8p6; the GNU
    /// `[lo ... hi]` range only on the last subscript). Subscript `d`
    /// scales by the product of `inner_dims[d..]`; at most
    /// `inner_dims.len() + 1` subscripts index dimensions, a further
    /// `[` / `.` step belongs to the element and is left unconsumed
    /// with `element_chain` set. The trailing `=` is consumed
    /// otherwise. `None` when the entry carries no designator.
    pub(super) fn take_chained_array_designator(
        &mut self,
        inner_dims: &[i64],
    ) -> Result<Option<ArrayDesignator>, C5Error> {
        if self.lex.tk != Token::Brak {
            return Ok(None);
        }
        let mut base: i64 = 0;
        let mut range_end: i64 = 0;
        let mut depth: usize = 0;
        loop {
            self.next()?; // consume `[`
            let n = self.parse_constant_int_folding_const_objects()?;
            if n < 0 {
                return Err(self.compile_err(format!(
                    "array designator index must be non-negative (got {n})"
                )));
            }
            let scale: i64 = inner_dims.iter().skip(depth).product::<i64>().max(1);
            let mut hi = n;
            if self.lex.tk == Token::Ellipsis {
                self.next()?;
                hi = self.parse_constant_int_folding_const_objects()?;
                if hi < n {
                    return Err(
                        self.compile_err(format!("array range designator high {hi} below low {n}"))
                    );
                }
            }
            if self.lex.tk != ']' {
                return Err(self.compile_err("`]` expected after array designator index"));
            }
            self.next()?; // consume `]`
            base += n * scale;
            if hi > n {
                range_end = base + (hi - n) * scale + scale;
            }
            depth += 1;
            if self.lex.tk == Token::Brak && depth <= inner_dims.len() {
                if range_end > 0 {
                    return Err(self.compile_err("range designator must be the last subscript"));
                }
                continue;
            }
            break;
        }
        let desig = ArrayDesignator {
            base,
            range_end,
            depth: depth - 1,
            element_chain: self.lex.tk == Token::Brak || self.lex.tk == Token::Dot,
        };
        if !desig.element_chain {
            if self.lex.tk != Token::Assign {
                return Err(self.compile_err("`=` expected after `[N]` designator"));
            }
            self.next()?;
        }
        Ok(Some(desig))
    }

    fn collect_array_initializer_inner(
        &mut self,
        elem_ty: i64,
    ) -> Result<Vec<(i128, InitElemReloc)>, C5Error> {
        // 2D inner-dim hint -- callers set this when the declarator
        // shape is `T xs[N][M]` so a nested `{ row }` that lists
        // fewer than M values gets zero-padded per C99 6.7.8p21
        // (the remaining elements of an aggregate are initialised
        // implicitly to zero). Without padding, subsequent rows
        // shift into the previous row's tail and `xs[i][j]` reads
        // garbage. Read-and-clear so a recursive call into an
        // inner brace doesn't inherit it.
        let inner_dims = core::mem::take(&mut self.pending.init_inner_dims);
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
            // `wchar_t`-width array (wide string) takes a brace-wrapped
            // string. A pointer array (`char *names[] = {"a", "b"}` or
            // `CHAR16 *names[] = {L"a", L"b"}`) or a multi-dimensional char
            // array (`char c[2][6] = {"a", "b"}`, one string per row) has a
            // string as its first element and must stay a brace list. The
            // wide case mirrors the char case: the element is a scalar of the
            // wide-char width, not a pointer whose value happens to be a
            // string literal.
            let is_char_array = strip_unsigned(elem_ty) == Ty::Char as i64;
            let is_wchar_array = self.lex.str_is_wide
                && !is_pointer_ty(elem_ty)
                && self.size_of_type(elem_ty) == self.lex.str_elem_bytes;
            if inner_dims.is_empty() && self.lex.tk == '"' && (is_wchar_array || is_char_array) {
                brace_wrapped = true;
            } else {
                self.restore_lex(snap);
                self.truncate_data(data_snap);
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
            let is_char_array = strip_unsigned(elem_ty) == Ty::Char as i64;
            if self.lex.tk == '"' && (self.lex.str_is_wide || is_char_array) {
                paren_depth = depth;
            } else {
                self.restore_lex(snap);
                self.truncate_data(data_snap);
            }
        }
        if self.lex.tk == '"' && self.lex.str_is_wide {
            // C99 6.4.5 / 6.7.8p14: a wide string literal initializes a
            // `wchar_t`-shaped array. The lexer stored one code point
            // per element plus a terminator at the target's `wchar_t`
            // width; read them back at that stride.
            let w = self.lex.str_elem_bytes;
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
                    self.truncate_data(start_addr + elem_count * w);
                }
            }
            let elems: Vec<(i128, InitElemReloc)> = (0..elem_count)
                .map(|k| {
                    let base = start_addr + k * w;
                    let mut v: i64 = 0;
                    for b in 0..w {
                        v |= (self.data[base + b] as i64) << (b * 8);
                    }
                    (v as i128, InitElemReloc::None)
                })
                .collect();
            if brace_wrapped {
                self.expect_close_brace_after_wrapped_string()?;
            }
            self.expect_close_parens(paren_depth)?;
            return Ok(elems);
        }
        if self.lex.tk == '"' && strip_unsigned(elem_ty) == Ty::Char as i64 {
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
                self.push_literal_nul();
            }
            let elems: Vec<(i128, InitElemReloc)> = self.data[start_addr..]
                .iter()
                .map(|&b| (b as i128, InitElemReloc::None))
                .collect();
            if brace_wrapped {
                self.expect_close_brace_after_wrapped_string()?;
            }
            self.expect_close_parens(paren_depth)?;
            return Ok(elems);
        }
        // GCC "Compound Literals": an array initialized by a compound
        // literal of array type takes the literal's brace list, for static
        // and automatic storage alike (`static u8 m[6] = (u8[6]){ ... }`,
        // the shape a macro produces). Strip the cast so the list fills the
        // object in place; the grouping parens close after it.
        if self.lex.tk == '(' && self.skip_opt_compound_literal_cast()? {
            paren_depth += core::mem::take(&mut self.pending.compound_lit_close_parens) as usize;
        }
        if self.lex.tk != '{' {
            return Err(
                self.compile_err("array initializer must be a string literal or `{{ ... }}`")
            );
        }
        self.next()?;
        let mut elements: Vec<(i128, InitElemReloc)> = Vec::new();
        // C99 6.7.8 designated initializers: a `[N] = ...` clause
        // sets the write position to N; subsequent positional
        // entries (and chained `[K] = ...` clauses) continue
        // from there. Track the cursor here so designated and
        // positional entries can interleave per 6.7.8p17.
        let mut cursor: usize = 0;
        // Set by a GCC range designator `[a ... b] = value` to the
        // one-past-the-last scalar index the next value fills.
        let mut desig_range_end: Option<usize> = None;
        // Sub-array levels a chained designator descended (`[i][j] =` is
        // one below `[i] =`), so the value that follows spans that
        // level's row rather than this level's.
        let mut desig_depth: usize = 0;
        while self.lex.tk != '}' {
            // Array designator `[N] = ...`, optionally a GCC range
            // `[a ... b] = ...`, and optionally chained for a
            // multi-dimensional array (`[i][j] = value`, C99 6.7.8p6).
            // A `.field` step names a member the scalar element does not
            // have.
            let mut entry_designated = false;
            if let Some(d) = self.take_chained_array_designator(&inner_dims)? {
                if d.element_chain {
                    return Err(self.compile_err("`=` expected after `[N]` designator"));
                }
                entry_designated = true;
                cursor = d.base as usize;
                desig_range_end = if d.range_end > 0 {
                    Some(d.range_end as usize)
                } else {
                    None
                };
                desig_depth = d.depth;
            }
            // The level the entry that follows belongs to: one deeper per
            // extra chained subscript for a designated entry. C99 6.7.8p17
            // resumes a positional entry at the subobject after the one the
            // last designator named, so its level is the outermost one whose
            // row boundary the cursor sits on -- a whole-row span measured
            // from mid-row would advance the count past the object.
            let level = core::mem::replace(&mut desig_depth, 0);
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
                let level = if entry_designated {
                    level
                } else {
                    (0..=inner_dims.len())
                        .find(|&k| {
                            let s: usize = inner_dims[k..].iter().map(|&d| d as usize).product();
                            s > 0 && before.is_multiple_of(s)
                        })
                        .unwrap_or(inner_dims.len())
                };
                let dims_below = inner_dims.get(level..).unwrap_or(&[]);
                let span: usize = dims_below.iter().map(|&d| d as usize).product();
                self.pending.init_inner_dims = if dims_below.is_empty() {
                    alloc::vec::Vec::new()
                } else {
                    dims_below[1..].to_vec()
                };
                let inner = self.collect_array_initializer(elem_ty)?;
                let written = inner.len();
                // One sub-array copy spans its declared element count, or
                // its own length when the brace list is longer (no declared
                // inner dimension).
                let stride = span.max(written);
                // A range designator (`[a ... b] = { ... }`) replicates the
                // sub-array across every covered index; a plain designator or
                // positional entry writes it once (C99 6.7.8 with the GCC
                // range extension over an array of aggregates). A short brace
                // list zero-pads to `stride` per C99 6.7.8p21.
                let reps = match desig_range_end.take() {
                    Some(end) if stride > 0 && end > before => (end - before).div_ceil(stride),
                    _ => 1,
                };
                let total = before + reps * stride;
                if elements.len() < total {
                    elements.resize(total, (0, InitElemReloc::None));
                }
                for r in 0..reps {
                    let dst = before + r * stride;
                    for (i, &entry) in inner.iter().enumerate() {
                        elements[dst + i] = entry;
                    }
                }
                cursor = total;
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
                && strip_unsigned(elem_ty) == Ty::Char as i64
            {
                let row = inner_dims[0] as usize;
                let start_addr = self.take_concat_string_literal()?;
                let avail = self.data.len() - start_addr;
                let before = cursor;
                // A range designator (`[a ... b] = "..."`) replicates the row
                // across every covered index; a plain entry fills one row.
                let reps = match desig_range_end.take() {
                    Some(end) if row > 0 && end > before => (end - before).div_ceil(row),
                    _ => 1,
                };
                let total = before + reps * row;
                if elements.len() < total {
                    elements.resize(total, (0, InitElemReloc::None));
                }
                for r in 0..reps {
                    let dst = before + r * row;
                    for k in 0..row {
                        let b = if k < avail {
                            self.data[start_addr + k] as i64
                        } else {
                            0
                        };
                        elements[dst + k] = (b as i128, InitElemReloc::None);
                    }
                }
                // The string's bytes were appended to the data segment by
                // the lexer; they are copied into `elements` now, so drop
                // them to avoid an orphaned literal.
                self.truncate_data(start_addr);
                cursor = total;
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
                elements.resize(end, (0i128, InitElemReloc::None));
            }
            elements[cursor..end].fill((value, reloc));
            cursor = end;
            self.accept(',')?;
        }
        self.next()?; // consume `}`
        self.expect_close_parens(paren_depth)?;
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
        elements: &[(i128, InitElemReloc)],
    ) -> (usize, usize) {
        let elem_size = self.size_of_type(elem_ty);
        // The staged template's only consumer is an `Inst::Mcpy` into an
        // 8-byte-slotted frame local, which transfers in units up to 8
        // bytes; the source must satisfy the same alignment.
        self.align_data_to_8();
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
                self.push_init_reloc(here, v as i64, reloc);
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
    pub(super) fn parse_const_address(&mut self) -> Result<Option<(i64, usize, bool)>, C5Error> {
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
        let mut ampersands = 0usize;
        loop {
            if self.lex.tk == Token::AndOp {
                ampersands += 1;
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
                    let cast_ty = base + stars * (Ty::Ptr as i64);
                    if self.lex.tk == ')' && !is_struct_value_ty(cast_ty) {
                        // The cast retypes the address and so sets the
                        // stride of a following `+ N`: a pointer target
                        // strides by its pointee (C99 6.5.6p8), an integer
                        // target by bytes (6.3.2.3p6). Same rule the
                        // const-expr evaluator applies to `ConstAddr`.
                        cast_stride = Some(
                            if is_pointer_ty(cast_ty)
                                || (is_struct_ty(cast_ty) && struct_ptr_depth(cast_ty) > 0)
                            {
                                (self.size_of_type(cast_ty - Ty::Ptr as i64) as i64).max(1)
                            } else {
                                1
                            },
                        );
                        self.next()?; // consume `)`
                    } else {
                        // A more elaborate abstract declarator (function
                        // pointer, array). Skip the whole group by token
                        // balance; such casts do not appear before a
                        // pointer-arithmetic address constant.
                        self.restore_lex(paren_snap);
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
            self.restore_lex(snap);
            self.truncate_data(data_snap);
            return Ok(None);
        }
        let sym_idx = self.lex.curr_id_idx;
        if self.symbols[sym_idx].class != Token::Glo as i64 {
            self.restore_lex(snap);
            self.truncate_data(data_snap);
            return Ok(None);
        }
        let mut off = self.symbols[sym_idx].val;
        let mut cur_ty = self.symbols[sym_idx].type_;
        let base_zero_len = self.symbols[sym_idx].is_zero_len_array;
        // A subscript at level `i` of a multi-dimensional array strides by
        // `product(array_dims[i+1..]) * sizeof(element)` -- the first index
        // spans whole sub-arrays, the innermost one element (C99
        // 6.5.2.1p2). An empty `array_dims` is the 1D case. A `.field`
        // selection resets the dimension ladder to the field's own type.
        let mut cur_dims = self.symbols[sym_idx].array_dims.clone();
        // Element count of the current sub-object's array (a 1D array records
        // it here with an empty `array_dims`), used to report whether the
        // final sub-object still has an unsubscripted dimension.
        let mut cur_array_size = self.symbols[sym_idx].array_size;
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
                let n = self.parse_constant_int_folding_const_objects()?;
                if self.lex.tk != ']' {
                    self.restore_lex(snap);
                    self.truncate_data(data_snap);
                    return Ok(None);
                }
                self.next()?;
                off += n * elem_stride_at(cur_ty, &cur_dims, level, self);
                level += 1;
            } else if self.lex.tk == Token::Dot || self.lex.tk == Token::Arrow {
                self.next()?;
                if self.lex.tk != Token::Id || !(is_struct_value_ty(cur_ty)) {
                    self.restore_lex(snap);
                    self.truncate_data(data_snap);
                    return Ok(None);
                }
                let fname = self.symbols[self.lex.curr_id_idx].name.clone();
                let sid = struct_id_of(cur_ty);
                let Some(fpos) = self.structs[sid]
                    .fields
                    .iter()
                    .position(|f| f.name == fname)
                else {
                    self.restore_lex(snap);
                    self.truncate_data(data_snap);
                    return Ok(None);
                };
                let field = self.structs[sid].fields[fpos].clone();
                off += field.offset as i64;
                cur_ty = field.ty;
                cur_dims = field.array_dims.clone();
                cur_array_size = field.array_size;
                level = 0;
                self.next()?;
            } else if self.lex.tk == Token::AddOp || self.lex.tk == Token::SubOp {
                // C99 6.6: `&object + integer-constant`. The stride is
                // the cast's pointee size when present (the common
                // `(uint8_t*)&g + offset` byte form), else the size of the
                // current sub-object (one element at the current level).
                // A right operand that is not an integer constant (e.g.
                // another address, `&s.b - &s.a`) is left with its operator
                // for the caller's full evaluator, which folds the pointer
                // difference (6.5.6p9).
                let subtract = self.lex.tk == Token::SubOp;
                let op_snap = self.lex.snapshot();
                let op_data = self.data.len();
                self.next()?;
                let n = match self.parse_constant_int_folding_const_objects() {
                    Ok(n) => n,
                    Err(_) => {
                        self.restore_lex(op_snap);
                        self.truncate_data(op_data);
                        break;
                    }
                };
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
        // C99 6.3.2.1p3: the designation is an array object (an unsubscripted
        // dimension remains) that decays to the address of its first element.
        // The caller uses this to accept a bare `g.arr` pointer initializer.
        // A 1D array records its extent in `cur_array_size` with empty
        // `cur_dims` (`-1` for a flexible or zero-length member, which
        // still decays); a multi-dim one lists every dimension in
        // `cur_dims`. A zero-length base object records array-ness in
        // its own flag.
        let rank = if cur_dims.is_empty() {
            (cur_array_size != 0 || (level == 0 && base_zero_len)) as usize
        } else {
            cur_dims.len()
        };
        let final_is_array = level < rank;
        // An address constant needs an `&` or an array's decay (C99
        // 6.6p9, 6.3.2.1p3). A bare non-array designation names a
        // value: the caller's evaluator folds it when something (a
        // const-qualified scalar) makes it constant.
        if ampersands == 0 && !final_is_array {
            self.restore_lex(snap);
            self.truncate_data(data_snap);
            return Ok(None);
        }
        Ok(Some((off, sym_idx, final_is_array)))
    }

    /// Consume the not-taken arm of a constant conditional without
    /// requiring it to be a constant-init value: C99 6.6p3 admits
    /// otherwise-disallowed operators (e.g. a function call) in a
    /// subexpression that is not evaluated. The shared constant grammar
    /// consumes such an operand in unevaluated mode; on failure the
    /// lexer is restored and the caller falls back to parsing the arm
    /// as a full init value.
    fn skip_unevaluated_cond_arm(&mut self) -> Result<bool, C5Error> {
        // A failed attempt may have staged a compound literal's bytes and
        // relocations; roll back the full initializer state, not just the
        // lexer, or the stale relocations patch whatever lands at those
        // offsets next.
        let cp = self.init_checkpoint();
        let nonconst = self.pending.const_expr_nonconst;
        self.const_unevaluated += 1;
        let ok = self.parse_const_expr_cond_val().is_ok();
        self.const_unevaluated -= 1;
        if !ok {
            self.restore_init_checkpoint(cp);
            self.pending.const_expr_nonconst = nonconst;
        }
        Ok(ok)
    }

    /// Parse `cond`'s two arms with the selection already known: the taken
    /// arm is a full constant-init value, the not-taken arm is consumed
    /// unevaluated (with the init-value parse as a fallback for shapes the
    /// constant grammar does not cover). Returns `None` -- without a lexer
    /// guarantee -- when either parse fails; callers restore.
    fn parse_selected_cond_arms(
        &mut self,
        taken_first: bool,
    ) -> Result<Option<(i128, InitElemReloc)>, C5Error> {
        let mut selected: Option<(i128, InitElemReloc)> = None;
        if taken_first {
            if let Ok(v) = self.parse_constant_init_value()
                && self.lex.tk == ':'
            {
                self.next()?; // `:`
                if self.skip_unevaluated_cond_arm()? || self.parse_constant_init_value().is_ok() {
                    selected = Some(v);
                }
            }
        } else {
            let skipped = self.skip_unevaluated_cond_arm()?
                || self
                    .parse_constant_init_value()
                    .map(|_| true)
                    .unwrap_or(false);
            if skipped && self.lex.tk == ':' {
                self.next()?; // `:`
                if let Ok(v) = self.parse_constant_init_value() {
                    selected = Some(v);
                }
            }
        }
        Ok(selected)
    }

    /// Try to parse `cond ? A : B )` as a constant-init value, with the
    /// opening `(` already consumed. The condition is a constant integer;
    /// the selected arm is a constant-init value (an address constant or
    /// an integer), the other arm is consumed unevaluated. Returns the
    /// selected arm and consumes the closing `)`, or restores the lexer
    /// and returns `None` when the parens do not hold a conditional (so
    /// the caller's other paren handling runs).
    fn try_const_cond_init_value(&mut self) -> Result<Option<(i128, InitElemReloc)>, C5Error> {
        // Without a `?` at this depth there is no conditional; skip the
        // speculative parse (it would stage and roll back every nested
        // compound literal in the operand).
        if !self.lex.scan_ahead_for_cond(i64::from(
            self.lex.tk == '(' || self.lex.tk == '{' || self.lex.tk == Token::Brak,
        )) {
            return Ok(None);
        }
        // A bail-out may leave behind a speculatively staged compound
        // literal; restore the full initializer state.
        let cp = self.init_checkpoint();
        // The condition runs up to `?` (a logical-OR expression). A
        // non-integer leaf (e.g. a bare `(T*)&g` with no conditional)
        // makes the evaluator error; treat that as "not a conditional".
        let cond = match self.parse_const_expr_or() {
            Ok(c) => c,
            Err(_) => {
                self.restore_init_checkpoint(cp);
                return Ok(None);
            }
        };
        if self.lex.tk != Token::Cond {
            self.restore_init_checkpoint(cp);
            return Ok(None);
        }
        self.next()?; // consume `?`
        let selected = self.parse_selected_cond_arms(cond != 0)?;
        let Some(v) = selected else {
            self.restore_init_checkpoint(cp);
            return Ok(None);
        };
        if self.lex.tk != ')' {
            self.restore_init_checkpoint(cp);
            return Ok(None);
        }
        self.next()?; // consume the closing `)`
        Ok(Some(v))
    }

    pub(super) fn parse_constant_init_value(&mut self) -> Result<(i128, InitElemReloc), C5Error> {
        // A constant initializer's value position folds block-scope
        // `const` scalar objects (`static int x = h;` inside a function),
        // as GCC accepts; type dimensions nested in the value (a compound
        // literal's `[N]`) re-mask the fold (see `const_object_fold`).
        self.const_object_fold += 1;
        let r = self.parse_constant_init_value_inner();
        self.const_object_fold -= 1;
        r
    }

    fn parse_constant_init_value_inner(&mut self) -> Result<(i128, InitElemReloc), C5Error> {
        // C11 6.5.1.1 generic selection as an aggregate initializer
        // element: select the association, then evaluate the winning
        // expression as a constant (which may itself be an address).
        if self.lex.tk == Token::Generic {
            let after = self.generic_select_to_winner()?;
            let result = self.parse_constant_init_value()?;
            self.restore_lex(after);
            return Ok(result);
        }
        // `&(T){...}` -- the address of a compound literal, possibly with a
        // designator chain (`&((T){...}).member`) -- reaches the shared
        // constant-designation grammar through the `Token::AndOp` leaf
        // below, which handles the literal, grouping parens, and any
        // trailing `.member` / `[i]` steps in one pass (C99 6.5.2.5, 6.6p9).
        // A constant address of a global's sub-object: `&g.field`,
        // `g.array_field`, `(&buf[i])->field`. Takes priority over the
        // integer / `&global` leaves below, which only handle a whole
        // symbol with no member or index chain.
        if self.lex.tk == Token::AndOp || self.lex.tk == Token::Id || self.lex.tk == '(' {
            let snap = self.lex.snapshot();
            // A `:` or `)` terminator appears when this value is a
            // conditional arm (`cond ? &a : &b`) or a parenthesised leaf;
            // `,` / `}` terminate a brace-list element and `;` a scalar
            // declaration's initializer.
            if let Some((off, sym_idx, _)) = self.parse_const_address()?
                && (self.lex.tk == ','
                    || self.lex.tk == '}'
                    || self.lex.tk == ':'
                    || self.lex.tk == ')'
                    || self.lex.tk == ';')
            {
                return Ok((off as i128, InitElemReloc::Data(Some(sym_idx))));
            }
            self.restore_lex(snap);
        }
        // An unparenthesized constant conditional `cond ? A : B` whose arms
        // may be address constants -- a dispatch table's
        // `.fn = COND ? impl : NULL`. The integer/float const-expr evaluator
        // below handles only arithmetic arms, so fold the constant condition
        // here and take the selected arm as a full init value (which may be a
        // function pointer, `&global`, or an integer). The parenthesized form
        // `( cond ? A : B )` is handled by the paren path below. The
        // speculative parse can emit a compound literal (bytes and
        // relocations), so the bail-out restores a full checkpoint. A `?`
        // scan gates the attempt: without one the parse cannot commit.
        if self.lex.scan_ahead_for_cond(i64::from(
            self.lex.tk == '(' || self.lex.tk == '{' || self.lex.tk == Token::Brak,
        )) {
            let cp = self.init_checkpoint();
            let mut selected: Option<(i128, InitElemReloc)> = None;
            if let Ok(cond) = self.parse_const_expr_or()
                && self.lex.tk == Token::Cond
            {
                self.next()?; // `?`
                selected = self.parse_selected_cond_arms(cond != 0)?;
            }
            if let Some(v) = selected {
                return Ok(v);
            }
            self.restore_init_checkpoint(cp);
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
                return Ok((bits.to_bits() as i128, InitElemReloc::Float64Bits));
            }
            return Ok((v as i128, InitElemReloc::Float64Bits));
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
                    return Ok((folded.to_bits() as i128, InitElemReloc::Float64Bits));
                }
                return Ok((bits as i128, InitElemReloc::Float64Bits));
            }
            if self.lex.tk == Token::Num {
                self.restore_lex(snap);
                let v = self.parse_constant_i128()?;
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
                    return Ok((folded.to_bits() as i128, InitElemReloc::Float64Bits));
                }
                return Ok((bits as i128, InitElemReloc::Float64Bits));
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
                self.restore_lex(snap);
                let v = self.parse_constant_i128()?;
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
            self.restore_lex(snap);
            if signed_float_paren {
                let bits = self.parse_const_expr_add_val()?.as_float();
                return Ok((bits.to_bits() as i128, InitElemReloc::Float64Bits));
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
                self.pending.fn_ptr_ret_indirection = 0;
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
                    let r = self.parse_array_compound_literal(cast_ty)?;
                    if let (_, InitElemReloc::Data(Some(sym))) = r {
                        self.reject_automatic_compound_literal(sym)?;
                    }
                    return Ok(r);
                }
                // C99 6.5.2.5 scalar-typed compound literal `(T){ v }`: the
                // brace holds a single value; the result is that value
                // converted to `T`, keeping any relocation it carries.
                if self.lex.tk == ')' && !is_struct_value_ty(cast_ty) {
                    let paren_snap = self.lex.snapshot();
                    // The peeked token may be a string literal whose bytes
                    // the lexer stages; reclaim them on the non-`{` path.
                    let paren_data = self.data.len();
                    self.next()?;
                    if self.lex.tk == '{' {
                        self.next()?;
                        let (v, reloc) = self.parse_constant_init_value()?;
                        self.accept(',')?;
                        if self.lex.tk != '}' {
                            return Err(
                                self.compile_err("scalar compound literal holds a single value")
                            );
                        }
                        self.next()?;
                        let target_fp = matches!(
                            strip_unsigned(cast_ty),
                            t if t == Ty::Float as i64 || t == Ty::Double as i64
                        );
                        return Ok(match reloc {
                            InitElemReloc::None if target_fp => {
                                ((v as f64).to_bits() as i128, InitElemReloc::Float64Bits)
                            }
                            InitElemReloc::Float64Bits if !target_fp => {
                                let bytes = self.size_of_type(cast_ty);
                                let is_bool = strip_unsigned(cast_ty) == Ty::Bool as i64;
                                let n = f64::from_bits(v as u64) as i128;
                                (
                                    narrow_const_int(bytes, is_unsigned_ty(cast_ty), is_bool, n),
                                    InitElemReloc::None,
                                )
                            }
                            InitElemReloc::None => {
                                let bytes = self.size_of_type(cast_ty);
                                let is_bool = strip_unsigned(cast_ty) == Ty::Bool as i64;
                                (
                                    narrow_const_int(bytes, is_unsigned_ty(cast_ty), is_bool, v),
                                    InitElemReloc::None,
                                )
                            }
                            _ => (v, reloc),
                        });
                    }
                    self.restore_lex(paren_snap);
                    self.truncate_data(paren_data);
                }
                // Fold the whole element with the cast applied first: a cast
                // participating in arithmetic (`(char *)&s.b - (char *)&s.a`
                // strides by the cast's pointee, C99 6.5.6) must not be
                // discarded by the reloc-leaf shortcut below. Authoritative
                // only for an arithmetic result that consumed the whole
                // element and staged nothing: a parse that appended data (a
                // string literal, a compound literal) folded an address that
                // needs its relocation, so it falls through to the paths
                // that keep one.
                {
                    let cp = self.init_checkpoint();
                    let data_before = self.data.len();
                    self.restore_lex(snap);
                    let whole = self.parse_const_expr_cond_val();
                    let done = (self.lex.tk == ','
                        || self.lex.tk == '}'
                        || self.lex.tk == ';'
                        || self.lex.tk == ')'
                        || self.lex.tk == ':')
                        && self.data.len() == data_before;
                    match whole {
                        Ok(ConstVal::Float(f)) if done => {
                            return Ok((f.to_bits() as i128, InitElemReloc::Float64Bits));
                        }
                        Ok(v @ ConstVal::Int { .. }) if done => {
                            return Ok((v.as_i128(), InitElemReloc::None));
                        }
                        _ => self.restore_init_checkpoint(cp),
                    }
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
                    self.restore_lex(snap);
                    return match self.parse_const_expr_cond_val()? {
                        ConstVal::Float(f) => Ok((f.to_bits() as i128, InitElemReloc::Float64Bits)),
                        v => self.init_scalar_of(v),
                    };
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
            if let Some((v, reloc)) = self.try_const_cond_init_value()? {
                // A pure-integer parenthesized conditional may be followed by
                // any binary operator (`(cond ? a : b) * N`, `(cond ? a : b)
                // | N << 8`) or another `?:`; continue the full const-expr
                // chain so the trailing operators are absorbed rather than
                // left for the brace list to misread as extra elements.
                // `parse_const_expr_cond_from` returns the seed unchanged
                // when no operator follows. An address-valued arm is
                // returned as-is.
                if matches!(reloc, InitElemReloc::None) {
                    let folded = self.parse_const_expr_cond_from(ConstVal::Int {
                        val: v,
                        ty: Ty::Int as i64,
                    })?;
                    return Ok((folded.as_i128(), InitElemReloc::None));
                }
                return Ok((v, reloc));
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
                self.restore_lex(inner_snap);
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
                    return Ok((folded.to_bits() as i128, InitElemReloc::Float64Bits));
                }
                return Ok((v.to_bits() as i128, InitElemReloc::Float64Bits));
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
                // The peek may lex the string literal itself, staging its
                // bytes; reclaim them so only the real parse's copy stays.
                let peek_data = self.data.len();
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
                self.restore_lex(peek_snap);
                self.truncate_data(peek_data);
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
            self.restore_lex(snap);
            return self.parse_constant_init_scalar();
        }
        if self.lex.tk == '"' {
            let cp = self.init_checkpoint();
            let addr = self.lex.ival;
            self.next()?;
            while self.lex.tk == '"' {
                self.next()?;
            }
            self.push_literal_nul();
            // A subscripted literal (`"..."[i]`) is a constant byte value,
            // not an address; rewind past the staged bytes and let the
            // scalar evaluator fold it with any trailing operators.
            if self.lex.tk == Token::Brak {
                self.restore_init_checkpoint(cp);
                return self.parse_constant_init_scalar();
            }
            return Ok((addr as i128, InitElemReloc::Data(None)));
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
            let cp = self.init_checkpoint();
            let a = self.parse_const_address_of()?;
            // A trailing operator means the address is an operand of a
            // larger constant expression (`&s.b - &s.a`, C99 6.5.6p9);
            // rewind -- including any staged compound literal -- and let
            // the full evaluator fold it to an integer.
            let complete = self.lex.tk == ','
                || self.lex.tk == '}'
                || self.lex.tk == ';'
                || self.lex.tk == ')'
                || self.lex.tk == ':';
            if !complete {
                self.restore_init_checkpoint(cp);
                return self.parse_constant_init_scalar();
            }
            return Ok((a.value as i128, Self::init_elem_reloc_of(a)));
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
                return Ok((off as i128, InitElemReloc::Data(None)));
            }
            // An identifier followed by `(` is a call, not the symbol's
            // address: taking the branches below would consume the name
            // alone and leave the argument list to be misread as further
            // elements. A static initializer admits a call only when it
            // folds (C99 6.6p10) -- the constant evaluator owns which
            // builtins do -- so defer to it, and fall through when it
            // cannot, leaving the diagnostics below to report the shape.
            if self.lex.peek_after_whitespace(b'(') {
                let snap = self.lex.snapshot();
                let data_snap = self.data.len();
                let nonconst = self.pending.const_expr_nonconst;
                if let Ok(v) = self.parse_constant_i128() {
                    return Ok((v, InitElemReloc::None));
                }
                self.restore_lex(snap);
                self.truncate_data(data_snap);
                self.pending.const_expr_nonconst = nonconst;
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
                // The name may be an implementation builtin folding to an
                // integer constant expression (C99 6.6p10). That evaluator
                // owns which builtins fold, so defer rather than keep a
                // second set here; what it cannot fold is undeclared.
                let snap = self.lex.snapshot();
                let data_snap = self.data.len();
                let nonconst = self.pending.const_expr_nonconst;
                if let Ok(v) = self.parse_constant_i128() {
                    return Ok((v, InitElemReloc::None));
                }
                self.restore_lex(snap);
                self.truncate_data(data_snap);
                self.pending.const_expr_nonconst = nonconst;
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
                return Ok((ent_pc as i128, InitElemReloc::Code(idx)));
            }
            if class == Token::Num as i64 {
                // Integer constant -- either a bare enum / macro
                // value or the head of a constant arithmetic
                // expression (`E_A | E_B`, `K << 4`, ...). Defer
                // to the full integer-constant evaluator so any
                // trailing operator chain is folded in per C99
                // 6.6, instead of returning the head value and
                // leaving the operator to fail downstream.
                let v = self.parse_constant_i128()?;
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
                // A scalar global names its value, not its address (the
                // address spelling is `&name`): defer to the shared
                // evaluator, which folds a const-qualified object the
                // way gcc does and rejects the rest, absorbing any
                // trailing operator chain. Only an array (including a
                // zero-length one) decays here.
                if self.symbols[idx].array_size == 0 && !self.symbols[idx].is_zero_len_array {
                    return self.parse_constant_init_scalar();
                }
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
                    let n = self.parse_constant_int_folding_const_objects()?;
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
                return Ok((off as i128, InitElemReloc::Data(Some(idx))));
            }
            return Err(self.compile_err(format!(
                "identifier `{}` is not a constant-expression value",
                self.symbols[idx].name
            )));
        }
        // Fall back to the shared constant evaluator.
        self.parse_constant_init_scalar()
    }

    /// A scalar initializer element folded by the shared constant
    /// evaluator. C99 6.6p9 admits an integer constant expression added
    /// to an address constant in either order, so `N + &obj` reaches
    /// here with the integer leading and only the evaluator can tell the
    /// two apart.
    fn parse_constant_init_scalar(&mut self) -> Result<(i128, InitElemReloc), C5Error> {
        let v = self.parse_const_expr_cond_val()?;
        self.init_scalar_of(v)
    }

    /// The relocation an address constant's root calls for.
    fn init_elem_reloc_of(a: super::const_expr::ConstAddr) -> InitElemReloc {
        use super::const_expr::ConstRoot;
        match a.root {
            ConstRoot::None => InitElemReloc::None,
            ConstRoot::Data(idx) => InitElemReloc::Data(Some(idx)),
            ConstRoot::Code(idx) => InitElemReloc::Code(idx),
            ConstRoot::Label(l) => InitElemReloc::Label(l),
        }
    }

    /// A folded constant as an initializer element: a symbol-relative
    /// address carries its relocation, anything else is a plain value.
    fn init_scalar_of(&self, v: ConstVal) -> Result<(i128, InitElemReloc), C5Error> {
        if let ConstVal::Addr(a) = v
            && a.root.is_symbolic()
        {
            return Ok((a.value as i128, Self::init_elem_reloc_of(a)));
        }
        Ok((
            self.require_integer_const(v)?.as_i128(),
            InitElemReloc::None,
        ))
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
    ) -> Result<(i128, InitElemReloc), C5Error> {
        // Bracket run, outermost first; only the leading dimension may be
        // omitted (C99 6.7.5.2) and is then completed by the initializer.
        let mut dims: alloc::vec::Vec<i64> = alloc::vec::Vec::new();
        while self.lex.tk == Token::Brak {
            self.next()?; // consume `[`
            if self.lex.tk == ']' {
                if !dims.is_empty() {
                    return Err(self.compile_err("array type has an incomplete inner dimension"));
                }
                dims.push(-1);
            } else {
                // A type dimension: the const-object fold stays masked so
                // `(int[h]){...}` with a const local `h` is rejected as a
                // variably sized literal, as gcc rejects it.
                dims.push(self.with_const_object_fold_masked(|c| c.parse_constant_int())?);
                if self.lex.tk != ']' {
                    return Err(self.compile_err("`]` expected in array compound-literal type"));
                }
            }
            self.next()?; // consume `]`
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected to close compound-literal type"));
        }
        self.next()?; // consume `)`
        if self.lex.tk != '{' {
            return Err(self.compile_err("`{` expected to start compound-literal initializer"));
        }
        let elem_size = self.size_of_type(elem_ty);
        let elem_is_struct = is_struct_value_ty(elem_ty);
        let inner_span: i64 = dims[1..].iter().product::<i64>().max(1);
        // The element count must be known before the storage is reserved:
        // a struct element with a string-literal or `&global` field
        // appends to the data segment as it is filled, so per-element
        // offsets are computed as `off + i * elem_size`, not from the
        // live `self.data` length. A `[N]` designator can push the count
        // past the positional entry total (C99 6.7.8p22).
        let (scanned, _) = self.scan_array_init()?;
        let rows = self.designated_array_count(scanned, inner_span)?;
        let rows = rows.max(dims[0]).max(0);
        let count = (rows * inner_span) as usize;
        self.align_data_to_8();
        let off = self.data.len() as i64;
        for _ in 0..(count * elem_size) {
            self.data.push(0);
        }
        if elem_is_struct {
            let mut full_dims = alloc::vec::Vec::with_capacity(dims.len());
            full_dims.push(rows);
            full_dims.extend_from_slice(&dims[1..]);
            self.collect_struct_array_data(elem_ty, off, &full_dims)?;
        } else {
            self.pending.init_target_array_size = count as i64;
            self.pending.init_inner_dims = dims[1..].to_vec();
            let elements = self.collect_array_initializer(elem_ty)?;
            if elements.len() > count {
                return Err(self.compile_err("too many initializers for array compound literal"));
            }
            self.write_array_init_into_data(off, elem_ty, &elements);
        }
        // An empty element list reserves a slot of its own: the literal
        // is a distinct unnamed object (C99 6.5.2.5p3) and the data-object
        // model identifies an object by its start offset, so it must not
        // share one with whatever is placed next.
        if self.data.len() as i64 == off {
            self.data.push(0);
        }
        // Pad the anonymous array's storage up to an 8-byte boundary.
        while (self.data.len() as i64 - off) % 8 != 0 {
            self.data.push(0);
        }
        let sym_idx = self.intern_compound_literal_symbol(off, elem_ty, (count * elem_size) as i64);
        Ok((off as i128, InitElemReloc::Data(Some(sym_idx))))
    }

    /// Stage an array-typed compound literal `(T[]){...}` in the data segment
    /// (cursor on the leading `[` of the array declarator) and return its byte
    /// offset and interned symbol, for the constant-expression address path.
    pub(super) fn emit_array_compound_literal_body(
        &mut self,
        elem_ty: i64,
    ) -> Result<(i64, usize), C5Error> {
        match self.parse_array_compound_literal(elem_ty)? {
            (off, InitElemReloc::Data(Some(sym))) => Ok((off as i64, sym)),
            _ => Err(self.compile_err("array compound literal did not intern a symbol")),
        }
    }

    /// Create a synthetic internal `__compound.N` symbol anchored at
    /// data offset `off`, used as the relocation target for an
    /// anonymous compound literal stored in the data segment. `bytes` is
    /// the storage reserved for it -- the whole array for an array-typed
    /// literal, not its first element (C99 6.5.2.5) -- recorded on the
    /// symbol rather than re-derived from `ty`, which describes one
    /// element. Returns its symbol index.
    ///
    /// The symbol is registered against its storage so a truncation of
    /// the data segment retires it: a speculative parse stages literals
    /// it may roll back, and the offsets go on to unrelated objects.
    pub(super) fn intern_compound_literal_symbol(
        &mut self,
        off: i64,
        ty: i64,
        bytes: i64,
    ) -> usize {
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
            data_byte_size: bytes.max(0),
            linkage: crate::c5::symbol::Linkage::Internal,
            defined_here: true,
            has_initializer: true,
            is_compound_literal: true,
            ..Default::default()
        };
        self.symbols.push(sym);
        self.symbol_index.record(hash);
        // Ordered by offset: an inner literal staged while an outer one
        // fills is interned first, at the higher offset.
        let at = self.staged_literal_syms.partition_point(|&(v, _)| v <= off);
        self.staged_literal_syms.insert(at, (off, new_idx));
        new_idx
    }

    /// Emit a `(T){ ... }` compound-literal body -- entered with `tk` on the
    /// opening `{` and `cl_ty` the (struct) type. Reserve aligned storage in
    /// the data segment, intern an anonymous internal-linkage symbol for it,
    /// fill its bytes through the shared struct-initializer path, and return
    /// (its data offset, its symbol index) so the caller stores its address.
    /// Used by `&(T){...}` at file scope and as an aggregate element / member
    /// value; a nested `&(T){...}` inside recurses through the same path.
    pub(super) fn emit_compound_literal_body(
        &mut self,
        cl_ty: i64,
    ) -> Result<(i64, usize), C5Error> {
        self.align_data_to_8();
        // A zero-sized type still takes a slot: the literal is a distinct
        // unnamed object (C99 6.5.2.5p3) and the data-object model
        // identifies an object by its start offset.
        let size = self.size_of_type(cl_ty).max(1);
        let aligned = size.div_ceil(8) * 8;
        let off = self.data.len() as i64;
        for _ in 0..aligned {
            self.data.push(0);
        }
        let sym_idx = self.intern_compound_literal_symbol(off, cl_ty, size as i64);
        self.collect_struct_initializer(struct_id_of(cl_ty), off)?;
        Ok((off, sym_idx))
    }

    /// Walk a C99 6.7.8p7 designator-chain tail (the part after the
    /// first `.field` has already been consumed) and resolve it down
    /// to the final member: its absolute byte offset and its
    /// `StructField` record (so the caller sees array / bitfield
    /// shape, not just the element type). Accepts `.member` steps and
    /// `[index]` sub-array designators, one rank per index, in any
    /// mix (`.a[i][j]`, `.a[i].b`). The current type must be a
    /// value-typed struct or union for any `.` step.
    pub(super) fn resolve_nested_designator_chain(
        &mut self,
        mut cur_offset: i64,
        mut cur_ty: i64,
        entry_field: Option<super::StructField>,
    ) -> Result<DesignatedSubobject, C5Error> {
        // `entry_field` seeds the current object so a leading `[N]` step can
        // index an array member the caller already consumed (`.member[i]`,
        // where `.member` was read before this call). A `.member` step
        // overwrites it.
        let mut last: Option<super::StructField> = entry_field;
        let mut took_step = false;
        let mut extra: i64 = 0;
        let mut stride: i64 = 0;
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
                // C99 6.7.8p7 `.member[i]`: index the current array member,
                // one rank per designator. The element type is `cur_ty`; the
                // field record carries the dimensions (`array_size` is the
                // total element count, `array_dims` the per-rank list for a
                // multi-dimensional member), so each step scales by the
                // product of the remaining inner dimensions.
                let arr = match &last {
                    Some(f) if f.array_size > 0 => f.clone(),
                    _ => return Err(self.compile_err("`[N]` designator on a non-array field")),
                };
                let dims: Vec<i64> = if arr.array_dims.len() >= 2 {
                    arr.array_dims.clone()
                } else {
                    alloc::vec![arr.array_size]
                };
                let inner: i64 = dims[1..].iter().product::<i64>().max(1);
                self.next()?;
                let m = self.parse_constant_int_folding_const_objects()?;
                // GNU range designator `[lo ... hi]`: one entry value fills
                // every index in the range. A later step adds a constant
                // offset to each, so the run is carried as (count, stride)
                // and applied by the caller's re-parse loop.
                let mut hi = m;
                if self.lex.tk == Token::Ellipsis {
                    if extra != 0 {
                        return Err(self
                            .compile_err("two `[lo ... hi]` designators in one designator list"));
                    }
                    self.next()?;
                    hi = self.parse_constant_int_folding_const_objects()?;
                }
                if m < 0 || hi < m || hi >= dims[0] {
                    return Err(self.compile_err(format!(
                        "array designator index {m}..{hi} out of bounds [0, {})",
                        dims[0]
                    )));
                }
                if self.lex.tk != ']' {
                    return Err(self.compile_err("`]` expected after sub-designator index"));
                }
                self.next()?;
                let step = inner * self.size_of_type(cur_ty) as i64;
                cur_offset += m * step;
                if hi > m {
                    extra = hi - m;
                    stride = step;
                }
                // Drop the indexed rank: the remaining dims describe the
                // selected row, and a scalar leaf clears the array shape so
                // the value fill writes a single element.
                let mut elem = arr;
                elem.array_size = if dims.len() >= 2 { inner } else { 0 };
                elem.inner_array_size = if dims.len() >= 3 { dims[2] } else { 0 };
                elem.array_dims = if dims.len() >= 3 {
                    dims[1..].to_vec()
                } else {
                    Vec::new()
                };
                last = Some(elem);
            }
            took_step = true;
        }
        if !took_step {
            return Err(self.compile_err("empty designator chain after `.field`"));
        }
        let field =
            last.ok_or_else(|| self.compile_err("empty designator chain after `.field`"))?;
        Ok(DesignatedSubobject {
            offset: cur_offset,
            field,
            extra,
            stride,
        })
    }

    /// Continue a designator chain (`[i]`, `.inner`) from an already-selected
    /// member `entry` based at `entry_base`, consume the trailing `=`, and
    /// write the value through the shared member dispatch. The cursor is on
    /// the first `[`/`.` of the continuation. Shared by the top-level struct
    /// path and the flattened anonymous struct/union brace handlers so
    /// `.member[i]` / `.member.inner` designators (C99 6.7.8p7) resolve the
    /// same way in every initializer context.
    fn fill_member_designator_chain_t(
        &mut self,
        struct_id: usize,
        entry: &super::StructField,
        entry_base: usize,
        target: InitTarget,
    ) -> Result<(), C5Error> {
        let d =
            self.resolve_nested_designator_chain(entry_base as i64, entry.ty, Some(entry.clone()))?;
        if self.lex.tk != Token::Assign {
            return Err(self.compile_err("`=` expected after nested-designator chain"));
        }
        self.next()?;
        let value = self.lex.snapshot();
        for k in 0..=d.extra {
            if k > 0 {
                self.restore_lex(value);
            }
            // A pointer final member stores the address of a compound literal,
            // so keep the cast for the scalar leaf; a value member drops it.
            if is_pointer_ty(d.field.ty) || struct_ptr_depth(d.field.ty) > 0 {
                self.pending.compound_lit_close_parens = 0;
            } else {
                self.skip_opt_compound_literal_cast()?;
            }
            let chain_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
            self.fill_member_value_t(
                struct_id,
                &d.field,
                target,
                (d.offset + k * d.stride) as usize,
                false,
            )?;
            for _ in 0..chain_parens {
                self.accept(')')?;
            }
        }
        Ok(())
    }

    /// A compound array-element designator `[N].field... = v` in a struct
    /// array, entered with the cursor just past `[N]` on the leading
    /// `.`/`[`. Resolves the field chain from the element's base and writes
    /// one value there, overriding only that field -- the shape that fills
    /// every element with `[lo ... hi] = { ... }`, then overrides one field
    /// per element (`[k].field = ...`).
    pub(super) fn fill_element_field_designator(
        &mut self,
        struct_id: usize,
        elem_ty: i64,
        elem_base: i64,
    ) -> Result<(), C5Error> {
        self.fill_element_field_designator_t(
            struct_id,
            elem_ty,
            elem_base,
            InitTarget::Data {
                base: elem_base as usize,
            },
        )
    }

    /// [`Self::fill_element_field_designator`] against either target: an
    /// array whose element values are not all constant stages nothing, so
    /// the chain writes through the runtime store path instead.
    pub(super) fn fill_element_field_designator_t(
        &mut self,
        struct_id: usize,
        elem_ty: i64,
        elem_base: i64,
        target: InitTarget,
    ) -> Result<(), C5Error> {
        let d = self.resolve_nested_designator_chain(elem_base, elem_ty, None)?;
        if self.lex.tk != Token::Assign {
            return Err(self.compile_err("`=` expected after `[N].field` designator"));
        }
        self.next()?;
        let elem = self.size_of_type(d.field.ty);
        let span = if d.field.array_size > 0 {
            d.field.array_size as usize * elem
        } else {
            elem
        };
        let value = self.lex.snapshot();
        for k in 0..=d.extra {
            if k > 0 {
                self.restore_lex(value);
            }
            let off = (d.offset + k * d.stride) as usize;
            // A pointer final member stores the address of a compound literal,
            // so keep the cast for the scalar leaf; a value member drops it.
            if is_pointer_ty(d.field.ty) || struct_ptr_depth(d.field.ty) > 0 {
                self.pending.compound_lit_close_parens = 0;
            } else {
                self.skip_opt_compound_literal_cast()?;
            }
            let close_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
            if !target.is_runtime() {
                self.clear_init_relocs_in(off, off + span);
            }
            self.fill_member_value_t(struct_id, &d.field, target, off, false)?;
            for _ in 0..close_parens {
                self.accept(')')?;
            }
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
        let is_union = self.structs[struct_id].is_union;
        let n = self.structs[struct_id].fields.len();
        let mut total = 0usize;
        let mut i = 0usize;
        while i < n {
            // A promoted anonymous member is one member of this aggregate,
            // however many entries it contributed, and its own type says how
            // many slots it takes.
            if let Some(m) = self.anon_member_starting_at(struct_id, i) {
                total += self.struct_flat_init_slots(m.inner);
                i = m.first as usize + m.count as usize;
            } else {
                let f = &self.structs[struct_id].fields[i];
                let elem = if self.is_traversable_aggregate_ty(f.ty) {
                    self.struct_flat_init_slots(struct_id_of(f.ty))
                } else {
                    1
                };
                total += if f.array_size > 0 {
                    (f.array_size as usize) * elem
                } else {
                    elem
                };
                i += 1;
            }
            if is_union {
                break;
            }
        }
        total
    }

    /// The aggregate's flexible array member: a trailing `T v[]`
    /// (C99 6.7.2.1p16) or its GNU `T v[0]` spelling, both carried as
    /// `array_size < 0`. Only a trailing member is one. The same
    /// spelling earlier in the aggregate is a zero-storage position
    /// marker whose offset is not the fixed part's size, and the
    /// members after it hold the object's bytes.
    pub(super) fn flexible_array_member(&self, struct_id: usize) -> Option<&super::StructField> {
        self.structs[struct_id]
            .fields
            .last()
            .filter(|f| f.array_size < 0)
    }

    /// Whether member `idx` of `struct_id` is its flexible array member.
    pub(super) fn is_flexible_array_member(&self, struct_id: usize, idx: usize) -> bool {
        let fields = &self.structs[struct_id].fields;
        idx + 1 == fields.len() && fields[idx].array_size < 0
    }

    /// Bytes a definition of type `ty` adds past `sizeof` for its
    /// flexible array member's initializer. The lexer must be at the
    /// `=` of the definition and is left there. 0 when `ty` is not a
    /// FAM-bearing struct, the declaration has no initializer, or the
    /// initializer does not reach the member. The object's storage
    /// reservation and its recorded byte size both take this term:
    /// C99 6.7.2.1p16 keeps the member out of `sizeof`, but the object
    /// still occupies the initialized elements, and the following
    /// object starts past them.
    pub(super) fn flexible_array_init_tail_bytes(&mut self, ty: i64) -> Result<i64, C5Error> {
        if !is_struct_ty(ty) || struct_ptr_depth(ty) != 0 || self.lex.tk != Token::Assign {
            return Ok(0);
        }
        let sid = struct_id_of(ty);
        let Some(elem_ty) = self.flexible_array_member(sid).map(|f| f.ty) else {
            return Ok(0);
        };
        let elem = self.size_of_type(elem_ty) as i64;
        let snap = self.lex.snapshot();
        self.next()?; // `=`
        let count = self.flexible_array_init_count(sid)? as i64;
        self.restore_lex(snap);
        Ok(count * elem)
    }

    /// Count the elements a struct's flexible array member (`T v[]`,
    /// C99 6.7.2.1) is initialized with. An object of a FAM-bearing
    /// struct is laid out as if the member were a fixed
    /// array sized to its initializer; the storage reservation must
    /// include those element bytes *before* the field fill runs, or an
    /// earlier field's string literal is appended into that trailing
    /// region and then overwritten by the member's data.
    ///
    /// The count is obtained by running the ordinary struct-initializer
    /// descent speculatively against a scratch tail of the data segment,
    /// so a positional member, a `.<fam> =` designator, brace elision,
    /// and string / struct element forms are all counted exactly as the
    /// real fill lays them out. Every speculative write is rolled back
    /// through [`InitCheckpoint`]. The lexer must be at the struct
    /// initializer's opening `{`; it is restored before returning.
    /// Returns 0 when the struct has no FAM or the initializer does not
    /// reach it.
    pub(super) fn flexible_array_init_count(&mut self, sid: usize) -> Result<usize, C5Error> {
        let Some(fam_offset) = self.flexible_array_member(sid).map(|f| f.offset) else {
            return Ok(0);
        };
        if self.lex.tk != '{' {
            return Ok(0);
        }
        let cp = self.init_checkpoint();
        // Reserve the fixed part so the non-FAM members' writes land in
        // bounds, then let the FAM fill grow the tail. The FAM's offset
        // is not that size on its own: sharing a union with a wider arm
        // puts members past it, so take the aggregate's size too.
        let scratch = self.data.len();
        let fixed = fam_offset.max(self.structs[sid].size);
        self.data.resize(scratch + fixed, 0);
        self.flex_array_measured_count = None;
        let filled = self.collect_struct_initializer(sid, scratch as i64);
        // A genuine initializer error is left for the real fill to report
        // with an accurate source position; the under-count it yields is
        // moot because that fill then aborts the compile.
        let count = if filled.is_ok() {
            self.flex_array_measured_count
        } else {
            None
        };
        self.restore_init_checkpoint(cp);
        Ok(count.unwrap_or(0))
    }

    /// Capture the lengths of every append-only initializer output
    /// buffer plus the lexer position, so a speculative measuring parse
    /// can be undone exactly. The lexer snapshot does not cover these
    /// compiler-owned buffers, and identifier interning done during the
    /// parse is left in place (it is idempotent -- a later lex of the
    /// same name reuses the entry).
    pub(super) fn init_checkpoint(&self) -> InitCheckpoint {
        InitCheckpoint {
            lex: self.lex.snapshot(),
            next_ent_pc: self.next_ent_pc,
            data: self.data.len(),
            data_object_starts: self.data_object_starts.len(),
            data_relocs: self.data_relocs.len(),
            data_reloc_sym_idx: self.data_reloc_sym_idx.len(),
            code_relocs: self.code_relocs.len(),
            code_reloc_sym_idx: self.code_reloc_sym_idx.len(),
            extern_data_relocs: self.extern_data_relocs.len(),
            pending_label_relocs: self.pending_label_relocs.len(),
        }
    }

    pub(super) fn restore_init_checkpoint(&mut self, cp: InitCheckpoint) {
        self.restore_lex(cp.lex);
        self.next_ent_pc = cp.next_ent_pc;
        // The records below are about to go, so their slots are free
        // again. One record per slot, so releasing a popped record's
        // offset cannot release a surviving record's.
        let mut popped = alloc::vec::Vec::new();
        let off = |r: &crate::c5::program::DataReloc| r.data_offset;
        popped.extend(self.data_relocs.iter().skip(cp.data_relocs).map(off));
        popped.extend(
            self.code_relocs
                .iter()
                .skip(cp.code_relocs)
                .map(|r| r.data_offset),
        );
        popped.extend(
            self.extern_data_relocs
                .iter()
                .skip(cp.extern_data_relocs)
                .map(|r| r.data_offset),
        );
        popped.extend(
            self.pending_label_relocs
                .iter()
                .skip(cp.pending_label_relocs)
                .map(|r| r.data_offset),
        );
        for slot in popped {
            self.init_reloc_slots.remove(&slot);
        }
        self.truncate_data(cp.data);
        self.data_object_starts.truncate(cp.data_object_starts);
        self.data_relocs.truncate(cp.data_relocs);
        self.data_reloc_sym_idx.truncate(cp.data_reloc_sym_idx);
        self.code_relocs.truncate(cp.code_relocs);
        self.code_reloc_sym_idx.truncate(cp.code_reloc_sym_idx);
        self.extern_data_relocs.truncate(cp.extern_data_relocs);
        self.pending_label_relocs.truncate(cp.pending_label_relocs);
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

    /// Fill a (possibly multi-dimensional) array of structs from a brace
    /// list. `elem_ty` is the element struct type; `dims` lists the
    /// remaining dimensions, outermost first; `base` is the sub-array's
    /// data offset. Consumes the opening `{` through the matching `}`.
    /// Each entry may be positional, `[N] =`, `[lo ... hi] =` (the value
    /// re-parsed per index), a chained `[i][j]... =` naming a deeper
    /// sub-object, or a subscript run ending in a `.field` chain
    /// (C99 6.7.8p6/p7/p17-p21 with the GCC range extension).
    pub(super) fn collect_struct_array_data(
        &mut self,
        elem_ty: i64,
        base: i64,
        dims: &[i64],
    ) -> Result<(), C5Error> {
        if self.lex.tk != '{' {
            return Err(self.compile_err("array initializer must start with `{{`"));
        }
        self.next()?;
        self.with_nesting("initializer", |c| {
            c.collect_struct_array_entries(elem_ty, base, dims)
        })?;
        Ok(())
    }

    /// The entry loop of [`Self::collect_struct_array_data`], entered past
    /// the opening `{`; consumes through the matching `}`. Returns the
    /// one-past-the-highest flat element index the list initialized, for
    /// the deferred-size outer dimension (C99 6.7.8p22).
    pub(super) fn collect_struct_array_entries(
        &mut self,
        elem_ty: i64,
        base: i64,
        dims: &[i64],
    ) -> Result<i64, C5Error> {
        self.collect_struct_array_entries_braced(elem_ty, base, dims, true)
    }

    /// [`Self::collect_struct_array_entries`], plus the C99 6.7.9p20
    /// brace-elided form: a sub-array with no braces of its own takes as
    /// many entries as it holds from the enclosing list and leaves the
    /// rest, so the loop ends at its element count rather than at a `}`
    /// and consumes no closing brace.
    pub(super) fn collect_struct_array_entries_braced(
        &mut self,
        elem_ty: i64,
        base: i64,
        dims: &[i64],
        braced: bool,
    ) -> Result<i64, C5Error> {
        let sid = struct_id_of(elem_ty);
        let elem_size = self.size_of_type(elem_ty) as i64;
        let child = &dims[1..];
        let child_span: i64 = child.iter().product::<i64>().max(1);
        let stride = elem_size * child_span;
        let total = dims[0] * child_span;
        // Flat element cursor: a chained designator leaves it just past
        // the designated subobject, so a positional entry resumes there
        // (C99 6.7.8p17), at the outermost level whose row boundary the
        // cursor sits on. `high` tracks the extent for a deferred outer
        // dimension.
        let mut cursor: i64 = 0;
        let mut high: i64 = 0;
        while self.lex.tk != '}' && (braced || cursor < total) {
            if let Some((lo, hi, chain)) = self.take_struct_array_designator(dims[0])? {
                if chain && hi > lo {
                    // `[lo ... hi].field = v` replicates the member fill
                    // across the range, re-parsing the value per index.
                    if dims.len() != 1 {
                        return Err(self
                            .compile_err("`[lo ... hi].field` requires a single-dimension level"));
                    }
                    for e in lo..=hi {
                        let snap = self.lex.snapshot();
                        self.fill_element_field_designator(sid, elem_ty, base + e * stride)?;
                        if e < hi {
                            self.restore_lex(snap);
                        }
                    }
                    cursor = (hi + 1) * child_span;
                } else if chain {
                    let end =
                        self.fill_struct_array_designated(elem_ty, base + lo * stride, child)?;
                    cursor = (end - base) / elem_size;
                } else if hi > lo {
                    for e in lo..=hi {
                        let snap = self.lex.snapshot();
                        let here = base + e * stride;
                        if child.is_empty() {
                            self.init_struct_array_element(sid, here)?;
                        } else {
                            self.collect_struct_array_data(elem_ty, here, child)?;
                        }
                        if e < hi {
                            self.restore_lex(snap);
                        }
                    }
                    cursor = (hi + 1) * child_span;
                } else {
                    let here = base + lo * stride;
                    if child.is_empty() {
                        self.init_struct_array_element(sid, here)?;
                    } else {
                        self.collect_struct_array_data(elem_ty, here, child)?;
                    }
                    cursor = (lo + 1) * child_span;
                }
                high = high.max(cursor);
                self.accept(',')?;
                continue;
            }
            if cursor >= total {
                return Err(self.compile_err("too many initializers for array"));
            }
            // The rank a positional entry fills: the outermost level whose
            // row boundary the cursor sits on; mid-row it names a deeper
            // subobject, down to a single element.
            let level = (0..=child.len())
                .find(|&k| {
                    let s: i64 = child[k..].iter().product();
                    s > 0 && cursor % s == 0
                })
                .unwrap_or(child.len());
            let sub = &child[level..];
            let here = base + cursor * elem_size;
            if sub.is_empty() {
                self.init_struct_array_element(sid, here)?;
            } else if self.lex.tk == '{' {
                self.collect_struct_array_data(elem_ty, here, sub)?;
            } else {
                self.collect_struct_array_entries_braced(elem_ty, here, sub, false)?;
            }
            cursor += sub.iter().product::<i64>().max(1);
            high = high.max(cursor);
            self.accept(',')?;
        }
        if braced {
            self.next()?; // consume `}`
        }
        Ok(high)
    }

    /// Take an `[N]` / `[lo ... hi]` designator at the current level, the
    /// cursor left after the `]`. Returns `(lo, hi, chain)`: `chain` is true
    /// when the designator continues (`[..][..]` / `[..].field`) and the
    /// continuation plus its `=` and value are left for
    /// [`Self::fill_struct_array_designated`]; otherwise the `=` is consumed.
    fn take_struct_array_designator(
        &mut self,
        count: i64,
    ) -> Result<Option<(i64, i64, bool)>, C5Error> {
        if self.lex.tk != Token::Brak {
            return Ok(None);
        }
        self.next()?; // `[`
        let lo = self.parse_constant_int_folding_const_objects()?;
        let mut hi = lo;
        if self.lex.tk == Token::Ellipsis {
            self.next()?;
            hi = self.parse_constant_int_folding_const_objects()?;
        }
        if lo < 0 || hi < lo || hi >= count {
            return Err(self.compile_err(format!(
                "array designator index {lo}..{hi} out of bounds [0, {count})"
            )));
        }
        if self.lex.tk != ']' {
            return Err(self.compile_err("`]` expected after array designator index"));
        }
        self.next()?; // `]`
        if self.lex.tk == Token::Brak || self.lex.tk == Token::Dot {
            if hi > lo && self.lex.tk == Token::Brak {
                return Err(
                    self.compile_err("`[lo ... hi]` range cannot combine with a further subscript")
                );
            }
            return Ok(Some((lo, hi, true)));
        }
        if self.lex.tk != Token::Assign {
            return Err(self.compile_err("`=` expected after `[N]` designator"));
        }
        self.next()?; // `=`
        Ok(Some((lo, hi, false)))
    }

    /// Continue a designator chain below a consumed subscript: the
    /// sub-object at `at` has dimensions `dims_below` (empty for a single
    /// element). Further `[k]` steps descend; a `.field` chain resolves a
    /// member; the terminating `=` takes a value for the designated
    /// sub-object (C99 6.7.8p7). Returns the byte offset one past the
    /// designated sub-object, where a positional entry resumes (p17).
    fn fill_struct_array_designated(
        &mut self,
        elem_ty: i64,
        at: i64,
        dims_below: &[i64],
    ) -> Result<i64, C5Error> {
        let sid = struct_id_of(elem_ty);
        let elem_size = self.size_of_type(elem_ty) as i64;
        if self.lex.tk == Token::Brak {
            if dims_below.is_empty() {
                // Element-level `[k]` continues into an array member
                // (`[i][j].arr[k] = v` has a leading `.`; a direct `[k]`
                // on a struct element is invalid).
                return Err(self.compile_err("`[` designator on a non-array element"));
            }
            self.next()?; // `[`
            let n = self.parse_constant_int_folding_const_objects()?;
            if n < 0 || n >= dims_below[0] {
                return Err(self.compile_err(format!(
                    "array designator index {n} out of bounds [0, {})",
                    dims_below[0]
                )));
            }
            if self.lex.tk != ']' {
                return Err(self.compile_err("`]` expected after array designator index"));
            }
            self.next()?; // `]`
            let stride = elem_size * dims_below[1..].iter().product::<i64>().max(1);
            return self.fill_struct_array_designated(elem_ty, at + n * stride, &dims_below[1..]);
        }
        if self.lex.tk == Token::Dot {
            if !dims_below.is_empty() {
                return Err(
                    self.compile_err("`.field` designator requires indexing down to one element")
                );
            }
            self.fill_element_field_designator(sid, elem_ty, at)?;
            return Ok(at + elem_size);
        }
        if self.lex.tk != Token::Assign {
            return Err(self.compile_err("`=` expected after designator chain"));
        }
        self.next()?; // `=`
        if dims_below.is_empty() {
            self.init_struct_array_element(sid, at)?;
            Ok(at + elem_size)
        } else {
            self.collect_struct_array_data(elem_ty, at, dims_below)?;
            Ok(at + elem_size * dims_below.iter().product::<i64>().max(1))
        }
    }

    /// Non-destructive: the struct id named by a compound-literal cast
    /// `(T){ ... }` at the current position (possibly behind grouping
    /// parens), when `T` is a struct/union value type. `None` otherwise.
    /// The lexer is restored before returning.
    pub(super) fn peek_element_compound_literal_sid(&mut self) -> Result<Option<usize>, C5Error> {
        if self.lex.tk != '(' {
            return Ok(None);
        }
        let snap = self.lex.snapshot();
        loop {
            self.next()?; // consume `(`
            if self.lex.tk != '(' {
                break;
            }
        }
        // C99 6.7.7p1: a type-name is a specifier-qualifier-list, so
        // qualifiers may lead it without changing the type it names.
        while self.lex.tk == Token::TypeQual {
            self.next()?;
        }
        let sid = if self.lex.tk == Token::Struct as i64 || self.lex.tk == Token::Union as i64 {
            self.next()?;
            if self.lex.tk == Token::Id {
                let name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.find_struct_id(&name)
            } else {
                None
            }
        } else if self.is_lex_typedef_name() {
            let ty = self.symbols[self.lex.curr_id_idx].type_;
            if is_struct_value_ty(ty) {
                Some(struct_id_of(ty))
            } else {
                None
            }
        } else {
            None
        };
        self.restore_lex(snap);
        Ok(sid)
    }

    /// Initialize one struct array element at `here` from the current
    /// brace-list position. The element may be a braced initializer
    /// (`{ ... }`), a brace-elided flat run of field values (C99
    /// 6.7.8p20), or a whole-element compound literal `(T){ ... }` (C99
    /// 6.5.2.5) whose type names the element's own struct. A `(U){ ... }`
    /// naming a different type is the initializer of the element's first
    /// field under brace elision, so it is left for `fill_struct_fields`.
    /// (A by-value field cannot have the element's own struct type, so
    /// the type match is unambiguous.)
    pub(super) fn init_struct_array_element(
        &mut self,
        struct_id: usize,
        here: i64,
    ) -> Result<(), C5Error> {
        if self.peek_element_compound_literal_sid()? == Some(struct_id) {
            self.skip_opt_compound_literal_cast()?;
            let close_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
            self.collect_struct_initializer(struct_id, here)?;
            for _ in 0..close_parens {
                self.accept(')')?;
            }
            return Ok(());
        }
        if self.lex.tk == '{' {
            self.collect_struct_initializer(struct_id, here)?;
        } else {
            self.fill_struct_fields(struct_id, here, false)?;
        }
        Ok(())
    }

    /// The runtime twin of `init_struct_array_element`: fill one struct array
    /// element with non-constant values at `off` from the current brace-list
    /// position. Accepts a whole-element compound literal `(T){ ... }` (C99
    /// 6.5.2.5) naming the element's own type, a braced initializer, or a
    /// brace-elided flat run (6.7.8p20).
    pub(super) fn emit_struct_array_element_runtime(
        &mut self,
        local_val: i64,
        off: i64,
        sid: usize,
    ) -> Result<(), C5Error> {
        if self.peek_element_compound_literal_sid()? == Some(sid) {
            self.skip_opt_compound_literal_cast()?;
            let close_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
            self.emit_struct_runtime_at(local_val, off, sid, true)?;
            for _ in 0..close_parens {
                self.accept(')')?;
            }
        } else {
            let braced = self.lex.tk == '{';
            self.emit_struct_runtime_at(local_val, off, sid, braced)?;
        }
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
            self.restore_lex(snap);
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
            // C99 6.5.2.5p1: `( type-name ){ ... }` is a primary expression.
            // Elide the redundant `( type-name )` cast and let the brace list
            // fill the member in place only when the literal is the complete
            // value -- a terminator (`,`/`}`/`;`/`)`/`]` or end of input)
            // follows it and its grouping parens. When a postfix
            // (`.`/`->`/`[`/`(`/`++`/`--`) or an operator continues the
            // literal it is a sub-expression, so the whole run goes to the
            // expression parser instead. The `;` terminator matters because
            // this detector also fronts the outer literal of a declaration
            // initializer (`T v = (T){ ... };`).
            let at_brace = self.lex.snapshot();
            // `next` appends string literals to `data`; this is a lookahead, so
            // record the length and truncate any bytes the scan appends before
            // the real parse re-reads the same tokens.
            let data_mark = self.data.len();
            let mut brace_depth: i64 = 0;
            while self.lex.tk != 0 {
                if self.lex.tk == '{' {
                    brace_depth += 1;
                } else if self.lex.tk == '}' {
                    brace_depth -= 1;
                    if brace_depth == 0 {
                        self.next()?; // past the literal's closing `}`
                        break;
                    }
                }
                self.next()?;
            }
            for _ in 0..grouping {
                if self.lex.tk == ')' {
                    self.next()?;
                }
            }
            let complete = self.lex.tk == 0
                || self.lex.tk == ','
                || self.lex.tk == '}'
                || self.lex.tk == ';'
                || self.lex.tk == ')'
                || self.lex.tk == ']';
            self.truncate_data(data_mark);
            if complete {
                self.restore_lex(at_brace);
                self.pending.compound_lit_close_parens = grouping;
                return Ok(true);
            }
            self.restore_lex(snap);
            return Ok(false);
        }
        self.restore_lex(snap);
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
        inner_dims: &[i64],
    ) -> Result<(), C5Error> {
        let elem_size = self.size_of_type(elem_ty);
        let grow_to = |data: &mut alloc::vec::Vec<u8>, end: usize| {
            if data.len() < end {
                data.resize(end, 0);
            }
        };
        // Multi-dimensional struct flexible array member
        // (`struct S v[][M]`): each top-level entry is a row of `M`
        // structs. Grow the storage per row and fill each through the
        // shared struct-array walker; the measured count is the flat
        // element total, matching the one-dimensional struct case.
        if !inner_dims.is_empty() && self.lex.tk == '{' && is_struct_value_ty(elem_ty) {
            self.next()?; // outer `{`
            let row_span: usize = inner_dims.iter().map(|&d| d as usize).product();
            let row_bytes = row_span * elem_size;
            let mut row: i64 = 0;
            let mut rows: i64 = 0;
            while self.lex.tk != '}' {
                if let Some((lo, hi, chain)) = self.take_struct_array_designator(i64::MAX)? {
                    if chain {
                        return Err(self.compile_err(
                            "designator chain on a flexible-array row is not supported",
                        ));
                    }
                    for e in lo..=hi {
                        let snap = self.lex.snapshot();
                        let here = field_base + e as usize * row_bytes;
                        grow_to(&mut self.data, here + row_bytes);
                        self.collect_struct_array_data(elem_ty, here as i64, inner_dims)?;
                        if e < hi {
                            self.restore_lex(snap);
                        }
                    }
                    row = hi + 1;
                } else {
                    let here = field_base + row as usize * row_bytes;
                    grow_to(&mut self.data, here + row_bytes);
                    self.collect_struct_array_data(elem_ty, here as i64, inner_dims)?;
                    row += 1;
                }
                rows = rows.max(row);
                self.accept(',')?;
            }
            self.next()?; // consume `}`
            self.flex_array_measured_count = Some(rows as usize * row_span);
            return Ok(());
        }
        // Multi-dimensional flexible array member (`T v[][M]`): each
        // element of the flexible outer dimension is itself a sub-array.
        // The general array collector fills a brace list of arbitrary rank,
        // zero-padding short rows (C99 6.7.8p21); write its flat leaves into
        // the member and record the scalar-leaf count the enclosing object
        // uses to size its tail (bytes = count * sizeof(base element)).
        if !inner_dims.is_empty() && self.lex.tk == '{' && !(is_struct_value_ty(elem_ty)) {
            self.pending.init_inner_dims = inner_dims.to_vec();
            let elems = self.collect_array_initializer(elem_ty)?;
            grow_to(&mut self.data, field_base + elems.len() * elem_size);
            self.write_array_init_into_data(field_base as i64, elem_ty, &elems);
            self.flex_array_measured_count = Some(elems.len());
            return Ok(());
        }
        if self.lex.tk == '"' && strip_unsigned(elem_ty) == Ty::Char as i64 {
            let start_addr = self.take_concat_string_literal()?;
            self.push_literal_nul(); // ensure NUL terminator in the literal's bytes
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
            self.flex_array_measured_count = Some(idx);
            return Ok(());
        }
        if self.lex.tk != '{' {
            return Err(self
                .compile_err("flexible array member initializer must be a brace list or string"));
        }
        self.next()?;
        let elem_is_struct = is_struct_value_ty(elem_ty);
        let mut idx = 0usize;
        let mut count = 0usize;
        while self.lex.tk != '}' {
            // C99 6.7.8p7 array designator `[index] = value` (GCC also
            // allows the range form `[lo ... hi]`): set the element the
            // value fills; a positional element continues after it.
            let mut range_hi = idx;
            if self.lex.tk == Token::Brak {
                self.next()?; // consume `[`
                let n = self.parse_constant_int_folding_const_objects()?;
                if n < 0 {
                    return Err(self.compile_err(format!(
                        "array designator index must be non-negative (got {n})"
                    )));
                }
                let mut hi = n;
                if self.lex.tk == Token::Ellipsis {
                    self.next()?;
                    hi = self.parse_constant_int_folding_const_objects()?;
                    if hi < n {
                        return Err(self.compile_err(format!(
                            "array range designator high {hi} below low {n}"
                        )));
                    }
                }
                if self.lex.tk != ']' {
                    return Err(self.compile_err("`]` expected after array designator index"));
                }
                self.next()?; // consume `]`
                if self.lex.tk != Token::Assign {
                    return Err(self.compile_err("`=` expected after array designator"));
                }
                self.next()?; // consume `=`
                idx = n as usize;
                range_hi = hi as usize;
            }
            if elem_is_struct {
                let here = field_base + idx * elem_size;
                grow_to(&mut self.data, here + elem_size);
                self.init_struct_array_element(struct_id_of(elem_ty), here as i64)?;
            } else {
                let (value, reloc) = self.parse_constant_init_value()?;
                for i in idx..=range_hi {
                    let here = field_base + i * elem_size;
                    grow_to(&mut self.data, here + elem_size);
                    self.write_init_value(here, elem_size, value, reloc, elem_ty);
                }
            }
            idx = range_hi + 1;
            count = count.max(idx);
            self.accept(',')?;
        }
        self.next()?; // consume `}`
        self.flex_array_measured_count = Some(count);
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
                    self.fill_member_designator_chain_t(struct_id, &outer, chain_base, target)?;
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
            // (`.fields = (const T[]){ ... }`, a common table-descriptor
            // shape); there the cast carries
            // the literal's type, so leave it for the scalar leaf to consume
            // via `parse_constant_init_value`.
            if is_pointer_ty(field.ty) || struct_ptr_depth(field.ty) > 0 {
                self.pending.compound_lit_close_parens = 0;
            } else {
                self.skip_opt_compound_literal_cast()?;
            }
            let close_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
            // C11 6.7.2.1p13 makes the members of an anonymous aggregate
            // members of the enclosing one, and C99 6.7.9p17 gives the
            // anonymous aggregate its own brace level. The promoted run
            // mirrors the inner aggregate's field list one-to-one, so the
            // brace initializes an object of that type at the member's
            // offset -- which handles union alternatives, designators and
            // any nesting depth through the ordinary struct path. Skipped
            // for a field reached by an explicit `.name` designator: the
            // brace then belongs to that member's own type.
            if !designated
                && self.lex.tk == '{'
                && let Some(m) = self.anon_member_starting_at(struct_id, field_idx)
            {
                let base = (var_offset as usize) + m.offset;
                self.collect_struct_initializer_t(m.inner, target.rebased(base as i64))?;
                pos = m.first as usize + m.count as usize;
                for _ in 0..close_parens {
                    self.accept(')')?;
                }
                self.accept(',')?;
                continue;
            }
            // A `T v[0]` member ahead of the last one is a zero-storage
            // position marker, not the aggregate's flexible array member.
            // It has no subobject to initialize and shares its offset with
            // the member after it, so its element is consumed and dropped
            // rather than written (GCC reports the element as excess and
            // discards it too).
            if field.array_size < 0 && !self.is_flexible_array_member(struct_id, field_idx) {
                let data_snap = self.data.len();
                self.skip_init_element_value()?;
                self.truncate_data(data_snap);
                for _ in 0..close_parens {
                    self.accept(')')?;
                }
                pos = field_idx + 1;
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
                let inner_dims: Vec<i64> = field
                    .array_dims
                    .get(1..)
                    .map(|s| s.to_vec())
                    .unwrap_or_default();
                self.fill_flexible_array_member(field_base, field.ty, &inner_dims)?;
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
            pos = self.positional_next(struct_id, field_idx);
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

    /// The anonymous member whose promoted run starts at `field_idx`, if
    /// any, searched through the nested records (each promotion level
    /// keeps its own), with `first` and `offset` rebased to `struct_id`.
    /// The outermost run starting there wins: its brace opens first, and
    /// deeper levels open through its own initializer. A run with no
    /// fields of its own has nothing to initialize and shares its start
    /// with the entry after it, so it is not one.
    fn anon_member_starting_at(&self, struct_id: usize, field_idx: usize) -> Option<AnonMember> {
        let mut agg = struct_id;
        let mut first_base = 0usize;
        let mut offset_base = 0usize;
        loop {
            let runs = &self.structs[agg].anon_members;
            if let Some(m) = runs
                .iter()
                .copied()
                .find(|m| m.count > 0 && first_base + m.first as usize == field_idx)
            {
                return Some(AnonMember {
                    first: (first_base + m.first as usize) as u32,
                    offset: offset_base + m.offset,
                    ..m
                });
            }
            let m = runs.iter().copied().find(|m| {
                let start = first_base + m.first as usize;
                m.count > 0 && field_idx > start && field_idx < start + m.count as usize
            })?;
            first_base += m.first as usize;
            offset_base += m.offset;
            agg = m.inner;
        }
    }

    /// The positional cursor after filling field `i` of `struct_id`.
    /// C99 6.7.9p17: a union takes one initializer, so once the alternative
    /// holding `i` is complete the rest of the union is skipped -- its
    /// members share the same storage. Anonymous members nest, so the test
    /// runs from the innermost aggregate holding `i` outwards.
    fn positional_next(&self, struct_id: usize, i: usize) -> usize {
        // (aggregate, index of its first field, index one past its last)
        let mut levels = alloc::vec![(struct_id, 0usize, self.structs[struct_id].fields.len())];
        while let Some(&(agg, base, _)) = levels.last() {
            let Some(m) = self.structs[agg].anon_members.iter().copied().find(|m| {
                let start = base + m.first as usize;
                m.count > 0 && i >= start && i < start + m.count as usize
            }) else {
                break;
            };
            let start = base + m.first as usize;
            levels.push((m.inner, start, start + m.count as usize));
        }
        let mut pos = i + 1;
        for k in (1..levels.len()).rev() {
            let (agg, _, end) = levels[k];
            // The direct member of `agg` holding `i` ends where the next
            // level down ends, or at `i` itself for a plain field.
            let member_end = levels.get(k + 1).map_or(i + 1, |&(_, _, e)| e);
            if pos < member_end {
                break;
            }
            if self.structs[agg].is_union {
                pos = end;
            }
        }
        pos
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
            && strip_unsigned(field.ty) == Ty::Char as i64
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
                self.restore_lex(snap);
                self.truncate_data(data_snap);
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
            && strip_unsigned(field.ty) == Ty::Char as i64
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
                self.restore_lex(snap);
                self.truncate_data(data_snap);
            }
        }
        if field.array_size > 0 && self.lex.tk == '"' && strip_unsigned(field.ty) == Ty::Char as i64
        {
            // `struct S { char a[N]; } x = { "..." };` -- copy the
            // string bytes (including the trailing NUL) into the
            // char-array field, padding the remainder with zeroes.
            // Without this branch the parser falls into the
            // single-value path and writes the *pointer* to the
            // string's data-segment slot into the field's first
            // 8 bytes, which produces garbage at read time.
            let start_addr = self.take_concat_string_literal()?;
            self.push_literal_nul(); // ensure NUL terminator
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
                    b as i128,
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
            let w = self.lex.str_elem_bytes;
            if self.size_of_type(field.ty) != w {
                return Err(self
                    .compile_err("wide string initializer requires a wchar_t-width array member"));
            }
            let start_addr = self.take_concat_string_literal()?;
            for _ in 0..w {
                self.push_literal_nul(); // terminator slot
            }
            for idx in 0..field.array_size as usize {
                let base = start_addr + idx * w;
                let mut v: i64 = 0;
                if base + w <= self.data.len() {
                    for b in 0..w {
                        v |= (self.data[base + b] as i64) << (b * 8);
                    }
                }
                self.write_init_value(
                    field_base + idx * w,
                    w,
                    v as i128,
                    InitElemReloc::None,
                    field.ty,
                );
            }
        } else if field.array_size > 0 && self.lex.tk == '{' {
            // C99 6.7.8p21: a brace-enclosed initializer for the array
            // member initializes every element; positions not named by a
            // designator -- and any value left by an overridden duplicate
            // initializer (6.7.8p19) -- are set to zero. Clear the member's
            // region, then fill through the shared array walkers, which
            // handle arbitrary rank, designator chains, ranges, and (for
            // char rows) string literals.
            let elem_size = self.size_of_type(field.ty);
            let region = elem_size * field.array_size as usize;
            self.clear_init_relocs_in(field_base, field_base + region);
            for b in &mut self.data[field_base..field_base + region] {
                *b = 0;
            }
            if self.is_traversable_aggregate_ty(field.ty) {
                let dims: Vec<i64> = if field.array_dims.len() >= 2 {
                    field.array_dims.clone()
                } else {
                    alloc::vec![field.array_size]
                };
                self.collect_struct_array_data(field.ty, field_base as i64, &dims)?;
            } else {
                self.pending.init_inner_dims = field.array_dims.get(1..).unwrap_or(&[]).to_vec();
                self.pending.init_target_array_size = field.array_size;
                let elements = self.collect_array_initializer(field.ty)?;
                if elements.len() as i64 > field.array_size {
                    return Err(self.compile_err(format!(
                        "too many initializers for `{}.{}`",
                        self.structs[struct_id].name, field.name
                    )));
                }
                self.write_array_init_into_data(field_base as i64, field.ty, &elements);
            }
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
        } else if self.is_traversable_aggregate_ty(field.ty) {
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
            let mut unit_value: u128 = 0;
            for i in 0..unit_bytes {
                unit_value |= (self.data[field_base + i] as u128) << (i * 8);
            }
            let mask = super::super::ast::bitfield_slice_mask(field.bit_width, 0);
            let placed = super::super::ast::bitfield_slice_mask(field.bit_width, field.bit_offset);
            let cleared = unit_value & !placed;
            let merged = cleared | (((value as u128) & mask) << field.bit_offset);
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
                && strip_unsigned(field.ty) == Ty::Char as i64
            {
                let start_addr = self.take_concat_string_literal()?;
                self.push_literal_nul(); // ensure NUL terminator
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
                            value: super::super::ast::RuntimeInitValue::Expr(value),
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
                let w = self.lex.str_elem_bytes;
                if self.size_of_type(field.ty) != w {
                    return Err(self.compile_err(
                        "wide string initializer requires a wchar_t-width array member",
                    ));
                }
                let start_addr = self.take_concat_string_literal()?;
                for _ in 0..w {
                    self.push_literal_nul(); // terminator slot
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
                            value: super::super::ast::RuntimeInitValue::Expr(value),
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
        if self.is_traversable_aggregate_ty(field.ty) && self.lex.tk == '{' {
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
        // C99 6.7.9p11: a scalar member's initializer may be enclosed
        // in braces; strip a single wrapper as the constant path does.
        let braced_scalar = self.lex.tk == '{';
        if braced_scalar {
            self.next()?;
        }
        self.expr(Token::Assign as i64)?;
        if braced_scalar {
            self.accept(',')?;
            if self.lex.tk != '}' {
                return Err(self.compile_err(
                    "scalar initializer wrapped in `{ ... }` must hold a single value",
                ));
            }
            self.next()?; // consume `}`
        }
        // C99 6.7.9p13: a brace-elided first field taking an expression
        // of the enclosing struct's own type is a whole-object copy, not
        // elision into the first scalar field. Copy the bytes and stop.
        if first_elided && is_struct_value_ty(self.ty) && struct_id_of(self.ty) == struct_id {
            let value = self.ast_acc;
            let elem_ty = self.ty;
            self.ast_assign();
            if let Some(value) = value {
                self.pending_local_runtime_elements
                    .push(super::super::ast::RuntimeInitElement {
                        offset: field_base,
                        value: super::super::ast::RuntimeInitValue::Expr(value),
                        ty: elem_ty,
                        bitfield: None,
                    });
            }
            return Ok(true);
        }
        // C99 6.7.8p13: a struct member may be initialized by a single
        // compatible struct expression (copied); a scalar value would be
        // brace elision into its sub-fields, which this path can't model.
        if self.is_traversable_aggregate_ty(field.ty) && !(is_struct_value_ty(self.ty)) {
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
                    value: super::super::ast::RuntimeInitValue::Expr(value),
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
        // C99 6.7.9p11: a scalar member's initializer may be enclosed
        // in braces; strip a single wrapper on either target path.
        let braced_scalar = !self.is_traversable_aggregate_ty(ty) && self.lex.tk == '{';
        if braced_scalar {
            self.next()?;
        }
        let r = self.init_leaf_scalar_value(target, at, ty);
        if braced_scalar && r.is_ok() {
            self.accept(',')?;
            if self.lex.tk != '}' {
                return Err(self.compile_err(
                    "scalar initializer wrapped in `{ ... }` must hold a single value",
                ));
            }
            self.next()?; // consume `}`
        }
        r
    }

    fn init_leaf_scalar_value(
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
                            value: super::super::ast::RuntimeInitValue::Expr(value),
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
        value: i128,
        reloc: InitElemReloc,
        elem_ty: i64,
    ) {
        let bits = self.to_storage_bits(value, reloc, elem_ty);
        self.write_init_bytes(here, bits, field_size);
        self.push_init_reloc(here, value as i64, reloc);
    }

    /// Write packed initializer bytes into `self.data` at
    /// `var_offset` -- the address of a freshly allocated global
    /// array. Element values are little-endian; `elem_size`
    /// determines whether each value writes one byte (char arrays)
    /// or `elem_size` bytes (int / pointer arrays). Pointer-into-
    /// data elements record a DataReloc so the native writers
    /// patch the runtime address.
    /// A zero-element array definition still reserves one slot when it
    /// sits at the end of the data segment: the object model identifies
    /// objects by start offset (static DCE intervals, the named-section
    /// carve), so no two objects may share one. An object placed in
    /// storage a tentative declaration already reserved keeps that
    /// storage and needs nothing here.
    pub(super) fn reserve_zero_length_array_slot(&mut self, id_idx: usize) {
        if !self.symbols[id_idx].is_zero_len_array
            || self.symbols[id_idx].val != self.data.len() as i64
        {
            return;
        }
        self.symbols[id_idx].reserved_data_bytes = 8;
        for _ in 0..8 {
            self.data.push(0);
        }
    }

    pub(super) fn write_array_init_into_data(
        &mut self,
        var_offset: i64,
        elem_ty: i64,
        elements: &[(i128, InitElemReloc)],
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
            self.push_init_reloc(byte_off, v as i64, reloc);
            byte_off += elem_size;
        }
    }

    /// True when the bytes staged at `[off, off + len)` are the zero
    /// image a local initializer stores directly instead of copying:
    /// all zero, under no relocation (whose value lands in the slot
    /// after staging), and within the inline fill bound.
    fn staged_template_is_zero(&self, off: usize, len: usize) -> bool {
        use super::super::ast::{MAX_MEM_FILL_ACCESSES, SLOT_ALIGN, mem_transfer_accesses};
        let span = off as u64..(off + len) as u64;
        let relocated = |o: &u64| span.contains(o);
        mem_transfer_accesses(len as i64, SLOT_ALIGN) <= MAX_MEM_FILL_ACCESSES
            && self
                .data
                .get(off..off + len)
                .is_some_and(|s| s.iter().all(|&b| b == 0))
            && !self.data_relocs.iter().any(|r| relocated(&r.data_offset))
            && !self.code_relocs.iter().any(|r| relocated(&r.data_offset))
            && !self
                .extern_data_relocs
                .iter()
                .any(|r| relocated(&r.data_offset))
            && !self
                .pending_label_relocs
                .iter()
                .any(|r| relocated(&r.data_offset))
    }

    /// Initialize the local at `local_val` from the `total_bytes`
    /// staged at `src_data_addr` (a position in self.data), either as
    /// a Mcpy from those bytes or, when they are the zero image, as
    /// stores that need no data object at all.
    pub(super) fn emit_local_array_init(
        &mut self,
        local_val: i64,
        src_data_addr: usize,
        total_bytes: usize,
    ) {
        use super::super::ast::LocalInitPrelude;
        if total_bytes == 0 {
            return;
        }
        self.emit_lea(local_val);
        self.ast_psh();
        // A zero image carries no information, and the object holding it
        // is never written, so a writable section is the wrong home for
        // it: a link script that discards `.data` / `.bss` -- every
        // platform's vDSO -- rejects a `.text` relocation into one. The
        // stores are also one access per unit against the copy's pair.
        if self.staged_template_is_zero(src_data_addr, total_bytes) {
            // Drop the staged bytes while they are still the tail of the
            // image; otherwise they stay as an object nothing names,
            // which static DCE removes.
            if src_data_addr + total_bytes == self.data.len() {
                self.data.truncate(src_data_addr);
            } else {
                self.data_object_starts.push(src_data_addr as i64);
            }
            self.mark_emit_other();
            self.pending_local_aggregate_ast = Some(LocalInitPrelude::Zero {
                size_bytes: total_bytes as i64,
            });
            return;
        }
        // The staged template is an anonymous data object (the Mcpy
        // source); record its boundary like a literal's so static DCE
        // neither glues it to a neighbor nor drops part of it, and its
        // range so the const-data load fold may read its bytes (nothing
        // names a template, so its image never changes).
        self.data_object_starts.push(src_data_addr as i64);
        self.const_data_ranges
            .push((src_data_addr as i64, (src_data_addr + total_bytes) as i64));
        self.emit_data_imm(src_data_addr as i64);
        self.mark_emit_other();
        // Dual-emit: record the Mcpy source descriptor so the
        // surrounding decl-site caller can build
        // `Decl::Local { init: Aggregate { src_data_off,
        // size_bytes } }`.
        self.pending_local_aggregate_ast = Some(LocalInitPrelude::Template {
            src_data_off: src_data_addr as i64,
            size_bytes: total_bytes as i64,
        });
    }

    /// Emit the store sequence for a local-variable initializer:
    ///   Lea local_val ; Psh ; <init expr> ; Si | Sc | Mcpy
    /// On entry `tk` is positioned just past the `=`; on exit it
    /// is at the comma or semicolon following the initializer.
    pub(super) fn emit_local_init_store(&mut self, local_val: i64, ty: i64) -> Result<(), C5Error> {
        let init_line = self.lex.line;
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
        // C99 6.7.8p11: a scalar object's initializer must have a type
        // assignment-compatible with it. Only the mismatches with no
        // conversion are diagnosed; the pointer/integer ones this site
        // has always passed silently stay silent.
        if let Some(m) = Self::type_warning_with_flags(
            &self.structs,
            ty,
            self.ty,
            self.last_emit_is_zero(),
            self.last_emit_was_indirect_call(),
        ) && m.no_conversion
        {
            let want = super::types::format_type(ty, &self.structs);
            let got = super::types::format_type(self.ty, &self.structs);
            return Err(self.compile_err_at(
                init_line,
                format!("{} in initializer (declared={want}, init={got})", m.reason),
            ));
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
        if is_struct_value_ty(ty) {
            self.mark_emit_other();
        } else if strip_unsigned(ty) == Ty::Char as i64 {
            self.ast_assign();
        } else if strip_unsigned(ty) == Ty::Float as i64 {
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
        self.restore_lex(snap);
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

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::CODE_BASE;
use super::codegen::Target;
use super::error::C5Error;
use super::lexer::{self, Lexer};
use super::op::Op;
use super::preprocessor::{DylibSpec, Preprocessor};
use super::program::Program;
use super::symbol::Symbol;
use super::token::{Token, Ty};

/// Encoding of struct types into the same `i64` namespace as primitives.
///
/// Primitives sit in `[0, STRUCT_BASE)`; struct id `N` occupies the band
/// `[STRUCT_BASE + N*STRUCT_STRIDE, STRUCT_BASE + (N+1)*STRUCT_STRIDE)`.
/// Within a band, the existing `+= Ty::Ptr` arithmetic still adds a
/// pointer level, so `struct Foo *` is `STRUCT_BASE + N*STRIDE + 2` and
/// `struct Foo **` is `+ 4`. The wide stride leaves room for hundreds of
/// pointer levels per struct without colliding with the next struct id --
/// far more than anyone will ever write.
const STRUCT_BASE: i64 = 1000;
const STRUCT_STRIDE: i64 = 1000;

/// Floating-type encoding bands. See `token.rs::Ty` for the layout
/// rationale. Each band reuses the integer family's "+= Ty::Ptr per
/// `*`" scheme inside its own range, so `float**` = 104 and
/// `double*` = 202; the upper edge of each band sits well below the
/// next type group.
const FP_BAND_SIZE: i64 = 100;

fn is_struct_ty(ty: i64) -> bool {
    ty >= STRUCT_BASE
}

fn struct_id_of(ty: i64) -> usize {
    ((ty - STRUCT_BASE) / STRUCT_STRIDE) as usize
}

fn struct_ptr_depth(ty: i64) -> i64 {
    ((ty - STRUCT_BASE) % STRUCT_STRIDE) / Ty::Ptr as i64
}

fn struct_ty_for(id: usize) -> i64 {
    STRUCT_BASE + (id as i64) * STRUCT_STRIDE
}

fn is_float_ty(ty: i64) -> bool {
    let base = Ty::Float as i64;
    (base..base + FP_BAND_SIZE).contains(&ty)
}

fn is_double_ty(ty: i64) -> bool {
    let base = Ty::Double as i64;
    (base..base + FP_BAND_SIZE).contains(&ty)
}

/// `ty` is a value of any floating-point type (or pointer to one).
fn is_floating_ty(ty: i64) -> bool {
    is_float_ty(ty) || is_double_ty(ty)
}

/// `ty` is a *scalar* float/double -- not a pointer to one.
fn is_floating_scalar(ty: i64) -> bool {
    ty == Ty::Float as i64 || ty == Ty::Double as i64
}

fn fp_ptr_depth(ty: i64) -> i64 {
    if is_float_ty(ty) {
        (ty - Ty::Float as i64) / Ty::Ptr as i64
    } else if is_double_ty(ty) {
        (ty - Ty::Double as i64) / Ty::Ptr as i64
    } else {
        0
    }
}

/// True if `ty` represents a pointer (any base type, any depth).
/// Used everywhere the integer-family `>= Ty::Ptr` test was the
/// quick proxy for "is a pointer"; the bands for floats and structs
/// have their own depth predicates that this helper unifies.
fn is_pointer_ty(ty: i64) -> bool {
    if is_struct_ty(ty) {
        struct_ptr_depth(ty) > 0
    } else if is_floating_ty(ty) {
        fp_ptr_depth(ty) > 0
    } else {
        ty >= Ty::Ptr as i64
    }
}

/// Element size in bytes of a pointee for the given pointer type.
/// `char*` deferences a single byte; everything else is 8-byte.
/// Floats are stored in 8-byte slots regardless (the ABI lowering
/// will narrow `float` to 32 bits at the FP-register boundary).
fn pointee_size(ty: i64) -> i64 {
    // char* (= Ty::Ptr alone, base char=0) is the only special case;
    // every other pointer points to an 8-byte slot in c5.
    if ty == Ty::Ptr as i64 { 1 } else { 8 }
}

/// True for any pointer whose element size is 8 -- i.e., everything
/// except `char*`. Pointer arithmetic on these scales the offset by
/// 8 before adding to the base. Replaces the previous `t > Ty::Ptr`
/// quick test, which treated the float-band scalar values (`100`,
/// `200`) as if they were deep pointers.
fn is_ptr_scaling_by_8(ty: i64) -> bool {
    is_pointer_ty(ty) && pointee_size(ty) > 1
}

/// Result type for a binary FP operation. Both operands are
/// floating-point scalars; if either is `double`, the result is
/// `double`, otherwise `float`. Mirrors the C standard's "usual
/// arithmetic conversions" for FP operands. Internally both flow
/// through f64 ops anyway -- the type is purely for downstream
/// type-warning bookkeeping.
fn fp_result_ty(lhs: i64, rhs: i64) -> i64 {
    if lhs == Ty::Double as i64 || rhs == Ty::Double as i64 {
        Ty::Double as i64
    } else {
        Ty::Float as i64
    }
}

/// Pick the right load op for the given `ty`. `char`-typed lvalues take
/// `Op::Lc` (one-byte load); anything else (`int`, pointers, struct
/// pointers) goes through `Op::Li` (eight-byte load).
fn load_op_for(ty: i64) -> Op {
    if ty == Ty::Char as i64 {
        Op::Lc
    } else {
        Op::Li
    }
}

/// Mirror of [`load_op_for`] for stores: `Sc` for `char`, `Si` otherwise.
fn store_op_for(ty: i64) -> Op {
    if ty == Ty::Char as i64 {
        Op::Sc
    } else {
        Op::Si
    }
}

#[derive(Debug, Clone)]
struct StructDef {
    name: String,
    /// Total size in bytes -- sum of field sizes, padded to 8.
    size: usize,
    fields: Vec<StructField>,
}

#[derive(Debug, Clone)]
struct StructField {
    name: String,
    /// Byte offset of the field from the start of the struct.
    offset: usize,
    /// `ty`-encoded type of the field.
    ty: i64,
}

/// Bundle returned from `parse_function_params` -- keeps the per-param
/// symbol indices (needed by the function-body binding step) together
/// with the declared types and the variadic flag (needed by the type
/// checker at every call site).
struct ParsedParams {
    indices: Vec<usize>,
    types: Vec<i64>,
    is_variadic: bool,
}

/// Single-pass C compiler. Holds the lexer, the symbol table, and the
/// codegen scaffolding. `compile(self)` consumes the compiler and produces
/// a [`Program`] ready for the VM.
pub struct Compiler {
    lex: Lexer,
    symbols: Vec<Symbol>,

    // --- Codegen state ---
    text: Vec<i64>,
    data: Vec<u8>,
    /// Type of the current expression -- set by `expr` callees, read by callers
    /// to decide between byte and word loads/stores and for pointer scaling.
    ty: i64,
    /// Number of local-variable slots currently reserved in the active stack
    /// frame. User-declared locals push it up monotonically; call-arg staging
    /// (parse_function_args) bumps it temporarily for each in-flight call's
    /// reverse-push temp slots and then restores it.
    loc_offs: i64,
    /// Per-function high-water mark of `loc_offs` -- patched into `Op::Ent`
    /// at the end of the function so the prologue reserves enough stack for
    /// every nested-call temp the function ever needs.
    max_loc_offs: i64,

    // --- Patch lists ---
    loop_breaks: Vec<Vec<usize>>,
    loop_continues: Vec<Vec<usize>>,
    /// Linear table of `(label_name, text_pc)`. Per-function (cleared
    /// at every function start), so it stays small -- typically 0-2
    /// entries even in code that uses `goto`. Linear scan beats
    /// pulling in `HashMap` (which would force `std`).
    labels: Vec<(String, usize)>,
    unresolved_gotos: Vec<(String, usize)>,
    switch_cases: Vec<Vec<(i64, usize)>>,
    switch_defaults: Vec<Option<usize>>,

    /// Defined struct types, indexed by struct id.
    structs: Vec<StructDef>,

    /// Type-mismatch warnings collected during compilation. Stored as
    /// formatted lines so the final consumer (CLI / test) can dump them
    /// without knowing their structure. Warnings never fail the compile --
    /// c4 was permissive by design and many idioms (NULL=0, void*~char*)
    /// would otherwise drown the output.
    warnings: Vec<String>,

    /// Bytecode positions (indices into `text`) of `Op::Imm` operands
    /// that hold an offset into the data segment. Recorded at emit time
    /// because the native backend can't rediscover them from the
    /// bytecode alone -- a small Imm could be a global's address or
    /// just an integer literal. The VM doesn't care; this rides along
    /// in `Program` for the native codegen to consume.
    data_imm_positions: Vec<usize>,

    /// Thread-local data segment. Same shape as `data` but the
    /// codegen lowers accesses with the per-target TLS sequence
    /// (TPIDR_EL0 + offset on aarch64, fs:0 + offset on x86_64,
    /// the .tls$ callback chain on Win64). Each `_Thread_local`
    /// global gets `slots_of_type(ty) * 8` bytes here, with
    /// `Symbol::val` holding the byte offset within `tls_data`.
    /// Today we don't parse TLS initialisers, so the segment is
    /// always zero-filled and goes entirely into .tbss; the layout
    /// leaves room for a future "initialised TLS image -> .tdata"
    /// path.
    tls_data: Vec<u8>,
    /// Number of bytes at the start of [`Self::tls_data`] that
    /// are statically initialised by an explicit
    /// `_Thread_local int x = 5;` initializer. The remainder
    /// (`tls_data.len() - tls_init_size`) is zero-fill. Today
    /// only TLS initializer variants supported by the parser
    /// land here; uninitialised TLS keeps the field at 0 and
    /// the bytes are zeros.
    tls_init_size: usize,
    /// Address-of-global initializers seen at file scope:
    /// `int *p = &x;`. Each entry says "the 8 bytes at
    /// `data_offset` in the data segment must contain the
    /// runtime address of `target_offset` in the same
    /// segment." Threaded through to `Program::data_relocs`;
    /// the per-format writer materializes the relocation as
    /// either an absolute write (ELF / ET_EXEC), a Mach-O
    /// rebase opcode, or a PE `.reloc` entry.
    data_relocs: Vec<crate::c5::program::DataReloc>,
    /// Names from `#pragma export(<name>)` directives, in
    /// declaration order. Validated at the end of
    /// [`Self::run_compile`] -- each must resolve to a
    /// `Token::Fun` symbol -- and copied onto
    /// `Program::exports` together with the function's
    /// bytecode PC. Empty for executables that don't reach
    /// for the directive.
    pending_exports: Vec<String>,
    /// Per-libc-call FP-argument bitmaps. Filled when emitting an
    /// `Op::JsrExt` whose argument list contains at least one
    /// floating-point operand; the codegen reads it back to route
    /// those args through the platform's FP-arg registers. Empty
    /// for the all-integer case, which is most calls.
    call_fp_arg_masks: Vec<(usize, u32)>,

    /// Return type of the function whose body is currently being
    /// parsed (0 outside any function). Used by the `return s`
    /// path to emit a struct-copy through the hidden out-pointer
    /// when the function's declared return type is a struct
    /// value -- the caller pre-allocates a result temp and passes
    /// its address at param val=2; struct-returning callees treat
    /// declared params as starting at val=3.
    current_func_return_ty: i64,

    /// Preprocessor failure (e.g. unterminated `#if`) deferred from
    /// `with_target` until `compile` runs, so the construction API
    /// stays infallible (matches all the `Compiler::new(src).compile()`
    /// callers in tests / examples). `None` if preprocessing
    /// succeeded.
    deferred_error: Option<C5Error>,

    /// Dylibs + bindings the preprocessor extracted from the
    /// per-target header. Threaded onto `Program` so `emit_native`
    /// can drive its import table from this list rather than the
    /// codegen's hardcoded knowledge of which libc symbols live
    /// where.
    dylibs: Vec<DylibSpec>,
}

impl Compiler {
    /// Construct a compiler for the default target (the host).
    /// Equivalent to `Compiler::with_target(source,
    /// Target::default_target())`. Most tests reach for this; the
    /// CLI uses the explicit-target form so `--target=` flows
    /// through to the codegen.
    pub fn new(source: String) -> Self {
        Self::with_target(source, Target::default_target())
    }

    /// Construct a compiler for a specific native target. Runs the
    /// preprocessor (with the target predefines: `__APPLE__` /
    /// `__linux__` / `_WIN32`, plus arch macros) over `source`, then
    /// feeds the substituted text to the lexer. The target choice
    /// drives the predefines -- `#include`d headers (`<stdio.h>`,
    /// `<string.h>`, ...) gate their `#pragma binding(...)` blocks
    /// off them so the right libc / libSystem / msvcrt symbols get
    /// bound for this target.
    pub fn with_target(source: String, target: Target) -> Self {
        // Run the preprocessor first so we know the
        // `#pragma binding(...)` set before seeding the symbol
        // table. The bindings come from whichever standard headers
        // the source `#include`s (or doesn't); a fixture that needs
        // `printf` but skips `<stdio.h>` will fail with a clear
        // "no `#pragma binding(... ::printf, ...)` is in scope"
        // error out of the codegen's import resolver, not a
        // mysterious link-time mismatch.
        //
        // Preprocessor failures (unterminated `#if`, duplicate
        // `#else`, ...) are stored on the struct and surfaced when
        // `compile()` runs -- this keeps the construction API
        // infallible so the `Compiler::new(src).compile()` shape
        // every existing caller uses keeps working.
        let mut pp = Preprocessor::new(target.id_str(), target, env!("CARGO_PKG_VERSION"));
        let (preprocessed, deferred_error) = match pp.process(&source) {
            Ok(s) => (s, None),
            Err(e) => (String::new(), Some(e)),
        };
        let dylibs = pp.dylibs;
        let pending_exports = pp.exports;

        let mut symbols = Vec::new();
        lexer::init_symbols(&mut symbols, &dylibs);

        // Reserve the first 8 bytes of `.data` so no symbol's
        // offset is zero. The c5 dialect models pointers as
        // raw data offsets (no per-segment base in the VM, and
        // `data_vmaddr` is the base on native targets), so a
        // global at offset 0 would be indistinguishable from
        // the integer literal `0` -- which c5 uses for NULL.
        // Reserving the first 8 bytes pushes every actual
        // global / string literal to offset >= 8, preserving
        // the `pointer != 0 <=> non-NULL` invariant that
        // `int *p = &x; if (p == 0) ...` style code expects.
        // Native binaries are unaffected (the bytes are just
        // an unused prefix in `.data`); the VM's address space
        // gains 8 bytes of reserved padding at offset 0.
        let data: Vec<u8> = alloc::vec![0u8; 8];

        Self {
            lex: Lexer::new(preprocessed),
            symbols,
            deferred_error,
            dylibs,
            text: Vec::new(),
            data,
            ty: 0,
            loc_offs: 0,
            max_loc_offs: 0,
            loop_breaks: Vec::new(),
            loop_continues: Vec::new(),
            labels: Vec::new(),
            unresolved_gotos: Vec::new(),
            switch_cases: Vec::new(),
            switch_defaults: Vec::new(),
            structs: Vec::new(),
            warnings: Vec::new(),
            data_imm_positions: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            pending_exports,
            call_fp_arg_masks: Vec::new(),
            current_func_return_ty: 0,
        }
    }

    /// Append a type-checking warning. We never fail compilation on a
    /// type mismatch -- it always lands here. Callers grab the list off
    /// `Program.warnings` after `compile()`.
    fn warn(&mut self, msg: alloc::string::String) {
        self.warnings.push(msg);
    }

    /// Test whether `actual` is assignable / passable where `declared`
    /// is expected. Returns a human-readable warning string when they
    /// don't match under badc's rules; `None` when they do.
    ///
    /// Compatibility is intentionally lax -- c4 itself does no checking,
    /// so jumping straight to ISO-C strictness would drown the suite.
    /// What we *do* catch:
    ///   * pointer <-> non-zero scalar (one side a pointer, the other an
    ///     integer that isn't a literal 0)
    ///   * struct of different concrete types
    ///   * struct value vs anything non-struct
    ///
    /// What we deliberately *don't* catch (yet):
    ///   * pointer base mismatch (`int*` <-> `char*`); both pointers, both
    ///     fit in a register, common in c5 idioms
    ///   * char <-> int width difference; c convention
    ///
    /// `actual_is_zero_literal` is a hint from the caller -- when an
    /// expression compiles to exactly `Imm 0`, treat the value as the
    /// NULL pointer for the purposes of this check.
    fn type_warning(
        declared: i64,
        actual: i64,
        actual_is_zero_literal: bool,
    ) -> Option<&'static str> {
        if declared == actual {
            return None;
        }
        let decl_is_struct = is_struct_ty(declared);
        let act_is_struct = is_struct_ty(actual);
        let decl_is_ptr = is_pointer_ty(declared);
        let act_is_ptr = is_pointer_ty(actual);

        // Struct types must match exactly (when one side is a struct).
        if decl_is_struct || act_is_struct {
            // Already returned None above when declared == actual; if we
            // reach here, the struct sides differ. But allow struct
            // pointer vs untyped 0 (NULL).
            if (decl_is_ptr && actual_is_zero_literal) || (act_is_ptr && declared == 0) {
                return None;
            }
            return Some("incompatible struct types");
        }

        match (decl_is_ptr, act_is_ptr) {
            // Both pointers (any base/depth) -- fine.
            (true, true) => None,
            // Pointer <-> literal 0: NULL idiom.
            (true, false) if actual_is_zero_literal => None,
            // Pointer <-> non-zero integer: warn.
            (true, false) => Some("integer assigned to pointer"),
            (false, true) => Some("pointer assigned to integer"),
            // Both numeric (char vs int) -- c convention, silent.
            (false, false) => None,
        }
    }

    /// Reject mixed int/float operands for an arithmetic or
    /// comparison op. The IR has no in-place int-to-float
    /// conversion when the int operand is already on the stack,
    /// and the cleanest user-facing rule is to require an explicit
    /// `(double)x` cast to lift the int side. Once both sides are
    /// FP, the call sites pick the right `Op::Fxxx` and let the
    /// codegen do the f64 work.
    fn require_both_float(&self, lhs: i64, op: &str) -> Result<(), C5Error> {
        if !is_floating_scalar(lhs) || !is_floating_scalar(self.ty) {
            return Err(C5Error::Compile(format!(
                "{}: `{op}` requires both operands to be the same kind \
                 (float or int) -- add an explicit cast to lift one side",
                self.lex.line
            )));
        }
        Ok(())
    }

    /// True when the most recently emitted instruction is `Imm 0` --
    /// i.e. the expression that just finished compiling was the literal
    /// `0`. Used by [`Compiler::type_warning`] to suppress the NULL
    /// idiom warning on `pointer = 0`.
    fn last_emit_is_zero(&self) -> bool {
        let n = self.text.len();
        n >= 2 && self.text[n - 1] == 0 && self.text[n - 2] == Op::Imm as i64
    }

    /// Linear lookup of a struct by its tag name. Returns the id used in
    /// `struct_ty_for(id)` and as an index into `self.structs`.
    fn find_struct_id(&self, name: &str) -> Option<usize> {
        self.structs.iter().position(|s| s.name == name)
    }

    /// Size in bytes of a value of the given `ty`. Pointers are always 8;
    /// `char` is 1; `int` (and any other primitive that isn't a `char`) is
    /// 8; struct values use the size recorded in the struct table.
    fn size_of_type(&self, ty: i64) -> usize {
        if is_struct_ty(ty) {
            if struct_ptr_depth(ty) > 0 {
                8
            } else {
                self.structs[struct_id_of(ty)].size
            }
        } else if ty == Ty::Char as i64 {
            1
        } else {
            8
        }
    }

    /// Number of c5 stack slots required to hold a value of `ty`.
    /// Each c5 slot is 8 bytes; struct values may span several. The
    /// existing scalar / pointer paths always return 1, so existing
    /// `loc_offs += 1` patterns map to `loc_offs += slots_of(ty)`
    /// without changing emit semantics.
    fn slots_of_type(&self, ty: i64) -> i64 {
        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
            // Struct fields are 8-byte aligned (see parse_struct_body),
            // so the size is already a multiple of 8 -- the +7 round
            // is defensive in case a future change adds sub-8-byte
            // packing.
            ((self.structs[struct_id_of(ty)].size as i64) + 7) / 8
        } else {
            1
        }
    }

    /// Parse the base type of a declaration: `int`, `char`, or
    /// `struct Name`. Caller has already verified the current token is
    /// one of those -- used by the three local/parameter declaration
    /// loops, where struct definitions are not allowed (only references
    /// to pre-defined structs).
    /// Parse the declarator part of a declaration: zero-or-more `*` markers
    /// followed by an identifier. The `base` is the type prefix already
    /// parsed by the caller (e.g. `int` or `struct Foo`); pointer markers
    /// raise the resulting type by `Ty::Ptr` per `*`.
    ///
    /// Returns `(symbol_index, declarator_type)`. On exit, `tk` points at
    /// whatever followed the identifier (typically `,`, `;`, `(`, or `=`).
    /// Used by every declaration site -- globals, parameters, function-top
    /// locals, block-scoped locals -- so the four near-identical loops it
    /// replaced share one definition of "what counts as a valid name" and
    /// "we don't allow struct values".
    fn parse_declarator(&mut self, base: i64) -> Result<(usize, i64), C5Error> {
        let mut ty = base;
        while self.lex.tk == Token::MulOp as i64 {
            self.next()?;
            ty += Ty::Ptr as i64;
        }
        if self.lex.tk != Token::Id as i64 {
            return Err(C5Error::Compile(format!(
                "{}: identifier expected in declaration",
                self.lex.line
            )));
        }
        let idx = self.lex.curr_id_idx;
        self.next()?;
        Ok((idx, ty))
    }

    fn parse_decl_base_type(&mut self) -> Result<i64, C5Error> {
        if self.lex.tk == Token::Int as i64 {
            self.next()?;
            Ok(Ty::Int as i64)
        } else if self.lex.tk == Token::Char as i64 {
            self.next()?;
            Ok(Ty::Char as i64)
        } else if self.lex.tk == Token::Float as i64 {
            self.next()?;
            Ok(Ty::Float as i64)
        } else if self.lex.tk == Token::Double as i64 {
            self.next()?;
            Ok(Ty::Double as i64)
        } else if self.lex.tk == Token::Struct as i64 {
            self.next()?;
            if self.lex.tk != Token::Id as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: struct name expected",
                    self.lex.line
                )));
            }
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;
            let id = self.find_struct_id(&name).ok_or_else(|| {
                C5Error::Compile(format!("{}: unknown struct {}", self.lex.line, name))
            })?;
            Ok(struct_ty_for(id))
        } else {
            Err(C5Error::Compile(format!(
                "{}: type expected",
                self.lex.line
            )))
        }
    }

    /// Parse a `struct Name { ... }` definition. The struct is registered
    /// before its fields are parsed, so a field of type `struct Name *`
    /// (self-reference) resolves correctly. Field offsets are 8-byte
    /// aligned, which matches the natural alignment of every type c4
    /// supports -- even `char` fields take a full slot, but that buys us a
    /// trivially simple layout.
    ///
    /// On entry `tk` is `{`; on exit `tk` is the token AFTER the closing
    /// `}` (typically `;`).
    fn parse_struct_body(&mut self, name: &str) -> Result<usize, C5Error> {
        // Pre-register so self-referential pointer fields can find this
        // struct mid-definition.
        let struct_id = self.structs.len();
        self.structs.push(StructDef {
            name: name.to_string(),
            size: 0,
            fields: Vec::new(),
        });

        self.next()?; // consume `{`

        let mut offset = 0usize;
        while self.lex.tk != '}' as i64 {
            // Field type prefix: int, char, float, double, or struct Name.
            let field_base = if self.lex.tk == Token::Int as i64 {
                self.next()?;
                Ty::Int as i64
            } else if self.lex.tk == Token::Char as i64 {
                self.next()?;
                Ty::Char as i64
            } else if self.lex.tk == Token::Float as i64 {
                self.next()?;
                Ty::Float as i64
            } else if self.lex.tk == Token::Double as i64 {
                self.next()?;
                Ty::Double as i64
            } else if self.lex.tk == Token::Struct as i64 {
                self.next()?;
                if self.lex.tk != Token::Id as i64 {
                    return Err(C5Error::Compile(format!(
                        "{}: struct name expected in field type",
                        self.lex.line
                    )));
                }
                let inner_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                let inner_id = self.find_struct_id(&inner_name).ok_or_else(|| {
                    C5Error::Compile(format!("{}: unknown struct {}", self.lex.line, inner_name))
                })?;
                struct_ty_for(inner_id)
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: type expected in struct field",
                    self.lex.line
                )));
            };

            // One or more comma-separated declarators sharing the prefix.
            loop {
                let mut field_ty = field_base;
                while self.lex.tk == Token::MulOp as i64 {
                    self.next()?;
                    field_ty += Ty::Ptr as i64;
                }
                if self.lex.tk != Token::Id as i64 {
                    return Err(C5Error::Compile(format!(
                        "{}: field name expected",
                        self.lex.line
                    )));
                }
                if is_struct_ty(field_ty) && struct_ptr_depth(field_ty) == 0 {
                    return Err(C5Error::Compile(format!(
                        "{}: struct-value fields are not supported (use a pointer)",
                        self.lex.line
                    )));
                }

                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;

                // 8-byte align every field. Even `char` fields take a full
                // slot -- wasteful but keeps offset arithmetic obvious.
                offset = (offset + 7) & !7;
                let field_size = self.size_of_type(field_ty);
                self.structs[struct_id].fields.push(StructField {
                    name: field_name,
                    offset,
                    ty: field_ty,
                });
                offset += field_size;

                if self.lex.tk == ',' as i64 {
                    self.next()?;
                    continue;
                }
                break;
            }

            if self.lex.tk != ';' as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: semicolon expected after struct field",
                    self.lex.line
                )));
            }
            self.next()?;
        }
        self.next()?; // consume `}`

        let total = (offset + 7) & !7;
        self.structs[struct_id].size = total.max(8); // never zero-sized
        Ok(struct_id)
    }

    /// Compile the source. On success, the returned `Program` contains the
    /// bytecode, the static data segment, and the PC of `main`.
    pub fn compile(mut self) -> Result<Program, C5Error> {
        if let Some(e) = self.deferred_error.take() {
            return Err(e);
        }
        self.run_compile()?;
        // `main` is optional today: shared-library output
        // (`OutputKind::SharedLibrary`) doesn't need an entry
        // point, and the executable-output writer surfaces a
        // clear error if `entry_pc` doesn't land on real code.
        // When neither `main`, any `#pragma export(...)`, nor
        // a user-defined `DllMain` is present we still refuse,
        // since the result would be an image with no callable
        // entries at all.
        let main_idx = lexer::find_symbol(&self.symbols, "main");
        let dllmain_idx = lexer::find_symbol(&self.symbols, "DllMain");
        let has_user_dllmain =
            dllmain_idx.is_some_and(|idx| self.symbols[idx].class == Token::Fun as i64);
        let entry_pc = match main_idx {
            Some(idx) if self.symbols[idx].class == Token::Fun as i64 => {
                self.symbols[idx].val as usize
            }
            _ if !self.pending_exports.is_empty() || has_user_dllmain => 0,
            _ => return Err(C5Error::Compile("main() not defined".to_string())),
        };
        // Resolve `#pragma export(<name>)` directives against
        // the now-finalised symbol table. Each name must
        // resolve to a `Token::Fun` (a function defined in
        // this translation unit); anything else gets a clear
        // diagnostic so a misspelled export doesn't silently
        // produce a shared object missing the symbol the user
        // expected.
        let mut exports = Vec::with_capacity(self.pending_exports.len());
        for name in core::mem::take(&mut self.pending_exports) {
            let Some(idx) = lexer::find_symbol(&self.symbols, &name) else {
                return Err(C5Error::Compile(format!(
                    "`#pragma export({name})` -- no such symbol; the name must \
                     refer to a function defined in this source"
                )));
            };
            if self.symbols[idx].class != Token::Fun as i64 {
                return Err(C5Error::Compile(format!(
                    "`#pragma export({name})` -- expected a function, but `{name}` \
                     is class {} (only locally-defined functions are exportable today; \
                     globals would need data-export support that isn't wired up yet)",
                    self.symbols[idx].class
                )));
            }
            exports.push(crate::c5::program::ExportedFunction {
                name,
                bytecode_pc: self.symbols[idx].val as usize,
            });
        }
        // A user-defined `DllMain` (any source-level function with
        // that exact name) overrides the boilerplate
        // `mov eax, 1; ret` DllMain stub the PE shared-library
        // writer otherwise emits. We record the bytecode PC here
        // unconditionally -- the VM / JIT / non-PE writers ignore
        // it, and the PE writer only consults it for `--shared`
        // builds. No signature validation: c5 trusts user `main`
        // the same way and DllMain is just a different ABI.
        let dllmain_pc =
            dllmain_idx.and_then(|idx| has_user_dllmain.then(|| self.symbols[idx].val as usize));
        Ok(Program {
            text: self.text,
            data: self.data,
            entry_pc,
            warnings: self.warnings,
            data_imm_positions: self.data_imm_positions,
            tls_data: self.tls_data,
            tls_init_size: self.tls_init_size,
            call_fp_arg_masks: self.call_fp_arg_masks,
            exports,
            data_relocs: self.data_relocs,
            dylibs: self.dylibs,
            dllmain_pc,
        })
    }

    // ---- Lexer plumbing ----

    fn next(&mut self) -> Result<(), C5Error> {
        self.lex.next(&mut self.symbols, &mut self.data)
    }

    // ---- Code emission ----

    fn emit_op(&mut self, op: Op) {
        self.text.push(op as i64);
    }

    fn emit_val(&mut self, val: i64) {
        self.text.push(val);
    }

    /// Emit `Op::Imm <data_offset>` and record the operand's bytecode
    /// position in [`Compiler::data_imm_positions`]. Use this anywhere
    /// the immediate is the address of a string literal or a global --
    /// the VM treats the result identically to a plain `Op::Imm`, but
    /// the native backend needs the side channel to relocate the value
    /// against the real `__data` vmaddr at link time.
    fn emit_data_imm(&mut self, data_offset: i64) {
        self.emit_op(Op::Imm);
        self.data_imm_positions.push(self.text.len());
        self.emit_val(data_offset);
    }

    // ---- Recursive descent ----

    fn expr(&mut self, lev: i64) -> Result<(), C5Error> {
        let mut t: i64;

        if self.lex.tk == 0 {
            return Err(C5Error::Compile(format!(
                "{}: unexpected eof in expression",
                self.lex.line
            )));
        } else if self.lex.tk == Token::Num as i64 {
            self.emit_op(Op::Imm);
            self.emit_val(self.lex.ival);
            self.next()?;
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::FloatNum as i64 {
            // The lexer parsed `1.5` etc. into f64 and stored
            // `f64::to_bits()` cast to i64 in `ival`. The byte
            // pattern flows through Op::Imm unmodified -- a future
            // float codegen reads it back with `f64::from_bits`.
            // Until then, the `is_floating_scalar` self-ty marks
            // the value so it can't accidentally feed into integer
            // arithmetic (the binary-op handlers gate on this).
            self.emit_op(Op::Imm);
            self.emit_val(self.lex.ival);
            self.next()?;
            self.ty = Ty::Double as i64;
        } else if self.lex.tk == '"' as i64 {
            self.emit_data_imm(self.lex.ival);
            self.next()?;
            // C concatenates adjacent string literals -- `"a" "b"` is one
            // string. The lexer leaves the NUL off so the bytes flow
            // straight together; we add the single trailing NUL here.
            while self.lex.tk == '"' as i64 {
                self.next()?;
            }
            self.data.push(0);
            self.ty = Ty::Ptr as i64;
        } else if self.lex.tk == Token::Sizeof as i64 {
            self.next()?;
            if self.lex.tk == '(' as i64 {
                self.next()?;
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: open paren expected in sizeof",
                    self.lex.line
                )));
            }
            if self.lex.tk == Token::Int as i64
                || self.lex.tk == Token::Char as i64
                || self.lex.tk == Token::Float as i64
                || self.lex.tk == Token::Double as i64
                || self.lex.tk == Token::Struct as i64
            {
                // sizeof(<type>): an explicit type name, optionally with
                // pointer markers (`int **`, `struct Foo *`, ...). No
                // bytecode is emitted for the operand at all in this
                // branch.
                self.ty = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp as i64 {
                    self.next()?;
                    self.ty += Ty::Ptr as i64;
                }
            } else {
                // sizeof(<expr>): parse the expression to learn its type,
                // then drop whatever bytecode it emitted. sizeof is
                // compile-time -- the operand is never actually evaluated,
                // so e.g. `sizeof(*p)` doesn't dereference p, and
                // `sizeof(f())` doesn't call f.
                let saved_text_len = self.text.len();
                self.expr(Token::Assign as i64)?;
                self.text.truncate(saved_text_len);
            }
            if self.lex.tk == ')' as i64 {
                self.next()?;
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: close paren expected in sizeof",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Imm);
            self.emit_val(self.size_of_type(self.ty) as i64);
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::Id as i64 {
            let id_idx = self.lex.curr_id_idx;
            self.next()?;
            if self.lex.tk == '(' as i64 {
                self.next()?;
                // Snapshot the declared signature up front: the per-arg
                // type checks read from `expected_params` and `is_variadic`,
                // and we don't want a recursive call to clobber them via
                // self-mutation. Cloning the Vec is cheap (typically 1-3
                // i64s) compared to the cost of the type check itself.
                let expected_params = self.symbols[id_idx].params.clone();
                let is_variadic = self.symbols[id_idx].is_variadic;
                let fn_name_for_warn = self.symbols[id_idx].name.clone();
                // Struct-returning callees use a hidden out-pointer
                // arg at val=2: the caller pre-allocates a temp for
                // the result and passes its address as arg 0; the
                // callee's `return s` writes to *(out_pointer)
                // before Lev. The result expression's value (in
                // `a`) becomes the temp's address so an enclosing
                // `lhs = call(...)` Mcpy reads from there.
                let callee_ret_ty = self.symbols[id_idx].type_;
                let callee_returns_struct = self.symbols[id_idx].class == Token::Fun as i64
                    && is_struct_ty(callee_ret_ty)
                    && struct_ptr_depth(callee_ret_ty) == 0;
                // Token::Sys (libc) calls returning a struct by
                // value would need real platform-ABI register
                // packing -- SysV's two-register split for
                // 8 < size <= 16, Win64's hidden out-pointer for
                // size > 8, AAPCS64's HFA / two-GPR split, and so
                // on. The c5-internal "address-as-value, hidden
                // out-pointer at val=2" convention only works for
                // c5-to-c5 calls. Refuse the call up front rather
                // than emit a silently-broken sequence; the gap
                // is documented in the M9 commit.
                if self.symbols[id_idx].class == Token::Sys as i64
                    && is_struct_ty(callee_ret_ty)
                    && struct_ptr_depth(callee_ret_ty) == 0
                {
                    return Err(C5Error::Compile(format!(
                        "{}: `{}` returns a struct by value, but the \
                         platform-ABI struct-return convention isn't \
                         implemented for Token::Sys calls. Use a \
                         pointer-returning variant or pass an out-buffer.",
                        self.lex.line, fn_name_for_warn
                    )));
                }
                let mut nargs = 0;
                // For struct returns, allocate a result temp now
                // so its address can be pushed before the
                // declared-arg pushes.
                let saved_loc_offs_for_result = self.loc_offs;
                let result_temp_off: i64 = if callee_returns_struct {
                    let slots = self.slots_of_type(callee_ret_ty);
                    self.loc_offs += slots;
                    if self.loc_offs > self.max_loc_offs {
                        self.max_loc_offs = self.loc_offs;
                    }
                    -self.loc_offs
                } else {
                    0
                };
                // c5 uses cdecl-style arg passing: args are pushed
                // right-to-left so the i'th declared param sits at
                // `[bp + 16*(i+1)]`. The parser still has to evaluate
                // args left-to-right (so observable side effects
                // happen in source order), so each arg gets parked in
                // a transient temp local and we re-emit the pushes in
                // reverse once they're all evaluated.
                let saved_loc_offs = self.loc_offs;
                let mut temp_offsets: Vec<i64> = Vec::new();
                // Per-arg FP flag, captured at evaluation time. Used
                // below when the call is `Token::Sys` to build a bit
                // mask the codegen reads for variadic FP packing
                // (`printf("%f", x)` etc.). Order matches
                // `temp_offsets`: index 0 = first declared arg.
                let mut arg_is_fp: Vec<bool> = Vec::new();
                while self.lex.tk != ')' as i64 {
                    let arg_line = self.lex.line;
                    // Allocate a temp slot for this arg.
                    self.loc_offs += 1;
                    if self.loc_offs > self.max_loc_offs {
                        self.max_loc_offs = self.loc_offs;
                    }
                    let temp_off = -self.loc_offs;
                    temp_offsets.push(temp_off);

                    // Emit the `*temp = expr;` shape that c5's
                    // assignment path already supports: address
                    // first, push, then RHS, then Si.
                    self.emit_op(Op::Lea);
                    self.emit_val(temp_off);
                    self.emit_op(Op::Psh);
                    self.expr(Token::Assign as i64)?;

                    // Type-check before the Si overwrites self.ty.
                    if (nargs as usize) < expected_params.len() {
                        let want = expected_params[nargs as usize];
                        let zero = self.last_emit_is_zero();
                        if let Some(reason) = Self::type_warning(want, self.ty, zero) {
                            self.warn(format!(
                                "{arg_line}: warning: {reason} in argument {} of `{}` (param={want}, arg={})",
                                nargs + 1,
                                fn_name_for_warn,
                                self.ty
                            ));
                        }
                    } else if !expected_params.is_empty() && !is_variadic {
                        self.warn(format!(
                            "{arg_line}: warning: too many arguments to `{}` (expected {}, got at least {})",
                            fn_name_for_warn,
                            expected_params.len(),
                            nargs + 1,
                        ));
                    }

                    arg_is_fp.push(is_floating_scalar(self.ty));
                    // Refuse passing a struct by value to a
                    // Token::Sys callee. The c5-internal "push
                    // the address" convention works for c5-to-c5
                    // calls (the callee copies into a fresh local
                    // on entry); platform ABIs for libc instead
                    // expect the bytes packed into argument
                    // registers (SysV/AAPCS64: 1-2 GPRs for
                    // structs <= 16 bytes; Win64: a single GPR
                    // for <= 8 bytes, hidden pointer otherwise).
                    // Implementing those splits is future work;
                    // for now flag the mismatch loudly.
                    if self.symbols[id_idx].class == Token::Sys as i64
                        && is_struct_ty(self.ty)
                        && struct_ptr_depth(self.ty) == 0
                    {
                        return Err(C5Error::Compile(format!(
                            "{}: argument {} of `{}` is a struct passed by value, \
                             but the platform-ABI struct-arg convention isn't \
                             implemented for Token::Sys calls. Pass `&s` (a \
                             pointer to the struct) instead.",
                            arg_line,
                            nargs + 1,
                            fn_name_for_warn
                        )));
                    }
                    self.emit_op(Op::Si);
                    nargs += 1;
                    if self.lex.tk == ',' as i64 {
                        self.next()?;
                    }
                }
                // Push from temp slots right-to-left so the first
                // declared param ends up on top of the c5 stack.
                for &temp_off in temp_offsets.iter().rev() {
                    self.emit_op(Op::Lea);
                    self.emit_val(temp_off);
                    self.emit_op(Op::Li);
                    self.emit_op(Op::Psh);
                }
                // For struct-returning callees, push the hidden
                // out-pointer (address of the result temp) so it
                // lands at val=2 -- ahead of the first declared
                // arg in the c5 stack walk. The callee's `return
                // s` writes through it; on return we set `a` to
                // the temp's address so the enclosing assignment
                // can Mcpy from it.
                if callee_returns_struct {
                    self.emit_op(Op::Lea);
                    self.emit_val(result_temp_off);
                    self.emit_op(Op::Psh);
                }
                // Release the staging slots; they'll be reused by
                // the next call in this function. The result-temp
                // slot stays alive (loc_offs not reset to it) until
                // the enclosing expression consumes it.
                let target_loc_offs = if callee_returns_struct {
                    saved_loc_offs_for_result + self.slots_of_type(callee_ret_ty)
                } else {
                    saved_loc_offs
                };
                self.loc_offs = target_loc_offs;
                // Arity underflow check (after the loop, when nargs is
                // final). Only fires for non-variadic functions with a
                // recorded signature.
                if !is_variadic
                    && !expected_params.is_empty()
                    && (nargs as usize) < expected_params.len()
                {
                    self.warn(format!(
                        "{}: warning: too few arguments to `{}` (expected {}, got {})",
                        self.lex.line,
                        fn_name_for_warn,
                        expected_params.len(),
                        nargs,
                    ));
                }
                self.next()?;
                if self.symbols[id_idx].class == Token::Sys as i64 {
                    // External library call. The symbol's `val` is
                    // the binding's flat index across all
                    // `#pragma binding(...)` directives the
                    // preprocessor parsed; the codegen / VM use it
                    // as the GOT slot lookup key (native) or the
                    // dispatch-table key (VM).
                    let jsrext_pc = self.text.len();
                    self.emit_op(Op::JsrExt);
                    self.emit_val(self.symbols[id_idx].val);
                    // Capture per-arg FP-ness for the codegen. Only
                    // needed when at least one arg is FP; an
                    // all-integer call rides the existing path.
                    let mut mask: u32 = 0;
                    for (i, &is_fp) in arg_is_fp.iter().enumerate() {
                        if is_fp && i < 32 {
                            mask |= 1u32 << i;
                        }
                    }
                    if mask != 0 {
                        self.call_fp_arg_masks.push((jsrext_pc, mask));
                    }
                } else if self.symbols[id_idx].class == Token::Fun as i64 {
                    self.emit_op(Op::Jsr);
                    self.emit_val(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Loc as i64
                    || self.symbols[id_idx].class == Token::Glo as i64
                {
                    if self.symbols[id_idx].class == Token::Loc as i64 {
                        self.emit_op(Op::Lea);
                        self.emit_val(self.symbols[id_idx].val);
                    } else {
                        self.emit_data_imm(self.symbols[id_idx].val);
                    }
                    self.emit_op(Op::Li);
                    self.emit_op(Op::Jsri);
                } else {
                    let name = self.symbols[id_idx].name.clone();
                    let suggestion = match super::headers::header_declaring(&name) {
                        Some(h) => format!(" -- try `#include <{h}>`"),
                        None => String::new(),
                    };
                    return Err(C5Error::Compile(format!(
                        "{}: unknown function `{name}`{suggestion}",
                        self.lex.line,
                    )));
                }
                let total_pushed = if callee_returns_struct {
                    nargs + 1
                } else {
                    nargs
                };
                if total_pushed > 0 {
                    self.emit_op(Op::Adj);
                    self.emit_val(total_pushed);
                }
                // For struct-returning callees, the result lives
                // in the caller-allocated temp. After the call,
                // load the temp's address into `a` so the
                // expression's value (matching M5 struct-rvalue
                // semantics: address-as-value) flows into the
                // enclosing assignment / `.field` access.
                if callee_returns_struct {
                    self.emit_op(Op::Lea);
                    self.emit_val(result_temp_off);
                }
                // For direct calls (Jsr/JsrExt) the symbol's `type_`
                // is the declared return type. For indirect calls
                // through a variable (Jsri), `type_` is the *variable*
                // type (e.g. `int *` for a function pointer), not the
                // return type -- using it as the result type spuriously
                // taints downstream assignments with "pointer assigned
                // to integer" warnings. The c5 dialect has no way to
                // declare the return type of a function pointer, so
                // default to `int` for the result.
                self.ty = if self.symbols[id_idx].class == Token::Loc as i64
                    || self.symbols[id_idx].class == Token::Glo as i64
                {
                    Ty::Int as i64
                } else {
                    self.symbols[id_idx].type_
                };
            } else if self.symbols[id_idx].class == Token::Num as i64 {
                self.emit_op(Op::Imm);
                self.emit_val(self.symbols[id_idx].val);
                self.ty = Ty::Int as i64;
            } else if self.symbols[id_idx].class == Token::Fun as i64 {
                // Bare function reference (e.g. `fp = add;`). The value
                // becomes a user-visible pointer, so it gets the CODE_BASE
                // bias -- that lets the VM tell apart "function pointer"
                // from "data pointer", and refuse to deref the former.
                self.emit_op(Op::Imm);
                self.emit_val(CODE_BASE as i64 + self.symbols[id_idx].val);
                // Type as `int*` rather than `char*`: matches the
                // conventional `int *fp = some_function;` idiom and
                // keeps the type-check loose-but-not-wrong.
                self.ty = Ty::Int as i64 + Ty::Ptr as i64;
            } else {
                if self.symbols[id_idx].class == Token::Loc as i64 {
                    self.emit_op(Op::Lea);
                    self.emit_val(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Glo as i64
                    && self.symbols[id_idx].is_thread_local
                {
                    // `_Thread_local` global: emit Op::TlsLea so
                    // the codegen lowers via the per-target TLS
                    // sequence (TPIDR_EL0 + offset on aarch64,
                    // fs:0 + offset on x86_64). The operand is the
                    // byte offset within the program's TLS block.
                    self.emit_op(Op::TlsLea);
                    self.emit_val(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Glo as i64 {
                    self.emit_data_imm(self.symbols[id_idx].val);
                } else {
                    return Err(C5Error::Compile(format!(
                        "{}: undefined variable {}",
                        self.lex.line, self.symbols[id_idx].name
                    )));
                }
                self.ty = self.symbols[id_idx].type_;
                // Struct values aren't 8-byte loadable -- the
                // expression's value is the struct's *address*. The
                // `.field` operator expects the address in `a` and
                // adds the field offset. Pointers to structs and
                // every scalar type still go through the normal
                // load_op_for path.
                if !(is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0) {
                    self.emit_op(load_op_for(self.ty));
                }
            }
        } else if self.lex.tk == '(' as i64 {
            self.next()?;
            if self.lex.tk == Token::Int as i64
                || self.lex.tk == Token::Char as i64
                || self.lex.tk == Token::Float as i64
                || self.lex.tk == Token::Double as i64
                || self.lex.tk == Token::Struct as i64
            {
                // C-style cast: `(<type>)expr`. Accepts int, char,
                // float, double, or struct base, with any number of
                // `*` markers.
                t = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp as i64 {
                    self.next()?;
                    t += Ty::Ptr as i64;
                }
                if self.lex.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C5Error::Compile(format!("{}: bad cast", self.lex.line)));
                }
                self.expr(Token::Inc as i64)?;
                // FP-vs-int casts emit conversion ops so the bit
                // pattern in r13 is consistent with the new type.
                // Same-class casts (int<->ptr, float<->double) are
                // bit-pattern-compatible and need no conversion.
                let target_is_fp = is_floating_scalar(t);
                let source_is_fp = is_floating_scalar(self.ty);
                if target_is_fp && !source_is_fp {
                    self.emit_op(Op::Fcvtif);
                } else if !target_is_fp && source_is_fp {
                    self.emit_op(Op::Fcvtfi);
                }
                self.ty = t;
            } else {
                self.expr(Token::Assign as i64)?;
                // Comma operator within parens: `(a, b, c)` evaluates
                // each subexpression for its side effects and yields
                // the last. Outside parens, comma stays a separator
                // (function args, declarators) -- this branch only
                // fires inside `(...)` because expr(Assign) doesn't
                // consume `,`.
                while self.lex.tk == ',' as i64 {
                    self.next()?;
                    self.expr(Token::Assign as i64)?;
                }
                if self.lex.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C5Error::Compile(format!(
                        "{}: close paren expected",
                        self.lex.line
                    )));
                }
            }
        } else if self.lex.tk == Token::MulOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            if self.ty > Ty::Int as i64 {
                self.ty -= Ty::Ptr as i64;
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: bad dereference",
                    self.lex.line
                )));
            }
            self.emit_op(load_op_for(self.ty));
        } else if self.lex.tk == Token::AndOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            let last = *self.text.last().unwrap();
            if last == Op::Lc as i64 || last == Op::Li as i64 {
                // Scalar / pointer lvalue: drop the trailing load
                // so what's left is the address-producing op.
                self.text.pop();
            } else if is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0 {
                // Struct value -- the parser already left the
                // address in `a` (no Li was emitted). `&s` just
                // raises the type by one pointer level; no IR
                // change needed.
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: bad address-of",
                    self.lex.line
                )));
            }
            self.ty += Ty::Ptr as i64;
        } else if self.lex.tk == '!' as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(0);
            self.emit_op(Op::Eq);
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == '~' as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(-1);
            self.emit_op(Op::Xor);
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::AddOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == Token::SubOp as i64 {
            self.next()?;
            // Constant-fold `-<int-literal>` into `Imm -N`. Float
            // literals don't qualify -- we want Op::Fneg to apply
            // to the parsed f64 bit pattern, not a sign flip on the
            // integer-shaped operand.
            if self.lex.tk == Token::Num as i64 {
                self.emit_op(Op::Imm);
                self.emit_val(-self.lex.ival);
                self.next()?;
                self.ty = Ty::Int as i64;
            } else {
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(self.ty) {
                    self.emit_op(Op::Fneg);
                    // self.ty already matches the operand's FP type
                } else {
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(-1);
                    self.emit_op(Op::Mul);
                    self.ty = Ty::Int as i64;
                }
            }
        } else if self.lex.tk == Token::Inc as i64 || self.lex.tk == Token::Dec as i64 {
            t = self.lex.tk;
            self.next()?;
            self.expr(Token::Inc as i64)?;
            let last = *self.text.last().unwrap();
            if last == Op::Lc as i64 {
                *self.text.last_mut().unwrap() = Op::Psh as i64;
                self.emit_op(Op::Lc);
            } else if last == Op::Li as i64 {
                *self.text.last_mut().unwrap() = Op::Psh as i64;
                self.emit_op(Op::Li);
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: bad lvalue in pre-increment",
                    self.lex.line
                )));
            }
            if is_floating_scalar(self.ty) {
                return Err(C5Error::Compile(format!(
                    "{}: floating-point ++/-- not yet implemented",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(if is_ptr_scaling_by_8(self.ty) { 8 } else { 1 });
            self.emit_op(if t == Token::Inc as i64 {
                Op::Add
            } else {
                Op::Sub
            });
            self.emit_op(store_op_for(self.ty));
        } else {
            return Err(C5Error::Compile(format!(
                "{}: bad expression tk={}",
                self.lex.line, self.lex.tk
            )));
        }

        while self.lex.tk >= lev {
            t = self.ty;
            if self.lex.tk == Token::Assign as i64 {
                self.next()?;
                let last = *self.text.last().unwrap();
                if last == Op::Lc as i64 || last == Op::Li as i64 {
                    // Scalar / pointer assignment: rewrite the
                    // trailing load into a push so the address is
                    // preserved on the stack while the RHS evaluates.
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                    let line = self.lex.line;
                    self.expr(Token::Assign as i64)?;
                    let rhs_is_zero = self.last_emit_is_zero();
                    if let Some(reason) = Self::type_warning(t, self.ty, rhs_is_zero) {
                        self.warn(format!(
                            "{line}: warning: {reason} in assignment \
                             (lhs={t}, rhs={})",
                            self.ty
                        ));
                    }
                    self.ty = t;
                    self.emit_op(store_op_for(self.ty));
                } else if is_struct_ty(t) && struct_ptr_depth(t) == 0 {
                    // Struct-to-struct copy. The LHS already left
                    // its address in `a`; push it so the RHS can
                    // produce the source address into `a`. Then
                    // emit Op::Mcpy with the byte size; the runtime
                    // (VM and both codegens) takes top-of-stack as
                    // dst, accumulator as src, and copies `size`
                    // bytes. Returns dst in `a` to mirror libc
                    // memcpy.
                    self.emit_op(Op::Psh);
                    self.expr(Token::Assign as i64)?;
                    if !is_struct_ty(self.ty) || struct_ptr_depth(self.ty) != 0 {
                        return Err(C5Error::Compile(format!(
                            "{}: cannot assign non-struct value to a struct",
                            self.lex.line
                        )));
                    }
                    if t != self.ty {
                        return Err(C5Error::Compile(format!(
                            "{}: struct types differ on either side of `=` \
                             (lhs={t}, rhs={})",
                            self.lex.line, self.ty
                        )));
                    }
                    let size = self.size_of_type(t);
                    self.emit_op(Op::Mcpy);
                    self.emit_val(size as i64);
                    self.ty = t;
                } else {
                    return Err(C5Error::Compile(format!(
                        "{}: bad lvalue in assignment",
                        self.lex.line
                    )));
                }
            } else if self.lex.tk == Token::Cond as i64 {
                self.next()?;
                self.emit_op(Op::Bz);
                let b_else = self.text.len();
                self.emit_val(0);
                self.expr(Token::Assign as i64)?;
                if self.lex.tk == ':' as i64 {
                    self.next()?;
                } else {
                    return Err(C5Error::Compile(format!(
                        "{}: conditional missing colon",
                        self.lex.line
                    )));
                }
                let b_end_val = (self.text.len() + 2) as i64;
                self.text[b_else] = b_end_val;
                self.emit_op(Op::Jmp);
                let b_end = self.text.len();
                self.emit_val(0);
                self.expr(Token::Cond as i64)?;
                self.text[b_end] = self.text.len() as i64;
            } else if self.lex.tk == Token::Lor as i64 {
                self.next()?;
                self.emit_op(Op::Bnz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::Lan as i64)?;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::Lan as i64 {
                self.next()?;
                self.emit_op(Op::Bz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::OrOp as i64)?;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::OrOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::XorOp as i64)?;
                self.emit_op(Op::Or);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::XorOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AndOp as i64)?;
                self.emit_op(Op::Xor);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::AndOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::EqOp as i64)?;
                self.emit_op(Op::And);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::EqOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "==")?;
                    self.emit_op(Op::Feq);
                } else {
                    self.emit_op(Op::Eq);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::NeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "!=")?;
                    self.emit_op(Op::Fne);
                } else {
                    self.emit_op(Op::Ne);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::LtOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "<")?;
                    self.emit_op(Op::Flt);
                } else {
                    self.emit_op(Op::Lt);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::GtOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, ">")?;
                    self.emit_op(Op::Fgt);
                } else {
                    self.emit_op(Op::Gt);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::LeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "<=")?;
                    self.emit_op(Op::Fle);
                } else {
                    self.emit_op(Op::Le);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::GeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, ">=")?;
                    self.emit_op(Op::Fge);
                } else {
                    self.emit_op(Op::Ge);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::ShlOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                self.emit_op(Op::Shl);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::ShrOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                self.emit_op(Op::Shr);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::AddOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::MulOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "+")?;
                    self.emit_op(Op::Fadd);
                    self.ty = fp_result_ty(t, self.ty);
                } else {
                    if is_ptr_scaling_by_8(t) {
                        self.emit_op(Op::Psh);
                        self.emit_op(Op::Imm);
                        self.emit_val(8);
                        self.emit_op(Op::Mul);
                    }
                    self.emit_op(Op::Add);
                    self.ty = t;
                }
            } else if self.lex.tk == Token::SubOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::MulOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "-")?;
                    self.emit_op(Op::Fsub);
                    self.ty = fp_result_ty(t, self.ty);
                } else if is_pointer_ty(t) && t == self.ty {
                    // ptr - ptr -> element count (Int). For deeper
                    // pointers (int*, int**, ...) the element size is
                    // 8 bytes so divide; for char* the byte count is
                    // the element count, no division.
                    self.emit_op(Op::Sub);
                    if is_ptr_scaling_by_8(t) {
                        self.emit_op(Op::Psh);
                        self.emit_op(Op::Imm);
                        self.emit_val(8);
                        self.emit_op(Op::Div);
                    }
                    self.ty = Ty::Int as i64;
                } else if is_ptr_scaling_by_8(t) {
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(8);
                    self.emit_op(Op::Mul);
                    self.emit_op(Op::Sub);
                    self.ty = t;
                } else {
                    self.emit_op(Op::Sub);
                    self.ty = t;
                }
            } else if self.lex.tk == Token::MulOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "*")?;
                    self.emit_op(Op::Fmul);
                    self.ty = fp_result_ty(t, self.ty);
                } else {
                    self.emit_op(Op::Mul);
                    self.ty = Ty::Int as i64;
                }
            } else if self.lex.tk == Token::DivOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "/")?;
                    self.emit_op(Op::Fdiv);
                    self.ty = fp_result_ty(t, self.ty);
                } else {
                    self.emit_op(Op::Div);
                    self.ty = Ty::Int as i64;
                }
            } else if self.lex.tk == Token::ModOp as i64 {
                self.next()?;
                if is_floating_scalar(t) {
                    return Err(C5Error::Compile(format!(
                        "{}: `%` is not defined on floating-point operands",
                        self.lex.line
                    )));
                }
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(self.ty) {
                    return Err(C5Error::Compile(format!(
                        "{}: `%` is not defined on floating-point operands",
                        self.lex.line
                    )));
                }
                self.emit_op(Op::Mod);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::Inc as i64 || self.lex.tk == Token::Dec as i64 {
                let last = *self.text.last().unwrap();
                if last == Op::Lc as i64 {
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                    self.emit_op(Op::Lc);
                } else if last == Op::Li as i64 {
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                    self.emit_op(Op::Li);
                } else {
                    return Err(C5Error::Compile(format!(
                        "{}: bad lvalue in post-increment",
                        self.lex.line
                    )));
                }
                if is_floating_scalar(self.ty) {
                    return Err(C5Error::Compile(format!(
                        "{}: floating-point ++/-- not yet implemented",
                        self.lex.line
                    )));
                }
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(if is_ptr_scaling_by_8(self.ty) { 8 } else { 1 });
                self.emit_op(if self.lex.tk == Token::Inc as i64 {
                    Op::Add
                } else {
                    Op::Sub
                });
                self.emit_op(store_op_for(self.ty));
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(if is_ptr_scaling_by_8(self.ty) { 8 } else { 1 });
                self.emit_op(if self.lex.tk == Token::Inc as i64 {
                    Op::Sub
                } else {
                    Op::Add
                });
                self.next()?;
            } else if self.lex.tk == Token::Brak as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Assign as i64)?;
                if self.lex.tk == ']' as i64 {
                    self.next()?;
                } else {
                    return Err(C5Error::Compile(format!(
                        "{}: close bracket expected",
                        self.lex.line
                    )));
                }
                if !is_pointer_ty(t) {
                    return Err(C5Error::Compile(format!(
                        "{}: pointer type expected",
                        self.lex.line
                    )));
                }
                if is_ptr_scaling_by_8(t) {
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(8);
                    self.emit_op(Op::Mul);
                }
                self.emit_op(Op::Add);
                self.ty = t - Ty::Ptr as i64;
                self.emit_op(load_op_for(self.ty));
            } else if self.lex.tk == Token::Arrow as i64 || self.lex.tk == Token::Dot as i64 {
                // p->field / s.field. Both shapes resolve a struct
                // field offset and load the field. The difference is
                // upstream: `->` runs on a struct pointer (which the
                // preceding subexpression loaded into `a` via Op::Li),
                // while `.` runs on a struct value, where the parser
                // suppressed the load and `a` already holds the
                // struct's address.
                let is_dot = self.lex.tk == Token::Dot as i64;
                let valid = if is_dot {
                    is_struct_ty(t) && struct_ptr_depth(t) == 0
                } else {
                    is_struct_ty(t) && struct_ptr_depth(t) == 1
                };
                if !valid {
                    let want = if is_dot {
                        "struct value"
                    } else {
                        "single-level struct pointer"
                    };
                    let op = if is_dot { "." } else { "->" };
                    return Err(C5Error::Compile(format!(
                        "{}: {op} requires a {want}",
                        self.lex.line
                    )));
                }
                self.next()?;
                if self.lex.tk != Token::Id as i64 {
                    let op = if is_dot { "." } else { "->" };
                    return Err(C5Error::Compile(format!(
                        "{}: field name expected after {op}",
                        self.lex.line
                    )));
                }
                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;

                let sid = struct_id_of(t);
                let field = self.structs[sid]
                    .fields
                    .iter()
                    .find(|f| f.name == field_name)
                    .ok_or_else(|| {
                        C5Error::Compile(format!(
                            "{}: struct {} has no field {}",
                            self.lex.line, self.structs[sid].name, field_name
                        ))
                    })?
                    .clone();

                if field.offset > 0 {
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(field.offset as i64);
                    self.emit_op(Op::Add);
                }
                self.ty = field.ty;
                // Trailing Lc/Li loads the field. The assignment handler
                // (in the same loop) converts a trailing Li/Lc to Psh, so
                // `p->x = value` and `s.x = value` work the same way as
                // `*ptr = value`. Struct-typed fields get no load -- the
                // address propagates so `s.inner.field` chains.
                if !(is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0) {
                    self.emit_op(load_op_for(self.ty));
                }
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: compiler error tk={}",
                    self.lex.line, self.lex.tk
                )));
            }
        }
        Ok(())
    }

    /// `for (init; cond; step) body`. The body is emitted between the
    /// condition (which falls through to it) and the step (which the
    /// body's tail jumps back to). `continue` patches into the step
    /// position; `break` patches past the loop end.
    fn parse_for_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.consume(b'(', "open paren expected")?;

        // Initialization (optional).
        if self.lex.tk != ';' as i64 {
            self.expr(Token::Assign as i64)?;
        }
        self.consume(b';', "semicolon expected after for-init")?;

        // Condition (optional -- empty means `1`).
        let cond_pc = self.text.len();
        if self.lex.tk != ';' as i64 {
            self.expr(Token::Assign as i64)?;
        } else {
            self.emit_op(Op::Imm);
            self.emit_val(1);
        }
        self.emit_op(Op::Bz);
        let end_jmp_pc = self.text.len();
        self.emit_val(0);

        self.emit_op(Op::Jmp);
        let body_jmp_pc = self.text.len();
        self.emit_val(0);

        self.consume(b';', "semicolon expected after for-cond")?;

        // Step (optional). Compiled before the body so the body can jump
        // back to it; the body itself is reached via the `body_jmp_pc`
        // patched a few lines below.
        let step_pc = self.text.len();
        if self.lex.tk != ')' as i64 {
            self.expr(Token::Assign as i64)?;
        }
        self.emit_op(Op::Jmp);
        self.emit_val(cond_pc as i64);

        self.consume(b')', "close paren expected")?;

        // Body -- patched to start at the current PC.
        self.text[body_jmp_pc] = self.text.len() as i64;
        self.loop_breaks.push(Vec::new());
        self.loop_continues.push(Vec::new());
        self.stmt()?;

        for pc in self.loop_continues.pop().unwrap() {
            self.text[pc] = step_pc as i64;
        }
        self.emit_op(Op::Jmp);
        self.emit_val(step_pc as i64);

        self.text[end_jmp_pc] = self.text.len() as i64;
        let end_pc = self.text.len();
        for pc in self.loop_breaks.pop().unwrap() {
            self.text[pc] = end_pc as i64;
        }
        Ok(())
    }

    /// `switch (expr) { ... }`. Three phases: stash the scrutinee in a
    /// fresh local slot, parse the body (which records `case`/`default`
    /// label positions in `switch_cases`/`switch_defaults`), then emit a
    /// trailing dispatcher that compares the stashed value against each
    /// case label and jumps. Breaks inside the body are pushed onto
    /// `loop_breaks` and patched to land just past the dispatcher.
    fn parse_switch_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        self.consume(b'(', "open paren expected")?;

        self.loc_offs += 1;
        let switch_val_offset = -self.loc_offs;
        self.emit_op(Op::Lea);
        self.emit_val(switch_val_offset);
        self.emit_op(Op::Psh);

        self.expr(Token::Assign as i64)?;
        self.consume(b')', "close paren expected")?;

        self.emit_op(Op::Si);

        // Jump past the body to the dispatcher emitted at the end.
        self.emit_op(Op::Jmp);
        let disp_pc_patch = self.text.len();
        self.emit_val(0);

        self.switch_cases.push(Vec::new());
        self.switch_defaults.push(None);
        self.loop_breaks.push(Vec::new());

        self.stmt()?;

        // Fall-through past the body skips the dispatcher entirely.
        self.emit_op(Op::Jmp);
        let end_switch_patch = self.text.len();
        self.emit_val(0);

        // Dispatcher block.
        self.text[disp_pc_patch] = self.text.len() as i64;
        let cases = self.switch_cases.pop().unwrap();
        let default_pc = self.switch_defaults.pop().unwrap();

        for (val, pc) in cases {
            self.emit_op(Op::Lea);
            self.emit_val(switch_val_offset);
            self.emit_op(Op::Li);
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(val);
            self.emit_op(Op::Eq);
            self.emit_op(Op::Bnz);
            self.emit_val(pc as i64);
        }

        if let Some(dpc) = default_pc {
            self.emit_op(Op::Jmp);
            self.emit_val(dpc as i64);
        } else {
            // No default: fall through to the end (patched below alongside
            // explicit `break`s).
            self.emit_op(Op::Jmp);
            self.emit_val(0);
            self.loop_breaks
                .last_mut()
                .unwrap()
                .push(self.text.len() - 1);
        }

        self.text[end_switch_patch] = self.text.len() as i64;
        let end_pc = self.text.len();
        for pc in self.loop_breaks.pop().unwrap() {
            self.text[pc] = end_pc as i64;
        }
        Ok(())
    }

    /// `{ <decls> <stmts> }`. C4-style block scoping: any local
    /// declarations must come first; the names they bind shadow outer
    /// symbols for the duration of the block and are restored on exit.
    fn parse_block_stmt(&mut self) -> Result<(), C5Error> {
        self.next()?;
        let mut block_symbols = Vec::new();

        // Block-scoped local variables (declared at the top of the block).
        while self.lex.tk == Token::Int as i64
            || self.lex.tk == Token::Char as i64
            || self.lex.tk == Token::Float as i64
            || self.lex.tk == Token::Double as i64
            || self.lex.tk == Token::Struct as i64
            // `extern` / `static` are accepted as no-op
            // storage-class prefixes on local declarations,
            // matching the file-scope handling. C lets you
            // write `static int counter = 0;` inside a
            // function for "function-scope persistent
            // storage", but c5 only has automatic locals --
            // we consume the keyword and the local stays
            // automatic. Surface code that relies on the
            // persistence semantics will misbehave at
            // runtime; it's still useful to compile cleanly
            // so unmodified C from the wild lexes.
            || self.lex.tk == Token::Extern as i64
            || self.lex.tk == Token::Static as i64
        {
            // Consume any leading extern / static prefixes on
            // the local decl. Order doesn't matter; both are
            // no-ops.
            while self.lex.tk == Token::Extern as i64 || self.lex.tk == Token::Static as i64 {
                self.next()?;
            }
            let lbt = self.parse_decl_base_type()?;
            while self.lex.tk != ';' as i64 {
                let (loc_idx, ty) = self.parse_declarator(lbt)?;
                self.ty = ty;

                block_symbols.push((
                    loc_idx,
                    self.symbols[loc_idx].class,
                    self.symbols[loc_idx].type_,
                    self.symbols[loc_idx].val,
                ));

                self.symbols[loc_idx].class = Token::Loc as i64;
                self.symbols[loc_idx].type_ = ty;
                self.loc_offs += self.slots_of_type(ty);
                self.symbols[loc_idx].val = -self.loc_offs;
                if self.loc_offs > self.max_loc_offs {
                    self.max_loc_offs = self.loc_offs;
                }

                if self.lex.tk == ',' as i64 {
                    self.next()?;
                }
            }
            self.next()?;
        }

        while self.lex.tk != '}' as i64 {
            self.stmt()?;
        }
        self.next()?;

        // Restore shadowed bindings on block exit.
        for (idx, class, ty, val) in block_symbols.into_iter().rev() {
            self.symbols[idx].class = class;
            self.symbols[idx].type_ = ty;
            self.symbols[idx].val = val;
        }
        Ok(())
    }

    fn stmt(&mut self) -> Result<(), C5Error> {
        if self.lex.tk == Token::Id as i64 && self.lex.peek_after_whitespace(b':') {
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.labels.push((name, self.text.len()));
            self.next()?; // consume Id
            self.next()?; // consume ':'
            self.stmt()?;
            return Ok(());
        }

        if self.lex.tk == Token::If as i64 {
            self.next()?;
            self.consume(b'(', "open paren expected")?;
            self.expr(Token::Assign as i64)?;
            self.consume(b')', "close paren expected")?;
            self.emit_op(Op::Bz);
            let b = self.text.len();
            self.emit_val(0);
            self.stmt()?;
            if self.lex.tk == Token::Else as i64 {
                self.text[b] = (self.text.len() + 2) as i64;
                self.emit_op(Op::Jmp);
                let b_else = self.text.len();
                self.emit_val(0);
                self.next()?;
                self.stmt()?;
                self.text[b_else] = self.text.len() as i64;
            } else {
                self.text[b] = self.text.len() as i64;
            }
        } else if self.lex.tk == Token::While as i64 {
            self.next()?;
            let cond_pc = self.text.len();
            self.consume(b'(', "open paren expected")?;
            self.expr(Token::Assign as i64)?;
            self.consume(b')', "close paren expected")?;
            self.emit_op(Op::Bz);
            let bz_pc = self.text.len();
            self.emit_val(0);

            self.loop_breaks.push(Vec::new());
            self.loop_continues.push(Vec::new());

            self.stmt()?;

            for pc in self.loop_continues.pop().unwrap() {
                self.text[pc] = cond_pc as i64;
            }

            self.emit_op(Op::Jmp);
            self.emit_val(cond_pc as i64);

            self.text[bz_pc] = self.text.len() as i64;
            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.lex.tk == Token::Do as i64 {
            self.next()?;
            let start_pc = self.text.len();

            self.loop_breaks.push(Vec::new());
            self.loop_continues.push(Vec::new());

            self.stmt()?;

            if self.lex.tk == Token::While as i64 {
                self.next()?;
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: while expected after do",
                    self.lex.line
                )));
            }

            let cond_pc = self.text.len();
            for pc in self.loop_continues.pop().unwrap() {
                self.text[pc] = cond_pc as i64;
            }

            self.consume(b'(', "open paren expected")?;
            self.expr(Token::Assign as i64)?;
            self.consume(b')', "close paren expected")?;

            self.emit_op(Op::Bnz);
            self.emit_val(start_pc as i64);

            self.consume(b';', "semicolon expected after do-while")?;

            let end_pc = self.text.len();
            for pc in self.loop_breaks.pop().unwrap() {
                self.text[pc] = end_pc as i64;
            }
        } else if self.lex.tk == Token::For as i64 {
            self.parse_for_stmt()?;
        } else if self.lex.tk == Token::Switch as i64 {
            self.parse_switch_stmt()?;
        } else if self.lex.tk == Token::Case as i64 {
            self.next()?;
            if self.lex.tk != Token::Num as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: invalid case value",
                    self.lex.line
                )));
            }
            let val = self.lex.ival;
            self.next()?;
            self.consume(b':', "expected colon after case")?;
            let Some(cases) = self.switch_cases.last_mut() else {
                return Err(C5Error::Compile(format!(
                    "{}: case outside switch",
                    self.lex.line
                )));
            };
            cases.push((val, self.text.len()));
            self.stmt()?;
        } else if self.lex.tk == Token::Default as i64 {
            self.next()?;
            self.consume(b':', "expected colon after default")?;
            let Some(def) = self.switch_defaults.last_mut() else {
                return Err(C5Error::Compile(format!(
                    "{}: default outside switch",
                    self.lex.line
                )));
            };
            *def = Some(self.text.len());
            self.stmt()?;
        } else if self.lex.tk == Token::Goto as i64 {
            self.next()?;
            if self.lex.tk != Token::Id as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: expected identifier after goto",
                    self.lex.line
                )));
            }
            let target_name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;

            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);

            match self.labels.iter().find(|(n, _)| n == &target_name) {
                Some(&(_, target)) => self.text[pc] = target as i64,
                None => self.unresolved_gotos.push((target_name, pc)),
            }

            self.consume(b';', "semicolon expected after goto")?;
        } else if self.lex.tk == Token::Break as i64 {
            self.next()?;
            if self.loop_breaks.is_empty() {
                return Err(C5Error::Compile(format!(
                    "{}: break outside of loop or switch",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.loop_breaks.last_mut().unwrap().push(pc);
            self.consume(b';', "semicolon expected after break")?;
        } else if self.lex.tk == Token::Continue as i64 {
            self.next()?;
            if self.loop_continues.is_empty() {
                return Err(C5Error::Compile(format!(
                    "{}: continue outside of loop",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Jmp);
            let pc = self.text.len();
            self.emit_val(0);
            self.loop_continues.last_mut().unwrap().push(pc);
            self.consume(b';', "semicolon expected after continue")?;
        } else if self.lex.tk == Token::Return as i64 {
            self.next()?;
            let ret_ty = self.current_func_return_ty;
            let returns_struct = is_struct_ty(ret_ty) && struct_ptr_depth(ret_ty) == 0;
            if self.lex.tk != ';' as i64 {
                if returns_struct {
                    // Push the hidden out-pointer (loaded from
                    // val=2 -- the slot the caller pushed before
                    // the declared args) and emit Mcpy to copy
                    // the source struct's bytes into the caller's
                    // result temp. Then Lev. The accumulator
                    // value Lev returns is overwritten by the
                    // call site's `Lea result_temp` after the
                    // call so the assignment has a stable
                    // address to copy from.
                    self.emit_op(Op::Lea);
                    self.emit_val(2);
                    self.emit_op(Op::Li);
                    self.emit_op(Op::Psh);
                    self.expr(Token::Assign as i64)?;
                    if !is_struct_ty(self.ty) || struct_ptr_depth(self.ty) != 0 {
                        return Err(C5Error::Compile(format!(
                            "{}: returning a non-struct value from a \
                             struct-returning function",
                            self.lex.line
                        )));
                    }
                    let size = self.size_of_type(ret_ty);
                    self.emit_op(Op::Mcpy);
                    self.emit_val(size as i64);
                } else {
                    self.expr(Token::Assign as i64)?;
                }
            }
            self.emit_op(Op::Lev);
            self.consume(b';', "semicolon expected")?;
        } else if self.lex.tk == '{' as i64 {
            self.parse_block_stmt()?;
        } else if self.lex.tk == ';' as i64 {
            self.next()?;
        } else {
            self.expr(Token::Assign as i64)?;
            self.consume(b';', "semicolon expected")?;
        }
        Ok(())
    }

    /// Consume a single-byte token, returning a labelled compile error otherwise.
    fn consume(&mut self, expected: u8, msg: &str) -> Result<(), C5Error> {
        if self.lex.tk == expected as i64 {
            self.next()?;
            Ok(())
        } else {
            Err(C5Error::Compile(format!("{}: {}", self.lex.line, msg)))
        }
    }

    fn parse_enum_decl(&mut self) -> Result<(), C5Error> {
        self.next()?;
        if self.lex.tk != '{' as i64 {
            self.next()?;
        }
        if self.lex.tk == '{' as i64 {
            self.next()?;
            let mut i = 0;
            while self.lex.tk != '}' as i64 {
                if self.lex.tk != Token::Id as i64 {
                    return Err(C5Error::Compile(format!(
                        "{}: bad enum identifier",
                        self.lex.line
                    )));
                }
                let idx = self.lex.curr_id_idx;
                self.next()?;
                if self.lex.tk == Token::Assign as i64 {
                    self.next()?;
                    if self.lex.tk != Token::Num as i64 {
                        return Err(C5Error::Compile(format!(
                            "{}: bad enum initializer",
                            self.lex.line
                        )));
                    }
                    i = self.lex.ival;
                    self.next()?;
                }
                self.symbols[idx].class = Token::Num as i64;
                self.symbols[idx].type_ = Ty::Int as i64;
                self.symbols[idx].val = i;
                i += 1;
                if self.lex.tk == ',' as i64 {
                    self.next()?;
                }
            }
            self.next()?;
        }
        Ok(())
    }

    /// Returned from [`Compiler::parse_function_params`]. Carries the
    /// param symbol indices (for binding to stack slots in the function
    /// body), the declared types (for the function signature), and the
    /// variadic flag.
    fn parse_function_params(&mut self) -> Result<ParsedParams, C5Error> {
        let mut args = Vec::new();
        let mut types = Vec::new();
        let mut is_variadic = false;
        while self.lex.tk != ')' as i64 {
            // `...` ends the typed-parameter list and marks the function
            // variadic. Anything after is a syntax error.
            if self.lex.tk == Token::Ellipsis as i64 {
                self.next()?;
                if self.lex.tk != ')' as i64 {
                    return Err(C5Error::Compile(format!(
                        "{}: `...` must be the last parameter",
                        self.lex.line
                    )));
                }
                is_variadic = true;
                break;
            }
            // Consume any extern/static prefixes on parameter
            // decls. C lets you write `void f(static int n)`
            // (it's diagnosed in some compilers but legal in
            // others) and `register` would belong here too if
            // we ever supported it. No semantic effect.
            while self.lex.tk == Token::Extern as i64 || self.lex.tk == Token::Static as i64 {
                self.next()?;
            }
            let base = if self.lex.tk == Token::Int as i64
                || self.lex.tk == Token::Char as i64
                || self.lex.tk == Token::Float as i64
                || self.lex.tk == Token::Double as i64
                || self.lex.tk == Token::Struct as i64
            {
                self.parse_decl_base_type()?
            } else {
                Ty::Int as i64
            };
            let (param_idx, ty) = self.parse_declarator(base)?;
            self.ty = ty;
            if self.symbols[param_idx].class == Token::Loc as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: duplicate parameter definition",
                    self.lex.line
                )));
            }

            self.symbols[param_idx].h_class = self.symbols[param_idx].class;
            self.symbols[param_idx].class = Token::Loc as i64;
            self.symbols[param_idx].h_type = self.symbols[param_idx].type_;
            self.symbols[param_idx].type_ = ty;
            self.symbols[param_idx].h_val = self.symbols[param_idx].val;

            args.push(param_idx);
            types.push(ty);

            if self.lex.tk == ',' as i64 {
                self.next()?;
            }
        }
        self.next()?;
        Ok(ParsedParams {
            indices: args,
            types,
            is_variadic,
        })
    }

    fn run_compile(&mut self) -> Result<(), C5Error> {
        self.next()?;
        while self.lex.tk != 0 {
            let mut bt = Ty::Int as i64;
            // Storage-class prefixes -- can appear in any order
            // and any combination before the type. C lets you
            // mix `static extern` (silly but legal in some
            // compilers) and `_Thread_local extern` (legal),
            // so we accept any ordering. `extern` and `static`
            // are no-ops in c5 (every symbol already has
            // internal linkage and there's no separate
            // translation-unit story); `_Thread_local` flips
            // the per-thread storage flag.
            let mut thread_local = false;
            loop {
                if self.lex.tk == Token::ThreadLocal as i64 {
                    thread_local = true;
                    self.next()?;
                } else if self.lex.tk == Token::Extern as i64 || self.lex.tk == Token::Static as i64
                {
                    self.next()?;
                } else {
                    break;
                }
            }
            if self.lex.tk == Token::Int as i64 {
                self.next()?;
                bt = Ty::Int as i64;
            } else if self.lex.tk == Token::Char as i64 {
                self.next()?;
                bt = Ty::Char as i64;
            } else if self.lex.tk == Token::Float as i64 {
                self.next()?;
                bt = Ty::Float as i64;
            } else if self.lex.tk == Token::Double as i64 {
                self.next()?;
                bt = Ty::Double as i64;
            } else if self.lex.tk == Token::Enum as i64 {
                self.parse_enum_decl()?;
            } else if self.lex.tk == Token::Struct as i64 {
                // Two shapes:
                //   struct Foo { ... };       -- definition only
                //   struct Foo *p;            -- type use, declarators follow
                self.next()?; // consume `struct`
                if self.lex.tk != Token::Id as i64 {
                    return Err(C5Error::Compile(format!(
                        "{}: struct name expected",
                        self.lex.line
                    )));
                }
                let name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;

                if self.lex.tk == '{' as i64 {
                    self.parse_struct_body(&name)?;
                    // tk is now whatever follows `}` (typically `;`); the
                    // declarator inner loop sees `;` immediately and the
                    // outer `next()` below consumes it.
                } else {
                    let id = self.find_struct_id(&name).ok_or_else(|| {
                        C5Error::Compile(format!("{}: unknown struct {}", self.lex.line, name))
                    })?;
                    bt = struct_ty_for(id);
                }
            }

            while self.lex.tk != ';' as i64 && self.lex.tk != '}' as i64 {
                let (id_idx, ty) = self.parse_declarator(bt)?;
                self.ty = ty;
                // Sys-class predefined symbols (the per-target
                // header's libc bindings) are allowed to be
                // *re-declared* as prototypes -- the source uses the
                // declaration to teach the parser the type signature
                // without overriding the function's binding-driven
                // class/val. Anything else with class != 0 is a real
                // duplicate.
                let was_sys = self.symbols[id_idx].class == Token::Sys as i64;
                if self.symbols[id_idx].class != 0 && !was_sys {
                    return Err(C5Error::Compile(format!(
                        "{}: duplicate global definition",
                        self.lex.line
                    )));
                }
                self.symbols[id_idx].type_ = ty;

                if self.lex.tk == '(' as i64 {
                    if !was_sys {
                        self.symbols[id_idx].class = Token::Fun as i64;
                        self.symbols[id_idx].val = self.text.len() as i64;
                    }
                    self.next()?;

                    let params = self.parse_function_params()?;

                    // Stash the signature on the function symbol so
                    // call sites can type-check arguments later. For
                    // both prototypes and bodied definitions.
                    self.symbols[id_idx].params = params.types.clone();
                    self.symbols[id_idx].is_variadic = params.is_variadic;

                    // For Sys symbols (header-bound libc functions),
                    // also fold the variadic flag onto the matching
                    // `#pragma binding`. The native lowering reads it
                    // when it picks the variadic ABI dance (macOS
                    // arm64 stack-packing, SysV xor eax,eax) instead
                    // of asking the symbol table at codegen time --
                    // which has long since gone out of scope.
                    if was_sys {
                        let name = self.symbols[id_idx].name.clone();
                        let fixed = params.types.len();
                        let variadic = params.is_variadic;
                        for spec in self.dylibs.iter_mut() {
                            for binding in spec.bindings.iter_mut() {
                                if binding.local_name == name {
                                    binding.is_variadic = variadic;
                                    binding.fixed_args = fixed;
                                }
                            }
                        }
                    }

                    if self.lex.tk == ';' as i64 {
                        // Forward declaration / prototype --
                        // `int foo(int a, ...);`. Restore the param
                        // symbols' outer class (parse_function_params
                        // marked them as `Loc`) so subsequent
                        // declarations of the same names don't trip
                        // the duplicate-global check.
                        for sym in self.symbols.iter_mut() {
                            if sym.class == Token::Loc as i64 {
                                sym.class = sym.h_class;
                                sym.type_ = sym.h_type;
                                sym.val = sym.h_val;
                            }
                        }
                        // Outer loop sees `;` and exits; `self.next()`
                        // after the loop consumes it.
                        if self.lex.tk == ',' as i64 {
                            self.next()?;
                        }
                        continue;
                    }

                    if was_sys {
                        return Err(C5Error::Compile(format!(
                            "{}: cannot give a body to predefined library function `{}` \
                             (the per-target header's `#pragma binding` provides the \
                             implementation -- use a prototype only)",
                            self.lex.line, self.symbols[id_idx].name
                        )));
                    }
                    if self.lex.tk != '{' as i64 {
                        return Err(C5Error::Compile(format!(
                            "{}: bad function definition",
                            self.lex.line
                        )));
                    }
                    self.next()?;

                    // Track this function's declared return type
                    // so the `return s` lowering knows whether to
                    // emit a struct-copy through the hidden
                    // out-pointer.
                    let return_ty = self.symbols[id_idx].type_;
                    self.current_func_return_ty = return_ty;
                    let returns_struct =
                        is_struct_ty(return_ty) && struct_ptr_depth(return_ty) == 0;

                    // c5 callers push args right-to-left (cdecl-style), so
                    // the i'th declared param ends up at `[bp + 16*(i+1)]`,
                    // i.e. val = i + 2: the first declared param is at the
                    // shallowest c5 stack slot, the last is deepest.
                    // Variadic args follow after the last declared, at
                    // val = N+2, N+3, ... -- which is what stdarg.h walks.
                    //
                    // Functions returning a struct value get a hidden
                    // out-pointer at val=2 (the caller pre-allocates a
                    // result temp and pushes its address as the first
                    // arg); declared params start at val=3 in that
                    // case. Variadic + struct-return aren't useful
                    // together so we don't bother optimising for it.
                    let param_base = if returns_struct { 3 } else { 2 };
                    for (i, &idx) in params.indices.iter().enumerate() {
                        self.symbols[idx].val = (i as i64) + param_base;
                    }

                    self.loc_offs = 0;
                    self.max_loc_offs = 0;
                    self.labels.clear();
                    self.unresolved_gotos.clear();

                    while self.lex.tk == Token::Int as i64
                        || self.lex.tk == Token::Char as i64
                        || self.lex.tk == Token::Float as i64
                        || self.lex.tk == Token::Double as i64
                        || self.lex.tk == Token::Struct as i64
                        || self.lex.tk == Token::Extern as i64
                        || self.lex.tk == Token::Static as i64
                    {
                        // Consume any extern/static prefixes
                        // before the type token; both are
                        // no-op storage classes in c5. See
                        // the comment in `parse_block_stmt`
                        // for the rationale.
                        while self.lex.tk == Token::Extern as i64
                            || self.lex.tk == Token::Static as i64
                        {
                            self.next()?;
                        }
                        let lbt = self.parse_decl_base_type()?;
                        while self.lex.tk != ';' as i64 {
                            let (loc_idx, ty) = self.parse_declarator(lbt)?;
                            self.ty = ty;
                            if self.symbols[loc_idx].class == Token::Loc as i64 {
                                return Err(C5Error::Compile(format!(
                                    "{}: duplicate local definition",
                                    self.lex.line
                                )));
                            }

                            self.symbols[loc_idx].h_class = self.symbols[loc_idx].class;
                            self.symbols[loc_idx].class = Token::Loc as i64;
                            self.symbols[loc_idx].h_type = self.symbols[loc_idx].type_;
                            self.symbols[loc_idx].type_ = ty;
                            self.symbols[loc_idx].h_val = self.symbols[loc_idx].val;

                            self.loc_offs += self.slots_of_type(ty);
                            self.symbols[loc_idx].val = -self.loc_offs;
                            if self.loc_offs > self.max_loc_offs {
                                self.max_loc_offs = self.loc_offs;
                            }

                            if self.lex.tk == ',' as i64 {
                                self.next()?;
                            }
                        }
                        self.next()?;
                    }

                    let ent_pc = self.text.len();
                    self.emit_op(Op::Ent);
                    self.emit_val(0); // patched below

                    // Struct-value parameters: the caller pushed
                    // the struct's *address* into the param slot
                    // (matching the M5 "address is the value" rule
                    // for struct rvalues). Without a copy the
                    // function body's `p.field = v` would land in
                    // the caller's storage, which isn't C
                    // by-value. Memcpy each struct param into a
                    // freshly allocated local and re-point the
                    // param's symbol so subsequent accesses inside
                    // the function go to the local copy. The
                    // sequence reuses Op::Mcpy from M6 so neither
                    // codegen needs new shapes for parameter
                    // passing.
                    for &idx in params.indices.iter() {
                        let pty = self.symbols[idx].type_;
                        if !is_struct_ty(pty) || struct_ptr_depth(pty) != 0 {
                            continue;
                        }
                        let slots = self.slots_of_type(pty);
                        let size = self.size_of_type(pty);
                        let param_val = self.symbols[idx].val;
                        self.loc_offs += slots;
                        let local_val = -self.loc_offs;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        // dst = &local
                        self.emit_op(Op::Lea);
                        self.emit_val(local_val);
                        self.emit_op(Op::Psh);
                        // src = *param_slot (the passed address;
                        // val from the param-base-aware
                        // numbering above)
                        self.emit_op(Op::Lea);
                        self.emit_val(param_val);
                        self.emit_op(Op::Li);
                        // Mcpy size
                        self.emit_op(Op::Mcpy);
                        self.emit_val(size as i64);
                        // The symbol now points at the local copy.
                        self.symbols[idx].val = local_val;
                    }

                    while self.lex.tk != '}' as i64 {
                        self.stmt()?;
                    }
                    self.emit_op(Op::Lev);

                    self.text[ent_pc + 1] = self.max_loc_offs.max(self.loc_offs);

                    for (name, pc) in &self.unresolved_gotos {
                        match self.labels.iter().find(|(n, _)| n == name) {
                            Some(&(_, target)) => self.text[*pc] = target as i64,
                            None => {
                                return Err(C5Error::Compile(format!(
                                    "unresolved label: {}",
                                    name
                                )));
                            }
                        }
                    }

                    for sym in self.symbols.iter_mut() {
                        if sym.class == Token::Loc as i64 {
                            sym.class = sym.h_class;
                            sym.type_ = sym.h_type;
                            sym.val = sym.h_val;
                        }
                    }
                } else {
                    self.symbols[id_idx].class = Token::Glo as i64;
                    self.symbols[id_idx].is_thread_local = thread_local;
                    let var_offset = if thread_local {
                        // Allocate the variable in the TLS block.
                        // `val` holds the byte offset within
                        // `tls_data`; the codegen translates it
                        // to a TPIDR_EL0 / fs:0 offset at lowering
                        // time. Each variable gets
                        // `slots_of_type(ty) * 8` bytes (the c5
                        // VM stores everything in 8-byte slots).
                        let slots = self.slots_of_type(ty);
                        let off = self.tls_data.len() as i64;
                        self.symbols[id_idx].val = off;
                        for _ in 0..(slots * 8) {
                            self.tls_data.push(0);
                        }
                        off
                    } else {
                        // Same `slots_of_type * 8` accounting for
                        // the regular data segment, so structs at
                        // file scope get their full storage. The
                        // c5 dialect didn't have struct globals
                        // before; the previous "always 8 bytes"
                        // allocation was a latent bug that nothing
                        // exercised. See `static_linked_list.c`
                        // for the regression coverage.
                        let slots = self.slots_of_type(ty);
                        let off = self.data.len() as i64;
                        self.symbols[id_idx].val = off;
                        for _ in 0..(slots * 8) {
                            self.data.push(0);
                        }
                        off
                    };

                    // Optional initializer: `int x = 5;`,
                    // `int *p = 0;`, `int *p = &y;`. Restricted
                    // grammar -- this is a constant-expression
                    // path, not the full expression parser, so
                    // the right-hand side is one of:
                    //   * an integer constant (`Token::Num`,
                    //     possibly negated),
                    //   * `Token::Sub` followed by `Token::Num`,
                    //   * `&<global-name>` for pointer init,
                    //   * `Token::Num == 0` for NULL pointer
                    //     init (any pointer LHS).
                    // String literals and casts are future
                    // work; the user's stated motivation
                    // (static linked lists) needs only
                    // address-of-global plus integer constants.
                    if self.lex.tk == Token::Assign as i64 {
                        self.next()?;
                        self.parse_global_initializer(ty, var_offset, thread_local)?;
                    }
                }
                if self.lex.tk == ',' as i64 {
                    self.next()?;
                }
            }
            self.next()?;
        }
        Ok(())
    }

    /// Parse a global / TLS initializer's right-hand side and
    /// stash the bytes into [`Self::data`] / [`Self::tls_data`]
    /// at `var_offset`. The grammar is intentionally narrow --
    /// integer constants (with optional unary `-`) and
    /// `&<global-name>`. Anything else surfaces a clear "bad
    /// global initializer" diagnostic so the parser stays
    /// honest about what it accepts.
    fn parse_global_initializer(
        &mut self,
        var_ty: i64,
        var_offset: i64,
        is_thread_local: bool,
    ) -> Result<(), C5Error> {
        let line = self.lex.line;
        // `&<global>` -- address-of-global pointer init.
        if self.lex.tk == Token::AndOp as i64 {
            if is_thread_local {
                return Err(C5Error::Compile(format!(
                    "{line}: address-of-global initializer for `_Thread_local` \
                     not yet supported (the rebase / .reloc ordering against \
                     the TLS template needs design work; integer / NULL \
                     initializers are fine)"
                )));
            }
            self.next()?;
            if self.lex.tk != Token::Id as i64 {
                return Err(C5Error::Compile(format!(
                    "{line}: identifier expected after `&` in initializer"
                )));
            }
            let target_idx = self.lex.curr_id_idx;
            let target_class = self.symbols[target_idx].class;
            if target_class != Token::Glo as i64 {
                return Err(C5Error::Compile(format!(
                    "{line}: `&{}` in a global initializer requires a \
                     non-thread_local global; the right-hand side is \
                     class={target_class}",
                    self.symbols[target_idx].name
                )));
            }
            if self.symbols[target_idx].is_thread_local {
                return Err(C5Error::Compile(format!(
                    "{line}: `&{}` -- can't take the address of a \
                     `_Thread_local` global in a static initializer; the \
                     per-thread address isn't fixed at link time",
                    self.symbols[target_idx].name
                )));
            }
            let target_offset = self.symbols[target_idx].val;
            self.next()?;
            // Write the target's data-segment offset into the
            // slot. The VM reads this directly because its
            // pointers are small data offsets (no image-base
            // arithmetic). The native writers overwrite this
            // with the target's absolute VA at write time --
            // ELF (ET_EXEC) writes a fully-resolved VA; Mach-O
            // and PE write the preferred VA and emit a
            // dynamic relocation (rebase opcode / .reloc DIR64
            // entry) so the loader can patch in the slide
            // delta.
            let bytes = (target_offset as u64).to_le_bytes();
            self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
            self.data_relocs.push(crate::c5::program::DataReloc {
                data_offset: var_offset as u64,
                target_offset: target_offset as u64,
            });
            return Ok(());
        }

        // Integer literal, optionally negated. Anything else
        // is rejected.
        let mut sign: i64 = 1;
        if self.lex.tk == Token::SubOp as i64 {
            sign = -1;
            self.next()?;
        } else if self.lex.tk == Token::AddOp as i64 {
            // Unary `+` is a no-op; tolerate it for symmetry
            // with the negation case.
            self.next()?;
        }
        if self.lex.tk != Token::Num as i64 {
            return Err(C5Error::Compile(format!(
                "{line}: bad global initializer (expected integer constant \
                 or `&<global>`, got tk={})",
                self.lex.tk
            )));
        }
        let value = sign.wrapping_mul(self.lex.ival);
        self.next()?;

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
        debug_assert!(off + 8 <= segment.len());
        segment[off..off + 8].copy_from_slice(&bytes);

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

        // Type-check: warn (don't error) if the constant
        // doesn't match the declared type. For now we only
        // care about pointer-vs-int mismatches the way the
        // assignment path does.
        let init_ty = if value == 0 { 0 } else { Ty::Int as i64 };
        if let Some(reason) = Self::type_warning(var_ty, init_ty, value == 0) {
            self.warn(format!(
                "{line}: warning: {reason} in global initializer (var={var_ty}, value={init_ty})"
            ));
        }
        Ok(())
    }
}

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::CODE_BASE;
use super::codegen::Target;
use super::error::C4Error;
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
    /// frame; patched into `Op::Ent` at the end of the function.
    loc_offs: i64,

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

    /// Preprocessor failure (e.g. unterminated `#if`) deferred from
    /// `with_target` until `compile` runs, so the construction API
    /// stays infallible (matches all the `Compiler::new(src).compile()`
    /// callers in tests / examples). `None` if preprocessing
    /// succeeded.
    deferred_error: Option<C4Error>,

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
        let mut symbols = Vec::new();
        lexer::init_symbols(&mut symbols);

        // Run the preprocessor over the user's source verbatim. The
        // bindings come from whichever standard headers the source
        // `#include`s (or doesn't); a fixture that needs `printf`
        // but skips `<stdio.h>` will fail with a clear "no
        // `#pragma binding(... ::printf, ...)` is in scope" error
        // out of the codegen's import resolver, not a mysterious
        // link-time mismatch.
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

        Self {
            lex: Lexer::new(preprocessed),
            symbols,
            deferred_error,
            dylibs,
            text: Vec::new(),
            data: Vec::new(),
            ty: 0,
            loc_offs: 0,
            loop_breaks: Vec::new(),
            loop_continues: Vec::new(),
            labels: Vec::new(),
            unresolved_gotos: Vec::new(),
            switch_cases: Vec::new(),
            switch_defaults: Vec::new(),
            structs: Vec::new(),
            warnings: Vec::new(),
            data_imm_positions: Vec::new(),
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
    ///     fit in a register, common in c4 idioms
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
        let decl_is_ptr = decl_is_struct || declared >= Ty::Ptr as i64;
        let act_is_ptr = act_is_struct || actual >= Ty::Ptr as i64;

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
    fn parse_declarator(&mut self, base: i64) -> Result<(usize, i64), C4Error> {
        let mut ty = base;
        while self.lex.tk == Token::MulOp as i64 {
            self.next()?;
            ty += Ty::Ptr as i64;
        }
        if self.lex.tk != Token::Id as i64 {
            return Err(C4Error::Compile(format!(
                "{}: identifier expected in declaration",
                self.lex.line
            )));
        }
        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
            return Err(C4Error::Compile(format!(
                "{}: struct-value declarations are not supported (use a pointer)",
                self.lex.line
            )));
        }
        let idx = self.lex.curr_id_idx;
        self.next()?;
        Ok((idx, ty))
    }

    fn parse_decl_base_type(&mut self) -> Result<i64, C4Error> {
        if self.lex.tk == Token::Int as i64 {
            self.next()?;
            Ok(Ty::Int as i64)
        } else if self.lex.tk == Token::Char as i64 {
            self.next()?;
            Ok(Ty::Char as i64)
        } else if self.lex.tk == Token::Struct as i64 {
            self.next()?;
            if self.lex.tk != Token::Id as i64 {
                return Err(C4Error::Compile(format!(
                    "{}: struct name expected",
                    self.lex.line
                )));
            }
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;
            let id = self.find_struct_id(&name).ok_or_else(|| {
                C4Error::Compile(format!("{}: unknown struct {}", self.lex.line, name))
            })?;
            Ok(struct_ty_for(id))
        } else {
            Err(C4Error::Compile(format!(
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
    fn parse_struct_body(&mut self, name: &str) -> Result<usize, C4Error> {
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
            // Field type prefix: int, char, or struct Name.
            let field_base = if self.lex.tk == Token::Int as i64 {
                self.next()?;
                Ty::Int as i64
            } else if self.lex.tk == Token::Char as i64 {
                self.next()?;
                Ty::Char as i64
            } else if self.lex.tk == Token::Struct as i64 {
                self.next()?;
                if self.lex.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: struct name expected in field type",
                        self.lex.line
                    )));
                }
                let inner_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                let inner_id = self.find_struct_id(&inner_name).ok_or_else(|| {
                    C4Error::Compile(format!("{}: unknown struct {}", self.lex.line, inner_name))
                })?;
                struct_ty_for(inner_id)
            } else {
                return Err(C4Error::Compile(format!(
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
                    return Err(C4Error::Compile(format!(
                        "{}: field name expected",
                        self.lex.line
                    )));
                }
                if is_struct_ty(field_ty) && struct_ptr_depth(field_ty) == 0 {
                    return Err(C4Error::Compile(format!(
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
                return Err(C4Error::Compile(format!(
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
    pub fn compile(mut self) -> Result<Program, C4Error> {
        if let Some(e) = self.deferred_error.take() {
            return Err(e);
        }
        self.run_compile()?;
        let main_idx = lexer::find_symbol(&self.symbols, "main")
            .ok_or_else(|| C4Error::Compile("main() not defined".to_string()))?;
        if self.symbols[main_idx].class != Token::Fun as i64 {
            return Err(C4Error::Compile("main() not defined".to_string()));
        }
        let entry_pc = self.symbols[main_idx].val as usize;
        Ok(Program {
            text: self.text,
            data: self.data,
            entry_pc,
            warnings: self.warnings,
            data_imm_positions: self.data_imm_positions,
            dylibs: self.dylibs,
        })
    }

    // ---- Lexer plumbing ----

    fn next(&mut self) -> Result<(), C4Error> {
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

    fn expr(&mut self, lev: i64) -> Result<(), C4Error> {
        let mut t: i64;

        if self.lex.tk == 0 {
            return Err(C4Error::Compile(format!(
                "{}: unexpected eof in expression",
                self.lex.line
            )));
        } else if self.lex.tk == Token::Num as i64 {
            self.emit_op(Op::Imm);
            self.emit_val(self.lex.ival);
            self.next()?;
            self.ty = Ty::Int as i64;
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
                return Err(C4Error::Compile(format!(
                    "{}: open paren expected in sizeof",
                    self.lex.line
                )));
            }
            if self.lex.tk == Token::Int as i64
                || self.lex.tk == Token::Char as i64
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
                return Err(C4Error::Compile(format!(
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
                let mut nargs = 0;
                while self.lex.tk != ')' as i64 {
                    let arg_line = self.lex.line;
                    self.expr(Token::Assign as i64)?;
                    // Type-check this arg against the declared param,
                    // unless it's a vararg position (i.e. nargs is past
                    // the fixed param count of a variadic function) or
                    // the function has no recorded signature (legacy or
                    // non-Sys/Fun symbol).
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
                        // Has a signature, isn't variadic, but we got
                        // more args than declared. Worth a warning.
                        self.warn(format!(
                            "{arg_line}: warning: too many arguments to `{}` (expected {}, got at least {})",
                            fn_name_for_warn,
                            expected_params.len(),
                            nargs + 1,
                        ));
                    }
                    self.emit_op(Op::Psh);
                    nargs += 1;
                    if self.lex.tk == ',' as i64 {
                        self.next()?;
                    }
                }
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
                    self.emit_op(Op::from_i64(self.symbols[id_idx].val).unwrap());
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
                    return Err(C4Error::Compile(format!(
                        "{}: bad function call",
                        self.lex.line
                    )));
                }
                if nargs > 0 {
                    self.emit_op(Op::Adj);
                    self.emit_val(nargs);
                }
                self.ty = self.symbols[id_idx].type_;
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
                } else if self.symbols[id_idx].class == Token::Glo as i64 {
                    self.emit_data_imm(self.symbols[id_idx].val);
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: undefined variable {}",
                        self.lex.line, self.symbols[id_idx].name
                    )));
                }
                self.ty = self.symbols[id_idx].type_;
                self.emit_op(load_op_for(self.ty));
            }
        } else if self.lex.tk == '(' as i64 {
            self.next()?;
            if self.lex.tk == Token::Int as i64
                || self.lex.tk == Token::Char as i64
                || self.lex.tk == Token::Struct as i64
            {
                // C-style cast: `(<type>)expr`. Accepts int, char, or
                // struct base, with any number of `*` markers.
                t = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp as i64 {
                    self.next()?;
                    t += Ty::Ptr as i64;
                }
                if self.lex.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!("{}: bad cast", self.lex.line)));
                }
                self.expr(Token::Inc as i64)?;
                self.ty = t;
            } else {
                self.expr(Token::Assign as i64)?;
                if self.lex.tk == ')' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
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
                return Err(C4Error::Compile(format!(
                    "{}: bad dereference",
                    self.lex.line
                )));
            }
            self.emit_op(load_op_for(self.ty));
        } else if self.lex.tk == Token::AndOp as i64 {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            let last = self.text.pop().unwrap();
            if last != Op::Lc as i64 && last != Op::Li as i64 {
                return Err(C4Error::Compile(format!(
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
            self.emit_op(Op::Imm);
            if self.lex.tk == Token::Num as i64 {
                self.emit_val(-self.lex.ival);
                self.next()?;
            } else {
                self.emit_val(-1);
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Mul);
            }
            self.ty = Ty::Int as i64;
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
                return Err(C4Error::Compile(format!(
                    "{}: bad lvalue in pre-increment",
                    self.lex.line
                )));
            }
            self.emit_op(Op::Psh);
            self.emit_op(Op::Imm);
            self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
            self.emit_op(if t == Token::Inc as i64 {
                Op::Add
            } else {
                Op::Sub
            });
            self.emit_op(store_op_for(self.ty));
        } else {
            return Err(C4Error::Compile(format!(
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
                    *self.text.last_mut().unwrap() = Op::Psh as i64;
                } else {
                    return Err(C4Error::Compile(format!(
                        "{}: bad lvalue in assignment",
                        self.lex.line
                    )));
                }
                let line = self.lex.line;
                self.expr(Token::Assign as i64)?;
                // RHS just compiled; self.ty is the RHS type, t is the
                // declared LHS type. Compare before we overwrite ty.
                let rhs_is_zero = self.last_emit_is_zero();
                if let Some(reason) = Self::type_warning(t, self.ty, rhs_is_zero) {
                    self.warn(format!(
                        "{line}: warning: {reason} in assignment (lhs={t}, rhs={})",
                        self.ty
                    ));
                }
                self.ty = t;
                self.emit_op(store_op_for(self.ty));
            } else if self.lex.tk == Token::Cond as i64 {
                self.next()?;
                self.emit_op(Op::Bz);
                let b_else = self.text.len();
                self.emit_val(0);
                self.expr(Token::Assign as i64)?;
                if self.lex.tk == ':' as i64 {
                    self.next()?;
                } else {
                    return Err(C4Error::Compile(format!(
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
                self.emit_op(Op::Eq);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::NeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                self.emit_op(Op::Ne);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::LtOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Lt);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::GtOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Gt);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::LeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Le);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::GeOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                self.emit_op(Op::Ge);
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
                if t > Ty::Ptr as i64 {
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(8);
                    self.emit_op(Op::Mul);
                }
                self.emit_op(Op::Add);
                self.ty = t;
            } else if self.lex.tk == Token::SubOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::MulOp as i64)?;
                if t > Ty::Ptr as i64 && t == self.ty {
                    self.emit_op(Op::Sub);
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(8);
                    self.emit_op(Op::Div);
                    self.ty = Ty::Int as i64;
                } else if t > Ty::Ptr as i64 {
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
                self.emit_op(Op::Mul);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::DivOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                self.emit_op(Op::Div);
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::ModOp as i64 {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
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
                    return Err(C4Error::Compile(format!(
                        "{}: bad lvalue in post-increment",
                        self.lex.line
                    )));
                }
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
                self.emit_op(if self.lex.tk == Token::Inc as i64 {
                    Op::Add
                } else {
                    Op::Sub
                });
                self.emit_op(store_op_for(self.ty));
                self.emit_op(Op::Psh);
                self.emit_op(Op::Imm);
                self.emit_val(if self.ty > Ty::Ptr as i64 { 8 } else { 1 });
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
                    return Err(C4Error::Compile(format!(
                        "{}: close bracket expected",
                        self.lex.line
                    )));
                }
                if t > Ty::Ptr as i64 {
                    self.emit_op(Op::Psh);
                    self.emit_op(Op::Imm);
                    self.emit_val(8);
                    self.emit_op(Op::Mul);
                } else if t < Ty::Ptr as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: pointer type expected",
                        self.lex.line
                    )));
                }
                self.emit_op(Op::Add);
                self.ty = t - Ty::Ptr as i64;
                self.emit_op(load_op_for(self.ty));
            } else if self.lex.tk == Token::Arrow as i64 {
                // p->field. Preceding subexpression already evaluated as
                // an rvalue, so the loaded pointer is in `a`. Look the
                // field up in the struct's table, add the byte offset,
                // then load the field with the right size.
                if !is_struct_ty(t) || struct_ptr_depth(t) != 1 {
                    return Err(C4Error::Compile(format!(
                        "{}: -> requires a single-level struct pointer",
                        self.lex.line
                    )));
                }
                self.next()?;
                if self.lex.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: field name expected after ->",
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
                        C4Error::Compile(format!(
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
                // `p->x = value` works the same way as `*ptr = value`.
                self.emit_op(load_op_for(self.ty));
            } else {
                return Err(C4Error::Compile(format!(
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
    fn parse_for_stmt(&mut self) -> Result<(), C4Error> {
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
    fn parse_switch_stmt(&mut self) -> Result<(), C4Error> {
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
    fn parse_block_stmt(&mut self) -> Result<(), C4Error> {
        self.next()?;
        let mut block_symbols = Vec::new();

        // Block-scoped local variables (declared at the top of the block).
        while self.lex.tk == Token::Int as i64
            || self.lex.tk == Token::Char as i64
            || self.lex.tk == Token::Struct as i64
        {
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
                self.loc_offs += 1;
                self.symbols[loc_idx].val = -self.loc_offs;

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

    fn stmt(&mut self) -> Result<(), C4Error> {
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
                return Err(C4Error::Compile(format!(
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
                return Err(C4Error::Compile(format!(
                    "{}: invalid case value",
                    self.lex.line
                )));
            }
            let val = self.lex.ival;
            self.next()?;
            self.consume(b':', "expected colon after case")?;
            let Some(cases) = self.switch_cases.last_mut() else {
                return Err(C4Error::Compile(format!(
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
                return Err(C4Error::Compile(format!(
                    "{}: default outside switch",
                    self.lex.line
                )));
            };
            *def = Some(self.text.len());
            self.stmt()?;
        } else if self.lex.tk == Token::Goto as i64 {
            self.next()?;
            if self.lex.tk != Token::Id as i64 {
                return Err(C4Error::Compile(format!(
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
                return Err(C4Error::Compile(format!(
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
                return Err(C4Error::Compile(format!(
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
            if self.lex.tk != ';' as i64 {
                self.expr(Token::Assign as i64)?;
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
    fn consume(&mut self, expected: u8, msg: &str) -> Result<(), C4Error> {
        if self.lex.tk == expected as i64 {
            self.next()?;
            Ok(())
        } else {
            Err(C4Error::Compile(format!("{}: {}", self.lex.line, msg)))
        }
    }

    fn parse_enum_decl(&mut self) -> Result<(), C4Error> {
        self.next()?;
        if self.lex.tk != '{' as i64 {
            self.next()?;
        }
        if self.lex.tk == '{' as i64 {
            self.next()?;
            let mut i = 0;
            while self.lex.tk != '}' as i64 {
                if self.lex.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: bad enum identifier",
                        self.lex.line
                    )));
                }
                let idx = self.lex.curr_id_idx;
                self.next()?;
                if self.lex.tk == Token::Assign as i64 {
                    self.next()?;
                    if self.lex.tk != Token::Num as i64 {
                        return Err(C4Error::Compile(format!(
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
    fn parse_function_params(&mut self) -> Result<ParsedParams, C4Error> {
        let mut args = Vec::new();
        let mut types = Vec::new();
        let mut is_variadic = false;
        while self.lex.tk != ')' as i64 {
            // `...` ends the typed-parameter list and marks the function
            // variadic. Anything after is a syntax error.
            if self.lex.tk == Token::Ellipsis as i64 {
                self.next()?;
                if self.lex.tk != ')' as i64 {
                    return Err(C4Error::Compile(format!(
                        "{}: `...` must be the last parameter",
                        self.lex.line
                    )));
                }
                is_variadic = true;
                break;
            }
            let base = if self.lex.tk == Token::Int as i64
                || self.lex.tk == Token::Char as i64
                || self.lex.tk == Token::Struct as i64
            {
                self.parse_decl_base_type()?
            } else {
                Ty::Int as i64
            };
            let (param_idx, ty) = self.parse_declarator(base)?;
            self.ty = ty;
            if self.symbols[param_idx].class == Token::Loc as i64 {
                return Err(C4Error::Compile(format!(
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

    fn run_compile(&mut self) -> Result<(), C4Error> {
        self.next()?;
        while self.lex.tk != 0 {
            let mut bt = Ty::Int as i64;
            if self.lex.tk == Token::Int as i64 {
                self.next()?;
                bt = Ty::Int as i64;
            } else if self.lex.tk == Token::Char as i64 {
                self.next()?;
                bt = Ty::Char as i64;
            } else if self.lex.tk == Token::Enum as i64 {
                self.parse_enum_decl()?;
            } else if self.lex.tk == Token::Struct as i64 {
                // Two shapes:
                //   struct Foo { ... };       -- definition only
                //   struct Foo *p;            -- type use, declarators follow
                self.next()?; // consume `struct`
                if self.lex.tk != Token::Id as i64 {
                    return Err(C4Error::Compile(format!(
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
                        C4Error::Compile(format!("{}: unknown struct {}", self.lex.line, name))
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
                    return Err(C4Error::Compile(format!(
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
                        return Err(C4Error::Compile(format!(
                            "{}: cannot give a body to predefined library function `{}` \
                             (the per-target header's `#pragma binding` provides the \
                             implementation -- use a prototype only)",
                            self.lex.line, self.symbols[id_idx].name
                        )));
                    }
                    if self.lex.tk != '{' as i64 {
                        return Err(C4Error::Compile(format!(
                            "{}: bad function definition",
                            self.lex.line
                        )));
                    }
                    self.next()?;

                    let nargs = params.indices.len() as i64;
                    for (i, &idx) in params.indices.iter().enumerate() {
                        self.symbols[idx].val = nargs - (i as i64) + 1;
                    }

                    self.loc_offs = 0;
                    self.labels.clear();
                    self.unresolved_gotos.clear();

                    while self.lex.tk == Token::Int as i64
                        || self.lex.tk == Token::Char as i64
                        || self.lex.tk == Token::Struct as i64
                    {
                        let lbt = self.parse_decl_base_type()?;
                        while self.lex.tk != ';' as i64 {
                            let (loc_idx, ty) = self.parse_declarator(lbt)?;
                            self.ty = ty;
                            if self.symbols[loc_idx].class == Token::Loc as i64 {
                                return Err(C4Error::Compile(format!(
                                    "{}: duplicate local definition",
                                    self.lex.line
                                )));
                            }

                            self.symbols[loc_idx].h_class = self.symbols[loc_idx].class;
                            self.symbols[loc_idx].class = Token::Loc as i64;
                            self.symbols[loc_idx].h_type = self.symbols[loc_idx].type_;
                            self.symbols[loc_idx].type_ = ty;
                            self.symbols[loc_idx].h_val = self.symbols[loc_idx].val;

                            self.loc_offs += 1;
                            self.symbols[loc_idx].val = -self.loc_offs;

                            if self.lex.tk == ',' as i64 {
                                self.next()?;
                            }
                        }
                        self.next()?;
                    }

                    let ent_pc = self.text.len();
                    self.emit_op(Op::Ent);
                    self.emit_val(0); // patched below

                    while self.lex.tk != '}' as i64 {
                        self.stmt()?;
                    }
                    self.emit_op(Op::Lev);

                    self.text[ent_pc + 1] = self.loc_offs;

                    for (name, pc) in &self.unresolved_gotos {
                        match self.labels.iter().find(|(n, _)| n == name) {
                            Some(&(_, target)) => self.text[*pc] = target as i64,
                            None => {
                                return Err(C4Error::Compile(format!(
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
                    self.symbols[id_idx].val = self.data.len() as i64;
                    for _ in 0..8 {
                        self.data.push(0);
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
}

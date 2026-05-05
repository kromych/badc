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
use super::types::{is_struct_ty, struct_id_of, struct_ptr_depth};
use super::{Compiler, InitElemReloc};

impl Compiler {
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
        if self.lex.tk == '"' as i64 && elem_ty == Ty::Char as i64 {
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
            return Err(C5Error::Compile(format!(
                "{}: array initializer must be a string literal or `{{ ... }}`",
                self.lex.line
            )));
        }
        self.next()?;
        let mut elements = Vec::new();
        while self.lex.tk != '}' as i64 {
            // Nested brace list (multi-dim array): `{ {1,2}, {3,4}, ... }`.
            // c5's array-symbol storage carries a single flat
            // dimension, so we flatten the rows by recursing and
            // concatenating element vectors. Indexing into the
            // multi-dim shape isn't precise (only the outermost
            // dimension scales), but the bytes laid out in `data`
            // match the equivalent `T xs[N*M]` layout, which is
            // what code that walks the array linearly expects.
            if self.lex.tk == '{' as i64 {
                let mut inner = self.collect_array_initializer(elem_ty)?;
                elements.append(&mut inner);
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
            for (idx, &(v, reloc)) in elements.iter().enumerate() {
                let here = start_addr + idx * elem_size;
                for i in 0..elem_size {
                    self.data.push(((v >> (i * 8)) & 0xFF) as u8);
                }
                match reloc {
                    InitElemReloc::None => {}
                    InitElemReloc::Data => {
                        self.data_relocs.push(crate::c5::program::DataReloc {
                            data_offset: here as u64,
                            target_offset: v as u64,
                        });
                    }
                    InitElemReloc::Code(sym_idx) => {
                        self.code_relocs.push(crate::c5::program::CodeReloc {
                            data_offset: here as u64,
                            target_bc_pc: v as u64,
                        });
                        self.code_reloc_sym_idx.push(sym_idx);
                    }
                }
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
        if self.lex.tk == Token::FloatNum as i64 {
            let v = self.lex.ival;
            self.next()?;
            return Ok((v, InitElemReloc::None));
        }
        // `(type)expr` cast or `(expr)` parenthesized constant in a
        // static initializer. After consuming `(`, peek the next
        // token: if it starts a type, treat as a cast and recurse on
        // the value (c5's i64-shaped representation makes integer /
        // pointer casts no-ops). Otherwise it's a parenthesized
        // constant expression -- evaluate it and expect `)`.
        if self.lex.tk == '(' as i64 {
            self.next()?;
            if self.lex_is_type_start() {
                let _ = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp as i64
                    || self.lex.tk == Token::TypeQual as i64
                {
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
                    return Err(C5Error::Compile(format!(
                        "{}: close paren expected after cast in initializer",
                        self.lex.line
                    )));
                }
                self.next()?;
                return self.parse_constant_init_value();
            }
            let v = self.parse_const_expr_or()?;
            if self.lex.tk != ')' as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: close paren expected in initializer",
                    self.lex.line
                )));
            }
            self.next()?;
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
                return Err(C5Error::Compile(format!(
                    "{}: identifier expected after `&` in initializer",
                    self.lex.line
                )));
            }
            let target_idx = self.lex.curr_id_idx;
            let class = self.symbols[target_idx].class;
            if class != Token::Glo as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: `&{}` -- only addresses of globals are accepted in static initializers",
                    self.lex.line, self.symbols[target_idx].name
                )));
            }
            let off = self.symbols[target_idx].val;
            self.next()?;
            return Ok((off, InitElemReloc::Data));
        }
        if self.lex.tk == Token::Id as i64 {
            let idx = self.lex.curr_id_idx;
            let class = self.symbols[idx].class;
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
                // The real address lives in the loader's GOT and isn't
                // known at compile time; the proper fix is a per-Sys
                // trampoline whose code-pc gets a CodeReloc into the
                // data slot. Until that lands, emit zero with a
                // warning so sqlite's VFS dispatch table compiles --
                // the runtime fills in the slots before use through
                // the platform-specific init path.
                let line = self.lex.line;
                let name = self.symbols[idx].name.clone();
                self.warn(format!(
                    "{line}: warning: address of libc symbol `{name}` in a static \
                     initializer lowered as 0 (no GOT-trampoline support yet); \
                     the runtime must overwrite the slot before first use"
                ));
                self.next()?;
                return Ok((0, InitElemReloc::None));
            }
            if class == Token::Glo as i64 {
                // Bare global identifier in a static initializer.
                // For array globals (`static const char name[] =
                // "..."`) this is the array-decay rule: the value
                // is the array's data-segment offset; a DataReloc
                // patches it to the runtime address.
                let off = self.symbols[idx].val;
                self.next()?;
                return Ok((off, InitElemReloc::Data));
            }
            return Err(C5Error::Compile(format!(
                "{}: identifier `{}` is not a constant-expression value",
                self.lex.line, self.symbols[idx].name
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
            return Err(C5Error::Compile(format!(
                "{}: struct initializer must start with `{{`",
                self.lex.line
            )));
        }
        self.next()?;
        let mut pos: usize = 0;
        while self.lex.tk != '}' as i64 {
            // Designator?
            let field_idx = if self.lex.tk == Token::Dot as i64 {
                self.next()?;
                if self.lex.tk != Token::Id as i64 {
                    return Err(C5Error::Compile(format!(
                        "{}: field name expected after `.`",
                        self.lex.line
                    )));
                }
                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                if self.lex.tk != Token::Assign as i64 {
                    return Err(C5Error::Compile(format!(
                        "{}: `=` expected after `.{field_name}` designator",
                        self.lex.line
                    )));
                }
                self.next()?;
                let pos_in_struct = self.structs[struct_id]
                    .fields
                    .iter()
                    .position(|f| f.name == field_name)
                    .ok_or_else(|| {
                        C5Error::Compile(format!(
                            "{}: struct {} has no field {}",
                            self.lex.line, self.structs[struct_id].name, field_name
                        ))
                    })?;
                pos_in_struct
            } else {
                pos
            };
            if field_idx >= self.structs[struct_id].fields.len() {
                return Err(C5Error::Compile(format!(
                    "{}: too many initializers for struct {}",
                    self.lex.line, self.structs[struct_id].name
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
            if field.array_size > 0 && self.lex.tk == '{' as i64 {
                self.next()?;
                let elem_size = self.size_of_type(field.ty);
                let mut idx: usize = 0;
                while self.lex.tk != '}' as i64 {
                    if idx as i64 >= field.array_size {
                        return Err(C5Error::Compile(format!(
                            "{}: too many initializers for `{}.{}`",
                            self.lex.line, self.structs[struct_id].name, field.name
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
        if field_size == 1 {
            self.data[here] = value as u8;
        } else {
            for i in 0..field_size {
                self.data[here + i] = ((value >> (i * 8)) & 0xFF) as u8;
            }
        }
        match reloc {
            InitElemReloc::None => {}
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
            if elem_size == 1 {
                self.data[byte_off] = v as u8;
                byte_off += 1;
            } else {
                for i in 0..elem_size {
                    self.data[byte_off + i] = ((v >> (i * 8)) & 0xFF) as u8;
                }
                match reloc {
                    InitElemReloc::None => {}
                    InitElemReloc::Data => {
                        self.data_relocs.push(crate::c5::program::DataReloc {
                            data_offset: byte_off as u64,
                            target_offset: v as u64,
                        });
                    }
                    InitElemReloc::Code(sym_idx) => {
                        self.code_relocs.push(crate::c5::program::CodeReloc {
                            data_offset: byte_off as u64,
                            target_bc_pc: v as u64,
                        });
                        self.code_reloc_sym_idx.push(sym_idx);
                    }
                }
                byte_off += elem_size;
            }
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
        self.emit_op(Op::Lea);
        self.emit_val(local_val);
        self.emit_op(Op::Psh);
        self.emit_data_imm(src_data_addr as i64);
        self.emit_op(Op::Mcpy);
        self.emit_val(total_bytes as i64);
    }

    /// Emit the store sequence for a local-variable initializer:
    ///   Lea local_val ; Psh ; <init expr> ; Si | Sc | Mcpy
    /// On entry `tk` is positioned just past the `=`; on exit it
    /// is at the comma or semicolon following the initializer.
    pub(super) fn emit_local_init_store(
        &mut self,
        local_val: i64,
        ty: i64,
    ) -> Result<(), C5Error> {
        self.emit_op(Op::Lea);
        self.emit_val(local_val);
        self.emit_op(Op::Psh);
        self.expr(Token::Assign as i64)?;
        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
            self.emit_op(Op::Mcpy);
            self.emit_val(self.size_of_type(ty) as i64);
        } else if ty == Ty::Char as i64 {
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
}

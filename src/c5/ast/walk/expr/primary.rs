//! Primary expressions: an identifier's address and its value
//! (C99 6.5.1).

use super::super::access::{load_kind_for, load_place};
use super::super::types::lvalue_shape_label;
use super::super::*;

impl<'a> Walker<'a> {
    /// Address-of for an identifier. Locals lower to a
    /// `local_addr` against the symbol's slot offset; globals to
    /// an `imm_data` against the symbol's data offset; functions
    /// to an `imm_code` against the function's ent_pc.
    /// Token::Sys and TLS variants surface as unsupported until
    /// their walker arms land.
    pub(super) fn ident_address(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
    ) -> Result<ValueId, WalkError> {
        let Expr::Ident {
            sym,
            class,
            val,
            is_thread_local,
            ..
        } = self.ast.expr(id)
        else {
            return Err(WalkError::InvalidExpr {
                id,
                kind: lvalue_shape_label(self.ast.expr(id)),
            });
        };
        if *class == Token::Loc as i64 {
            Ok(b.local_addr(*val))
        } else if *class == Token::Glo as i64 {
            if *is_thread_local {
                match self.live_tls_addr(*sym, *val) {
                    GloAddr::Extern => Ok(b.tls_addr_extern(*sym)),
                    GloAddr::Resolved(off) => Ok(b.tls_addr(off)),
                }
            } else {
                let addr = if self.ast.block_extern_refs.contains(&id) {
                    self.block_extern_glo_addr(*sym)
                } else {
                    self.live_glo_addr(*sym, *val)
                };
                match addr {
                    GloAddr::Extern => Ok(b.imm_data_extern(*sym)),
                    GloAddr::Resolved(off) => Ok(b.imm_data(off)),
                }
            }
        } else if *class == Token::Fun as i64 {
            // Sys-trampoline symbols are added late and have
            // their `val` filled in by `emit_sys_trampolines`
            // -- AFTER `ast_emit_ident` snapshotted 0. Read
            // the live value off the symbol table; a scoped
            // function declaration's entity also keeps its
            // post-parse `val` there. The walker sym is the
            // same index the parser stored, so the lookup hits
            // the same entry the trampoline emit updated.
            let live_val = self.live_fun_addr_val(*sym, *val);
            if live_val == 0 {
                Ok(b.imm_code_extern(*sym))
            } else {
                Ok(b.imm_code(live_val as usize))
            }
        } else if *class == Token::Sys as i64 {
            // Address of a dynamically-imported function (`&strcmp`,
            // `fp = strcmp`). The Ident's `val` is the binding's flat
            // index across all `#pragma binding(...)` directives, the
            // same value `Inst::CallExt` carries. The address resolves
            // to the import's shared PLT stub.
            Ok(b.imm_ext_code(*val))
        } else {
            Err(WalkError::UnknownSymbolClass {
                sym: *sym,
                class: *class,
            })
        }
    }

    /// Identifier rvalue: take the address, load through the
    /// type-appropriate `LoadKind`. Reads `class` / `val` /
    /// `is_thread_local` straight off the snapshotted Ident node
    /// so a post-parse scope-exit that restored the symbol's
    /// pre-declaration tag doesn't invalidate the walker.
    #[allow(clippy::too_many_arguments)]
    pub(super) fn load_ident_rvalue(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
        _sym: u32,
        ty: i64,
        class: i64,
        val: i64,
        is_thread_local: bool,
        array_size: i64,
    ) -> Result<ValueId, WalkError> {
        // The parser snapshotted `val` as the function's
        // entry-PC at emit time; for `Token::Fun` references the
        // live PC lives on `self.symbols[sym].val` (sys
        // trampolines patch theirs late). Other classes
        // (`Token::Loc` / `Token::Glo` / `Token::Num`) carry a
        // stable per-frame slot / data offset / constant, so the
        // snapshot stays correct. Glo non-TLS routes through
        // `live_glo_addr` which discriminates a cross-TU extern
        // from an
        // intra-unit data offset without a 0 sentinel.
        let glo_addr = if class == Token::Glo as i64 && !is_thread_local {
            Some(if self.ast.block_extern_refs.contains(&id) {
                self.block_extern_glo_addr(_sym)
            } else {
                self.live_glo_addr(_sym, val)
            })
        } else {
            None
        };
        let val: i64 = if class == Token::Fun as i64 {
            // The only `Token::Fun` rvalue is the function-pointer decay
            // of C99 6.3.2.1p4, so this is an address site.
            self.live_fun_addr_val(_sym, val)
        } else {
            val
        };
        // C99 6.3.2.1p3 + c5's address-as-value rule: an lvalue
        // of array type, or a struct value (non-pointer struct
        // type), is consumed as its address rather than its
        // contents -- no trailing load. `array_size != 0` flags
        // arrays; the type tag indicates a struct value when
        // `is_struct_value_ty(ty)`. Both
        // shapes route through the lvalue helper so the walker
        // emits just the address producer. The fields are
        // snapshotted at parse time on `Expr::Ident` so this
        // path keeps working after the function-end shadow
        // restoration unbinds the symbol's outer-scope value.
        let address_only = array_size != 0 || (is_struct_value_ty(ty));
        if address_only {
            if class == Token::Loc as i64 {
                return Ok(b.local_addr(val));
            } else if let Some(addr) = glo_addr {
                return Ok(match addr {
                    GloAddr::Extern => b.imm_data_extern(_sym),
                    GloAddr::Resolved(off) => b.imm_data(off),
                });
            } else if class == Token::Glo as i64 && is_thread_local {
                return Ok(match self.live_tls_addr(_sym, val) {
                    GloAddr::Extern => b.tls_addr_extern(_sym),
                    GloAddr::Resolved(off) => b.tls_addr(off),
                });
            }
        }
        let seg = self.access_seg(id, ty)?;
        let vol = is_volatile_object_ty(ty);
        if class == Token::Loc as i64 {
            // A frame slot has no named address space; the parser
            // rejects such declarations.
            if seg != AsmSeg::None {
                return Err(WalkError::InvalidExpr {
                    id,
                    kind: "named address space on automatic storage",
                });
            }
            let kind = load_kind_for(ty, self.target);
            Ok(b.load_local_vol(val, kind, vol))
        } else if let Some(addr) = glo_addr {
            let addr_v = match addr {
                GloAddr::Extern => b.imm_data_extern(_sym),
                GloAddr::Resolved(off) => b.imm_data(off),
            };
            let kind = load_kind_for(ty, self.target);
            Ok(load_place(b, addr_v, kind, seg, vol, 0))
        } else if class == Token::Glo as i64 && is_thread_local {
            // Thread-local addressing already names its own segment on
            // x86; a further named address space cannot combine with it.
            if seg != AsmSeg::None {
                return Err(WalkError::UnsupportedExpr {
                    id,
                    kind: "named address space on thread-local storage",
                });
            }
            let addr = match self.live_tls_addr(_sym, val) {
                GloAddr::Extern => b.tls_addr_extern(_sym),
                GloAddr::Resolved(off) => b.tls_addr(off),
            };
            let kind = load_kind_for(ty, self.target);
            Ok(b.load_vol(addr, kind, vol))
        } else if class == Token::Fun as i64 {
            if val == 0 {
                Ok(b.imm_code_extern(_sym))
            } else {
                Ok(b.imm_code(val as usize))
            }
        } else if class == Token::Sys as i64 {
            // Bare imported-function rvalue (`fp = strcmp`). `val` is
            // the binding index; the address resolves to the import's
            // shared PLT stub. See `address_of_ident`.
            Ok(b.imm_ext_code(val))
        } else if class == Token::Num as i64 {
            // Enum constants and `#define`-via-const-decl idioms
            // both surface as `Token::Num`-class symbols; `val`
            // holds the resolved integer constant.
            Ok(b.imm(val))
        } else {
            Err(WalkError::UnknownSymbolClass { sym: _sym, class })
        }
    }
}

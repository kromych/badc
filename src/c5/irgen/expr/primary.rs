//! Primary expressions: an identifier's address and its value
//! (C99 6.5.1).

use super::super::access::{load_kind_for, load_place};
use super::super::types::lvalue_shape_label;
use super::super::*;

impl<'a> Walker<'a> {
    /// Address-of for an identifier: a local against its slot offset,
    /// a global against its data offset, a function against its entry
    /// PC.
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
        } else if *class == Token::Fun as i64 || self.binding_defined_here(*sym, *class) {
            // A sys trampoline's `val` is filled in after the Ident
            // node snapshotted 0, so the live value comes off the
            // symbol table. A scoped function declaration's entity
            // likewise keeps its post-parse `val` there.
            let live_val = self.live_fun_addr_val(*sym, *val);
            if live_val == 0 {
                Ok(b.imm_code_extern(*sym))
            } else {
                Ok(b.imm_code(live_val as usize))
            }
        } else if *class == Token::Sys as i64 {
            // For a dynamically-imported function the Ident's `val` is
            // the binding index `Inst::CallExt` carries, and the
            // address resolves to the import's shared PLT stub.
            Ok(b.imm_ext_code(*val))
        } else {
            Err(WalkError::UnknownSymbolClass {
                sym: *sym,
                class: *class,
            })
        }
    }

    /// Identifier rvalue: the address, loaded through the type's
    /// `LoadKind`. The class, value and thread-local flag come off the
    /// Ident node itself, so a post-parse scope exit that restored the
    /// symbol's pre-declaration tag does not invalidate them.
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
        // A `Token::Fun` reference reads its entry PC off the symbol
        // table, since a sys trampoline patches its own late. The other
        // classes carry a stable slot, data offset or constant, so the
        // node's snapshot holds.
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
            // The only `Token::Fun` rvalue is the function-pointer
            // decay of C99 6.3.2.1p4.
            self.live_fun_addr_val(_sym, val)
        } else {
            val
        };
        // C99 6.3.2.1p3 with the address-as-value rule: an array
        // lvalue or a struct value is consumed as its address, so both
        // take the lvalue path and emit no load.
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
            // Thread-local addressing names its own segment on x86, and
            // a further named address space cannot combine with it.
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
        } else if self.binding_defined_here(_sym, class) {
            let live_val = self.live_fun_addr_val(_sym, 0);
            if live_val == 0 {
                Ok(b.imm_code_extern(_sym))
            } else {
                Ok(b.imm_code(live_val as usize))
            }
        } else if class == Token::Sys as i64 {
            // A bare imported-function rvalue (`fp = strcmp`) resolves
            // to the import's shared PLT stub.
            Ok(b.imm_ext_code(val))
        } else if class == Token::Num as i64 {
            // Enum constants reach the walker as `Token::Num` symbols
            // whose `val` is the resolved integer constant.
            Ok(b.imm(val))
        } else {
            Err(WalkError::UnknownSymbolClass { sym: _sym, class })
        }
    }
}

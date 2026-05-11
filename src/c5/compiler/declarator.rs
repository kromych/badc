//! Declarator parser.
//!
//! `parse_declarator` consumes the declarator portion of a
//! declaration -- the part that comes *after* a base-type prefix
//! (`int` / `struct Foo` / a typedef-name). It handles:
//!
//!   * zero-or-more leading `*` markers (each adding one pointer
//!     level via `Ty::Ptr`) plus the qualifier-soup
//!     (`*const`, `*volatile`, `*restrict`) attached to each `*`
//!   * the function-pointer shape `RET (*Name)(args)` (and its
//!     nested / abstract variants) -- requires recursion into
//!     parse_declarator and a one-shot capture of the inner-fn's
//!     params on `pending_fn_params` for the function-returning-fp
//!     shape `void (*foo(args1))(args2)`
//!   * the abstract / unnamed declarator (`)` or `,` immediately
//!     after the type) -- returns `usize::MAX` for the symbol idx
//!   * the optional `[N]` array suffix (with the empty-bracket
//!     `[]` decay to pointer at parameter position) plus 2D
//!     `[N][M]` (flattened to `array_size = N*M` plus
//!     `inner_array_size = M` for first-index scaling)
//!
//! Used by every declaration site -- file-scope globals,
//! parameters, function-top locals, block-scoped locals -- so the
//! four near-identical loops it replaced share one definition of
//! "what counts as a valid name" and "we don't allow struct
//! values in this position."

use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;

impl Compiler {
    /// Parse a single declarator: zero-or-more `*` (pointer levels)
    /// + identifier + optional `[N]` array suffix. Returns the symbol
    /// index, the (possibly decayed) base type, and the array
    /// dimension. `array_size = 0` means the declarator is not an
    /// array; otherwise `type_` holds the element type and
    /// `array_size` is N.
    ///
    /// `int xs[]` -- empty-bracket form -- is treated as `int *xs`
    /// (added pointer level, `array_size = 0`) per C's parameter-
    /// position decay rule. Callers in object-decl position can
    /// still detect "the user wrote brackets" by remembering whether
    /// the decay happened, but for c5 today the equivalence is
    /// sufficient.
    pub(super) fn parse_declarator(&mut self, base: i64) -> Result<(usize, i64, i64), C5Error> {
        let mut ty = base;
        let mut leading_ptr_count: i64 = 0;
        while self.lex.tk == Token::MulOp as i64 {
            self.next()?;
            ty += Ty::Ptr as i64;
            leading_ptr_count += 1;
            // Pointer-level qualifiers: `int *const p`, `int *volatile p`,
            // `char *restrict s`. Consumed; no semantic effect.
            while self.lex.tk == Token::TypeQual as i64 {
                self.next()?;
            }
        }
        // lineage propagation: if the caller pre-seeded
        // `pending_fn_ptr_indirection` from a typedef-of-fn-ptr
        // base type, the leading `*`s here add directly to the
        // indirection count: `fn_t fp` -> 1, `fn_t *pp` -> 2,
        // `fn_t **ppp` -> 3. The fn-ptr-declarator branch below
        // overrides this with its own value when it fires (the
        // declarator carries explicit fn-pointer shape rather
        // than inheriting from the base type), so we update
        // pending only when leading `*`s actually accumulated.
        if leading_ptr_count > 0
            && let Some(fpi) = self.pending_fn_ptr_indirection
        {
            self.pending_fn_ptr_indirection = Some(fpi + leading_ptr_count);
        }

        // Function-pointer declarator: `RET (*Name)(args)`, possibly
        // nested as `RET (*(*Name)(args1))(args2)`, or abstract as
        // `RET (*)(args)` (an unnamed parameter type, e.g.
        // `int register_cb(void *ctx, int(*)(void*,int))`).
        // Detected by peeking past the open paren: `*` opens the
        // pointer-cum-declarator, `(` starts a nested parens group.
        if self.lex.tk == '(' as i64
            && (self.lex.peek_after_whitespace(b'*')
                || self.lex.peek_after_whitespace(b'(')
                || self.lex.peek_after_whitespace_starts_ident())
        {
            self.next()?; // consume the outer `(`
            let outer_ty_before_inner = ty;
            let (idx, mut inner_ty, inner_array_size) = self.parse_declarator(ty)?;
            // Function-pointer lineage trace: the inner
            // declarator's leading `*`s plus the fn-pointer's own
            // pointer level give the indirection count from the
            // variable's loaded value down to the fn-pointer
            // rvalue, plus 1. For `T (*name)(args)` the inner
            // declarator added one Ptr (the `*`), so depth = 1 -
            // matching Symbol::fn_ptr_indirection's "value IS fn
            // ptr" convention. For `T (**name)(args)` the inner
            // added two Ptrs, depth = 2 (one more deref needed).
            let ty_delta = inner_ty - outer_ty_before_inner;
            let inner_ptr_levels = ty_delta / (Ty::Ptr as i64);
            if inner_ptr_levels > 0 {
                // Only set the side-channel for the OUTERMOST
                // fn-ptr declarator: the inner recursive call may
                // itself have set it for a nested fn-ptr declarator
                // (function-returning-fp shape), and the outer
                // call's value is the right one to expose.
                self.pending_fn_ptr_indirection = Some(inner_ptr_levels);
            }
            // The inner declarator may have stopped on `(` if it
            // was a function-returning-fp shape like
            // `void (*foo(args1))(args2)`. In that case `foo` is
            // the outer function whose params we MUST capture
            // (the body will reference them); `args2` after the
            // outer paren close is the function-pointer pointee's
            // signature, which c5 doesn't track.
            //
            // When this branch fires we stash the parsed params
            // on `self.pending_fn_params` so `run_compile` can
            // bind `foo` as `Token::Fun` and parse the body even
            // though the next token will be `{` (not `(` -- the
            // params are already consumed).
            if self.lex.tk == '(' as i64 {
                self.next()?;
                // parse_function_params consumes the matching `)`,
                // so on return we're already past the inner args1.
                let params = self.parse_function_params()?;
                self.pending_fn_params = Some(params);
            }
            if self.lex.tk != ')' as i64 {
                return Err(self.compile_err("close paren expected in nested declarator"));
            }
            self.next()?;
            // Trailing decorations on the parenthesised group.
            // Multiple are legal: `(*pp)[N](args)` etc.
            loop {
                if self.lex.tk == '(' as i64 {
                    self.next()?;
                    self.skip_balanced_parens_after_open()?;
                } else if self.lex.tk == Token::Brak as i64 {
                    self.next()?;
                    if self.lex.tk == ']' as i64 {
                        self.next()?;
                    } else {
                        let _ = self.parse_constant_int()?;
                        if self.lex.tk == ']' as i64 {
                            self.next()?;
                        }
                    }
                    inner_ty += Ty::Ptr as i64;
                } else {
                    break;
                }
            }
            return Ok((idx, inner_ty, inner_array_size));
        }

        // Abstract declarator: type-only, no identifier. Most
        // commonly seen as the unnamed-fp shape `(*)(args)` whose
        // inner-recursion lands here, and as an unnamed parameter
        // closing-out (`,` / `)`). Return `usize::MAX` so callers
        // recognise "no symbol to bind"; only `parse_function_params`
        // is in a context that should accept this.
        if self.lex.tk == ')' as i64 || self.lex.tk == ',' as i64 {
            return Ok((usize::MAX, ty, 0));
        }

        if self.lex.tk != Token::Id as i64 {
            return Err(self.compile_err(format!(
                "identifier expected in declaration (tk={})",
                self.lex.tk
            )));
        }
        let idx = self.lex.curr_id_idx;
        self.next()?;

        let mut array_size: i64 = 0;
        if self.lex.tk == Token::Brak as i64 {
            self.next()?;
            if self.lex.tk == ']' as i64 {
                // `int xs[]` -- empty brackets. The dimension is
                // deferred: in parameter position the caller decays
                // to a pointer; at file or block scope with an
                // initializer the size comes from the initializer
                // (`int xs[] = {1, 2, 3};` -> 3). We signal this
                // shape with `array_size = -1` and let the caller
                // decide how to interpret it.
                self.next()?;
                array_size = -1;
            } else {
                // `int xs[N]` -- N must fold to a positive integer
                // constant. The constant-expression evaluator
                // accepts integer literals (with optional unary
                // minus) and identifiers bound to compile-time
                // integer constants (Token::Num via enum or via
                // `#define`s the preprocessor folded into the
                // source token stream).
                let n = self.parse_constant_int()?;
                if n <= 0 {
                    return Err(
                        self.compile_err(format!("array dimension must be positive (got {n})"))
                    );
                }
                if self.lex.tk != ']' as i64 {
                    return Err(self.compile_err("close bracket expected in array declarator"));
                }
                self.next()?;
                array_size = n;
            }
            // Trailing `[M]` dimension for 2D arrays. c5 stores
            // `array_size = N*M` (total element count) and
            // `inner_array_size = M` on the symbol so the indexing
            // path can scale the first index by `M * sizeof(T)`.
            // Higher-dimensional arrays are flattened: their inner
            // strides aren't tracked, but the byte storage is
            // correct.
            let mut inner_dim: i64 = 0;
            while self.lex.tk == Token::Brak as i64 {
                self.next()?;
                if self.lex.tk == ']' as i64 {
                    self.next()?;
                    continue;
                }
                let m = self.parse_constant_int()?;
                if m <= 0 {
                    return Err(
                        self.compile_err(format!("array dimension must be positive (got {m})"))
                    );
                }
                if self.lex.tk != ']' as i64 {
                    return Err(self.compile_err("close bracket expected in array declarator"));
                }
                self.next()?;
                if inner_dim == 0 {
                    inner_dim = m;
                }
                if array_size > 0 {
                    array_size *= m;
                }
            }
            if idx != usize::MAX {
                // Always overwrite, even with 0, so a rebinding of a
                // name that previously carried a 2D dimension (a
                // struct field, an outer-scope local, etc.) doesn't
                // inherit the stale row stride. C99 6.2.1
                // identifier scopes: each new binding starts fresh,
                // so any per-symbol shape metadata must be cleared
                // when the binding's scope begins.
                self.symbols[idx].inner_array_size = inner_dim;
            }
        } else if idx != usize::MAX {
            // No `[` suffix at all -- the declarator is a scalar or
            // pointer. Same rationale as above: scrub any stale
            // inner_array_size carried over from an earlier binding
            // of the same name.
            self.symbols[idx].inner_array_size = 0;
        }

        Ok((idx, ty, array_size))
    }
}

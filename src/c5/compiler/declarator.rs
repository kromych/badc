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
        while self.lex.tk == Token::MulOp {
            self.next()?;
            ty += Ty::Ptr as i64;
            leading_ptr_count += 1;
            // Pointer-level qualifiers: `int *const p`, `int *volatile p`,
            // `char *restrict s`. Consumed; no semantic effect.
            while self.lex.tk == Token::TypeQual {
                self.next()?;
            }
        }
        // Fn-pointer lineage propagation: if the caller pre-seeded
        // `pending_fn_ptr_indirection` from a typedef-of-fn-ptr
        // base type, the leading `*`s here add directly to the
        // indirection count: `fn_t fp` -> 1, `fn_t *pp` -> 2,
        // `fn_t **ppp` -> 3. The fn-ptr-declarator branch below
        // overrides this with its own value when it fires (the
        // declarator carries explicit fn-pointer shape rather
        // than inheriting from the base type), so we update
        // pending only when leading `*`s actually accumulated.
        if leading_ptr_count > 0
            && let Some(fpi) = self.pending.fn_ptr_indirection
        {
            self.pending.fn_ptr_indirection = Some(fpi + leading_ptr_count);
        }

        // Function-pointer declarator: `RET (*Name)(args)`, possibly
        // nested as `RET (*(*Name)(args1))(args2)`, or abstract as
        // `RET (*)(args)` (an unnamed parameter type, e.g.
        // `int register_cb(void *ctx, int(*)(void*,int))`).
        // Detected by peeking past the open paren: `*` opens the
        // pointer-cum-declarator, `(` starts a nested parens group.
        if self.lex.tk == '('
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
            //
            // The function-pointer determination happens after the
            // trailing decorations are scanned -- only then is it known
            // whether the parenthesised declarator was followed by
            // `(args)` (fn-ptr) or by `[N]` (pointer-to-array, not a
            // fn-ptr). Set the indirection unconditionally here and clear
            // it back to None if the shape resolves to an array.
            let ty_delta = inner_ty - outer_ty_before_inner;
            let inner_ptr_levels = ty_delta / (Ty::Ptr as i64);
            // The inner declarator may have stopped on `(` if it
            // was a function-returning-fp shape like
            // `void (*foo(args1))(args2)`. In that case `foo` is
            // the outer function whose params we MUST capture
            // (the body will reference them); `args2` after the
            // outer paren close is the function-pointer pointee's
            // signature, which c5 doesn't track.
            //
            // When this branch fires we stash the parsed params
            // on `self.pending.fn_params` so `run_compile` can
            // bind `foo` as `Token::Fun` and parse the body even
            // though the next token will be `{` (not `(` -- the
            // params are already consumed).
            let mut saw_fn_signature = false;
            if self.lex.tk == '(' {
                self.next()?;
                // parse_function_params consumes the matching `)`,
                // so on return we're already past the inner args1.
                let params = self.parse_function_params()?;
                self.pending.fn_params = Some(params);
                saw_fn_signature = true;
            }
            if self.lex.tk != ')' {
                return Err(self.compile_err("close paren expected in nested declarator"));
            }
            self.next()?;
            // C99 6.7.5p1: a parenthesised declarator `(D)` is
            // equivalent to `D`. When the inner is a plain
            // identifier with no `*` and no fn-pointer signature
            // got consumed already, the parens are redundant and
            // must NOT promote a following `(args)` to a function-
            // pointer or a following `[N]` to a pointer-to-array.
            // Return immediately so the dispatch in `run_compile`
            // parses `(args)` as a regular function signature on
            // the identifier and a plain `[N]` (handled by the
            // array-suffix branch below) lands as a real array.
            if !saw_fn_signature && inner_ptr_levels == 0 && idx != usize::MAX && self.lex.tk == '('
            {
                return Ok((idx, inner_ty, inner_array_size));
            }
            // Trailing decorations on the parenthesised group.
            // Multiple are legal: `(*pp)[N](args)` etc. Each
            // `[N]` adds a pointer level to `inner_ty` and a
            // dimension to the symbol's `array_dims` so the
            // indexing path can stride correctly through a
            // `T (*p)[N]` shape (`p[i]` strides by
            // `N * sizeof(T)`, not `sizeof(T*)`).
            let mut pointee_dims: alloc::vec::Vec<i64> = alloc::vec::Vec::new();
            loop {
                if self.lex.tk == '(' {
                    self.next()?;
                    // Capture the pointee signature's prototype on the
                    // first function-signature paren so a fn-pointer
                    // declarator records its callee's variadic-ness and
                    // named-parameter count. Subsequent signatures
                    // (function-returning-fp shapes) keep skipping.
                    if !saw_fn_signature {
                        let (fixed, variadic) = self.skip_balanced_parens_capturing_proto()?;
                        self.pending.typedef_fn_proto = Some((fixed, variadic));
                    } else {
                        self.skip_balanced_parens_after_open()?;
                    }
                    saw_fn_signature = true;
                } else if self.lex.tk == Token::Brak {
                    self.next()?;
                    if self.lex.tk == ']' {
                        self.next()?;
                    } else {
                        let m = self.parse_constant_int()?;
                        if m > 0 {
                            pointee_dims.push(m);
                        }
                        if self.lex.tk == ']' {
                            self.next()?;
                        }
                    }
                    inner_ty += Ty::Ptr as i64;
                } else {
                    break;
                }
            }
            // Now the shape is fully known. Only expose the
            // fn-pointer lineage if a function signature actually
            // appeared in the declarator; pointer-to-array shapes
            // share the parenthesised form but must NOT be
            // tagged as fn-ptr lineage (otherwise the unary `*`
            // handler treats `*p` on `T (*p)[N]` as the fn-ptr
            // decay no-op and the row deref never fires).
            if saw_fn_signature && inner_ptr_levels > 0 {
                // Only set the side-channel for the OUTERMOST
                // fn-ptr declarator: the inner recursive call may
                // itself have set it for a nested fn-ptr declarator
                // (function-returning-fp shape), and the outer
                // call's value is the right one to expose.
                self.pending.fn_ptr_indirection = Some(inner_ptr_levels);
            }
            if idx != usize::MAX && !pointee_dims.is_empty() {
                // Pointer-to-array shape: `T (*p)[M1][M2]...[Mn]`.
                // Store dims with a leading 0 sentinel so the
                // indexing paths can disambiguate from a decayed
                // array (which has dims[0] > 0). The peel-one-Ptr
                // step at use-time recovers the decayed-array
                // encoding so the existing multi-dim stride
                // logic applies unchanged.
                let mut dims = alloc::vec::Vec::with_capacity(pointee_dims.len() + 1);
                dims.push(0);
                dims.extend(pointee_dims);
                self.symbols[idx].array_dims = dims;
            }
            return Ok((idx, inner_ty, inner_array_size));
        }

        // Abstract declarator: type-only, no identifier. Most
        // commonly seen as the unnamed-fp shape `(*)(args)` whose
        // inner-recursion lands here, and as an unnamed parameter
        // closing-out (`,` / `)`). Return `usize::MAX` so callers
        // recognise "no symbol to bind"; only `parse_function_params`
        // is in a context that should accept this.
        if self.lex.tk == ')' || self.lex.tk == ',' {
            return Ok((usize::MAX, ty, 0));
        }

        if self.lex.tk != Token::Id {
            return Err(self.compile_err(format!(
                "identifier expected in declaration (got {})",
                super::super::token::describe(self.lex.tk)
            )));
        }
        let idx = self.lex.curr_id_idx;
        self.next()?;

        let mut array_size: i64 = 0;
        if self.lex.tk == Token::Brak {
            self.next()?;
            // C99 6.7.5.3p7 + 6.7.5.2p1: `[`'s contents may be
            // prefixed by `static` and / or any type qualifier
            // (`const` / `volatile` / `restrict`) in a parameter
            // declarator. The keywords are hints to the compiler;
            // c5 doesn't act on them but consumes them so the
            // dimension expression parses cleanly.
            while self.lex.tk == Token::Static || self.lex.tk == Token::TypeQual {
                self.next()?;
            }
            if self.lex.tk == ']' {
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
                if self.lex.tk != ']' {
                    return Err(self.compile_err("close bracket expected in array declarator"));
                }
                self.next()?;
                array_size = n;
            }
            // Trailing dimensions for N-dim arrays. c5 stores
            // `array_size = product(dims)` (total element count),
            // `inner_array_size = dims[1]` for the 2D-init padding
            // path, and `array_dims = [dims..]` for the indexing
            // path so 3D / 4D / ... arrays compute strides at
            // every level.
            let mut dims: alloc::vec::Vec<i64> = alloc::vec::Vec::new();
            if array_size > 0 {
                dims.push(array_size);
            }
            while self.lex.tk == Token::Brak {
                self.next()?;
                // Same C99 6.7.5.3p7 qualifier-skip as the leading
                // dimension above; applies to every trailing
                // dimension too.
                while self.lex.tk == Token::Static || self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
                if self.lex.tk == ']' {
                    self.next()?;
                    continue;
                }
                let m = self.parse_constant_int()?;
                if m <= 0 {
                    return Err(
                        self.compile_err(format!("array dimension must be positive (got {m})"))
                    );
                }
                if self.lex.tk != ']' {
                    return Err(self.compile_err("close bracket expected in array declarator"));
                }
                self.next()?;
                dims.push(m);
                if array_size > 0 {
                    array_size *= m;
                }
            }
            // C99 6.7.7p3: when the base type is a typedef whose
            // alias is an array, the typedef's dimensions extend
            // the declarator's. `typedef i64 gf[16]; gf q[4];`
            // declares `q` as `i64[4][16]`. The carrier is left
            // intact so the rest of a comma-separated declarator
            // list (`gf p[4], q[4];`) still folds the dimension;
            // it is reset when the next declaration's base type
            // is parsed. The caller observes `array_size > 0` and
            // skips its own typedef-dim fold to avoid double
            // application.
            if array_size > 0 {
                let typedef_dim = self.pending.typedef_base_array_size;
                if typedef_dim > 0 {
                    dims.push(typedef_dim);
                    array_size *= typedef_dim;
                }
            }
            // Deferred-outer multi-dim arrays (`T arr[][N]`,
            // `T arr[][N][M]`, ...): the outermost dimension's count
            // arrives later, from the initializer. The trailing
            // inner dims still need to be recorded NOW so the
            // indexer's stride math is correct -- otherwise
            // `arr[i]` strides by `elem_size` instead of
            // `inner_dim * elem_size` and an out-of-row reference
            // walks into the previous row's tail bytes.
            //
            // Convention: `array_dims[0] = 0` marks the deferred
            // outer dim. `seed_multi_dim_strides` only reads
            // `dims[k+1..]` for stride[k] so the placeholder zero
            // never propagates into a computed stride; the
            // post-init fixup in `run_compile` overwrites it with
            // the real count once the initializer has been parsed.
            // Unified dimension list, outermost first. For a deferred
            // outer dim (`array_size < 0`), `dims` holds only the
            // trailing inner dims, so prepend the `0` placeholder; an
            // explicit shape already carries every dimension. The
            // post-init fixup in `run_compile` overwrites `dims[0] == 0`
            // with the real outer count once the initializer is parsed.
            let full_dims: alloc::vec::Vec<i64> = if array_size < 0 && !dims.is_empty() {
                let mut v = alloc::vec::Vec::with_capacity(dims.len() + 1);
                v.push(0);
                v.extend(dims);
                v
            } else {
                dims
            };
            // `inner_array_size` is the second overall dimension (the
            // immediate inner row width), used by the 2D-init padding
            // path. `seed_multi_dim_strides` only reads `dims[k+1..]`
            // for stride[k], so the placeholder zero never enters a
            // computed stride.
            let inner_dim: i64 = if full_dims.len() >= 2 {
                full_dims[1]
            } else {
                0
            };
            if idx != usize::MAX {
                // Always overwrite, even with 0, so a rebinding of a
                // name that previously carried a multi-dim shape (a
                // struct field, an outer-scope local, etc.) doesn't
                // inherit the stale strides. C99 6.2.1 identifier
                // scopes: each new binding starts fresh, so any
                // per-symbol shape metadata must be cleared when the
                // binding's scope begins.
                self.symbols[idx].inner_array_size = inner_dim;
                self.symbols[idx].array_dims = if full_dims.len() >= 2 {
                    full_dims
                } else {
                    alloc::vec::Vec::new()
                };
            }
        } else if idx != usize::MAX {
            // No `[` suffix at all -- the declarator is a scalar or
            // pointer. Same rationale as above: scrub any stale
            // multi-dim metadata carried over from an earlier
            // binding of the same name.
            self.symbols[idx].inner_array_size = 0;
            self.symbols[idx].array_dims = alloc::vec::Vec::new();
            // C99 6.7.7p3 + 6.7.6.1: a declarator `T *p` whose
            // base type `T` is an array typedef declares `p` as
            // a pointer to the typedef's element-array. Record
            // the inner dimension on the symbol so a subsequent
            // `p[i]` (which decays to a row pointer) strides by
            // the row width and a chained `p[i][j]` resolves
            // correctly. The outer dim is a non-zero placeholder:
            // only `dims[1..]` participates in the per-level
            // stride computation, but the multi-dim decay path
            // bails when `dims[0] == 0`, which is reserved for
            // declarator-level pointer-to-array shapes.
            if leading_ptr_count > 0 && self.pending.typedef_base_array_size > 0 {
                let inner = self.pending.typedef_base_array_size;
                self.symbols[idx].inner_array_size = inner;
                self.symbols[idx].array_dims = alloc::vec![1, inner];
            }
        }

        Ok((idx, ty, array_size))
    }
}

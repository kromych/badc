use alloc::string::String;
use alloc::vec::Vec;

/// The part of a declaration's type that the `i64` type tag does not
/// carry: the typedef it was spelled through, and the `const` /
/// `restrict` qualifiers. DWARF describes each with its own DIE
/// (DWARF 4 5.2, 5.3), so the debug-info writers read this to name a
/// type the way the source did instead of naming the type it resolves
/// to. `volatile` is absent because the tag already records it
/// (`types::VOLATILE_BIT`), and nothing outside debug info reads any
/// of it.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct DeclSpelling {
    /// Index in the unit's symbol table of the typedef the base type
    /// was named through. The slot keeps its name for the whole unit
    /// even where a block-scope binding reverts its class.
    pub typedef: Option<u32>,
    /// Qualifiers on the base type. Under a pointer declarator these
    /// are the pointee's (`const T *p`).
    pub base_const: bool,
    pub base_restrict: bool,
    /// Qualifiers on the declared object itself (`T *const p`), which
    /// C99 6.7.5.1p1 takes from the outermost derivation.
    pub outer_const: bool,
    pub outer_restrict: bool,
}

#[derive(Clone, Debug, Default)]
pub(crate) struct Symbol {
    pub name: String,
    pub token: i64,
    pub class: i64,
    pub type_: i64,
    pub val: i64,
    /// For a file-scope object that reserved storage in the data
    /// segment, the byte count reserved at `val`. C99 6.9.2: a later
    /// defining declaration reuses a tentative definition's storage,
    /// but only when it fits -- a deferred-size tentative (`T x[];`)
    /// reserves one element, so a larger initializer must allocate
    /// fresh storage rather than overrun the following globals.
    pub reserved_data_bytes: i64,
    /// Shadow slot for `reserved_data_bytes` (see `h_class`).
    pub h_reserved_data_bytes: i64,
    /// `(previous offset, previous reserved bytes)` when a defining
    /// declaration moved the object out of the storage a tentative
    /// definition had reserved. C99 6.9.2 makes both declarations
    /// denote one object, so references that baked the old offset --
    /// identifier snapshots in the AST and pointer initializers already
    /// written into the data segment -- are rebased onto `val`.
    pub relocated_from: Option<(i64, i64)>,
    /// For a defined file-scope object, its byte size, filled at unit
    /// finalize. The object writers emit it as the symbol size
    /// (`st_size`); 0 means unknown and keeps the size unset.
    pub data_byte_size: i64,
    /// Bytes the object occupies past `sizeof` for a flexible array
    /// member's initialized elements (C99 6.7.2.1p16 keeps the member
    /// out of `sizeof`). Added to `data_byte_size`, so the object's
    /// recorded size covers the tail and the named-section carve moves
    /// all of it.
    pub fam_init_bytes: i64,
    /// Shadow slot for `fam_init_bytes` (see `h_class`).
    pub h_fam_init_bytes: i64,
    pub h_class: i64,
    pub h_type: i64,
    pub h_val: i64,

    // ---- Function-only metadata ----
    /// For `Token::Fun` and `Token::Sys` symbols, the declared parameter
    /// types in source order. Empty for non-functions.
    pub params: Vec<i64>,
    /// True if the function accepts trailing varargs (e.g. `printf`).
    /// Type-checking only verifies the fixed parameters.
    pub is_variadic: bool,

    /// Shadow slots for `params` / `is_variadic`. See `h_array_size`:
    /// a function-pointer parameter, block-scope local, or block-scope
    /// typedef that reuses an outer function name writes its own
    /// prototype onto the shared symbol slot; without the save the
    /// outer signature is permanently replaced (C99 6.2.1p4), which
    /// breaks later call type-checks and can flip a variadic call's
    /// ABI.
    pub h_params: Vec<i64>,
    pub h_is_variadic: bool,

    /// True while the function's return type is the implicit `int`
    /// default rather than a declared type: a `#pragma binding` seen
    /// without a following prototype, or a C89 implicit declaration.
    /// A call site warns once (the result is truncated to 32 bits if
    /// the function really returns a pointer or wider type). Cleared
    /// when a declaration supplies an explicit return type.
    pub implicit_return_int: bool,

    /// True for a function declared `_Noreturn` / `noreturn` (C11
    /// 6.7.4) or one of the built-in non-returning library functions
    /// (`exit`, `abort`, ...). The reachability analysis treats a call
    /// to such a function as not reaching its continuation, so a
    /// caller whose last statement is the call does not fall off its
    /// end.
    pub is_noreturn: bool,

    /// Set on a `Token::Glo` symbol declared with the
    /// `_Thread_local` storage class (C11). Drives the TLS
    /// lowering paths in the per-target writers: ELF .tdata /
    /// .tbss + GOT slot, PE TLS directory + _tls_index, Mach-O
    /// __thread_data + __thread_vars. The VM treats the slot
    /// like a regular global (single-threaded execution).
    pub is_thread_local: bool,
    /// Shadow slot for `is_thread_local` (see `h_class`).
    pub h_is_thread_local: bool,

    /// GNU explicit-register variable: `register T name asm("reg")`
    /// binds the local to a machine register. Stack- and frame-pointer
    /// bindings compile reads into direct register moves; a
    /// general-purpose binding keeps normal slot storage and pins the
    /// variable's inline-asm operands to the named register.
    pub asm_register: Option<AsmRegister>,
    /// Shadow slot for `asm_register` (see `h_class`).
    pub h_asm_register: Option<AsmRegister>,

    /// File-scope `register T name asm("reg")` binding. Distinguishes
    /// the unit-wide `Loc` binding from a function's own local so a
    /// block-scope declaration of the same name shadows it instead of
    /// tripping the duplicate-local check.
    pub is_global_register: bool,
    /// Shadow slot for `is_global_register` (see `h_class`).
    pub h_is_global_register: bool,

    /// GNU asm-label rename (`T name asm("label")`): the assembler
    /// symbol name emitted for this entity. `name` stays the C
    /// identifier -- it remains the lookup key, the redeclaration
    /// match and the spelling diagnostics use -- while every emitted
    /// symbol and relocation uses [`Symbol::link_name`].
    ///
    /// The label is the assembler name, taken as written: gcc and clang
    /// emit it with no target user-label prefix. badc carries names
    /// undecorated through the compiler and the linker, so ELF and PE
    /// emit exactly the label. The Mach-O writer adds its leading
    /// underscore where it decorates today -- the `--shared` dynamic
    /// export table -- so a renamed symbol is exported there as
    /// `_<label>`; nothing else on that path decorates.
    pub asm_name: Option<String>,
    /// Shadow slot for `asm_name` (see `h_class`). An inner binding
    /// that reuses the name starts with no rename of its own.
    pub h_asm_name: Option<String>,

    /// `__attribute__((weak))`: the symbol binds STB_WEAK in the
    /// object's symbol table, for a definition (a strong definition
    /// elsewhere overrides it) and for a declaration (an unresolved
    /// reference links to address 0 instead of failing).
    pub is_weak: bool,

    /// `__attribute__((used))`: keep the definition in the object even
    /// when nothing in the unit references it.
    pub is_used: bool,

    /// `__attribute__((visibility("hidden")))` (or `"internal"`): the
    /// symbol is not preemptible, so the object writer marks it STV_HIDDEN
    /// and addresses it PC-relative directly rather than through the GOT.
    /// An undefined hidden reference resolves within the linked image, to 0
    /// when it stays undefined, with no GOT entry.
    pub is_hidden: bool,

    /// `__attribute__((section("name")))`: the named object section the
    /// symbol's bytes go to instead of the default `.text` / `.data` /
    /// `.bss` placement.
    pub section_name: Option<String>,

    /// `__attribute__((patchable_function_entry(N, M)))` seen on any
    /// declaration of the name: `N` NOPs at the entry, `M` of them ahead
    /// of the symbol, in place of `-fpatchable-function-entry=`.
    pub patchable_function_entry: Option<(u32, u32)>,

    /// `__attribute__((no_instrument_function))` seen on any declaration
    /// of the name: `-pg` emits no profiling call in the body.
    pub no_instrument_function: bool,

    /// `__attribute__((constructor))` seen on any declaration of the
    /// name. Sticky like `is_weak`, so a prototype's attribute reaches
    /// the definition, which registers the `InitFunc` at body open.
    pub is_constructor: bool,
    /// `__attribute__((destructor))`, same carry as `is_constructor`.
    pub is_destructor: bool,
    /// Explicit `constructor(N)` / `destructor(N)` priority; `None`
    /// for the bare form.
    pub init_priority: Option<u32>,

    /// Placement alignment of a `Token::Glo` object with storage: the
    /// widest of the declarator's `aligned(N)` / `_Alignas` request, the
    /// type's natural alignment, and a typedef's `aligned(N)` type
    /// attribute. Zero when the object never went through storage
    /// allocation. The relocatable writer lays named sections out with
    /// it; the unified `.data` placement keeps its own 8-byte floor.
    pub data_align: i64,
    /// Shadow slot for `data_align` (see `h_class`).
    pub h_data_align: i64,

    /// `__attribute__((alias("target")))`: this symbol is an additional
    /// name for its target; `val` carries the target's entry / offset.
    /// Excluded from the per-pc linkage join in the object writers so
    /// it cannot clobber the target's own linkage.
    pub is_alias: bool,

    /// For an array-typed local or global, the declared element
    /// count from `int xs[N]`. Zero means "not an array" (the
    /// symbol is a scalar, struct value, or pointer). The
    /// element type is in `type_`; the total byte storage is
    /// `array_size * size_of_type(type_)`. In expression
    /// position the symbol decays to a pointer-to-element --
    /// the load step is suppressed and `type_` is bumped by
    /// `Ty::Ptr`. Multi-dim arrays would extend this with a
    /// vector of dimensions; today only the single-dimension
    /// case lands.
    pub array_size: i64,

    /// Shadow slot for `array_size`. C99 6.2.1 paragraph 4: an
    /// inner block-scope or function-parameter declaration that
    /// reuses an outer name fully hides the outer binding for the
    /// duration of the inner scope, and the outer binding becomes
    /// visible again unchanged on scope exit. The parameter and
    /// local-decl paths overwrite `array_size` on the same symbol
    /// slot; without this save the outer typedef-array dimension
    /// (e.g. `typedef long jmp_buf[64]`) is permanently lost when
    /// a prototype reuses the name (`f(void *jmp_buf)`).
    pub h_array_size: i64,

    /// Inner dimension of a 2D-or-greater array variable. For
    /// `T xs[N][M]` we record `array_size = N*M` and
    /// `inner_array_size = M` so subscripting `xs[i]` scales by
    /// `M * sizeof(T)` instead of `sizeof(T)` -- the first index
    /// strides over rows, the second over elements. For 3D
    /// `T xs[N][M][K]` this stays `M` (the size immediately
    /// below the outermost dim). Used by the 2D-init-padding
    /// path, which only needs the row size. Higher-dim indexing
    /// uses `array_dims` (below) for the full stride ladder. Zero
    /// for 1D arrays.
    pub inner_array_size: i64,

    /// Shadow slot for `inner_array_size`. See `h_array_size`.
    pub h_inner_array_size: i64,

    /// Full dimension list, outermost first. For `T xs[N][M][K]`
    /// this is `[N, M, K]`. Empty for non-array or 1D-array
    /// symbols (the 1D case is fully described by `array_size`).
    /// The indexing path reads this to compute strides for each
    /// `[i]` subscript level: stride at level `k` is
    /// `product(array_dims[k+1..]) * sizeof(elem)`, with the
    /// final innermost subscript falling through to the regular
    /// `sizeof(elem)` + decay path.
    pub array_dims: Vec<i64>,

    /// Shadow slot for `array_dims`. See `h_array_size`.
    pub h_array_dims: Vec<i64>,

    /// True for a C99 6.7.6.2 variable-length array local: the
    /// element count is a runtime expression, so the storage is
    /// allocated from the stack at runtime rather than a fixed
    /// frame slot. `type_` holds the element type; `array_size` stays
    /// 0 (it is not a constant array). `vla_ptr_slot` is the hidden
    /// frame slot holding the runtime base pointer; `vla_size_slot`
    /// holds the runtime byte count so `sizeof` reports `n *
    /// sizeof(elem)` per 6.5.3.4p2.
    pub is_vla: bool,
    pub vla_ptr_slot: i64,
    pub vla_size_slot: i64,
    /// Shadow slots for the VLA fields, saved / restored alongside
    /// `array_size` so an inner binding that reuses the name does not
    /// corrupt an outer VLA (C99 6.2.1p4).
    pub h_is_vla: bool,
    pub h_vla_ptr_slot: i64,
    pub h_vla_size_slot: i64,

    /// True for a deferred-size array whose initializer resolved to zero
    /// elements (`T x[] = {}`, e.g. an element list left empty after all
    /// members are `#if`'d out). The element type is in `type_` but the
    /// count is 0, which collides with the `array_size == 0` scalar
    /// encoding. This flag keeps the array-ness so the symbol still decays
    /// to a pointer, `sizeof` reports 0, and `typeof(x)` stays distinct
    /// from `typeof(&x[0])` (C99 6.7.6.2 array vs pointer).
    pub is_zero_len_array: bool,
    /// Shadow slot for `is_zero_len_array`. See `h_array_size`.
    pub h_is_zero_len_array: bool,

    /// How the declaration spelled the type; see [`DeclSpelling`].
    /// Debug info only.
    pub decl_spelling: DeclSpelling,

    /// True for a `const`-qualified plain integer object with static
    /// storage (`static const int N = ...`, a file-scope `const`). C99 6.6
    /// does not make it a constant expression, but GCC and common practice
    /// fold its value; the constant-expression evaluator reads the value
    /// back from the object's `.data` storage when this is set, so
    /// `char buf[N * 2 + 1]` is a fixed array rather than a VLA.
    pub is_const_qualified: bool,
    /// Shadow slot for `is_const_qualified` (see `h_class`).
    pub h_is_const_qualified: bool,

    /// Folded initializer of a block-scope `const`-qualified scalar
    /// arithmetic object with automatic storage. GCC (GNU mode, at -O)
    /// folds a reference to such an object where a case label or
    /// `static_assert` needs a constant; the value is recorded at the
    /// declaration, already converted to the declared type, and consumed
    /// by the constant-expression evaluator only in those contexts.
    /// `None` for every other object shape (non-const, volatile,
    /// aggregate, pointer, missing or non-constant initializer).
    pub const_object_value: Option<ConstObjectValue>,
    /// Shadow slot for `const_object_value`. See `h_array_size`.
    pub h_const_object_value: Option<ConstObjectValue>,

    /// True for a file-scope array whose element type is `const`-qualified
    /// (`static const T x[]`). Its elements -- and their members -- cannot
    /// be written (C99 6.7.3), so a relocation the initializer planted in
    /// the storage (a member holding another object's address) holds for
    /// the object's lifetime. The const-global fold reads this to prove a
    /// null comparison of such a member false.
    pub storage_is_const: bool,
    /// Shadow slot for `storage_is_const` (see `h_class`).
    pub h_storage_is_const: bool,

    /// True once a `Token::Glo` symbol has been seen with an
    /// explicit initializer (`= ...`). Tentative-definition
    /// merges (C11 6.9.2): a forward `static T x;` (or the same
    /// translation unit's `extern T x;`) is allowed to be
    /// re-declared and the later defining initializer fills in
    /// the storage. A second declaration that *also* carries an
    /// initializer is a real duplicate.
    pub has_initializer: bool,

    /// True when the object's initial value comes from stores emitted at
    /// its declaration point rather than from the data image, which is
    /// left zeroed (a static array mixing a `&&label` element with one
    /// that is not a link-time constant). A pass reading the image for
    /// the object's value must skip it.
    pub runtime_initialized: bool,
    /// Shadow slot for `runtime_initialized` (see `h_class`).
    pub h_runtime_initialized: bool,

    /// Number of derefs from this variable's *loaded value* down
    /// to a function-pointer rvalue, plus 1, or 0 if the variable
    /// has no function-pointer lineage. Concretely:
    ///
    ///   * `int (*fp)(int)`        -> 1 (loaded value IS the fn ptr)
    ///   * `fn_t fp;` via typedef  -> 1 (same)
    ///   * `fn_t *pp;`             -> 2 (one more deref needed)
    ///   * `int x;`                -> 0 (no lineage)
    ///
    /// The `+1` lets a default-zero field encode "no lineage"
    /// distinctly from "value is direct fn ptr" (which would
    /// otherwise also be zero). Read by the identifier-load path
    /// to seed `Compiler::fn_ptr_chain_depth` and ultimately
    /// decide whether a unary `*` is a real deref or a C decay
    /// no-op. c5 doesn't carry the function-pointer
    /// distinction in the type tag itself, so this side-channel
    /// is the only durable trace.
    pub fn_ptr_indirection: i64,
    /// Shadow slot for `fn_ptr_indirection`, saved by
    /// `shadow_symbol` and restored by `restore_shadowed_symbol`.
    /// Without it, a parameter or local that re-uses an outer
    /// fn-ptr name (or any name a previous binding tagged as
    /// fn-ptr lineage) inherits the stale tag, and a plain
    /// `*p = ...` against the rebound scalar pointer is treated
    /// as a fn-ptr decay no-op.
    pub h_fn_ptr_indirection: i64,
    /// Fn-pointer lineage of the value a call through this variable
    /// returns, in `fn_ptr_indirection`'s plus-1 convention: 0 when the
    /// call result has no fn-pointer lineage, 1 when it IS a function
    /// pointer (`int (*(*p)(int))(int)`), 2 when one deref above one.
    /// The flat tag holds only the total pointer depth, which cannot
    /// separate `int (*(*)(int))(int)` from `int (**)(int)`; this field
    /// carries the split. The call arms read it to seed
    /// `fn_ptr_chain_depth` after an indirect call so a following
    /// unary `*` is the C99 6.3.2.1p4 decay no-op.
    pub fn_ptr_ret_indirection: i64,
    /// Scope-restore shadow for `fn_ptr_ret_indirection`.
    pub h_fn_ptr_ret_indirection: i64,
    /// True for a typedef of a function TYPE (`typedef RET F(args)`),
    /// as opposed to a function POINTER (`typedef RET (*F)(args)`). The
    /// type encoding pre-decays both to a function pointer (`RET` plus
    /// one pointer level), so they are otherwise indistinguishable; a
    /// declarator needs the distinction because `F *p` over a function
    /// type forms the pointer-to-function (a function pointer) while
    /// `F *p` over a function pointer is a pointer to one.
    pub is_function_type: bool,

    /// Set on a `Token::Fun` symbol whose declared return type
    /// was bare `void`. The type encoding (`type_`) still records
    /// `Ty::Char | UNSIGNED_BIT` -- a side-channel rather than
    /// a separate `Ty::Void` band, because a real band collides
    /// with the function-pointer encoding C99 6.7.6.3 uses for
    /// `void (*)(...)` slots inside dispatch tables. Consumed by:
    ///   * the function-body emit path: prepends a zero
    ///     immediate before the trailing synthetic return so a
    ///     caller that misclassifies the prototype reads `0`
    ///     rather than stale accumulator state (C99 6.8.6.4p3).
    ///   * the `return` statement: bare `return;` in a void
    ///     function emits the same zero prefix; a `return
    ///     <expr>;` is rejected as a constraint violation
    ///     (C99 6.8.6.4p1).
    pub returns_void: bool,

    /// Set on a `Token::Typedef` symbol whose alias chain ends
    /// at the bare `void` keyword. Because `void` and
    /// `unsigned char` share the same type encoding, the
    /// function-parameter parser consults this flag to
    /// distinguish `int f(VOID)` (no parameters) from
    /// `int f(BYTE)` (one byte-typed parameter).
    pub is_void_typedef: bool,

    /// True for a typedef whose base type is an `enum`. The base
    /// collapses to `int`, but an enum bitfield reads as unsigned, so
    /// a field declared with this typedef plus a bitfield width needs
    /// the unsigned (zero-extending) extraction.
    pub is_enum_typedef: bool,

    /// Explicit alignment (bytes) a typedef's type carries from a GNU
    /// `__attribute__((aligned(N)))` type attribute, or 0 for the
    /// type's natural alignment. Unlike `_Alignas` on an object or
    /// member (raise-only), a type attribute sets the alignment and may
    /// lower it below the natural value (`typedef long long
    /// __attribute__((aligned(4))) t;`). The scalar type tag cannot
    /// record this, so a declaration through the typedef re-seeds
    /// `pending.type_align` from here for struct-field layout,
    /// `__alignof__`, and object placement.
    pub type_align: i64,
    /// Shadow slot for `type_align`. See `h_array_size`: a block-scope
    /// typedef reusing an outer name saves the outer alignment here.
    pub h_type_align: i64,

    /// C99 6.2.2 linkage class of a file-scope identifier.
    /// `Linkage::None` for block-scope names; `Linkage::Internal`
    /// for `static`-qualified file-scope names; `Linkage::External`
    /// for everything else at file scope. Used by the linker
    /// (when the `full` feature is enabled) to decide whether
    /// this symbol participates in the cross-translation-unit
    /// symbol table -- internal-linkage names stay private to the
    /// translation unit. Inside a single TU compile this field is
    /// informational only.
    pub linkage: Linkage,

    /// True for a `Token::Fun` whose body has been emitted into
    /// `Compiler::text`, or a `Token::Glo` whose storage has been
    /// allocated in `Compiler::data` / `Compiler::tls_data`.
    /// False for forward prototypes (`int foo();`) and for
    /// `extern T x;` declarations whose definition lives in
    /// another translation unit -- those become undefined-symbol
    /// references in the link-unit symbol table.
    pub defined_here: bool,

    /// True for a file-scope declaration that explicitly carried
    /// the `extern` storage-class keyword. Combined with
    /// `defined_here == false`, it distinguishes an extern
    /// declaration (a forward reference satisfied by another TU)
    /// from a tentative definition that the parser is still
    /// waiting to resolve.
    pub is_extern_decl: bool,
    /// Shadow slot for `is_extern_decl` (see `h_class`).
    pub h_is_extern_decl: bool,

    /// Per-name census of the file-scope declarations of a function in
    /// the translation unit, sticky across all of them. Each records
    /// that at least one declaration had the named shape:
    /// `saw_noninline_decl` no `inline`; `saw_static_decl` `static`;
    /// `saw_plain_inline_decl` `inline` without `extern`;
    /// `saw_extern_inline_decl` `inline` with `extern`. Together with
    /// `is_gnu_inline` they decide, per [`InlineModel`], whether the
    /// unit's definition is an inline definition; see
    /// [`inline_definition`].
    pub saw_noninline_decl: bool,
    /// A definition in this unit spelled without `inline`. Under the
    /// GNU89 model an `extern inline` body is inline-only, and gcc's
    /// gnu_inline contract lets the same unit provide the ordinary
    /// definition; that definition is the external one.
    pub saw_noninline_def: bool,
    pub saw_static_decl: bool,
    pub saw_plain_inline_decl: bool,
    pub saw_extern_inline_decl: bool,

    /// `__attribute__((gnu_inline))` on any declaration of this
    /// function: the GNU89 inline model applies to it whatever the
    /// unit's default model is.
    pub is_gnu_inline: bool,

    /// The definition in this unit is an inline definition and provides
    /// no external definition (C99 6.7.4p6). Computed once per unit
    /// after the last declaration is in; drives internal linkage and
    /// suppresses the unused-function diagnostic.
    pub is_inline_definition: bool,

    /// Assembler name the inline definition's body is emitted under,
    /// distinct from the identifier so the identifier stays available as
    /// an undefined external reference. `None` for every other symbol.
    /// See [`Symbol::def_link_name`].
    pub inline_body_name: Option<String>,

    /// Placeholder `ent_pc` naming the identifier as an import, used by
    /// the address sites of an inline definition. `val` keeps the real
    /// `ent_pc`, so a direct call still reaches the body in this unit.
    pub inline_addr_pc: Option<i64>,

    /// True while a block-scope `extern` declaration that shadows an
    /// enclosing local (or other bound name) holds this slot. The slot
    /// is converted to `Glo` for the block so in-block references take
    /// the global path, but the prior binding is saved and restored at
    /// block exit (C99 6.2.1p4). Set on conversion, cleared on the
    /// block-exit restore. A reference emitted while it is set is
    /// recorded in `Ast::block_extern_refs` so the walker resolves it
    /// against the same-TU definition (if any) or a name-keyed extern,
    /// independent of the slot's restored class at walk time.
    pub block_extern_active: bool,

    /// True for a binding made at the function-body top level whose
    /// class no longer reads as `Loc`, so the function-exit cleanup
    /// cannot infer it: a block-scope `static` (promoted to `Glo`), a
    /// typedef, an enumerator, or a block-scope / C89-implicit function
    /// declaration (C99 6.2.1p4: all have block scope). The cleanup
    /// restores the shadowed outer binding. Cleared on restore.
    pub is_scope_bound: bool,

    /// True once a block-scope or C89-implicit function declaration
    /// bound this symbol. Scope exit unbinds the name (`class` returns
    /// to 0), but the entity -- prototype, linkage, asm rename -- stays
    /// on the slot for call lowering and the extern-import scan (C99
    /// 6.2.2p4: every declaration with external linkage denotes the
    /// same function). Never cleared.
    pub scoped_fn_decl: bool,

    /// ent_pc of the enclosing function for a block-scope static's
    /// emission record (the persistent `name.N` symbol; the scoped
    /// binding itself is restored at function exit). A block-scope
    /// static exists only in an emitted instance of its function, so
    /// static DCE honors `is_used` on such a record only while the
    /// owner survives. `None` for file-scope symbols.
    pub owner_ent_pc: Option<u64>,

    /// Index of the emission record while this slot's live binding is a
    /// block-scope static. Reference-capture sites resolve the name to
    /// the record, whose state outlives the scope-exit restore of the
    /// slot (which may bring back a same-named file-scope `extern`).
    /// Set at the promotion, cleared when the binding's scope exits.
    pub static_local_record: Option<u32>,
    /// Shadow slot for `static_local_record` at function-body scope.
    pub h_static_local_record: Option<u32>,

    /// True for the synthetic internal symbol of an anonymous compound
    /// literal staged in the data segment. Its initializer bytes are
    /// final at parse time, so a constant subscript of the literal may
    /// fold by reading them back (which is not extended to named
    /// objects: `const int t[3]` indexed is not an integer constant
    /// expression, matching gcc / clang).
    pub is_compound_literal: bool,

    /// True once the parser has emitted any reference to this
    /// symbol after its declaration -- a read, a write, an
    /// address-of, or a decay. Set by the expression parser's
    /// identifier resolution path; consulted at block / function
    /// exit to emit a C99-style "unused variable" diagnostic for
    /// block-scope locals and parameters that were never
    /// mentioned in the body.
    pub was_referenced: bool,

    /// True once a scalar load (`LoadKind::I64` / `LoadKind::U8` / ...) of
    /// this symbol's value survives in the parser's recent-emit
    /// ring -- i.e., the runtime would actually read the stored
    /// value. Distinct from `was_referenced`: the identifier-
    /// rvalue path tentatively sets `was_read` when it tags the
    /// load, and the assignment / address-of helpers retract the
    /// bit if they remove the load before the parse closes.
    /// Consulted alongside `was_written` to emit the "value
    /// assigned but never used" diagnostic for dead stores.
    pub was_read: bool,

    /// True once a scalar store of this symbol's lvalue surface
    /// has been emitted, or a declaration
    /// initializer wrote the storage. Set by the assignment /
    /// compound-assignment / increment paths in the expression
    /// parser and by `allocate_local_with_init` for declarations
    /// with `= ...`. Consulted alongside `was_read` to emit the
    /// dead-store diagnostic.
    pub was_written: bool,

    /// True once the symbol's address has been taken (`&local`
    /// or array decay). The address might escape to an unknown
    /// callee that reads or writes the storage, so the
    /// unused-symbol diagnostics suppress themselves
    /// conservatively when this flag is set.
    pub address_escaped: bool,

    /// Source lines of stores to this symbol that have not yet
    /// been followed by a read. Pushed by the assignment paths
    /// in the expression parser and by
    /// `allocate_local_with_init` for declarations with `= ...`.
    /// Cleared when an identifier-rvalue load of the symbol
    /// tags the trailing scalar load. Branches and function calls
    /// also clear the list (conservatively; the analysis is
    /// intra-segment to avoid flow-sensitivity false positives).
    /// Drained at function exit to emit the dead-store
    /// diagnostic for any line still present.
    pub pending_stores: Vec<usize>,

    /// Source line where this declaration was parsed. Captured at
    /// declaration time so unused-variable diagnostics can point
    /// at the declaration rather than the surrounding block's
    /// closing brace.
    pub decl_line: usize,

    /// `Compiler::source_files` index of the file the declaration
    /// was parsed from. Captured at declaration time alongside
    /// `decl_line`. Surfaces as `DW_AT_decl_file` in the DWARF
    /// variable / formal_parameter DIE after mapping to the
    /// DWARF file_names index. Zero means the primary source.
    pub decl_file: u32,

    /// True if the declaration was parsed while the lexer was
    /// reading the primary source (matched against
    /// `Compiler::source_label`); false when the declaration came
    /// from a header pulled in by `#include`. Used to suppress
    /// unused-symbol diagnostics on header-internal static
    /// helpers -- those are only dead with respect to the current
    /// translation unit, and the header is the wrong place to
    /// flag them.
    pub decl_in_main_source: bool,

    /// True when the declaration carried a `maybe_unused` /
    /// `unused` attribute (C23 6.7.12.4 `[[maybe_unused]]` or GNU
    /// `__attribute__((unused))`). Suppresses the unused-variable
    /// and dead-store diagnostics for this symbol, matching the
    /// documented effect of the attribute.
    pub maybe_unused: bool,
}

/// Recorded initializer value of a block-scope `const` scalar arithmetic
/// object (see `Symbol::const_object_value`). Floats carry the f64 bit
/// pattern so the type stays `Copy + Eq` for the shadow-slot machinery.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ConstObjectValue {
    Int(i64),
    FloatBits(u64),
}

/// The machine register a `register T name asm("reg")` declaration
/// names, resolved against the compile target. The stack and frame
/// pointers are singled out because reading them is the pervasive use
/// and needs no allocator involvement; any other general-purpose
/// register carries its architectural number.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AsmRegister {
    /// rsp / esp (x86-64), sp (aarch64).
    StackPointer,
    /// rbp / ebp (x86-64), x29 / fp (aarch64).
    FramePointer,
    /// Any other bindable general-purpose register, by architectural
    /// number.
    Gp(u8),
}

/// C99 6.2.2 linkage class. `None` is the default for block-scope
/// declarations and for the symbol-table predefines; file-scope
/// declarations resolve to one of `Internal` (`static`) or
/// `External` (everything else, including bare declarations and
/// `extern T x;`). Materialised onto every symbol so the linker
/// can decide whether to surface the name in the cross-TU symbol
/// table or keep it private.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
pub enum Linkage {
    /// No linkage -- block-scope names, function parameters,
    /// per-target header predefines, and any symbol the linker
    /// has no business looking at. The default for a freshly-
    /// constructed `Symbol`.
    #[default]
    None,
    /// `static` file-scope identifiers. Visible only within the
    /// containing translation unit; never emitted into the
    /// link-unit symbol table.
    Internal,
    /// Unqualified file-scope identifiers and `extern T x;`
    /// references. Visible to other translation units through
    /// the link-unit symbol table.
    External,
}

/// Which set of rules decides whether a unit's `inline` definition
/// also provides that function's external definition. The two are
/// inverted with respect to each other, so the model in force has to
/// be explicit at every decision point.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
pub enum InlineModel {
    /// C99 6.7.4p6-p7. If every file-scope declaration of the function
    /// includes `inline` and none includes `extern`, the definition is
    /// an inline definition and provides no external definition;
    /// otherwise it provides one. badc's default, reported to headers
    /// as `__GNUC_STDC_INLINE__`.
    #[default]
    C99,
    /// GNU89, selected by `-fgnu89-inline` for the whole unit or by
    /// `__attribute__((gnu_inline))` per function. `extern inline` is
    /// inline-only and never provides an external definition; a plain
    /// `inline` does provide one. Reported as `__GNUC_GNU_INLINE__`.
    Gnu89,
}

/// True when this function's definition is an inline definition -- it
/// provides no external definition for the name in this unit.
/// `static` never reaches here: internal linkage is decided first and
/// is orthogonal to both models.
pub fn inline_definition(sym: &Symbol, model: InlineModel) -> bool {
    if !sym.saw_plain_inline_decl && !sym.saw_extern_inline_decl {
        return false;
    }
    let gnu89 = sym.is_gnu_inline || model == InlineModel::Gnu89;
    if gnu89 {
        // GCC's `gnu_inline` contract: `extern inline` is used only for
        // inlining, a declaration spelling `inline` without `extern`
        // cancels that back to a standalone definition, and an ordinary
        // definition in the same unit is the external one.
        sym.saw_extern_inline_decl && !sym.saw_plain_inline_decl && !sym.saw_noninline_def
    } else {
        // C99 6.7.4p6: every declaration `inline`, none `extern`. A
        // non-inline declaration sets `saw_noninline_decl`, so only the
        // `extern inline` shape needs its own term.
        !sym.saw_noninline_decl && !sym.saw_extern_inline_decl
    }
}

impl Symbol {
    /// Assembler symbol name: the GNU asm label when the declaration
    /// set one, otherwise the C identifier. Every emitted symbol,
    /// relocation and export uses this; `name` is the identifier.
    pub fn link_name(&self) -> &str {
        self.asm_name.as_deref().unwrap_or(&self.name)
    }

    /// Assembler name of the definition this unit emits. Equals
    /// [`Self::link_name`] except for an inline definition, whose body is
    /// private to the unit while the identifier stays an external
    /// reference (C99 6.2.2p2). Consumers naming the body -- the emitted
    /// function symbol, the per-function attribute lookups keyed on it --
    /// use this; consumers naming the entity across units use
    /// `link_name`.
    pub fn def_link_name(&self) -> &str {
        match self.inline_body_name.as_deref() {
            Some(n) => n,
            None => self.link_name(),
        }
    }

    /// Whether the slot denotes a function entity: a live `Token::Fun`
    /// binding, or a scoped function declaration whose name binding was
    /// unwound at scope exit (`class` back to 0) while `val`, the
    /// prototype and the linkage stayed on the slot. Consumers reading
    /// the entity (call lowering, import scans) use this; name lookup
    /// keys on `class` alone.
    pub fn is_fun_entity(&self) -> bool {
        self.class == crate::c5::token::Token::Fun as i64
            || (self.class == 0 && self.scoped_fn_decl)
    }
}

impl crate::c5::layout::DataOffsets for Symbol {
    /// `val` is a `Program::data` byte offset only for a file-scope object
    /// this unit defines: a function symbol's `val` is an `ent_pc`, a
    /// `_Thread_local` symbol's indexes the TLS image, and an undefined
    /// `extern` reserves no storage here.
    fn remap_data_offsets(&mut self, r: &dyn crate::c5::layout::DataRemap) {
        let Self {
            name: _,
            token: _,
            class,
            type_: _,
            val,
            reserved_data_bytes: _,   // a byte count, not an offset
            h_reserved_data_bytes: _, // scope-restore shadow
            relocated_from: _,        // the pre-relocation span, kept for diagnostics
            data_byte_size: _,        // a byte count
            fam_init_bytes: _,        // a byte count
            h_fam_init_bytes: _,
            h_class: _,
            h_type: _,
            h_val: _, // scope-restore shadow; every scope is unwound before a `Program` exists
            params: _,
            is_variadic: _,
            h_params: _,
            h_is_variadic: _,
            implicit_return_int: _,
            is_noreturn: _,
            is_thread_local,
            h_is_thread_local: _,
            asm_register: _,
            h_asm_register: _,
            is_global_register: _,
            h_is_global_register: _,
            asm_name: _,   // an assembler symbol name, not an offset
            h_asm_name: _, // scope-restore shadow
            is_weak: _,
            is_used,
            is_hidden: _,
            section_name,
            patchable_function_entry: _,
            no_instrument_function: _,
            is_constructor: _,
            is_destructor: _,
            init_priority: _,
            data_align: _, // an alignment, not an offset
            h_data_align: _,
            is_alias: _,
            array_size: _,
            h_array_size: _,
            inner_array_size: _,
            h_inner_array_size: _,
            array_dims: _,
            h_array_dims: _,
            is_vla: _,
            vla_ptr_slot: _,  // frame slot
            vla_size_slot: _, // frame slot
            h_is_vla: _,
            h_vla_ptr_slot: _,
            h_vla_size_slot: _,
            is_zero_len_array: _,
            h_is_zero_len_array: _,
            decl_spelling: _, // debug-info spelling, not an offset
            is_const_qualified: _,
            h_is_const_qualified: _,
            const_object_value: _,
            h_const_object_value: _, // scope-restore shadow
            storage_is_const: _,
            h_storage_is_const: _,
            has_initializer: _,
            runtime_initialized: _,
            h_runtime_initialized: _,
            fn_ptr_indirection: _,
            h_fn_ptr_indirection: _,
            fn_ptr_ret_indirection: _,
            h_fn_ptr_ret_indirection: _,
            is_function_type: _,
            returns_void: _,
            is_void_typedef: _,
            is_enum_typedef: _,
            type_align: _,
            h_type_align: _,
            linkage: _,
            defined_here,
            is_extern_decl: _,
            h_is_extern_decl: _,
            saw_noninline_decl: _,
            saw_noninline_def: _,
            saw_plain_inline_decl: _,  // linkage model input, not an offset
            saw_extern_inline_decl: _, // linkage model input, not an offset
            is_gnu_inline: _,          // linkage model selector
            is_inline_definition: _,   // linkage model result
            inline_body_name: _,       // assembler name, not an offset
            inline_addr_pc: _,         // code address space
            saw_static_decl: _,
            block_extern_active: _,
            is_scope_bound: _,
            scoped_fn_decl: _,
            owner_ent_pc: _, // code address space
            static_local_record: _,
            h_static_local_record: _, // scope-restore shadow
            is_compound_literal: _,
            was_referenced: _,
            was_read: _,
            was_written: _,
            address_escaped: _,
            pending_stores: _,
            decl_line: _,
            decl_file: _,
            decl_in_main_source: _,
            maybe_unused: _,
        } = self;
        if *class != crate::c5::token::Token::Glo as i64
            || !*defined_here
            || *is_thread_local
            || !r.in_data(*val)
        {
            return;
        }
        match r.remap(*val, *val) {
            Some(new) => *val = new,
            // The object was dropped. Retire the record in place -- removing
            // it would shift the indices the AST references -- so no writer
            // places or carves it.
            None => {
                *defined_here = false;
                *is_used = false;
                *section_name = None;
                *val = 0;
            }
        }
    }
}

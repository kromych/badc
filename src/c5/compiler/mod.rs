use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::CODE_BASE;
use super::codegen::Target;
use super::error::C5Error;
use super::lexer::{self, Lexer};
use super::preprocessor::{DylibSpec, IncludeRecord, PpReuse, Preprocessor};
use super::program::Program;
use super::symbol::Symbol;
use super::token::Token;

mod aggregate;
mod call_fixups;
mod const_expr;
mod control_flow;
mod convert;
mod decl_base;
mod declarator;
mod diag;
mod emit;
mod enum_decl;
mod expr;
mod function;
mod global_init;
mod initializer;
mod locals;
mod loop_idiom;
mod run_compile;
mod sizeof_expr;
mod stmt;
mod type_layout;
#[cfg(test)]
pub(crate) use emit::SCOPE_UNWIND;
pub(crate) use initializer::PendingLabelReloc;
pub(crate) use type_layout::{
    StructReturnAbi, host_abi_agg_desc, host_abi_agg_desc_conv, struct_return_abi,
    struct_return_abi_conv,
};
pub(crate) mod types;

/// Largest alignment (in bytes) honored on a static object via C11
/// `_Alignas` / the GCC `aligned` attribute, whether the request comes
/// from the declarator or the object's type. Static objects (file-scope,
/// block-scope static, and initialised or zero-init alike) are placed at
/// this alignment in `.data` / `.bss`; automatic objects stay capped at
/// `MAX_FRAME_ALIGN`. 64 KiB is the
/// largest page size in common use (the aarch64 max-page-size) and covers
/// cache-line, page, and page-multiple requests such as a per-CPU stack.
/// The self-contained ELF writer raises the read-write segment `p_align`
/// to the object's alignment so a PIE load bias preserves it, and the JIT
/// over-aligns its data mapping the same way; both are bounded by
/// `TEXT_VMADDR_BASE`, which fixes the structural ceiling above this.
pub(crate) const MAX_STATIC_ALIGN: usize = 65536;

/// Maximum alignment an automatic (stack) object may request. The prologue
/// realigns sp down to the object's alignment (C11 6.7.5 `_Alignas` / GNU
/// `aligned`); a larger request must use static storage. One page bounds the
/// per-frame waste the realignment reserves.
pub(crate) const MAX_FRAME_ALIGN: i64 = 4096;

/// Captured enum tag + constants for DWARF emission. C99 6.7.2.2
/// enums collapse to `int` in c5 -- the tag carries no semantic
/// weight at the type level -- but preserving the (name, value)
/// pairs lets the DWARF emitter produce DW_TAG_enumeration_type
/// + DW_TAG_enumerator children so `(gdb) ptype enum Tag` works.
/// Anonymous enums (no tag) skip emission; their constants stay
/// reachable through plain integer DW_AT_const_value lookups in
/// the symbol table.
#[derive(Debug, Clone)]
pub struct EnumDef {
    pub name: String,
    pub constants: Vec<(String, i64)>,
    /// The enum's underlying integer type tag (`Ty::Int` for a plain
    /// enum, a sub-int width for `__attribute__((packed))`). A bare
    /// `enum Tag` reference resolves its size / alignment through this.
    pub underlying_ty: i64,
}

impl EnumDef {
    /// Byte size of the underlying integer type. Packed enums narrow to
    /// 1/2/4/8; a plain enum is 4. Target-independent: the underlying
    /// type is never `long`.
    pub fn byte_size(&self) -> u8 {
        let t = self.underlying_ty & !types::UNSIGNED_BIT;
        if t == super::token::Ty::Char as i64 {
            1
        } else if t == super::token::Ty::Short as i64 {
            2
        } else if t == super::token::Ty::Int as i64 {
            4
        } else {
            8
        }
    }
}

#[derive(Debug, Clone)]
pub struct StructDef {
    pub name: String,
    /// Total size in bytes -- sum of field sizes (each placed at
    /// its natural alignment) for structs, `max(field size)` for
    /// unions, padded up to the struct's own alignment. Always at
    /// least 8 (c5 has no zero-sized aggregates).
    pub size: usize,
    /// Alignment of the aggregate in bytes -- the max alignment of
    /// any field, capped at 8 (the rest of c5's IR -- locals,
    /// stack pushes, GOT entries -- is 8-byte slotted, so
    /// over-aligning a struct above 8 buys nothing). `0` until
    /// `parse_aggregate_body` finishes.
    pub align: usize,
    /// The attribute-derived part of `align`: the widest `aligned(N)` /
    /// `_Alignas` reaching the aggregate through its tag, body, members,
    /// or a member's typedef, 0 when the alignment is purely natural.
    pub explicit_align: u32,
    /// The alignment the members require with every `aligned(N)` /
    /// `_Alignas` / `packed` / `#pragma pack` removed, computed
    /// recursively through nested aggregates. `align` cannot report it
    /// once an attribute raised or lowered the aggregate, and object
    /// placement keeps it as a floor. `0` until layout finishes.
    pub natural_align: usize,
    pub fields: Vec<StructField>,
    /// Unnamed bit-fields, in declaration order. C99 6.7.2.1p11 makes
    /// them members that reserve storage, but they have no name, so
    /// they are not addressable and do not appear in `fields`. The
    /// post-body `packed` re-lay replays them from here to reproduce
    /// the placement the natural pass computed.
    pub anon_bitfields: Vec<AnonBitfield>,
    /// Members promoted from an anonymous struct/union, in declaration
    /// order. `fields` cannot express the boundary between this
    /// aggregate's members and a member's own members, which the
    /// post-body `packed` re-lay needs: packing removes the padding
    /// between an aggregate's members, not the padding inside a
    /// member's type.
    pub anon_members: Vec<AnonMember>,
    /// `true` for `union` definitions. The only effect on layout
    /// is that every field sits at offset 0 and the aggregate
    /// size is `max(field size)` instead of the sum. Member
    /// access otherwise reuses the struct path verbatim.
    pub is_union: bool,
    /// `false` for a tag that has been named but whose body has not
    /// been parsed (C99 6.7.2.3 incomplete type). Size cannot stand in
    /// for this: a complete empty `struct {}` and a struct whose only
    /// member is a flexible array both have size 0.
    pub is_complete: bool,
    /// `true` for the synthesized aggregate that models a GCC vector type
    /// (`__attribute__((vector_size(N)))`). It has one array field of the
    /// element type; the flag lets the cast and binary-operator paths treat it
    /// as a vector (reinterpret casts, element-wise operators) rather than a
    /// plain struct.
    pub is_vector: bool,
    /// `true` for the synthesized aggregate that models the pointee of a
    /// pointer-to-array type (`T (*)[N]`, or `A *` for an array typedef
    /// `A`). It has one array field of the element type; the entry gives
    /// the pointer-to-array tag a first-class type id, so the array layer
    /// survives typedefs and extra pointer levels, and `pointee_size`
    /// yields the row size. Only pointer depths >= 1 of the tag occur:
    /// the last dereference decays to the element pointer (C99 6.3.2.1p3)
    /// instead of producing the depth-0 value.
    pub is_array: bool,
    /// `true` when the source declared no tag and `name` is the synthetic
    /// one the registry needs as a key. C99 6.7.2.3 gives such a type no
    /// name, so DWARF describes it with no `DW_AT_name`; the synthetic
    /// spelling carries a parse-order serial and matches nothing across
    /// translation units.
    pub is_anonymous: bool,
    /// GNU `transparent_union`: a function parameter of this union type
    /// accepts an argument compatible with any member and takes it as
    /// that member. Set only when the attribute is honored
    /// (`mark_transparent_union`).
    pub is_transparent_union: bool,
    /// A cast type-name in this unit names the aggregate. C99 6.5.4 makes
    /// that a use of the type whatever becomes of the value, so debug info
    /// keeps a DIE for it with no object of the type declared.
    pub cast_named: bool,
}

/// One unnamed bit-field of an aggregate (`int :N;`). `before` is the
/// index in `StructDef::fields` of the first named member declared
/// after it, `unit` the declared type's size in bytes, and `width` the
/// requested bit count -- 0 for the C99 6.7.2.1p11 form that only ends
/// the current storage unit.
#[derive(Debug, Clone, Copy)]
pub struct AnonBitfield {
    pub before: u32,
    pub width: u32,
    pub unit: u8,
}

/// One member promoted from an anonymous struct/union (C11 6.7.2.1p13).
/// `first` is its first entry in `StructDef::fields` and `count` how many
/// it contributed -- 0 when the anonymous aggregate has no named member
/// of its own -- with `offset` the member's byte offset in the enclosing
/// aggregate and `size` its type's size. `inner` is the anonymous
/// aggregate's own definition: the promoted run mirrors its field list
/// one-to-one, so its `anon_members` describe the runs nested inside this
/// one and the records form a tree of arbitrary depth.
#[derive(Debug, Clone, Copy)]
pub struct AnonMember {
    pub first: u32,
    pub count: u32,
    pub offset: usize,
    pub size: usize,
    pub inner: usize,
}

/// Where a member chain stands, relative to the object it started at.
#[derive(Debug, Clone, Copy)]
pub struct MemberBase {
    /// Byte size of the declared object the chain started at; `None`
    /// when it started at a pointer's target.
    pub decl_size: Option<i64>,
    /// Byte offset of the current subobject within that object.
    pub offset: i64,
    /// Struct (not union) containers crossed so far.
    pub records: u32,
    /// Every struct container crossed selected its last member.
    pub at_end: bool,
}

impl MemberBase {
    /// A chain starting at a pointer's target.
    pub const UNKNOWN: MemberBase = MemberBase {
        decl_size: None,
        offset: 0,
        records: 0,
        at_end: true,
    };
}

/// An array member's decay as `__builtin_object_size` reads it.
#[derive(Debug, Clone, Copy)]
pub struct ArrayMember {
    /// Bytes from the member to the end of the declared object the
    /// chain started at, when it started at one.
    pub decl_remaining: Option<i64>,
    /// The member may extend past its declared bound: its type is
    /// incomplete, or `-fstrict-flex-arrays` treats it as flexible and
    /// the chain reached it through a pointer.
    pub unbounded: bool,
}

#[derive(Debug, Clone)]
pub struct StructField {
    pub name: String,
    /// Byte offset of the field from the start of the struct.
    /// For a bitfield, the byte offset of the *storage unit*
    /// (8-byte word) the bitfield lives in.
    pub offset: usize,
    /// `ty`-encoded type of the field.
    pub ty: i64,
    /// Array dimension if the field was declared as `T xs[N]`;
    /// 0 when the field is a scalar / pointer / struct value.
    /// For a 2D field `T xs[N][M]` this stores the total element
    /// count (`N * M`) and `inner_array_size = M`. `s.xs` decays
    /// to a pointer-to-element the same way a local array does.
    pub array_size: i64,
    /// Inner dimension for a 2D-or-greater array field
    /// (`T xs[N][M]` -> `M`). Mirrors `Symbol::inner_array_size`:
    /// with this set, the `s.xs[i]` postfix scales `i` by
    /// `M * sizeof(T)` and stays at pointer type so the next
    /// `[j]` decays to an element. Used by the 2D-init padding
    /// path. 0 for 1D / scalar fields.
    pub inner_array_size: i64,
    /// Full dimension list for an N-dim array field, outermost
    /// first. Mirrors `Symbol::array_dims`. Empty for non-array
    /// or 1D-array fields. The field-access decay path reads
    /// this to compute the per-level strides for `s.xs[i][j][k]`.
    pub array_dims: Vec<i64>,
    /// The bound was spelled `[0]` (a GNU zero-length array, complete
    /// with size zero) rather than `[]`; both store `array_size = -1`.
    pub zero_len: bool,
    /// Bit offset within the storage unit. Meaningful only when
    /// `bit_width > 0`.
    pub bit_offset: u32,
    /// Bit width of a bitfield, or 0 for a regular field. Bitfields
    /// pack into shared storage units sized by their base type
    /// (C99 6.7.2.1p11); reads emit a load-shift-mask sequence and
    /// writes emit a load-clear-shift-or-store sequence keyed by
    /// `bit_unit_size`.
    pub bit_width: u32,
    /// Storage-unit size in bytes (1, 2, 4, or 8). Picks the
    /// matching `Lc/Lh/Lw/Li` and `Sc/Sh/Sw/Si` opcodes for the
    /// bitfield read / write so a 32-bit-base bitfield does not
    /// load eight bytes (which would mix in adjacent fields).
    /// Meaningful only when `bit_width > 0`; 0 otherwise.
    pub bit_unit_size: u8,
    /// Function-pointer lineage tag (mirrors
    /// `Symbol::fn_ptr_indirection`). 0 for non-fn-ptr fields;
    /// `n >= 1` for fields whose value, after `n - 1` derefs, is
    /// the fn-pointer rvalue. `Symbol::fn_ptr_indirection`'s
    /// convention: 1 means the field IS the fn-pointer, 2 means
    /// it's a pointer-to-fn-pointer, etc. The post-load handler
    /// in member access seeds `pending.fn_ptr_chain_depth` from
    /// this so a following unary `*` recognises the C99 6.3.2.1
    /// function-to-pointer no-op decay instead of emitting a
    /// spurious `Li` that loads through code memory.
    pub fn_ptr_indirection: i64,
    /// Fn-pointer lineage of the value a call through this field
    /// returns (mirrors `Symbol::fn_ptr_ret_indirection`, same plus-1
    /// convention). The postfix call arm seeds `fn_ptr_chain_depth`
    /// from it so `(*s.cb(x))(y)`-style chains decay instead of
    /// loading through the returned function pointer.
    pub fn_ptr_ret_indirection: i64,
    /// Parameter type tags of a function-pointer field, captured from
    /// the field declarator's prototype (mirrors `Symbol::params`).
    /// Empty for a non-function-pointer field or one declared without a
    /// prototype. A `s.fp(args)` / `s->fp(args)` call reads this to
    /// narrow each argument to its declared parameter type (C99
    /// 6.5.2.2p7), matching the direct-identifier and array-element
    /// call paths.
    pub params: Vec<i64>,
    /// True when the function-pointer field's prototype is variadic
    /// (`int (*fp)(int, ...)`). Mirrors `Symbol::is_variadic`. A
    /// `s.fp(args)` / `s->fp(args)` call reads this with `params` to
    /// split the argument list at the fixed-parameter count for the host
    /// variadic ABI. False for a non-function-pointer field or a
    /// non-variadic prototype.
    pub is_variadic: bool,
    /// Calling convention of the function a function-pointer field
    /// points to (`__attribute__((ms_abi))` / `((sysv_abi))`). Mirrors
    /// `Symbol::conv`; `CallConv::Target` for every other field. The
    /// EFI boot- and runtime-services tables declare their members this
    /// way, so a call through one has to marshal to that convention.
    pub(crate) conv: crate::c5::codegen::CallConv,
    /// Non-zero for a field promoted from an anonymous union (C11
    /// 6.7.2.1p13). All members of one anonymous union share the same
    /// value; the same id groups them so a brace-list initializer
    /// treats the whole union as a single positional sub-object
    /// (C99 6.7.8: one initializer fills the first member). Zero for a
    /// regular field and for anonymous-struct members, which keep
    /// distinct positions.
    pub anon_union_group: u32,
    /// Non-zero for a field promoted from an anonymous struct (C11
    /// 6.7.2.1p13). The members keep distinct positions, but the same id
    /// groups them so a brace-enclosed sub-initializer fills the whole
    /// anonymous struct in order (`union { struct { int a, b; }; ... } x =
    /// { { 1, 2 } }`). Zero for a regular field and for anonymous-union
    /// members, which the `anon_union_group` path handles.
    pub anon_struct_group: u32,
    /// Alignment requested for this field by an explicit
    /// `__attribute__((aligned(N)))` / `_Alignas(N)`, or 0 when the
    /// field sits at its type's natural alignment. `packed` drops a
    /// field's natural alignment but not an explicit request (GCC and
    /// clang both keep an `aligned(64)` member 64-aligned inside a
    /// packed struct), so the re-lay path needs the request preserved.
    pub explicit_align: u32,
    /// Alignment the layout placed this field at, including a
    /// typedef-carried `aligned(N)` the flat field type cannot express.
    /// `__alignof__` on a member lvalue reports it. 0 for bitfields.
    pub align: u32,
    /// How the member declaration spelled the type; see
    /// [`crate::c5::symbol::DeclSpelling`]. Debug info only.
    pub decl_spelling: crate::c5::symbol::DeclSpelling,
}

/// Optional preprocessor / driver knobs threaded through compiler
/// construction. Everything here has a sensible default (empty
/// vectors, empty label, tracing off); only callers that need to
/// pass `-D` / `-I` / `-include` / `-H` flags or a real source
/// filename for diagnostics have to fill any of these in.
///
/// Builder-style methods (`with_defines`, `with_undefines`,
/// `with_include_paths`, `with_force_includes`, `with_source_label`,
/// `with_track_includes`) return `self` so the typical CLI shape is
/// `CompileOptions::default().with_defines(d).with_include_paths(p)`.
#[derive(Default, Debug, Clone)]
pub struct CompileOptions {
    /// `-D name[=body]` predefines installed before the source
    /// runs through the preprocessor.
    pub defines: Vec<(String, String)>,
    /// `-U name` -- names removed from the predefines table.
    pub undefines: Vec<String>,
    /// `-I path` -- filesystem search paths probed before the
    /// bundled in-binary headers on `#include`.
    pub include_paths: Vec<String>,
    /// `-iquote path` -- search paths for `#include "..."` only,
    /// probed after the including file's directory and before the
    /// `-I` paths (gcc scope).
    pub quote_include_paths: Vec<String>,
    /// System header directories probed only after the bundled headers
    /// (the driver's implicit system include path for a hosted native
    /// build). A third-party header the embedded set lacks (`zlib.h`)
    /// resolves here without shadowing a standard header.
    pub system_include_paths: Vec<String>,
    /// On-disk copies of the compiler's own header set (the source
    /// tree's `libc/include`, `$BADC_HOME/include`). A bundled name
    /// found there replaces the in-binary body.
    pub own_header_roots: Vec<String>,
    /// `-nostdinc` -- the bundled standard headers and the system
    /// directories leave the `#include` search, so only `-I`, `-iquote`
    /// and the including file's directory resolve a name. The auto-include
    /// retry is off with it: a unit that asked for no library headers must
    /// not be given one. See [`Preprocessor::set_nostdinc`].
    pub nostdinc: bool,
    /// `-fno-builtin` / `-ffreestanding` -- a call spelled with a library
    /// function's own name is an ordinary call, not a builtin the compiler
    /// may fold. The `__builtin_` spellings keep folding, as they do under
    /// gcc's flag, and the auto-include retry is off with it: a
    /// freestanding unit has no library to declare the name from.
    pub no_builtin: bool,
    /// `-fno-builtin-<name>` -- the same, for one library name each.
    pub no_builtin_fns: Vec<String>,
    /// `-include FILE` -- headers force-included before the source.
    pub force_includes: Vec<String>,
    /// Filename string used in compiler diagnostics
    /// (`<file>:<line>: error: ...`). Empty for library / fixture
    /// callers; the preprocessor then falls back to the historical
    /// `<source>` placeholder.
    pub source_label: String,
    /// When true the preprocessor records one entry per `#include`
    /// resolve, readable via [`Compiler::include_trace`] (the `-H`
    /// rendering) and [`Compiler::include_records`] (the `-M`
    /// family's prerequisite source). Set by `-H` and by any
    /// dependency-output flag.
    pub track_includes: bool,
    /// The level each diagnostic reports at, as the `-W` family left
    /// it. The pragmas in the unit apply on top of this.
    pub diag: crate::c5::diag::Config,
    /// When true, [`Compiler::compile`] returns
    /// `Program { entry_pc: 0, entry_name: None, .. }`
    /// instead of erroring out on a missing `main` /
    /// `wmain` / `WinMain` / `wWinMain`. Set for `-c`
    /// builds where the resulting Program is fed to the
    /// relocatable codegen (no `_start` stub, no entry-point
    /// requirement -- the linker picks the entry once it
    /// merges every TU).
    pub no_entry_point: bool,
    /// When true, every non-static function defined in this unit is
    /// exported in addition to any named by `#pragma export`. Set for
    /// `--shared` builds so a runtime `dlopen` consumer can `dlsym` the
    /// module's entry points without source-level export pragmas,
    /// matching the default visibility of a system toolchain's shared
    /// library.
    pub export_all_functions: bool,
    /// `--gnu` -- when true the preprocessor defines the GCC identity
    /// macros (`__GNUC__` and the rest, via
    /// [`Preprocessor::enable_gnu`]). Off by default: badc implements
    /// most but not all of the GNU C surface, so it claims `__GNUC__`
    /// only when the caller opts in.
    pub gnu: bool,
    /// Function names an undeclared call may bind as a C89 6.3.2.2
    /// implicit `extern int name();` instead of triggering the
    /// auto-include retry. The driver fills this in a multi-TU build
    /// for auto-included names another input defines, so the user's
    /// definition wins over the header's library binding.
    pub implicit_extern_fns: Vec<String>,
    /// `-O` -- predefine `NDEBUG` and `__OPTIMIZE__`, both `1`, so a
    /// single flag selects release semantics (optimization passes plus
    /// asserts compiled out). Explicit `-D` / `-U` flags override.
    pub optimize: bool,
    /// `-fgnu89-inline` -- make [`InlineModel::Gnu89`] the unit's
    /// default inline linkage model instead of C99's, and predefine
    /// `__GNUC_GNU_INLINE__` in place of `__GNUC_STDC_INLINE__`.
    pub gnu89_inline: bool,
    /// `-fstrict-flex-arrays=N` -- which trailing array members
    /// `__builtin_object_size` treats as unbounded through a pointer:
    /// 0 (the default, as in gcc) every one, 1 those bounded `[]`,
    /// `[0]` or `[1]`, 2 those bounded `[]` or `[0]`, 3 only `[]`.
    pub strict_flex_arrays: u8,
    /// `-std=gnu*` -- the GNU dialect, which suppresses the
    /// `__STRICT_ANSI__` predefine `--gnu` otherwise installs, as in gcc
    /// and clang. Off by default: without `-std` badc reports strict
    /// conformance so a header takes its standard-C path for the GNU
    /// features badc lacks.
    pub gnu_dialect: bool,
    /// Assembler-with-cpp input (a `.S` unit). The preprocessor then
    /// passes a `#` line naming no directive through as text, as GNU
    /// cpp does for assembler input.
    pub asm_source: bool,
    /// Mirror of [`crate::NativeOptions::elf_class`]. The assembler's
    /// starting code mode follows it, the way `as --32` starts in
    /// 32-bit mode and `as --64` in 64-bit; a `.code16` / `.code32` /
    /// `.code64` directive overrides it from that point on. The
    /// preprocessor's data-model predefines follow it as well, as gcc's
    /// do under `-m16` / `-m32`.
    pub elf_class: crate::c5::ElfClass,
    /// Mirror of [`crate::NativeOptions::code_model`] (`-mcmodel`).
    /// The preprocessor's `__code_model_*__` predefine follows it.
    pub code_model: crate::c5::CodeModel,
    /// `-fshort-wchar` -- give `wchar_t` an unsigned 16-bit type on
    /// every target, which narrows `L"..."` / `L'...'` elements and the
    /// `__SIZEOF_WCHAR_T__` / `__WCHAR_TYPE__` predefines with it.
    pub short_wchar: bool,
    /// `-fsigned-char` / `-funsigned-char`, which C99 6.2.5p15 leaves to
    /// the implementation. `None` keeps the target ABI's own choice; see
    /// [`Self::plain_char_signed`], the sole resolution of the pair.
    pub char_signed: Option<bool>,
    /// `-ftrivial-auto-var-init=`: what an automatic object declared
    /// without an initializer holds on entry to its scope; see
    /// [`AutoVarInit`].
    pub auto_var_init: AutoVarInit,
}

/// `-ftrivial-auto-var-init=`: the initialization the compiler supplies
/// for an automatic object the program declares without an initializer
/// -- scalars, aggregates, arrays and variable-length arrays alike. The
/// store is emitted where the object's storage is established, so a
/// declaration reached by a jump past it (C99 6.8.6.1 `goto`, 6.8.4.2
/// `switch`) is not covered, as in gcc. An object carrying
/// `__attribute__((uninitialized))` or bound to a register by `asm` opts
/// out. Diagnostics and the `-O` promotion of the object are unchanged:
/// the supplied value is an ordinary initializer later stores overwrite.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
pub enum AutoVarInit {
    /// `uninitialized`: the storage holds whatever the frame held.
    #[default]
    Uninitialized,
    /// `zero`: every byte of the object is zero.
    Zero,
    /// `pattern`: every byte of the object is
    /// [`AUTO_VAR_INIT_PATTERN_BYTE`].
    Pattern,
}

/// The byte `AutoVarInit::Pattern` repeats over the object. gcc 16
/// stores `0xFE` for every type on both x86-64 and AArch64 (clang uses
/// a per-type pattern instead); the value is unlikely to be a valid
/// pointer or a small count and reads back as a negative integer.
pub const AUTO_VAR_INIT_PATTERN_BYTE: u8 = 0xFE;

impl AutoVarInit {
    /// The byte stored over an uninitialized object, `None` when the
    /// object is left as declared.
    pub(crate) fn fill_byte(self) -> Option<u8> {
        match self {
            Self::Uninitialized => None,
            Self::Zero => Some(0),
            Self::Pattern => Some(AUTO_VAR_INIT_PATTERN_BYTE),
        }
    }
}

impl CompileOptions {
    /// Enable the `--gnu` GCC identity predefines.
    pub fn with_gnu(mut self, gnu: bool) -> Self {
        self.gnu = gnu;
        self
    }
    /// ELF class of the object being produced; the assembler's
    /// starting code mode follows it.
    pub fn with_elf_class(mut self, class: crate::c5::ElfClass) -> Self {
        self.elf_class = class;
        self
    }
    /// x86-64 code model of the object being produced (`-mcmodel`).
    pub fn with_code_model(mut self, model: crate::c5::CodeModel) -> Self {
        self.code_model = model;
        self
    }
    /// Narrow `wchar_t` to an unsigned 16-bit type (`-fshort-wchar`).
    pub fn with_short_wchar(mut self, on: bool) -> Self {
        self.short_wchar = on;
        self
    }
    /// Initialize the automatic objects the program leaves
    /// uninitialized (`-ftrivial-auto-var-init=`).
    pub fn with_auto_var_init(mut self, mode: AutoVarInit) -> Self {
        self.auto_var_init = mode;
        self
    }
    /// Take the standard library headers off the `#include` search
    /// (`-nostdinc`).
    pub fn with_nostdinc(mut self, on: bool) -> Self {
        self.nostdinc = on;
        self
    }
    /// Stop treating a library function's own name as a builtin
    /// (`-fno-builtin` / `-ffreestanding`).
    pub fn with_no_builtin(mut self, on: bool) -> Self {
        self.no_builtin = on;
        self
    }
    /// The same for the named library functions (`-fno-builtin-<name>`).
    pub fn with_no_builtin_fns(mut self, names: Vec<String>) -> Self {
        self.no_builtin_fns = names;
        self
    }

    /// Select plain `char`'s signedness (`-fsigned-char` /
    /// `-funsigned-char`); `None` restores the target default.
    pub fn with_char_signed(mut self, signed: Option<bool>) -> Self {
        self.char_signed = signed;
        self
    }

    /// Whether plain `char` is signed in this unit: the target ABI's
    /// choice unless an explicit flag overrode it. Every site that
    /// depends on the signedness -- the `__CHAR_UNSIGNED__` predefine,
    /// `#if` character constants, the lexer's constant folding and the
    /// `char` type tag -- resolves it here.
    pub fn plain_char_signed(&self, target: Target) -> bool {
        self.char_signed
            .unwrap_or_else(|| target.plain_char_signed())
    }

    /// Mark the input as assembler-with-cpp (a `.S` unit).
    pub fn with_asm_source(mut self, on: bool) -> Self {
        self.asm_source = on;
        self
    }
    /// Select the GNU89 inline linkage model as the unit default
    /// (`-fgnu89-inline`).
    pub fn with_gnu89_inline(mut self, on: bool) -> Self {
        self.gnu89_inline = on;
        self
    }
    /// Select which trailing array members are flexible
    /// (`-fstrict-flex-arrays=N`).
    pub fn with_strict_flex_arrays(mut self, level: u8) -> Self {
        self.strict_flex_arrays = level;
        self
    }
    /// Select the GNU dialect (`-std=gnu*`) over strict ISO (`-std=c*`).
    pub fn with_gnu_dialect(mut self, on: bool) -> Self {
        self.gnu_dialect = on;
        self
    }
    /// Replace the `-D` predefine list.
    pub fn with_defines(mut self, defines: Vec<(String, String)>) -> Self {
        self.defines = defines;
        self
    }
    /// Replace the `-U` undefine list.
    pub fn with_undefines(mut self, undefines: Vec<String>) -> Self {
        self.undefines = undefines;
        self
    }
    /// Enable the `-O` predefines. See [`Self::optimize`].
    pub fn with_optimize(mut self, on: bool) -> Self {
        self.optimize = on;
        self
    }
    /// Replace the `-I` include-search-path list.
    pub fn with_include_paths(mut self, include_paths: Vec<String>) -> Self {
        self.include_paths = include_paths;
        self
    }
    /// Replace the `-iquote` (quoted-include-only) search-path list.
    pub fn with_quote_include_paths(mut self, paths: Vec<String>) -> Self {
        self.quote_include_paths = paths;
        self
    }
    /// Replace the system header directories (probed after the bundled
    /// headers).
    pub fn with_system_include_paths(mut self, paths: Vec<String>) -> Self {
        self.system_include_paths = paths;
        self
    }
    /// Replace the on-disk overlay roots of the compiler's own headers.
    pub fn with_own_header_roots(mut self, paths: Vec<String>) -> Self {
        self.own_header_roots = paths;
        self
    }
    /// Replace the `-include FILE` force-include list.
    pub fn with_force_includes(mut self, force_includes: Vec<String>) -> Self {
        self.force_includes = force_includes;
        self
    }
    /// Set the source-file label used in diagnostics.
    pub fn with_source_label(mut self, label: impl Into<String>) -> Self {
        self.source_label = label.into();
        self
    }
    /// Flip include tracking on or off. See [`Self::track_includes`].
    pub fn with_track_includes(mut self, on: bool) -> Self {
        self.track_includes = on;
        self
    }
    /// Install the levels the `-W` family selected. See
    /// [`Self::diag`].
    pub fn with_diag(mut self, config: crate::c5::diag::Config) -> Self {
        self.diag = config;
        self
    }
    /// Export every non-static function. See
    /// [`Self::export_all_functions`].
    pub fn with_export_all_functions(mut self, on: bool) -> Self {
        self.export_all_functions = on;
        self
    }
    /// Drop the "must define main" requirement. Returns a
    /// `Program` with `entry_pc = 0` / `entry_name = None`
    /// when no entry function is defined, instead of erroring.
    /// Used by the relocatable `-c` path where the entry is a
    /// link-time decision.
    pub fn with_no_entry_point(mut self, on: bool) -> Self {
        self.no_entry_point = on;
        self
    }
    /// Replace the implicit-extern function-name list. See
    /// [`Self::implicit_extern_fns`].
    pub fn with_implicit_extern_fns(mut self, names: Vec<String>) -> Self {
        self.implicit_extern_fns = names;
        self
    }
}

/// Ephemeral side-channel state passed between parser layers --
/// the "stuff a deeper parse needs to relay back to its caller
/// without bloating its return type." Groups the
/// declarator-handoff flags, the multi-dim subscript stride
/// queue, the array-decay sizeof recovery channel, and the
/// function-pointer chain-depth tracker into one carrier so the
/// `Compiler` field list reads as "lexer + symbols + codegen
/// output + transient state" instead of eleven loose fields.
/// Sentinel `array_size` for a C99 6.7.6.2 variable-length array
/// declarator: distinct from `0` (scalar), `> 0` (constant array),
/// and `-1` (deferred / flexible `T x[]`). The dimension expression
/// rides on `Pending::vla_dim_expr`.
pub(in crate::c5::compiler) const VLA_ARRAY_SIZE: i64 = -2;

#[derive(Debug)]
pub(in crate::c5::compiler) struct Pending {
    /// Side channel from the base-type parsers
    /// (`parse_decl_base_type`, the inline base-type loop in
    /// `run_compile`, and `parse_aggregate_body`) to the
    /// function-decl path: set to `true` when the just-consumed
    /// base spelled bare `void`, `false` otherwise. The type
    /// encoding itself collapses both `void` and `char` to
    /// `Ty::Char | UNSIGNED_BIT` (so `void *` arithmetic,
    /// sizeof, struct-field layout, and function-pointer
    /// encoding stay byte-identical to the legacy void-as-char
    /// behavior); the void-ness is carried out-of-band here.
    /// Cleared at the start of every base-type parse and
    /// consumed by the function-decl path right after
    /// `parse_declarator` returns -- `returns_void` on the
    /// function's symbol is set when the flag is true *and* the
    /// declarator added no leading `*`s.
    pub base_was_void: bool,

    /// Side channel from `parse_decl_base_type`: the base specifiers
    /// included a `const` qualifier. The declaration path reads it to mark
    /// a plain integer-scalar object `const`-qualified so a later constant
    /// expression can fold its value (C99 6.6 leaves this to the
    /// implementation; GCC and common practice fold `const int N = ...`).
    pub base_is_const: bool,

    /// Side channel from `parse_decl_base_type`: the base specifiers
    /// included `restrict`, and the symbol-table index of the typedef
    /// they named the base type through. Debug info only -- nothing
    /// else reads either, so neither reaching a declaration it does
    /// not belong to can change generated code.
    pub spell_base_const: bool,
    pub spell_base_restrict: bool,
    pub spell_base_typedef: Option<u32>,

    /// Side channel from `parse_decl_base_type` to the function-
    /// prototype path: the base type was spelled `long double`,
    /// not bare `double`. Cleared at the start of every base-type
    /// parse. The function-decl path consumes this when stamping
    /// a libc binding so the codegen knows to read the return
    /// value out of x87 `st(0)` on SysV x86_64 (long-double libc
    /// returns) instead of XMM0 (which carries double / float).
    /// The encoded type stays `Ty::Double` for storage so the
    /// rest of the compiler treats the value as an 8-byte double;
    /// the distinction is libc-ABI-only.
    pub base_was_long_double: bool,

    /// Side channel from `parse_declarator` to `run_compile`: when
    /// the declarator's nested-paren branch encounters a "function
    /// returning function pointer" shape (`T (*name(args1))(args2)`),
    /// it parses `args1` via `parse_function_params` and stashes
    /// them here so the caller can bind `name` as a function and
    /// continue with the body. `args2` is consumed as a no-op via
    /// the trailing-decoration loop. None when the declarator
    /// wasn't this shape.
    pub fn_params: Option<function::ParsedParams>,

    /// Side channel from `parse_declarator` to its caller: when
    /// the declarator was function-pointer-shaped, this is the
    /// number of pointer levels between the resulting variable's
    /// loaded value and the underlying fn-pointer rvalue, plus 1
    /// (matching `Symbol::fn_ptr_indirection`'s convention).
    /// `None` when the declarator wasn't fn-pointer-shaped, so
    /// the caller doesn't have to clear a stale value before
    /// each parse. The caller takes() the value when binding the
    /// symbol.
    pub fn_ptr_indirection: Option<i64>,

    /// Companion to `fn_ptr_indirection`: fn-pointer lineage of the
    /// value a call through the declared pointer returns, in the same
    /// plus-1 convention (0 = no lineage, 1 = the result IS a fn
    /// pointer). Set by `parse_declarator` when signature-bearing
    /// declarator groups enclose the innermost one
    /// (`int (*(*p)(int))(int)` records indirection 1, return
    /// lineage 1), taken alongside `fn_ptr_indirection`.
    pub fn_ptr_ret_indirection: i64,

    /// Set by a `parse_declarator` frame whose parenthesised group
    /// carried its own function signature; the enclosing frame takes it
    /// after the nested recursion to learn the fn-pointer lineage was
    /// already fixed by an inner group, so the enclosing pointer levels
    /// belong to the return type (`fn_ptr_ret_indirection`), not to
    /// `fn_ptr_indirection`.
    pub fn_ptr_group_resolved: bool,

    /// Set when the base type of the declarator currently being parsed
    /// came from a function-TYPE typedef (`typedef RET F(args)`), so the
    /// declarator absorbs the first `*` (it forms the pointer-to-function
    /// the typedef already half-encodes). Consumed and cleared by
    /// `parse_declarator`.
    pub base_is_function_type: bool,

    /// Set by `parse_declarator` when the declared identifier has a bare
    /// function type: the base came from a function-TYPE typedef and no
    /// pointer level was added (`F name`, not `F *name`). Per C99 6.9.1 such
    /// an identifier is a function declaration, not a function-pointer object.
    /// Read once by the file-scope declaration path.
    pub bare_function_type_declarator: bool,

    /// Override stride for the next `[i]` postfix index. When we
    /// load the address of a 2D-array variable (`T xs[N][M]`),
    /// the first subscript should scale the index by
    /// `M * sizeof(T)`, not `sizeof(T)`. The expr() identifier
    /// branch sets this to `inner_array_size * sizeof(elem)` on a
    /// 2D-array decay; the Brak postfix handler reads-and-clears
    /// it before falling back to the regular pointer-arithmetic
    /// stride. Zero means "use the regular stride."
    pub index_stride: i64,

    /// Strides for the *remaining* subscript levels of an N-dim
    /// array (N >= 3), beyond the first one held in
    /// `index_stride`. For `T xs[A][B][C]` after the
    /// `xs` decay the levels are: first = `B*C*sizeof(T)`
    /// (in `index_stride`), then `C*sizeof(T)` (in this
    /// vec), then the regular `sizeof(T)` fall-through. Each
    /// Brak postfix consumes one stride and shifts the rest
    /// down. Empty means "no further multi-dim strides queued."
    pub index_strides_tail: Vec<i64>,

    /// Snapshot of the multi-dim stride queue taken at the bottom
    /// of every `expr()` -- just before the defensive clear
    /// runs. Lets an outer operator that ran a recursive `expr()`
    /// (notably unary `*` on a pointer-to-array operand)
    /// recover what the inner parse seeded but nothing
    /// consumed. Reset to zero on the next `expr()` exit, so
    /// the inspector window is one operator deep.
    pub end_of_expr_stride: i64,
    pub end_of_expr_strides_tail: Vec<i64>,

    /// Inner dimensions (below the outermost) for the next
    /// `collect_array_initializer` call, outermost first. Set by
    /// callers from the declarator's `array_dims[1..]` so a nested
    /// `{ ... }` at each level can be zero-padded to the element count
    /// its sub-array spans (the product of the dimensions below it),
    /// keeping every level on the right stride for N-dim arrays. Empty
    /// means "flatten without padding" (1D arrays, struct-array
    /// initializers that own their layout). The collector reads-and-
    /// clears this on entry and reinstates the tail before recursing
    /// into a nested brace.
    pub init_inner_dims: alloc::vec::Vec<i64>,

    /// Target array bound for the next `collect_array_initializer`
    /// call. Set by callers that know the declarator's `[N]` so
    /// the string-literal branch can drop the trailing NUL when
    /// the literal would otherwise overflow by exactly one byte
    /// per C99 6.7.8p14. Zero means "no bound" (deferred-size
    /// array). Read-and-cleared on entry.
    pub init_target_array_size: i64,

    /// Set whenever the most recent `expr()` step ended with an
    /// array-decay-to-pointer (a bare array variable, or a
    /// struct field whose declared shape is `T xs[N]`). Carries
    /// the array's element count so `sizeof(<expr>)` can return
    /// `array_size * sizeof(elem)` instead of the decayed
    /// pointer's `sizeof(T*) = 8`. Cleared at the top of every
    /// `expr()` call so a previous decay doesn't leak into an
    /// unrelated sizeof.
    /// Side channel from the base-type parsers to the declarator-
    /// binding sites: when the base type was a typedef whose
    /// alias resolved to an array, this carries the typedef's
    /// element count so the bound declarator can inherit the
    /// array-ness. C99 6.7.7 paragraph 3: a typedef name
    /// "denotes the same type" as its aliased type, including
    /// the array length. Cleared by every base-type parse
    /// (`0` means "not from an array typedef").
    pub typedef_base_array_size: i64,
    /// Dimension list (outermost first) accompanying
    /// `typedef_base_array_size` when the typedef alias is a
    /// multi-dimensional array; empty for a 1-D alias. Written by the
    /// same three base-type sites that set the element count and only
    /// meaningful while that count is non-zero, so the count's
    /// clear-discipline covers this field too.
    pub typedef_base_array_dims: alloc::vec::Vec<i64>,
    /// Set alongside `typedef_base_array_size == -1` when the alias is a
    /// zero-length array (`typedef T A[0]`) rather than an incomplete
    /// one (`typedef T A[]`). Both carry the same `-1` count and both
    /// occupy no storage; only the zero-length form is a complete type,
    /// so `sizeof` through it is 0 instead of a diagnostic.
    pub typedef_base_zero_len: bool,
    /// Count of leading `*` levels the most recent declarator added.
    /// A use of an array typedef folds the typedef's dimension onto the
    /// object (`typedef T A[N]; A x;` -> `x` is `T[N]`) unless the
    /// declarator turned it into a pointer (`A *p` -> pointer to `T[N]`);
    /// that is `> 0` here, distinct from the typedef's own element type
    /// being a pointer (`typedef T *A[N]; A x;` still folds).
    pub declarator_leading_ptr_count: i64,
    /// Whether a `const` follows the declarator's outermost `*`
    /// (`T *const p`, `T *const a[]`). That qualifier applies to the
    /// declared object itself, unlike a `const` in the specifiers of a
    /// pointer declaration (`const T *p`), which applies to the pointee.
    pub declarator_outer_const: bool,
    /// `declarator_outer_const` for `restrict` (`T *restrict p`).
    /// Debug info only.
    pub declarator_outer_restrict: bool,
    /// Set true while parsing a block-scope object declarator, where
    /// a non-constant array dimension is a C99 6.7.6.2 variable-length
    /// array. Elsewhere (file scope, struct member, typedef, cast,
    /// sizeof) a non-constant dimension is a constraint violation.
    pub vla_allowed: bool,
    /// The declarator's parsed VLA dimension expression, set when the
    /// leading `[expr]` was non-constant and `vla_allowed`. `None` for
    /// a constant-dimension array. Consumed by the local-decl site.
    pub vla_dim_expr: Option<crate::c5::ast::ExprId>,
    /// True when the declarator's leading dimension was spelled `[0]`.
    /// Both `T x[0]` and `T x[]` reach the object allocators as
    /// `array_size == -1`, but they declare different objects: `[0]` is
    /// a complete GNU zero-length array (`sizeof` 0, no elements), while
    /// empty brackets leave the type incomplete until an initializer or
    /// C99 6.9.2p2 completion supplies a count. Written by the array
    /// declarator, read by the object allocators.
    pub declarator_zero_len_array: bool,
    /// Set by `sizeof_operand_bytes` to the VLA's runtime-byte-count
    /// slot when the operand is a variable-length array (C99
    /// 6.5.3.4p2); the `sizeof` site then emits a runtime load instead
    /// of a constant. `None` for a constant-size operand.
    pub sizeof_vla_size_slot: Option<i64>,
    /// Set by the constant-expression evaluator when it fails because it
    /// reached a non-constant operand (a runtime identifier, call, ...),
    /// as opposed to a malformed constant (division by zero, ...). Lets
    /// the array-declarator distinguish a C99 6.7.6.2 VLA dimension from
    /// a genuine constant-expression error that must be diagnosed.
    pub const_expr_nonconst: bool,
    /// Set by the constant-expression evaluator when a fold consumed a
    /// compound literal, which denotes an object (C99 6.5.2.5p4) rather
    /// than a value; `__builtin_constant_p` answers 0 for such an operand.
    pub const_expr_compound_literal: bool,
    /// Binding-site carrier for a function-pointer typedef's
    /// prototype: `Some((fixed_param_count, is_variadic))` when the
    /// base type was a typedef whose alias is a function-pointer
    /// type. A variable declared `fn_ptr_t cb` inherits the
    /// callee's variadic-ness and named-parameter count so an
    /// indirect call through `cb` can split its arguments into the
    /// fixed register prefix and the variadic stack tail (the macOS
    /// arm64 variadic ABI). `None` for non-fn-pointer base types.
    /// Cleared by every base-type parse.
    pub typedef_fn_proto: Option<(usize, bool)>,
    /// The pointed-to function's parameter type tags, captured by the
    /// fn-pointer declarator alongside `typedef_fn_proto`. Lets an
    /// indirect call narrow each argument to its declared parameter type
    /// instead of applying the default argument promotions. `None` when
    /// the prototype carries no types (an empty parameter list).
    pub fn_ptr_param_types: Option<alloc::vec::Vec<i64>>,
    /// Parameter type tags of the function pointer that an in-progress
    /// postfix indirect call (`tbl[i](args)`, `(*fp)(args)`) will call.
    /// The flat type tag in the accumulator carries only the callee's
    /// return type, not its parameter list, so this side-channel ferries
    /// the parameters from the producing symbol (a function-pointer array
    /// element or a dereferenced function-pointer variable) to the call's
    /// argument loop, which narrows each argument to its declared type
    /// (C99 6.5.2.2p7) the same way the direct-identifier call path does.
    /// Set at the array-decay and identifier-load sites, preserved across
    /// a subscript index parse, cleared at a `.`/`->` field access and at
    /// each statement boundary so it cannot reach an unrelated call.
    pub indirect_callee_params: Option<alloc::vec::Vec<i64>>,
    /// True when the indirect callee whose parameter types are held in
    /// `indirect_callee_params` is variadic. Threaded alongside the
    /// parameter list so an indirect variadic call recovers the
    /// pre-ellipsis (fixed) argument count and places the variadic tail
    /// per the host variadic ABI (C99 6.5.2.2; the macOS/AAPCS64 Darwin
    /// variant passes the tail on the stack). Set and cleared at the same
    /// sites as `indirect_callee_params`.
    pub indirect_callee_is_variadic: bool,
    /// Calling convention of the function `indirect_callee_params`
    /// describes (`__attribute__((ms_abi))` / `((sysv_abi))`). Set and
    /// cleared at the same sites as `indirect_callee_params`; the call
    /// arm records it on the callee `ExprId` so the walker can pick the
    /// convention long after the declaration went out of scope.
    pub indirect_callee_conv: crate::c5::codegen::CallConv,
    /// Pointer depth of the value whose prototype is held in
    /// `indirect_callee_params`, in `Symbol::fn_ptr_indirection`'s
    /// convention (1: the value is the function pointer). Threaded at the
    /// same sites; `typeof` reads it to spell the operand's indirection.
    pub indirect_callee_fn_ptr_depth: i64,
    /// Fn-pointer lineage of the indirect callee's return value, in the
    /// same plus-1 convention (`Symbol::fn_ptr_ret_indirection`).
    /// Threaded at the same sites; the postfix call arm takes it to
    /// seed `fn_ptr_chain_depth` when the call result is itself a
    /// function pointer, matching the direct-call arm.
    pub indirect_callee_ret_fn_ptr: i64,
    /// Signature of the last completed function-pointer cast: (cast
    /// result tag, parameter types, variadic, pointer depth). The flat
    /// tag carries only the return type, so `typeof(<cast>)` recovers
    /// the prototype from here, keyed to the cast node so a larger
    /// operand does not inherit it. Taken by
    /// `parse_unevaluated_expr_ty`.
    pub last_fn_ptr_cast: Option<(i64, alloc::vec::Vec<i64>, bool, i64)>,
    /// Set while parsing a function-pointer declarator's parameter list.
    /// The parameters form a prototype: their names are irrelevant, so
    /// `parse_function_params` records each type without binding the name
    /// (a named parameter that shadows an enclosing function's parameter --
    /// a callback type nested in another prototype -- must not trip the
    /// duplicate-parameter check).
    pub parsing_fn_ptr_proto: bool,
    /// Set while parsing a struct/union member's declarator, carrying the
    /// member identifier's pre-declarator symbol entry. C99 6.2.3 puts
    /// members in their own name space, but the declarator parser writes
    /// the shared symbol slot (class, type, array shape); the aggregate
    /// path restores this snapshot so an object of the same name keeps its
    /// own declaration.
    pub member_decl_save: Option<(usize, alloc::boxed::Box<crate::c5::symbol::Symbol>)>,
    pub in_member_declarator: bool,
    /// Array shape (`inner_array_size`, `array_dims`) the identifier a
    /// declarator just bound carried before that declarator overwrote it.
    /// The scope save runs after the declarator, so it would otherwise
    /// record the new binding's shape as the outer one's (C99 6.2.1p4).
    /// Taken by `shadow_symbol` / `capture_block_shadow` for that symbol.
    pub declarator_prior_shape: Option<(usize, i64, alloc::vec::Vec<i64>)>,
    /// Set by `parse_function_params` immediately before the per-parameter
    /// `parse_declarator` call and taken (cleared) at the top of that call,
    /// so it applies only to the parameter's own declarator and not to any
    /// nested one. In parameter position a function-typed declarator
    /// `RET (name)(args)` decays to a pointer to function (C99 6.7.5.3p8),
    /// the same as `RET (*name)(args)`.
    pub param_decl_context: bool,
    pub last_array_decay_size: i64,

    /// Full dimension list of the array expression that most recently
    /// decayed to a pointer at an identifier load. `&arr` reads it to
    /// rebuild the pointer-to-array aggregate for a multi-dimensional
    /// array (C99 6.5.3.2p3), where `last_array_decay_size` holds only
    /// the outermost dimension. Cleared the same way so it doesn't leak.
    pub last_array_decay_dims: alloc::vec::Vec<i64>,

    /// Set by `parse_typeof_specifier` to true when its operand was an
    /// array type (a bare array expression or an array-shaped type name).
    /// `__builtin_types_compatible_p` reads it so `typeof(arr)` compares
    /// unequal to `typeof(&arr[0])` (C99 6.7.6.2 array vs pointer), which
    /// the flat type system otherwise collapses through array-to-pointer
    /// decay. Consumed and reset by each `parse_generic_type_name` reader.
    pub typeof_operand_was_array: bool,

    /// Element count of a 1D array expression operand of `typeof`,
    /// captured before the unevaluated parse restores the decay
    /// markers. `parse_typeof_specifier` moves it onto
    /// `typedef_base_array_size` so a declarator through the specifier
    /// gets the dimension, mirroring an array typedef base.
    pub typeof_operand_array_size: i64,

    /// Byte width of a `typeof` operand that decayed to the element
    /// pointer with only the row size recorded (a pointer-to-array
    /// deref `*p`, a string literal, or a 1D row of a multi-dim
    /// subscript). Captured only when the row is 1D-reducible (no
    /// pending multi-dim stride); `parse_typeof_specifier` recovers the
    /// element count as `bytes / sizeof(elem)` so `typeof(*p)` is the
    /// array type rather than the decayed element pointer.
    pub typeof_operand_array_bytes: i64,

    /// Exact dimensions of a `typeof` operand that decayed from an
    /// array whose full shape is known (a pointer-to-array deref / row
    /// select, or a zero-length array). Outermost first; -1 marks an
    /// unspecified bound and 0 a zero-length one, matching the type-name
    /// dims encoding. Preferred over the count / byte channels, which
    /// cannot express those bounds or a multi-dimensional row.
    pub typeof_operand_array_dims: alloc::vec::Vec<i64>,

    /// Companion to `last_array_decay_size` for cases where the
    /// row's byte size is known directly but its shape can't be
    /// reduced to a single `count * sizeof(elem_ty)` pair --
    /// concretely, multi-dim subscripts of a pointer-to-array
    /// like `T (*p)[A][B]; sizeof(p[0])`. The Brak postfix
    /// handler stashes the consumed `multi_dim_stride` here so
    /// `sizeof` can return the whole row size. Cleared the same
    /// way as `last_array_decay_size` so it doesn't leak.
    pub last_array_decay_bytes: i64,

    /// The array member the trailing decay came from, for
    /// `__builtin_object_size`; cleared with `last_array_decay_size`.
    pub last_array_decay_member: Option<ArrayMember>,

    /// The object a struct-valued identifier or member load left in the
    /// accumulator, read by the next `.` step. Taken at the top of every
    /// postfix step and cleared at the end of `expr`, so it never
    /// outlives the step that set it.
    pub member_base: Option<MemberBase>,

    /// Depth from the value currently in the accumulator down to
    /// a function-pointer rvalue, or -1 if the running expression
    /// has no function-pointer lineage. Concretely:
    ///
    ///   * 0  -- value IS a fn pointer; one more unary `*` is the
    ///           C function-pointer-decay no-op.
    ///   * N>0 -- N more derefs to reach the fn pointer.
    ///   * -1 -- not in a fn-ptr-tracked chain; existing behavior.
    ///
    /// Seeded by the identifier-load path from
    /// `Symbol::fn_ptr_indirection` and updated by unary `*` /
    /// `&`. Cleared by `mark_emit_other` so any unrelated emit
    /// invalidates the trace; identifier loads and `*` re-set it
    /// when applicable. Used to suppress the spurious `Li` that
    /// the existing unary `*` handler would emit when chasing a
    /// function pointer whose return type is itself a pointer
    /// (so the post-`*` type still satisfies `is_pointer_ty` and
    /// the call-site fallback can't fire).
    pub fn_ptr_chain_depth: i64,

    /// True when `fn_ptr_chain_depth` describes an array's *element*
    /// rather than the value in hand: an array of function pointers
    /// decays to a pointer to one, and the decay seeds the depth from
    /// the element so `(*arr[i])(...)` still sees the 6.3.2.1p4 no-op.
    /// Cleared with `fn_ptr_chain_depth`.
    pub fn_ptr_depth_is_array_elem: bool,

    /// Symbol index of the Token::Loc whose value was loaded by
    /// the most recently emitted scalar load (`LoadKind::I64` /
    /// `LoadKind::U8` / `LoadKind::I16` / `LoadKind::I32`, or the fused local-load
    /// shorthand) in the identifier-rvalue path. The
    /// assignment / address-of
    /// callers consult this when they pop or rewrite that
    /// trailing load: if the load is removed before the
    /// program text is finalised, the symbol's was_read flag
    /// must be reverted to its prior state -- the load never
    /// ran, but the symbol may still have been read by an
    /// earlier expression. Cleared by `mark_emit_scalar_load`
    /// whenever a scalar load lands at the tail through a path
    /// that is not the identifier-rvalue branch (field access,
    /// array indexing, deref, bitfield extraction) so a downstream
    /// pop/rewrite does not retract was_read from a symbol
    /// whose load is no longer trailing.
    pub last_loaded_local: Option<usize>,

    /// `was_read` value the most recently parsed identifier
    /// load saw on the symbol immediately before flipping it
    /// to true. Captured in lockstep with `last_loaded_local`
    /// so `take_last_loaded_local` can restore the prior state
    /// when the load gets popped or rewritten -- preserving
    /// reads recorded by earlier expressions in the function.
    pub last_loaded_local_prior_was_read: bool,

    /// `pending_stores` value the most recently parsed
    /// identifier load saw on the symbol immediately before
    /// clearing it. Captured in lockstep with
    /// `last_loaded_local` so a tentative load that the
    /// surrounding assignment / address-of rewrites does not
    /// permanently drop the dead-store entries -- they restore
    /// alongside `was_read`.
    pub last_loaded_local_prior_pending: Vec<usize>,

    /// AST id of the rhs expression that the bitfield write path
    /// (`emit_bitfield_access`'s Assign branch) just parsed. The
    /// storage emit the same routine produces afterwards triggers
    /// `ast_apply_assign`, which clears `ast_acc` -- so the
    /// caller can't observe the rhs from `ast_acc`. Captured
    /// here before the store runs and read by the Member handler
    /// in `expr.rs` to build `Expr::BitfieldAssign`. `None`
    /// outside the bitfield-assign window.
    pub bf_assign_rhs: Option<crate::c5::ast::ExprId>,
    /// Compound-assignment counterpart of `bf_assign_rhs`. Holds
    /// `(rhs_ast_id, op)` where `op` is the binary operator the
    /// assignment expanded to. The Member handler reads this and
    /// builds `Expr::BitfieldAssign { rhs: Binop(read, op, rhs) }`
    /// per C99 6.5.16.2 (`E1 OP= E2` == `E1 = E1 OP E2`).
    pub bf_compound_assign: Option<(crate::c5::ast::ExprId, crate::c5::ir::BinOp)>,

    /// True while the trailing emit is an indirect-call shape
    /// (the indirect-call tag, optionally followed by a
    /// stack-arg cleanup). Set at the indirect-call site,
    /// preserved across the matching cleanup, cleared by any
    /// other emit. Read by
    /// `Self::last_emit_was_indirect_call` to suppress the
    /// type-warning on `T x = fp();` shapes where c5 can't see
    /// the callee's return type.
    pub last_emit_was_indirect_call: bool,

    /// True while the trailing emit is a literal-zero integer
    /// immediate. Set by `emit_imm(0)`, cleared by every other
    /// emit. Read by
    /// `Self::last_emit_is_zero` to suppress the NULL-idiom
    /// warning on `pointer = 0`.
    pub last_imm_was_zero: bool,

    /// Number of grouping parentheses stripped from around a compound
    /// literal by `skip_opt_compound_literal_cast` (`((T){...})`,
    /// C99 6.5.1/6.5.2.5). The aggregate-initializer dispatch consumes
    /// this many closing `)` after the literal's brace list. 0 when the
    /// literal carried no surrounding parentheses.
    pub compound_lit_close_parens: i64,

    /// Side channel from `skip_attribute_specifiers`: set true when a
    /// consumed attribute named `unused` / `maybe_unused` (C23
    /// 6.7.12.4 `[[maybe_unused]]` or GNU `__attribute__((unused))`).
    /// Read by `parse_block_stmt` right after the leading-attribute
    /// skip to mark the declared locals so their unused-variable
    /// diagnostics are suppressed.
    pub attr_maybe_unused: bool,
    /// Side channel from `skip_attribute_specifiers`: true when the most
    /// recent run named `transparent_union`, false otherwise (every run
    /// rewrites it). Consumed by the aggregate and typedef paths.
    pub attr_transparent_union: bool,
    /// Requested object alignment from `_Alignas(N)` /
    /// `__attribute__((aligned(N)))` / `__declspec(align(N))`, 0 when
    /// absent. The declaration parse takes it: file-scope objects
    /// honor up to 16, anything larger (or an automatic object above
    /// the 8-byte slot alignment) is a diagnostic, never silent.
    pub attr_align: i64,
    /// The `_Alignas(N)` share of `attr_align`, 0 when the request came
    /// only from `__attribute__((aligned(N)))` / `__declspec(align(N))`.
    /// C11 6.7.5 makes `_Alignas` raise-only and an alignment below the
    /// type's a constraint violation, where a variable-level GNU
    /// `aligned(N)` sets the object's alignment and may lower it.
    pub attr_alignas: i64,
    /// Alignment (bytes) carried by the base type of the declaration
    /// under parse, from a typedef whose type has a GNU
    /// `aligned(N)` attribute. Distinct from `attr_align` (an object /
    /// member `_Alignas`, raise-only): a type attribute sets the
    /// alignment and may lower it below the natural value, so the
    /// struct-field layout uses it to replace the field's natural
    /// alignment rather than raising it. Seeded when a typedef-name
    /// resolves as a base type; 0 for a type with natural alignment.
    pub type_align: i64,
    /// `__attribute__((packed))` seen on the declarator being parsed.
    /// A struct member takes it to clamp that field's alignment to 1
    /// (GCC member-level packed), independent of a struct-level `packed`.
    /// Recorded here because the trailing member attribute is consumed
    /// inside the declarator parse, not by the aggregate field loop.
    pub attr_packed: bool,
    /// `__attribute__((vector_size(N)))` byte width, 0 when absent. The base
    /// type of the declaration is rebuilt into a GCC vector type of `N /
    /// sizeof(element)` lanes (modeled as an N-byte aggregate).
    pub attr_vector_size: i64,
    /// `__attribute__((mode(M)))`: the machine mode the declaration's type
    /// is rewritten to, as `(bytes, is_float)`. `None` when absent. GCC
    /// applies it to the base type of an enum and to the declared type of
    /// an object, member, or typedef alias.
    pub attr_mode: Option<(u8, bool)>,
    /// A consumed `__declspec(thread)`. Read by the declaration parse to mark
    /// the declared object thread-local (the storage class `_Thread_local`
    /// reaches the same flag through the keyword path).
    pub attr_thread_local: bool,
    /// A consumed `__declspec(dllexport)`. Read after the declarator to add the
    /// declared name to the export list -- the equivalent of `#pragma export`.
    pub attr_dllexport: bool,
    /// A consumed `__attribute__((constructor))`. Merged onto
    /// `Symbol::is_constructor`, which the function-body open reads to
    /// record the function in `Compiler::init_funcs`.
    pub attr_constructor: bool,
    /// A consumed `__attribute__((destructor))`.
    pub attr_destructor: bool,
    /// Explicit priority from `constructor(N)` / `destructor(N)`; `None`
    /// for the bare form. Applies to whichever of the two above is set.
    pub attr_init_priority: Option<u32>,
    /// A consumed `__attribute__((cleanup(fn)))`: the symbol index of the
    /// cleanup function. Read where a local is bound to register a call to
    /// `fn(&var)` at every exit from the variable's scope (C99 has no such
    /// feature; this is the GCC/Clang extension that scope-guard and
    /// auto-cleanup idioms rely on).
    pub attr_cleanup: Option<usize>,
    /// A consumed `__attribute__((uninitialized))`: the declared
    /// automatic object is left out of `-ftrivial-auto-var-init`.
    pub attr_uninitialized: bool,
    /// A consumed `__attribute__((weak))`: the declared symbol binds
    /// STB_WEAK in the object's symbol table.
    pub attr_weak: bool,
    /// A consumed `__attribute__((ms_abi))` / `((sysv_abi))`: the
    /// calling convention of the function (or pointed-to function)
    /// being declared. Already normalised against the target, so
    /// `CallConv::Target` means "the target's own", including on a
    /// target where the attribute is inert.
    pub attr_call_conv: crate::c5::codegen::CallConv,
    /// A consumed `__attribute__((used))`: keep the definition in the
    /// object even when nothing in the unit references it.
    pub attr_used: bool,
    /// A consumed `__attribute__((visibility(...)))`: `Some(true)` for
    /// `"hidden"` / `"internal"` -- the declared symbol is not preemptible,
    /// marked STV_HIDDEN and addressed PC-relative directly rather than
    /// through the GOT -- and `Some(false)` for the preemptible spellings.
    /// `None` leaves the choice to the `#pragma GCC visibility` extent the
    /// declaration sits in.
    pub attr_visibility: Option<bool>,
    /// A consumed `__attribute__((section("name")))`: the named object
    /// section the declared symbol's bytes go to.
    pub attr_section: Option<alloc::string::String>,
    /// A consumed `__attribute__((patchable_function_entry(N, M)))`.
    pub attr_patchable_entry: Option<(u32, u32)>,
    /// A consumed `__attribute__((no_instrument_function))`.
    pub attr_no_instrument: bool,
    /// A consumed `__attribute__((alias("target")))`: the declared name
    /// is an additional symbol for `target`.
    pub attr_alias: Option<alloc::string::String>,
    /// A consumed `register` storage-class specifier. Gates the GNU
    /// explicit-register `asm("reg")` declarator suffix; a plain
    /// `register` without the suffix stays the historical no-op hint.
    pub saw_register_storage: bool,
    /// Set by an `__auto_type` base-type parse: the declaration must
    /// hold exactly one declarator, so the declarator loop rejects a
    /// `,` while this is set. Cleared when the declaration ends.
    pub auto_type_single_declarator: bool,
}

/// The declaration-specifier carriers of an enclosing, still-open
/// declaration, detached while a nested statement block parses (a GNU
/// statement expression in a `typeof` operand or an initializer). The
/// block's own declarations reset or consume these fields on entry, so
/// without the detach the enclosing declaration would read the inner
/// declaration's state -- e.g. `register typeof(({...})) v asm("reg")`
/// losing its storage class.
pub(super) struct DeclSpecifiers {
    saw_register_storage: bool,
    base_is_const: bool,
    attr_used: bool,
    attr_weak: bool,
    attr_call_conv: crate::c5::codegen::CallConv,
    attr_visibility: Option<bool>,
    attr_section: Option<alloc::string::String>,
    attr_patchable_entry: Option<(u32, u32)>,
    attr_no_instrument: bool,
    attr_cleanup: Option<usize>,
    attr_uninitialized: bool,
    attr_align: i64,
    attr_alignas: i64,
    type_align: i64,
    attr_vector_size: i64,
    attr_mode: Option<(u8, bool)>,
}

impl Pending {
    /// Detach the specifier carriers; the nested block starts clean, as
    /// any declaration does.
    pub(super) fn take_decl_specifiers(&mut self) -> DeclSpecifiers {
        DeclSpecifiers {
            saw_register_storage: core::mem::take(&mut self.saw_register_storage),
            base_is_const: core::mem::take(&mut self.base_is_const),
            attr_used: core::mem::take(&mut self.attr_used),
            attr_weak: core::mem::take(&mut self.attr_weak),
            attr_call_conv: core::mem::take(&mut self.attr_call_conv),
            attr_visibility: self.attr_visibility.take(),
            attr_section: self.attr_section.take(),
            attr_patchable_entry: self.attr_patchable_entry.take(),
            attr_no_instrument: core::mem::take(&mut self.attr_no_instrument),
            attr_cleanup: self.attr_cleanup.take(),
            attr_uninitialized: core::mem::take(&mut self.attr_uninitialized),
            attr_align: core::mem::take(&mut self.attr_align),
            attr_alignas: core::mem::take(&mut self.attr_alignas),
            type_align: core::mem::take(&mut self.type_align),
            attr_vector_size: core::mem::take(&mut self.attr_vector_size),
            attr_mode: self.attr_mode.take(),
        }
    }

    pub(super) fn restore_decl_specifiers(&mut self, s: DeclSpecifiers) {
        self.saw_register_storage = s.saw_register_storage;
        self.base_is_const = s.base_is_const;
        self.attr_used = s.attr_used;
        self.attr_weak = s.attr_weak;
        self.attr_call_conv = s.attr_call_conv;
        self.attr_visibility = s.attr_visibility;
        self.attr_section = s.attr_section;
        self.attr_patchable_entry = s.attr_patchable_entry;
        self.attr_no_instrument = s.attr_no_instrument;
        self.attr_cleanup = s.attr_cleanup;
        self.attr_uninitialized = s.attr_uninitialized;
        self.attr_align = s.attr_align;
        self.attr_alignas = s.attr_alignas;
        self.type_align = s.type_align;
        self.attr_vector_size = s.attr_vector_size;
        self.attr_mode = s.attr_mode;
    }

    /// Detach the declared-type carriers seeded by a base-type or
    /// `typeof` specifier. An attribute argument (`aligned(sizeof(T))`,
    /// `vector_size(N)`, `_Alignas(T)`, ...) re-enters the expression
    /// and type-name parsers, which reset these carriers on entry;
    /// `skip_attribute_specifiers` detaches them around the attribute
    /// so it cannot alter the type of the declarator it annotates.
    pub(super) fn take_decl_type_carriers(&mut self) -> DeclTypeCarriers {
        DeclTypeCarriers {
            base_was_void: core::mem::take(&mut self.base_was_void),
            base_is_const: core::mem::take(&mut self.base_is_const),
            spell_base_const: core::mem::take(&mut self.spell_base_const),
            spell_base_restrict: core::mem::take(&mut self.spell_base_restrict),
            spell_base_typedef: self.spell_base_typedef.take(),
            base_was_long_double: core::mem::take(&mut self.base_was_long_double),
            base_is_function_type: core::mem::take(&mut self.base_is_function_type),
            fn_ptr_indirection: self.fn_ptr_indirection.take(),
            fn_ptr_ret_indirection: core::mem::take(&mut self.fn_ptr_ret_indirection),
            typedef_fn_proto: self.typedef_fn_proto.take(),
            fn_ptr_param_types: self.fn_ptr_param_types.take(),
            typedef_base_array_size: core::mem::take(&mut self.typedef_base_array_size),
            typedef_base_array_dims: core::mem::take(&mut self.typedef_base_array_dims),
            typedef_base_zero_len: core::mem::take(&mut self.typedef_base_zero_len),
            typeof_operand_was_array: core::mem::take(&mut self.typeof_operand_was_array),
            type_align: core::mem::take(&mut self.type_align),
        }
    }

    pub(super) fn restore_decl_type_carriers(&mut self, s: DeclTypeCarriers) {
        self.base_was_void = s.base_was_void;
        self.base_is_const = s.base_is_const;
        self.spell_base_const = s.spell_base_const;
        self.spell_base_restrict = s.spell_base_restrict;
        self.spell_base_typedef = s.spell_base_typedef;
        self.base_was_long_double = s.base_was_long_double;
        self.base_is_function_type = s.base_is_function_type;
        self.fn_ptr_indirection = s.fn_ptr_indirection;
        self.fn_ptr_ret_indirection = s.fn_ptr_ret_indirection;
        self.typedef_fn_proto = s.typedef_fn_proto;
        self.fn_ptr_param_types = s.fn_ptr_param_types;
        self.typedef_base_array_size = s.typedef_base_array_size;
        self.typedef_base_array_dims = s.typedef_base_array_dims;
        self.typedef_base_zero_len = s.typedef_base_zero_len;
        self.typeof_operand_was_array = s.typeof_operand_was_array;
        self.type_align = s.type_align;
    }
}

/// The declared-type carriers of the declaration being parsed, detached
/// while an attribute specifier's arguments parse. See
/// [`Pending::take_decl_type_carriers`].
pub(super) struct DeclTypeCarriers {
    base_was_void: bool,
    base_is_const: bool,
    spell_base_const: bool,
    spell_base_restrict: bool,
    spell_base_typedef: Option<u32>,
    base_was_long_double: bool,
    base_is_function_type: bool,
    fn_ptr_indirection: Option<i64>,
    fn_ptr_ret_indirection: i64,
    typedef_fn_proto: Option<(usize, bool)>,
    fn_ptr_param_types: Option<alloc::vec::Vec<i64>>,
    typedef_base_array_size: i64,
    typedef_base_zero_len: bool,
    typedef_base_array_dims: alloc::vec::Vec<i64>,
    typeof_operand_was_array: bool,
    type_align: i64,
}

impl Default for Pending {
    fn default() -> Self {
        Self {
            base_was_void: false,
            base_is_const: false,
            spell_base_const: false,
            spell_base_restrict: false,
            spell_base_typedef: None,
            base_was_long_double: false,
            fn_params: None,
            fn_ptr_indirection: None,
            fn_ptr_ret_indirection: 0,
            fn_ptr_group_resolved: false,
            base_is_function_type: false,
            bare_function_type_declarator: false,
            index_stride: 0,
            index_strides_tail: Vec::new(),
            end_of_expr_stride: 0,
            end_of_expr_strides_tail: Vec::new(),
            init_inner_dims: alloc::vec::Vec::new(),
            init_target_array_size: 0,
            typedef_base_array_size: 0,
            typedef_base_zero_len: false,
            typedef_base_array_dims: alloc::vec::Vec::new(),
            declarator_leading_ptr_count: 0,
            declarator_outer_const: false,
            declarator_outer_restrict: false,
            vla_allowed: false,
            vla_dim_expr: None,
            declarator_zero_len_array: false,
            sizeof_vla_size_slot: None,
            const_expr_nonconst: false,
            const_expr_compound_literal: false,
            typedef_fn_proto: None,
            fn_ptr_param_types: None,
            indirect_callee_params: None,
            indirect_callee_is_variadic: false,
            indirect_callee_conv: crate::c5::codegen::CallConv::Target,
            indirect_callee_fn_ptr_depth: 0,
            indirect_callee_ret_fn_ptr: 0,
            last_fn_ptr_cast: None,
            parsing_fn_ptr_proto: false,
            member_decl_save: None,
            in_member_declarator: false,
            declarator_prior_shape: None,
            param_decl_context: false,
            last_array_decay_size: 0,
            last_array_decay_dims: alloc::vec::Vec::new(),
            typeof_operand_was_array: false,
            typeof_operand_array_size: 0,
            typeof_operand_array_bytes: 0,
            typeof_operand_array_dims: alloc::vec::Vec::new(),
            last_array_decay_bytes: 0,
            last_array_decay_member: None,
            member_base: None,
            // `-1` means "not in a fn-ptr-tracked chain"; see field
            // docs above.
            fn_ptr_chain_depth: -1,
            fn_ptr_depth_is_array_elem: false,
            last_loaded_local: None,
            last_loaded_local_prior_was_read: false,
            last_loaded_local_prior_pending: Vec::new(),
            bf_assign_rhs: None,
            bf_compound_assign: None,
            last_emit_was_indirect_call: false,
            last_imm_was_zero: false,
            compound_lit_close_parens: 0,
            attr_maybe_unused: false,
            attr_transparent_union: false,
            attr_align: 0,
            attr_alignas: 0,
            type_align: 0,
            attr_packed: false,
            attr_vector_size: 0,
            attr_mode: None,
            attr_thread_local: false,
            attr_dllexport: false,
            attr_constructor: false,
            attr_destructor: false,
            attr_init_priority: None,
            attr_cleanup: None,
            attr_uninitialized: false,
            attr_weak: false,
            attr_call_conv: crate::c5::codegen::CallConv::Target,
            attr_used: false,
            attr_visibility: None,
            attr_section: None,
            attr_patchable_entry: None,
            attr_no_instrument: false,
            attr_alias: None,
            saw_register_storage: false,
            auto_type_single_declarator: false,
        }
    }
}

/// Per-function state of one label name, held in `Compiler::labels`.
pub(super) struct LabelState {
    /// AST slot shared by the label's references and its labelled
    /// statement, allocated on the first mention either way.
    id: super::ast::LabelId,
    /// Set once the labelled statement is parsed. A second one for
    /// the same name violates C99 6.8.1p3.
    defined: bool,
}

/// One `__label__` binding: the key its name interns under, and the
/// block-nesting depth of the declaring block.
struct LocalLabelBinding {
    key: String,
    depth: usize,
}

/// GCC `__label__` bindings for the blocks open in the current
/// function, keyed by the name's symbol-table index -- the lexer
/// interns one entry per spelling, so a name is a `usize` here.
/// Declaring, resolving and closing a block each cost one map probe
/// per name rather than a scan of the declaring block's list.
#[derive(Default)]
pub(super) struct LocalLabelScopes {
    /// Per name, the bindings currently in scope, innermost last: a
    /// declaration pushes, its block's exit pops. `last()` is the
    /// binding a reference resolves to, so an inner declaration
    /// shadows an outer one.
    active: hashbrown::HashMap<usize, Vec<LocalLabelBinding>>,
    /// Per open block, the names it declared, so its exit pops exactly
    /// its own bindings.
    declared: Vec<Vec<usize>>,
    /// Makes each declaration's key unique within the function, which
    /// keeps two sibling blocks declaring one name apart.
    seq: u32,
}

impl LocalLabelScopes {
    /// Drop every binding. Called at each function start.
    fn clear(&mut self) {
        self.active.clear();
        self.declared.clear();
        self.seq = 0;
    }

    fn open(&mut self) {
        self.declared.push(Vec::new());
    }

    fn close(&mut self) {
        for idx in self.declared.pop().unwrap_or_default() {
            if let hashbrown::hash_map::Entry::Occupied(mut e) = self.active.entry(idx) {
                e.get_mut().pop();
                if e.get().is_empty() {
                    e.remove();
                }
            }
        }
    }

    /// Bind the name at symbol index `idx` in the innermost open block
    /// and return its key. `None` when that block already declares the
    /// name, which gcc rejects.
    fn declare(&mut self, idx: usize, name: &str) -> Option<String> {
        let depth = self.declared.len();
        if self.innermost(idx).is_some_and(|b| b.depth == depth) {
            return None;
        }
        let key = format!("{name}#{}", self.seq);
        self.seq += 1;
        self.active.entry(idx).or_default().push(LocalLabelBinding {
            key: key.clone(),
            depth,
        });
        self.declared
            .last_mut()
            .expect("a block scope is open while parsing its `__label__` declaration")
            .push(idx);
        Some(key)
    }

    /// The key the name at symbol index `idx` resolves to, or `None`
    /// when no open block declares it (a function-scoped label).
    fn resolve(&self, idx: usize) -> Option<&str> {
        self.innermost(idx).map(|b| b.key.as_str())
    }

    fn innermost(&self, idx: usize) -> Option<&LocalLabelBinding> {
        let found = self.active.get(&idx).and_then(|s| s.last());
        note_local_label_lookup(usize::from(found.is_some()), self.active.len());
        found
    }
}

#[cfg(test)]
thread_local! {
    /// Label lookups, `__label__` bindings those lookups examined, and
    /// bindings that were in scope at them. Read by the scaling test,
    /// which bounds the second against the first and the third.
    pub(crate) static LOCAL_LABEL_LOOKUP: core::cell::Cell<(usize, usize, usize)> =
        const { core::cell::Cell::new((0, 0, 0)) };
}

#[cfg(test)]
fn note_local_label_lookup(examined: usize, in_scope: usize) {
    LOCAL_LABEL_LOOKUP.with(|c| {
        let (n, e, s) = c.get();
        c.set((n + 1, e + examined, s + in_scope));
    });
}

#[cfg(not(test))]
fn note_local_label_lookup(_examined: usize, _in_scope: usize) {}

/// Single-pass C compiler. Holds the lexer, the symbol table, and the
/// codegen scaffolding. `compile(self)` consumes the compiler and produces
/// a [`Program`] ready for the VM.
pub struct Compiler {
    lex: Lexer,
    symbols: Vec<Symbol>,
    /// Side hash index over `symbols`, kept in lockstep with it so
    /// `find_symbol` / `resolve_symbol` are O(1) amortised instead of
    /// scanning the whole vector on every identifier.
    symbol_index: lexer::SymbolIndex,
    /// Indices into `symbols` whose binding an inner scope rebound and
    /// which the scope-exit unwind has yet to restore. `symbols` is
    /// interned, not a scope stack, so a function's bindings are
    /// scattered through it; without this list every scope exit would
    /// have to scan the whole table. Maintained by `shadow_symbol` /
    /// `capture_block_shadow` and drained by `unwind_scope_bound`,
    /// which keeps the entries whose binding outlives the scope (a
    /// file-scope register variable is permanently `Loc`).
    scope_bound: Vec<u32>,
    /// Open nested-block scopes' saved bindings, innermost last. A
    /// level is pushed at block / `for`-init entry and drained at its
    /// exit through `restore_block_shadow`; any rebinding site reached
    /// while a level is open (declaration, enum body, block-scope or
    /// implicit function declaration) saves the outer binding into the
    /// innermost level. Empty at the function-body top level, whose
    /// bindings use the per-symbol `h_*` slots instead.
    block_scopes: Vec<Vec<stmt::BlockShadow>>,

    // --- Codegen state ---
    /// Next available `ent_pc` identifier for a user function or
    /// Sys trampoline. Bumped once per function at recording time
    /// so `ent_pc` / `end_pc` form a strictly increasing,
    /// non-overlapping per-TU sequence the linker can rebase
    /// across translation units.
    next_ent_pc: usize,
    data: Vec<u8>,
    /// Start offsets of anonymous data objects (string literals,
    /// `__func__`) recorded as they are placed in `data`, for static
    /// DCE object boundaries. See `Program::data_object_starts`.
    data_object_starts: Vec<i64>,
    /// `[lo, hi)` ranges of anonymous immutable data (string literals,
    /// `__func__` arrays, staged local-initializer templates). See
    /// `Program::const_data_ranges`.
    const_data_ranges: Vec<(i64, i64)>,
    /// Alignment-padding ranges within `data`. See
    /// `Program::data_pad_ranges`.
    data_pad_ranges: Vec<(i64, i64)>,
    /// Above-8 alignment boundaries within `data`. See
    /// `Program::data_align_marks`.
    data_align_marks: Vec<(i64, i64)>,
    /// Element count the most recent flexible array member fill wrote.
    /// Read by the speculative pass that sizes a FAM-bearing object's
    /// storage before the real fill runs; `None` between measurements.
    flex_array_measured_count: Option<usize>,
    /// Type of the current expression -- set by `expr` callees, read by callers
    /// to decide between byte and word loads/stores and for pointer scaling.
    ty: i64,
    /// Number of local-variable slots currently reserved in the active stack
    /// frame. User-declared locals push it up monotonically; call-arg staging
    /// (parse_function_args) bumps it temporarily for each in-flight call's
    /// reverse-push temp slots and then restores it.
    loc_offs: i64,
    /// Per-function floor the call-argument staging recycle may not drop
    /// below. A block-scope compound literal reserves storage that lasts to
    /// the end of the enclosing block (C99 6.5.2.5p5); when it is evaluated
    /// inside a call argument, that storage sits above the recycle's saved
    /// `loc_offs`. Raising this to the literal's top keeps the recycle from
    /// reclaiming it for a later full-expression's temporaries. Reset per
    /// function.
    committed_loc_offs: i64,
    /// Per-function high-water mark of `loc_offs` -- the SSA
    /// builder uses it to size the function's local slot count
    /// so the prologue reserves enough stack for every nested-call
    /// temp the function ever needs.
    max_loc_offs: i64,
    /// `(base_offset, cells)` for each multi-cell temporary the parser
    /// allocates that carries no symbol (a struct call result, a
    /// struct-by-value parameter copy, a struct compound literal). Slot
    /// coalescing reserves these interior cells; without a symbol they are
    /// absent from the per-function variable list. Reset per function.
    multi_cell_temps: alloc::vec::Vec<(i64, i64)>,
    /// `(slot_off, align, size_bytes)` for each automatic object in the current
    /// function whose required alignment exceeds 16 (C11 6.7.5). Drained at
    /// function close into `FinishedFunction::over_aligned_slots`. Reset per
    /// function.
    func_over_aligned: alloc::vec::Vec<(i64, i64, i64)>,

    /// True once the current function has applied the address-of operator
    /// to one of its automatic objects, directly or through a member,
    /// element or cast of one. Feeds
    /// [`crate::c5::ir::SspFacts::addr_taken`], which
    /// `-fstack-protector-strong` reads. Reset per function.
    func_local_addr_taken: bool,

    /// True once the current function has emitted at least one
    /// alloca intrinsic. Drives the function-end backpatch that
    /// grows the function's local count to include the alloca
    /// arena and sets the matching `Inst::AllocaInit`'s operand to
    /// the alloca-top slot index. Reset on each new function
    /// definition.
    uses_alloca_in_current_fn: bool,

    /// Count of C99 6.7.6.2 variable-length arrays declared so far in
    /// the current function. Snapshotted around a block's declarations
    /// so `parse_block_stmt` knows whether to bracket the block with
    /// the alloca-arena save / restore that reclaims VLA storage on
    /// exit. Reset on each new function definition.
    func_vla_decls: usize,

    /// Half-open `self.ast.stmts` ranges owned by statement
    /// expressions `({ ... })` parsed in the current function. A
    /// statement expression pushes its block's statements into the
    /// shared statement arena, but those are sub-statements of the
    /// expression, not top-level block items; the decl-path capture
    /// in `parse_block_stmt` / the function-body loop skips any id
    /// inside one of these ranges so the statements are walked only
    /// once (through the `Expr::StmtExpr` node). Pruned as each
    /// enclosing declaration is captured; cleared per function.
    stmt_expr_arena_ranges: Vec<(usize, usize)>,

    /// True when the most recent decl-spec parse consumed an
    /// `inline` / `__inline` / `__inline__` keyword. Captured at
    /// function-symbol commit time onto `FinishedFunction::is_inline`
    /// and reset after, so it scopes to the immediately following
    /// declarator only.
    pending_is_inline: bool,

    /// Like [`Self::pending_is_inline`] but for a *mandatory* inline
    /// request (`__attribute__((always_inline))` / MSVC
    /// `__forceinline`); implies `pending_is_inline`.
    pending_is_always_inline: bool,
    /// `__attribute__((noinline))` seen on the declarator being emitted.
    pending_is_noinline: bool,

    /// True when the most recent decl-spec parse consumed an `inline`
    /// function specifier -- `inline` / `__inline` / `__inline__` or
    /// MSVC `__forceinline`. Distinct from [`Self::pending_is_inline`],
    /// which `__attribute__((always_inline))` also sets: that is an
    /// attribute, not a specifier, and the linkage model reads the
    /// specifier the source spelled.
    pending_saw_inline_specifier: bool,

    /// Set by `__attribute__((gnu_inline))` on the current declaration;
    /// selects the GNU89 inline model for the declared function.
    pending_is_gnu_inline: bool,
    /// Set by `__attribute__((naked))`; the next function emits no
    /// prologue/epilogue and no implicit return -- its body is its full
    /// machine code (inline asm).
    pending_is_naked: bool,

    /// True when the most recent decl-spec parse consumed a
    /// `_Noreturn` / `noreturn` keyword. Captured at function-symbol
    /// commit time onto `Symbol::is_noreturn` and reset after, so it
    /// scopes to the immediately following declarator only.
    pending_noreturn: bool,

    /// Nesting depth of unevaluated constant-expression operands
    /// (short-circuited `&&` / `||` right sides and not-taken `?:`
    /// arms). C99 6.6p4 forbids a zero divisor in a constant
    /// expression, but an unevaluated operand must not trigger the
    /// diagnostic (`1 ? 2 : 1/0` is accepted by gcc / clang).
    const_unevaluated: u32,

    /// Nesting depth of constant-expression contexts where a reference
    /// to a `const`-qualified scalar object folds to its recorded
    /// initializer value (`Symbol::const_object_value`). GCC (GNU mode,
    /// at -O) applies that fold to case labels (including GNU ranges)
    /// and `static_assert`, and not to array bounds, enum values,
    /// bitfield widths, or alignment specifiers; the entry points for
    /// the folding contexts raise this depth.
    const_object_fold: u32,

    /// Nesting depth of initializers for an object with static storage
    /// duration declared inside a function body. C99 6.7.8p4 requires
    /// those to be constant expressions; an automatic object's
    /// initializer at the same nesting has no such requirement.
    static_duration_init: u32,

    /// Per-function AST. The arena is reset at every function
    /// entry; the SSA walker reads from these snapshots at codegen
    /// entry.
    pub(super) ast: super::ast::Ast,

    /// ExprId of the value currently in the c5 accumulator,
    /// matching the parser's "every expression leaves its result
    /// in `a`" invariant. `None` between statements or when the
    /// expression site doesn't produce an AST node (address-only
    /// producers that the call-site path consumes directly).
    pub(super) ast_acc: Option<super::ast::ExprId>,

    /// ExprIds matching values on the c5 stack-machine stack --
    /// the stack push records the current `ast_acc` here;
    /// arithmetic / store ops pop the top entry. `Option`
    /// because some parser sites push address-only producers
    /// (address-of-local for a temp, data-segment immediate)
    /// that aren't AST-wired yet; pushing `None` keeps the
    /// vstack depth in lockstep with the c5 stack so a later pop
    /// hits the right slot rather than a stale value
    /// from a previous statement. `Vec` is per-function, never
    /// grows past the deepest expression nesting in any one
    /// function.
    pub(super) ast_vstack: Vec<Option<super::ast::ExprId>>,

    /// Per-function AST snapshots, captured at every function's
    /// closing return. The codegen entry walks these in order to
    /// produce one `FunctionSsa` per source function. Order
    /// matches function-definition order.
    pub(super) finished_functions: Vec<super::ast::FinishedFunction>,

    /// Synthesised `FunctionSsa` entries for parser-emitted
    /// helpers that aren't built from source (sys-trampolines).
    /// The codegen reads these directly via `produce_ssa_funcs`.
    pub(super) synthetic_ssa_funcs: Vec<super::ir::FunctionSsa>,

    /// Cross-helper carry: `emit_local_init_store` stashes the
    /// initializer's ExprId here so the calling `parse_*_local_decl`
    /// can wrap it in `Decl::Local { init: Scalar(_) }`. Always
    /// cleared to None by the consumer; None on entry means an
    /// uninitialized local declaration.
    pub(super) pending_local_init_ast: Option<super::ast::ExprId>,

    /// Cross-helper carry for aggregate (constant brace-list)
    /// local initializers: `emit_local_array_init` stashes the
    /// staged `(src_data_off, size_bytes)` here so the decl site
    /// can build `Decl::Local { init: Aggregate(_) }`. Holds the
    /// Mcpy source descriptor; `None` means the decl is scalar /
    /// uninitialized.
    pub(super) pending_local_aggregate_ast: Option<super::ast::LocalInitPrelude>,

    /// Cross-helper carry for runtime brace-list local
    /// initializers: `emit_local_array_init_runtime` and
    /// `emit_struct_local_init_runtime` append one entry per
    /// element-store, so the decl site can build
    /// `Decl::Local { init: Runtime { zero_init, elements } }`.
    /// The optional `zero_init` is filled by the preceding
    /// `emit_local_array_init` Mcpy-zero prelude (struct path);
    /// the array path has no zero prelude today.
    pub(super) pending_local_runtime_elements: Vec<super::ast::RuntimeInitElement>,

    // --- Lex-time scope depth ---
    /// Number of currently-open `break`-eligible scopes
    /// (`while` / `for` / `do-while` bodies, plus `switch`
    /// bodies). Used to flag `break` outside any such scope.
    /// The walker handles branch-target resolution from the
    /// AST; only the depth counter survives here for the
    /// "break outside loop / switch" check.
    loop_break_depth: usize,
    /// Number of currently-open `continue`-eligible scopes
    /// (loops only; `switch` doesn't open one).
    loop_continue_depth: usize,
    /// Recursion depth shared by the recursive-descent entry points
    /// (statements, expressions, constant expressions, declarators,
    /// initializer lists). Bounded by `MAX_NEST_DEPTH` via
    /// `with_nesting` so pathological nesting is diagnosed instead
    /// of exhausting the native stack.
    nest_depth: usize,
    /// Every label named in the current function, keyed by its
    /// resolved name (see `resolve_label_name`). Ties the parser's
    /// name-keyed view to the AST's flat per-function label-id space,
    /// so a `goto` resolves regardless of source order;
    /// `Compiler::run_compile` validates every `goto` target against
    /// it at function end. Cleared at every function start.
    labels: hashbrown::HashMap<String, LabelState>,
    /// Names of `goto label` statements whose target wasn't yet
    /// defined when the goto was parsed. Each name is rechecked
    /// against `labels` at function end; an unresolved entry is
    /// a compile error.
    unresolved_gotos: Vec<String>,
    /// GCC `__label__` bindings of the open blocks: an inner
    /// declaration shadows an outer one and two sibling blocks
    /// declaring the same name get distinct keys. Cleared at every
    /// function start.
    local_label_scopes: LocalLabelScopes,
    /// Per nested `switch` body: drained at switch close. The
    /// AST emitter records each case's constant on its `Stmt::Case`
    /// node; this stack is the parser-side depth tracker that
    /// gates `case` / `default` legality.
    switch_cases: Vec<Vec<i64>>,
    /// Per nested `switch` body: `true` once a `default:` label
    /// was seen.
    switch_defaults: Vec<bool>,

    /// Defined struct types, indexed by struct id.
    pub(super) structs: Vec<StructDef>,
    /// Per-scope struct/union tag bindings (C99 6.2.1: tags have
    /// block scope). Each entry is a Vec of `(tag_name, struct_id)`
    /// declared in that scope. The first entry is the file scope; an
    /// inner block pushes an empty scope on entry and pops it on
    /// exit, so a `struct T` in a nested block shadows an outer one
    /// without colliding. `self.structs` keeps the StructDef storage
    /// reachable by id even after a scope pops.
    pub(super) tag_scopes: Vec<Vec<(String, usize)>>,
    /// Captured enum definitions. Populated by `parse_enum_body`
    /// when the parser sees `enum Tag { ... }`; the (tag, constants)
    /// pairs feed the DWARF emitter's enum DIEs.
    pub(super) enums: Vec<EnumDef>,

    /// Where every controllable diagnostic the front end reports goes.
    /// The sink resolves each one's level and drops the ignored ones.
    sink: crate::c5::diag::Sink,

    /// Diagnostics still formatted as text at their site: the
    /// preprocessor's warnings and the auto-include notes.
    /// TODO: fold into `sink` when those sites take catalogue rows.
    text_diagnostics: Vec<String>,

    /// File-scope `asm("...")` templates, validated at parse time
    /// (section data directives only). The codegen materializes them
    /// into the object's named sections under the emit target's
    /// directive conventions.
    pub(super) file_asm: Vec<String>,

    /// `.weak` symbol names from file-scope asm, bound STB_WEAK by the
    /// object writer wherever the name surfaces.
    pub(super) asm_weak_names: Vec<String>,
    /// `.globl` symbol names from file-scope asm, given an undefined global
    /// entry when the unit neither defines nor references the name.
    pub(super) asm_global_names: Vec<String>,
    /// Symbol visibility named by `.hidden` / `.internal` / `.protected` in
    /// file-scope asm.
    pub(super) asm_visibility: Vec<(String, crate::c5::program::SymVisibility)>,
    /// `.set name, target` symbol aliases from file-scope asm, merged
    /// onto `Program::function_aliases`.
    pub(super) asm_sym_sets: Vec<(String, String, i64)>,
    /// `.file "name"` operands from file-scope asm, in directive order.
    pub(super) asm_file_names: Vec<String>,
    /// `.ident` strings from file-scope asm, in directive order.
    pub(super) asm_idents: Vec<String>,
    /// Sink the parse-time validation materializes every file-scope asm
    /// template into, in source order. Per unit, as the codegen sink is:
    /// a location expression may reach a label an earlier template
    /// defined (`.size name, .-name` split across two `asm()`).
    pub(super) asm_validate_sink: crate::c5::asm::AsmSectionSink,

    /// Include resolutions recorded by the preprocessor when
    /// [`CompileOptions::track_includes`] was set. Empty otherwise.
    /// Renders the `-H` trace and the `-M` family's prerequisites.
    include_records: Vec<IncludeRecord>,

    /// `#pragma entrypoint(<name>)` value drained from the
    /// preprocessor. Default `None` means "use `main`".
    /// Read in `compile()` to compute `entry_pc` and threaded onto
    /// `Program::entry_name`.
    pp_entrypoint: Option<String>,
    /// `#pragma subsystem(<kind>)` value drained from the
    /// preprocessor. Default `None` means "PE writer
    /// picks `Console`". Read only by the PE writers.
    pp_subsystem: Option<crate::c5::preprocessor::Subsystem>,

    /// `#pragma intrinsic("name")` map drained from the
    /// preprocessor. Used at declaration time to stamp
    /// `Symbol::intrinsic` on matching callables so the
    /// call-site lowering can substitute an `Inst::Intrinsic`
    /// emit for the regular call + stack-cleanup sequence.
    pp_intrinsics: alloc::collections::BTreeMap<String, i64>,

    /// Thread-local data segment. Same shape as `data` but the
    /// codegen lowers accesses with the per-target TLS sequence
    /// (TPIDR_EL0 + offset on aarch64, fs:0 + offset on x86_64,
    /// the .tls$ callback chain on Win64). Each `_Thread_local`
    /// global gets `slots_of_type(ty) * 8` bytes here, with
    /// `Symbol::val` holding the byte offset within `tls_data`.
    /// A `_Thread_local int x = 5;` initialiser fills its slice and
    /// raises `tls_init_size` so its bytes go into .tdata; an
    /// uninitialised variable stays zero-filled in .tbss.
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
    /// Pointer-to-extern-data static initializers; the target symbol is
    /// resolved by name at link time. See [`program::ExternDataReloc`].
    pub(super) extern_data_relocs: Vec<crate::c5::program::ExternDataReloc>,
    /// Function-pointer relocations for static initializers like
    /// `static const VTable v = { .xClose = my_close };`. Each
    /// entry is the byte offset in `data` of an 8-byte slot plus
    /// the ent_pc of the function to point at; the per-format
    /// writers patch the slot to the real code address at write or
    /// load time. The VM reads the slot directly because c5
    /// function pointers carry the small `CODE_BASE + ent_pc` bias
    /// and the indirect-call lowering recognises that range.
    code_relocs: Vec<crate::c5::program::CodeReloc>,
    /// Address-constant initializers of `_Thread_local` objects. Slots are
    /// `tls_data` offsets; see [`program::Program::tls_data_relocs`].
    pub(super) tls_data_relocs: Vec<crate::c5::program::DataReloc>,
    /// Per-`tls_data_relocs` originating symbol index, as
    /// [`Self::data_reloc_sym_idx`] is for `data_relocs`.
    pub(super) tls_data_reloc_sym_idx: Vec<usize>,
    /// [`Self::extern_data_relocs`] whose slot is in `tls_data`.
    pub(super) tls_extern_data_relocs: Vec<crate::c5::program::ExternDataReloc>,
    /// [`Self::code_relocs`] whose slot is in `tls_data`.
    pub(super) tls_code_relocs: Vec<crate::c5::program::CodeReloc>,
    /// Per-`tls_code_relocs` originating symbol index, as
    /// [`Self::code_reloc_sym_idx`] is for `code_relocs`.
    pub(super) tls_code_reloc_sym_idx: Vec<usize>,
    /// `&&label` initializer elements staged while parsing the current
    /// function body; moved onto `FinishedFunction::label_data_slots` at
    /// function close.
    pending_label_relocs: Vec<PendingLabelReloc>,
    /// Set while a function body is being parsed, so `&&label` resolves
    /// against a label scope rather than lexing as the logical-AND
    /// operator.
    in_function_body: bool,
    /// Names from `#pragma export(<name>)` directives, in
    /// declaration order. Validated at the end of
    /// [`Self::run_compile`] -- each must resolve to a
    /// `Token::Fun` symbol -- and copied onto
    /// `Program::exports` together with the function's
    /// ent_pc. Empty for executables that don't reach
    /// for the directive.
    pending_exports: Vec<String>,
    /// Functions defined with `__attribute__((constructor))` /
    /// `((destructor))`, accumulated in source order and copied onto
    /// `Program::init_funcs`. Populated at each function-body open
    /// when the symbol carries `is_constructor` / `is_destructor`.
    init_funcs: Vec<crate::c5::program::InitFunc>,
    /// `__attribute__((alias("target")))` function declarations, moved
    /// onto `Program::function_aliases`.
    function_aliases: Vec<crate::c5::program::FunctionAlias>,
    /// Aliases whose target was not yet defined when the declarator was
    /// parsed. C99 leaves the ordering open and GCC accepts a target defined
    /// later in the unit, so resolution is retried once the unit is complete.
    /// Each entry is the alias symbol, its target name, and whether the
    /// declarator was an object rather than a function.
    pending_aliases: Vec<(usize, String, bool)>,
    /// Names given external linkage by a file-scope `asm(".globl name");`.
    /// The directive may precede the definition, so the names are applied
    /// once the unit is complete.
    pending_asm_globl: Vec<String>,
    /// File-scope object definitions whose aggregate tag was incomplete at
    /// the declarator. C99 6.9.2p3 admits a tentative definition the unit
    /// completes later, so each entry -- the symbol, its tag, and the
    /// declarator's line -- is rechecked once the unit is complete.
    pending_incomplete_objects: Vec<(usize, usize, usize)>,
    /// Return type of the function whose body is currently being
    /// parsed (0 outside any function). Used by the `return s`
    /// path to emit a struct-copy through the hidden out-pointer
    /// when the function's declared return type is a struct
    /// value -- the caller pre-allocates a result temp and passes
    /// its address at param val=2; struct-returning callees treat
    /// declared params as starting at val=3.
    current_func_return_ty: i64,

    /// True while parsing the body of a function whose declared
    /// return type was bare `void`. Drives two emit decisions:
    ///   * the synthetic return prepended at function end
    ///     emits a zero so a caller that misclassifies the
    ///     prototype reads `0` rather than stale accumulator bits
    ///     (C99 6.8.6.4p3 -- a `void` callee produces no value).
    ///   * a `return;` statement emits the same zero prefix
    ///     before the return; a `return <expr>;` is rejected
    ///     (C99 6.8.6.4p1 constraint violation).
    /// Set at function-body entry from the function's symbol
    /// (`Symbol::returns_void`), cleared at exit.
    current_func_returns_void: bool,
    /// Calling convention of the function body being parsed, taken off
    /// its symbol at the opening brace. Propagated onto
    /// `FinishedFunction::conv`.
    current_func_conv: crate::c5::codegen::CallConv,

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

    /// Symbol indices of callees already reported as used without a
    /// return-type prototype (implicit int). Dedupes the diagnostic to
    /// one per callee.
    warned_implicit_ret: alloc::collections::BTreeSet<usize>,

    /// The native target this compilation is producing for.
    /// Drives data-model picks: `long` is 8 bytes on LP64
    /// (Linux / macOS) and 4 bytes on LLP64 (Windows). Stored
    /// here so per-`ty` helpers (`size_of_type`, `align_of_type`,
    /// `load_op_for`) can pick the right width without threading the
    /// target through every call site.
    target: Target,

    /// Side-channel state shared between parser layers -- the
    /// 11 transient flags / stride queues / chain-depth counters
    /// the recursive descent reaches for. Grouped into one
    /// carrier so `Compiler` doesn't grow per parser-feature.
    /// Reset to `Pending::default()` at compiler construction.
    pending: Pending,

    /// Symbols with at least one entry in `Symbol::pending_stores`.
    /// Tracked separately so the branch and call AST emitters
    /// can flush every pending store without walking the full
    /// symbol table on each control-flow point. Cleared in
    /// lockstep with the per-symbol vectors.
    pending_store_symbols: Vec<usize>,

    /// Whether the `dead-store` row reports anywhere in this unit,
    /// resolved once from the command line and the pragmas. The
    /// parser's per-store bookkeeping is only worth its cost when it
    /// does.
    warn_dead_store: bool,
    /// Mirror of [`CompileOptions::no_entry_point`]. Drops the
    /// "must define main / wmain / WinMain / wWinMain" check
    /// in `resolve_entry_and_dllmain_pcs`; `compile()` then
    /// returns a `Program` with `entry_pc = 0` /
    /// `entry_name = None` if no entry symbol exists.
    no_entry_point: bool,

    /// Base alignment the `.data` image requires, at least 8. Raised
    /// to 16 when a file-scope object requests `_Alignas(16)`.
    data_align: usize,

    /// Mirror of [`CompileOptions::implicit_extern_fns`]. An
    /// undeclared call to a listed name binds as a C89 6.3.2.2
    /// implicit `extern int name();` resolved at link time.
    implicit_extern_fns: Vec<String>,

    /// Mirror of [`CompileOptions::export_all_functions`]. When set,
    /// `resolve_exports` adds every non-static defined function to the
    /// export list so a `--shared` consumer can `dlsym` it.
    export_all_functions: bool,
    /// Mirror of [`CompileOptions::no_builtin`] and
    /// [`CompileOptions::no_builtin_fns`]. Read by the library-name
    /// folds, which decline under them.
    no_builtin: bool,
    no_builtin_fns: Vec<String>,
    /// Mirror of [`CompileOptions::optimize`]. Gates the parse-side
    /// transforms that are optimizations rather than lowerings.
    optimize: bool,
    /// Mirror of [`CompileOptions::nostdinc`]. With either flag set the
    /// auto-include retry never runs, which is when a builtin's
    /// fallback call must bind without a declaration.
    nostdinc: bool,
    /// Mirror of [`CompileOptions::auto_var_init`]. Read where an
    /// automatic object without an initializer is bound.
    auto_var_init: AutoVarInit,
    /// Mirror of [`CompileOptions::elf_class`]: the assembler's
    /// starting code mode.
    elf_class: crate::c5::ElfClass,

    /// The unit's default inline linkage model, from
    /// [`CompileOptions::gnu89_inline`]. A function carrying
    /// `__attribute__((gnu_inline))` uses [`InlineModel::Gnu89`]
    /// regardless.
    inline_model: crate::c5::symbol::InlineModel,
    /// Mirror of [`CompileOptions::strict_flex_arrays`].
    strict_flex_arrays: u8,

    /// File-name table. Index 0 is the user's translation unit;
    /// every distinct filename observed via the lexer's
    /// `(file, line)` state (i.e. crossing a GNU line marker on
    /// `#include` enter / a `#line N "file"` directive) gets
    /// a fresh entry. The DWARF emitter writes one
    /// `DW_LNE_define_file` per entry and switches with the
    /// walker's per-Inst `inst_src` file index.
    source_files: Vec<String>,
    /// Name -> index into `source_files`. The table is append-only, so
    /// this is a pure index over it; without it every declaration site
    /// re-scans the whole table comparing full paths.
    source_file_index: hashbrown::HashMap<String, usize>,
    /// Label of the primary translation-unit source as supplied
    /// through [`CompileOptions::source_label`]. Compared against
    /// [`lexer::Lexer::file`] at declaration sites so unused-symbol
    /// diagnostics can skip declarations that landed via
    /// `#include`d headers (which the user can't act on from
    /// this TU). Empty when the caller didn't set a label; the
    /// preprocessor's `"<source>"` placeholder then stands in.
    source_label: String,
    /// The unit is assembler source (`.s` / `.S`), carried to
    /// `Program::asm_unit` for the object writer's GNU as shape.
    asm_unit: bool,
    /// Per-function locals + parameters captured at body close,
    /// before the c5 shadow-symbol restore unwinds the binding.
    /// The DWARF emitter walks this list to attach
    /// `DW_TAG_variable` / `DW_TAG_formal_parameter` DIEs to the
    /// matching subprogram, which lets lldb's `frame variable` and
    /// `watchpoint set variable foo` work for c5-emitted code.
    variables: Vec<crate::c5::program::VariableInfo>,
    /// Block-scoped locals captured at each block exit, before the
    /// shadow-symbol restore unwinds their binding and removes them
    /// from the symbol table the function-close collection walks.
    /// Drained into `variables` at function close with the function's
    /// entry PC. The entries flatten into function scope; precise
    /// `DW_TAG_lexical_block` ranges are not emitted yet (TODO).
    pending_block_locals: Vec<crate::c5::program::VariableInfo>,
    /// Stack of block scopes carrying `__attribute__((cleanup(fn)))`
    /// variables, innermost last, in declaration order. A block exit emits
    /// `fn(&var)` in reverse order (C++-style, matching GCC) on every path
    /// out: fall-through, `return`, `break`, and `continue`. Entries are
    /// snapshots of the declared binding: the symbol slot is rebound when
    /// an inner scope shadows the name, and an exit emitted inside such a
    /// scope must address the registered binding, not the current one.
    cleanup_scopes: Vec<Vec<stmt::CleanupVar>>,
    /// `cleanup_scopes` depth at each enclosing `break` target (loop or
    /// `switch`) and `continue` target (loop only), innermost last. A
    /// `break` / `continue` cleans the scopes above the recorded depth.
    break_cleanup_depths: Vec<usize>,
    continue_cleanup_depths: Vec<usize>,
    /// Name of the C function whose body is currently being
    /// emitted. Set on function-entry emit and cleared on the
    /// closing return.
    current_function_name: String,
    /// Parallel symbol index for each entry in `code_relocs`.
    /// `parse_constant_init_value` records a CodeReloc with the
    /// callee's `Symbol::val` at parse time -- which is `0` for
    /// any function whose body hasn't been emitted yet (e.g. a
    /// dispatch table that names every callback before any
    /// callback's body lands). [`Compiler::resolve_code_relocs`]
    /// reads this index post-parse and rewrites each CodeReloc's
    /// `target_ent_pc` to the originating symbol's now-resolved
    /// `Symbol::val`.
    code_reloc_sym_idx: Vec<usize>,

    /// Parser-symbol indices for every immediate emit whose
    /// operand carries a global's tentative address. The data
    /// reference shape becomes a cross-TU reference when the
    /// target global is defined in another translation unit;
    /// `link_unit` walks the list at construction time to flag
    /// cross-TU references to `_Thread_local` globals (which c5
    /// doesn't support yet) before the walker's
    /// `extern_imm_data_refs` / `extern_tls_refs` channels take
    /// over resolution. Empty in single-TU compiles.
    pub(super) glo_imm_refs: alloc::vec::Vec<usize>,
    /// Per-`data_relocs` originating symbol index. Tracks the
    /// `Token::Glo` whose address an initializer like
    /// `int *p = &x;` baked into the data segment. Cross-TU
    /// link-unit assembly walks this list in parallel with
    /// `data_relocs` to convert any entry whose `x` is an
    /// undefined external reference into a `DataDataAbs64`
    /// relocation. Length matches `data_relocs.len()` -- one
    /// symbol idx per emitted reloc -- so the parallel arrays
    /// don't drift out of sync.
    pub(super) data_reloc_sym_idx: alloc::vec::Vec<usize>,
    /// `Program::data` offsets that currently carry an initializer
    /// relocation, so a byte write can ask whether the range it
    /// overwrites holds one and run the C99 6.7.8p19 retirement only
    /// where there is something to retire. A bound on the highest
    /// recorded offset does not answer that: an element holding the
    /// address of a compound literal appends the literal, then writes the
    /// pointer back into the element's slot below it, so the write offset
    /// retreats below the highest recorded slot on every such element.
    pub(super) init_reloc_slots: alloc::collections::BTreeSet<u64>,
    /// Per-libc-symbol trampoline registry. When source code
    /// reaches for the *address* of a `Token::Sys` binding --
    /// either bare (`fp = lstat;`) or in a static initializer
    /// (a function-pointer dispatch table referencing libc) --
    /// c5 has no compile-time
    /// libc address to fold in. Instead the parser synthesizes a
    /// tiny c5 function that re-pushes its parameters and
    /// re-dispatches through an external call. Each entry maps
    /// `sys_sym_idx` to a
    /// fresh synthetic-symbol idx whose `.val` carries the
    /// trampoline's `ent_pc`; the walker reads that live `val`
    /// through `live_fun_val` when it emits the matching
    /// `Inst::ImmCode` for the address-of site, and
    /// `resolve_code_relocs` patches any data-slot CodeReloc
    /// against the same `Symbol::val`. Trampolines are
    /// emitted in [`Self::emit_sys_trampolines`] after every
    /// real function body lands so they never split a caller
    /// mid-emission.
    sys_trampoline_sym: alloc::collections::BTreeMap<usize, usize>,

    /// Per-TU counter for anonymous compound-literal backing
    /// symbols. C99 6.5.2.5 compound literals at file scope
    /// (`Type *p = &(Type){ ... };`) need a synthetic symbol so the
    /// linker can resolve the `&` reloc; the name is
    /// `__compound.<n>` with `n` incrementing on every literal.
    /// The same counter feeds block-scope compound literals that
    /// spill to internal-linkage storage. Reset implicitly via
    /// `Compiler::default()` on every fresh compile.
    next_compound_literal_id: usize,

    /// `(data offset, symbol index)` of every staged-literal symbol,
    /// ascending by offset. `truncate_data` retires the suffix whose
    /// storage it reclaims: those offsets go back to unrelated objects,
    /// and the data-object model identifies an object by its start.
    staged_literal_syms: Vec<(i64, usize)>,

    /// `(function, spelling, data offset)` of every `__func__` object
    /// already materialised. C99 6.4.2.2 declares one object per
    /// function, so a second reference resolves to the same storage.
    func_name_objects: Vec<(String, String, i64)>,
    /// Per-TU counter for the `__func__.<n>` backing symbols, shared
    /// across the three spellings as gcc's is.
    next_func_name_id: usize,

    /// Symbol indices of block-scope statics' emission records pushed
    /// while the current function body parses. Function close stamps
    /// each record's `owner_ent_pc` (mirrors `pending_block_locals`).
    pending_block_static_syms: Vec<usize>,
    /// Suffix counter for `name.<n>` emission records.
    next_block_static_id: usize,

    /// Original `(source, opts)` snapshot captured in `with_options`
    /// when auto-include retry is permitted. On a "unknown function
    /// `name`" error during [`Self::compile`] the snapshot is
    /// re-used: the header that declares `name` (looked up in
    /// `headers::header_declaring`) is appended to
    /// `opts.force_includes` and a fresh `Compiler` runs the source
    /// from scratch. C99 7.1.4p2 lets standard library functions be
    /// referenced without a prior declaration; this turns that
    /// permission into an actually-working build for fixtures that
    /// rely on it. `None` after the first retry attempt, so the
    /// recursion bottoms out at one level.
    retry_state: Option<(String, CompileOptions)>,

    /// The first pass's recorded preprocessor state, letting a retry
    /// reuse that pass instead of re-preprocessing when the appended
    /// force-include provably cannot change it.
    pp_reuse: Option<PpReuse>,
}

/// Header of `__builtin_*` thunks every translation unit is given; see
/// [`Compiler::configure_preprocessor`].
const BUILTIN_THUNK_HEADER: &str = "_builtins.h";

impl Compiler {
    /// Construct a compiler for the default target (the host).
    /// Equivalent to `Compiler::with_target(source,
    /// Target::default_target())`. Most tests reach for this; the
    /// CLI uses the explicit-target form so `--target=` flows
    /// through to the codegen.
    pub fn new(source: String) -> Self {
        Self::with_target(source, Target::default_target())
    }

    /// Construct a compiler for a specific native target with all
    /// driver options left at their defaults.
    pub fn with_target(source: String, target: Target) -> Self {
        Self::with_options(source, target, CompileOptions::default())
    }

    /// The gcc `-H`-shape include trace. Empty when constructed
    /// without `CompileOptions::with_track_includes(true)`.
    pub fn include_trace(&self) -> Vec<String> {
        self.include_records
            .iter()
            .map(IncludeRecord::trace_line)
            .collect()
    }

    /// The recorded `#include` resolutions, in directive order.
    /// Feeds `depfile::prerequisites` for the `-M` flag family.
    pub fn include_records(&self) -> &[IncludeRecord] {
        &self.include_records
    }

    /// The preprocessing failure deferred from construction, if any.
    /// `compile` reports it too; a caller that stops at the
    /// preprocessor (`-M` / `-MM`) reads it here instead.
    pub fn preprocess_error(&self) -> Option<&C5Error> {
        self.deferred_error.as_ref()
    }

    /// Diagnostics the preprocessor produced. `compile` folds these
    /// into `Program::text_diagnostics`; a caller that stops at the
    /// preprocessor reads them here.
    pub fn preprocess_warnings(&self) -> &[String] {
        &self.text_diagnostics
    }

    /// Catalogued diagnostics reported so far. Construction reports the
    /// ones that come out of the `#pragma` set, before any parse.
    pub fn diagnostics(&self) -> &[crate::c5::diag::Diagnostic] {
        self.sink.diagnostics()
    }

    /// Construct a compiler with the full set of preprocessor /
    /// driver knobs bundled into a [`CompileOptions`] struct.
    /// This is the single shared implementation behind every
    /// `Compiler::new` and `Compiler::with_target` callable;
    /// callers that need `-D` / `-I` / `-include` / source-label
    /// / `-H` flags reach for this directly.
    ///
    /// Preprocessor failures (unterminated `#if`, duplicate
    /// `#else`, ...) are stored on the struct and surfaced when
    /// [`Self::compile`] runs -- this keeps the construction API
    /// infallible so the `Compiler::new(src).compile()` shape
    /// every existing caller uses keeps working.
    /// Run the preprocessor on `source` with the same setup
    /// `with_options` performs and return the expanded text. Used
    /// by the `--dump-pp` / `-E` CLI mode to surface what the
    /// lexer is about to see, without paying for the parse / codegen
    /// passes. Errors propagate via `Result` rather than the
    /// deferred-error channel because the caller has no compiler
    /// state to attach them to.
    pub fn preprocess(
        source: String,
        target: Target,
        opts: CompileOptions,
    ) -> Result<String, C5Error> {
        Self::preprocess_tracked(source, target, opts).map(|(text, _)| text)
    }

    /// As [`Self::preprocess`], also returning the include records the run
    /// opened. The assembler driver needs both from one pass: the expanded
    /// text to assemble and the records to render `-M` dependencies from.
    pub fn preprocess_tracked(
        source: String,
        target: Target,
        opts: CompileOptions,
    ) -> Result<(String, Vec<IncludeRecord>), C5Error> {
        let mut pp = Self::configure_preprocessor(target, &opts);
        let text = pp.process(&source)?;
        Ok((text, pp.include_records))
    }

    /// Assemble one GNU-as source unit for `target`, yielding the program the
    /// object writers consume. The unit routes through the same
    /// section-directive engine as a file-scope `asm("...")`, so the two
    /// accept the same constructs and diagnose the rest identically.
    pub fn assemble(text: &str, target: Target, opts: CompileOptions) -> Result<Program, C5Error> {
        let label = opts.source_label.clone();
        // No C source and no retry state: the auto-include retry rebuilds
        // from the source string, which would drop the ingested unit.
        let mut this = Self::build("", target, opts);
        this.ingest_file_scope_asm(text, false)
            .map_err(|m| C5Error::Compile(alloc::format!("{label}: error: {m}")))?;
        let mut program = this.compile_one_pass()?;
        // The reserved `.data` prefix keeps a c5 global's address away from
        // the null pointer. An assembled unit has no C source and so no c5
        // global; every byte it defines lives in an asm section, leaving the
        // prefix as eight bytes of `.data` GNU as does not emit.
        program.data.clear();
        Ok(program)
    }

    /// Construct a `Preprocessor` from `opts`. Shared by the `-E`
    /// dump path and the compile path, which differ only in how they
    /// drive `process()` afterward.
    fn configure_preprocessor(target: Target, opts: &CompileOptions) -> Preprocessor {
        let mut pp = Preprocessor::new(target.id_str(), target, env!("CARGO_PKG_VERSION"));
        // The `-W` family governs this pass's diagnostics too; the
        // pragmas it records then refine them per position.
        pp.sink.set_config(opts.diag.clone());
        // `-m16` / `-m32` reach the front end as an ELFCLASS32 object;
        // gcc preprocesses those units with the i386 predefine set.
        // `-mcmodel` moves the `__code_model_*__` name the same way, and
        // `-fshort-wchar` the `wchar_t` pair.
        pp.set_unit_model(opts.elf_class, opts.code_model, opts.short_wchar);
        pp.set_plain_char_signed(opts.plain_char_signed(target));
        if opts.gnu {
            pp.enable_gnu(opts.gnu89_inline, !opts.gnu_dialect);
        }
        pp.set_source_label(&opts.source_label);
        pp.set_track_includes(opts.track_includes);
        pp.set_asm_source(opts.asm_source);
        for path in &opts.include_paths {
            pp.add_search_path(path);
        }
        for path in &opts.quote_include_paths {
            pp.add_quote_path(path);
        }
        for path in &opts.system_include_paths {
            pp.add_system_fallback_path(path);
        }
        for path in &opts.own_header_roots {
            pp.add_own_header_root(path);
        }
        pp.set_nostdinc(opts.nostdinc);
        pp.set_no_builtin(opts.no_builtin);
        // The GCC `__builtin_*` library thunks, which gcc and clang give
        // every unit with no `#include`. The header is only `#define`s of
        // names C99 7.1.3 reserves to the implementation, so it declares
        // nothing and orders nothing; supplying it up front rather than
        // on a parse failure keeps the compile to one front-end pass. It
        // goes ahead of the driver's `-include` list because a forced
        // include may itself be a translation unit's body, and the thunks
        // have to be visible to it as they are to the main source.
        if !opts
            .force_includes
            .iter()
            .any(|h| h == BUILTIN_THUNK_HEADER)
        {
            pp.add_force_include(BUILTIN_THUNK_HEADER);
        }
        for name in &opts.force_includes {
            pp.add_force_include(name);
        }
        // `-O` predefines, installed before the CLI lists so an explicit
        // `-D NDEBUG=<v>` overrides the value and `-U NDEBUG` removes it.
        if opts.optimize {
            pp.define("NDEBUG", "1");
            pp.define("__OPTIMIZE__", "1");
        }
        for (name, body) in &opts.defines {
            pp.define(name, body);
        }
        for name in &opts.undefines {
            pp.undef(name);
        }
        pp
    }

    /// Reserve `n_slots` eight-byte frame cells and return the
    /// negative base offset, bumping the high-water mark. Callers
    /// own any `multi_cell_temps` push and any `loc_offs` recycle.
    pub(super) fn reserve_slots(&mut self, n_slots: i64) -> i64 {
        self.loc_offs += n_slots;
        if self.loc_offs > self.max_loc_offs {
            self.max_loc_offs = self.loc_offs;
        }
        -self.loc_offs
    }

    /// Mark the block-lifetime storage based at `base` (the most negative
    /// slot of the object) as committed, so the call-argument staging
    /// recycle cannot reclaim it while evaluating an enclosing expression.
    pub(super) fn commit_block_slot(&mut self, base: i64) {
        self.committed_loc_offs = self.committed_loc_offs.max(-base);
    }

    pub fn with_options(source: String, target: Target, opts: CompileOptions) -> Self {
        // The retry re-runs the compile from this source, so it is kept
        // rather than copied; only the options, which the retry extends
        // with a force-include, need a copy. Recording for pass reuse is
        // skipped when the retry itself is off (mirroring `compile`).
        let retry_opts = opts.clone();
        let record = !(opts.nostdinc || opts.no_builtin);
        let mut this = Self::build_recording(&source, target, opts, record);
        this.retry_state = Some((source, retry_opts));
        this
    }

    fn build(source: &str, target: Target, opts: CompileOptions) -> Self {
        Self::build_recording(source, target, opts, false)
    }

    /// Run the preprocessor and construct the compiler. With `record`,
    /// the run additionally captures the reuse state the auto-include
    /// retry consults ([`Self::build_retry`]).
    fn build_recording(source: &str, target: Target, opts: CompileOptions, record: bool) -> Self {
        // Run the preprocessor first so we know the
        // `#pragma binding(...)` set before seeding the symbol
        // table. The bindings come from whichever standard headers
        // the source `#include`s (or doesn't); a fixture that needs
        // `printf` but skips `<stdio.h>` will fail with a clear
        // "no `#pragma binding(... ::printf, ...)` is in scope"
        // error out of the codegen's import resolver, not a
        // mysterious link-time mismatch.
        let mut pp = Self::configure_preprocessor(target, &opts);
        #[cfg(feature = "codegen_test")]
        let pp_start = std::time::Instant::now();
        let (preprocessed, pp_reuse, deferred_error) = if record {
            match pp.process_recording(source) {
                Ok((s, cache)) => (s, Some(cache), None),
                Err(e) => (String::new(), None, Some(e)),
            }
        } else {
            match pp.process(source) {
                Ok(s) => (s, None, None),
                Err(e) => (String::new(), None, Some(e)),
            }
        };
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_TIME_PASSES").is_ok() {
            eprintln!("pass: preprocess -- {}us", pp_start.elapsed().as_micros());
        }
        let mut this = Self::finish_build(pp, preprocessed, deferred_error, target, opts);
        this.pp_reuse = pp_reuse;
        this
    }

    /// One auto-include retry pass: reuse the recorded first pass when
    /// the appended force-include provably cannot change it, else run a
    /// full build from source.
    fn build_retry(
        source: &str,
        target: Target,
        opts: CompileOptions,
        prior: Option<&PpReuse>,
    ) -> Self {
        if let Some(prior) = prior {
            let mut pp = Self::configure_preprocessor(target, &opts);
            #[cfg(feature = "codegen_test")]
            let pp_start = std::time::Instant::now();
            if let Some(text) = pp.process_reusing(prior) {
                #[cfg(feature = "codegen_test")]
                if std::env::var("BADC_TIME_PASSES").is_ok() {
                    eprintln!(
                        "pass: preprocess (source pass reused) -- {}us",
                        pp_start.elapsed().as_micros()
                    );
                }
                return Self::finish_build(pp, text, None, target, opts);
            }
        }
        Self::build(source, target, opts)
    }

    /// Construct the compiler from a finished preprocessor run.
    fn finish_build(
        pp: Preprocessor,
        preprocessed: String,
        deferred_error: Option<C5Error>,
        target: Target,
        opts: CompileOptions,
    ) -> Self {
        // Debug knob: when BADC_DUMP_PP is set, write the post-
        // preprocessor source to /tmp/badc-pp.c so the exact token
        // stream the lexer is about to see can be inspected. Read
        // only under the `codegen_test` feature so a production build
        // never consults the environment.
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_DUMP_PP").is_ok() {
            let _ = std::fs::write("/tmp/badc-pp.c", &preprocessed);
        }
        let dylibs = pp.dylibs;
        let pending_exports = pp.exports;
        // The preprocessor now records diagnostics rather than strings;
        // they reach the driver through `Program::text_diagnostics`, which
        // keeps their position ahead of the parser's warnings.
        // TODO: carry them as diagnostics once the ordering is settled.
        let pp_warnings: Vec<String> = pp
            .sink
            .diagnostics()
            .iter()
            .map(ToString::to_string)
            .collect();
        // The diagnostic pragmas the preprocessor recorded are keyed on
        // byte offsets into `preprocessed`, which is what the lexer
        // reads, so they govern the parser's diagnostics as well.
        let pp_control = pp.sink.into_control();
        let pp_include_records = pp.include_records;
        let pp_entrypoint = pp.entrypoint;
        let pp_subsystem = pp.subsystem;
        let pp_intrinsics = pp.intrinsics;

        let mut symbols = Vec::new();
        let mut symbol_index = lexer::SymbolIndex::new();
        let shadowed = lexer::init_symbols(&mut symbols, &mut symbol_index, &dylibs);
        // The dead-store bookkeeping is a cost the parser pays only when
        // the row reports somewhere, which a pragma decides as much as
        // the command line does.
        let warn_dead_store = opts.diag.level(crate::c5::diag::Code::DEAD_STORE)
            != crate::c5::diag::Level::Ignore
            || pp_control.may_report(crate::c5::diag::Code::DEAD_STORE);
        let mut sink = crate::c5::diag::Sink::new(opts.diag.clone(), pp_control);
        for b in shadowed {
            sink.emit(
                crate::c5::diag::Code::SHADOWED_BINDING,
                None,
                format!(
                    "`#pragma binding({}::{}, \"{}\")` is shadowed by an earlier \
                     binding from `{}`; the later binding is ignored. Remove or \
                     reorder one of the two.",
                    b.dylib, b.local_name, b.real_symbol, b.kept_dylib
                ),
            );
        }

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

        let lex = {
            let mut l = Lexer::new(preprocessed);
            // Wide literals take their element width, and `L'...'` its
            // type, from the target's `wchar_t`.
            let wchar = target.wchar_type(opts.short_wchar);
            l.wchar_bytes = wchar.bytes;
            l.wchar_signed = wchar.signed;
            l.char_signed = opts.plain_char_signed(target);
            l
        };
        Self {
            lex,
            symbols,
            symbol_index,
            scope_bound: Vec::new(),
            block_scopes: Vec::new(),
            deferred_error,
            dylibs,
            warned_implicit_ret: alloc::collections::BTreeSet::new(),
            target,
            next_ent_pc: 0,
            data,
            data_object_starts: Vec::new(),
            const_data_ranges: Vec::new(),
            data_pad_ranges: Vec::new(),
            data_align_marks: Vec::new(),
            flex_array_measured_count: None,
            ty: 0,
            loc_offs: 0,
            committed_loc_offs: 0,
            max_loc_offs: 0,
            multi_cell_temps: alloc::vec::Vec::new(),
            func_over_aligned: alloc::vec::Vec::new(),
            func_local_addr_taken: false,
            uses_alloca_in_current_fn: false,
            func_vla_decls: 0,
            stmt_expr_arena_ranges: Vec::new(),
            pending_is_inline: false,
            pending_is_always_inline: false,
            pending_is_noinline: false,
            pending_saw_inline_specifier: false,
            pending_is_gnu_inline: false,
            pending_is_naked: false,
            pending_noreturn: false,
            const_unevaluated: 0,
            const_object_fold: 0,
            static_duration_init: 0,
            ast: super::ast::Ast::new(),
            ast_acc: None,
            ast_vstack: Vec::new(),
            finished_functions: Vec::new(),
            synthetic_ssa_funcs: Vec::new(),
            pending_local_init_ast: None,
            pending_local_aggregate_ast: None,
            pending_local_runtime_elements: Vec::new(),
            loop_break_depth: 0,
            loop_continue_depth: 0,
            nest_depth: 0,
            labels: hashbrown::HashMap::new(),
            unresolved_gotos: Vec::new(),
            local_label_scopes: LocalLabelScopes::default(),
            switch_cases: Vec::new(),
            switch_defaults: Vec::new(),
            structs: Vec::new(),
            tag_scopes: alloc::vec![alloc::vec::Vec::new()],
            enums: Vec::new(),
            sink,
            text_diagnostics: pp_warnings,
            file_asm: Vec::new(),
            asm_weak_names: Vec::new(),
            asm_global_names: Vec::new(),
            asm_visibility: Vec::new(),
            asm_sym_sets: Vec::new(),
            asm_file_names: Vec::new(),
            asm_idents: Vec::new(),
            asm_validate_sink: Default::default(),
            include_records: pp_include_records,
            pp_entrypoint,
            pp_subsystem,
            pp_intrinsics,
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            extern_data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            tls_data_relocs: Vec::new(),
            tls_data_reloc_sym_idx: Vec::new(),
            tls_extern_data_relocs: Vec::new(),
            tls_code_relocs: Vec::new(),
            tls_code_reloc_sym_idx: Vec::new(),
            pending_label_relocs: Vec::new(),
            in_function_body: false,
            pending_exports,
            init_funcs: Vec::new(),
            function_aliases: Vec::new(),
            pending_aliases: Vec::new(),
            pending_incomplete_objects: Vec::new(),
            pending_asm_globl: Vec::new(),
            current_func_return_ty: 0,
            current_func_returns_void: false,
            current_func_conv: crate::c5::codegen::CallConv::Target,
            pending: Pending::default(),
            pending_store_symbols: Vec::new(),
            warn_dead_store,
            no_entry_point: opts.no_entry_point,
            data_align: 8,
            implicit_extern_fns: opts.implicit_extern_fns.clone(),
            export_all_functions: opts.export_all_functions,
            no_builtin: opts.no_builtin,
            nostdinc: opts.nostdinc,
            auto_var_init: opts.auto_var_init,
            no_builtin_fns: opts.no_builtin_fns.clone(),
            optimize: opts.optimize,
            elf_class: opts.elf_class,
            inline_model: if opts.gnu89_inline {
                crate::c5::symbol::InlineModel::Gnu89
            } else {
                crate::c5::symbol::InlineModel::C99
            },
            strict_flex_arrays: opts.strict_flex_arrays,
            source_files: Vec::new(),
            source_file_index: hashbrown::HashMap::new(),
            source_label: opts.source_label.clone(),
            asm_unit: opts.asm_source,
            variables: Vec::new(),
            pending_block_locals: Vec::new(),
            cleanup_scopes: Vec::new(),
            break_cleanup_depths: Vec::new(),
            continue_cleanup_depths: Vec::new(),
            current_function_name: String::new(),
            code_reloc_sym_idx: Vec::new(),
            sys_trampoline_sym: alloc::collections::BTreeMap::new(),
            glo_imm_refs: alloc::vec::Vec::new(),
            data_reloc_sym_idx: alloc::vec::Vec::new(),
            init_reloc_slots: alloc::collections::BTreeSet::new(),
            next_compound_literal_id: 0,
            staged_literal_syms: Vec::new(),
            func_name_objects: Vec::new(),
            next_func_name_id: 0,
            pending_block_static_syms: Vec::new(),
            next_block_static_id: 0,
            retry_state: None,
            pp_reuse: None,
        }
    }

    /// Resolve the ent_pcs for the program entry point
    /// (`main` or the `#pragma entrypoint(<name>)` override) and
    /// for an optional user-defined `DllMain`.
    ///
    /// `main` is optional today: shared-library output
    /// (`OutputKind::SharedLibrary`) doesn't need an entry point,
    /// and the executable-output writer surfaces a clear error if
    /// `entry_pc` doesn't land on real code. When neither `main`,
    /// any `#pragma export(...)`, nor a user-defined `DllMain` is
    /// present we still refuse, since the result would be an
    /// image with no callable entries at all.
    ///
    /// `#pragma entrypoint(<name>)` overrides the canonical
    /// `main`. The override goes through the same symbol-table
    /// lookup so the diagnostic is uniform: a missing entrypoint
    /// always reads `<name>() not defined`.
    ///
    /// A user-defined `DllMain` (any source-level function with
    /// that exact name) overrides the boilerplate `mov eax, 1;
    /// ret` DllMain stub the PE shared-library writer otherwise
    /// emits. We record the ent_pc here unconditionally --
    /// the VM / JIT / non-PE writers ignore it, and the PE writer
    /// only consults it for `--shared` builds. No signature
    /// validation: c5 trusts user `main` the same way and DllMain
    /// is just a different ABI.
    fn resolve_entry_and_dllmain_pcs(
        &self,
    ) -> Result<(usize, Option<usize>, Option<String>), C5Error> {
        let pragma_name = self.pp_entrypoint.as_deref();
        let default_name: &str = pragma_name.unwrap_or("main");
        let lookup_fun = |name: &str| {
            lexer::find_symbol(&self.symbols, &self.symbol_index, name)
                .filter(|&idx| self.symbols[idx].class == Token::Fun as i64)
        };
        // Without `#pragma entrypoint(<name>)`, accept any of
        // `main` / `wmain` / `WinMain` / `wWinMain` in that
        // priority order.
        let resolved_idx = lookup_fun(default_name).or_else(|| {
            if pragma_name.is_some() {
                None
            } else {
                ["wmain", "WinMain", "wWinMain"]
                    .iter()
                    .find_map(|&n| lookup_fun(n).map(|idx| (n, idx)))
                    .map(|(_, idx)| idx)
            }
        });

        let dllmain_idx = lexer::find_symbol(&self.symbols, &self.symbol_index, "DllMain");
        let has_user_dllmain =
            dllmain_idx.is_some_and(|idx| self.symbols[idx].class == Token::Fun as i64);

        let (entry_pc, entry_name) = match resolved_idx {
            Some(idx) => (
                self.symbols[idx].val as usize,
                Some(self.symbols[idx].link_name().into()),
            ),
            None if !self.pending_exports.is_empty() || has_user_dllmain || self.no_entry_point => {
                (0, None)
            }
            None => {
                return Err(self.compile_err(format!("{default_name}() not defined")));
            }
        };
        let dllmain_pc =
            dllmain_idx.and_then(|idx| has_user_dllmain.then(|| self.symbols[idx].val as usize));
        Ok((entry_pc, dllmain_pc, entry_name))
    }

    /// Resolve `#pragma export(<name>)` directives against the
    /// now-finalised symbol table. Each name must resolve to a
    /// `Token::Fun` (a function defined in this translation
    /// unit); anything else gets a clear diagnostic so a
    /// misspelled export doesn't silently produce a shared object
    /// missing the symbol the user expected.
    ///
    /// Drains `self.pending_exports` -- callers should only invoke
    /// once on the way out of `compile()`.
    fn resolve_exports(&mut self) -> Result<Vec<crate::c5::program::ExportedFunction>, C5Error> {
        let mut exports = Vec::with_capacity(self.pending_exports.len());
        for name in core::mem::take(&mut self.pending_exports) {
            let Some(idx) = lexer::find_symbol(&self.symbols, &self.symbol_index, &name) else {
                return Err(self.compile_err(format!(
                    "`#pragma export({name})` -- no such symbol; the name must \
                     refer to a function defined in this source"
                )));
            };
            if self.symbols[idx].class != Token::Fun as i64 {
                return Err(self.compile_err(format!(
                    "`#pragma export({name})` -- expected a function, but `{name}` \
                     is class {} (only locally-defined functions are exportable today; \
                     globals would need data-export support that isn't wired up yet)",
                    self.symbols[idx].class
                )));
            }
            exports.push(crate::c5::program::ExportedFunction {
                name,
                ent_pc: self.symbols[idx].val as usize,
            });
        }
        // For a `--shared` build, export every non-static function
        // defined in this unit, matching the default visibility a
        // system toolchain gives a shared library: a runtime `dlopen`
        // consumer resolves an entry point (e.g. a module init
        // function) by name without a source-level pragma.
        // Functions named by `#pragma export` above are skipped here to
        // avoid duplicate export entries.
        if self.export_all_functions {
            use crate::c5::symbol::Linkage;
            for idx in 0..self.symbols.len() {
                let sym = &self.symbols[idx];
                if sym.class != Token::Fun as i64
                    || sym.linkage != Linkage::External
                    || !sym.defined_here
                {
                    continue;
                }
                if exports.iter().any(|e| e.name == sym.link_name()) {
                    continue;
                }
                exports.push(crate::c5::program::ExportedFunction {
                    name: sym.link_name().into(),
                    ent_pc: sym.val as usize,
                });
            }
        }
        Ok(exports)
    }

    /// Recover the function name from a compile error whose
    /// message has the shape ``unknown function `<name>`...``,
    /// returning `None` for any other error. Used to drive the
    /// auto-include retry in [`Self::compile`] -- a parser-level
    /// "unknown function" lands in `C5Error::Compile(_)` with the
    /// matching text, and `header_declaring` keys off the
    /// extracted name to pick the right `#include`.
    fn parse_unknown_function_name_from(err: &C5Error) -> Option<String> {
        let msg = match err {
            C5Error::Compile(m) => m,
            _ => return None,
        };
        let start = msg.find("unknown function `")? + "unknown function `".len();
        let rest = &msg[start..];
        let end = rest.find('`')?;
        Some(rest[..end].to_string())
    }

    /// Compile the source. On success, the returned `Program`
    /// carries the per-function SSA + static data segment + the
    /// ent_pc of `main`.
    ///
    /// Auto-include retry: when the first pass fails with
    /// `unknown function `name`` and `name` is declared by one of
    /// the embedded standard headers (per `headers::header_declaring`
    /// + the build-time index in `BINDING_TO_HEADER`), this method
    /// transparently re-runs the compile with the matching header
    /// force-included. C99 7.1.4p2 lets standard library functions
    /// be used without a prior declaration; this turns that
    /// permission into a successful build instead of a friendly
    /// error. The retry runs only once -- a second-pass failure
    /// propagates the original error.
    pub fn compile(mut self) -> Result<Program, C5Error> {
        let retry_state = self.retry_state.take();
        let pp_reuse = self.pp_reuse.take();
        let target = self.target;
        let mut result = self.compile_one_pass();
        let Some((source, mut opts)) = retry_state else {
            return result;
        };
        // C99 7.1.4p2's permission to use a library function without a
        // declaration is a hosted-implementation one, and the header it
        // would splice in is off the search under `-nostdinc`. The
        // undeclared-function error stands instead.
        if opts.nostdinc || opts.no_builtin {
            return result;
        }
        // Auto-include retry. Each pass that fails on an undeclared
        // function names the header declaring it; force-include that
        // header and run again. Looping (rather than retrying once)
        // resolves a chain -- a `__builtin_*` thunk header pulling in
        // the library function's header -- and several independent
        // missing headers. The force-include set only grows, and a
        // header already in it ends the loop, so progress is monotone.
        let mut infos: Vec<String> = Vec::new();
        let mut auto_names: Vec<String> = Vec::new();
        loop {
            let e = match result {
                Ok(mut prog) => {
                    // Surface each recovery through the same diagnostic
                    // pipeline the CLI colourises (`info:` -> bold
                    // green), oldest first above the retry pass's own
                    // warnings.
                    for info in infos.into_iter().rev() {
                        prog.text_diagnostics.insert(0, info);
                    }
                    prog.auto_includes = auto_names;
                    return Ok(prog);
                }
                Err(e) => e,
            };
            let Some(name) = Self::parse_unknown_function_name_from(&e) else {
                return Err(e);
            };
            let header = match super::headers::header_declaring(&name) {
                Some(h) => h,
                None => return Err(e),
            };
            // The thunk header is always in scope, so a failure naming
            // one of its macros is not something a retry can fix.
            if header == BUILTIN_THUNK_HEADER || opts.force_includes.iter().any(|h| h == header) {
                return Err(e);
            }
            opts.force_includes.push(header.to_string());
            infos.push(format!(
                "info: auto-including <{header}> for undeclared `{name}`"
            ));
            auto_names.push(name);
            result = Self::build_retry(&source, target, opts.clone(), pp_reuse.as_ref())
                .compile_one_pass();
        }
    }

    /// C99 6.9.2: a tentative definition and the later defining declaration
    /// denote one object. A definition that did not fit the tentative's
    /// reservation took fresh storage, leaving the references emitted before
    /// it addressing the abandoned slot. Move them onto the definition:
    /// identifier snapshots in the parsed functions, and the pointer
    /// initializers already written into the data segment. Only object base
    /// addresses reach either channel, and the abandoned slot holds no other
    /// object, so the byte range identifies the relocated object alone.
    fn rebase_relocated_globals(&mut self) {
        let moves: Vec<(i64, i64, i64)> = self
            .symbols
            .iter()
            .filter_map(|s| {
                let (old_off, old_bytes) = s.relocated_from?;
                (s.val != old_off).then_some((old_off, old_bytes, s.val))
            })
            .collect();
        if moves.is_empty() {
            return;
        }
        let remap = RelocatedGlobals(moves.clone());
        for f in &mut self.finished_functions {
            use crate::c5::layout::DataOffsets;
            f.ast.remap_data_offsets(&remap);
        }
        for r in &mut self.data_relocs {
            let Some(&(old, _, new)) = moves.iter().find(|m| m.0 == r.target_anchor as i64) else {
                continue;
            };
            let target = r.target_offset as i64 - old + new;
            r.target_offset = target as u64;
            r.target_anchor = new as u64;
            let at = r.data_offset as usize;
            self.data[at..at + 8].copy_from_slice(&(target as u64).to_le_bytes());
        }
        for r in &mut self.tls_data_relocs {
            let Some(&(old, _, new)) = moves.iter().find(|m| m.0 == r.target_anchor as i64) else {
                continue;
            };
            let target = r.target_offset as i64 - old + new;
            r.target_offset = target as u64;
            r.target_anchor = new as u64;
            let at = r.data_offset as usize;
            self.tls_data[at..at + 8].copy_from_slice(&(target as u64).to_le_bytes());
        }
        for s in &mut self.symbols {
            s.relocated_from = None;
        }
    }

    /// Run the full compile pipeline once with no auto-include
    /// retry. Shared by [`Self::compile`] (first pass) and by the
    /// retry branch inside the same method.
    fn compile_one_pass(mut self) -> Result<Program, C5Error> {
        if let Some(e) = self.deferred_error.take() {
            return Err(e);
        }
        #[cfg(feature = "codegen_test")]
        let parse_start = std::time::Instant::now();
        self.run_compile()?;
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_TIME_PASSES").is_ok() {
            eprintln!(
                "pass: run_compile (parse + AST build) -- {}us",
                parse_start.elapsed().as_micros()
            );
        }
        #[cfg(feature = "codegen_test")]
        let post_start = std::time::Instant::now();
        // Trampolines must land before the code-reloc resolve
        // pass: every static-init function-pointer site that
        // names a libc symbol references its trampoline by
        // sym idx, and `resolve_code_relocs` reads the
        // trampoline's `Symbol::val` (set during
        // `emit_sys_trampolines`) to backfill each CodeReloc's
        // `target_ent_pc`.
        self.emit_sys_trampolines();
        self.resolve_code_relocs()?;
        // Cross-TU / undefined extern linkage. One model for every
        // consumer: the linker resolves the references, the VM and
        // the JIT refuse the unresolved ones, and no mode falls
        // back to phantom storage or a colliding pc.
        //
        // Every extern-declared `Token::Fun` symbol with no body in
        // this TU gets a unique placeholder ent_pc (past
        // `text.len()`), then has `Symbol::val` rewritten to that
        // PC. The walker reads `Symbol::val` through `live_fun_val`
        // when lowering an `Inst::Call`, so the matching call site
        // carries the placeholder as its `target_pc`. The native
        // codegen detects the placeholder (outside `[0,
        // text.len())`) and emits a `RelocCallSite` against the
        // symbol's name instead of resolving in place.
        let extern_imports = {
            use crate::c5::symbol::Linkage;
            let mut imports: alloc::vec::Vec<(usize, String)> = alloc::vec::Vec::new();
            let mut next_pc = self.next_ent_pc + 1;
            for sym in self.symbols.iter_mut() {
                // `is_fun_entity`: a scoped function declaration keeps
                // its entity on the slot after the name unbinds; it
                // still needs an import placeholder for its calls.
                if !sym.is_fun_entity() || sym.defined_here || sym.linkage != Linkage::External {
                    continue;
                }
                imports.push((next_pc, sym.link_name().into()));
                sym.val = next_pc as i64;
                next_pc += 1;
            }
            // C99 6.2.2p2: an inline definition's identifier keeps
            // external linkage, so `&f` must denote the program's one
            // definition. The body carries `inline_body_name`, so the
            // identifier is free to take an import placeholder; `val`
            // keeps the real ent_pc and direct calls stay local. An
            // entry nothing references emits no symbol.
            for sym in self.symbols.iter_mut() {
                if !sym.is_fun_entity() || sym.inline_body_name.is_none() {
                    continue;
                }
                imports.push((next_pc, sym.link_name().into()));
                sym.inline_addr_pc = Some(next_pc as i64);
                next_pc += 1;
            }
            // C99 6.7.1 + 6.9.2: an `extern T x;` / `extern T
            // x[N];` declaration with no defining initializer in
            // this TU contributes no storage. The parser-time
            // tentative slot at `sym.val` is meaningless once the
            // unit is linked against the defining TU; clear it so
            // the walker's `live_glo_addr` returns
            // `GloAddr::Extern` and routes the address producer
            // through `imm_data_extern`. Without this clear, the
            // walker emits `Inst::ImmData(stale_offset)` and the
            // ET_REL writer lowers it as a `.data section symbol +
            // 0` reloc, losing the symbol identity needed for
            // cross-TU resolution. The same clear keeps a `#pragma
            // binding(data ...)` local (e.g. environ) undefined so
            // its references route through the GOT / loader import
            // instead of an uninitialized local slot.
            for sym in self.symbols.iter_mut() {
                if sym.class == Token::Glo as i64
                    && sym.linkage == Linkage::External
                    && sym.is_extern_decl
                    && !sym.has_initializer
                {
                    sym.defined_here = false;
                    sym.val = 0;
                }
            }
            // A pointer-to-data initializer parsed while its target was an
            // undefined extern was recorded by name. When this unit later
            // defines the object, rewrite the entry as a direct data
            // relocation: the reference must bind to the definition, not
            // surface as an import of a symbol the unit itself defines.
            let mut still_extern = alloc::vec::Vec::new();
            for r in core::mem::take(&mut self.extern_data_relocs) {
                let defined = self.symbols.iter().position(|s| {
                    s.class == Token::Glo as i64
                        && s.defined_here
                        && !s.is_thread_local
                        && s.link_name() == r.symbol_name
                });
                let Some(sym_idx) = defined else {
                    still_extern.push(r);
                    continue;
                };
                let target = self.symbols[sym_idx].val + r.addend;
                let off = r.data_offset as usize;
                self.data[off..off + 8].copy_from_slice(&(target as u64).to_le_bytes());
                self.data_relocs.push(crate::c5::program::DataReloc {
                    data_offset: r.data_offset,
                    target_offset: target as u64,
                    target_anchor: self.symbols[sym_idx].val as u64,
                });
                self.data_reloc_sym_idx.push(sym_idx);
            }
            self.extern_data_relocs = still_extern;
            // Same rewrite for a `_Thread_local` slot: only the segment the
            // slot lives in differs.
            let mut still_extern = alloc::vec::Vec::new();
            for r in core::mem::take(&mut self.tls_extern_data_relocs) {
                let defined = self.symbols.iter().position(|s| {
                    s.class == Token::Glo as i64
                        && s.defined_here
                        && !s.is_thread_local
                        && s.link_name() == r.symbol_name
                });
                let Some(sym_idx) = defined else {
                    still_extern.push(r);
                    continue;
                };
                let target = self.symbols[sym_idx].val + r.addend;
                let off = r.data_offset as usize;
                self.tls_data[off..off + 8].copy_from_slice(&(target as u64).to_le_bytes());
                self.tls_data_relocs.push(crate::c5::program::DataReloc {
                    data_offset: r.data_offset,
                    target_offset: target as u64,
                    target_anchor: self.symbols[sym_idx].val as u64,
                });
                self.tls_data_reloc_sym_idx.push(sym_idx);
            }
            self.tls_extern_data_relocs = still_extern;
            self.rebase_relocated_globals();
            // Record each defined object's byte size for the object
            // writers' symbol tables; the writers have no type layout.
            // An alias is sized like any other object: it took its
            // target's element count when it resolved.
            for i in 0..self.symbols.len() {
                let s = &self.symbols[i];
                if s.class != Token::Glo as i64 || !s.defined_here {
                    continue;
                }
                // A staged literal recorded its own reserved extent; its
                // `type_` describes one element.
                if s.is_compound_literal {
                    continue;
                }
                let elem = self.size_of_type(s.type_) as i64;
                let s = &mut self.symbols[i];
                s.data_byte_size = if s.is_zero_len_array {
                    0
                } else if s.array_size > 0 {
                    elem * s.array_size
                } else {
                    elem + s.fam_init_bytes
                };
            }
            // Function-pointer initializers (`int (*const fp)
            // (...) = some_fn;`) recorded a `code_relocs` row
            // whose `target_ent_pc` was the symbol's val at
            // parse time -- before the loop above assigned
            // placeholder PCs to extern callees. Refresh each
            // row whose source symbol is an extern function so
            // the ET_REL writer can identify it as a cross-TU
            // reference. Local code_relocs already carry the
            // function's ent_pc and keep it. An inline definition's
            // address takes the same route through `inline_addr_pc`:
            // the slot must hold the program's definition, not this
            // unit's body (C99 6.2.2p2).
            let addr_pc = |sym: &crate::c5::symbol::Symbol| -> Option<u64> {
                if let Some(pc) = sym.inline_addr_pc {
                    return Some(pc as u64);
                }
                (sym.is_fun_entity() && !sym.defined_here && sym.linkage == Linkage::External)
                    .then_some(sym.val as u64)
            };
            for (reloc, &sym_idx) in self
                .code_relocs
                .iter_mut()
                .zip(self.code_reloc_sym_idx.iter())
            {
                if sym_idx == usize::MAX || sym_idx >= self.symbols.len() {
                    continue;
                }
                if let Some(pc) = addr_pc(&self.symbols[sym_idx]) {
                    reloc.target_ent_pc = pc;
                }
            }
            for (reloc, &sym_idx) in self
                .tls_code_relocs
                .iter_mut()
                .zip(self.tls_code_reloc_sym_idx.iter())
            {
                if sym_idx == usize::MAX || sym_idx >= self.symbols.len() {
                    continue;
                }
                if let Some(pc) = addr_pc(&self.symbols[sym_idx]) {
                    reloc.target_ent_pc = pc;
                }
            }
            imports
        };
        let (entry_pc, dllmain_pc, resolved_entry_name) = self.resolve_entry_and_dllmain_pcs()?;
        let exports = self.resolve_exports()?;
        #[cfg(feature = "codegen_test")]
        if std::env::var("BADC_TIME_PASSES").is_ok() {
            eprintln!(
                "pass: compiler post-parse (trampolines, relocs, imports, exports) -- {}us",
                post_start.elapsed().as_micros()
            );
        }
        // `.set name, target` aliases from file-scope asm. The binding follows
        // the unit's `.globl` / `.weak` directives, in either order and from
        // either statement, so the object writer settles it.
        let mut function_aliases = self.function_aliases;
        for (name, target, addend) in self.asm_sym_sets {
            function_aliases.push(crate::c5::program::FunctionAlias {
                name,
                target,
                bind: crate::c5::program::AliasBind::Assigned,
                addend,
            });
        }
        Ok(Program {
            target: self.target,
            data: self.data,
            file_asm: self.file_asm,
            asm_weak_names: self.asm_weak_names,
            asm_global_names: self.asm_global_names,
            asm_visibility: self.asm_visibility,
            asm_unit: self.asm_unit,
            asm_file_names: self.asm_file_names,
            asm_idents: self.asm_idents,
            data_align: self.data_align,
            data_ro_len: 0,
            data_relro_len: 0,
            data_object_starts: self.data_object_starts,
            const_data_ranges: self.const_data_ranges,
            data_pad_ranges: self.data_pad_ranges,
            data_align_marks: self.data_align_marks,
            entry_pc,
            warnings: self.sink.take(),
            text_diagnostics: self.text_diagnostics,
            tls_data: self.tls_data,
            tls_init_size: self.tls_init_size,
            exports,
            data_relocs: self.data_relocs,
            extern_data_relocs: self.extern_data_relocs,
            code_relocs: self.code_relocs,
            tls_data_relocs: self.tls_data_relocs,
            tls_extern_data_relocs: self.tls_extern_data_relocs,
            tls_code_relocs: self.tls_code_relocs,
            dylibs: self.dylibs,
            dllmain_pc,
            source_files: self.source_files,
            // `source_label` carries the path the CLI passed at
            // `with_source_label`; mirror it onto the returned
            // `Program` so DWARF emitters that consume the path
            // (DW_AT_name on the CU DIE, line-program file 0)
            // don't surface empty fields when the caller forgets
            // to set it explicitly. Downstream emitters overwrite
            // the field when they have a more specific value.
            source_path: self.source_label.clone(),
            variables: self.variables,
            // Struct registry, exposed so the DWARF emitter can
            // walk member offsets / bitfield layouts and produce
            // `DW_TAG_structure_type` DIEs. The VM /
            // JIT / interpreter ignore this field.
            structs: self.structs,
            enums: self.enums,
            // Resolved entry name. Includes the value from a
            // source-level `#pragma entrypoint(<name>)` plus the
            // CRT-recognised fallbacks (`wmain`, `WinMain`,
            // `wWinMain`) chosen when `main` is absent.
            entry_name: resolved_entry_name,
            entry_pragma: self.pp_entrypoint.clone(),
            auto_includes: Vec::new(),
            subsystem: self.pp_subsystem,
            // Compile output is pre-optimizer; only the explicit
            // `optimize()` step flips this on.
            finished_functions: self.finished_functions,
            // Snapshot the symbol table for the SSA walker. Only
            // the `array_size` and `type_` fields are read today,
            // but cloning the full Symbol keeps the walker's view
            // in sync with any later field additions.
            symbols: self.symbols,
            synthetic_ssa_funcs: self.synthetic_ssa_funcs,
            // The single-TU compile path doesn't run the walker
            // eagerly; produce_ssa_funcs invokes it at codegen
            // time via finished_functions. Leave empty so the
            // codegen sees the walker as the source of truth.
            user_ssa_funcs: Vec::new(),
            extern_function_imports: extern_imports,
            init_funcs: self.init_funcs,
            function_aliases,
        })
    }
}

/// Objects a defining declaration moved off their tentative reservation,
/// as `(old offset, reserved bytes, new offset)`. Reuses the compaction
/// pass's offset surface so both rebases reach the same fields.
struct RelocatedGlobals(Vec<(i64, i64, i64)>);

impl RelocatedGlobals {
    fn shift(&self, off: i64) -> i64 {
        match self
            .0
            .iter()
            .find(|&&(old, bytes, _)| off >= old && off < old + bytes)
        {
            Some(&(old, _, new)) => new + (off - old),
            None => off,
        }
    }
}

impl crate::c5::layout::DataRemap for RelocatedGlobals {
    /// Every offset is a candidate: an object outside the move table
    /// shifts by zero.
    fn in_data(&self, _off: i64) -> bool {
        true
    }

    fn remap(&self, off: i64, _anchor: i64) -> Option<i64> {
        Some(self.shift(off))
    }

    fn remap_span(&self, lo: i64, hi: i64) -> Option<(i64, i64)> {
        Some((self.shift(lo), self.shift(lo) + (hi - lo)))
    }
}

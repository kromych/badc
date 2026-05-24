//! ELF (64-bit) writer for Linux/aarch64 executables.
//!
//! ## Layout
//!
//! ```text
//!   file                                                segment / contents
//!   ----------------------------------------------------------------------
//!   0x0000   ELF header (64 bytes)                       \
//!            Program headers (6 * 56 = 336 bytes)        |
//!            .interp ("/lib/ld-linux-aarch64.so.1\0")    |
//!            .dynsym (Elf64_Sym per import + sentinel)   | r-x PT_LOAD
//!            .dynstr (NUL-separated symbol names)        |
//!            .hash (DT_HASH bucket/chain table)          |
//!            .rela.dyn (R_AARCH64_GLOB_DAT entries)      |
//!            <pad to 16>                                 |
//!            _start stub + build.text                    |
//!            <pad to page>                               /
//!   0x1000   .dynamic (DT_* entries terminated DT_NULL)  \
//!            .got (8 bytes per import, zero-filled)      | rw  PT_LOAD
//!            build.data (program's static data segment)  |
//!            <pad to page>                               /
//! ```
//!
//! Six program headers describe the above:
//!   * PT_PHDR       -- the phdr table self-locating itself
//!   * PT_INTERP     -- "/lib/ld-linux-aarch64.so.1"
//!   * PT_LOAD r-x   -- header through code
//!   * PT_LOAD rw    -- .dynamic, .got, .data
//!   * PT_DYNAMIC    -- mirrors the .dynamic location
//!   * PT_GNU_STACK  -- non-exec stack marker
//!
//! ## Dynamic linking
//!
//! ET_EXEC + PT_INTERP. The loader (ld-linux-aarch64.so.1) maps both
//! PT_LOAD segments at their fixed vmaddrs (no slide -- ET_EXEC), then
//! walks .dynamic, finds DT_NEEDED `libc.so.6`, loads it, and uses
//! .rela.dyn to populate each .got slot with the resolved libc symbol
//! address (R_AARCH64_GLOB_DAT). DT_BIND_NOW forces eager binding so
//! the slots are filled before `_start` runs.
//!
//! The codegen's `adrp + ldr + blr` calls already point at the .got;
//! the writer just patches the immediates with the page-relative
//! offset of the matching GOT slot. Same scheme as the macOS Mach-O
//! writer (the codegen is platform-agnostic; only the writer differs).

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::program::Program;
use super::{Abi, Build, Machine};
use super::{aarch64, dwarf, x86_64};

// ------------------------------------------------------------------
// ELF constants. Names mirror `<elf.h>` so cross-checking is mechanical.
// ------------------------------------------------------------------

const EI_NIDENT: usize = 16;

const ELFMAG: [u8; 4] = [0x7F, b'E', b'L', b'F'];
const ELFCLASS64: u8 = 2;
const ELFDATA2LSB: u8 = 1;
const EV_CURRENT: u8 = 1;
const ELFOSABI_SYSV: u8 = 0;

const ET_EXEC: u16 = 2;
/// `ET_DYN` -- shared object / position-independent
/// executable. Used when `OutputKind::SharedLibrary` is in
/// effect; the loader (`dlopen`) maps the image at any
/// address and adds the runtime base to every absolute VA.
const ET_DYN: u16 = 3;

const EM_AARCH64: u16 = 183;
const EM_X86_64: u16 = 62;

const PT_LOAD: u32 = 1;
const PT_DYNAMIC: u32 = 2;
const PT_INTERP: u32 = 3;
const PT_PHDR: u32 = 6;
const PT_TLS: u32 = 7;
const PT_GNU_STACK: u32 = 0x6474_E551;

const PF_X: u32 = 1;
const PF_W: u32 = 2;
const PF_R: u32 = 4;

// .dynamic tag types we use.
const DT_NULL: u64 = 0;
const DT_NEEDED: u64 = 1;
const DT_HASH: u64 = 4;
const DT_STRTAB: u64 = 5;
const DT_SYMTAB: u64 = 6;
const DT_RELA: u64 = 7;
const DT_RELASZ: u64 = 8;
const DT_RELAENT: u64 = 9;
const DT_STRSZ: u64 = 10;
const DT_SYMENT: u64 = 11;
const DT_BIND_NOW: u64 = 24;
const DT_FLAGS: u64 = 30;

const DF_BIND_NOW: u64 = 0x8;

// nlist / Elf64_Sym fields.
/// `STB_LOCAL` -- file-local binding. Used by the
/// per-PLT-trampoline static symbols so they don't shadow
/// `.dynsym`'s loader-visible globals.
const STB_LOCAL: u8 = 0;
const STB_GLOBAL: u8 = 1;
/// `STT_FUNC` symbol type -- `st_info` low nibble for both
/// imported and exported functions. Imports use it so debuggers
/// (`gdb`, `lldb`) treat the dynamic-symbol entry as a callable
/// breakpoint target; exports use it so `dlsym` surfaces them as
/// code (dlsym only resolves `STT_FUNC` / `STT_NOTYPE`-non-undef
/// entries).
const STT_FUNC: u8 = 2;
const SHN_UNDEF: u16 = 0;

// Relocation types we emit.
const R_AARCH64_GLOB_DAT: u64 = 1025;
const R_X86_64_GLOB_DAT: u64 = 6;

/// Maximum supported page size, used both for `p_align` and for
/// VA spacing between adjacent `PT_LOAD` segments. Distros build
/// AArch64 Linux kernels with 4K, 16K, or **64K** pages, and the
/// kernel can only enforce distinct permissions at page
/// granularity. With a 64K-page kernel, two LOAD segments at e.g.
/// `0x400000` (R+E) and `0x406000` (RW) collapse into the same
/// kernel page; whichever permission the loader picks for that
/// page, one of the segments ends up wrong -- and `.text` ending
/// up non-executable manifests as `SIGSEGV (invalid permissions
/// for mapped object)` on the first instruction.
///
/// `binutils ld` defaults to `-z max-page-size=0x10000` on
/// AArch64 Linux for exactly this reason. We do the same, which
/// trades ~60K of file-size padding (ET_EXEC binaries gain one
/// 64K hole between the R+E and RW segments) for correctness on
/// all three page-size configurations.
const PAGE_SIZE: u64 = 0x10000;

/// Default load address for non-PIE ET_EXEC binaries on Linux/aarch64.
/// The kernel maps the binary at exactly this vmaddr (no slide); all
/// our .got slot addresses, e_entry, etc. are absolute and burned in.
const TEXT_VMADDR_BASE: u64 = 0x40_0000;

const ELF_HEADER_SIZE: u64 = 64;
const PROGRAM_HEADER_SIZE: u64 = 56;
/// Without TLS in the program. Programs that declare a
/// `_Thread_local` global add one more PT_TLS header (so a total of
/// 7).
const N_BASE_PROGRAM_HEADERS: u64 = 6;

const ELF64_SYM_SIZE: u64 = 24;
const ELF64_RELA_SIZE: u64 = 24;
const ELF64_DYN_SIZE: u64 = 16;
const ELF64_SHDR_SIZE: u64 = 64;

// Section header types we emit (Elf64_Shdr.sh_type).
const SHT_NULL: u32 = 0;
const SHT_PROGBITS: u32 = 1;
/// Static symbol table -- the file-only `.symtab` paired with
/// `.strtab`. Distinct from `SHT_DYNSYM` (the loader-side dynamic
/// symbol table). One local STT_FUNC per import is emitted via
/// this section so debuggers (`gdb`, `lldb`) and `nm` resolve
/// PLT trampoline addresses to a real name.
const SHT_SYMTAB: u32 = 2;
const SHT_STRTAB: u32 = 3;
const SHT_RELA: u32 = 4;
const SHT_HASH: u32 = 5;
const SHT_DYNAMIC: u32 = 6;
const SHT_DYNSYM: u32 = 11;

// Section header flags (Elf64_Shdr.sh_flags).
const SHF_WRITE: u64 = 0x1;
const SHF_ALLOC: u64 = 0x2;
const SHF_EXECINSTR: u64 = 0x4;

// ------------------------------------------------------------------
// On-disk shapes. `#[repr(C)]` with explicit fields plus a
// const-time `assert_eq!` on `size_of::<T>()` against the matching
// `ELF*_SIZE` constant; written via the same memcpy helper the PE
// writer uses. ELF is little-endian on all our targets, so a bare
// memcpy of the in-memory struct gives the right wire format.
// ------------------------------------------------------------------

/// Elf64_Ehdr -- the file header at offset 0.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Ehdr {
    e_ident: [u8; EI_NIDENT],
    e_type: u16,
    e_machine: u16,
    e_version: u32,
    e_entry: u64,
    e_phoff: u64,
    e_shoff: u64,
    e_flags: u32,
    e_ehsize: u16,
    e_phentsize: u16,
    e_phnum: u16,
    e_shentsize: u16,
    e_shnum: u16,
    e_shstrndx: u16,
}

const _: () = assert!(core::mem::size_of::<Elf64Ehdr>() == ELF_HEADER_SIZE as usize);

/// Elf64_Phdr -- one program-header table entry.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Phdr {
    p_type: u32,
    p_flags: u32,
    p_offset: u64,
    p_vaddr: u64,
    p_paddr: u64,
    p_filesz: u64,
    p_memsz: u64,
    p_align: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Phdr>() == PROGRAM_HEADER_SIZE as usize);

/// Elf64_Sym -- one entry in `.dynsym`.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Sym {
    st_name: u32,
    st_info: u8,
    st_other: u8,
    st_shndx: u16,
    st_value: u64,
    st_size: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Sym>() == ELF64_SYM_SIZE as usize);

/// Elf64_Rela -- one entry in `.rela.dyn`. Addend-bearing form of
/// the relocation record; we don't use the older addend-less
/// `Elf64_Rel`.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Rela {
    r_offset: u64,
    r_info: u64,
    r_addend: i64,
}

const _: () = assert!(core::mem::size_of::<Elf64Rela>() == ELF64_RELA_SIZE as usize);

/// Elf64_Dyn -- one entry in the `.dynamic` table. The tag field
/// names what the value means (`DT_NEEDED`, `DT_HASH`, ...); the
/// union shape from the C ABI is just two `u64`s on the wire.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Dyn {
    d_tag: u64,
    d_val: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Dyn>() == ELF64_DYN_SIZE as usize);

/// Elf64_Shdr -- one entry in the section header table. We emit
/// only enough to expose the four DWARF debug sections plus the
/// `.shstrtab` to lldb / gdb; the dynamic loader doesn't
/// need section headers, and `objdump -h` falls back to the
/// program-header view when none are present.
#[repr(C)]
#[derive(Copy, Clone)]
struct Elf64Shdr {
    sh_name: u32,
    sh_type: u32,
    sh_flags: u64,
    sh_addr: u64,
    sh_offset: u64,
    sh_size: u64,
    sh_link: u32,
    sh_info: u32,
    sh_addralign: u64,
    sh_entsize: u64,
}

const _: () = assert!(core::mem::size_of::<Elf64Shdr>() == ELF64_SHDR_SIZE as usize);

/// Append a `#[repr(C)]` struct's raw bytes to `out`. Same shape
/// the PE writer uses; see that module for the safety argument.
fn write_struct<T: Copy>(out: &mut Vec<u8>, value: &T) {
    const _: () = assert!(
        cfg!(target_endian = "little"),
        "ELF writer assumes a little-endian host; emit bytes manually if you need to cross-build from big-endian"
    );
    let bytes = unsafe {
        core::slice::from_raw_parts((value as *const T) as *const u8, core::mem::size_of::<T>())
    };
    out.extend_from_slice(bytes);
}

/// Dynamic linker path. Selected per machine: `aarch64` lives at
/// `/lib/`, x86_64 at `/lib64/`. Mirrors what the host distro
/// expects.
fn interp_path(machine: Machine) -> &'static str {
    match machine {
        Machine::Aarch64 => "/lib/ld-linux-aarch64.so.1",
        Machine::X86_64 => "/lib64/ld-linux-x86-64.so.2",
    }
}

/// `e_machine` field in the ELF header.
fn e_machine(machine: Machine) -> u16 {
    match machine {
        Machine::Aarch64 => EM_AARCH64,
        Machine::X86_64 => EM_X86_64,
    }
}

/// `R_*_GLOB_DAT` relocation type: stores the symbol's resolved
/// address into the GOT slot. Different value on each arch.
fn r_glob_dat(machine: Machine) -> u64 {
    match machine {
        Machine::Aarch64 => R_AARCH64_GLOB_DAT,
        Machine::X86_64 => R_X86_64_GLOB_DAT,
    }
}

// `DT_NEEDED` entries come from `build.imports.dylibs` -- whatever
// the program's resolved `#pragma binding`s pull in. Empty when the
// program calls no libc.

// ------------------------------------------------------------------
// Tiny serialization helpers.
// ------------------------------------------------------------------

fn put_u32(out: &mut Vec<u8>, v: u32) {
    out.extend_from_slice(&v.to_le_bytes());
}

fn round_up(n: u64, align: u64) -> u64 {
    (n + align - 1) & !(align - 1)
}

// ------------------------------------------------------------------
// `_start` prologue. Linux/aarch64 process startup hands control to
// e_entry with sp pointing at argc.
//
// Per-arch variants live in `aarch64::emit_start_stub_elf` and
// `x86_64::emit_start_stub`. Both route exit through libc so
// glibc gets a chance to flush stdio.
// ------------------------------------------------------------------

/// Stub byte length per machine. Used for layout calculations.
///
/// `use_libc_exit` selects the longer (libc-routed) tail when the
/// program has a libc `exit` binding in scope; the syscall tail
/// is shorter on aarch64 and one byte longer on x86_64.
fn start_stub_len(machine: Machine, use_libc_exit: bool) -> u64 {
    match (machine, use_libc_exit) {
        // aarch64 libc tail: adrp + ldr + blr = 3 instructions.
        // aarch64 syscall tail: movz w8, #94 + svc #0 = 2
        // instructions. Saves 4 bytes.
        (Machine::Aarch64, true) => 6 * 4,
        (Machine::Aarch64, false) => 5 * 4,
        // x86_64 libc tail: mov rdi, rax (3) + call qword
        //   [rip+disp32] (6) = 9 bytes after the 14-byte prefix.
        // x86_64 syscall tail: mov rdi, rax (3) + mov eax, imm32
        //   (5) + syscall (2) = 10 bytes after the prefix --
        //   one byte longer.
        (Machine::X86_64, true) => x86_64::START_STUB_LEN,
        (Machine::X86_64, false) => x86_64::START_STUB_LEN_SYSCALL,
    }
}

/// Emit the `_start` prologue for the given machine. When
/// `use_libc_exit` is `true` the stub tail is `adrp/ldr/blr`
/// (aarch64) / `call qword [rip+disp32]` (x86_64) through the
/// libc `exit` GOT slot, and we return `Some(byte_offset)` so
/// the caller can register a `GotFixup` against it. When
/// `false`, the stub direct-syscalls
/// `sys_exit_group` so the resulting binary has no libc
/// dependency, and we return `None`. Routing through libc is
/// preferred when available because glibc's `exit` flushes
/// stdio buffers; the syscall tail is for binaries that
/// neither include `<stdlib.h>` nor use stdio at all.
fn emit_start_stub(
    machine: Machine,
    abi: Abi,
    code: &mut Vec<u8>,
    main_offset_in_code: u64,
    use_libc_exit: bool,
) -> Option<usize> {
    match machine {
        Machine::Aarch64 => emit_start_stub_aarch64(abi, code, main_offset_in_code, use_libc_exit),
        Machine::X86_64 => x86_64::emit_start_stub(code, abi, main_offset_in_code, use_libc_exit),
    }
}

/// AArch64 `_start`: ldr argc; add argv; bl main; then either
/// `adrp/ldr/blr libc::exit` or `mov w8, #94; svc #0`.
fn emit_start_stub_aarch64(
    abi: Abi,
    code: &mut Vec<u8>,
    main_offset_in_code: u64,
    use_libc_exit: bool,
) -> Option<usize> {
    use aarch64::Reg;
    let stub_len = start_stub_len(Machine::Aarch64, use_libc_exit);

    // argc / argv land in the first two of the ABI's
    // int-arg-passing registers. AAPCS64's order is x0..x7 so
    // these come out as x0, x1; pulling from `abi.int_arg_regs`
    // keeps the stub honest if a future arm64 ABI variant
    // shuffles the bank.
    let argc_reg = Reg(abi.int_arg_regs[0]);
    let argv_reg = Reg(abi.int_arg_regs[1]);
    aarch64::emit(code, aarch64::enc_ldr_imm(argc_reg, Reg::SP, 0));
    aarch64::emit(code, aarch64::enc_add_imm(argv_reg, Reg::SP, 8));

    let bl_pc = 8i64;
    let main_pc = stub_len as i64 + main_offset_in_code as i64;
    let delta_insns = ((main_pc - bl_pc) / 4) as i32;
    aarch64::emit(code, aarch64::enc_bl(delta_insns));

    let result = if use_libc_exit {
        // Placeholder adrp + ldr + blr through the libc exit GOT
        // slot. The caller appends a GotFixup with adrp_offset =
        // current code length so the writer fills in imm21/imm12
        // once the GOT vmaddr is known.
        let exit_adrp_offset = code.len();
        aarch64::emit(code, aarch64::enc_adrp(Reg::X16, 0));
        aarch64::emit(code, aarch64::enc_ldr_imm(Reg::X16, Reg::X16, 0));
        aarch64::emit(code, aarch64::enc_blr(Reg::X16));
        Some(exit_adrp_offset)
    } else {
        // direct `sys_exit_group` (Linux aarch64 syscall
        // 94). main's int return value is already in x0/w0, which
        // is the syscall's first arg. svc #0 transfers control to
        // the kernel and never returns.
        // movz w8, #94 -- Linux aarch64 sys_exit_group number.
        // The 16-bit shift amount (`hw`) is 0 since 94 fits in
        // the low 16 bits.
        aarch64::emit(code, aarch64::enc_movz(Reg::X8, 94, 0));
        aarch64::emit(code, aarch64::enc_svc(0));
        None
    };

    debug_assert_eq!(code.len() as u64, stub_len);
    result
}

// ------------------------------------------------------------------
// Dynamic-linking metadata.
//
// Section ordering inside the r-x segment:
//   .interp .dynsym .dynstr .hash .rela.dyn
// All naturally 8-byte aligned.
// ------------------------------------------------------------------

/// Build .dynstr -- the dynamic string table. Returns
/// `(bytes, import_name_offsets, lib_offsets, export_name_offsets)`
/// where each offsets vec lists the byte offset within the
/// table for the corresponding name. Exports come from
/// `Build::exports`; their names are exposed externally so
/// `dlsym` can find them.
fn build_dynstr(
    imports: &super::ResolvedImports,
    exports: &[crate::c5::program::ExportedFunction],
) -> (Vec<u8>, Vec<u32>, Vec<u32>, Vec<u32>) {
    let mut bytes = Vec::new();
    bytes.push(0); // index 0 is conventionally the empty string

    let mut name_offsets = Vec::with_capacity(imports.imports.len());
    for imp in &imports.imports {
        name_offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(imp.real_symbol.as_bytes());
        bytes.push(0);
    }

    let mut lib_offsets = Vec::with_capacity(imports.dylibs.len());
    for d in &imports.dylibs {
        lib_offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(d.path.as_bytes());
        bytes.push(0);
    }

    let mut export_offsets = Vec::with_capacity(exports.len());
    for e in exports {
        export_offsets.push(bytes.len() as u32);
        bytes.extend_from_slice(e.name.as_bytes());
        bytes.push(0);
    }

    // Pad to 8 so the next section starts aligned.
    while !bytes.len().is_multiple_of(8) {
        bytes.push(0);
    }

    (bytes, name_offsets, lib_offsets, export_offsets)
}

/// Build the static `.symtab` + `.strtab` for the
/// PLT-trampoline pool. One local `STT_FUNC` per import, plus
/// the SHT_SYMTAB sentinel at index 0. Returns
/// `(symtab_bytes, strtab_bytes)`.
///
/// `text_vmaddr` is the runtime vmaddr of `build.text[0]` (i.e.
/// `code_vmaddr + stub_len`), so each symbol's `st_value` resolves
/// to the trampoline's actual instruction address.
fn build_plt_symtab(
    build: &super::Build,
    text_vmaddr: u64,
    trampoline_size: u64,
) -> (Vec<u8>, Vec<u8>) {
    let imports = &build.imports.imports;
    debug_assert_eq!(
        imports.len(),
        build.plt_trampoline_offsets.len(),
        "trampoline-offset count must match import count"
    );

    // .strtab: leading NUL (st_name=0 -> empty string sentinel)
    // followed by NUL-separated import names.
    let mut strtab = alloc::vec![0u8];
    let mut name_offsets: Vec<u32> = Vec::with_capacity(imports.len());
    for imp in imports {
        name_offsets.push(strtab.len() as u32);
        strtab.extend_from_slice(imp.local_name.as_bytes());
        strtab.push(0);
    }

    // .symtab: SHT_SYMTAB sentinel at index 0, then one local
    // STT_FUNC per trampoline. Local symbols come first by spec
    // (the .symtab section header's `sh_info` field points one
    // past the last local entry).
    let mut symtab: Vec<u8> = Vec::with_capacity((1 + imports.len()) * ELF64_SYM_SIZE as usize);
    write_struct(
        &mut symtab,
        &Elf64Sym {
            st_name: 0,
            st_info: 0,
            st_other: 0,
            st_shndx: 0,
            st_value: 0,
            st_size: 0,
        },
    );
    for (i, imp) in imports.iter().enumerate() {
        let _ = imp;
        let st_value = text_vmaddr + build.plt_trampoline_offsets[i] as u64;
        write_struct(
            &mut symtab,
            &Elf64Sym {
                st_name: name_offsets[i],
                // Local + STT_FUNC. Locals come before globals in
                // the table; with no globals, the section header's
                // `sh_info` is `n_locals + 1` -- past the last
                // local (the SHT_SYMTAB rule).
                st_info: (STB_LOCAL << 4) | STT_FUNC,
                st_other: 0,
                // .text section index. Hard-coded to match the
                // section-header table: NULL=0, .interp=1,
                // .dynsym=2, .dynstr=3, .hash=4, .rela.dyn=5,
                // .text=6.
                st_shndx: 6,
                st_value,
                st_size: trampoline_size,
            },
        );
    }
    (symtab, strtab)
}

/// Build .dynsym. Layout:
///
/// * Index 0: zero sentinel (required by ELF).
/// * `[1, 1+n_imports)`: undefined imports (`STB_GLOBAL |
///   STT_NOTYPE`, `st_shndx = SHN_UNDEF`). Loader resolves
///   these via `.rela.dyn`.
/// * `[1+n_imports, 1+n_imports+n_exports)`: defined exports
///   (`STB_GLOBAL | STT_FUNC`, `st_shndx = 1` -- a placeholder
///   non-zero index since we don't emit section headers, but
///   `dlsym` only checks `SHN_UNDEF` to gate a name as
///   resolvable). `st_value` is the runtime VA of the
///   function.
fn build_dynsym(
    import_name_offsets: &[u32],
    export_name_offsets: &[u32],
    export_addrs: &[u64],
) -> Vec<u8> {
    debug_assert_eq!(export_name_offsets.len(), export_addrs.len());
    let n_total = 1 + import_name_offsets.len() + export_name_offsets.len();
    let mut out = Vec::with_capacity(n_total * ELF64_SYM_SIZE as usize);

    // Sentinel at index 0 -- all zero. Required by ELF.
    write_struct(
        &mut out,
        &Elf64Sym {
            st_name: 0,
            st_info: 0,
            st_other: 0,
            st_shndx: 0,
            st_value: 0,
            st_size: 0,
        },
    );

    for &name_off in import_name_offsets {
        write_struct(
            &mut out,
            &Elf64Sym {
                st_name: name_off,
                // c5's only dynamic-import mechanism today is
                // `#pragma binding(<lib>::<name>, "<sym>")`, and
                // every binding is reached via `Op::JsrExt` (a
                // call site) -- there's no path that imports a
                // data symbol. So tagging every import `STT_FUNC`
                // is correct in practice and gives `gdb` / `nm`
                // the right hint about callability. If we ever
                // grow an `extern int errno;`-style data import,
                // `ResolvedImport` would need an `is_function`
                // discriminator and this branch would pick
                // `STT_OBJECT` for the data case. The dynamic
                // linker doesn't care either way -- it resolves
                // by name -- so the worst case for a future
                // mis-tag is a confused debugger, not a broken
                // load.
                st_info: (STB_GLOBAL << 4) | STT_FUNC,
                st_other: 0, // STV_DEFAULT
                st_shndx: SHN_UNDEF,
                st_value: 0,
                st_size: 0,
            },
        );
    }

    for (&name_off, &addr) in export_name_offsets.iter().zip(export_addrs.iter()) {
        write_struct(
            &mut out,
            &Elf64Sym {
                st_name: name_off,
                st_info: (STB_GLOBAL << 4) | STT_FUNC,
                st_other: 0,
                // Non-zero placeholder section index -- we
                // don't emit section headers, but dlsym
                // treats `SHN_UNDEF` as "to be resolved" and
                // anything non-zero as defined.
                st_shndx: 1,
                st_value: addr,
                st_size: 0,
            },
        );
    }
    debug_assert_eq!(out.len() as u64, n_total as u64 * ELF64_SYM_SIZE);
    out
}

/// SysV ELF hash function -- the one DT_HASH wants.
fn elf_hash(name: &[u8]) -> u32 {
    let mut h: u32 = 0;
    for &b in name {
        h = (h << 4).wrapping_add(b as u32);
        let g = h & 0xF000_0000;
        if g != 0 {
            h ^= g >> 24;
        }
        h &= !g;
    }
    h
}

/// Build the DT_HASH table over `.dynsym`. Layout:
///   nbucket (u32), nchain (u32), bucket[nbucket], chain[nchain]
/// nchain == nsyms (the number of dynsym entries, counting the
/// sentinel). Each bucket holds the index of a sym, or 0 if empty;
/// chain[i] holds the next sym in the chain after sym `i`, or 0 to
/// terminate.
fn build_hash(name_offsets: &[u32], dynstr: &[u8]) -> Vec<u8> {
    let nsyms = (1 + name_offsets.len()) as u32;
    // Pick a small odd bucket count; doesn't have to be tuned.
    let nbucket = 7u32.min(nsyms.max(1));
    let mut buckets = vec![0u32; nbucket as usize];
    let mut chain = vec![0u32; nsyms as usize];

    for (i, &name_off) in name_offsets.iter().enumerate() {
        let sym_idx = (i + 1) as u32; // sentinel is index 0
        let name = name_bytes(dynstr, name_off as usize);
        let bkt = (elf_hash(name) % nbucket) as usize;
        // Insert at the head of the bucket's chain.
        chain[sym_idx as usize] = buckets[bkt];
        buckets[bkt] = sym_idx;
    }

    let mut out = Vec::with_capacity((2 + nbucket as usize + nsyms as usize) * 4);
    put_u32(&mut out, nbucket);
    put_u32(&mut out, nsyms);
    for b in &buckets {
        put_u32(&mut out, *b);
    }
    for c in &chain {
        put_u32(&mut out, *c);
    }
    while !out.len().is_multiple_of(8) {
        out.push(0);
    }
    out
}

/// Slice a NUL-terminated name out of a string table at `offset`.
fn name_bytes(strtab: &[u8], offset: usize) -> &[u8] {
    let end = strtab[offset..]
        .iter()
        .position(|&b| b == 0)
        .map(|p| offset + p)
        .unwrap_or(strtab.len());
    &strtab[offset..end]
}

/// Build .rela.dyn -- one `R_*_GLOB_DAT` relocation per import.
/// `got_vmaddr` is the runtime address of the start of the .got
/// section so `r_offset` can name the correct slot. The relocation
/// type varies by machine.
fn build_rela_dyn(got_vmaddr: u64, n_imports: usize, machine: Machine) -> Vec<u8> {
    let r_type = r_glob_dat(machine);
    let mut out = Vec::with_capacity(n_imports * ELF64_RELA_SIZE as usize);
    for i in 0..n_imports {
        // r_addend is ignored for GLOB_DAT; sym index is +1 to skip
        // the sentinel at dynsym[0].
        let sym_idx = (i as u64) + 1;
        write_struct(
            &mut out,
            &Elf64Rela {
                r_offset: got_vmaddr + (i as u64) * 8,
                r_info: (sym_idx << 32) | r_type,
                r_addend: 0,
            },
        );
    }
    out
}

/// Build .dynamic -- the table the loader walks to find every other
/// section. Each entry is `(d_tag, d_un)` 16 bytes. One DT_NEEDED
/// per [`NEEDED_LIBS`] entry, then the standard pointer-and-size
/// tags for the symbol / string / hash / rela sections.
fn build_dynamic(lib_strtab_offsets: &[u32], info: DynamicInfo) -> Vec<u8> {
    let mut out = Vec::with_capacity((lib_strtab_offsets.len() + 11) * ELF64_DYN_SIZE as usize);
    for &off in lib_strtab_offsets {
        write_struct(
            &mut out,
            &Elf64Dyn {
                d_tag: DT_NEEDED,
                d_val: off as u64,
            },
        );
    }
    let entries: &[(u64, u64)] = &[
        (DT_HASH, info.hash_vmaddr),
        (DT_STRTAB, info.strtab_vmaddr),
        (DT_SYMTAB, info.symtab_vmaddr),
        (DT_STRSZ, info.strtab_size),
        (DT_SYMENT, ELF64_SYM_SIZE),
        (DT_RELA, info.rela_vmaddr),
        (DT_RELASZ, info.rela_size),
        (DT_RELAENT, ELF64_RELA_SIZE),
        (DT_BIND_NOW, 0),
        (DT_FLAGS, DF_BIND_NOW),
        (DT_NULL, 0),
    ];
    for &(d_tag, d_val) in entries {
        write_struct(&mut out, &Elf64Dyn { d_tag, d_val });
    }
    out
}

/// Group of vmaddr/size values [`build_dynamic`] consumes. Only
/// exists to keep the signature short -- the writer computes them
/// all in one pass.
#[derive(Debug, Clone, Copy)]
struct DynamicInfo {
    hash_vmaddr: u64,
    strtab_vmaddr: u64,
    symtab_vmaddr: u64,
    rela_vmaddr: u64,
    rela_size: u64,
    strtab_size: u64,
}

// ------------------------------------------------------------------
// Adrp/ldr/add fixup patching. The codegen records GotFixup,
// DataFixup, and FuncFixup entries against `Build::text` byte offsets;
// we shift those by `START_STUB_LEN` (since the stub sits in front of
// build.text in the final code blob) and patch the immediates the
// same way the Mach-O writer does.
// ------------------------------------------------------------------

/// Patch an `adrp Xd, page; ldr Xd, [Xd, #imm12]` pair so it loads
/// the value at `target_vmaddr` -- here the address of a libc symbol
/// that the loader has written into .got.
fn patch_adrp_ldr(
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    adrp_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let adrp_file_off = (code_base_in_file + adrp_offset_in_code) as usize;
    let ldr_file_off = adrp_file_off + 4;
    let adrp_vmaddr = code_vmaddr_base + adrp_offset_in_code;

    let adrp_page = adrp_vmaddr & !0xFFF;
    let target_page = target_vmaddr & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} page diff {page_diff} not 4 KiB aligned"),
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = (target_vmaddr & 0xFFF) as u32;
    if !in_page.is_multiple_of(8) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} slot offset {in_page:#x} not 8-aligned"),
        )));
    }

    let adrp_word = aarch64::enc_adrp(aarch64::Reg::X16, imm21);
    let ldr_word = aarch64::enc_ldr_imm(aarch64::Reg::X16, aarch64::Reg::X16, in_page);
    out[adrp_file_off..adrp_file_off + 4].copy_from_slice(&adrp_word.to_le_bytes());
    out[ldr_file_off..ldr_file_off + 4].copy_from_slice(&ldr_word.to_le_bytes());
    Ok(())
}

/// Per-machine dispatch for "load an absolute address into the
/// accumulator". aarch64 uses an `adrp + add` pair; x86_64 uses a
/// single `lea r13, [rip + disp32]`. The codegen records the
/// instruction's start offset under the same field name; the
/// per-arch patcher knows the encoding.
fn patch_addr_load(
    machine: Machine,
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    match machine {
        Machine::Aarch64 => patch_adrp_add(
            out,
            code_base_in_file,
            code_vmaddr_base,
            instr_offset_in_code,
            target_vmaddr,
            label,
        ),
        Machine::X86_64 => patch_lea_rip32(
            out,
            code_base_in_file,
            code_vmaddr_base,
            instr_offset_in_code,
            target_vmaddr,
            label,
        ),
    }
}

/// Per-machine dispatch for "call a libc function whose address
/// lives in the GOT". aarch64 emits adrp+ldr+blr -- patch the
/// adrp+ldr immediates. x86_64 emits `call qword [rip + disp32]` --
/// patch the disp32.
fn patch_got_call(
    machine: Machine,
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    match machine {
        Machine::Aarch64 => patch_adrp_ldr(
            out,
            code_base_in_file,
            code_vmaddr_base,
            instr_offset_in_code,
            target_vmaddr,
            label,
        ),
        Machine::X86_64 => patch_call_qword_rip32(
            out,
            code_base_in_file,
            code_vmaddr_base,
            instr_offset_in_code,
            target_vmaddr,
            label,
        ),
    }
}

/// Patch the disp32 field of `call qword [rip + disp32]` so the
/// loaded pointer is at `target_vmaddr`. The `disp32` is measured
/// from the byte *after* the call (i.e. from
/// `instr_vmaddr + CALL_QWORD_RIP32_LEN`).
fn patch_call_qword_rip32(
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let call_len = x86_64::CALL_QWORD_RIP32_LEN as u64;
    let instr_vmaddr = code_vmaddr_base + instr_offset_in_code;
    let after = instr_vmaddr + call_len;
    let delta = target_vmaddr as i64 - after as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} disp {delta} doesn't fit in 32 bits"),
        )));
    }
    let disp32 = delta as i32;
    // disp32 is the last 4 bytes of `FF 15 dd dd dd dd`.
    let disp_file_off = (code_base_in_file + instr_offset_in_code + call_len - 4) as usize;
    out[disp_file_off..disp_file_off + 4].copy_from_slice(&disp32.to_le_bytes());
    Ok(())
}

/// Patch the disp32 field of `lea r64, [rip + disp32]` so the
/// instruction computes `target_vmaddr` into its destination. The
/// `disp32` is measured from the byte *after* the lea (i.e. from
/// `instr_vmaddr + LEA_RIP32_LEN`). 32-bit signed range, ~+/-2 GiB.
fn patch_lea_rip32(
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    instr_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let lea_len = x86_64::LEA_RIP32_LEN as u64;
    let instr_vmaddr = code_vmaddr_base + instr_offset_in_code;
    let after = instr_vmaddr + lea_len;
    let delta = target_vmaddr as i64 - after as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} disp {delta} doesn't fit in 32 bits"),
        )));
    }
    let disp32 = delta as i32;
    // disp32 is the last 4 bytes of a 7-byte LEA encoding:
    //   REX.W + 0x8D + ModR/M + 4*disp
    let disp_file_off = (code_base_in_file + instr_offset_in_code + lea_len - 4) as usize;
    out[disp_file_off..disp_file_off + 4].copy_from_slice(&disp32.to_le_bytes());
    Ok(())
}

/// Patch an `adrp Xd, page; add Xd, Xd, #imm12` pair so the result
/// equals `target_vmaddr`. Used for data-segment references and
/// function-pointer literals; both are absolute-address materializations.
fn patch_adrp_add(
    out: &mut [u8],
    code_base_in_file: u64,
    code_vmaddr_base: u64,
    adrp_offset_in_code: u64,
    target_vmaddr: u64,
    label: &str,
) -> Result<(), C5Error> {
    let adrp_file_off = (code_base_in_file + adrp_offset_in_code) as usize;
    let add_file_off = adrp_file_off + 4;
    let adrp_vmaddr = code_vmaddr_base + adrp_offset_in_code;

    let adrp_page = adrp_vmaddr & !0xFFF;
    let target_page = target_vmaddr & !0xFFF;
    let page_diff = target_page as i64 - adrp_page as i64;
    if page_diff & 0xFFF != 0 {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            &format!("ELF: {label} page diff {page_diff} not 4 KiB aligned"),
        )));
    }
    let imm21 = (page_diff >> 12) as i32;
    let in_page = (target_vmaddr & 0xFFF) as u32;

    let adrp_word = aarch64::enc_adrp(aarch64::Reg::X19, imm21);
    let add_word = aarch64::enc_add_imm(aarch64::Reg::X19, aarch64::Reg::X19, in_page);
    out[adrp_file_off..adrp_file_off + 4].copy_from_slice(&adrp_word.to_le_bytes());
    out[add_file_off..add_file_off + 4].copy_from_slice(&add_word.to_le_bytes());
    Ok(())
}

// ------------------------------------------------------------------
// Top-level writer.
// ------------------------------------------------------------------

pub(super) fn write(
    program: &Program,
    build: &Build,
    machine: Machine,
) -> Result<Vec<u8>, C5Error> {
    let is_shared = build.output_kind == super::OutputKind::SharedLibrary;
    let n_imports = build.imports.imports.len();
    // Pick the libc-exit tail when the user has any
    // libc `exit` import (typically through `<stdlib.h>`),
    // otherwise emit a direct sys_exit_group syscall and avoid
    // pulling libc in just to terminate. Stays opt-in to libc so
    // programs that print via stdio still get glibc's
    // end-of-process flush.
    let use_libc_exit = build.imports.imports.iter().any(|i| i.local_name == "exit");
    // Shared libraries don't have a `_start` stub -- dyld
    // never jumps into them, callers reach exports via
    // `dlsym`. Executables keep the existing stub that
    // tail-calls libc `exit` (when libc is available) or
    // direct-syscalls (when it isn't).
    let stub_len = if is_shared {
        0
    } else {
        start_stub_len(machine, use_libc_exit)
    };
    let exports = if is_shared {
        &build.exports[..]
    } else {
        &[][..]
    };

    // ---- Build the dynamic-linking metadata up front so we know the
    //      sizes for layout calculations. ----
    //
    // Shared-library output adds one `.dynsym` entry per
    // `Build::exports` -- defined symbols (`STB_GLOBAL |
    // STT_FUNC`) with `st_value` set to the function's
    // runtime VA. For executables `exports` is empty and the
    // tables look exactly like before.
    let (dynstr, name_offsets, lib_strtab_offsets, export_name_offsets) =
        build_dynstr(&build.imports, exports);
    // Compute each export's runtime VA. We fill in the real
    // values after layout is fixed and `code_vmaddr` is
    // known; here we just reserve the slot.
    let export_addrs_placeholder: Vec<u64> = vec![0; exports.len()];
    let dynsym = build_dynsym(
        &name_offsets,
        &export_name_offsets,
        &export_addrs_placeholder,
    );
    let hash = build_hash(&name_offsets, &dynstr);
    // .rela.dyn is built later -- it needs got_vmaddr.

    let interp_path_str = interp_path(machine);

    // .interp string (NUL-terminated). Round up to 8 so the next
    // section starts aligned.
    let mut interp = interp_path_str.as_bytes().to_vec();
    interp.push(0);
    while !interp.len().is_multiple_of(8) {
        interp.push(0);
    }

    // ---- Layout pass 1: compute file offsets in r-x segment. ----
    //
    // PT_TLS is added when the program has any `_Thread_local`
    // globals; the loader (`ld-linux-aarch64.so.1` /
    // `ld-linux-x86-64.so.2`) uses it to size per-thread TLS at
    // thread creation. `.tdata` (initialised TLS image) is the
    // first `tls_init_size` bytes of `build.tls_data`; `.tbss`
    // (zero-fill TLS) covers the remainder. We emit `.tdata` into
    // file storage immediately after `.data`; `.tbss` is
    // zero-filled (no file storage) and accounted for via PT_TLS's
    // `p_memsz - p_filesz` only.
    let has_tls = !build.tls_data.is_empty();
    let n_program_headers = N_BASE_PROGRAM_HEADERS + if has_tls { 1 } else { 0 };
    let phoff = ELF_HEADER_SIZE;
    let phsize = n_program_headers * PROGRAM_HEADER_SIZE;

    let interp_off = phoff + phsize;
    let dynsym_off = interp_off + interp.len() as u64;
    let dynstr_off = dynsym_off + dynsym.len() as u64;
    let hash_off = dynstr_off + dynstr.len() as u64;
    let rela_off = hash_off + hash.len() as u64;
    let rela_size = (n_imports as u64) * ELF64_RELA_SIZE;
    let code_off = round_up(rela_off + rela_size, 16);

    // Build the code blob: _start stub + build.text (with shifted
    // fixup offsets at write time). For shared-library output
    // we skip the stub entirely; dyld won't run it (no entry
    // point), and emitting one would force a libc-exit
    // import that isn't otherwise needed.
    let mut code: Vec<u8> = Vec::with_capacity(stub_len as usize + build.text.len());
    // `Some(byte_offset)` for the libc-exit GOT placeholder, or
    // `None` when the stub direct-syscalls / for shared
    // libraries that emit no stub at all. `None` short-circuits
    // the writer's later GOT-fixup patch.
    let exit_adrp_offset = if is_shared {
        None
    } else {
        emit_start_stub(
            machine,
            build.abi,
            &mut code,
            build.entry_offset as u64,
            use_libc_exit,
        )
    };
    code.extend_from_slice(&build.text);
    let code_size = code.len() as u64;

    let segment1_filesize = code_off + code_size;
    let segment1_end = round_up(segment1_filesize, PAGE_SIZE);

    // ---- Layout pass 2: rw segment (.dynamic, .got, build.data,
    //      .tdata, .tbss). ----
    let segment2_off = segment1_end;
    let dynamic_off = segment2_off;
    // `build_dynamic` emits one DT_NEEDED per resolved dylib plus
    // 11 fixed tags (DT_HASH, DT_STRTAB, ..., DT_NULL terminator).
    let dynamic_size = (build.imports.dylibs.len() as u64 + 11) * ELF64_DYN_SIZE;
    let got_off = dynamic_off + dynamic_size;
    let got_size = (n_imports as u64) * 8;
    let data_off = got_off + got_size;
    let data_size = build.data.len() as u64;
    let tdata_off = data_off + data_size;
    let tdata_size = build.tls_init_size as u64;
    let tbss_size = build.tls_data.len() as u64 - tdata_size;
    let segment2_filesize = tdata_off + tdata_size - segment2_off;
    // The PT_LOAD's p_memsz must cover `.tbss` even though it has
    // no file backing -- the loader zero-fills the difference.
    let segment2_memsize = segment2_filesize + tbss_size;
    let segment2_end = round_up(segment2_off + segment2_filesize, PAGE_SIZE);

    // ---- VM addresses (ET_EXEC, no slide). ----
    let interp_vmaddr = TEXT_VMADDR_BASE + interp_off;
    let dynsym_vmaddr = TEXT_VMADDR_BASE + dynsym_off;
    let dynstr_vmaddr = TEXT_VMADDR_BASE + dynstr_off;
    let hash_vmaddr = TEXT_VMADDR_BASE + hash_off;
    let rela_vmaddr = TEXT_VMADDR_BASE + rela_off;
    let code_vmaddr = TEXT_VMADDR_BASE + code_off;
    let dynamic_vmaddr = TEXT_VMADDR_BASE + dynamic_off;
    let got_vmaddr = TEXT_VMADDR_BASE + got_off;
    let data_vmaddr = TEXT_VMADDR_BASE + data_off;
    let tdata_vmaddr = TEXT_VMADDR_BASE + tdata_off;

    // ---- Layout pass 3: DWARF + section header table ----
    //
    // The DWARF debug sections aren't loaded (no PT_LOAD covers
    // them, no SHF_ALLOC) -- they're metadata that lldb / gdb
    // pick up by walking the section header table. We append:
    //
    //   <segment2_end aligned to PAGE_SIZE>
    //   .debug_info | .debug_abbrev | .debug_line | .debug_str
    //   .shstrtab (the section name string table)
    //   <pad to 8>
    //   section header table (6 * 64 bytes)
    //
    // The CU's `low_pc` references address into the loaded
    // text segment, so dwarf::emit needs the runtime vmaddr of
    // `build.text[0]` -- which is `code_vmaddr + stub_len` (the
    // _start stub sits ahead of build.text in the code blob;
    // shared libraries skip the stub so stub_len = 0 there).
    let dwarf_text_vmaddr = code_vmaddr + stub_len;
    let elf_target = match machine {
        super::Machine::Aarch64 => super::Target::LinuxAarch64,
        super::Machine::X86_64 => super::Target::LinuxX64,
    };
    // Skip the type-catalog walk + line program entirely
    // when the user passed `--no-debug`. Empty sections collapse
    // every `dwarf_*_off` into `dwarf_off` (= `segment2_end`) and
    // `shstrtab_off` lands right after, so the file body is
    // self-consistent without per-write conditionals.
    let emit_dwarf = build.debug_info;
    // Tell the DWARF emitter where the `_start` stub
    // lives so it can give it a `DW_TAG_subprogram` + a
    // CFI-terminating FDE. The stub sits at
    // `[code_vmaddr, code_vmaddr + stub_len)` -- ahead of
    // `build.text` -- so its range is independent of any
    // codegen-relative offset. Shared libraries skip the stub
    // (`stub_len = 0`); pass `None` there.
    let start_stub_range = if stub_len > 0 {
        Some((code_vmaddr, code_vmaddr + stub_len))
    } else {
        None
    };
    let dwarf_sections = if emit_dwarf {
        dwarf::emit(
            program,
            build,
            elf_target,
            dwarf_text_vmaddr,
            &program.source_path,
            start_stub_range,
        )
    } else {
        dwarf::DwarfSections {
            debug_info: Vec::new(),
            debug_abbrev: Vec::new(),
            debug_line: Vec::new(),
            debug_str: Vec::new(),
            debug_frame: Vec::new(),
        }
    };
    let dwarf_off = segment2_end;
    let dwarf_info_off = dwarf_off;
    let dwarf_abbrev_off = dwarf_info_off + dwarf_sections.debug_info.len() as u64;
    let dwarf_line_off = dwarf_abbrev_off + dwarf_sections.debug_abbrev.len() as u64;
    let dwarf_str_off = dwarf_line_off + dwarf_sections.debug_line.len() as u64;
    let dwarf_frame_off = dwarf_str_off + dwarf_sections.debug_str.len() as u64;

    // Build the static `.symtab` + `.strtab` listing one
    // local STT_FUNC per PLT trampoline. The trampolines live
    // inside `.text` at `code_vmaddr + stub_len + tramp_off`; a
    // debugger's `b malloc` on the produced binary now resolves
    // to the trampoline rather than getting lost in the dynamic
    // linker's macro-expansion sites.
    //
    // Empty when the program has no imports (a `void main(){}`
    // that never calls libc -- rare). The two sections still get
    // their headers in that case for layout symmetry, but their
    // payloads degenerate to the SHT_SYMTAB sentinel + the empty
    // string.
    let emit_plt_symtab = !build.plt_trampoline_offsets.is_empty();
    let trampoline_size: u64 = match machine {
        super::Machine::Aarch64 => 12, // adrp + ldr + br
        super::Machine::X86_64 => 6,   // jmp qword ptr [rip+disp32]
    };
    let (plt_symtab_bytes, plt_strtab_bytes) = if emit_plt_symtab {
        build_plt_symtab(build, dwarf_text_vmaddr, trampoline_size)
    } else {
        (Vec::new(), alloc::vec![0u8])
    };
    let post_dwarf_off = dwarf_frame_off + dwarf_sections.debug_frame.len() as u64;
    let (symtab_off, strtab_off, shstrtab_off) = if emit_plt_symtab {
        // .symtab requires 8-byte alignment (each Elf64_Sym is 24
        // bytes). The file body pads to `symtab_off` before
        // emitting the bytes; .strtab and .shstrtab sit immediately
        // after with no further padding.
        let s = round_up(post_dwarf_off, 8);
        let st = s + plt_symtab_bytes.len() as u64;
        let sh = st + plt_strtab_bytes.len() as u64;
        (s, st, sh)
    } else {
        // No PLT symtab -> .shstrtab abuts DWARF directly,
        // matching the pre-#61 layout.
        (post_dwarf_off, post_dwarf_off, post_dwarf_off)
    };
    // .shstrtab content: NUL + section names. Index 0 is the
    // empty name (SHT_NULL sentinel uses sh_name=0). Names cover
    // the full set of sections in the section-header table:
    // loaded segments (.interp, .dynsym, ..., .text, .data) plus
    // the debug-only metadata sections.
    //
    // Indices 0..=11 are stable; 12..=16 are the DWARF names,
    // present only when `emit_dwarf` is true (when the
    // user passed `--no-debug`, these names don't go into the
    // string table at all). The `.shstrtab` self-name is always
    // last; callers reach it via `shstrtab_idx_self` rather than
    // a fixed numeric index.
    let mut shstrtab_names: Vec<&str> = Vec::with_capacity(18);
    shstrtab_names.extend_from_slice(&[
        "",          // 0
        ".interp",   // 1
        ".dynsym",   // 2
        ".dynstr",   // 3
        ".hash",     // 4
        ".rela.dyn", // 5
        ".text",     // 6
        ".tdata",    // 7  (only present when has_tls)
        ".dynamic",  // 8
        ".got",      // 9
        ".data",     // 10
        ".tbss",     // 11 (only present when has_tls)
    ]);
    if emit_dwarf {
        shstrtab_names.extend_from_slice(&[
            ".debug_info",   // 12
            ".debug_abbrev", // 13
            ".debug_line",   // 14
            ".debug_str",    // 15
            ".debug_frame",  // 16
        ]);
    }
    // `.symtab` + `.strtab` for the PLT-trampoline pool.
    // Always paired -- a SHT_SYMTAB section's `sh_link` must
    // reference a real strtab. Only emitted when there are
    // trampolines to name.
    let plt_symtab_name_idx_in_shstrtab = if emit_plt_symtab {
        shstrtab_names.push(".symtab");
        shstrtab_names.push(".strtab");
        Some(shstrtab_names.len() - 2)
    } else {
        None
    };
    let shstrtab_idx_self = shstrtab_names.len();
    shstrtab_names.push(".shstrtab");
    let mut shstrtab: Vec<u8> = Vec::new();
    let mut shstrtab_offsets: Vec<u32> = Vec::with_capacity(shstrtab_names.len());
    for s in &shstrtab_names {
        shstrtab_offsets.push(shstrtab.len() as u32);
        shstrtab.extend_from_slice(s.as_bytes());
        shstrtab.push(0);
    }
    let shstrtab_size = shstrtab.len() as u64;
    let shdr_off = round_up(shstrtab_off + shstrtab_size, 8);
    // Section count: 1 NULL + .interp + .dynsym + .dynstr +
    // .hash + .rela.dyn + .text + (optional .tdata) +
    // .dynamic + .got + (optional .data) + (optional .tbss) +
    // 4 .debug_* + .shstrtab. Counted dynamically.
    let has_data = !build.data.is_empty();
    let has_tdata = has_tls && tdata_size > 0;
    let has_tbss = has_tls && tbss_size > 0;
    let n_section_headers: u64 = 1 // NULL
        + 1 // .interp
        + 1 // .dynsym
        + 1 // .dynstr
        + 1 // .hash
        + 1 // .rela.dyn
        + 1 // .text
        + (if has_tdata { 1 } else { 0 }) // .tdata
        + 1 // .dynamic
        + 1 // .got
        + (if has_data { 1 } else { 0 }) // .data
        + (if has_tbss { 1 } else { 0 }) // .tbss
        + (if emit_dwarf { 5 } else { 0 }) // .debug_* x 5 (info, abbrev, line, str, frame); 
        + (if emit_plt_symtab { 2 } else { 0 }) // .symtab + .strtab; 
        + 1; // .shstrtab
    let total_filesize = shdr_off + n_section_headers * ELF64_SHDR_SIZE;
    // shstrtab is the last section in the table; its index is
    // n_section_headers - 1.
    let shstrtab_idx: u16 = (n_section_headers - 1) as u16;

    // ---- Build the bytes. ----
    let mut out: Vec<u8> = Vec::with_capacity(total_filesize as usize);

    // ELF header.
    let mut e_ident = [0u8; EI_NIDENT];
    e_ident[0..4].copy_from_slice(&ELFMAG);
    e_ident[4] = ELFCLASS64;
    e_ident[5] = ELFDATA2LSB;
    e_ident[6] = EV_CURRENT;
    e_ident[7] = ELFOSABI_SYSV;
    write_struct(
        &mut out,
        &Elf64Ehdr {
            e_ident,
            e_type: if is_shared { ET_DYN } else { ET_EXEC },
            e_machine: e_machine(machine),
            e_version: EV_CURRENT as u32,
            // For executables: start of `_start`. For shared
            // libraries: zero -- the loader doesn't transfer
            // control to a dlopen'd image, and an explicit
            // `_init` constructor isn't needed for the cases
            // c5 currently produces.
            e_entry: if is_shared { 0 } else { code_vmaddr },
            e_phoff: phoff,
            e_shoff: shdr_off,
            e_flags: 0,
            e_ehsize: ELF_HEADER_SIZE as u16,
            e_phentsize: PROGRAM_HEADER_SIZE as u16,
            e_phnum: n_program_headers as u16,
            // The dynamic linker doesn't read section headers
            // (it walks PT_DYNAMIC); the only consumers are
            // lldb / gdb, which use them to locate the
            // `.debug_*` payload. Six entries: SHT_NULL
            // sentinel, four DWARF sections, .shstrtab.
            e_shentsize: ELF64_SHDR_SIZE as u16,
            e_shnum: n_section_headers as u16,
            e_shstrndx: shstrtab_idx,
        },
    );
    debug_assert_eq!(out.len() as u64, ELF_HEADER_SIZE);

    // PT_PHDR -- self-locate.
    write_phdr(
        &mut out,
        PT_PHDR,
        PF_R,
        phoff,
        TEXT_VMADDR_BASE + phoff,
        phsize,
        phsize,
        8,
    );

    // PT_INTERP -- per-machine path (aarch64 vs x86_64).
    write_phdr(
        &mut out,
        PT_INTERP,
        PF_R,
        interp_off,
        interp_vmaddr,
        interp_path_str.len() as u64 + 1,
        interp_path_str.len() as u64 + 1,
        1,
    );

    // PT_LOAD r-x -- ELF header + phdrs + interp + dynsym + dynstr +
    // hash + rela + code, all in one segment.
    write_phdr(
        &mut out,
        PT_LOAD,
        PF_R | PF_X,
        0,
        TEXT_VMADDR_BASE,
        segment1_filesize,
        segment1_filesize,
        PAGE_SIZE,
    );

    // PT_LOAD rw -- .dynamic, .got, .data, .tdata, [.tbss memsz].
    write_phdr(
        &mut out,
        PT_LOAD,
        PF_R | PF_W,
        segment2_off,
        TEXT_VMADDR_BASE + segment2_off,
        segment2_filesize,
        segment2_memsize,
        PAGE_SIZE,
    );

    // PT_DYNAMIC -- mirror of the .dynamic section.
    write_phdr(
        &mut out,
        PT_DYNAMIC,
        PF_R | PF_W,
        dynamic_off,
        dynamic_vmaddr,
        dynamic_size,
        dynamic_size,
        8,
    );

    // PT_TLS -- describes the per-thread TLS image. Only emitted
    // when the program declares any `_Thread_local` global; the
    // dynamic linker uses this to allocate per-thread TLS at
    // pthread_create time, copying `p_filesz` bytes from `.tdata`
    // and zero-filling the remainder up to `p_memsz` (.tbss).
    if has_tls {
        write_phdr(
            &mut out,
            PT_TLS,
            PF_R,
            tdata_off,
            tdata_vmaddr,
            tdata_size,
            tdata_size + tbss_size,
            8,
        );
    }

    // PT_GNU_STACK rw- (no x).
    write_phdr(&mut out, PT_GNU_STACK, PF_R | PF_W, 0, 0, 0, 0, 16);

    debug_assert_eq!(out.len() as u64, phoff + phsize);

    // .interp
    out.extend_from_slice(&interp);
    debug_assert_eq!(out.len() as u64, dynsym_off);

    // .dynsym -- rebuild now that we know `code_vmaddr` so
    // each export's `st_value` is its runtime VA. The
    // placeholder we built up front (with `st_value = 0`)
    // had the right byte count for layout; the real values
    // go in here.
    let export_addrs: Vec<u64> = exports
        .iter()
        .map(|exp| {
            let native_off = build
                .bytecode_to_native
                .get(exp.bytecode_pc)
                .copied()
                .unwrap_or(usize::MAX);
            if native_off == usize::MAX {
                return 0;
            }
            // Code blob layout is `[stub_len bytes of _start][build.text]`;
            // shared-library output has stub_len=0 so the
            // shift is a no-op there.
            code_vmaddr + (stub_len + native_off as u64)
        })
        .collect();
    let final_dynsym = build_dynsym(&name_offsets, &export_name_offsets, &export_addrs);
    debug_assert_eq!(final_dynsym.len(), dynsym.len());
    out.extend_from_slice(&final_dynsym);
    debug_assert_eq!(out.len() as u64, dynstr_off);

    // .dynstr
    out.extend_from_slice(&dynstr);
    debug_assert_eq!(out.len() as u64, hash_off);

    // .hash
    out.extend_from_slice(&hash);
    debug_assert_eq!(out.len() as u64, rela_off);

    // .rela.dyn
    let rela = build_rela_dyn(got_vmaddr, n_imports, machine);
    debug_assert_eq!(rela.len() as u64, rela_size);
    out.extend_from_slice(&rela);

    // Pad to code_off.
    while (out.len() as u64) < code_off {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, code_off);

    // _start stub + build.text.
    let code_file_offset = out.len() as u64;
    out.extend_from_slice(&code);
    debug_assert_eq!(out.len() as u64, segment1_filesize);

    // Pad to end of segment 1 (page-aligned).
    while (out.len() as u64) < segment1_end {
        out.push(0);
    }

    // .dynamic
    let dynamic = build_dynamic(
        &lib_strtab_offsets,
        DynamicInfo {
            hash_vmaddr,
            strtab_vmaddr: dynstr_vmaddr,
            symtab_vmaddr: dynsym_vmaddr,
            rela_vmaddr,
            rela_size,
            strtab_size: dynstr.len() as u64,
        },
    );
    debug_assert_eq!(dynamic.len() as u64, dynamic_size);
    out.extend_from_slice(&dynamic);

    // .got -- one zero-filled u64 per import. Loader fills these in
    // via .rela.dyn / R_AARCH64_GLOB_DAT before _start runs.
    out.extend(vec![0u8; got_size as usize]);

    // build.data -- the program's static data segment, with
    // pointer-to-global initializers resolved to absolute VAs.
    // ET_EXEC means the loader maps at the link-time vmaddr
    // (no slide), so the bytes can hold the final VA verbatim
    // -- no `.rela.dyn` relocations needed.
    let mut data_with_relocs = build.data.clone();
    for r in &build.data_relocs {
        let absolute = data_vmaddr + r.target_offset;
        let off = r.data_offset as usize;
        if off + 8 > data_with_relocs.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "ELF: data reloc offset {off:#x} past end of .data ({})",
                    data_with_relocs.len()
                ),
            )));
        }
        data_with_relocs[off..off + 8].copy_from_slice(&absolute.to_le_bytes());
    }
    // Function-pointer initializers in the data segment: translate
    // each bytecode PC to a native code-segment offset (skipping
    // the prologue stub at the start of the code blob), add the
    // text vmaddr, and write the absolute code address. ET_EXEC
    // means no slide so the bytes hold the final VA -- no
    // .rela.dyn entries needed.
    for r in &build.code_relocs {
        let bc_pc = r.target_bc_pc as usize;
        let native_off = build
            .bytecode_to_native
            .get(bc_pc)
            .copied()
            .unwrap_or(usize::MAX);
        if native_off == usize::MAX {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!("ELF: code reloc references missing bytecode pc {bc_pc}"),
            )));
        }
        let absolute = code_vmaddr + stub_len + native_off as u64;
        let off = r.data_offset as usize;
        if off + 8 > data_with_relocs.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "ELF: code reloc offset {off:#x} past end of .data ({})",
                    data_with_relocs.len()
                ),
            )));
        }
        data_with_relocs[off..off + 8].copy_from_slice(&absolute.to_le_bytes());
    }
    out.extend_from_slice(&data_with_relocs);

    // .tdata -- initialised TLS image. The first `tls_init_size`
    // bytes of `build.tls_data`. The loader copies these into each
    // thread's TLS region at thread creation. .tbss has no file
    // backing -- it lives only in PT_TLS's `p_memsz - p_filesz`
    // and gets zero-filled by the loader, so we emit nothing for
    // it here.
    out.extend_from_slice(&build.tls_data[..build.tls_init_size]);

    // Pad to end of segment 2 (page-aligned).
    while (out.len() as u64) < segment2_end {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, dwarf_off);

    // ---- DWARF debug sections ----
    out.extend_from_slice(&dwarf_sections.debug_info);
    out.extend_from_slice(&dwarf_sections.debug_abbrev);
    out.extend_from_slice(&dwarf_sections.debug_line);
    out.extend_from_slice(&dwarf_sections.debug_str);
    out.extend_from_slice(&dwarf_sections.debug_frame);

    // ---- PLT-trampoline static symbol table. ----
    if emit_plt_symtab {
        // Pad to 8 so each Elf64_Sym lands aligned.
        while (out.len() as u64) < symtab_off {
            out.push(0);
        }
        debug_assert_eq!(out.len() as u64, symtab_off);
        out.extend_from_slice(&plt_symtab_bytes);
        debug_assert_eq!(out.len() as u64, strtab_off);
        out.extend_from_slice(&plt_strtab_bytes);
    }
    debug_assert_eq!(out.len() as u64, shstrtab_off);

    // .shstrtab
    out.extend_from_slice(&shstrtab);

    // Pad to 8 so the section header table starts aligned.
    while (out.len() as u64) < shdr_off {
        out.push(0);
    }
    debug_assert_eq!(out.len() as u64, shdr_off);

    // Section header table: a full table covering loaded
    // segments (NULL sentinel, .interp, .dynsym, .dynstr, .hash,
    // .rela.dyn, .text, optional .tdata, .dynamic, .got, optional
    // .data, optional .tbss) plus the four DWARF sections and
    // .shstrtab.
    //
    // Without entries for the loaded segments, gdb segfaults on
    // `b main` (no section contains main's vmaddr) and `strip`
    // collapses the binary to ~488 bytes (it interprets the
    // missing section table as "no real content"). lldb on
    // Linux similarly mis-resolves names. The bytes the headers
    // describe are already on disk; we just describe them.
    // Section indices are computed as we emit; .dynsym /
    // .dynstr / .dynamic / etc. need to reference each other by
    // index in `sh_link`, so capture each one's slot before
    // emitting the next.
    let null_shdr_idx: u16 = 0;
    let _ = null_shdr_idx;
    let interp_shdr_idx: u16 = 1;
    let _ = interp_shdr_idx;
    let dynsym_shdr_idx: u16 = 2;
    let dynstr_shdr_idx: u16 = 3;
    let _hash_shdr_idx: u16 = 4;
    let _rela_shdr_idx: u16 = 5;
    let _ = (dynsym_shdr_idx, dynstr_shdr_idx);

    // [0] NULL sentinel.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[0],
            sh_type: SHT_NULL,
            sh_flags: 0,
            sh_addr: 0,
            sh_offset: 0,
            sh_size: 0,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 0,
            sh_entsize: 0,
        },
    );

    // [1] .interp -- the dynamic linker path string.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[1],
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC,
            sh_addr: interp_vmaddr,
            sh_offset: interp_off,
            sh_size: interp_path_str.len() as u64 + 1,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 1,
            sh_entsize: 0,
        },
    );

    // [2] .dynsym -- dynamic symbol table. sh_link = .dynstr,
    // sh_info = index of first non-local symbol (we have only
    // a NULL sentinel + globals, so 1).
    let dynsym_link_pending: u16 = dynstr_shdr_idx;
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[2],
            sh_type: SHT_DYNSYM,
            sh_flags: SHF_ALLOC,
            sh_addr: dynsym_vmaddr,
            sh_offset: dynsym_off,
            sh_size: dynsym.len() as u64,
            sh_link: dynsym_link_pending as u32,
            sh_info: 1,
            sh_addralign: 8,
            sh_entsize: ELF64_SYM_SIZE,
        },
    );

    // [3] .dynstr -- string table for .dynsym.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[3],
            sh_type: SHT_STRTAB,
            sh_flags: SHF_ALLOC,
            sh_addr: dynstr_vmaddr,
            sh_offset: dynstr_off,
            sh_size: dynstr.len() as u64,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 1,
            sh_entsize: 0,
        },
    );

    // [4] .hash -- DT_HASH bucket / chain table.
    let dynsym_idx_for_hash = dynsym_shdr_idx;
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[4],
            sh_type: SHT_HASH,
            sh_flags: SHF_ALLOC,
            sh_addr: hash_vmaddr,
            sh_offset: hash_off,
            sh_size: hash.len() as u64,
            sh_link: dynsym_idx_for_hash as u32,
            sh_info: 0,
            sh_addralign: 8,
            sh_entsize: 4,
        },
    );

    // [5] .rela.dyn -- relocations resolved at load time.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[5],
            sh_type: SHT_RELA,
            sh_flags: SHF_ALLOC,
            sh_addr: rela_vmaddr,
            sh_offset: rela_off,
            sh_size: rela_size,
            sh_link: dynsym_idx_for_hash as u32,
            sh_info: 0,
            sh_addralign: 8,
            sh_entsize: ELF64_RELA_SIZE,
        },
    );

    // [6] .text -- the executable code segment. The size covers
    // the entry stub + build.text; the address is `code_vmaddr`.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[6],
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC | SHF_EXECINSTR,
            sh_addr: code_vmaddr,
            sh_offset: code_off,
            sh_size: code_size,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 16,
            sh_entsize: 0,
        },
    );

    // [optional] .tdata -- TLS image template (when has_tdata).
    if has_tdata {
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: shstrtab_offsets[7],
                sh_type: SHT_PROGBITS,
                sh_flags: SHF_ALLOC | SHF_WRITE | 0x400, // SHF_TLS
                sh_addr: tdata_vmaddr,
                sh_offset: tdata_off,
                sh_size: tdata_size,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 8,
                sh_entsize: 0,
            },
        );
    }

    // [N] .dynamic -- dynamic linking info table.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[8],
            sh_type: SHT_DYNAMIC,
            sh_flags: SHF_ALLOC | SHF_WRITE,
            sh_addr: dynamic_vmaddr,
            sh_offset: dynamic_off,
            sh_size: dynamic_size,
            sh_link: dynstr_shdr_idx as u32,
            sh_info: 0,
            sh_addralign: 8,
            sh_entsize: ELF64_DYN_SIZE,
        },
    );

    // [N+1] .got -- global offset table (one slot per import).
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[9],
            sh_type: SHT_PROGBITS,
            sh_flags: SHF_ALLOC | SHF_WRITE,
            sh_addr: got_vmaddr,
            sh_offset: got_off,
            sh_size: got_size,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 8,
            sh_entsize: 8,
        },
    );

    // [optional] .data -- the initialised data segment.
    if has_data {
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: shstrtab_offsets[10],
                sh_type: SHT_PROGBITS,
                sh_flags: SHF_ALLOC | SHF_WRITE,
                sh_addr: data_vmaddr,
                sh_offset: data_off,
                sh_size: data_size,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 8,
                sh_entsize: 0,
            },
        );
    }

    // [optional] .tbss -- TLS zero-fill (no file backing).
    if has_tbss {
        // .tbss has no file-resident bytes; sh_offset still
        // points where the loader-zeroed region would conceptually
        // start so tools can compute its boundaries.
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: shstrtab_offsets[11],
                sh_type: 8,                              // SHT_NOBITS
                sh_flags: SHF_ALLOC | SHF_WRITE | 0x400, // SHF_TLS
                sh_addr: tdata_vmaddr + tdata_size,
                sh_offset: tdata_off + tdata_size,
                sh_size: tbss_size,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 8,
                sh_entsize: 0,
            },
        );
    }

    // [N+2..N+6] DWARF debug sections (file-only metadata, no
    // SHF_ALLOC so the loader skips them). `.debug_frame`
    // carries the CFI a debugger / unwinder reads to walk through
    // optimised frames without prologue heuristics. Suppressed
    // when `--no-debug` was passed -- the section table
    // simply omits these five entries; nothing else in the file
    // image references them.
    if emit_dwarf {
        let dwarf_section_specs: &[(u32, u64, u64)] = &[
            (
                shstrtab_offsets[12],
                dwarf_info_off,
                dwarf_sections.debug_info.len() as u64,
            ),
            (
                shstrtab_offsets[13],
                dwarf_abbrev_off,
                dwarf_sections.debug_abbrev.len() as u64,
            ),
            (
                shstrtab_offsets[14],
                dwarf_line_off,
                dwarf_sections.debug_line.len() as u64,
            ),
            (
                shstrtab_offsets[15],
                dwarf_str_off,
                dwarf_sections.debug_str.len() as u64,
            ),
            (
                shstrtab_offsets[16],
                dwarf_frame_off,
                dwarf_sections.debug_frame.len() as u64,
            ),
        ];
        for &(name_off, off, sz) in dwarf_section_specs {
            write_struct(
                &mut out,
                &Elf64Shdr {
                    sh_name: name_off,
                    sh_type: SHT_PROGBITS,
                    sh_flags: 0,
                    sh_addr: 0,
                    sh_offset: off,
                    sh_size: sz,
                    sh_link: 0,
                    sh_info: 0,
                    sh_addralign: 1,
                    sh_entsize: 0,
                },
            );
        }
    }

    // PLT-trampoline static symbol table. `.symtab`'s
    // `sh_info` field must point one past the last LOCAL symbol;
    // we only emit locals, so it's `n_symbols` (sentinel + one
    // per import). `sh_link` references the matching `.strtab`.
    if let Some(name_idx) = plt_symtab_name_idx_in_shstrtab {
        // Section-header indices for `.symtab` / `.strtab`. They
        // sit just before `.shstrtab` (which is always at
        // `n_section_headers - 1`), so they're at -3 / -2 from
        // the end. These are independent of `shstrtab_names`
        // ordering -- the names list and the shdr table use
        // different indexing schemes (the former includes only
        // names; the latter includes optional sections like
        // `.tdata` / `.data` / `.tbss` whose names are at fixed
        // shstrtab slots).
        let symtab_shdr_idx = (n_section_headers - 3) as u32;
        let strtab_shdr_idx = (n_section_headers - 2) as u32;
        let _ = symtab_shdr_idx;
        let n_sym = (plt_symtab_bytes.len() as u64) / ELF64_SYM_SIZE;
        // [N] .symtab
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: shstrtab_offsets[name_idx],
                sh_type: SHT_SYMTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: symtab_off,
                sh_size: plt_symtab_bytes.len() as u64,
                sh_link: strtab_shdr_idx,
                sh_info: n_sym as u32, // one past last local
                sh_addralign: 8,
                sh_entsize: ELF64_SYM_SIZE,
            },
        );
        // [N+1] .strtab
        write_struct(
            &mut out,
            &Elf64Shdr {
                sh_name: shstrtab_offsets[name_idx + 1],
                sh_type: SHT_STRTAB,
                sh_flags: 0,
                sh_addr: 0,
                sh_offset: strtab_off,
                sh_size: plt_strtab_bytes.len() as u64,
                sh_link: 0,
                sh_info: 0,
                sh_addralign: 1,
                sh_entsize: 0,
            },
        );
    }

    // [last] .shstrtab.
    write_struct(
        &mut out,
        &Elf64Shdr {
            sh_name: shstrtab_offsets[shstrtab_idx_self],
            sh_type: SHT_STRTAB,
            sh_flags: 0,
            sh_addr: 0,
            sh_offset: shstrtab_off,
            sh_size: shstrtab_size,
            sh_link: 0,
            sh_info: 0,
            sh_addralign: 1,
            sh_entsize: 0,
        },
    );

    debug_assert_eq!(out.len() as u64, total_filesize);

    // ---- Patch fixups. ----
    // The code blob layout is [_start stub][build.text]. The codegen's
    // adrp_offset is relative to build.text, so we shift by stub len.
    // Shared libraries have no `_start` and skip this patch
    // entirely; the stub-len shift below collapses to zero
    // and the libc-exit GOT lookup never gets emitted in
    // the first place.
    if let Some(exit_off) = exit_adrp_offset {
        let exit_idx = build
            .imports
            .imports
            .iter()
            .position(|i| i.local_name == "exit")
            .ok_or_else(|| {
                C5Error::Compile(crate::c5::error::fmt_internal_err(
                    "ELF writer: _start stub asked for the libc-exit tail but `exit` \
                     isn't in the import set -- the codegen lower-pass and the writer \
                     disagree on whether libc is in scope.",
                ))
            })?;
        patch_got_call(
            machine,
            &mut out,
            code_file_offset,
            code_vmaddr,
            exit_off as u64,
            got_vmaddr + (exit_idx as u64) * 8,
            "_start exit fixup",
        )?;
    }
    // The syscall tail (`exit_adrp_offset == None`) needs
    // no patch -- the `mov rax, 231; syscall` (x86_64) /
    // `movz x8, #94; svc #0` (aarch64) bytes are absolute and
    // self-contained.

    // GOT fixups for libc calls inside build.text. Same per-arch
    // dispatch as the _start exit call.
    for fx in &build.got_fixups {
        patch_got_call(
            machine,
            &mut out,
            code_file_offset,
            code_vmaddr,
            stub_len + fx.adrp_offset as u64,
            got_vmaddr + (fx.import_index as u64) * 8,
            "GOT fixup",
        )?;
    }

    // Data-segment references (string literals / globals). Per-arch
    // patch shape: aarch64 uses adrp+add, x86_64 uses lea + RIP-rel.
    for fx in &build.data_fixups {
        patch_addr_load(
            machine,
            &mut out,
            code_file_offset,
            code_vmaddr,
            stub_len + fx.adrp_offset as u64,
            data_vmaddr + fx.data_offset,
            "data fixup",
        )?;
    }

    // Function-pointer literals.
    for fx in &build.func_fixups {
        // Targets are byte offsets within build.text -- shift by
        // stub len.
        patch_addr_load(
            machine,
            &mut out,
            code_file_offset,
            code_vmaddr,
            stub_len + fx.adrp_offset as u64,
            code_vmaddr + stub_len + fx.target_native_offset as u64,
            "func fixup",
        )?;
    }

    Ok(out)
}

#[allow(clippy::too_many_arguments)]
fn write_phdr(
    out: &mut Vec<u8>,
    p_type: u32,
    p_flags: u32,
    p_offset: u64,
    p_vaddr: u64,
    p_filesz: u64,
    p_memsz: u64,
    p_align: u64,
) {
    write_struct(
        out,
        &Elf64Phdr {
            p_type,
            p_flags,
            p_offset,
            p_vaddr,
            // p_paddr mirrors p_vaddr -- our targets don't have a
            // separate physical-address space.
            p_paddr: p_vaddr,
            p_filesz,
            p_memsz,
            p_align,
        },
    );
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Smallest plausible Build that exercises the writer end to end.
    /// 8 bytes of code (movz x0, #42; ret), no fixups.
    ///
    /// Carries a fake `Op::Exit` import: the aarch64 `_start` stub
    /// always calls libc's `exit` after main returns, so ELF writes
    /// without that entry would error out before producing any bytes
    /// for the structural assertions to inspect. This mirrors what
    /// real programs get from `<stdlib.h>`.
    /// Empty `Program` paired with `tiny_build`. The DWARF
    /// emitter walks `Program::text` for `Op::Ent`s; an empty
    /// vec produces an empty subprogram list and trivial
    /// section bytes, which is enough for the structural
    /// invariants the tests check.
    fn tiny_program() -> Program {
        Program {
            text: Vec::new(),
            data: Vec::new(),
            entry_pc: 0,
            warnings: Vec::new(),
            data_imm_positions: Vec::new(),
            code_imm_positions: Vec::new(),
            call_fp_arg_masks: Vec::new(),
            variadic_functions: alloc::collections::BTreeSet::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            dylibs: Vec::new(),
            dllmain_pc: None,
            source_lines: Vec::new(),
            source_functions: Vec::new(),
            source_files: Vec::new(),
            source_file_indices: Vec::new(),
            source_path: String::new(),
            variables: Vec::new(),
            structs: Vec::new(),
            entry_name: None,
            subsystem: None,
            optimized: false,
            finished_functions: alloc::vec::Vec::new(),
            symbols: alloc::vec::Vec::new(),
            synthetic_ssa_funcs: alloc::vec::Vec::new(),
            extern_function_imports: alloc::vec::Vec::new(),
        }
    }

    fn tiny_build() -> Build {
        use super::super::{ResolvedDylib, ResolvedImport, ResolvedImports};
        Build {
            text: vec![0x40, 0x05, 0x80, 0xD2, 0xC0, 0x03, 0x5F, 0xD6],
            data: Vec::new(),
            entry_offset: 0,
            got_fixups: Vec::new(),
            data_fixups: Vec::new(),
            func_fixups: Vec::new(),
            bytecode_to_native: Vec::new(),
            func_ent_pcs: Vec::new(),
            reloc_call_sites: Vec::new(),
            user_extern_call_sites: Vec::new(),
            ssa_line_rows: Vec::new(),
            imports: ResolvedImports {
                imports: vec![ResolvedImport {
                    binding_idx: 0,
                    local_name: "exit".into(),
                    real_symbol: "exit".into(),
                    dylib_index: 0,
                    is_variadic: false,
                    fixed_args: 1,
                    return_type_tag: 0,
                    returns_long_double: false,
                    param_types: Vec::new(),
                }],
                dylibs: vec![ResolvedDylib {
                    name: "libc".into(),
                    path: "libc.so.6".into(),
                }],
            },
            abi: super::super::Target::LinuxAarch64.abi(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            tls_index_fixups: Vec::new(),
            data_relocs: Vec::new(),
            code_relocs: Vec::new(),
            exports: Vec::new(),
            output_kind: super::super::OutputKind::Executable,
            dllmain_pc: None,
            macho_tlv_fixups: Vec::new(),
            macho_tlv_descriptors: Vec::new(),
            debug_info: true,
            plt_trampoline_offsets: Vec::new(),
        }
    }

    fn read_u32(buf: &[u8], off: usize) -> u32 {
        u32::from_le_bytes(buf[off..off + 4].try_into().unwrap())
    }
    fn read_u64(buf: &[u8], off: usize) -> u64 {
        u64::from_le_bytes(buf[off..off + 8].try_into().unwrap())
    }

    #[test]
    fn writes_elf_magic() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        assert_eq!(&bytes[0..4], &ELFMAG);
    }

    #[test]
    fn class_is_64_bit_le() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        assert_eq!(bytes[4], ELFCLASS64);
        assert_eq!(bytes[5], ELFDATA2LSB);
    }

    #[test]
    fn machine_is_aarch64() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let e_machine = u16::from_le_bytes(bytes[18..20].try_into().unwrap());
        assert_eq!(e_machine, EM_AARCH64);
    }

    #[test]
    fn program_header_table_self_describes() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let phoff = read_u64(&bytes, 32);
        let phentsize = u16::from_le_bytes(bytes[54..56].try_into().unwrap()) as u64;
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;

        let mut found = false;
        for i in 0..phnum {
            let off = (phoff + i * phentsize) as usize;
            let p_type = read_u32(&bytes, off);
            if p_type == PT_PHDR {
                let p_offset = read_u64(&bytes, off + 8);
                let p_filesz = read_u64(&bytes, off + 32);
                assert_eq!(p_offset, phoff);
                assert_eq!(p_filesz, phnum * phentsize);
                found = true;
                break;
            }
        }
        assert!(found, "PT_PHDR entry not found");
    }

    #[test]
    fn pt_load_covers_entry_point() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let e_entry = read_u64(&bytes, 24);
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;

        let mut covered = false;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            let p_type = read_u32(&bytes, off);
            if p_type != PT_LOAD {
                continue;
            }
            let p_flags = read_u32(&bytes, off + 4);
            if p_flags & PF_X == 0 {
                continue;
            }
            let p_vaddr = read_u64(&bytes, off + 16);
            let p_memsz = read_u64(&bytes, off + 40);
            if e_entry >= p_vaddr && e_entry < p_vaddr + p_memsz {
                covered = true;
                break;
            }
        }
        assert!(covered, "no executable PT_LOAD covers e_entry {e_entry:#x}");
    }

    #[test]
    fn interp_string_is_correct() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(&bytes, off) != PT_INTERP {
                continue;
            }
            let p_offset = read_u64(&bytes, off + 8) as usize;
            let p_filesz = read_u64(&bytes, off + 32) as usize;
            let s = &bytes[p_offset..p_offset + p_filesz - 1]; // drop NUL
            assert_eq!(s, interp_path(Machine::Aarch64).as_bytes());
            return;
        }
        panic!("PT_INTERP not found");
    }

    #[test]
    fn dynamic_section_present_and_terminated() {
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        let mut dyn_off = 0u64;
        let mut dyn_sz = 0u64;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(&bytes, off) == PT_DYNAMIC {
                dyn_off = read_u64(&bytes, off + 8);
                dyn_sz = read_u64(&bytes, off + 32);
                break;
            }
        }
        assert!(dyn_off > 0 && dyn_sz > 0, "PT_DYNAMIC missing");
        // Last entry must be DT_NULL.
        let last = (dyn_off + dyn_sz - ELF64_DYN_SIZE) as usize;
        assert_eq!(read_u64(&bytes, last), DT_NULL);
    }

    #[test]
    fn elf_hash_matches_known_values() {
        // Cross-check with the canonical SysV ELF hash function.
        // Values verified by hand-tracing the algorithm; if these
        // change, the loader will look in the wrong bucket and
        // every libc symbol will silently miss.
        assert_eq!(elf_hash(b""), 0);
        assert_eq!(elf_hash(b"printf"), 0x077905a6);
        assert_eq!(elf_hash(b"malloc"), 0x07383353);
        assert_eq!(elf_hash(b"exit"), 0x0006cf04);
    }

    #[test]
    fn rela_dyn_targets_got_slots() {
        // Each .rela.dyn entry must target a valid GOT slot. Walk
        // PT_DYNAMIC for DT_RELA / DT_RELASZ, then verify each entry's
        // r_offset lies inside the rw PT_LOAD segment.
        let bytes = write(&tiny_program(), &tiny_build(), Machine::Aarch64).unwrap();
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;

        let mut dyn_off = 0u64;
        let mut dyn_sz = 0u64;
        let mut rw_lo = u64::MAX;
        let mut rw_hi = 0u64;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            let p_type = read_u32(&bytes, off);
            if p_type == PT_DYNAMIC {
                dyn_off = read_u64(&bytes, off + 8);
                dyn_sz = read_u64(&bytes, off + 32);
            }
            if p_type == PT_LOAD {
                let p_flags = read_u32(&bytes, off + 4);
                if p_flags & PF_W != 0 {
                    rw_lo = read_u64(&bytes, off + 16);
                    rw_hi = rw_lo + read_u64(&bytes, off + 40);
                }
            }
        }

        // Walk dynamic to find DT_RELA / DT_RELASZ.
        let mut rela_vmaddr = 0u64;
        let mut rela_size = 0u64;
        let mut p = dyn_off as usize;
        while (p as u64) < dyn_off + dyn_sz {
            let tag = read_u64(&bytes, p);
            let val = read_u64(&bytes, p + 8);
            if tag == DT_RELA {
                rela_vmaddr = val;
            }
            if tag == DT_RELASZ {
                rela_size = val;
            }
            p += ELF64_DYN_SIZE as usize;
        }
        assert!(rela_vmaddr > 0 && rela_size > 0);
        // Translate vmaddr to file offset (ET_EXEC, no slide).
        let rela_file_off = (rela_vmaddr - TEXT_VMADDR_BASE) as usize;
        let n = (rela_size / ELF64_RELA_SIZE) as usize;
        for i in 0..n {
            let r_offset = read_u64(&bytes, rela_file_off + i * ELF64_RELA_SIZE as usize);
            assert!(
                r_offset >= rw_lo && r_offset < rw_hi,
                "rela {i} r_offset {r_offset:#x} not inside rw PT_LOAD [{rw_lo:#x}, {rw_hi:#x})"
            );
        }
    }

    /// Walk the program-header table for the first phdr matching
    /// `p_type`. Returns `None` if no such phdr exists. Used by
    /// the TLS structural tests to assert presence / absence of
    /// `PT_TLS`.
    fn find_phdr(bytes: &[u8], p_type: u32) -> Option<usize> {
        let phoff = read_u64(bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(bytes, off) == p_type {
                return Some(off);
            }
        }
        None
    }

    /// `_Thread_local`-free programs must NOT carry a `PT_TLS`
    /// program header. The dynamic loader uses `PT_TLS` to size
    /// per-thread storage at thread creation; emitting one for a
    /// program with no TLS image would make glibc allocate empty
    /// per-thread regions on every clone, masking the bug behind
    /// a small but nonzero overhead.
    #[test]
    fn no_thread_local_means_no_pt_tls() {
        // The x86_64 `_start` stub picks argc/argv registers
        // out of `abi.int_arg_regs`, and its hard-coded
        // `START_STUB_LEN = 23` assumes the SysV ABI's RDI/RSI.
        // `tiny_build()`'s default `abi` is `LinuxAarch64`'s,
        // whose `int_arg_regs[0]` is byte 0 -- which collides
        // with RAX in x86_64 land and turns the post-call
        // `mov argc_reg, rax` into a self-mov the elision pass
        // drops, shortening the stub by 3 bytes. Build with the
        // matching target so each path sees its own ABI.
        for (machine, target) in [
            (Machine::Aarch64, super::super::Target::LinuxAarch64),
            (Machine::X86_64, super::super::Target::LinuxX64),
        ] {
            let mut b = tiny_build();
            b.abi = target.abi();
            let bytes = write(&tiny_program(), &b, machine).unwrap();
            assert!(
                find_phdr(&bytes, PT_TLS).is_none(),
                "{machine:?}: unexpected PT_TLS phdr in TLS-free image"
            );
        }
    }

    /// Compile a `_Thread_local`-using program for Linux/aarch64,
    /// confirm a `PT_TLS` phdr is emitted, and check its
    /// `p_filesz` / `p_memsz` match `tls_init_size` / total TLS
    /// size. Mirrors the structural check in
    /// `c5::codegen::pe::tests::thread_local_emits_well_formed_tls_directory_x64`.
    #[test]
    fn thread_local_emits_well_formed_pt_tls_aarch64() {
        use crate::Compiler;
        // Two distinct TLS variables: 16 bytes of .tbss total,
        // 0 bytes of .tdata (no initialiser syntax yet).
        let src = "_Thread_local int counter; _Thread_local int marker; \
             int main() { counter = 1; marker = 2; return counter + marker; }";
        let program = Compiler::with_target(
            super::super::super::tests::with_prelude(src),
            super::super::Target::LinuxAarch64,
        )
        .compile()
        .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::LinuxAarch64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(&tiny_program(), &build, Machine::Aarch64).expect("write ELF");

        let phdr_off = find_phdr(&bytes, PT_TLS).expect("expected PT_TLS phdr");
        let p_flags = read_u32(&bytes, phdr_off + 4);
        let p_offset = read_u64(&bytes, phdr_off + 8);
        let p_filesz = read_u64(&bytes, phdr_off + 32);
        let p_memsz = read_u64(&bytes, phdr_off + 40);
        let p_align = read_u64(&bytes, phdr_off + 48);

        // PT_TLS is read-only metadata as far as the loader is
        // concerned; PF_R is the canonical setting, matching what
        // ld.so emits for static-exec TLS.
        assert_eq!(p_flags, PF_R, "PT_TLS flags should be PF_R");
        // `p_filesz` covers .tdata only; `p_memsz` covers .tdata
        // plus .tbss. With no initialiser syntax in c5, the c5
        // frontend produces tls_init_size = 0, so p_filesz is 0
        // and p_memsz equals the full TLS block size.
        assert_eq!(
            p_filesz, build.tls_init_size as u64,
            "PT_TLS p_filesz must equal .tdata size"
        );
        assert_eq!(
            p_memsz,
            build.tls_data.len() as u64,
            "PT_TLS p_memsz must equal .tdata + .tbss size"
        );
        assert_eq!(p_memsz, 16, "two int TLS vars => 16 bytes per thread");
        // Alignment 8 matches glibc's TLS image alignment for
        // word-sized variables.
        assert_eq!(p_align, 8);
        // The TLS image must lie inside an rw PT_LOAD so the
        // loader can read .tdata as the per-thread initial image.
        let phoff = read_u64(&bytes, 32);
        let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
        let mut covered = false;
        for i in 0..phnum {
            let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
            if read_u32(&bytes, off) != PT_LOAD {
                continue;
            }
            let p_off = read_u64(&bytes, off + 8);
            let p_fsz = read_u64(&bytes, off + 32);
            if p_offset >= p_off && p_offset + p_filesz <= p_off + p_fsz {
                covered = true;
                break;
            }
        }
        assert!(
            covered || p_filesz == 0,
            "PT_TLS image not covered by any PT_LOAD"
        );
    }

    /// x86_64 mirror of the aarch64 PT_TLS structural test. The
    /// per-arch lowering encodes the TLS access differently
    /// (variant-2 `mov r13, fs:[0]; sub r13, tpoff` vs aarch64's
    /// variant-1 `mrs ... tpidr_el0`), but the writer side --
    /// PT_TLS phdr + .tdata layout -- is shared.
    #[test]
    fn thread_local_emits_well_formed_pt_tls_x86_64() {
        use crate::Compiler;
        let src = "_Thread_local int counter; \
             int main() { counter = 7; return counter; }";
        let program = Compiler::with_target(
            super::super::super::tests::with_prelude(src),
            super::super::Target::LinuxX64,
        )
        .compile()
        .expect("compile");
        let build = super::super::lower_for(
            &program,
            super::super::Target::LinuxX64,
            super::super::NativeOptions::default(),
        )
        .expect("lower");
        let bytes = write(&tiny_program(), &build, Machine::X86_64).expect("write ELF");

        let phdr_off = find_phdr(&bytes, PT_TLS).expect("expected PT_TLS phdr");
        let p_filesz = read_u64(&bytes, phdr_off + 32);
        let p_memsz = read_u64(&bytes, phdr_off + 40);
        assert_eq!(
            p_filesz, build.tls_init_size as u64,
            "PT_TLS p_filesz must equal .tdata size"
        );
        assert_eq!(
            p_memsz,
            build.tls_data.len() as u64,
            "PT_TLS p_memsz must equal .tdata + .tbss size"
        );
        assert_eq!(p_memsz, 8, "single int TLS var => 8 bytes per thread");
    }

    /// Shared-library output (`OutputKind::SharedLibrary`)
    /// flips `e_type` to `ET_DYN` and adds the
    /// `#pragma export(<name>)` symbols to `.dynsym` as
    /// `STB_GLOBAL | STT_FUNC` defined entries. This test
    /// covers the structural side: e_type is right, the
    /// export string lives in `.dynstr`, and the `.dynsym`
    /// entry has `st_value` set to a non-zero VA pointing
    /// inside the code segment. End-to-end runtime tests
    /// (dlopen / dlsym / call) live on the Linux orb VMs in
    /// CI -- macOS hosts can't load Linux ELFs directly.
    #[test]
    fn shared_library_output_emits_et_dyn_with_exports() {
        use crate::Compiler;
        let src = "
            int answer() { return 42; }
            #pragma export(answer)
            int main() { return 0; }
        ";
        for (machine, target) in [
            (Machine::Aarch64, super::super::Target::LinuxAarch64),
            (Machine::X86_64, super::super::Target::LinuxX64),
        ] {
            let program =
                Compiler::with_target(super::super::super::tests::with_prelude(src), target)
                    .compile()
                    .expect("compile");
            let build = super::super::lower_for(
                &program,
                target,
                super::super::NativeOptions::new().with_shared_library(),
            )
            .expect("lower");
            let bytes = write(&tiny_program(), &build, machine).expect("write ELF");

            // e_type = ET_DYN.
            let e_type = u16::from_le_bytes(bytes[16..18].try_into().unwrap());
            assert_eq!(e_type, ET_DYN, "{machine:?}: expected ET_DYN");

            // .dynstr contains "answer".
            let phoff = read_u64(&bytes, 32);
            let phnum = u16::from_le_bytes(bytes[56..58].try_into().unwrap()) as u64;
            let mut dynsym_vmaddr = 0u64;
            let mut dynstr_vmaddr = 0u64;
            let mut load_min = u64::MAX;
            for i in 0..phnum {
                let off = (phoff + i * PROGRAM_HEADER_SIZE) as usize;
                if read_u32(&bytes, off) == PT_LOAD {
                    load_min = load_min.min(read_u64(&bytes, off + 16));
                }
                if read_u32(&bytes, off) == PT_DYNAMIC {
                    let dyn_off = read_u64(&bytes, off + 8);
                    let dyn_sz = read_u64(&bytes, off + 32);
                    let mut p = dyn_off as usize;
                    while (p as u64) < dyn_off + dyn_sz {
                        let tag = read_u64(&bytes, p);
                        let val = read_u64(&bytes, p + 8);
                        if tag == DT_SYMTAB {
                            dynsym_vmaddr = val;
                        }
                        if tag == DT_STRTAB {
                            dynstr_vmaddr = val;
                        }
                        p += ELF64_DYN_SIZE as usize;
                    }
                }
            }
            assert!(dynsym_vmaddr > 0 && dynstr_vmaddr > 0);
            // Translate vmaddr to file offset via the rw
            // PT_LOAD's vmaddr base. .dynsym + .dynstr both
            // live inside the rx PT_LOAD which is mapped at
            // TEXT_VMADDR_BASE.
            let dynstr_file_off = (dynstr_vmaddr - load_min) as usize;
            let dynstr_slice = &bytes[dynstr_file_off..];
            let mut found_export = false;
            for off in 0..dynstr_slice.len().saturating_sub(7) {
                if &dynstr_slice[off..off + 7] == b"answer\0" {
                    found_export = true;
                    break;
                }
            }
            assert!(found_export, "{machine:?}: `answer` missing from .dynstr");

            // .dynsym last entry is the export -- check
            // st_info encodes STB_GLOBAL | STT_FUNC and
            // st_value is non-zero.
            let dynsym_file_off = (dynsym_vmaddr - load_min) as usize;
            let last_sym_off =
                dynsym_file_off + (1 + build.imports.imports.len()) * ELF64_SYM_SIZE as usize;
            let st_info = bytes[last_sym_off + 4];
            let st_value = read_u64(&bytes, last_sym_off + 8);
            assert_eq!(
                st_info,
                (STB_GLOBAL << 4) | STT_FUNC,
                "{machine:?}: export symbol must be STB_GLOBAL | STT_FUNC"
            );
            assert!(
                st_value > 0,
                "{machine:?}: export st_value must be the function VA"
            );
        }
    }
}

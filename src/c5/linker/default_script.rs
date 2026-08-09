//! Built-in default linker script, used when a final link names none.
//!
//! GNU ld carries one internal script per emulation and output kind and
//! falls back on it; this is the same arrangement. The script names the
//! sections whose order a loader or a consumer depends on -- the
//! dynamic tables ahead of the text, the writable group on its own page
//! -- and leaves everything else to the engine's orphan placement,
//! which puts an unnamed section with the last section of its
//! allocation class, as bfd's does.

#![cfg(feature = "std")]

use alloc::string::String;

/// bfd's default text base, the same on both emulations: an executable
/// starts clear of the first page so a null dereference faults; a
/// shared object is position independent and starts at zero.
const TEXT_BASE: &str = "0x400000";

/// The default script as an `ld` script source. `shared` selects the
/// ET_DYN variant.
pub fn default_script(shared: bool) -> String {
    let base = if shared { "0" } else { TEXT_BASE };
    // The read-only group runs from the headers; the writable group
    // starts on a fresh page so it can carry different permissions.
    alloc::format!(
        r#"ENTRY(_start)
SECTIONS
{{
  . = {base} + SIZEOF_HEADERS;
  .note.gnu.build-id : {{ *(.note.gnu.build-id) }}
  .hash : {{ *(.hash) }}
  .gnu.hash : {{ *(.gnu.hash) }}
  .dynsym : {{ *(.dynsym) }}
  .dynstr : {{ *(.dynstr) }}
  .gnu.version : {{ *(.gnu.version) }}
  .gnu.version_d : {{ *(.gnu.version_d) }}
  .gnu.version_r : {{ *(.gnu.version_r) }}
  .rela.dyn : {{ *(.rela.dyn) *(.rela.*) }}
  .relr.dyn : {{ *(.relr.dyn) }}
  .init : {{ KEEP (*(SORT_NONE(.init))) }}
  .text : {{ *(.text .text.* .gnu.linkonce.t.*) }}
  .fini : {{ KEEP (*(SORT_NONE(.fini))) }}
  .rodata : {{ *(.rodata .rodata.* .gnu.linkonce.r.*) }}
  .eh_frame_hdr : {{ *(.eh_frame_hdr) }}
  .eh_frame : {{ KEEP (*(.eh_frame)) *(.eh_frame.*) }}

  . = ALIGN(CONSTANT(MAXPAGESIZE)) + (. & (CONSTANT(MAXPAGESIZE) - 1));

  .preinit_array : {{
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  }}
  .init_array : {{
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT_BY_NAME(.init_array.*)))
    KEEP (*(.init_array))
    PROVIDE_HIDDEN (__init_array_end = .);
  }}
  .fini_array : {{
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(SORT_BY_NAME(.fini_array.*)))
    KEEP (*(.fini_array))
    PROVIDE_HIDDEN (__fini_array_end = .);
  }}
  .data.rel.ro : {{ *(.data.rel.ro .data.rel.ro.*) }}
  .dynamic : {{ *(.dynamic) }}
  .got : {{ *(.got) *(.igot) }}
  .got.plt : {{ *(.got.plt) *(.igot.plt) }}
  .data : {{ *(.data .data.* .gnu.linkonce.d.*) }}
  .bss : {{ *(.dynbss) *(.bss .bss.* .gnu.linkonce.b.*) *(COMMON) }}
  _end = .; PROVIDE (end = .);

  /DISCARD/ : {{ *(.note.GNU-stack) *(.gnu_debuglink) *(.gnu.lto_*) }}
}}
"#
    )
}

//! Built-in default linker script, used when a final link names none,
//! as GNU ld falls back on its internal one. It names the sections
//! whose order a consumer depends on and leaves the rest to orphan
//! placement.

#![cfg(feature = "std")]

use alloc::string::String;

/// bfd's default text base on both emulations. An executable starts
/// clear of the first page so a null dereference faults.
const TEXT_BASE: &str = "0x400000";

/// The default script as an `ld` script source. `shared` selects the
/// ET_DYN variant, which is position independent and starts at zero.
/// No `ENTRY`: an entry the caller never named is not a diagnostic,
/// and an unnamed one resolves per output kind in the engine.
pub fn default_script(shared: bool) -> String {
    let base = if shared { "0" } else { TEXT_BASE };
    alloc::format!(
        r#"SECTIONS
{{
  . = {base} + SIZEOF_HEADERS;
  .note.gnu.property : {{ *(.note.gnu.property) }}
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

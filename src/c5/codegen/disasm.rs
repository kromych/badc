//! Textual listing of the lowered code.
//!
//! Walks `Program::text` and `Build::bytecode_to_native` together to
//! print each c4 op with the native bytes it lowered to. Output is
//! grouped per-op so the bytecode-to-machine mapping is obvious;
//! within each op we just dump hex bytes (no mnemonics, since
//! disassembling x86_64 in particular is a project on its own).
//! Users who want full mnemonics can pipe a binary through
//! `objdump -d --disassemble`.
//!
//! Triggered by the CLI's `--dump-asm` flag.

use alloc::format;
use alloc::string::String;

use super::super::op::Op;
use super::super::program::Program;
use super::{Build, Target};

/// Render a textual listing of `build.text` keyed by the c4 ops in
/// `program.text`. Returns the listing as a string so callers can
/// print it, write it to a file, or inline it in an error.
pub(super) fn dump(program: &Program, build: &Build, target: Target) -> String {
    let mut out = String::new();
    push_header(&mut out, program, build, target);
    push_bytecode_listing(&mut out, program, build);
    push_data_listing(&mut out, build);
    push_fixup_summary(&mut out, build);
    out
}

fn push_header(out: &mut String, program: &Program, build: &Build, target: Target) {
    out.push_str(&format!(
        "; target:        {}\n",
        match target {
            Target::MacOSAarch64 => "macos-aarch64",
            Target::LinuxAarch64 => "linux-aarch64",
            Target::LinuxX64 => "linux-x64",
            Target::WindowsX64 => "windows-x64",
            Target::WindowsAarch64 => "windows-arm64",
        }
    ));
    out.push_str(&format!("; code bytes:    {}\n", build.text.len()));
    out.push_str(&format!("; data bytes:    {}\n", build.data.len()));
    out.push_str(&format!("; entry offset:  {:#06x}\n", build.entry_offset));
    out.push_str(&format!("; bytecode pcs:  {}\n", program.text.len()));
    out.push_str(";\n");
}

fn push_bytecode_listing(out: &mut String, program: &Program, build: &Build) {
    out.push_str("; --- bytecode -> native ---\n");
    out.push_str(";\n");

    if build.bytecode_to_native.is_empty() {
        out.push_str(
            "; (bytecode_to_native map empty -- did this Build come from a writer test?)\n",
        );
        return;
    }

    let mut bc_pc = 0usize;
    let mut last_fn_label: Option<String> = None;
    while bc_pc < program.text.len() {
        let raw = program.text[bc_pc];
        let Some(op) = Op::from_i64(raw) else {
            // Garbage word -- shouldn't happen post-compile, but
            // surface it rather than silently advance.
            out.push_str(&format!(
                "[bc={:>4}] (bad opcode {raw:#x}); halting listing\n",
                bc_pc
            ));
            return;
        };

        let native_start = build.bytecode_to_native[bc_pc];
        if native_start == usize::MAX {
            // The optimizer / DCE shouldn't leave dangling indices in
            // the live bytecode, but if one slipped through, skip it
            // rather than misalign the rest of the listing.
            bc_pc += op.word_size();
            continue;
        }
        // Find the *next* live entry to bound the byte range.
        let native_end = next_native_offset(build, bc_pc + op.word_size());

        // Function-boundary marker: when the source function name
        // changes, drop a `; <function>` header so the listing is
        // navigable by C function name. Quiet when the debug map
        // is empty (e.g. -O ran).
        let cur_fn = program.source_functions.get(bc_pc);
        if let Some(fn_name) = cur_fn
            && !fn_name.is_empty()
            && last_fn_label.as_deref() != Some(fn_name.as_str())
        {
            out.push_str(&format!(";\n; ---- {fn_name} ----\n;\n"));
            last_fn_label = Some(fn_name.clone());
        }

        let operand_str = if op.operand_count() > 0 {
            format!(" {}", program.text[bc_pc + 1])
        } else {
            String::new()
        };
        // Source-line annotation. Indexed by bc_pc; 0 means
        // "unknown" (the optimizer drops the map; data emit
        // doesn't push entries).
        let line_str = match program.source_lines.get(bc_pc).copied() {
            Some(0) | None => String::new(),
            Some(n) => format!("    ; line {n}"),
        };
        out.push_str(&format!(
            "[bc={:>4}] {:?}{}{}\n",
            bc_pc, op, operand_str, line_str
        ));
        push_hex_bytes(out, &build.text[native_start..native_end], native_start);

        bc_pc += op.word_size();
    }
}

/// Find the smallest native_offset > or = bytecode index `from`.
/// `bytecode_to_native` is sparse (operand slots hold `usize::MAX`),
/// so we walk forward to the next real entry. The final slot
/// (`text.len()`) holds the total code length, so we always
/// terminate.
fn next_native_offset(build: &Build, from: usize) -> usize {
    for i in from..=build.bytecode_to_native.len().saturating_sub(1) {
        let v = build.bytecode_to_native[i];
        if v != usize::MAX {
            return v;
        }
    }
    build.text.len()
}

/// Push the bytes at `slice` as hex, prefixed by `start`-relative
/// offsets. 16 bytes per line; aligned columns so the eye can skim.
fn push_hex_bytes(out: &mut String, slice: &[u8], start: usize) {
    if slice.is_empty() {
        return;
    }
    let mut off = 0;
    while off < slice.len() {
        let end = (off + 16).min(slice.len());
        let row = &slice[off..end];
        out.push_str(&format!("  {:#06x}: ", start + off));
        for b in row {
            out.push_str(&format!("{b:02x} "));
        }
        // Pad short rows so trailing comments would line up.
        for _ in row.len()..16 {
            out.push_str("   ");
        }
        out.push('\n');
        off += 16;
    }
}

fn push_data_listing(out: &mut String, build: &Build) {
    if build.data.is_empty() {
        return;
    }
    out.push_str(";\n");
    out.push_str(&format!(
        "; --- data segment ({} bytes) ---\n",
        build.data.len()
    ));
    out.push_str(";\n");
    push_hex_bytes(out, &build.data, 0);
}

fn push_fixup_summary(out: &mut String, build: &Build) {
    if build.got_fixups.is_empty() && build.data_fixups.is_empty() && build.func_fixups.is_empty() {
        return;
    }
    out.push_str(";\n");
    out.push_str("; --- fixups ---\n");
    out.push_str(&format!("; GOT:  {}\n", build.got_fixups.len()));
    out.push_str(&format!("; data: {}\n", build.data_fixups.len()));
    out.push_str(&format!("; func: {}\n", build.func_fixups.len()));
}

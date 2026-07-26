//! Guard-page safety of the emitted stack allocations.
//!
//! A stack whose end is protected by a guard region reports an overflow
//! only when the access that oversteps the end lands inside that region.
//! A single stack-pointer decrement larger than one page can move past
//! the region entirely, after which the first store writes into whatever
//! mapping lies below it. The backends therefore descend in probed steps
//! (`emit_stack_alloc`); this module decodes the emitted text of the
//! whole fixture corpus and asserts the property holds instruction by
//! instruction.

use crate::c5::codegen::ssa::emit_common::{MAX_UNPROBED_STACK_STEP, STACK_PROBE_PAGE};
use crate::{Compiler, NativeOptions, Target};

/// One stack-pointer decrement found in emitted text.
struct Decrement {
    /// Byte offset in the text stream.
    at: usize,
    /// Bytes the instruction subtracts from the stack pointer.
    bytes: u32,
    /// A store through the stack pointer immediately follows.
    probed: bool,
}

/// Decode every `sub rsp, imm` in `text`. `48 81 EC id` is the imm32
/// form the prologue and the call-argument lowering emit; `48 83 EC ib`
/// is the sign-extended imm8 form the table-driven path can pick. A
/// following `48 C7 04 24 id` is the probe store (`movq $0, (%rsp)`).
fn x86_64_decrements(text: &[u8]) -> Vec<Decrement> {
    const PROBE: &[u8] = &[0x48, 0xC7, 0x04, 0x24, 0x00, 0x00, 0x00, 0x00];
    let mut out = Vec::new();
    let mut i = 0usize;
    while i + 4 <= text.len() {
        let (bytes, len) = match text[i..] {
            [0x48, 0x81, 0xEC, ..] if i + 7 <= text.len() => (
                u32::from_le_bytes([text[i + 3], text[i + 4], text[i + 5], text[i + 6]]),
                7,
            ),
            [0x48, 0x83, 0xEC, imm8, ..] => (imm8 as i8 as i32 as u32, 4),
            _ => {
                i += 1;
                continue;
            }
        };
        let after = i + len;
        out.push(Decrement {
            at: i,
            bytes,
            probed: text[after..].starts_with(PROBE),
        });
        i = after;
    }
    out
}

/// Decode every `sub sp, sp, #imm{, lsl #12}` in `text`. A64 is
/// fixed-width and the text stream is 4-byte aligned, so the scan is
/// exact. A following `str xzr, [sp]` (`0xF90003FF`) is the probe store.
fn aarch64_decrements(text: &[u8]) -> Vec<Decrement> {
    const PROBE: u32 = 0xF900_03FF;
    let word = |at: usize| -> Option<u32> {
        text.get(at..at + 4)
            .map(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
    };
    let mut out = Vec::new();
    for at in (0..text.len().saturating_sub(3)).step_by(4) {
        let insn = word(at).unwrap();
        // SUB (immediate), 64-bit: sf=1 op=1 S=0 -> 0xD1, Rd = Rn = 31.
        if insn & 0xFF00_0000 != 0xD100_0000 || (insn & 0x3FF) != 0x3FF {
            continue;
        }
        let imm12 = (insn >> 10) & 0xFFF;
        let bytes = match (insn >> 22) & 0x3 {
            0 => imm12,
            1 => imm12 << 12,
            // Reserved shift encoding; not produced by the backend.
            _ => continue,
        };
        out.push(Decrement {
            at,
            bytes,
            probed: word(at + 4) == Some(PROBE),
        });
    }
    out
}

/// Compile `src` for `target` at `-O` and return the emitted text, or
/// `None` when the fixture does not build for that target (a source
/// whose inline asm names the other ISA, a deliberate-rejection case).
fn text_for(src: &str, target: Target) -> Option<Vec<u8>> {
    let program = Compiler::with_target(src.to_string(), target)
        .compile()
        .ok()?;
    let opts = NativeOptions {
        optimize: true,
        ..NativeOptions::default()
    };
    crate::c5::codegen::lower_for(&program, target, opts)
        .ok()
        .map(|b| b.text)
}

/// Every stack-pointer decrement in every fixture, for both Linux
/// targets, at `-O`: no single decrement may exceed one page, and one
/// larger than [`MAX_UNPROBED_STACK_STEP`] must be followed by a store
/// through the stack pointer, which is where the fault is taken. Runs
/// over the corpus rather than a fixture list so a new sp-moving
/// lowering is covered the moment any fixture reaches it.
#[test]
fn stack_decrements_cannot_step_over_a_guard_page() {
    let dir = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("tests")
        .join("fixtures")
        .join("c");
    let mut fixtures: Vec<std::path::PathBuf> = std::fs::read_dir(&dir)
        .expect("read tests/fixtures/c")
        .filter_map(|e| e.ok().map(|e| e.path()))
        .filter(|p| p.extension().and_then(|s| s.to_str()) == Some("c"))
        .collect();
    fixtures.sort();
    assert!(!fixtures.is_empty(), "no fixtures under {}", dir.display());

    let mut violations: Vec<String> = Vec::new();
    let mut scanned = 0usize;
    let mut decrements = 0usize;
    let mut largest = 0u32;
    for fixture in &fixtures {
        let Ok(src) = std::fs::read_to_string(fixture) else {
            continue;
        };
        let name = fixture.file_name().unwrap().to_string_lossy().into_owned();
        for target in [Target::LinuxX64, Target::LinuxAarch64] {
            let Some(text) = text_for(&src, target) else {
                continue;
            };
            scanned += 1;
            let found = match target {
                Target::LinuxX64 => x86_64_decrements(&text),
                _ => aarch64_decrements(&text),
            };
            decrements += found.len();
            for d in found {
                largest = largest.max(d.bytes);
                if d.bytes > STACK_PROBE_PAGE || (d.bytes > MAX_UNPROBED_STACK_STEP && !d.probed) {
                    violations.push(format!(
                        "[{target:?}] {name}: {b} bytes at text+{at:#x}, probed={p}",
                        b = d.bytes,
                        at = d.at,
                        p = d.probed
                    ));
                }
            }
        }
    }

    assert!(
        violations.is_empty(),
        "{} guard-unsafe stack decrement(s) of {decrements} scanned:\n{}",
        violations.len(),
        violations.join("\n")
    );
    // The corpus carries large-frame fixtures, so the scan must have
    // seen the probed form at least once; otherwise it is decoding
    // nothing and would pass on any output.
    assert!(scanned > 1000, "too few units scanned: {scanned}");
    assert!(
        largest >= STACK_PROBE_PAGE,
        "no page-sized decrement found -- decoder or corpus regressed (largest {largest})"
    );
}

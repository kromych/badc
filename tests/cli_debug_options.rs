//! The `-g` option family: which spellings the driver accepts, which it
//! reports on, which it rejects, and the DWARF each one produces.
//!
//! Every case runs the real driver against `--target=linux-x64` so the
//! assertions are on an emitted ELF object, and reads the `.debug_info`
//! and `.debug_line` unit headers directly rather than through a dumper.

use std::path::PathBuf;
use std::process::Command;

fn badc() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_badc"))
}

const SOURCE: &str = "int add(int a, int b) { return a + b; }\n";

struct Run {
    status: i32,
    stderr: String,
    /// `.debug_info` and `.debug_line` unit versions, absent when the
    /// object carries no such section.
    info_version: Option<u16>,
    line_version: Option<u16>,
}

/// Compile one translation unit under `flags` and read what came out.
fn compile(flags: &[&str]) -> Run {
    let dir = std::env::temp_dir().join(format!(
        "badc-debug-options-{}-{}",
        std::process::id(),
        flags.join("_").replace(['-', '=', ','], "")
    ));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let src = dir.join("a.c");
    std::fs::write(&src, SOURCE).expect("write source");
    let obj = dir.join("a.o");
    let out = Command::new(badc())
        .args(["--gnu", "-q", "--target=linux-x64", "-c"])
        .args(flags)
        .arg(&src)
        .arg("-o")
        .arg(&obj)
        .output()
        .expect("run badc");
    let elf = std::fs::read(&obj).unwrap_or_default();
    let run = Run {
        status: out.status.code().unwrap_or(-1),
        stderr: String::from_utf8_lossy(&out.stderr).into_owned(),
        info_version: unit_version(&elf, ".debug_info"),
        line_version: unit_version(&elf, ".debug_line"),
    };
    let _ = std::fs::remove_dir_all(&dir);
    run
}

/// The `version` field of the first unit header in `want`: a 32-bit
/// `unit_length` followed by the 16-bit version, in both sections.
fn unit_version(elf: &[u8], want: &str) -> Option<u16> {
    let body = section(elf, want)?;
    Some(u16::from_le_bytes([body[4], body[5]]))
}

fn section<'a>(elf: &'a [u8], want: &str) -> Option<&'a [u8]> {
    let u16le = |off: usize| u16::from_le_bytes([elf[off], elf[off + 1]]);
    let u32le = |off: usize| u32::from_le_bytes(elf[off..off + 4].try_into().unwrap());
    let u64le = |off: usize| u64::from_le_bytes(elf[off..off + 8].try_into().unwrap());
    if elf.len() < 64 || &elf[..4] != b"\x7fELF" {
        return None;
    }
    let shoff = u64le(0x28) as usize;
    let shentsize = u16le(0x3a) as usize;
    let shnum = u16le(0x3c) as usize;
    let shstrndx = u16le(0x3e) as usize;
    let strtab = {
        let sh = shoff + shstrndx * shentsize;
        let off = u64le(sh + 0x18) as usize;
        &elf[off..off + u64le(sh + 0x20) as usize]
    };
    (0..shnum).find_map(|i| {
        let sh = shoff + i * shentsize;
        let at = u32le(sh) as usize;
        let end = at + strtab[at..].iter().position(|&c| c == 0)?;
        (&strtab[at..end] == want.as_bytes()).then(|| {
            let off = u64le(sh + 0x18) as usize;
            &elf[off..off + u64le(sh + 0x20) as usize]
        })
    })
}

/// What badc emits, which every honoured request is measured against.
const EMITTED_VERSION: u16 = badc::DWARF_VERSION;

#[test]
fn the_level_spellings_select_the_one_level_badc_emits() {
    for flags in [
        &["-g"][..],
        &["-g1"],
        &["-g2"],
        &["-g3"],
        &["-ggdb"],
        &["-ggdb1"],
        &["-ggdb3"],
        &["--debug"],
    ] {
        let run = compile(flags);
        assert_eq!(run.status, 0, "{flags:?}: {}", run.stderr);
        assert_eq!(run.stderr, "", "{flags:?} reported something");
        assert_eq!(run.info_version, Some(EMITTED_VERSION), "{flags:?}");
        assert_eq!(run.line_version, Some(EMITTED_VERSION), "{flags:?}");
    }
}

#[test]
fn level_zero_emits_no_debug_sections() {
    for flags in [&["-g0"][..], &["-ggdb0"], &["--no-debug"], &["-g", "-g0"]] {
        let run = compile(flags);
        assert_eq!(run.status, 0, "{flags:?}: {}", run.stderr);
        assert_eq!(run.stderr, "", "{flags:?} reported something");
        assert_eq!(run.info_version, None, "{flags:?}");
    }
}

#[test]
fn the_version_badc_emits_is_honoured_silently() {
    for flags in [
        &["-gdwarf-4"][..],
        // No version: DWARF debug information, at whatever version.
        &["-gdwarf"],
        // The format and the construct set badc already produces.
        &["-g", "-gdwarf32"],
        &["-g", "-gstrict-dwarf"],
        &["-g", "-gno-strict-dwarf"],
        // Last spelling of the version wins.
        &["-gdwarf-5", "-gdwarf-4"],
    ] {
        let run = compile(flags);
        assert_eq!(run.status, 0, "{flags:?}: {}", run.stderr);
        assert_eq!(run.stderr, "", "{flags:?} reported something");
        assert_eq!(run.info_version, Some(EMITTED_VERSION), "{flags:?}");
    }
}

#[test]
fn a_version_badc_does_not_emit_is_accepted_and_reported() {
    for (flags, wanted) in [
        (&["-gdwarf-2"][..], 2),
        (&["-gdwarf-3"], 3),
        (&["-gdwarf-5"], 5),
        // Leading zeros are digits, as they are to gcc.
        (&["-gdwarf-005"], 5),
        (&["-gdwarf-4", "-gdwarf-5"], 5),
    ] {
        let run = compile(flags);
        assert_eq!(run.status, 0, "{flags:?}: {}", run.stderr);
        assert!(
            run.stderr.contains(&format!(
                "asks for DWARF version {wanted}; badc emits version {EMITTED_VERSION}"
            )) && run.stderr.contains("[B7011] [-Wdwarf-output]"),
            "{flags:?} reported {:?}",
            run.stderr
        );
        // The compile went through, at the version badc writes.
        assert_eq!(run.info_version, Some(EMITTED_VERSION), "{flags:?}");
        assert_eq!(run.line_version, Some(EMITTED_VERSION), "{flags:?}");
    }
}

#[test]
fn the_sixty_four_bit_dwarf_format_is_accepted_and_reported() {
    let run = compile(&["-g", "-gdwarf64"]);
    assert_eq!(run.status, 0, "{}", run.stderr);
    assert!(
        run.stderr.contains("asks for the 64-bit DWARF format")
            && run.stderr.contains("[B7011] [-Wdwarf-output]"),
        "reported {:?}",
        run.stderr
    );
    assert_eq!(run.info_version, Some(EMITTED_VERSION));
}

#[test]
fn a_line_that_writes_no_dwarf_reports_nothing() {
    for flags in [&["-gdwarf-5", "-g0"][..], &["-gdwarf64"], &["-gdwarf32"]] {
        let run = compile(flags);
        assert_eq!(run.status, 0, "{flags:?}: {}", run.stderr);
        assert_eq!(run.stderr, "", "{flags:?} reported something");
        assert_eq!(run.info_version, None, "{flags:?}");
    }
}

#[test]
fn the_report_follows_the_w_family() {
    for flags in [
        &["-gdwarf-5", "-Wno-dwarf-output"][..],
        &["-Wno-dwarf-output", "-gdwarf-5"],
        &["-w", "-gdwarf-5"],
    ] {
        let run = compile(flags);
        assert_eq!(run.status, 0, "{flags:?}: {}", run.stderr);
        assert_eq!(run.stderr, "", "{flags:?} reported something");
        assert_eq!(run.info_version, Some(EMITTED_VERSION), "{flags:?}");
    }
    for flags in [
        &["-gdwarf-5", "-Werror"][..],
        &["-Werror", "-gdwarf-5"],
        &["-Werror=dwarf-output", "-gdwarf-5"],
    ] {
        let run = compile(flags);
        assert_eq!(run.status, 1, "{flags:?}: {}", run.stderr);
        assert!(
            run.stderr
                .contains("error: `-gdwarf-5` asks for DWARF version 5")
                && run.stderr.contains("warnings treated as errors"),
            "{flags:?} reported {:?}",
            run.stderr
        );
        assert_eq!(run.info_version, None, "{flags:?} wrote an object");
    }
}

#[test]
fn a_spelling_that_names_no_request_is_rejected() {
    for (flags, message) in [
        (&["-gdwarf-1"][..], "dwarf version 1 is not supported"),
        (&["-gdwarf-0"], "dwarf version 0 is not supported"),
        (&["-gdwarf-6"], "dwarf version 6 is not supported"),
        (&["-gdwarf-99"], "dwarf version 99 is not supported"),
        (&["-gdwarf-"], "missing argument to `-gdwarf-`"),
        (
            &["-gdwarf-4x"],
            "argument to `-gdwarf-` should be a non-negative integer",
        ),
        (
            &["-gdwarf-aranges"],
            "argument to `-gdwarf-` should be a non-negative integer",
        ),
        (&["-g4"], "debug output level `4` is too high"),
        (&["-ggdb9"], "debug output level `9` is too high"),
        // Not in the family: each changes the file set or the section
        // contents, and badc implements neither.
        (&["-gsplit-dwarf"], "unknown option `-gsplit-dwarf`"),
        (&["-gz"], "unknown option `-gz`"),
        (
            &["-gline-tables-only"],
            "unknown option `-gline-tables-only`",
        ),
        (&["-gdwarfx"], "unknown option `-gdwarfx`"),
    ] {
        let run = compile(flags);
        assert_eq!(run.status, 1, "{flags:?} was accepted");
        assert!(
            run.stderr.contains(message),
            "{flags:?} reported {:?}, wanted {message:?}",
            run.stderr
        );
        assert_eq!(run.info_version, None, "{flags:?} wrote an object");
    }
}

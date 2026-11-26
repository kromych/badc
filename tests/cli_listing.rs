//! The assembly listing `-S` writes, against the object `-c` writes for the
//! same source. Over the snapshot fixtures each listed instruction starts
//! where llvm-objdump decodes one, holds the bytes the object holds, and
//! reads as the instruction llvm-objdump names, with the same operands
//! where neither side names a symbol; an A64 field a relocation fills names
//! the relocation's symbol. The passes that change bytes after an
//! instruction is formed each leave the listing describing the object:
//! branch relaxation, a branch patched in place, the re-emission over
//! truncated bytes, alignment fill, and the writer's rewrite of an address
//! load into a load from the GOT.
//!
//! The disassembler is `llvm-objdump`, or an `objdump` that is LLVM's; a
//! host with neither skips the corpus check.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};
use std::process::Command;

mod common;
use common::TempDir;

fn badc() -> Command {
    let mut cmd = Command::new(env!("CARGO_BIN_EXE_badc"));
    cmd.env_remove("BADC_MAX_GPR").env_remove("BADC_MAX_FPR");
    cmd
}

/// The listing `badc -S` writes for `src` under `flags`.
fn listing(dir: &Path, name: &str, src: &str, flags: &[&str]) -> String {
    listing_for("linux-x64", dir, name, src, flags)
}

/// [`listing`] for `target`.
fn listing_for(target: &str, dir: &Path, name: &str, src: &str, flags: &[&str]) -> String {
    let c = dir.join(format!("{name}.c"));
    std::fs::write(&c, src).unwrap();
    let s = dir.join(format!("{name}.s"));
    let out = badc()
        .arg(format!("--target={target}"))
        .args(["-q", "-S"])
        .args(flags)
        .arg(&c)
        .arg("-o")
        .arg(&s)
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "-S failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    std::fs::read_to_string(&s).unwrap()
}

/// One row of a listing or of llvm-objdump's output.
#[derive(Debug, Clone)]
struct Row {
    bytes: Vec<u8>,
    text: String,
}

/// A listing's rows by (section, offset), and its labels by offset.
type Rows = BTreeMap<(String, u64), Row>;

/// `xx ` byte tokens, or one `xxxxxxxx` A64 word, ahead of the text of a
/// row.
fn split_bytes(mut rest: &str) -> (Vec<u8>, &str) {
    let mut bytes = Vec::new();
    let r = rest.trim_start_matches([' ', '\t']);
    if let Some(w) = r
        .get(..8)
        .filter(|w| w.bytes().all(|b| b.is_ascii_hexdigit()))
        && r.as_bytes()
            .get(8)
            .is_some_and(|b| *b == b' ' || *b == b'\t')
    {
        let word = u32::from_str_radix(w, 16).unwrap();
        return (word.to_le_bytes().to_vec(), r[9..].trim());
    }
    loop {
        let r = rest.trim_start_matches([' ', '\t']);
        let token = r
            .get(..2)
            .filter(|t| t.bytes().all(|b| b.is_ascii_hexdigit()));
        let sep = r
            .as_bytes()
            .get(2)
            .is_some_and(|b| *b == b' ' || *b == b'\t');
        match token {
            Some(t) if sep => {
                bytes.push(u8::from_str_radix(t, 16).unwrap());
                rest = &r[3..];
            }
            _ => return (bytes, r.trim()),
        }
    }
}

/// The `<offset>:` head of a row line.
fn row_offset(line: &str) -> Option<(u64, &str)> {
    let (head, rest) = line.trim_start().split_once(':')?;
    let off = u64::from_str_radix(head, 16).ok()?;
    rest.starts_with([' ', '\t']).then_some((off, rest))
}

fn parse_listing(text: &str) -> (Rows, BTreeMap<u64, String>) {
    let mut rows = Rows::new();
    let mut labels = BTreeMap::new();
    let mut pending = Vec::new();
    let mut section = String::from(".text");
    for line in text.lines() {
        if let Some(name) = line.strip_prefix("\t.section\t") {
            section = name.trim().to_string();
        } else if let Some((off, rest)) = row_offset(line) {
            let (bytes, text) = split_bytes(rest);
            for l in pending.drain(..) {
                labels.insert(off, l);
            }
            let text = text.to_string();
            rows.insert((section.clone(), off), Row { bytes, text });
        } else if let Some(l) = line.strip_suffix(':').filter(|l| !l.contains(' ')) {
            pending.push(l.to_string());
        }
    }
    (rows, labels)
}

const PREFIXES: [&str; 13] = [
    "lock", "rep", "repne", "repe", "data16", "addr32", "rex64", "cs", "ds", "es", "fs", "gs", "ss",
];

/// The relocation symbols llvm-objdump names by (section, offset).
type Relocs = BTreeMap<(String, u64), Vec<String>>;

/// llvm-objdump's rows by (section, offset), a section met again numbered
/// `name#n`; a prefix it prints on a line of its own joins the instruction.
/// Its comment starts at `//` on A64 and at `#` otherwise. The relocations
/// of each row follow it.
fn parse_objdump(text: &str, a64: bool) -> (Rows, Relocs) {
    let mut rows = Rows::new();
    let mut relocs = Relocs::new();
    let mut seen: BTreeMap<String, u32> = BTreeMap::new();
    let mut section = None;
    let mut held: Option<((String, u64), Row)> = None;
    let mut last: Option<(String, u64)> = None;
    for line in text.lines() {
        if let Some(name) = line
            .strip_prefix("Disassembly of section ")
            .and_then(|s| s.strip_suffix(':'))
        {
            let n = seen.entry(name.to_string()).or_default();
            *n += 1;
            section = Some(if *n == 1 {
                name.to_string()
            } else {
                format!("{name}#{n}")
            });
            continue;
        }
        let (Some(s), Some((off, rest))) = (&section, row_offset(line)) else {
            continue;
        };
        let (bytes, text) = split_bytes(rest);
        // An A64 relocation's symbol and addend, which the listing names.
        if let Some(r) = text.strip_prefix("R_AARCH64_") {
            let sym = r.split_whitespace().nth(1).unwrap_or_default();
            if let Some(k) = &last {
                relocs
                    .entry(k.clone())
                    .or_default()
                    .push(sym.replace('\u{1}', ""));
            }
            continue;
        }
        if bytes.is_empty() || text.contains("R_X86_64") {
            continue;
        }
        let text = match a64 {
            true => text.split("//").next().unwrap(),
            false => text.split(" #").next().unwrap().split('#').next().unwrap(),
        };
        let text = text.split_whitespace().collect::<Vec<_>>().join(" ");
        let key = (s.clone(), off);
        last = Some(key.clone());
        if let Some((k, mut row)) = held.take() {
            if k.0 == key.0 && k.1 + row.bytes.len() as u64 == off {
                row.bytes.extend(bytes);
                row.text = format!("{} {text}", row.text);
                rows.insert(k, row);
                continue;
            }
            rows.insert(k, row);
        }
        if PREFIXES.contains(&text.as_str()) {
            held = Some((key, Row { bytes, text }));
            continue;
        }
        rows.insert(key, Row { bytes, text });
    }
    (rows, relocs)
}

/// The mnemonic, the prefixes ahead of it included, and the operands, split
/// at the commas outside parentheses.
fn split_insn(text: &str) -> (String, Vec<String>) {
    let mut words = text.split_whitespace().peekable();
    let mut mnemonic = Vec::new();
    for w in words.by_ref() {
        mnemonic.push(w);
        if !PREFIXES.contains(&w) {
            break;
        }
    }
    let rest = words.collect::<Vec<_>>().join(" ");
    let mut ops = Vec::new();
    let (mut depth, mut cur) = (0, String::new());
    for ch in rest.chars() {
        match ch {
            '(' | '{' | '[' => depth += 1,
            ')' | '}' | ']' => depth -= 1,
            ',' if depth == 0 => {
                ops.push(cur.trim().to_string());
                cur.clear();
                continue;
            }
            _ => {}
        }
        cur.push(ch);
    }
    if !cur.trim().is_empty() {
        ops.push(cur.trim().to_string());
    }
    (mnemonic.join(" "), ops)
}

fn number(s: &str) -> Option<i128> {
    let (neg, s) = match s.strip_prefix('-') {
        Some(s) => (true, s),
        None => (false, s),
    };
    let v = i128::from_str_radix(s.strip_prefix("0x")?, 16).ok()?;
    Some(if neg { -v } else { v })
}

/// Whether listing operand `l` names what llvm-objdump's `o` does: equal,
/// or a symbol or a displacement the listing names where the object holds
/// a field a relocation or the layout fills. Immediates compare at the
/// operation's width.
fn same_operand(l: &str, o: &str, bits: u32) -> bool {
    if l == o {
        return true;
    }
    let (l, o) = match (l.strip_prefix('*'), o.strip_prefix('*')) {
        (Some(l), Some(o)) => (l, o),
        (None, None) => (l, o),
        _ => return false,
    };
    let seg = |s: &str| match s
        .get(..4)
        .filter(|p| p.starts_with('%') && p.ends_with(':'))
    {
        Some(p) => (p.to_string(), s[4..].to_string()),
        None => (String::new(), s.to_string()),
    };
    let ((ls, l), (os, o)) = (seg(l), seg(o));
    if ls != os {
        return false;
    }
    if let (Some(a), Some(b)) = (l.strip_prefix('$'), o.strip_prefix('$')) {
        let mask = if bits >= 64 {
            u64::MAX as i128
        } else {
            (1i128 << bits) - 1
        };
        return match (number(a), number(b)) {
            (Some(x), Some(y)) => x & mask == y & mask,
            (None, Some(_)) => true,
            _ => false,
        };
    }
    if let (Some(lp), Some(op)) = (l.find('('), o.find('(')) {
        let (ld, od) = (&l[..lp], &o[..op]);
        let disp = |d: &str| if d.is_empty() { Some(0) } else { number(d) };
        return l[lp..] == o[op..]
            && (l[lp..] == *"(%rip)" || disp(ld).is_none() || disp(ld) == disp(od));
    }
    // A branch or call target: llvm-objdump names its address.
    !l.starts_with(['%', '$']) && number(&l).is_none() && (o.contains('<') || number(&o).is_some())
}

/// Whether A64 listing operand `l` names what llvm-objdump's `o` does:
/// equal, the address llvm-objdump also names by a symbol, or a symbol the
/// listing names where the object holds a field a relocation (`reloc`) or
/// the layout fills.
fn same_operand_a64(l: &str, o: &str, reloc: bool) -> bool {
    let bare = o.split(" <").next().unwrap();
    if l == o || l == bare {
        return true;
    }
    let symbolic = |s: &str| {
        let s = s.trim_start_matches('[').trim_end_matches([']', '!']);
        let s = s.rsplit(", ").next().unwrap_or(s);
        s.starts_with(':')
            || (s.starts_with(|c: char| c.is_ascii_alphabetic() || c == '_' || c == '.')
                && !s.contains(' '))
    };
    if symbolic(l) && (o.contains(" <") || reloc || bare.trim_start_matches('#').starts_with("0x"))
    {
        return true;
    }
    // A zero offset a relocation fills, which llvm-objdump leaves out.
    match l.strip_prefix('[').and_then(|l| l.split_once(", ")) {
        Some((base, field)) if reloc && symbolic(field) => o == format!("[{base}]"),
        _ => false,
    }
}

/// Spellings GNU as reads as the instruction llvm-objdump names otherwise:
/// a template's mnemonic without the suffix its operands imply, a string
/// or port operation without its implicit operands.
fn alias(lm: &str, lops: &[String], om: &str, oops: &[String]) -> bool {
    let base = |m: &str| m.rsplit(' ').next().unwrap_or(m).to_string();
    let (lb, ob) = (base(lm), base(om));
    let string_op = ["stos", "lods", "movs", "scas", "cmps", "ins", "outs"]
        .iter()
        .any(|s| {
            lb.strip_prefix(s)
                .is_some_and(|r| ["b", "w", "l", "q"].contains(&r))
        });
    match lb.as_str() {
        "fwait" => ob == "wait" && lops == oops,
        "pushf" | "popf" => ob == format!("{lb}q") && lops == oops,
        "crc32" => ob.len() == 6 && ob.starts_with("crc32") && lops == oops,
        "invlpga" => ob == "invlpga",
        _ => string_op && lm == om && lops.is_empty(),
    }
}

/// The first difference between a listing and llvm-objdump's decoding of
/// the object, `None` when they agree.
fn compare(listing: &str, objdump: &str, a64: bool) -> Vec<String> {
    let (lrows, _) = parse_listing(listing);
    let (orows, relocs) = parse_objdump(objdump, a64);
    let mut issues = Vec::new();
    let mut after_data = false;
    for ((section, off), row) in &lrows {
        let at = format!("{section}+{off:#x}");
        if row.text.ends_with("# no text") {
            issues.push(format!("{at}: bytes no row describes"));
            continue;
        }
        // Data the unit placed in the text, which llvm-objdump decodes as
        // instructions that may run past the next instruction's start.
        if row.text.starts_with('.') {
            after_data = true;
            continue;
        }
        let Some(o) = orows.get(&(section.clone(), *off)) else {
            if !after_data {
                issues.push(format!("{at}: `{}` starts inside an instruction", row.text));
            }
            continue;
        };
        after_data = false;
        if o.bytes != row.bytes {
            issues.push(format!(
                "{at}: `{}` holds {:02x?}, the object {:02x?}",
                row.text, row.bytes, o.bytes
            ));
            continue;
        }
        let (lm, lops) = split_insn(&row.text);
        let (om, oops) = split_insn(&o.text);
        if a64 {
            let rel = relocs.get(&(section.clone(), *off));
            for sym in rel.into_iter().flatten() {
                if !row.text.contains(sym.as_str()) {
                    issues.push(format!("{at}: `{}` does not name `{sym}`", row.text));
                }
            }
            let same = lm == om
                && lops.len() == oops.len()
                && (lops.iter().zip(&oops)).all(|(l, o)| same_operand_a64(l, o, rel.is_some()));
            if !same {
                issues.push(format!("{at}: `{}`, llvm-objdump `{}`", row.text, o.text));
            }
            continue;
        }
        let bits = match om.chars().last() {
            Some('b') => 8,
            Some('w') => 16,
            Some('l') => 32,
            _ => 64,
        };
        let same = lm == om
            && lops.len() == oops.len()
            && lops
                .iter()
                .zip(&oops)
                .all(|(l, o)| same_operand(l, o, bits));
        if !same && !alias(&lm, &lops, &om, &oops) {
            issues.push(format!("{at}: `{}`, llvm-objdump `{}`", row.text, o.text));
        }
    }
    issues
}

/// An LLVM disassembler, or none.
fn llvm_objdump() -> Option<&'static str> {
    ["llvm-objdump", "objdump"].into_iter().find(|tool| {
        Command::new(tool)
            .arg("--version")
            .output()
            .is_ok_and(|o| String::from_utf8_lossy(&o.stdout).contains("LLVM"))
    })
}

/// The flags a snapshot fixture pins for `target`, `-c` aside.
fn fixture_flags(src: &str, target: &str) -> Vec<String> {
    let mut flags = Vec::new();
    for line in src.lines() {
        let Some(rest) = line.trim_start().strip_prefix("//") else {
            continue;
        };
        let rest = rest.trim_start();
        let Some(spec) = rest.strip_prefix("snapshot-flags") else {
            continue;
        };
        let (scope, list) = match spec.split_once(':') {
            Some((scope, list)) => (scope.trim(), list),
            None => continue,
        };
        if scope.is_empty() || scope == format!("({target})") {
            flags.extend(
                list.split_whitespace()
                    .filter(|f| *f != "-c")
                    .map(String::from),
            );
        }
    }
    flags
}

/// Compare the listing with the object for every snapshot fixture `-c`
/// compiles under `target` and `extra`; returns (compared, issues).
fn corpus(tool: &str, target: &str, extra: &[&str]) -> (usize, Vec<String>) {
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/c");
    let mut fixtures: Vec<PathBuf> = std::fs::read_dir(&root)
        .unwrap()
        .filter_map(|e| e.ok().map(|e| e.path()))
        .filter(|p| p.extension().is_some_and(|e| e == "c"))
        .collect();
    fixtures.sort();
    let dir = TempDir::new(&format!("badc-listing-{target}-{}", extra.len()));
    let next = std::sync::atomic::AtomicUsize::new(0);
    let results = std::sync::Mutex::new((0usize, Vec::new()));
    let workers = std::thread::available_parallelism().map_or(4, |n| n.get());
    std::thread::scope(|s| {
        for _ in 0..workers {
            s.spawn(|| {
                loop {
                    let i = next.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
                    let Some(fx) = fixtures.get(i) else {
                        break;
                    };
                    let src = std::fs::read_to_string(fx).unwrap_or_default();
                    let stem = dir.join(fx.file_stem().unwrap());
                    let (obj, asm) = (stem.with_extension("o"), stem.with_extension("s"));
                    let run = |mode: &str, out: &Path| {
                        badc()
                            .arg(format!("--target={target}"))
                            .arg("-q")
                            .args(extra)
                            .args(fixture_flags(&src, target))
                            .arg(fx)
                            .args([mode, "-o"])
                            .arg(out)
                            .output()
                            .unwrap()
                    };
                    // A fixture the target does not compile has no object.
                    if !run("-c", &obj).status.success() {
                        continue;
                    }
                    let name = fx.file_name().unwrap().to_string_lossy().into_owned();
                    let out = run("-S", &asm);
                    let issues = if out.status.success() {
                        let dis = Command::new(tool).arg("-dr").arg(&obj).output().unwrap();
                        compare(
                            &std::fs::read_to_string(&asm).unwrap(),
                            &String::from_utf8_lossy(&dis.stdout),
                            target.ends_with("arm64") || target.ends_with("aarch64"),
                        )
                    } else {
                        vec![format!(
                            "-S failed: {}",
                            String::from_utf8_lossy(&out.stderr)
                        )]
                    };
                    let mut r = results.lock().unwrap();
                    r.0 += 1;
                    r.1.extend(issues.into_iter().map(|i| format!("{name}: {i}")));
                }
            });
        }
    });
    results.into_inner().unwrap()
}

#[test]
fn every_listed_instruction_is_the_one_the_object_holds() {
    let Some(tool) = llvm_objdump() else {
        eprintln!("skipped: no LLVM objdump on PATH");
        return;
    };
    for (target, extra) in [
        ("linux-x64", &[][..]),
        ("linux-x64", &["-O"][..]),
        ("windows-x64", &[][..]),
        ("linux-aarch64", &[][..]),
        ("windows-arm64", &[][..]),
    ] {
        let (compared, issues) = corpus(tool, target, extra);
        assert!(
            compared > 1000,
            "{target} {extra:?}: {compared} fixtures compiled"
        );
        assert!(
            issues.is_empty(),
            "{target} {extra:?}: {} differences, first: {:#?}",
            issues.len(),
            &issues[..issues.len().min(20)]
        );
    }
}

/// The rows a listing holds, in order: (offset, length, text).
fn rows(listing: &str) -> Vec<(u64, usize, String)> {
    let (rows, _) = parse_listing(listing);
    rows.into_iter()
        .map(|((_, off), r)| (off, r.bytes.len(), r.text))
        .collect()
}

/// The rows tile the text: each starts where the previous ends, and every
/// byte is described.
fn assert_tiled(listing: &str) {
    let rows = rows(listing);
    for w in rows.windows(2) {
        assert_eq!(w[0].0 + w[0].1 as u64, w[1].0, "{:?} then {:?}", w[0], w[1]);
    }
    assert!(
        rows.iter().all(|r| !r.2.ends_with("# no text")),
        "{listing}"
    );
}

/// The offset of label `name`.
fn label(listing: &str, name: &str) -> u64 {
    let (_, labels) = parse_listing(listing);
    *labels
        .iter()
        .find(|(_, l)| *l == name)
        .unwrap_or_else(|| panic!("no label `{name}` in\n{listing}"))
        .0
}

/// The target of the branch row at `off`, from its displacement field.
fn branch_target(listing: &str, off: u64) -> u64 {
    let (rows, _) = parse_listing(listing);
    let row = rows.iter().find(|((_, o), _)| *o == off).unwrap().1;
    let disp = match row.bytes.as_slice() {
        [0xEB | 0x70..=0x7F, d] => i64::from(*d as i8),
        [0xE9 | 0xE8, d @ ..] | [0x0F, 0x80..=0x8F, d @ ..] => {
            i64::from(i32::from_le_bytes(d.try_into().unwrap()))
        }
        b => panic!("not a direct branch: {b:02x?}"),
    };
    (off as i64 + row.bytes.len() as i64 + disp) as u64
}

/// The branch rows of a listing: (offset, length, mnemonic, target text).
fn branches(listing: &str) -> Vec<(u64, usize, String, String)> {
    rows(listing)
        .into_iter()
        .filter_map(|(off, len, text)| {
            let (m, ops) = split_insn(&text);
            (m.starts_with('j') && !ops[0].starts_with('*')).then(|| (off, len, m, ops[0].clone()))
        })
        .collect()
}

/// A short loop takes rel8 branches and one over a long body keeps rel32:
/// relaxation re-emits the body over the truncated bytes, and each branch
/// names the label of the block its final displacement reaches.
#[test]
fn relaxed_and_long_branches_name_their_targets() {
    let dir = TempDir::new("badc-listing-relax");
    let src = "volatile int sink;\n\
        int f(int n) { int s = 0; for (int i = 0; i < n; i++) s += i; return s; }\n\
        int g(int n) { int s = 0; for (int i = 0; i < n; i++) {\n\
        #define T sink = i; sink = i + 1; sink = i + 2; sink = i + 3;\n\
        T T T T T T T T T T T T } return s; }\n";
    let l = listing(&dir, "relax", src, &["-O"]);
    assert_tiled(&l);
    let all = branches(&l);
    assert!(all.iter().any(|b| b.1 == 2), "no rel8 branch:\n{l}");
    assert!(all.iter().any(|b| b.1 >= 5), "no rel32 branch:\n{l}");
    for (off, _, m, target) in all {
        assert_eq!(
            label(&l, &target),
            branch_target(&l, off),
            "{m} {target}\n{l}"
        );
    }
}

/// The unsigned-to-double conversion skips forward over its large-value
/// path with branches whose displacements are patched once the path is
/// emitted; each reads as the label its patched field reaches.
#[test]
fn a_forward_branch_patched_in_place_names_its_target() {
    let dir = TempDir::new("badc-listing-patch");
    let l = listing(
        &dir,
        "patch",
        "double f(unsigned long x) { return x; }\n",
        &[],
    );
    assert_tiled(&l);
    let patched: Vec<_> = branches(&l)
        .into_iter()
        .filter(|b| b.3.starts_with(".Ltmp"))
        .collect();
    assert!(patched.len() >= 2, "{l}");
    for (off, _, m, target) in patched {
        assert_eq!(
            label(&l, &target),
            branch_target(&l, off),
            "{m} {target}\n{l}"
        );
    }
}

/// Functions aligned to 64 bytes are padded with one-byte `nop`s, each a
/// row of its own; a 32-byte-window padding is the multi-byte NOPs.
#[test]
fn alignment_fill_reads_as_no_ops() {
    let dir = TempDir::new("badc-listing-align");
    let src = "int a(int x) { return x + 1; }\nint b(int x) { return x * 3; }\n";
    let l = listing(&dir, "align", src, &["-falign-functions=64"]);
    assert_tiled(&l);
    assert_eq!(label(&l, "b") % 64, 0, "{l}");
    let fill: Vec<_> = rows(&l)
        .into_iter()
        .filter(|r| r.0 < label(&l, "b") && r.2 == "nop")
        .collect();
    assert!(!fill.is_empty() && fill.iter().all(|r| r.1 == 1), "{l}");
    let src = "int h(int *p, int n) { int s = 0; for (int i = 0; i < n; i++) { if (p[i] > 3) s += p[i]; else s -= 2; } return s; }\n";
    let l = listing(
        &dir,
        "window",
        src,
        &["-O", "-mbranches-within-32B-boundaries"],
    );
    assert_tiled(&l);
}

/// An extern object's address under `-fPIC` is a `lea` the writer turns
/// into a load from the GOT; the listing reads the load the object holds.
#[test]
fn the_writer_s_got_load_reads_as_a_load() {
    let dir = TempDir::new("badc-listing-got");
    let src = "extern int counter;\nint *f(void) { return &counter; }\n";
    let l = listing(&dir, "got", src, &["-fPIC"]);
    assert_tiled(&l);
    assert!(l.contains("movq counter@GOTPCREL(%rip), %rax"), "{l}");
}

/// `-S -o -` writes the listing to standard output, one per function with
/// its symbol as the label.
#[test]
fn dash_o_dash_writes_standard_output() {
    let dir = TempDir::new("badc-listing-stdout");
    let c = dir.join("s.c");
    std::fs::write(&c, "int sq(int x) { return x * x; }\n").unwrap();
    let out = badc()
        .args(["--target=linux-x64", "-q", "-O", "-S"])
        .arg(&c)
        .args(["-o", "-"])
        .output()
        .unwrap();
    assert!(out.status.success());
    let text = String::from_utf8_lossy(&out.stdout);
    assert!(text.contains("\nsq:\n") && text.contains("retq"), "{text}");
    assert!(!dir.join("-").exists());
}

/// The target of the A64 branch whose word `word` sits at `off`, from its
/// offset field; `None` for another instruction.
fn a64_branch_target(word: u32, off: u64) -> Option<u64> {
    let sext = |v: u32, bits: u32| i64::from(((v << (32 - bits)) as i32) >> (32 - bits));
    let words = match word {
        // b / bl, b.cond, cbz / cbnz, tbz / tbnz.
        w if w & 0x7C00_0000 == 0x1400_0000 => sext(w & 0x03FF_FFFF, 26),
        w if w & 0xFF00_0010 == 0x5400_0000 => sext((w >> 5) & 0x7_FFFF, 19),
        w if w & 0x7E00_0000 == 0x3400_0000 => sext((w >> 5) & 0x7_FFFF, 19),
        w if w & 0x7E00_0000 == 0x3600_0000 => sext((w >> 5) & 0x3FFF, 14),
        _ => return None,
    };
    Some((off as i64 + 4 * words) as u64)
}

/// Every A64 branch to a label within the text names the label its patched
/// field reaches, in a block's branch fixed up after layout, the `va_arg`
/// overflow test patched in place, an inline-asm branch to a local label
/// that replaces its placeholder word, and the binary128 helper's calls
/// and internal branches; no placeholder survives.
#[test]
fn a64_patched_branches_name_their_targets() {
    let dir = TempDir::new("badc-listing-a64-branch");
    let src = "#include <stdarg.h>\n\
        int h(int *p, int n) { int s = 0; for (int i = 0; i < n; i++) {\n\
        if (p[i] > 3) s += p[i]; else s -= 2; } return s; }\n\
        int va(int n, ...) { va_list ap; va_start(ap, n); int x = va_arg(ap, int);\n\
        va_end(ap); return x; }\n\
        int as(int x) { int r; __asm__(\"cbz %w1, 1f\\n\\tmov %w0, #1\\n\\tb 2f\\n1:\\n\\t\"\n\
        \"mov %w0, #2\\n2:\" : \"=r\"(r) : \"r\"(x)); return r; }\n\
        double nl(long double x) { return x; }\n";
    for (target, flags) in [("linux-aarch64", &[][..]), ("windows-arm64", &["-O"][..])] {
        let l = listing_for(target, &dir, "branch", src, flags);
        assert_tiled(&l);
        assert!(!l.contains("udf"), "{l}");
        let (rows, _) = parse_listing(&l);
        let mut named = 0;
        for ((_, off), row) in &rows {
            let word = u32::from_le_bytes(row.bytes[..].try_into().unwrap());
            let Some(want) = a64_branch_target(word, *off) else {
                continue;
            };
            let (m, ops) = split_insn(&row.text);
            let target = ops.last().unwrap();
            assert_eq!(label(&l, target), want, "{target}: `{m}` at {off:#x}\n{l}");
            named += 1;
        }
        assert!(named >= 4, "{target}: {named} branches\n{l}");
    }
}

/// Under `-fPIC` an extern object's address on A64 is an `adrp` and `add`
/// pair the writer turns into a load from the GOT; the listing reads the
/// load the object holds, its offset the GOT slot's.
#[test]
fn a64_the_writer_s_got_load_reads_as_a_load() {
    let dir = TempDir::new("badc-listing-a64-got");
    let src = "extern int counter;\nint *f(void) { return &counter; }\n";
    let l = listing_for("linux-aarch64", &dir, "got", src, &["-fPIC"]);
    assert_tiled(&l);
    assert!(l.contains("adrp x0, :got:counter"), "{l}");
    assert!(l.contains("ldr x0, [x0, :got_lo12:counter]"), "{l}");
}

/// The system instructions an inline-asm template's parser encodes itself
/// read as instructions, not as the words they encode to.
#[test]
fn a64_parser_encoded_template_instructions_read_as_instructions() {
    let dir = TempDir::new("badc-listing-a64-sys");
    let src = "void f(void) { __asm__ volatile(\"msr daifset, #2\\n\\tdmb ish\\n\\t\"\n\
        \"dsb #0\\n\\tisb\\n\\tbti c\\n\\tclrex #3\"); }\n";
    let l = listing_for("linux-aarch64", &dir, "sys", src, &[]);
    assert_tiled(&l);
    for text in [
        "msr DAIFSet, #0x2",
        "dmb ish",
        "ssbb",
        "isb",
        "bti c",
        "clrex #0x3",
    ] {
        assert!(l.contains(&format!(" {text}\n")), "{text}\n{l}");
    }
    assert!(!l.contains(".inst"), "{l}");
}

/// Functions aligned to 64 bytes on A64 are padded with 4-byte `nop`s, as
/// is an inline-asm `.balign`; an `.org` gap reads as the zeros it places.
#[test]
fn a64_alignment_fill_reads_as_no_ops() {
    let dir = TempDir::new("badc-listing-a64-align");
    let src = "int a(int x) { return x + 1; }\nint b(int x) { return x * 3; }\n";
    let l = listing_for(
        "linux-aarch64",
        &dir,
        "align",
        src,
        &["-falign-functions=64"],
    );
    assert_tiled(&l);
    assert_eq!(label(&l, "b") % 64, 0, "{l}");
    let fill: Vec<_> = rows(&l)
        .into_iter()
        .filter(|r| r.0 < label(&l, "b") && r.2 == "nop")
        .collect();
    assert!(!fill.is_empty() && fill.iter().all(|r| r.1 == 4), "{l}");
    let src = "int f(int x) { __asm__ volatile(\"add %w0, %w0, #1\\n\\t.balign 32\\n\\t\"\n\
        \"add %w0, %w0, #2\\n\\t.org . + 8\\n\\tnop\" : \"+r\"(x)); return x; }\n";
    let l = listing_for("linux-aarch64", &dir, "asm-align", src, &[]);
    assert_tiled(&l);
    let rows = rows(&l);
    let add2 = rows.iter().find(|r| r.2 == "add w0, w0, #0x2").expect(&l);
    assert_eq!(add2.0 % 32, 0, "{l}");
    assert!(rows.iter().any(|r| r.2 == ".zero 8" && r.1 == 8), "{l}");
}

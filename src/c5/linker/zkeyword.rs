//! GNU ld's `-z` keywords, each read as the request it makes of a link,
//! so every front end refuses or honors the same set.

use alloc::format;
use alloc::string::String;

/// A `-z` keyword; a pair's `bool` is whether the positive spelling
/// (`execstack`, `relro`, `now`, `text`, `defs`, ...) was given.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum ZKeyword {
    ExecStack(bool),
    Relro(bool),
    Now(bool),
    Text(bool),
    Defs(bool),
    Muldefs,
    PackRelativeRelocs(bool),
    SeparateCode(bool),
    MaxPageSize(u64),
    CommonPageSize(u64),
    /// A loader policy recorded in `DT_FLAGS_1`.
    LoaderFlag(&'static str),
}

const LOADER_FLAGS: [&str; 9] = [
    "nodefaultlib",
    "nodelete",
    "nodlopen",
    "nodump",
    "origin",
    "global",
    "initfirst",
    "interpose",
    "loadfltr",
];

impl ZKeyword {
    /// The keyword as the command line spells it, less a size's value.
    pub fn name(self) -> &'static str {
        let pick = |on: bool, yes: &'static str, no: &'static str| if on { yes } else { no };
        match self {
            ZKeyword::ExecStack(on) => pick(on, "execstack", "noexecstack"),
            ZKeyword::Relro(on) => pick(on, "relro", "norelro"),
            ZKeyword::Now(on) => pick(on, "now", "lazy"),
            ZKeyword::Text(on) => pick(on, "text", "notext"),
            ZKeyword::Defs(on) => pick(on, "defs", "undefs"),
            ZKeyword::Muldefs => "muldefs",
            ZKeyword::PackRelativeRelocs(on) => {
                pick(on, "pack-relative-relocs", "nopack-relative-relocs")
            }
            ZKeyword::SeparateCode(on) => pick(on, "separate-code", "noseparate-code"),
            ZKeyword::MaxPageSize(_) => "max-page-size",
            ZKeyword::CommonPageSize(_) => "common-page-size",
            ZKeyword::LoaderFlag(name) => name,
        }
    }
}

/// A page size as `-z max-page-size=` / `common-page-size=` take one:
/// decimal or `0x` hexadecimal, a power of two.
pub(crate) fn parse_page_size(body: &str) -> Option<u64> {
    let n = match body.strip_prefix("0x").or_else(|| body.strip_prefix("0X")) {
        Some(hex) => u64::from_str_radix(hex, 16).ok()?,
        None => body.parse::<u64>().ok()?,
    };
    n.is_power_of_two().then_some(n)
}

/// Read a `-z` keyword; the error names what is wrong with it.
pub fn parse_z_keyword(kw: &str) -> Result<ZKeyword, String> {
    let size = |prefix: &str, body: &str| {
        parse_page_size(body).ok_or_else(|| format!("-z {prefix} requires a power of two"))
    };
    Ok(match kw {
        "execstack" | "noexecstack" => ZKeyword::ExecStack(kw == "execstack"),
        "relro" | "norelro" => ZKeyword::Relro(kw == "relro"),
        "now" | "lazy" => ZKeyword::Now(kw == "now"),
        "text" | "notext" => ZKeyword::Text(kw == "text"),
        "defs" | "undefs" => ZKeyword::Defs(kw == "defs"),
        "muldefs" => ZKeyword::Muldefs,
        "pack-relative-relocs" | "nopack-relative-relocs" => {
            ZKeyword::PackRelativeRelocs(kw == "pack-relative-relocs")
        }
        "separate-code" | "noseparate-code" => ZKeyword::SeparateCode(kw == "separate-code"),
        _ if kw.starts_with("max-page-size=") => {
            ZKeyword::MaxPageSize(size("max-page-size", &kw["max-page-size=".len()..])?)
        }
        _ if kw.starts_with("common-page-size=") => {
            ZKeyword::CommonPageSize(size("common-page-size", &kw["common-page-size=".len()..])?)
        }
        _ => match LOADER_FLAGS.iter().find(|&&f| f == kw) {
            Some(&f) => ZKeyword::LoaderFlag(f),
            None => return Err(format!("unsupported -z keyword `{kw}`")),
        },
    })
}

/// Whether an image's stack is executable, and the warning bfd gives with
/// it. `requested` is the last of `-z execstack` / `noexecstack`; without
/// one, an input whose `.note.GNU-stack` is executable (`asked_by`, the
/// first) makes the stack executable. `warn` is the last of
/// `--warn-execstack` / `--no-warn-execstack`: the default reports an
/// input's request only.
pub fn resolve_exec_stack(
    requested: Option<bool>,
    asked_by: Option<&str>,
    warn: Option<bool>,
) -> (bool, Option<String>) {
    match (requested, asked_by) {
        (Some(on), _) => (
            on,
            (on && warn == Some(true)).then(|| {
                String::from(
                    "enabling an executable stack because of -z execstack command line option",
                )
            }),
        ),
        (None, Some(input)) => (
            true,
            (warn != Some(false)).then(|| {
                format!(
                    "{input}: requires executable stack (because the .note.GNU-stack section \
                     is executable)"
                )
            }),
        ),
        (None, None) => (false, None),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_keyword_reads_back_as_its_spelling() {
        for kw in [
            "execstack",
            "noexecstack",
            "relro",
            "norelro",
            "now",
            "lazy",
            "text",
            "notext",
            "defs",
            "undefs",
            "muldefs",
            "pack-relative-relocs",
            "nopack-relative-relocs",
            "separate-code",
            "noseparate-code",
            "nodelete",
        ] {
            assert_eq!(parse_z_keyword(kw).map(ZKeyword::name), Ok(kw));
        }
        assert_eq!(
            parse_z_keyword("max-page-size=0x10000"),
            Ok(ZKeyword::MaxPageSize(0x10000))
        );
        assert_eq!(
            parse_z_keyword("common-page-size=4096"),
            Ok(ZKeyword::CommonPageSize(4096))
        );
        assert_eq!(
            parse_z_keyword("max-page-size=3"),
            Err(String::from("-z max-page-size requires a power of two"))
        );
        assert_eq!(
            parse_z_keyword("nodefault"),
            Err(String::from("unsupported -z keyword `nodefault`"))
        );
    }

    /// bfd's rule: `-z execstack` / `noexecstack` decide; without one an
    /// input's executable note does, with a warning `--no-warn-execstack`
    /// withholds and `--warn-execstack` extends to `-z execstack`.
    #[test]
    fn the_stack_follows_the_keyword_then_the_inputs() {
        let x = Some("x.o");
        let by_input = "x.o: requires executable stack (because the .note.GNU-stack section \
                        is executable)";
        let by_option = "enabling an executable stack because of -z execstack command line option";
        for (requested, asked_by, warn, stack, warning) in [
            (None, None, None, false, None),
            (None, x, None, true, Some(by_input)),
            (None, x, Some(true), true, Some(by_input)),
            (None, x, Some(false), true, None),
            (Some(false), x, None, false, None),
            (Some(false), x, Some(true), false, None),
            (Some(true), None, None, true, None),
            (Some(true), x, None, true, None),
            (Some(true), None, Some(true), true, Some(by_option)),
            (Some(true), x, Some(false), true, None),
        ] {
            assert_eq!(
                resolve_exec_stack(requested, asked_by, warn),
                (stack, warning.map(String::from)),
                "{requested:?} {asked_by:?} {warn:?}"
            );
        }
    }
}

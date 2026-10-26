//! `__declspec(dllimport)` / `__attribute__((dllimport))`: the entity lives in
//! a DLL and the image reaches it through its import-address slot
//! `__imp_<name>`, as MSVC, mingw-w64 gcc and clang do. The rules on
//! redeclarations and misuse follow gcc's; a function definition marked
//! dllimport is an error, as under clang and MSVC (C2491).

use super::super::diag::Code;
use super::Compiler;
use crate::c5::codegen::BinaryFormat;
use alloc::format;

/// The declaration of a function or object that may carry `dllimport`.
#[derive(Clone, Copy, Default)]
pub(super) struct DllImportDecl {
    /// A function body or an object initializer follows.
    pub definition: bool,
    pub inline: bool,
    pub internal: bool,
}

impl Compiler {
    /// Whether the declaration being parsed asks for `dllimport` on a target
    /// with an import table. The attribute is reported ignored elsewhere.
    pub(super) fn dllimport_requested(&mut self) -> bool {
        if !self.pending.attrs.dllimport {
            return false;
        }
        if self.target.binary_format() == BinaryFormat::Pe {
            return true;
        }
        self.pending.attrs.dllimport = false;
        let text = format!(
            "`dllimport` attribute ignored: {} images have no import table",
            self.target.binary_format().name()
        );
        self.warn_at(Code::ATTRIBUTES, self.lex.line, text);
        false
    }

    /// `dllimport` on a typedef or a tag, which names no entity.
    pub(super) fn dllimport_on_type(&mut self, was_set: bool) {
        if self.pending.attrs.dllimport && !was_set {
            self.pending.attrs.dllimport = false;
            let text = "`dllimport` attribute ignored on a type".into();
            self.warn_at(Code::ATTRIBUTES, self.lex.line, text);
        }
    }

    /// Record this declaration's `dllimport` on `id_idx`. A redeclaration
    /// without the attribute drops it, and with it a later reference goes
    /// to the definition the image holds.
    pub(super) fn apply_dllimport(
        &mut self,
        id_idx: usize,
        d: DllImportDecl,
    ) -> Result<(), crate::c5::C5Error> {
        let marked = self.dllimport_requested();
        let name = self.symbols[id_idx].name.clone();
        let is_object = self.symbols[id_idx].class == crate::c5::token::Token::Glo as i64;
        let line = self.lex.line;
        if !marked {
            if self.symbols[id_idx].dllimport {
                self.symbols[id_idx].dllimport = false;
                let text = if self.symbols[id_idx].binding.was_referenced {
                    format!(
                        "`{name}` redeclared without dllimport attribute after being \
                         referenced with dll linkage"
                    )
                } else if d.inline && d.definition && !is_object {
                    return Ok(());
                } else {
                    format!(
                        "`{name}` redeclared without dllimport attribute: previous dllimport ignored"
                    )
                };
                self.warn_at(Code::ATTRIBUTES, line, text);
            }
            return Ok(());
        }
        if d.internal {
            let text = format!(
                "external linkage required for symbol `{name}` because of the `dllimport` attribute"
            );
            return Err(self.compile_err(Code::INVALID_DECLARATION, text));
        }
        let defined = d.definition || self.symbols[id_idx].defined_here;
        if defined && is_object {
            let text = format!("variable `{name}` definition is marked dllimport");
            return Err(self.compile_err(Code::INVALID_DECLARATION, text));
        }
        if d.inline {
            let text = format!("inline function `{name}` declared as dllimport: attribute ignored");
            self.warn_at(Code::ATTRIBUTES, line, text);
            return Ok(());
        }
        if defined {
            let text = format!("function `{name}` definition is marked dllimport");
            return Err(self.compile_err(Code::INVALID_DECLARATION, text));
        }
        if self.pending_exports.contains(&name) {
            let text =
                format!("`{name}` already declared with dllexport attribute: dllimport ignored");
            self.warn_at(Code::ATTRIBUTES, line, text);
            return Ok(());
        }
        self.symbols[id_idx].dllimport = true;
        Ok(())
    }
}

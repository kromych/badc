use super::builtins;
use super::text::{is_ident, is_ident_byte, skip_literal};
use super::{
    Binding, DylibSpec, PRAGMA_POP_WITHOUT_PUSH, PRAGMA_SYNTAX, Preprocessor, Site, Subsystem,
    UNKNOWN_PRAGMA, UNKNOWN_WARNING_OPTION,
};
use crate::c5::diag::{Code, Control, Level, Selector, rows};
use crate::c5::error::C5Error;
use alloc::borrow::Cow;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

impl Preprocessor {
    /// The intrinsic `#pragma intrinsic(name)` binds `name` to, or `None`
    /// when badc has none for this target or `-fno-builtin` has made the
    /// library spelling opaque.
    fn registered_intrinsic(&self, name: &str) -> Option<i64> {
        if self.no_builtin {
            return None;
        }
        builtins::intrinsic_id(name, self.target)
    }

    /// Process C99 6.10.9 `_Pragma` operators in already-macro-expanded
    /// text. `_Pragma ( string-literal )` is destringized (the optional
    /// `L` prefix and the surrounding quotes are removed, `\"` becomes
    /// `"`, and `\\` becomes `\`) and handled as the matching `#pragma`
    /// directive; the operator itself contributes no tokens. String and
    /// character literals in the surrounding text are copied through
    /// unchanged so a `_Pragma` substring inside one is not mistaken for
    /// the operator. A malformed operator is left in place for the lexer
    /// to diagnose.
    pub(super) fn apply_pragma_operators<'t>(
        &mut self,
        text: &'t str,
        site: Site<'_>,
    ) -> Result<Cow<'t, str>, C5Error> {
        if !text.contains("_Pragma") && !text.contains("__pragma") {
            return Ok(Cow::Borrowed(text));
        }
        let bytes = text.as_bytes();
        let mut out = String::with_capacity(text.len());
        let mut copied = 0usize;
        let mut i = 0usize;
        while i < bytes.len() {
            let c = bytes[i];
            if c == b'"' || c == b'\'' {
                i = skip_literal(bytes, i);
                continue;
            }
            let is_operator = c == b'_'
                && bytes[i..].starts_with(b"_Pragma")
                && (i == 0 || !is_ident_byte(bytes[i - 1]))
                && !bytes.get(i + 7).copied().is_some_and(is_ident_byte);
            if let Some((args, next)) = is_operator
                .then(|| parse_pragma_operator_args(text, i + 7))
                .flatten()
            {
                out.push_str(&text[copied..i]);
                self.dispatch_pragma_operator(&args, site, &mut out)?;
                i = next;
                copied = next;
                continue;
            }
            // MSVC `__pragma(tokens)`: same operator as C99 `_Pragma`, but
            // the operand is raw tokens rather than a string literal.
            let is_msvc_operator = c == b'_'
                && bytes[i..].starts_with(b"__pragma")
                && (i == 0 || !is_ident_byte(bytes[i - 1]))
                && !bytes.get(i + 8).copied().is_some_and(is_ident_byte);
            if let Some((args, next)) = is_msvc_operator
                .then(|| parse_msvc_pragma_args(text, i + 8))
                .flatten()
            {
                out.push_str(&text[copied..i]);
                self.dispatch_pragma_operator(&args, site, &mut out)?;
                i = next;
                copied = next;
                continue;
            }
            i += 1;
        }
        out.push_str(&text[copied..]);
        Ok(Cow::Owned(out))
    }

    /// Apply a single destringized `_Pragma` operand through the same
    /// dispatch as the `#pragma` directive (see the `Directive::Pragma`
    /// arm in `process_named`). The position-sensitive pragmas are
    /// re-emitted as inline `#pragma` directives on their own line so the
    /// lexer folds them in at this source position.
    pub(super) fn dispatch_pragma_operator(
        &mut self,
        args: &str,
        site: Site<'_>,
        out: &mut String,
    ) -> Result<(), C5Error> {
        match parse_pragma_directive(args) {
            PragmaDirective::Once => {
                self.pragma_once_files.insert(site.file.to_string());
            }
            PragmaDirective::Other => {
                if pragma_is_pack(args) || pragma_is_visibility(args) {
                    out.push_str("\n#pragma ");
                    out.push_str(args.trim());
                    out.push('\n');
                } else {
                    self.parse_pragma(args, site)?;
                }
            }
        }
        Ok(())
    }

    /// Dispatches c5's pragma surface (`dylib`, `binding`,
    /// `export`, `intrinsic`, `entrypoint`, `subsystem`). `pack`
    /// and `once` are handled elsewhere and bypass this function.
    /// Any other directive is accepted with a warning.
    pub(super) fn parse_pragma(&mut self, args: &str, site: Site<'_>) -> Result<(), C5Error> {
        let (line_no, filename) = (site.line, site.file);
        let args = args.trim();
        // MSVC and others allow whitespace between a pragma keyword and
        // its argument list -- `#pragma warning ( disable : N )`. Collapse
        // the gap before the first `(` so the keyword-paren dispatch below
        // matches regardless of spacing. The keyword is a bare identifier,
        // so any space there is the keyword/paren boundary.
        let normalized;
        let args: &str = match args.find('(') {
            Some(i) if args[..i].trim_end().len() != i => {
                normalized = format!("{}{}", args[..i].trim_end(), &args[i..]);
                &normalized
            }
            _ => args,
        };
        // Record the directives feeding the side outputs the compile
        // consumes, so a reused pass can replay them in order.
        if self.reuse.is_some()
            && [
                "dylib(",
                "binding(",
                "export(",
                "intrinsic(",
                "entrypoint(",
                "subsystem(",
            ]
            .iter()
            .any(|p| args.starts_with(p))
        {
            let rec = self.reuse.as_deref_mut().expect("checked above");
            rec.pragma_events
                .push((args.to_string(), line_no, filename.to_string()));
        }
        if let Some(inner) = args
            .strip_prefix("dylib(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_dylib(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("binding(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_binding(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("export(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_export(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("intrinsic(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_intrinsic(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("entrypoint(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_entrypoint(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("subsystem(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_subsystem(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("warning(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_warning(inner.trim(), site);
        }
        // Borland / Watcom `#pragma warn -<code>` form (`-rch`,
        // `-aus`, ...). Parsed for visibility into `warn_disabled`;
        // see `parse_pragma_warn` for the syntax.
        if let Some(inner) = args.strip_prefix("warn ") {
            return self.parse_pragma_warn(inner.trim(), site);
        }
        if args.trim() == "warn" {
            return self.parse_pragma_warn("", site);
        }
        // `pack` and `once` are consumed elsewhere. The `GCC` / `clang`
        // vendor pragmas (diagnostic selection, `optimize`, `target`,
        // `push_options`, `loop`, ...) and the C99 6.10.6 `STDC` pragmas
        // (FP_CONTRACT, FENV_ACCESS, CX_LIMITED_RANGE) are compiler hints
        // / evaluation modes c5 does not act on. Accept them silently
        // rather than warning on every occurrence; everything else falls
        // through to the unknown-pragma warning.
        let directive = args.split('(').next().unwrap_or(args).trim();
        let head = directive.split_whitespace().next().unwrap_or("");
        if matches!(head, "GCC" | "clang") && self.parse_pragma_diagnostic(args, site) {
            return Ok(());
        }
        if matches!(head, "pack" | "once" | "STDC" | "GCC" | "clang") {
            return Ok(());
        }
        self.warn(
            UNKNOWN_PRAGMA,
            site,
            format!("unknown `#pragma {directive}` -- ignored"),
        );
        Ok(())
    }

    /// `#pragma GCC diagnostic <action> ["-W<selector>"]` and the
    /// identical `clang` spelling. `false` when the pragma is a
    /// `GCC` / `clang` one this does not implement, which the caller
    /// accepts without a diagnostic.
    ///
    /// Actions: `push`, `pop`, and `ignored` / `warning` / `error`
    /// with a quoted `-W` selector naming a catalogue row or a group.
    fn parse_pragma_diagnostic(&mut self, args: &str, site: Site<'_>) -> bool {
        let mut tokens = args.split_whitespace();
        let Some(vendor) = tokens.next().filter(|t| matches!(*t, "GCC" | "clang")) else {
            return false;
        };
        if tokens.next() != Some("diagnostic") {
            return false;
        }
        let Some(action) = tokens.next() else {
            return false;
        };
        let level = match action {
            "push" => {
                self.push_diag_state();
                return true;
            }
            "pop" => {
                if !self.pop_diag_state(site.offset) {
                    self.warn(
                        PRAGMA_POP_WITHOUT_PUSH,
                        site,
                        format!("`#pragma {vendor} diagnostic pop` with no matching push"),
                    );
                }
                return true;
            }
            "ignored" => Level::Ignore,
            "warning" => Level::Warning,
            "error" => Level::Error,
            _ => return false,
        };
        let operand = tokens.next().unwrap_or("");
        if let Some(selector) = self.diag_selector(operand, vendor, action, site) {
            self.apply_diag_selector(selector, site.offset, Some(level));
        }
        true
    }

    /// The `"-W<selector>"` operand a diagnostic pragma takes. `None`
    /// when the operand is malformed or names nothing in the
    /// catalogue; both are reported and the pragma covers nothing.
    fn diag_selector(
        &mut self,
        operand: &str,
        vendor: &str,
        action: &str,
        site: Site<'_>,
    ) -> Option<Selector> {
        let name = operand
            .strip_prefix('"')
            .and_then(|s| s.strip_suffix('"'))
            .and_then(|s| s.strip_prefix("-W"));
        let Some(name) = name else {
            self.warn(
                PRAGMA_SYNTAX,
                site,
                format!(
                    "`#pragma {vendor} diagnostic {action}` expects a quoted option name, \
                     got `{operand}`"
                ),
            );
            return None;
        };
        let selector = Selector::parse(name);
        if selector.is_none() {
            self.warn(
                UNKNOWN_WARNING_OPTION,
                site,
                format!("unknown option `-W{name}` in `#pragma {vendor} diagnostic {action}`"),
            );
        }
        selector
    }

    /// Record what a selector asks for at `offset`. `None` restores
    /// the level the command line left. A group covers every row in
    /// it, so a group named by a pragma reaches the rows the option
    /// of the same name does.
    fn apply_diag_selector(&mut self, selector: Selector, offset: u32, level: Option<Level>) {
        self.diag_pragmas += 1;
        let control = self.sink.control_mut();
        let mut apply = |code: Code| match level {
            Some(level) => control.set_level(offset, code, level),
            None => control.reset(offset, code),
        };
        match selector {
            Selector::Diagnostic(code) => apply(code),
            Selector::Group(group) => {
                for row in rows().filter(|r| r.groups.contains(group)) {
                    apply(row.code);
                }
            }
        }
    }

    /// `#pragma GCC diagnostic push` / `#pragma warning(push)`.
    fn push_diag_state(&mut self) {
        self.diag_pragmas += 1;
        self.sink.control_mut().push();
    }

    /// `#pragma GCC diagnostic pop` / `#pragma warning(pop)`. `false`
    /// when no push was open.
    fn pop_diag_state(&mut self, offset: u32) -> bool {
        self.diag_pragmas += 1;
        self.sink.control_mut().pop(offset)
    }

    /// MSVC `#pragma warning(...)`:
    ///
    /// * `#pragma warning(disable : N1 N2 ...)` -- ignore those IDs
    /// * `#pragma warning(default : N1 ...)` -- back to the level the
    ///   command line left
    /// * `#pragma warning(enable : N1 ...)` -- report as a warning
    /// * `#pragma warning(error : N1 ...)` -- report as an error
    /// * `#pragma warning(once : N1 ...)` -- report the first one only
    /// * `#pragma warning(suppress : N1 ...)` -- ignore over the next
    ///   line
    /// * `#pragma warning(push)` / `#pragma warning(push, level)`
    /// * `#pragma warning(pop)`
    ///
    /// Each ID resolves through the catalogue's MSVC aliases; the
    /// overall level a `push, <level>` names has no badc counterpart
    /// and is accepted without effect. An ID no row lists is ignored:
    /// badc numbers its own diagnostics, and a source silencing an
    /// MSVC-only warning is asking for nothing badc reports.
    pub(super) fn parse_pragma_warning(
        &mut self,
        inner: &str,
        site: Site<'_>,
    ) -> Result<(), C5Error> {
        // `inner` is the text between the outer parens, e.g.
        // `disable : 4267 4100` or `push, 3` or `pop`.
        let inner = inner.trim();

        if inner == "push" {
            self.push_diag_state();
            return Ok(());
        }
        // `push, <level>`: the level names MSVC's overall verbosity,
        // which badc has no counterpart for.
        if let Some(level) = inner
            .strip_prefix("push")
            .and_then(|s| s.trim().strip_prefix(','))
        {
            let level = level.trim();
            if !level.chars().all(|c| c.is_ascii_digit()) {
                self.warn(
                    PRAGMA_SYNTAX,
                    site,
                    format!(
                        "`#pragma warning(push, <level>)` expects an integer level, \
                         got `{level}`"
                    ),
                );
                return Ok(());
            }
            self.push_diag_state();
            return Ok(());
        }
        if inner == "pop" {
            if !self.pop_diag_state(site.offset) {
                self.warn(
                    PRAGMA_POP_WITHOUT_PUSH,
                    site,
                    "`#pragma warning(pop)` with no matching push".to_string(),
                );
            }
            return Ok(());
        }

        // Action-with-IDs forms: `<action> : N1 N2 ...`. Multiple
        // comma-separated groups are allowed (`disable: 4 ; enable: 5`)
        // -- accept the semicolon-separated form too because
        // some sources use it.
        for clause in inner.split(';') {
            let clause = clause.trim();
            if clause.is_empty() {
                continue;
            }
            let Some((action, rest)) = clause.split_once(':') else {
                self.warn(
                    PRAGMA_SYNTAX,
                    site,
                    format!(
                        "unrecognised `#pragma warning({clause})` \
                         -- expected `disable : N` / `enable : N` / \
                         `default : N` / `error : N` / `once : N` / \
                         `suppress : N` / `push` / `pop`"
                    ),
                );
                continue;
            };
            let action = action.trim();
            let ids = rest;
            let mut ids_parsed: Vec<u32> = Vec::new();
            let mut had_bad_token = false;
            for tok in ids.split_whitespace() {
                match tok.parse::<u32>() {
                    Ok(n) => ids_parsed.push(n),
                    Err(_) => {
                        self.warn(
                            PRAGMA_SYNTAX,
                            site,
                            format!(
                                "`#pragma warning({action} : {tok})` \
                                 -- expected an integer warning ID"
                            ),
                        );
                        had_bad_token = true;
                    }
                }
            }
            if had_bad_token {
                continue;
            }
            let Some(action) = WarningAction::parse(action) else {
                self.warn(
                    PRAGMA_SYNTAX,
                    site,
                    format!(
                        "unrecognised `#pragma warning` action `{action}` \
                         -- expected `disable` / `enable` / `default` / \
                         `error` / `once` / `suppress`"
                    ),
                );
                continue;
            };
            for id in ids_parsed {
                let Some(code) = Code::from_msvc_number(id) else {
                    continue;
                };
                self.diag_pragmas += 1;
                let offset = site.offset;
                action.record(self.sink.control_mut(), offset, code);
            }
        }
        Ok(())
    }

    /// Borland / Watcom `#pragma warn` syntax:
    ///
    /// ```text
    /// #pragma warn -rch  /* disable "unreachable code" */
    /// #pragma warn -aus  /* disable "assigned value never used" */
    /// #pragma warn +ccc  /* re-enable "condition always true/false" */
    /// #pragma warn .rch  /* restore "rch" to its default state */
    /// ```
    ///
    /// Each token is `<sign><code>` where `<sign>` is one of
    /// `-` (disable), `+` (enable), `.` (default). Multiple
    /// tokens per directive are accepted.
    ///
    /// Like the MSVC variant, c5 doesn't filter on these codes;
    /// the parse exists so the source's intent is preserved on
    /// the `warn_disabled` set rather than dropped on the floor.
    /// Empty payloads and bad sign prefixes surface as warnings.
    pub(super) fn parse_pragma_warn(&mut self, inner: &str, site: Site<'_>) -> Result<(), C5Error> {
        let inner = inner.trim();
        if inner.is_empty() {
            self.warn(
                PRAGMA_SYNTAX,
                site,
                "`#pragma warn` with no payload -- expected \
                 `-<code>` / `+<code>` / `.<code>`"
                    .to_string(),
            );
            return Ok(());
        }
        for tok in inner.split_whitespace() {
            let (sign, code) = match tok.chars().next() {
                Some(c @ ('-' | '+' | '.')) => (c, &tok[1..]),
                _ => {
                    self.warn(
                        PRAGMA_SYNTAX,
                        site,
                        format!(
                            "`#pragma warn {tok}` -- expected a leading \
                             `-` / `+` / `.`"
                        ),
                    );
                    continue;
                }
            };
            if code.is_empty() {
                self.warn(
                    PRAGMA_SYNTAX,
                    site,
                    format!("`#pragma warn {tok}` -- code follows the sign"),
                );
                continue;
            }
            match sign {
                '-' => {
                    self.warn_disabled.insert(code.to_string());
                }
                '+' | '.' => {
                    self.warn_disabled.remove(code);
                }
                _ => unreachable!(),
            }
        }
        Ok(())
    }

    /// `#pragma entrypoint(<name>)` -- override the function the
    /// loader / `--jit` handoff jumps to. Default is `main`. The
    /// only constraint here is that `<name>` is a plain
    /// identifier; the compile pass validates the name resolves
    /// to a `Token::Fun` symbol after the parse pass, the same
    /// way `#pragma export(...)` is checked.
    ///
    /// Use cases:
    ///   * Win32 GUI apps -- `#pragma entrypoint(WinMain)` with
    ///     `#pragma subsystem(windows)` produces a PE the
    ///     Windows loader resolves to `WinMain` and the loader
    ///     skips the console-attach step.
    ///   * Custom `_start` shapes that bypass the libc CRT.
    ///   * DLL-style entry points where `DllMain` is the only
    ///     callable name (rare; today the `#pragma export`
    ///     surface covers DLLs).
    pub(super) fn parse_pragma_entrypoint(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let name = inner.trim();
        if !is_ident(name) {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                format!(
                    "`#pragma entrypoint({name})` -- name must be a \
                     plain identifier"
                ),
            ));
        }
        if let Some(prev) = &self.entrypoint
            && prev != name
        {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                format!(
                    "`#pragma entrypoint({name})` conflicts with prior \
                     `#pragma entrypoint({prev})`; pick one"
                ),
            ));
        }
        self.entrypoint = Some(name.to_string());
        Ok(())
    }

    /// `#pragma intrinsic("name")` -- tag the named callable
    /// symbol as a compiler-builtin intrinsic. At
    /// declaration time the frontend stamps the matching
    /// `Symbol::intrinsic` field with the [`Intrinsic`]
    /// discriminant from `op.rs`, and the call-site lowering
    /// emits an `Inst::Intrinsic` instead of a regular call +
    /// stack-cleanup sequence. The C11 7.17 atomic operations use the
    /// same registry but lower to load / store / read-modify-write at
    /// the call site rather than to an `Inst::Intrinsic`. The arg list is
    /// expected to be a quoted string so future intrinsics
    /// whose spellings collide with c5 keywords don't trip
    /// the identifier parser; the body uses `is_ident` to
    /// stay strict.
    pub(super) fn parse_pragma_intrinsic(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        // Two forms share this pragma. The quoted single-name form is c5's
        // own registration and stays strict so an unknown name is a typo,
        // not a silent no-op. MSVC's `#pragma intrinsic(name, name, ...)`
        // names bare identifiers as an inlining hint; c5 registers the ones
        // it lowers specially and, like MSVC's C4163, ignores the rest so
        // MSVC-shaped headers (winnt.h's `#pragma intrinsic(_rotl8)`) parse.
        for item in inner.split(',') {
            let item = item.trim();
            if item.is_empty() {
                continue;
            }
            if let Some(name) = item.strip_prefix('"').and_then(|s| s.strip_suffix('"')) {
                if !is_ident(name) {
                    return Err(C5Error::at(
                        Code::INVALID_PRAGMA,
                        filename,
                        line_no,
                        format!(
                            "`#pragma intrinsic(\"{name}\")` -- name must be a \
                             plain identifier"
                        ),
                    ));
                }
                if !builtins::is_builtin(name) {
                    return Err(C5Error::at(
                        Code::INVALID_PRAGMA,
                        filename,
                        line_no,
                        format!(
                            "`#pragma intrinsic(\"{name}\")` -- `{name}` is not a \
                             builtin badc provides"
                        ),
                    ));
                }
                if let Some(id) = self.registered_intrinsic(name) {
                    self.intrinsics.insert(name.to_string(), id);
                }
            } else if is_ident(item) {
                if let Some(id) = self.registered_intrinsic(item) {
                    self.intrinsics.insert(item.to_string(), id);
                }
            } else {
                return Err(C5Error::at(
                    Code::INVALID_PRAGMA,
                    filename,
                    line_no,
                    format!("`#pragma intrinsic({item})` -- expected an identifier"),
                ));
            }
        }
        Ok(())
    }

    /// `#pragma subsystem(<kind>)` -- select the PE
    /// optional-header `Subsystem` value. Accepted kinds:
    ///
    ///   * `console` / `cui` -- `IMAGE_SUBSYSTEM_WINDOWS_CUI` (3,
    ///     default). Entry signature `main(argc, argv)`.
    ///   * `windows` / `gui` -- `IMAGE_SUBSYSTEM_WINDOWS_GUI` (2).
    ///     Entry signature `WinMain(hinst, prev, cmdline, show)`.
    ///   * `native` / `nt` / `driver` -- `IMAGE_SUBSYSTEM_NATIVE`
    ///     (1). NT-native usermode and kernel drivers share this
    ///     subsystem byte; the entry signature is selected by the
    ///     source, not the pragma.
    ///   * `efi_application` -- `IMAGE_SUBSYSTEM_EFI_APPLICATION`
    ///     (10).
    ///   * `efi_boot_service_driver` --
    ///     `IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER` (11).
    ///   * `efi_runtime_driver` --
    ///     `IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER` (12).
    ///   * `efi_rom` -- `IMAGE_SUBSYSTEM_EFI_ROM` (13).
    ///
    /// Accepted on non-PE targets and ignored there; the PE
    /// writer is the only consumer.
    pub(super) fn parse_pragma_subsystem(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let kind = inner.trim();
        let parsed = match kind {
            "console" | "CUI" | "cui" => Subsystem::Console,
            "windows" | "GUI" | "gui" => Subsystem::Windows,
            "native" | "NATIVE" | "nt" | "NT" | "driver" | "DRIVER" => Subsystem::Native,
            "efi_application" | "efi-application" | "EFI_APPLICATION" => Subsystem::EfiApplication,
            "efi_boot_service_driver" | "efi-boot-service-driver" | "EFI_BOOT_SERVICE_DRIVER" => {
                Subsystem::EfiBootServiceDriver
            }
            "efi_runtime_driver" | "efi-runtime-driver" | "EFI_RUNTIME_DRIVER" => {
                Subsystem::EfiRuntimeDriver
            }
            "efi_rom" | "efi-rom" | "EFI_ROM" => Subsystem::EfiRom,
            _ => {
                return Err(C5Error::at(
                    Code::INVALID_PRAGMA,
                    filename,
                    line_no,
                    format!(
                        "`#pragma subsystem({kind})` -- expected one of \
                         `console`, `windows`, `native` (alias `driver`), \
                         `efi_application`, `efi_boot_service_driver`, \
                         `efi_runtime_driver`, `efi_rom`"
                    ),
                ));
            }
        };
        if let Some(prev) = self.subsystem
            && prev != parsed
        {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                format!(
                    "`#pragma subsystem({kind})` conflicts with prior \
                     `#pragma subsystem({prev:?})`; pick one"
                ),
            ));
        }
        self.subsystem = Some(parsed);
        Ok(())
    }

    /// `#pragma export(<name>)` -- mark a function defined in
    /// this translation unit as externally visible. The
    /// compiler validates the name resolves to a `Token::Fun`
    /// symbol after the parse pass, and the shared-object
    /// writers (`Target::*` plus the upcoming `OutputKind::SharedLibrary`
    /// shape) promote it to a real export entry.
    ///
    /// Plain identifiers only -- no quoted-name aliasing today
    /// (we'd need a syntax like `export(local_name, "real_name")`
    /// to follow the `#pragma binding(...)` shape, but the
    /// inverse direction; not needed for the initial cut).
    pub(super) fn parse_pragma_export(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let name = inner.trim();
        if !is_ident(name) {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                format!(
                    "`#pragma export({name})` -- name must be a \
                 plain identifier"
                ),
            ));
        }
        if self.export_names.insert(name.to_string()) {
            self.exports.push(name.to_string());
        }
        Ok(())
    }

    /// `#pragma dylib(name, "path")` -- introduce a logical dylib
    /// the codegen can attach bindings to. `name` is an
    /// identifier-style c5-side handle (`libc`, `kernel32`, ...);
    /// `path` is the actual loader-search-name or filesystem path.
    pub(super) fn parse_pragma_dylib(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let Some((name, path)) = inner.split_once(',') else {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                "`#pragma dylib(...)` expects two args \
                 (`name, \"path\"`)",
            ));
        };
        let name = name.trim();
        let path = path.trim().trim_matches('"');
        if name.is_empty() || path.is_empty() {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                "`#pragma dylib(...)` arg is empty",
            ));
        }
        if !is_ident(name) {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                format!(
                    "`#pragma dylib({name}, ...)` -- name must be a \
                 plain identifier"
                ),
            ));
        }
        // A declaration the unit's own source makes is a dependency;
        // one a bundled header makes only names a binding target.
        let own_header = self.include_stack.last().is_some_and(|&(_, own)| own);
        if let Some(&at) = self.dylib_index.get(name) {
            let existing = &mut self.dylibs[at];
            // Re-declaring an identical dylib is fine -- standard
            // headers (`<stdio.h>`, `<string.h>`) all bind to the
            // same `libc` / `msvcrt`, so a source that includes
            // both will hit this twice. Different paths are still
            // a hard error since they'd silently shadow each other.
            if existing.path != path {
                return Err(C5Error::at(
                    Code::INVALID_PRAGMA,
                    filename,
                    line_no,
                    format!(
                        "`#pragma dylib({name}, {path:?})` -- already declared with different path {:?}",
                        existing.path
                    ),
                ));
            }
            existing.own_header &= own_header;
            return Ok(());
        }
        self.dylib_index.insert(name.to_string(), self.dylibs.len());
        self.dylibs.push(DylibSpec {
            name: name.to_string(),
            path: path.to_string(),
            bindings: Vec::new(),
            own_header,
        });
        Ok(())
    }

    /// `#pragma binding(dylib::local_name, "real_symbol")` -- record
    /// `local_name`'s mapping to `real_symbol` inside the dylib named
    /// `dylib`. The dylib must already have been declared by a
    /// `#pragma dylib(...)`; the directives can otherwise appear in
    /// any order.
    pub(super) fn parse_pragma_binding(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let Some((qualified, real_symbol)) = inner.split_once(',') else {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                "`#pragma binding(...)` expects two args \
                 (`dylib::local_name, \"real_symbol\"`)",
            ));
        };
        let qualified = qualified.trim();
        // `#pragma binding(data <lib>::<name>, "sym")` marks a data
        // object; the leading `data ` keyword distinguishes it from the
        // function form.
        let (is_data, qualified) = match qualified.strip_prefix("data ") {
            Some(rest) => (true, rest.trim()),
            None => (false, qualified),
        };
        let real_symbol = real_symbol.trim().trim_matches('"');
        let Some((dylib_name, local_name)) = qualified.split_once("::") else {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                format!(
                    "`#pragma binding({qualified}, ...)` -- LHS must be \
                 `dylib_name::local_name`"
                ),
            ));
        };
        let dylib_name = dylib_name.trim();
        let local_name = local_name.trim();
        if dylib_name.is_empty() || local_name.is_empty() || real_symbol.is_empty() {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                "`#pragma binding(...)` arg is empty",
            ));
        }
        let Some(&at) = self.dylib_index.get(dylib_name) else {
            return Err(C5Error::at(
                Code::INVALID_PRAGMA,
                filename,
                line_no,
                format!(
                    "`#pragma binding({dylib_name}::...)` -- no `#pragma \
                 dylib({dylib_name}, ...)` declared"
                ),
            ));
        };
        self.dylibs[at].bindings.push(Binding {
            is_variadic: false,
            fixed_args: 0,
            return_type_tag: 0,
            returns_long_double: false,
            param_types: Vec::new(),
            local_name: local_name.to_string(),
            real_symbol: real_symbol.to_string(),
            is_data,
        });
        Ok(())
    }
}

/// Parse the `( token-string )` operand of an MSVC `__pragma` operator,
/// starting at `start` (just past the `__pragma` keyword). Returns the
/// content between the outer parens verbatim (trimmed) and the byte
/// index just past the closing `)`, or `None` when the parens are
/// missing or unbalanced. `__pragma(X)` is the MSVC analog of C99
/// `_Pragma("X")`: the operand is raw tokens rather than a string
/// literal, so no destringizing applies. Nested parens and string /
/// char literals are tracked so an inner `)` does not close the operand.
pub(super) fn parse_msvc_pragma_args(text: &str, start: usize) -> Option<(String, usize)> {
    let bytes = text.as_bytes();
    let mut i = start;
    while i < bytes.len() && bytes[i].is_ascii_whitespace() {
        i += 1;
    }
    if i >= bytes.len() || bytes[i] != b'(' {
        return None;
    }
    let inner_start = i + 1;
    let mut depth = 1usize;
    i = inner_start;
    while i < bytes.len() {
        match bytes[i] {
            b'"' | b'\'' => i = skip_literal(bytes, i),
            b'(' => {
                depth += 1;
                i += 1;
            }
            b')' => {
                depth -= 1;
                if depth == 0 {
                    return Some((text[inner_start..i].trim().to_string(), i + 1));
                }
                i += 1;
            }
            _ => i += 1,
        }
    }
    None
}

/// Parse the `( string-literal )` operand of a `_Pragma` operator,
/// starting at `start` (just past the `_Pragma` keyword). Returns the
/// destringized pragma text and the byte index just past the closing
/// `)`, or `None` when the operand is malformed (C99 6.10.9). The
/// optional `L` prefix is dropped, the surrounding quotes are removed,
/// and `\"` / `\\` collapse to `"` / `\`.
pub(super) fn parse_pragma_operator_args(text: &str, start: usize) -> Option<(String, usize)> {
    let bytes = text.as_bytes();
    let mut i = start;
    while i < bytes.len() && bytes[i].is_ascii_whitespace() {
        i += 1;
    }
    if i >= bytes.len() || bytes[i] != b'(' {
        return None;
    }
    i += 1;
    while i < bytes.len() && bytes[i].is_ascii_whitespace() {
        i += 1;
    }
    if i < bytes.len() && bytes[i] == b'L' {
        i += 1;
    }
    if i >= bytes.len() || bytes[i] != b'"' {
        return None;
    }
    i += 1;
    let mut content: Vec<u8> = Vec::new();
    loop {
        if i >= bytes.len() {
            return None;
        }
        match bytes[i] {
            b'"' => {
                i += 1;
                break;
            }
            b'\\' if i + 1 < bytes.len() && (bytes[i + 1] == b'"' || bytes[i + 1] == b'\\') => {
                content.push(bytes[i + 1]);
                i += 2;
            }
            other => {
                content.push(other);
                i += 1;
            }
        }
    }
    let content = String::from_utf8(content).ok()?;
    while i < bytes.len() && bytes[i].is_ascii_whitespace() {
        i += 1;
    }
    if i >= bytes.len() || bytes[i] != b')' {
        return None;
    }
    i += 1;
    Some((content, i))
}

/// Sub-classification of `#pragma` payloads. `dylib(...)` /
/// `binding(...)` go to [`Preprocessor::parse_pragma`] and live in
/// the dylib registry; `once` is structural (it tags the *current*
/// header) and lives on the preprocessor itself.
pub(super) enum PragmaDirective {
    Once,
    Other,
}

pub(super) fn parse_pragma_directive(args: &str) -> PragmaDirective {
    if args.trim() == "once" {
        PragmaDirective::Once
    } else {
        PragmaDirective::Other
    }
}

/// The actions MSVC's `#pragma warning(<action> : N ...)` takes, and
/// the level each records for the rows the numbers resolve to.
#[derive(Clone, Copy)]
enum WarningAction {
    Disable,
    Enable,
    Default,
    Error,
    Once,
    Suppress,
}

impl WarningAction {
    fn parse(name: &str) -> Option<WarningAction> {
        Some(match name {
            "disable" => WarningAction::Disable,
            "enable" => WarningAction::Enable,
            "default" => WarningAction::Default,
            "error" => WarningAction::Error,
            "once" => WarningAction::Once,
            "suppress" => WarningAction::Suppress,
            _ => return None,
        })
    }

    fn record(self, control: &mut Control, offset: u32, code: Code) {
        match self {
            WarningAction::Disable => control.set_level(offset, code, Level::Ignore),
            WarningAction::Enable => control.set_level(offset, code, Level::Warning),
            WarningAction::Default => control.reset(offset, code),
            WarningAction::Error => control.set_level(offset, code, Level::Error),
            WarningAction::Once => control.report_once(offset, code),
            WarningAction::Suppress => control.open_suppress(offset, code),
        }
    }
}

/// True when `args` is the head of a `pack(...)` pragma -- the
/// preprocessor passes those through verbatim so the lexer can
/// fold them into its `pack_stack` at the right source position
/// (see the `Directive::Pragma` arm in `process_named`).
pub(super) fn pragma_is_pack(args: &str) -> bool {
    let trimmed = args.trim_start();
    let Some(rest) = trimmed.strip_prefix("pack") else {
        return false;
    };
    // `pack(...)` -- the next non-whitespace byte must be `(`.
    // Anything else (`packfoo`, `pack_extra`) is a different
    // pragma the preprocessor still wants to silently swallow.
    rest.trim_start().starts_with('(')
}

/// True when `args` is the head of a `GCC visibility` pragma. Its extent
/// is a source range, so like `pack` the line goes through to the lexer
/// rather than being consumed here.
pub(super) fn pragma_is_visibility(args: &str) -> bool {
    let Some(rest) = args.trim_start().strip_prefix("GCC") else {
        return false;
    };
    let Some(rest) = rest.trim_start().strip_prefix("visibility") else {
        return false;
    };
    // A following `push` / `pop` must be a separate token, so anything
    // that continues the identifier (`visibility_mode`) is a different
    // pragma.
    !rest.starts_with(|c: char| c.is_ascii_alphanumeric() || c == '_')
}

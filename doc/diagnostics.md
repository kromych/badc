# Diagnostics

Every warning and error badc prints ends with its code and its name:

```console
unit.c:3: warning: unused variable `x` [B2001] [-Wunused-variable]
unit.c:8: error: bad expression: got `;` (in f) [B2020] [syntax]
```

A code and a name stay with the diagnostic they were given, and a code is
never reused. Options and pragmas select a diagnostic by either one. The
[catalogue](#catalogue) at the end of this page lists every diagnostic.

## Contents

* [Selectors](#selectors)
* [Options](#options)
* [Pragmas](#pragmas)
* [Levels and classes](#levels-and-classes)
* [Catalogue](#catalogue)

## Selectors

A selector names one diagnostic or one group:

| form | example |
|---|---|
| name | `unused-variable` |
| code | `B2001` |
| alias, including an MSVC warning number | `unused`, `C4101` |
| group | `all`, `extra`, `pedantic` |

`badc --explain <selector>` prints one row of the catalogue with its aliases.
`badc --list-diagnostics` prints the whole catalogue.

## Options

| option | effect |
|---|---|
| `-W<sel>` | turn the diagnostic on; one that is an error by default stays an error |
| `-Wno-<sel>` | do not report it |
| `-Werror=<sel>` | report it as an error, and turn it on if it is off |
| `-Wno-error=<sel>` | report it as a warning again |
| `-Werror` / `-Wno-error` | report every warning as an error / stop doing so |
| `-w` | report no warnings |
| `-Wall`, `-Wextra`, `-Wpedantic` | turn on the group of that name |
| `-pedantic`, `-pedantic-errors` | `-Wpedantic`, `-Werror=pedantic` |
| `-fpermissive` | report `int-conversion`, `incompatible-pointer-types`, `implicit-int` and `return-mismatch` as warnings |

A warning name of another compiler that badc does not implement is accepted.
Turning one on reports B7012 and has no other effect. Any other unknown name is
an error, except after `-Wno-`, which accepts any name.

## Pragmas

These pragmas take effect from their position in the source:

* `#pragma GCC diagnostic ignored "-W<sel>"`, and the same with `warning` or
  `error`; `#pragma GCC diagnostic push` and `pop`.
* `#pragma clang diagnostic` in the same forms.
* MSVC's `#pragma warning(disable: <n>)`, with `error`, `default`, `once` or
  `suppress` in place of `disable`, and `#pragma warning(push)` and `(pop)`.
  The number `<n>` selects the diagnostic whose alias is `C<n>`.

A pragma that names an unknown selector reports B7002, or B7012 for another
compiler's warning badc does not implement, and changes nothing else.

## Levels and classes

The `default` column gives the level with no option or pragma: `error`,
`warning` or `ignore`. The `class` column says whether that level can change:

| class | behavior |
|---|---|
| controllable | options and pragmas set the level |
| hard | always an error, because compilation cannot continue past it; an option that names it is accepted and has no effect |
| note | advisory; `-w` and `-Wno-<name>` turn it off, and nothing raises it |

A row marked `(retired)` is no longer reported. Its code stays reserved, and
an option or pragma that names it is accepted and has no effect.

Default levels and groups may change between releases. Codes and names do
not.

## Catalogue

`scripts/diagnostics_doc.py` generates this table from
`tests/diagnostics/catalog.txt`. A unit test checks that file against the
output of `badc --list-diagnostics`.

| code | name | default | class | groups | description |
|------|------|---------|-------|--------|-------------|
| B1001 | `unknown-directive (retired)` | warning | controllable | default | a `#` line naming no directive badc implements; the line is dropped |
| B1002 | `#warnings` | warning | controllable | default | a `#warning` directive reached in an active conditional block |
| B1003 | `malformed-directive` | warning | controllable | default | a macro-expanded `#line` operand that does not reparse |
| B1004 | `unknown-pragmas` | warning | controllable | default,all | a `#pragma` badc does not implement; the directive is ignored |
| B1005 | `pragma-syntax` | warning | controllable | default | a diagnostic pragma badc implements whose operand is malformed |
| B1006 | `pragma-pop-without-push` | warning | controllable | default | a diagnostic-pragma pop or a `pop_macro` with no matching push |
| B1007 | `ignored-pragma-intrinsic` | warning | controllable | default | a `#pragma intrinsic` naming a function badc has no intrinsic for; the name stays an ordinary call |
| B1008 | `date-time` | ignore | controllable | - | a use of `__DATE__` or `__TIME__`, whose expansion changes from one build to the next |
| B1009 | `undef` | ignore | controllable | - | an identifier that names no macro evaluated in a `#if` or `#elif` expression, where it is 0 |
| B1010 | `directive` | error | hard | - | a directive name the preprocessor does not implement, a directive whose operand it cannot process, a directive preprocessed input does not take, or a conditional directive with no `#if` to match |
| B1011 | `invalid-pragma` | error | hard | - | a pragma badc implements whose operand cannot be applied |
| B1012 | `invalid-token` | error | hard | - | a character sequence that forms no token: a malformed constant, escape sequence or universal character name |
| B1013 | `error-directive` | error | hard | - | a `#error` directive reached in an active conditional block |
| B1014 | `macro` | error | hard | - | a macro definition or invocation C99 6.10.3 rejects: an argument count the definition does not take, `##` at either end of a replacement list |
| B1015 | `macro-redefined` | warning | controllable | default | a macro redefined with another kind, parameter list or replacement list (C99 6.10.3p2) outside a system header; the new definition replaces the old |
| B1016 | `expansion-to-defined` | ignore | controllable | extra,pedantic | a `defined` in an `#if` expression that a macro replacement produced (C99 6.10.1p4 leaves it undefined), outside a system header; its operand is taken as written |
| B2001 | `unused-variable` | ignore | controllable | all | a variable declared and never used |
| B2002 | `unused-parameter` | ignore | controllable | extra | a parameter never used in the function body |
| B2003 | `unused-but-set-variable` | ignore | controllable | all | a variable that is only ever assigned to |
| B2004 | `unused-function` | ignore | controllable | all | a function with internal linkage that is defined and never referenced |
| B2005 | `implicit-function-declaration (retired)` | warning | controllable | default | a function used before a prototype declares it, so its return type is `int` |
| B2006 | `undefined-function` | warning | controllable | default | an initializer names a `static` function this unit declares and never defines |
| B2007 | `redeclaration-mismatch` | warning | controllable | default | a function redeclaration incompatible under C99 that GNU C accepts: an implicit `int` body for a `void` declaration, an old-style definition matching its prototype only before promotion |
| B2008 | `attributes` | warning | controllable | default | an attribute the declaration cannot carry, so it is ignored |
| B2009 | `ignored-asm-label` | warning | controllable | default | an assembler name on a declaration that has no symbol to rename |
| B2010 | `shadowed-binding` | warning | controllable | default | a `#pragma binding` for a name an earlier binding already claimed |
| B2011 | `implicit-int` | error | controllable | default | a declaration or type name with no type specifier, whose type defaults to `int` |
| B2012 | `inline-asm` | warning | controllable | default | an `asm` statement that lists the stack pointer as clobbered or writes it through an output, where GNU C requires it to hold its value |
| B2013 | `visibility` | warning | controllable | default | a tag declared in a parameter list, whose scope ends with the declaration or definition |
| B2014 | `strict-prototypes` | ignore | controllable | - | a function declarator whose empty or identifier list declares no prototype, outside a cast and a definition an earlier prototype covers |
| B2015 | `missing-prototypes` | ignore | controllable | - | an external function definition, neither `inline` nor `main`, that no file-scope declaration with a prototype precedes |
| B2016 | `missing-declarations` | ignore | controllable | - | an external function definition, neither `inline` nor `main`, that no file-scope declaration precedes |
| B2017 | `implicit-fallthrough=5` | ignore | controllable | - | a statement completing normally into the `case` or `default` label after it, which no `fallthrough` attribute statement annotates |
| B2018 | `vla-larger-than` | ignore | controllable | - | under optimization, a variable-length array whose size the size expression does not bound by the `-Wvla-larger-than=` byte count |
| B2019 | `main` | warning | controllable | default | a hosted unit's file-scope declaration of `main` with `static`, which makes it no program entry point |
| B2020 | `syntax` | error | hard | - | a token the grammar does not admit at its position; the parser has no resynchronisation point |
| B2021 | `invalid-declaration` | error | hard | - | a declaration a C99 constraint rejects: a redefinition, conflicting types, an incomplete object, a bit-field width or an alignment out of range |
| B2022 | `undeclared-identifier` | error | hard | - | a name no declaration in scope introduces |
| B2023 | `static-assert` | error | hard | - | a static assertion whose controlling expression is zero |
| B2024 | `incomplete-element-type` | error | hard | - | an array whose element type is incomplete: an array of unknown size, `void`, or a tag declared without its body |
| B3001 | `int-conversion` | error | controllable | default | an integer and a pointer exchanged with no cast |
| B3002 | `incompatible-struct-types` | warning | controllable | default | an aggregate or enumerated type used where a different one is expected |
| B3003 | `return-type` | ignore | controllable | all | control reaches the end of a value-returning function |
| B3004 | `too-few-arguments` | warning | controllable | default | a call passing fewer arguments than an old-style definition declares |
| B3005 | `too-many-arguments` | warning | controllable | default | a call passing more arguments than an old-style definition declares |
| B3006 | `long-double-abi (retired)` | warning | controllable | default | a `long double` argument passed in a format this target's ABI does not use |
| B3007 | `dead-store` | ignore | controllable | - | a value assigned to a local and replaced before any read |
| B3008 | `switch-outside-range` | warning | controllable | default | a `case` label whose value lies outside the range of the controlling expression's type before promotion |
| B3009 | `empty-case-range` | warning | controllable | default | a GNU case range `lo ... hi` whose low bound exceeds its high bound in the promoted type of the controlling expression; the label is dropped |
| B3010 | `constant-conversion` | warning | controllable | default | an integer constant converted implicitly to an integer type or a bit-field whose width holds the value at neither signedness |
| B3011 | `incompatible-pointer-types-discards-qualifiers` | warning | controllable | default | a pointer assigned, initialized, passed or returned as a pointer to a type that differs from the one it points to only in the qualifiers of a type further down: `T **` as `const T **` |
| B3012 | `switch-bool` | warning | controllable | default | a `switch` on a boolean value with a case label outside 0 and 1, or with a `default` beside labels covering both |
| B3013 | `excess-initializers` | warning | controllable | default | a string literal longer than the array, member or row it initializes, a terminator aside; the characters past the bound are dropped |
| B3015 | `cast-function-type` | ignore | controllable | extra | a cast between pointers to function types whose returns or common leading parameters differ other than as pointers or as integers of one precision |
| B3016 | `designated-init` | warning | controllable | default | an initializer element with no designator for a member of a struct declared `designated_init` |
| B3017 | `enum-conversion` | ignore | controllable | extra | a value of one enumerated type, or a constant of one, assigned, initialized, passed or returned as another enumerated type |
| B3014 | `builtin-argument-range` | warning | controllable | default | an integer constant operand of a builtin outside the values the builtin takes; 0 is used in its place |
| B3020 | `invalid-operands` | error | hard | - | an operator applied to operands its constraints reject, or a non-lvalue where an lvalue is required |
| B3021 | `constant-expression` | error | hard | - | an expression that must be constant and is not, or one the compiler cannot evaluate at translation time |
| B3022 | `invalid-initializer` | error | hard | - | an initializer C99 6.7.8 rejects: a mismatched brace form, a designator naming nothing, an index out of range |
| B3023 | `invalid-arguments` | error | hard | - | a call with arguments its callee does not take: a count other than a prototype's, or a builtin's or intrinsic's operand it rejects |
| B3024 | `invalid-statement` | error | hard | - | a statement outside the construct it needs: `break` outside a loop, `case` outside a switch, a `goto` to no label, a jump into a statement expression or into the scope of a variably modified or cleanup object |
| B3025 | `incompatible-types` | error | hard | - | a value of a type no implicit conversion takes to the type required: an aggregate assigned, passed or returned as another |
| B3026 | `return-mismatch` | error | controllable | default | a `return` with a value in a function returning `void`, or with none in a function returning a value |
| B3027 | `void-value` | error | hard | - | the value of a `void` expression used: as an operand, an argument, an initializer, an assigned or returned value, or a controlling expression |
| B3028 | `controlling-expression` | error | hard | - | a controlling expression of a type its statement does not take: a non-scalar `if`, `while`, `do` or `for` condition, a non-integer `switch` expression |
| B3029 | `incompatible-pointer-types` | error | controllable | default | a pointer assigned, initialized, passed or returned as a pointer to a type incompatible with the type it points to, neither side a pointer to `void` |
| B3030 | `pointer-difference` | error | hard | - | a subtraction of two pointers that do not point to qualified or unqualified versions of compatible types |
| B3031 | `discarded-qualifiers` | warning | controllable | default | a pointer assigned, initialized, passed or returned as a pointer to a type without a `const` or `volatile` the original pointed-to type has |
| B3032 | `pointer-sign` | warning | controllable | default | a pointer assigned, initialized, passed or returned as a pointer to an integer type that differs from the one it points to only in signedness |
| B3033 | `modifiable-lvalue` | error | hard | - | an assignment, compound assignment, `++` or `--` whose operand is const-qualified, or is a structure or union with a const member |
| B3034 | `varargs` | warning | controllable | default | a `va_start` whose second operand is not the last named parameter, or is one declared `register` or of a type the default argument promotions change; a `va_arg` of such a type (C99 7.15.1) |
| B4001 | `unsupported` | error | hard | - | a well-formed construct badc does not implement |
| B4002 | `limit` | error | hard | - | a translation limit badc imposes: nesting depth, include depth, alignment |
| B4003 | `inline` | ignore | controllable | - | a function the source declared `inline` that the optimizer left out of line |
| B4004 | `always-inline` | warning | controllable | default | a function marked `always_inline` or `__forceinline` that the optimizer left out of line |
| B4005 | `frame-larger-than` | warning | controllable | default | a function whose stack frame exceeds the `-Wframe-larger-than=` bound; saved registers and the frame record count, `alloca` and variable-length arrays do not |
| B4006 | `general-regs-only` | error | hard | - | a floating-point value in a function compiled under `-mno-sse` or `-mgeneral-regs-only`, which withhold the floating-point and SIMD registers it needs |
| B5001 | `asm-syntax` | error | hard | - | an `asm` statement whose operand list, constraints or template does not parse |
| B5002 | `assembler` | error | hard | - | an instruction or directive the assembler cannot parse or encode for the target |
| B6001 | `orphan-section` | warning | controllable | default | an input section no script rule names, placed by the linker's own rule |
| B6002 | `missing-entry` | warning | controllable | default | no input defines the entry symbol, so the image enters at the first text address |
| B6003 | `merged-section-access` | warning | controllable | default | a relocation reaches past the end of the merged section it names |
| B6004 | `execstack` | warning | controllable | default | the image's stack is executable because an input's `.note.GNU-stack` asks for it, or because `-z execstack` does under `--warn-execstack` |
| B6005 | `rwx-segment` | warning | controllable | default | a segment the image loads is readable, writable and executable, or its thread-local segment executable |
| B6006 | `local-import` | warning | controllable | default | a reference to the import-address slot `__imp_X` of a symbol `X` the link defines, which resolves to the definition |
| B6007 | `text-relocation` | warning | controllable | default | a dynamic relocation writes into a read-only segment, which the loader makes writable to apply it (`DT_TEXTREL`) |
| B6008 | `undefined-lookup` | warning | controllable | default | a reference no input defines, which a Mach-O image looks up in the flat namespace at load time under `-undefined warning` |
| B6010 | `undefined-symbol` | error | hard | - | a reference no input object, archive or shared library defines |
| B6011 | `duplicate-symbol` | error | hard | - | more than one input defines the same symbol |
| B6012 | `relocation` | error | hard | - | a relocation the linker cannot apply, or a value its field cannot hold |
| B6013 | `linker-script` | error | hard | - | a linker script badc cannot parse, or a construct it does not implement |
| B6014 | `malformed-input` | error | hard | - | an input object, archive or shared library the reader cannot make sense of |
| B6015 | `object-format` | error | hard | - | a construct the selected object format cannot express |
| B6016 | `link` | error | hard | - | a link-time failure with no more specific row |
| B7001 | `unknown-argument` | error | hard | - | command-line option or operand the driver does not implement |
| B7002 | `unknown-warning-option` | warning | controllable | default | a diagnostic pragma names a selector that is neither in the catalogue nor a gcc or clang warning |
| B7003 | `unused-command-line-argument` | ignore | controllable | all,extra | an accepted option that selects nothing in the mode the command line picked |
| B7004 | `no-input-files` | error | hard | - | the command line names nothing to compile, assemble or link |
| B7005 | `input-unreadable` | error | hard | - | an input file the driver cannot read |
| B7006 | `output-unwritable` | error | hard | - | the driver cannot write the file it was asked to produce |
| B7007 | `unsupported-option` | error | controllable | default | an option badc parses but declines in the mode the command line picked |
| B7008 | `link-pragma-ignored` | warning | controllable | default | a link request from a source pragma that an object file does not carry |
| B7009 | `cross-target-output` | warning | note | - | the image is for another host and will not run where it was built |
| B7010 | `freestanding-import` | warning | controllable | default | a freestanding image binds a shared-library symbol, so it runs through the dynamic loader |
| B7011 | `dwarf-output` | warning | controllable | default | a `-gdwarf` option asks for a DWARF version or format the emitter does not produce |
| B7012 | `unimplemented-warning-option` | warning | controllable | default | a diagnostic pragma or a `-W` option turns on a gcc or clang warning that badc does not implement, so it has no effect |
| B9001 | `internal-error` | error | hard | - | an invariant inside badc did not hold |

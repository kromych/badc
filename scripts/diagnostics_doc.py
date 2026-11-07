#!/usr/bin/env python3
"""Write doc/diagnostics.md from the catalogue golden.

`tests/diagnostics/catalog.txt` is what `badc --list-diagnostics`
prints, pinned by a unit test; this turns the same rows into the
Markdown reference so the two never disagree. `--check` fails when the
document is stale instead of rewriting it.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
GOLDEN = ROOT / "tests" / "diagnostics" / "catalog.txt"
DOC = ROOT / "doc" / "diagnostics.md"

HEAD = """# Diagnostics

Every warning and error badc prints ends with its code and its name:

```console
unit.c:3: warning: unused variable `x` [B2001] [-Wunused-variable]
unit.c:8: error: bad expression: got `;` (in f) [B2020] [syntax]
```

A code and a name stay with the diagnostic they were given, and a code is
never reused. Options and pragmas select a diagnostic by either one. The
[catalogue](#catalogue) at the end of this page lists every diagnostic.

## Contents

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
| note | advisory; its level does not change |

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
"""

# The heading a list of links to the `##` headings after it fills.
CONTENTS = "## Contents\n"


def slug(heading: str) -> str:
    """GitHub's anchor for a heading: lowercase, characters other than
    letters, digits, spaces, `-` and `_` dropped, spaces as `-`."""
    return re.sub(r"[^\w\- ]", "", heading.lower()).replace(" ", "-")


def with_contents(head: str) -> str:
    intro, rest = head.split(CONTENTS, 1)
    links = "".join(f"* [{h}](#{slug(h)})\n" for h in re.findall(r"^## (.+)$", rest, re.M))
    return f"{intro}{CONTENTS}\n{links}{rest}"


def rows() -> list[list[str]]:
    lines = GOLDEN.read_text().splitlines()
    out = []
    for line in lines[1:]:
        cells = re.split(r"\s{2,}", line.rstrip(), maxsplit=6)
        if len(cells) != 7:
            raise SystemExit(f"{GOLDEN}: unparsed row: {line!r}")
        out.append(cells)
    return out


def render() -> str:
    body = []
    for code, name, default, cls, groups, status, desc in rows():
        if status == "retired":
            name = f"{name} (retired)"
        desc = desc.replace("|", "\\|")
        body.append(f"| {code} | `{name}` | {default} | {cls} | {groups} | {desc} |")
    return with_contents(HEAD) + "\n".join(body) + "\n"


def main() -> int:
    text = render()
    if "--check" in sys.argv[1:]:
        if not DOC.exists() or DOC.read_text() != text:
            print(f"{DOC} is stale; run scripts/diagnostics_doc.py", file=sys.stderr)
            return 1
        return 0
    DOC.write_text(text)
    return 0


if __name__ == "__main__":
    sys.exit(main())

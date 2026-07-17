#!/usr/bin/env python3
"""cc-shaped driver over badc for the edk2 BaseTools C utilities.

BaseTools' makefiles invoke `$(CC)` with the usual gcc surface; this
translates that onto badc: warning/codegen tuning flags badc has no
use for are dropped, `-O<n>` folds to `-O`, and everything else
(includes, defines, inputs, `-l`/`-L`, `-o`) passes through. `--gnu`
is always on -- the Pccts-generated parser sources use pre-prototype
call forms. The dependency flag `-MD` is dropped; the makefiles
tolerate absent `.d` files.
"""

import os
import shlex
import subprocess
import sys


def expand_response_files(argv: list[str]) -> list[str]:
    """Expand gcc `@file` response-file arguments in place. edk2 switches to
    a response file once a compile command line grows long (the OpenSSL
    sources carry a large `-I` / `-D` set), passing `$(CC) @cc_resp.txt`.
    Tokens are shell-quoted (`shlex`), so a flag like `"-DEFIAPI=..."` stays
    one argument. Recurse so a nested `@file` expands too; an unreadable
    `@file` is left as a literal argument, matching gcc."""
    out: list[str] = []
    for a in argv:
        if a.startswith("@"):
            try:
                with open(a[1:]) as f:
                    out.extend(expand_response_files(shlex.split(f.read())))
                continue
            except OSError:
                pass
        out.append(a)
    return out


def main() -> int:
    badc = os.environ.get("BADC", "badc")
    out: list[str] = ["--gnu"]
    args = expand_response_files(sys.argv[1:])
    i = 0
    while i < len(args):
        a = args[i]
        if a in ("-MD", "-MMD", "-MP", "-nostdlib", "-pipe", "-s"):
            pass
        elif a in ("-MF", "-MT", "-MQ"):
            # gcc dependency-file flags: drop the flag and its argument.
            i += 1
        elif a.startswith(("-W", "-f", "-m", "-std")):
            pass
        elif a == "-Os" or (a.startswith("-O") and len(a) <= 3):
            if a != "-O0":
                out.append("-O")
        elif a in ("-I", "-D", "-U", "-o", "-L", "-l", "-include"):
            out.append(a)
            i += 1
            out.append(args[i])
        else:
            out.append(a)
        i += 1
    cmd = [badc] + out
    if os.environ.get("BADC_CC_VERBOSE"):
        print("+ " + " ".join(shlex.quote(c) for c in cmd), file=sys.stderr)
    return subprocess.run(cmd).returncode


if __name__ == "__main__":
    sys.exit(main())

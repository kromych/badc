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


def main() -> int:
    badc = os.environ.get("BADC", "badc")
    out: list[str] = ["--gnu"]
    args = sys.argv[1:]
    i = 0
    while i < len(args):
        a = args[i]
        if a in ("-MD", "-nostdlib", "-pipe", "-s"):
            pass
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

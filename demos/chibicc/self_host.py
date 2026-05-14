#!/usr/bin/env python3
"""Self-host parity check for the chibicc bringup.

Validates that the chibicc binary produced by badc behaves identically
to a reference chibicc built with the host's native cc. Both binaries
must:

  1. Compile each sample C program to a `.s` assembly file with
     byte-identical contents.
  2. After gcc assembles + links those `.s` files, the resulting
     binaries must exit with the same return code on the same input.

The byte-identity check is the stronger of the two. If it holds for
every sample, badc has faithfully reproduced chibicc's codegen path
end-to-end -- the same source goes through the same parser, the same
constant-folding, the same emit order. Differences would indicate
that badc miscompiles some construct in chibicc's body.

The samples deliberately avoid #include <...> so chibicc's
preprocessor doesn't have to find modern glibc headers (which it
can't preprocess -- a known chibicc-upstream limitation tied to
the glibc cutover). The set covers integer arithmetic, recursion,
pointers, struct lvalues, arrays, control flow, and global storage.

Runs on Linux x86_64 only: chibicc emits SysV x86_64 GAS, so the
.s files only assemble on a native x86_64 toolchain. The
`badc-x64` OrbStack VM is the canonical dev-loop target.

Exit codes:
  0 -- byte-identical .s output AND matching exit codes
  1 -- mismatch detected
  2 -- environment unsuitable (wrong arch, missing gcc, chibicc
       sources absent, etc.) -- treated as skip rather than fail
"""

from __future__ import annotations

import os
import platform
import shutil
import subprocess
import sys
from pathlib import Path

CHIBICC_DIR = Path(__file__).resolve().parent
REPO_ROOT = CHIBICC_DIR.parent.parent

# Sample programs -- no #include lines, so chibicc's preprocessor
# stays inside the source. Each one is structured to exercise a
# specific corner of the compile pipeline.
SAMPLES: dict[str, str] = {
    "empty_main.c": """
int main() { return 0; }
""",
    "recursion.c": """
int factorial(int n) { return n <= 1 ? 1 : n * factorial(n - 1); }
int main() { return factorial(6); }
""",
    "struct_lvalue.c": """
struct Pt { int x; int y; };
int main() {
  struct Pt p = {3, 4};
  struct Pt *q = &p;
  int s = 0;
  for (int i = 0; i < 10; i++) s += i;
  return q->x + q->y + s;
}
""",
    "fib_loop.c": """
int fib(int n) { if (n < 2) return n; return fib(n-1) + fib(n-2); }
int main() {
  int sum = 0;
  for (int i = 0; i < 10; i++) sum += fib(i);
  return sum;
}
""",
    "global_array.c": """
int g[8] = {1, 2, 3, 4, 5, 6, 7, 8};
int sum_of(int *a, int n) { int s = 0; for (int i = 0; i < n; i++) s += a[i]; return s; }
int main() { return sum_of(g, 8); }
""",
    "string_walk.c": """
int strlen_local(char *s) { int n = 0; while (s[n]) n++; return n; }
int main() { return strlen_local("self-host"); }
""",
}


def env_unsuitable(reason: str) -> int:
    print(f"self_host: skip -- {reason}", file=sys.stderr)
    return 2


def resolve_badc() -> Path | None:
    env = os.environ.get("BADC")
    candidates: list[Path] = []
    if env:
        candidates.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    candidates.extend([default, default.with_suffix(".exe")])
    for cand in candidates:
        if cand.is_file() and os.access(cand, os.X_OK):
            return cand
    return None


def main() -> int:
    if platform.system() != "Linux" or platform.machine() not in ("x86_64", "amd64"):
        return env_unsuitable(
            "chibicc emits SysV x86_64 GAS; run this on Linux x86_64 "
            "(the badc-x64 OrbStack VM is the canonical target)"
        )

    cc = shutil.which("gcc") or shutil.which("cc")
    if not cc:
        return env_unsuitable("gcc / cc not on PATH")

    badc = resolve_badc()
    if not badc:
        return env_unsuitable(
            f"BADC binary not found; build with "
            f"`cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml`"
        )

    if not (CHIBICC_DIR / "chibicc.h").is_file():
        # Mirror smoke.py: fetch the upstream snapshot on demand.
        subprocess.run(
            [sys.executable, str(CHIBICC_DIR / "setup.py")],
            check=True,
        )

    work = CHIBICC_DIR / ".self_host"
    if work.exists():
        shutil.rmtree(work)
    work.mkdir()
    samples_dir = work / "samples"
    samples_dir.mkdir()
    for name, body in SAMPLES.items():
        (samples_dir / name).write_text(body)

    sources = sorted(CHIBICC_DIR.glob("*.c"))
    if not sources:
        return env_unsuitable("no chibicc *.c sources -- run setup.py first")

    # Reference chibicc: built with the host gcc. The reference is
    # what the upstream chibicc test suite would run against, modulo
    # being built with a different cc.
    ref_chibicc = work / "chibicc-ref"
    print(f"self_host: building reference chibicc via {cc}", flush=True)
    proc = subprocess.run(
        [cc, "-O0", "-g", "-o", str(ref_chibicc), *[str(s) for s in sources]],
        cwd=CHIBICC_DIR,
        capture_output=True,
        text=True,
    )
    if proc.returncode != 0:
        print("ref chibicc build failed:", proc.stderr, file=sys.stderr)
        return 1

    # Stage1: build chibicc via badc (the bringup target).
    stage1_chibicc = work / "chibicc-stage1"
    print(f"self_host: building stage1 chibicc via {badc}", flush=True)
    proc = subprocess.run(
        [
            str(badc),
            "-I",
            str(CHIBICC_DIR),
            "-o",
            str(stage1_chibicc),
            *[str(s) for s in sources],
        ],
        capture_output=True,
        text=True,
    )
    if proc.returncode != 0:
        print("stage1 chibicc build failed:", proc.stderr, file=sys.stderr)
        return 1

    matches = 0
    differed: list[str] = []
    exit_mismatches: list[str] = []

    for sample in sorted(samples_dir.glob("*.c")):
        name = sample.name
        ref_s = work / f"{name}.ref.s"
        s1_s = work / f"{name}.s1.s"

        ref_proc = subprocess.run(
            [str(ref_chibicc), "-S", "-o", str(ref_s), str(sample)],
            capture_output=True,
            text=True,
        )
        if ref_proc.returncode != 0:
            print(f"  REF FAIL {name}: {ref_proc.stderr.strip()}", file=sys.stderr)
            differed.append(name)
            continue
        s1_proc = subprocess.run(
            [str(stage1_chibicc), "-S", "-o", str(s1_s), str(sample)],
            capture_output=True,
            text=True,
        )
        if s1_proc.returncode != 0:
            print(f"  STAGE1 FAIL {name}: {s1_proc.stderr.strip()}", file=sys.stderr)
            differed.append(name)
            continue

        ref_bytes = ref_s.read_bytes()
        s1_bytes = s1_s.read_bytes()
        if ref_bytes != s1_bytes:
            print(f"  DIFFER {name}: ref={len(ref_bytes)}B stage1={len(s1_bytes)}B")
            # Surface the first hunk so a developer chasing a
            # regression can read it without running diff manually.
            ref_lines = ref_bytes.decode("utf-8", "replace").splitlines()
            s1_lines = s1_bytes.decode("utf-8", "replace").splitlines()
            for i, (a, b) in enumerate(zip(ref_lines, s1_lines)):
                if a != b:
                    print(f"    line {i + 1}:\n      ref:    {a!r}\n      stage1: {b!r}")
                    break
            differed.append(name)
            continue

        # Assemble + link via host gcc, run, compare exit codes.
        ref_bin = work / f"{name}.ref.bin"
        s1_bin = work / f"{name}.s1.bin"
        for src, bin_ in ((ref_s, ref_bin), (s1_s, s1_bin)):
            r = subprocess.run([cc, "-o", str(bin_), str(src)], capture_output=True, text=True)
            if r.returncode != 0:
                print(f"  GCC FAIL {name}: {r.stderr.strip()}", file=sys.stderr)
                differed.append(name)
                break
        else:
            ref_run = subprocess.run([str(ref_bin)], capture_output=True)
            s1_run = subprocess.run([str(s1_bin)], capture_output=True)
            if ref_run.returncode != s1_run.returncode:
                print(
                    f"  EXIT MISMATCH {name}: ref={ref_run.returncode} "
                    f"stage1={s1_run.returncode}"
                )
                exit_mismatches.append(name)
                continue
            matches += 1
            print(f"  ok {name}  ({len(ref_bytes)}B, exit={ref_run.returncode})")

    total = len(SAMPLES)
    print(f"self_host: {matches}/{total} samples matched byte-for-byte")
    if differed or exit_mismatches:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""Compile-time scaling probe: cost against input size, per input shape.

A real corpus cannot separate superlinear growth from correlation, because
larger translation units differ from smaller ones in more than size. This
generates one input shape at a time, scales only N, and fits the local
exponent between consecutive doublings. An exponent near 1 is linear; a
sustained exponent near 2 is quadratic in that shape.

Each shape isolates one structure the compiler has to scale in: the symbol
table, the initializer path, per-function passes, the CFG, register
pressure, macro expansion.

Usage:
    tools/scaling_probe.py --badc target/release/badc [--opt -O] [--shape N]
"""

from __future__ import annotations

import argparse
import math
import os
import subprocess
import tempfile
import time
from pathlib import Path


def gen_decls(n: int) -> str:
    """N file-scope prototypes, typedefs and enum constants: symbol table."""
    p = ["typedef struct s%d { int a, b; long c; } t%d;" % (i, i) for i in range(n)]
    p += ["int f%d(t%d *, int, long);" % (i, i) for i in range(n)]
    p += ["enum { E%d = %d };" % (i, i) for i in range(n)]
    return "\n".join(p) + "\nint main(void){return 0;}\n"


def gen_globals(n: int) -> str:
    """N initialized file-scope objects: static data planning and emission."""
    return "\n".join("int g%d = %d;" % (i, i) for i in range(n)) + \
        "\nint main(void){return g0;}\n"


def gen_arrayinit(n: int) -> str:
    """One array with N initializers: the initializer/checkpoint path."""
    body = ",".join(str(i % 251) for i in range(n))
    return "int a[%d] = {%s};\nint main(void){return a[0];}\n" % (n, body)


def gen_structinit(n: int) -> str:
    """One array of structs with N designated element initializers."""
    body = ",".join("[%d] = { .x = %d, .y = %d }" % (i, i, i * 3) for i in range(n))
    return ("struct e { int x; int y; };\n"
            "struct e a[%d] = {%s};\nint main(void){return a[0].x;}\n" % (n, body))


def gen_funcs(n: int) -> str:
    """N small functions: per-function pipeline cost, fixed body size."""
    b = "\n".join("static int fn%d(int x){ int y = x * %d; return y + %d; }"
                  % (i, i + 1, i) for i in range(n))
    return b + "\nint main(void){return fn0(1);}\n"


def gen_stmts(n: int) -> str:
    """One function, N sequential statements: per-function pass scaling."""
    b = "\n".join("  v = v + %d; v = v ^ (v >> 3);" % (i % 97) for i in range(n))
    return "int main(void){ int v = 1;\n%s\n return v; }\n" % b


def gen_locals(n: int) -> str:
    """One function, N locals all live to the end: liveness and allocation."""
    decl = "\n".join("  int l%d = %d;" % (i, i) for i in range(n))
    use = " + ".join("l%d" % i for i in range(n))
    return "int main(void){\n%s\n  return %s;\n}\n" % (decl, use)


def gen_blocks(n: int) -> str:
    """One function, N sequential if/else: CFG size, dominance, phis."""
    b = "\n".join("  if (v & %d) { v += %d; } else { v -= %d; }"
                  % (1 << (i % 20), i, i) for i in range(n))
    return "int main(void){ int v = 7;\n%s\n return v; }\n" % b


def gen_nest(n: int) -> str:
    """One function, N nested loops flattened to depth 8, N/8 wide."""
    inner = "    v += i0;"
    b = []
    for i in range(min(n, 8)):
        b.append("  for (int i%d = 0; i%d < %d; i%d++) {" % (i, i, n, i))
    b.append(inner)
    b += ["  }"] * min(n, 8)
    return "int main(void){ int v = 0;\n%s\n return v; }\n" % "\n".join(b)


def gen_switch(n: int) -> str:
    """One N-case switch: jump-table construction and branch simplification."""
    cases = "\n".join("  case %d: v = %d; break;" % (i, i * 7) for i in range(n))
    return ("int main(void){ int v = 0; int k = 3;\n switch (k) {\n%s\n }\n"
            " return v; }\n" % cases)


def gen_calls(n: int) -> str:
    """One function with N calls to a small callee: the inliner."""
    body = "\n".join("  v += cb(v, %d);" % i for i in range(n))
    return ("static int cb(int a, int b){ return a * 3 + b; }\n"
            "int main(void){ int v = 1;\n%s\n return v; }\n" % body)


def gen_expr(n: int) -> str:
    """One expression of N terms: expression-tree handling."""
    return "int main(void){ return %s; }\n" % " + ".join(str(i % 89) for i in range(n))


def gen_strings(n: int) -> str:
    """N distinct string literals: rodata accumulation and deduplication."""
    arr = ",".join('"literal number %d padding padding"' % i for i in range(n))
    return "const char *s[%d] = {%s};\nint main(void){return s[0][0];}\n" % (n, arr)


def gen_macro(n: int) -> str:
    """N object-like macro invocations, each expanding through 8 levels."""
    lvl = "\n".join("#define L%d(x) L%d(x) + %d" % (i, i - 1, i)
                    for i in range(1, 9))
    return ("#define L0(x) (x)\n%s\n"
            "int main(void){ int v = 0;\n%s\n return v; }\n"
            % (lvl, "\n".join("  v += L8(%d);" % (i % 13) for i in range(n))))


def gen_includes(n: int) -> str:
    """N repeat inclusions of one guarded header: the re-include path."""
    return ("#include <stddef.h>\n" * n) + "int main(void){return 0;}\n"


SHAPES = {
    "decls": gen_decls, "globals": gen_globals, "arrayinit": gen_arrayinit,
    "structinit": gen_structinit, "funcs": gen_funcs, "stmts": gen_stmts,
    "locals": gen_locals, "blocks": gen_blocks, "nest": gen_nest,
    "switch": gen_switch, "calls": gen_calls, "expr": gen_expr,
    "strings": gen_strings, "macro": gen_macro, "includes": gen_includes,
}


def run(badc: str, src: Path, target: str, opt: str, out: Path,
        timeout: float) -> tuple[float, int, int]:
    cmd = [badc, "--gnu", "-q", "-c", f"--target={target}", "-o", str(out)]
    if opt:
        cmd.append(opt)
    cmd.append(str(src))
    errf = tempfile.TemporaryFile()
    t0 = time.monotonic()
    p = subprocess.Popen(cmd, stdout=subprocess.DEVNULL, stderr=errf)
    try:
        pid, status, ru = os.wait4(p.pid, 0)
    finally:
        pass
    p.returncode = os.waitstatus_to_exitcode(status)
    wall = time.monotonic() - t0
    errf.seek(0)
    err = errf.read(300).decode(errors="replace")
    errf.close()
    if p.returncode != 0:
        return (-1.0, p.returncode, 0)
    return (ru.ru_utime + ru.ru_stime, 0, ru.ru_maxrss)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--badc", required=True)
    ap.add_argument("--target", default="linux-x64")
    ap.add_argument("--opt", default="-O", help="-O, or empty for -O0")
    ap.add_argument("--shape", action="append", default=[],
                    help="restrict to these shapes (repeatable)")
    ap.add_argument("--start", type=int, default=250)
    ap.add_argument("--steps", type=int, default=7, help="doublings from --start")
    ap.add_argument("--budget", type=float, default=25.0,
                    help="stop a shape once one point exceeds this many seconds")
    ap.add_argument("--reps", type=int, default=1)
    args = ap.parse_args()

    shapes = args.shape or list(SHAPES)
    tmp = Path(tempfile.mkdtemp(prefix="scaling-probe-"))
    print(f"badc={args.badc} target={args.target} opt={args.opt or '-O0'}")
    for name in shapes:
        gen = SHAPES[name]
        print(f"\n== {name}")
        print(f"{'N':>8} {'bytes':>10} {'cpu(s)':>9} {'rssMB':>7} {'exp':>6}")
        prev = None
        for k in range(args.steps):
            n = args.start * (2 ** k)
            src = tmp / f"{name}-{n}.c"
            src.write_text(gen(n))
            best = None
            for _ in range(args.reps):
                cpu, rc, rss = run(args.badc, src, args.target, args.opt,
                                   tmp / "o.o", 600.0)
                if rc != 0:
                    best = None
                    break
                best = cpu if best is None else min(best, cpu)
            if best is None:
                print(f"{n:>8} {src.stat().st_size:>10} {'rc!=0':>9}")
                break
            e = ""
            if prev and prev[1] > 0 and best > 0:
                e = "%.2f" % (math.log(best / prev[1]) / math.log(n / prev[0]))
            print(f"{n:>8} {src.stat().st_size:>10} {best:>9.3f} "
                  f"{rss / 1024:>7.0f} {e:>6}")
            prev = (n, best)
            src.unlink()
            if best > args.budget:
                break
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

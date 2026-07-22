#!/usr/bin/env python3
"""Linux-kernel translation-unit sweep for badc.

Replays a gcc reference build of the kernel against badc, one translation unit
at a time, and ranks what badc cannot yet compile. Kbuild records the exact
compile command for every object in a ``.<name>.o.cmd`` file next to it; the
sweep walks those, rewrites each gcc command into badc's flag set, runs badc
per unit, and buckets failures by a normalized first-error signature.

Prerequisite: a completed reference build in the kernel tree (``setup.py
--build``). The sweep is read-only with respect to the tree; badc objects go
to a scratch directory.

Flag rewriting keeps the preprocessor surface (-D/-U/-I/-iquote/-include,
-isystem folded into -I) and drops everything else: warnings, optimization,
debug, and the gcc code-model/hardening set (-mcmodel=kernel, -mno-red-zone,
-fno-strict-aliasing, -fstack-protector*, -pg, ...) have no badc spelling.
badc runs with --gnu -q -c --target=<triple>. Kbuild issues relative paths,
so badc runs with the kernel tree as its working directory.

Assembly units (.S) are out of scope and counted separately; so are .cmd
files that do not hold a kernel C compile (host tools, linker steps).

Output: a summary plus a ranked signature table on stdout, the same as
markdown via --report, and the full per-unit result set as JSON next to it.
"""

from __future__ import annotations

import argparse
import json
import os
import platform
import re
import shlex
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

LINUX_DIR = Path(__file__).resolve().parent
REPO_ROOT = LINUX_DIR.parents[1]

TARGETS = {"x86_64": "linux-x64", "aarch64": "linux-aarch64"}

# Directories holding host-tool builds, never kernel target code.
SKIP_DIRS = {"scripts", "tools"}

# Options badc accepts that take a separate argument.
KEEP_ARG = {"-I", "-include", "-iquote"}
# gcc spellings folded into -I (badc searches one include list).
FOLD_TO_I = {"-isystem", "-idirafter"}
# Dropped options that consume the next token; without this the argument
# would be misread as an input path.
DROP_ARG = {"-o", "-MF", "-MQ", "-MT", "--param", "-Xassembler", "-Xlinker"}


def log(m: str) -> None:
    print(f"linux sweep: {m}", flush=True)


def host_arch() -> str:
    m = platform.machine().lower()
    if m in ("arm64", "aarch64"):
        return "aarch64"
    if m in ("x86_64", "amd64"):
        return "x86_64"
    return m


def resolve_badc(cli: str | None) -> Path:
    cands = [Path(cli)] if cli else []
    env = os.environ.get("BADC")
    if env:
        cands.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    cands += [default, default.with_suffix(".exe")]
    for c in cands:
        if c.is_file() and os.access(c, os.X_OK):
            return c.resolve()
    sys.exit("linux sweep: badc binary not found; "
             "hint: cargo build --release --features full")


def parse_cmd_file(path: Path) -> list[str] | None:
    """The recorded compile command from a Kbuild .cmd file, or None when the
    file holds none. The first line is `savedcmd_<obj> := <shell command>`
    (`cmd_` in older Kbuild); an objtool invocation may follow after `;`."""
    try:
        first = path.read_text(errors="replace").split("\n", 1)[0]
    except OSError:
        return None
    if not (first.startswith("savedcmd_") or first.startswith("cmd_")):
        return None
    if " := " not in first:
        return None
    command = first.split(" := ", 1)[1].split(";", 1)[0]
    try:
        return shlex.split(command)
    except ValueError:
        return None


def classify(argv: list[str]) -> tuple[str, str | None]:
    """(kind, source): kind is 'c' for a kernel C compile, 'asm' for a .S
    compile, 'other' for anything else (host compile, link, archive)."""
    src = next((a for a in argv if a.endswith(".c") and not a.startswith("-")), None)
    asm = next((a for a in argv if a.endswith(".S") and not a.startswith("-")), None)
    if "-D__KERNEL__" not in argv:
        return ("other", None)
    if asm is not None and src is None:
        return ("asm", asm)
    if src is not None and "-c" in argv:
        return ("c", src)
    return ("other", None)


AUTOCONF_SUFFIX = "include/generated/autoconf.h"


def rewrite(argv: list[str], autoconf: str | None = None) -> list[str]:
    """gcc argv -> the badc flag set (source and output excluded).

    ``autoconf`` replaces the force-included generated autoconf.h, so a
    configuration probed with badc can be replayed over a corpus captured from
    a reference build."""
    out: list[str] = []
    i = 1
    while i < len(argv):
        a = argv[i]
        if a in KEEP_ARG:
            val = argv[i + 1]
            if (autoconf and a == "-include"
                    and val.replace(os.sep, "/").endswith(AUTOCONF_SUFFIX)):
                val = autoconf
            out += [a, val]
            i += 2
        elif a in FOLD_TO_I:
            out += ["-I", argv[i + 1]]
            i += 2
        elif a.startswith("-I") and len(a) > 2:
            out += ["-I", a[2:]]
            i += 1
        elif a.startswith(("-D", "-U")):
            out.append(a)
            i += 1
        elif a in DROP_ARG:
            i += 2
        elif a.startswith("-"):
            i += 1  # warnings, -O, -g, -std, -f*, -m*, -Wp,* -- no badc spelling
        else:
            i += 1  # positional: the source (added by the caller) or an object
    return out


# Signature normalization: one bucket per distinct diagnostic shape.
_QUOTED = re.compile(r"(`[^`']*'|'[^']*'|\"[^\"]*\")")
_LOC = re.compile(r"(^|\s)\S+\.[ch]:\d+(:\d+)?:?")
_NUM = re.compile(r"\b\d+\b")


def signature(rc: int, stderr: str) -> str:
    lines = [ln for ln in stderr.splitlines() if ln.strip()]
    if rc < 0:
        return f"crash: signal {-rc}"
    panic = next((ln for ln in lines if "panicked at" in ln or "internal error" in ln), None)
    err = next((ln for ln in lines if "error:" in ln), None)
    line = panic or err or (lines[0] if lines else f"exit {rc} with no diagnostics")
    if "panicked at" in line:
        line = "ICE: " + line.split("panicked at", 1)[1]
    elif "error:" in line:
        line = "error: " + line.split("error:", 1)[1]
    line = _LOC.sub(" ", line)
    line = _QUOTED.sub("<id>", line)
    line = _NUM.sub("N", line)
    return " ".join(line.split())[:160]


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--kernel-dir", type=Path, required=True,
                    help="kernel tree with a completed reference build")
    ap.add_argument("--arch", choices=sorted(TARGETS), default=host_arch())
    ap.add_argument("--badc", help="badc binary (default: $BADC or target/release/badc)")
    ap.add_argument("-j", "--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--limit", type=int, default=0, help="cap unit count (debug)")
    ap.add_argument("--timeout", type=float, default=120.0, help="seconds per unit")
    ap.add_argument("--report", type=Path, help="write the markdown report here")
    ap.add_argument("--pre-include", type=Path, action="append", default=[],
                    help="header forced in front of every unit (repeatable); "
                         "supplies a macro or type badc lacks, to unmask the "
                         "units otherwise blocked behind it")
    ap.add_argument("--pre-I", type=Path, action="append", default=[],
                    help="include dir searched before the recorded ones "
                         "(repeatable); an overlay with a patched copy of a "
                         "gating header exposes the failures behind it")
    ap.add_argument("--probed-autoconf", type=Path,
                    help="badc-probed include/generated/autoconf.h (probecfg.py) "
                         "substituted for the reference one each unit force-"
                         "includes; the capability symbols Kconfig baked in from "
                         "the reference compiler then reflect badc instead")
    ap.add_argument("--keep-objects", action="store_true",
                    help="keep the per-unit badc objects in the scratch dir")
    args = ap.parse_args(argv)

    badc = resolve_badc(args.badc)
    kdir = args.kernel_dir.resolve()
    if not (kdir / "Makefile").is_file():
        sys.exit(f"linux sweep: {kdir} is not a kernel tree")
    target = TARGETS[args.arch]

    units: list[tuple[str, list[str]]] = []  # (source, gcc argv)
    n_asm = n_other = 0
    for root, dirs, files in os.walk(kdir):
        rel_top = os.path.relpath(root, kdir).split(os.sep, 1)[0]
        if rel_top in SKIP_DIRS:
            dirs[:] = []
            continue
        for f in files:
            if not (f.startswith(".") and f.endswith(".o.cmd")):
                continue
            cmd = parse_cmd_file(Path(root) / f)
            if cmd is None:
                n_other += 1
                continue
            kind, src = classify(cmd)
            if kind == "c":
                units.append((src, cmd))
            elif kind == "asm":
                n_asm += 1
            else:
                n_other += 1
    units.sort()
    if args.limit:
        units = units[: args.limit]
    if not units:
        sys.exit("linux sweep: no compile commands found; run the reference "
                 "build first (setup.py --build)")

    scratch = LINUX_DIR / ".work" / f"sweep-{args.arch}"
    scratch.mkdir(parents=True, exist_ok=True)
    log(f"badc={badc} target={target} units={len(units)} "
        f"asm-skipped={n_asm} other-cmds={n_other} jobs={args.jobs}")

    pre = [f for p in args.pre_I for f in ("-I", str(p.resolve()))]
    pre += [f for p in args.pre_include for f in ("-include", str(p.resolve()))]

    # A unit reaches autoconf.h two ways: Kbuild force-includes it by path, and
    # include/linux/kconfig.h includes <generated/autoconf.h> off the search
    # path. Substituting the probed header needs both -- rewriting the recorded
    # -include, and an overlay directory searched ahead of the recorded ones.
    autoconf = None
    if args.probed_autoconf:
        src = args.probed_autoconf.resolve()
        if not src.is_file():
            sys.exit(f"linux sweep: no such autoconf.h: {src}")
        overlay = scratch / "probed-config" / "generated"
        overlay.mkdir(parents=True, exist_ok=True)
        (overlay / "autoconf.h").write_bytes(src.read_bytes())
        autoconf = str(overlay / "autoconf.h")
        pre = ["-I", str(overlay.parent)] + pre
        n_sub = sum(1 for _, a in units if rewrite(a, autoconf) != rewrite(a))
        log(f"probed config: {src} (force-include rewritten in {n_sub}/"
            f"{len(units)} units, search path overlay in all)")

    def run_one(item: tuple[str, list[str]]) -> dict:
        src, gcc_argv = item
        obj = scratch / (src.replace(os.sep, "_") + ".o")
        flags = rewrite(gcc_argv, autoconf)
        cmd = [str(badc), "--gnu", "-q", "-c", f"--target={target}",
               "-o", str(obj), *pre, *flags, src]
        try:
            r = subprocess.run(cmd, cwd=kdir, capture_output=True, text=True,
                               timeout=args.timeout)
            rc, err = r.returncode, r.stderr
        except subprocess.TimeoutExpired:
            rc, err = 900, f"timeout after {args.timeout:.0f}s"
        ok = rc == 0
        if not args.keep_objects:
            obj.unlink(missing_ok=True)
        res = {"src": src, "ok": ok}
        if not ok:
            res["sig"] = signature(rc, err)
            res["stderr"] = "\n".join(err.splitlines()[:8])
        return res

    t0 = time.time()
    results: list[dict] = []
    with ThreadPoolExecutor(max_workers=args.jobs) as ex:
        for i, res in enumerate(ex.map(run_one, units), 1):
            results.append(res)
            if i % 500 == 0:
                log(f"{i}/{len(units)} done")
    n_ok = sum(1 for r in results if r["ok"])
    n_fail = len(results) - n_ok
    log(f"done in {time.time() - t0:.0f}s: {n_ok} ok, {n_fail} failed, "
        f"{n_asm} .S skipped")

    buckets: dict[str, list[str]] = {}
    locs: dict[str, int] = {}
    for r in results:
        if not r["ok"]:
            buckets.setdefault(r["sig"], []).append(r["src"])
            first = r["stderr"].splitlines()[0] if r.get("stderr") else ""
            if " error:" in first:
                site = first.split(" error:")[0].rstrip(":")
                locs[site] = locs.get(site, 0) + 1
    ranked = sorted(buckets.items(), key=lambda kv: (-len(kv[1]), kv[0]))
    loc_ranked = sorted(locs.items(), key=lambda kv: (-kv[1], kv[0]))[:15]

    lines = [
        f"# badc kernel TU sweep: {args.arch} ({kdir.name})",
        "",
        f"- badc: `{badc}`  target: `{target}`",
        f"- C units: {len(units)}  pass: {n_ok}  fail: {n_fail}  "
        f"pass rate: {100.0 * n_ok / len(units):.1f}%",
        f"- .S units skipped: {n_asm}  non-compile .cmd files: {n_other}",
        f"- config: {'badc-probed, autoconf.h `' + str(args.probed_autoconf)
                    + '` (force-include rewritten in ' + str(n_sub) + '/'
                    + str(len(units)) + ' units, search path overlay in all)'
                    if autoconf else 'as captured from the reference build'}",
        "",
        "| rank | count | error signature | examples |",
        "|-----:|------:|-----------------|----------|",
    ]
    for rank, (sig, srcs) in enumerate(ranked, 1):
        ex_list = ", ".join(f"`{s}`" for s in srcs[:3])
        sig_md = sig.replace("|", "\\|")
        lines.append(f"| {rank} | {len(srcs)} | {sig_md} | {ex_list} |")
    # A single header can gate hundreds of units; rank the sites the first
    # error fires at so the gating headers are named, not just the messages.
    if loc_ranked:
        lines += ["", "| count | first-error site |", "|------:|------------------|"]
        lines += [f"| {n} | `{site}` |" for site, n in loc_ranked]
    report = "\n".join(lines) + "\n"
    print(report)

    out_json = (args.report.with_suffix(".json") if args.report
                else scratch / "results.json")
    out_json.parent.mkdir(parents=True, exist_ok=True)
    out_json.write_text(json.dumps(results, indent=1))
    if args.report:
        args.report.write_text(report)
        log(f"report -> {args.report}; full results -> {out_json}")
    else:
        log(f"full results -> {out_json}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

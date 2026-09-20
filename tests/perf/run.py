#!/usr/bin/env python3
"""Perf-table harness comparing badc against the vendored tcc and the
reference compilers on a small fixture set.

Each fixture is compiled with every available compiler, the result is
run three times, and the median wall-clock is reported. The table goes
to stdout in GitHub-Flavored-Markdown so the CI job can route it into
$GITHUB_STEP_SUMMARY.

Exit status:
* 0 -- table printed; every binary built and ran successfully.
* 1 -- one or more entries failed to build or run.

Legs probed (skipped when the compiler or the flag is absent):
* badc               -- target/release/badc next to repo root.
* badc -O            -- same with -O.
* tcc                -- built by build_tcc.sh from demos/tinycc sources.
* clang -O0, gcc -O0 -- the reference compilers on PATH.
* clang -O2, gcc -O2 -- same.
* <cc> -O2 -march=<level> -- the same pair pinned to the instruction-set
  level badc assumes for the host architecture (BASELINE_LEVEL), so the
  table compares badc against them at its own baseline rather than at
  their defaults.
* cl /Od, cl /O2     -- MSVC cl.exe on Windows.

A leg is named by the flags that distinguish it, so two legs of one
compiler are two rows. badc -O implies NDEBUG; the -O2 and /O2 legs pass
-DNDEBUG explicitly to match. The unoptimized entries keep asserts live.

Override the badc binary via $BADC; override the tcc binary via $TCC.
"""

from __future__ import annotations

import argparse
import json
import os
import platform
import re
import shutil
import statistics
import subprocess
import sys
import tempfile
import time
from dataclasses import dataclass
from pathlib import Path

PERF_DIR = Path(__file__).resolve().parent
REPO_ROOT = PERF_DIR.parent.parent

WIN = sys.platform == "win32"
EXE = ".exe" if WIN else ""
RUNS_PER_FIXTURE = 3
TIMING_LINE_RE = re.compile(r"in\s+(\d+(?:\.\d+)?)\s+ms")
# The record contract `scripts/perf_publish.py` files: 3 states each
# leg's flags and the level it pins, so two legs of one compiler are two
# entries.
SCHEMA = 3
# The compilers the table measures badc against, probed in this order.
REFERENCE_CC = ("clang", "gcc")
# The instruction-set level badc's codegen assumes on each architecture
# (doc/native-compilation.md). badc takes no -march; the reference
# compilers get one leg pinned here as well as their default ones.
BASELINE_LEVEL = {"x86_64": "x86-64-v3", "aarch64": "armv8.4-a"}
# `platform.machine()` answers with the host's own spelling.
ARCH_ALIAS = {"arm64": "aarch64", "amd64": "x86_64", "AMD64": "x86_64",
              "x64": "x86_64"}
# What a leg's name keeps in the binary it builds; every other character
# becomes `_`, so `cl /O2` and `gcc -O2 -march=...` are filenames.
SLUG_OK = re.compile(r"[^A-Za-z0-9._-]")

# The SQLite amalgamation only parses once the features pulling in
# headers badc does not ship are switched off (load-extension, the
# Apple AFP locking path, deprecated entry points). The same knobs are
# harmless for clang and tcc, so every compiler gets them.
SQLITE_DEFINES = [
    "-DSQLITE_OMIT_LOAD_EXTENSION",
    "-DSQLITE_THREADSAFE=0",
    "-DSQLITE_DEFAULT_MEMSTATUS=0",
    "-DSQLITE_DQS=0",
    "-DSQLITE_OMIT_DEPRECATED",
    "-DSQLITE_OMIT_PROGRESS_CALLBACK",
    "-DSQLITE_OMIT_SHARED_CACHE",
    "-DSQLITE_OMIT_AUTOINIT",
    "-DSQLITE_WITHOUT_ZONEMALLOC=1",
    "-DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1",
    "-DSQLITE_ENABLE_LOCKING_STYLE=0",
    # sqlite reaches for MSVC's __umulh / _umul128 intrinsics and the
    # SEH wrappers; disabling them selects the portable fallbacks. Both
    # are inert for clang and tcc, which never take the MSVC paths.
    "-DSQLITE_DISABLE_INTRINSIC",
    "-DSQLITE_OMIT_SEH",
    # glibc gates `mremap` + `MREMAP_MAYMOVE` behind `_GNU_SOURCE`; the
    # sqlite amalgamation hard-references both on Linux. macOS / BSD
    # headers ignore the macro.
    "-D_GNU_SOURCE",
]

# Extra compile flags per fixture. The `-I` entries put each vendored
# demo directory on the include search path: badc resolves quoted
# includes against the search path rather than the including file's
# directory, and the path is harmless for clang and tcc.
FIXTURE_FLAGS: dict[str, list[str]] = {
    "crypto.c": [f"-I{REPO_ROOT}/demos/tweetnacl"],
    "sqlite.c": [f"-I{REPO_ROOT}/demos/sqlite3", *SQLITE_DEFINES],
    "sqlite_bench.c": [f"-I{REPO_ROOT}/demos/sqlite3", *SQLITE_DEFINES],
    "compress.c": [
        f"-I{REPO_ROOT}/demos/miniz",
        # Keep only the in-memory zlib-style codec; drop the ZIP archive,
        # stdio, and wall-clock paths that reach for headers badc and tcc
        # do not ship (sys/utime.h, struct utimbuf).
        "-DMINIZ_NO_STDIO",
        "-DMINIZ_NO_TIME",
        "-DMINIZ_NO_ARCHIVE_APIS",
    ],
    "stb.c": [f"-I{REPO_ROOT}/demos/stb"],
    # quickjs_bench.c drives the full engine, so its other seven
    # translation units ride along as extra source arguments. qjs.c is
    # excluded -- the bench supplies its own main().
    "quickjs_bench.c": [
        f"-I{REPO_ROOT}/demos/quickjs",
        "-D_GNU_SOURCE",
        '-DCONFIG_VERSION="2024"',
        f"{REPO_ROOT}/demos/quickjs/quickjs.c",
        f"{REPO_ROOT}/demos/quickjs/quickjs-libc.c",
        f"{REPO_ROOT}/demos/quickjs/cutils.c",
        f"{REPO_ROOT}/demos/quickjs/libregexp.c",
        f"{REPO_ROOT}/demos/quickjs/libunicode.c",
        f"{REPO_ROOT}/demos/quickjs/dtoa.c",
        f"{REPO_ROOT}/demos/quickjs/repl_stub.c",
    ],
}

# Flags applied only when the compiler is badc. The bundled msvc_compat.h
# presents the MSVC surface sqlite's Windows paths expect; it is guarded by
# `_WIN32`, so the include changes nothing on other targets. clang and tcc
# use the real system headers and must not see this include.
BADC_FIXTURE_FLAGS: dict[str, list[str]] = {
    "sqlite.c": ["-include", "msvc_compat.h"],
    "sqlite_bench.c": ["-include", "msvc_compat.h"],
}

# Compilers that cannot build a given fixture, skipped rather than counted
# as a build failure. The vendored tcc does not implement the AArch64
# `yield` instruction quickjs uses in a spin loop.
FIXTURE_SKIP_COMPILERS: dict[str, set[str]] = {
    "quickjs_bench.c": {"tcc"},
}


@dataclass
class Compiler:
    name: str
    cmd: list[str]
    # When True, the compiler invocation expects the output flag as
    # `-o <path>`; when False (MSVC), it expects `/Fe:<path>`.
    output_dash_o: bool = True
    # Extra flags appended after the source path.
    trailing: tuple[str, ...] = ()
    # The instruction-set level this leg pins, when it pins one.
    level: str = ""

    @property
    def flags(self) -> list[str]:
        """Every argument this leg passes for every fixture, past the
        binary. The per-fixture ones are in FIXTURE_FLAGS."""
        return [*self.cmd[1:], *self.trailing]


@dataclass
class Result:
    compiler: str
    fixture: str
    binary_bytes: int
    median_ms: float
    compile_ms: float


def host_level(arch: str = "") -> str:
    """The instruction-set level badc assumes on this machine, or empty
    where it assumes none."""
    arch = arch or platform.machine()
    return BASELINE_LEVEL.get(ARCH_ALIAS.get(arch, arch), "")


def accepts_flag(argv: list[str], flag: str) -> bool:
    """Whether the compiler `argv` compiles a trivial unit with `flag`."""
    with tempfile.TemporaryDirectory() as tmp:
        src = Path(tmp) / "probe.c"
        src.write_text("int main(void) { return 0; }\n")
        obj = Path(tmp) / ("probe.obj" if WIN else "probe.o")
        try:
            r = subprocess.run([*argv, flag, "-c", str(src), "-o", str(obj)],
                               capture_output=True, text=True)
        except OSError:
            return False
        return r.returncode == 0


def reference_legs(name: str, argv: list[str], level: str,
                   trailing: tuple[str, ...] = ()) -> list[Compiler]:
    """The legs of one reference compiler: the two optimization levels
    the table has always carried, plus the baseline leg when the
    compiler takes the level's `-march`."""
    legs = [
        Compiler(f"{name} -O0", [*argv, "-O0"], trailing=trailing),
        Compiler(f"{name} -O2", [*argv, "-O2", "-DNDEBUG"], trailing=trailing),
    ]
    if not level:
        return legs
    march = f"-march={level}"
    if accepts_flag(argv, march):
        legs.append(Compiler(f"{name} -O2 {march}",
                             [*argv, "-O2", "-DNDEBUG", march],
                             trailing=trailing, level=level))
    else:
        print(f"info: {name} rejects {march}; skipping its baseline row",
              file=sys.stderr)
    return legs


def probe_compilers() -> list[Compiler]:
    found: list[Compiler] = []

    badc_env = os.environ.get("BADC")
    if badc_env:
        badc = Path(badc_env)
    else:
        badc = REPO_ROOT / "target" / "release" / f"badc{EXE}"
    if badc.is_file():
        found.append(Compiler("badc", [str(badc)]))
        found.append(Compiler("badc -O", [str(badc), "-O"]))
    else:
        print(f"info: badc not at {badc}; skipping badc rows", file=sys.stderr)

    tcc_env = os.environ.get("TCC")
    if tcc_env:
        tcc = Path(tcc_env)
    else:
        tcc = PERF_DIR / "build" / f"tcc{EXE}"
        # Bootstrap the vendored tinycc on first run so the perf
        # table reports a single-pass non-optimising baseline
        # without the caller having to remember to invoke
        # `build_tcc.sh`. The build script is a no-op when its
        # output already exists.
        if not tcc.is_file():
            build_script = PERF_DIR / "build_tcc.sh"
            if build_script.is_file():
                print(
                    f"info: bootstrapping vendored tinycc via {build_script.name}",
                    file=sys.stderr,
                )
                subprocess.run(["bash", str(build_script)], check=False)
    if tcc.is_file():
        # tcc's macho build needs the macOS SDK include path; the Linux
        # build is happy with the bundled `-B` directory holding
        # tccdefs.h.
        # -B finds tccdefs.h; -L puts the build dir on the library path
        # so tcc resolves its own libtcc1.a there.
        tcc_cmd = [
            str(tcc),
            f"-B{tcc.parent}",
            f"-I{tcc.parent}/include",
            f"-L{tcc.parent}",
        ]
        if sys.platform == "darwin":
            sdk = subprocess.run(
                ["xcrun", "--show-sdk-path"],
                capture_output=True,
                text=True,
                check=False,
            )
            if sdk.returncode == 0 and sdk.stdout.strip():
                tcc_cmd += [f"-I{sdk.stdout.strip()}/usr/include"]
        # The FP fixtures call libm (fabs); on Linux libm is a separate
        # archive that must be named at link time. macOS folds it into
        # libSystem, which tcc links by default.
        tcc_trailing = ("-lm",) if sys.platform == "linux" else ()
        found.append(Compiler("tcc", tcc_cmd, trailing=tcc_trailing))
    else:
        print(f"info: tcc not at {tcc}; skipping tcc rows", file=sys.stderr)

    # The FP fixtures and quickjs call libm (pow / fmod / ldexp); on
    # Linux libm is a separate archive that must be named at link
    # time, the same reason tcc needs it above. macOS folds it into
    # libSystem. Without `-lm` the link of quickjs_bench fails.
    cc_trailing = ("-lm",) if sys.platform == "linux" else ()
    level = host_level()
    # `/usr/bin/gcc` on macOS is clang; without this its legs would
    # report one compiler's numbers twice, under two names.
    by_version: dict[str, str] = {}
    for prog in REFERENCE_CC:
        if not shutil.which(prog):
            continue
        version = program_version(prog)
        first = by_version.get(version)
        if version and first:
            print(f"info: {prog} reports the version of {first} "
                  f"({version}); skipping its rows", file=sys.stderr)
            continue
        by_version[version] = prog
        found += reference_legs(prog, [prog], level, cc_trailing)

    if WIN and shutil.which("cl"):
        found.append(
            Compiler(
                "cl /Od",
                ["cl", "/nologo", "/Od"],
                output_dash_o=False,
            )
        )
        found.append(
            Compiler(
                "cl /O2",
                ["cl", "/nologo", "/O2", "/DNDEBUG"],
                output_dash_o=False,
            )
        )

    return found


def compile_one(c: Compiler, src: Path, out: Path) -> float | None:
    """Compile `src` with `c`, returning the wall-clock in milliseconds, or
    `None` when the compiler failed or produced nothing."""
    extra = list(FIXTURE_FLAGS.get(src.name, []))
    if c.name.startswith("badc"):
        extra += BADC_FIXTURE_FLAGS.get(src.name, [])
    if c.output_dash_o:
        argv = [*c.cmd, *extra, "-o", str(out), str(src), *c.trailing]
    else:
        argv = [*c.cmd, *extra, f"/Fe:{out}", str(src), *c.trailing]
    t0 = time.monotonic()
    r = subprocess.run(argv, capture_output=True, text=True)
    compile_ms = (time.monotonic() - t0) * 1000.0
    if r.returncode != 0:
        print(
            f"compile fail: {c.name} {src.name} -> exit {r.returncode}",
            file=sys.stderr,
        )
        if r.stderr:
            print(r.stderr, file=sys.stderr)
        return None
    if not out.is_file() or out.stat().st_size == 0:
        print(
            f"compile fail: {c.name} {src.name} -> empty output {out}",
            file=sys.stderr,
        )
        return None
    # macOS sometimes refuses unsigned binaries with SIGKILL; sign with
    # the ad-hoc identity if we just produced an aarch64 binary.
    if sys.platform == "darwin" and platform.machine() == "arm64":
        subprocess.run(["codesign", "-s", "-", str(out)], check=False)
    return compile_ms


def run_one(out: Path) -> float | None:
    times = []
    for _ in range(RUNS_PER_FIXTURE):
        r = subprocess.run([str(out)], capture_output=True, text=True)
        if r.returncode != 0:
            print(
                f"run fail: {out.name} -> exit {r.returncode}",
                file=sys.stderr,
            )
            if r.stderr:
                print(r.stderr, file=sys.stderr)
            return None
        m = TIMING_LINE_RE.search(r.stdout)
        if not m:
            print(f"run: no timing line in output of {out.name}", file=sys.stderr)
            print(r.stdout, file=sys.stderr)
            return None
        times.append(float(m.group(1)))
    return statistics.median(times)


def render_table(fixtures: list[str], results: list[Result],
                 order: list[str]) -> str:
    """The table, one section per fixture, its rows in the order the
    legs were probed: badc first, then tcc, then each reference compiler
    at its levels."""
    by_fix: dict[str, dict[str, Result]] = {}
    for r in results:
        by_fix.setdefault(r.fixture, {})[r.compiler] = r
    measured = {r.compiler for r in results}
    compilers = [c for c in order if c in measured]
    compilers += sorted(measured - set(compilers))

    out: list[str] = []
    for fix in fixtures:
        rows = by_fix.get(fix, {})
        if not rows:
            continue
        out.append(f"### {fix}")
        out.append("")
        out.append("| compiler | median (ms) | binary (bytes) | vs badc -O |")
        out.append("| --- | ---: | ---: | ---: |")
        baseline = rows.get("badc -O")
        for c in compilers:
            r = rows.get(c)
            if r is None:
                continue
            ratio = "-"
            if baseline is not None and baseline.median_ms > 0:
                ratio = f"{r.median_ms / baseline.median_ms:.2f}x"
            out.append(
                f"| {r.compiler} | {r.median_ms:.1f} | {r.binary_bytes:,} | {ratio} |"
            )
        out.append("")
    return "\n".join(out)


def cpu_model() -> str:
    """The machine's processor, as the host reports it; empty when it does
    not say. The figures are comparable within one run only, so the page
    that publishes them names the machine each run landed on."""
    try:
        if sys.platform == "darwin":
            out = subprocess.run(["sysctl", "-n", "machdep.cpu.brand_string"],
                                 capture_output=True, text=True)
            return out.stdout.strip()
        if sys.platform.startswith("linux"):
            for line in Path("/proc/cpuinfo").read_text().splitlines():
                for key in ("model name", "Model"):
                    if line.startswith(key):
                        return line.split(":", 1)[1].strip()
            # AArch64 kernels print the implementer and part numbers instead
            # of a name; lscpu carries the table that decodes them.
            out = subprocess.run(["lscpu"], capture_output=True, text=True)
            for line in out.stdout.splitlines():
                if line.startswith("Model name:"):
                    return line.split(":", 1)[1].strip()
    except OSError:
        pass
    return ""


IMAGE_DATA = Path("/imagegeneration/imagedata.json")
OS_RELEASE = Path("/etc/os-release")


def runner_image(image_data: Path = IMAGE_DATA,
                 os_release: Path = OS_RELEASE) -> str:
    """The image the machine booted, as it names itself. A GitHub runner
    publishes its image data where the job log's `Image:` line comes from;
    any other Linux host names its own release. Empty when neither says."""
    try:
        data = json.loads(image_data.read_text())
        for entry in data if isinstance(data, list) else []:
            for line in str(entry.get("detail", "")).splitlines():
                if line.startswith("Image:"):
                    return line.split(":", 1)[1].strip()
    except (OSError, ValueError, AttributeError):
        pass
    try:
        fields = dict(line.split("=", 1) for line
                      in os_release.read_text().splitlines() if "=" in line)
    except OSError:
        return ""
    name = fields.get("ID", "").strip('"')
    version = fields.get("VERSION_ID", "").strip('"')
    return f"{name}-{version}" if name and version else ""


def program_version(prog: str, dash_version: bool = True) -> str:
    """The first line of a compiler's own version output. MSVC prints its
    banner when asked for nothing and rejects `--version`."""
    argv = [prog, "--version"] if dash_version else [prog]
    try:
        r = subprocess.run(argv, capture_output=True, text=True)
    except OSError:
        return ""
    text = (r.stdout or r.stderr).strip().splitlines()
    return text[0] if text else ""


def compiler_version(c: Compiler) -> str:
    return program_version(c.cmd[0], c.output_dash_o)


def named_compiler(c: Compiler) -> dict:
    """The leg as schema 3 states it: the name the results key on, the
    compiler's own version line, the flags it was given, and the
    instruction-set level it pins where it pins one."""
    doc = {"name": c.name}
    version = compiler_version(c)
    if version:
        doc["version"] = version
    doc["flags"] = c.flags
    if c.level:
        doc["level"] = c.level
    return doc


def write_json(path: Path, compilers: list[Compiler], fixtures: list[str],
               results: list[Result]) -> None:
    """The run as data, for the page that charts it: what ran where, and one
    record per (fixture, compiler) with the three measurements.

    This is the part of the schema-3 record the harness knows. The commit,
    the CI runner label and the runner image are the publisher's to add, and
    `scripts/perf_publish.py` stamps them; a field the host does not report is
    left out rather than written empty."""
    machine = {
        "system": platform.system(),
        "release": platform.release(),
        "arch": platform.machine(),
        "cpu": cpu_model(),
        "image": runner_image(),
        # The CI step overrides this with the runner's label.
        "runner": "local",
    }
    doc = {
        "schema": SCHEMA,
        "taken": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "machine": {k: v for k, v in machine.items() if v},
        "runs_per_fixture": RUNS_PER_FIXTURE,
        "compilers": [named_compiler(c) for c in compilers],
        "fixtures": fixtures,
        "results": [
            {
                "fixture": r.fixture,
                "compiler": r.compiler,
                "run_ms": round(r.median_ms, 2),
                "compile_ms": round(r.compile_ms, 1),
                "binary_bytes": r.binary_bytes,
            }
            for r in results
        ],
    }
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(doc, indent=1) + "\n")


# A compiler for the self-test: it answers `-c` and rejects one -march,
# which is what a leg the host cannot pin has to look like.
FAKE_CC = """import sys
flags = sys.argv[1:]
if "-march=x86-64-v3" in flags:
    sys.stderr.write("fakecc: unsupported argument 'x86-64-v3'\\n")
    sys.exit(1)
out = flags[flags.index("-o") + 1] if "-o" in flags else "a.out"
open(out, "w").write("")
"""


def self_test() -> int:
    """The parts of the record that do not need a compiler: where the image
    name comes from, how a leg is named and stated, and the shape `--json`
    writes."""
    with tempfile.TemporaryDirectory() as tmp:
        d = Path(tmp)
        cc = d / "fakecc.py"
        cc.write_text(FAKE_CC)
        argv = [sys.executable, str(cc)]
        assert accepts_flag(argv, "-march=armv8.4-a")
        assert not accepts_flag(argv, "-march=x86-64-v3")
        assert not accepts_flag([str(d / "absent")], "-march=armv8.4-a")
        # The level the compiler takes gets a third leg; the one it
        # rejects leaves the other two standing.
        legs = reference_legs("fakecc", argv, "armv8.4-a", ("-lm",))
        assert [c.name for c in legs] == [
            "fakecc -O0", "fakecc -O2",
            "fakecc -O2 -march=armv8.4-a"], [c.name for c in legs]
        assert legs[2].flags == [str(cc), "-O2", "-DNDEBUG",
                                 "-march=armv8.4-a", "-lm"], legs[2].flags
        assert legs[2].level == "armv8.4-a" and legs[1].level == ""
        rejected = reference_legs("fakecc", argv, "x86-64-v3")
        assert [c.name for c in rejected] == ["fakecc -O0", "fakecc -O2"], \
            [c.name for c in rejected]
        # An architecture badc states no level for asks for no -march.
        assert [c.name for c in reference_legs("fakecc", argv, "")] == \
            ["fakecc -O0", "fakecc -O2"]
        assert host_level("arm64") == "armv8.4-a"
        assert host_level("AMD64") == "x86-64-v3"
        assert host_level("riscv64") == ""

        # A leg states the flags it was given, whatever the compiler's
        # spelling of them, and its level only when it pins one. The
        # binaries here do not exist: a leg is stated without running one.
        msvc = Compiler("cl /O2", [str(d / "cl"), "/nologo", "/O2", "/DNDEBUG"],
                        output_dash_o=False)
        assert named_compiler(msvc)["flags"] == ["/nologo", "/O2", "/DNDEBUG"]
        assert "level" not in named_compiler(msvc)
        assert "version" not in named_compiler(msvc)
        assert named_compiler(Compiler("badc", [str(d / "badc")]))["flags"] == []
        # Two legs of one compiler are two entries, distinguished by name.
        assert len({named_compiler(c)["name"] for c in legs}) == 3
        assert SLUG_OK.sub("_", "gcc -O2 -march=x86-64-v3") == \
            "gcc_-O2_-march_x86-64-v3"
        assert SLUG_OK.sub("_", "cl /O2") == "cl__O2"

    with tempfile.TemporaryDirectory() as tmp:
        d = Path(tmp)
        (d / "imagedata.json").write_text(json.dumps([
            {"group": "Operating System", "detail": "Ubuntu\n24.04.3\nLTS"},
            {"group": "Runner Image",
             "detail": "Image: ubuntu-24.04-arm\nVersion: 20260907.300.1\n"},
        ]))
        (d / "os-release").write_text(
            'PRETTY_NAME="Ubuntu 24.04.3 LTS"\nID=ubuntu\n'
            'VERSION_ID="24.04"\n')
        assert runner_image(d / "imagedata.json",
                            d / "os-release") == "ubuntu-24.04-arm"
        # Without the runner's image data the host names its own release.
        assert runner_image(d / "absent.json",
                            d / "os-release") == "ubuntu-24.04"
        assert runner_image(d / "absent.json", d / "absent") == ""
        (d / "empty.json").write_text("[]")
        assert runner_image(d / "empty.json", d / "absent") == ""

        out = d / "perf.json"
        legs = [Compiler("badc -O", [str(d / "badc"), "-O"]),
                Compiler("gcc -O2 -march=x86-64-v3",
                         [str(d / "gcc"), "-O2", "-DNDEBUG",
                          "-march=x86-64-v3"], level="x86-64-v3")]
        write_json(out, legs, ["fib.c"],
                   [Result(compiler="badc -O", fixture="fib.c",
                           binary_bytes=18224, median_ms=103.04,
                           compile_ms=32.21)])
        doc = json.loads(out.read_text())
        assert doc["schema"] == 3, doc["schema"]
        assert doc["machine"]["runner"] == "local", doc["machine"]
        assert "" not in doc["machine"].values(), doc["machine"]
        assert doc["results"] == [
            {"fixture": "fib.c", "compiler": "badc -O", "run_ms": 103.04,
             "compile_ms": 32.2, "binary_bytes": 18224}], doc["results"]
        # The record lists the legs that ran, whatever set that is, and a
        # result keys the name of one of them.
        assert [c["name"] for c in doc["compilers"]] == \
            ["badc -O", "gcc -O2 -march=x86-64-v3"], doc["compilers"]
        assert doc["compilers"][0]["flags"] == ["-O"], doc["compilers"][0]
        assert doc["compilers"][1]["level"] == "x86-64-v3"
        assert doc["results"][0]["compiler"] == doc["compilers"][0]["name"]

        # The table reads in probe order and keeps a leg the order does
        # not name.
        rows = render_table(["fib.c"], [
            Result(compiler=n, fixture="fib.c", binary_bytes=1,
                   median_ms=m, compile_ms=1.0)
            for n, m in (("badc -O", 100.0), ("gcc -O2", 50.0),
                         ("tcc", 400.0))],
            ["badc -O", "tcc", "gcc -O2"])
        assert [line.split("|")[1].strip() for line in rows.splitlines()
                if line.startswith("| ") and "---" not in line][1:] == \
            ["badc -O", "tcc", "gcc -O2"], rows
        assert "| 0.50x |" in rows, rows
    print("[perf run] self-test OK")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--json", type=Path, metavar="PATH",
                    help="also write the run as JSON, for the performance page")
    ap.add_argument("--only", metavar="A.c,B.c",
                    help="run these fixtures instead of the whole set")
    ap.add_argument("--self-test", action="store_true",
                    help="check the record shape; compile nothing")
    args = ap.parse_args()
    if args.self_test:
        return self_test()

    compilers = probe_compilers()
    if not compilers:
        print("error: no compilers found", file=sys.stderr)
        return 1

    fixtures = [
        "fib.c",
        "qsort.c",
        "sieve.c",
        # Digit loop over a counted range: division and modulo by a
        # constant, a table load, and an early-exit compare.
        "munchausen.c",
        "crypto.c",
        "compress.c",
        "stb.c",
        "sqlite.c",
        # Multi-phase workload (bulk insert, aggregation, sort, index,
        # join, subquery, update / delete; 100k + 50k rows).
        "sqlite_bench.c",
        "quickjs_bench.c",
    ]
    if args.only:
        want = [f.strip() for f in args.only.split(",") if f.strip()]
        missing = [f for f in want if f not in fixtures]
        if missing:
            print(f"error: unknown fixture(s): {', '.join(missing)}", file=sys.stderr)
            return 1
        fixtures = want
    results: list[Result] = []
    any_fail = False

    out_dir = PERF_DIR / "build" / "bins"
    out_dir.mkdir(parents=True, exist_ok=True)

    for fix in fixtures:
        src = PERF_DIR / fix
        if not src.is_file():
            print(f"missing fixture: {src}", file=sys.stderr)
            any_fail = True
            continue
        for c in compilers:
            if c.name in FIXTURE_SKIP_COMPILERS.get(fix, set()):
                continue
            out = out_dir / f"{src.stem}-{SLUG_OK.sub('_', c.name)}{EXE}"
            compile_ms = compile_one(c, src, out)
            if compile_ms is None:
                any_fail = True
                continue
            t = run_one(out)
            if t is None:
                any_fail = True
                continue
            results.append(
                Result(
                    compiler=c.name,
                    fixture=fix,
                    binary_bytes=out.stat().st_size,
                    median_ms=t,
                    compile_ms=compile_ms,
                )
            )

    print("## perf comparison")
    print()
    print(render_table(fixtures, results, [c.name for c in compilers]))
    if args.json:
        write_json(args.json, compilers, fixtures, results)
        print(f"\nwrote {args.json}")
    return 1 if any_fail else 0


if __name__ == "__main__":
    sys.exit(main())

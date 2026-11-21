#!/usr/bin/env python3
"""Build SymCrypt 103.13.0 with badc through its own CMake and run its unit test.

Pipeline:
  - ``setup.py`` fetches and extracts the release under ``.cache``.
  - SymCrypt's CMake configures the build with badc as the C compiler and
    the host C++ compiler for the unit test, ``symcryptunittest``, a C++
    program that links the badc-built static library. Every C unit of the
    library is checked to have been compiled by badc.
  - ``symcryptunittest noperftests`` runs the functional tests: the known
    answers, error cases and cross-implementation checks of every
    algorithm. The run passes when it reports the suite done and exits 0.

The configuration is SymCrypt's own options:
  - ``SYMCRYPT_USE_ASM``: on for aarch64, whose generated GNU-syntax
    assembly badc assembles; off for x86_64, whose generated form is Intel
    syntax, which badc's assembler does not take (#2141). Off selects
    ``SYMCRYPT_IGNORE_PLATFORM``, the portable C code throughout.
  - ``SYMCRYPT_STACK_PROTECTION=OFF``: it adds -fstack-clash-protection,
    which badc does not implement (#2142).
  - ``SYMCRYPT_FIPS_BUILD=OFF``: the FIPS build needs the jitterentropy
    submodule, which the release archive does not carry.
  - ``SYMCRYPT_BUILD_MODULES=OFF``, ``SYMCRYPT_SYMCRUST=OFF``: the unit test
    links the static library and the C ML-KEM.
  - ``CMAKE_C_FLAGS``: -fgnuc-version=4.7.0, the first GNU version CMake
    gives a C11 mode, which the project requires; and
    -Wno-incompatible-pointer-types, since the library initializes
    ``void (*)(void *)`` members with functions of a structure-pointer
    parameter, which gcc 16 and clang 23 reject as well.

On x86_64 the portable bignum code makes RSA, DH and DSA 860 s of the
955 s the full suite takes on the x86_64 box, so the smoke leaves them out
there; ``BADC_SYMCRYPT_TESTS=all`` runs them too. On aarch64 the full suite
takes 227 s. Linux only: SymCrypt's macOS configuration fixes the compiler
to clang, and its Windows one is MSVC's.
"""

from __future__ import annotations

import argparse
import importlib.util
import json
import os
import platform
import shutil
import subprocess
import sys
import time
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
DEMO_DIR = Path(__file__).resolve().parent
CACHE = DEMO_DIR / ".cache"
SUITE_TIMEOUT = 1800
BUILD_TIMEOUT = 1800
C_FLAGS = "-fgnuc-version=4.7.0 -Wno-incompatible-pointer-types"
# Prefixes of the algorithm groups the x86_64 default leaves out.
X86_64_SLOW = ("Rsa", "Dh", "Dsa")


def setup_module():
    spec = importlib.util.spec_from_file_location("symcrypt_setup", DEMO_DIR / "setup.py")
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def badc_path() -> Path:
    p = REPO_ROOT / "target" / "release" / "badc"
    if not p.is_file():
        sys.exit(f"smoke: badc not built at {p} -- run `cargo build --release --features full`")
    return p


def build_jobs() -> int:
    """One job per CPU, bounded by 2 GB of available memory per job: the
    unit test's C++ units each take about that much under g++."""
    jobs = os.cpu_count() or 1
    try:
        for line in Path("/proc/meminfo").read_text().splitlines():
            if line.startswith("MemAvailable:"):
                jobs = min(jobs, max(1, int(line.split()[1]) // (2 * 1024 * 1024)))
    except OSError:
        pass
    return int(os.environ.get("BADC_SYMCRYPT_JOBS", jobs))


def run_logged(cmd: list[str], log: Path, timeout: int, env=None, cwd=None) -> int:
    with open(log, "w") as f:
        try:
            return subprocess.run(cmd, stdout=f, stderr=subprocess.STDOUT, env=env, cwd=cwd,
                                  timeout=timeout).returncode
        except subprocess.TimeoutExpired:
            f.write(f"\nsmoke: timed out after {timeout}s\n")
            return 124


def first_errors(log: Path, limit: int = 20) -> list[str]:
    lines = log.read_text(errors="replace").splitlines()
    hits = [line for line in lines if "error" in line.lower() and not line.startswith("[")]
    return (hits or lines[-limit:])[:limit]


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("-v", "--verbose", action="store_true")
    args = p.parse_args(argv)
    if sys.platform != "linux":
        print("symcrypt smoke skipped (Linux only)")
        return 0
    arch = platform.machine()
    if arch not in ("x86_64", "aarch64"):
        print(f"symcrypt smoke skipped ({arch} is not a badc target)")
        return 0
    for tool in ("cmake",):
        if shutil.which(tool) is None:
            sys.exit(f"smoke: `{tool}` not found")
    cxx = os.environ.get("CXX") or shutil.which("c++") or shutil.which("g++")
    if not cxx:
        sys.exit("smoke: no C++ compiler (c++ / g++) for the unit test")
    badc = badc_path()
    setup = setup_module()
    if setup.main(["-v"] if args.verbose else []) != 0:
        sys.exit("smoke: setup.py failed")
    src = CACHE / setup.SRC_DIRNAME

    # A fresh tree every run: CMake does not rebuild objects when the
    # compiler binary changes, so a kept tree would test an older badc.
    build = CACHE / f"build-{arch}"
    if build.exists():
        shutil.rmtree(build)
    build.mkdir(parents=True)
    env = dict(os.environ, SYMCRYPT_BRANCH=f"v{setup.VERSION}",
               SYMCRYPT_COMMIT_HASH=setup.UPSTREAM_SHA[:7],
               SYMCRYPT_COMMIT_TIMESTAMP=setup.COMMIT_TIMESTAMP)
    asm = "ON" if arch == "aarch64" else "OFF"
    generator = ["-G", "Ninja"] if shutil.which("ninja") else []
    configure = ["cmake", "-S", str(src), "-B", str(build), *generator,
                 f"-DCMAKE_C_COMPILER={badc}", f"-DCMAKE_CXX_COMPILER={cxx}",
                 "-DCMAKE_BUILD_TYPE=Release", f"-DSYMCRYPT_USE_ASM={asm}",
                 "-DSYMCRYPT_STACK_PROTECTION=OFF", "-DSYMCRYPT_FIPS_BUILD=OFF",
                 "-DSYMCRYPT_BUILD_MODULES=OFF", "-DSYMCRYPT_SYMCRUST=OFF",
                 "-DSYMCRYPT_UNIT_TESTS=ON", f"-DCMAKE_C_FLAGS={C_FLAGS}"]
    t0 = time.monotonic()
    if run_logged(configure, build / "configure.log", 600, env=env) != 0:
        print("\n".join(first_errors(build / "configure.log")), file=sys.stderr)
        sys.exit("smoke: cmake configure failed")
    units = [e for e in json.loads((build / "compile_commands.json").read_text())
             if e["file"].endswith(".c")]
    foreign = [e["file"] for e in units if not e["command"].startswith(str(badc))]
    if not units or foreign:
        sys.exit(f"smoke: {len(foreign)} of {len(units)} C units are not compiled by badc")
    jobs = build_jobs()
    if run_logged(["cmake", "--build", str(build), "-j", str(jobs)], build / "build.log",
                  BUILD_TIMEOUT, env=env) != 0:
        print("\n".join(first_errors(build / "build.log")), file=sys.stderr)
        sys.exit("smoke: build failed")
    built = time.monotonic() - t0

    test = [str(build / "exe" / "symcryptunittest"), "noperftests"]
    full = os.environ.get("BADC_SYMCRYPT_TESTS") == "all"
    if arch == "x86_64" and not full:
        test += [f"-{group}" for group in X86_64_SLOW]
    t0 = time.monotonic()
    rc = run_logged(test, build / "unittest.log", SUITE_TIMEOUT, cwd=build)
    ran = time.monotonic() - t0
    out = (build / "unittest.log").read_text(errors="replace")
    if rc != 0 or "...SymCrypt unit test done" not in out:
        print("\n".join(out.splitlines()[-40:]), file=sys.stderr)
        sys.exit(f"smoke: symcryptunittest failed (rc {rc}); log {build / 'unittest.log'}")
    scope = "all algorithms" if full or arch != "x86_64" else \
        "all but " + ", ".join(X86_64_SLOW)
    print(f"symcrypt {setup.VERSION} ({arch}, asm {asm.lower()}): {len(units)} C units by "
          f"badc, built in {built:.0f}s with {jobs} jobs; unit test ({scope}) passed in "
          f"{ran:.0f}s")
    print("symcrypt smoke OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())

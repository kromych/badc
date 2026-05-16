#!/usr/bin/env python3
"""End-to-end smoke for badc against the full BearSSL 0.6 src/ tree.

Builds every .c file under demos/bearssl/src + the hand-written
driver and the upstream test/test_crypto.c through badc, in the
per-TU and archive flavours (-O / no-O each). Returns 0 on success,
non-zero with a diagnostic on failure.

Two driver stages:

- The bundled smoke_main.c: SHA-256 / SHA-224 known-answers
  (FIPS 180-2), HMAC-SHA-256 (RFC 4231 test case 1), HKDF-SHA-256
  (RFC 5869 test case 1).
- The upstream test/test_crypto.c run against a whitelisted set
  of fast KAT suites covering hashes, MACs, KDFs, DRBGs, the
  TLS PRF, ChaCha20 and Poly1305. The slower AES / DES KAT
  loops are tracked under TODO and excluded.

Amalgamation is intentionally skipped: BearSSL reuses `static`
table names (e.g. `C255_P`) across files, which collide when
concatenated into a single TU. Per-TU compilation respects the
C99 6.2.2 internal-linkage scope and links cleanly.

Override the badc binary via the ``BADC`` env var (default:
``target/release/badc[.exe]`` next to the repo root).
"""

from __future__ import annotations

import importlib.util
import os
import subprocess
import sys
import tempfile
from pathlib import Path

BEAR_DIR = Path(__file__).resolve().parent
REPO_ROOT = BEAR_DIR.parent.parent

_tu_spec = importlib.util.spec_from_file_location(
    "_tu_build", BEAR_DIR.parent / "_tu_build.py"
)
_tu_build = importlib.util.module_from_spec(_tu_spec)
_tu_spec.loader.exec_module(_tu_build)
WIN = sys.platform == "win32"
EXE_SUFFIX = ".exe" if WIN else ""

# Disable the Win32 CryptoAPI seeder in src/rand/sysrng.c: it
# pulls in `<wincrypt.h>` types and functions (HCRYPTPROV,
# PROV_RSA_FULL, CryptAcquireContext, ...) that c5's ambient
# Windows headers do not surface. The portable PRNGs still build
# and the smoke / KAT drivers never call br_prng_seeder_system,
# so the disabled codepath has no behavioural effect on the
# tests. The override is a no-op on POSIX, where BR_USE_URANDOM
# carries the runtime path. TODO: add a wincrypt.h surface to
# the c5 headers so this can come back on Windows.
BUILD_DEFINES: tuple[str, ...] = (
    "BR_USE_WIN32_RAND=0",
)
INCLUDE_PATHS = (
    BEAR_DIR / "inc",
    BEAR_DIR / "src",
)

def _collect_lib_sources() -> tuple[str, ...]:
    # setup.py extracts the upstream src/ tree on demand, so this
    # walk is deferred until main() has staged the files.
    src_root = BEAR_DIR / "src"
    rels: list[str] = []
    for path in sorted(src_root.rglob("*.c")):
        rels.append(str(path.relative_to(BEAR_DIR)))
    return tuple(rels)


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    candidates = []
    if env:
        candidates.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    candidates.extend([default, default.with_suffix(".exe")])
    for cand in candidates:
        if cand.is_file() and os.access(cand, os.X_OK):
            return cand
    print(
        f"smoke: BADC binary not found / not executable\n"
        f"       hint: cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml",
        file=sys.stderr,
    )
    sys.exit(2)


EXPECTED_PREFIXES = (
    "hash OK [sha256-abc]:",
    "hash OK [sha224-abc]:",
    "mac OK [hmac-sha256]:",
    "kdf OK [hkdf-sha256]:",
    "bearssl smoke: all scenarios green",
)

# Whitelisted suites from test/test_crypto.c. The full set takes
# minutes (AES_big / DES_tab iterate over thousands of vectors),
# so the smoke only runs the fast portable suites covering
# hashes, MACs, KDFs, DRBGs, the TLS PRF, ChaCha20 and Poly1305.
KAT_SUITES = (
    "MD5",
    "SHA1",
    "SHA224",
    "SHA256",
    "SHA384",
    "SHA512",
    "MD5_SHA1",
    "multihash",
    "HMAC",
    "HKDF",
    "HMAC_DRBG",
    "AESCTR_DRBG",
    "PRF",
    "ChaCha20_ct",
    "Poly1305_ctmul",
    "Poly1305_ctmul32",
    "Poly1305_i15",
)
KAT_EXPECTED_LINES = len(KAT_SUITES)


def run_and_check(label: str, smoke_bin: Path) -> bool:
    proc = subprocess.run(
        [str(smoke_bin)],
        capture_output=True,
        text=True,
        check=False,
    )
    out = proc.stdout.replace("\r", "")
    err = proc.stderr.replace("\r", "")
    if proc.returncode != 0:
        print(
            f"smoke FAIL [{label}]: exit {proc.returncode}\n--- stdout ---\n{out}\n--- stderr ---\n{err}",
            file=sys.stderr,
        )
        return False
    lines = out.splitlines()
    if len(lines) != len(EXPECTED_PREFIXES):
        print(
            f"smoke FAIL [{label}]: expected {len(EXPECTED_PREFIXES)} output lines, got {len(lines)}\n{out}",
            file=sys.stderr,
        )
        return False
    for i, prefix in enumerate(EXPECTED_PREFIXES):
        if not lines[i].startswith(prefix):
            print(
                f"smoke FAIL [{label}]: line {i+1}: {lines[i]!r} does not start with {prefix!r}",
                file=sys.stderr,
            )
            return False
    print(f"smoke OK [{label}]: {len(EXPECTED_PREFIXES) - 1} scenarios green")
    return True


def run_kat_and_check(label: str, kat_bin: Path) -> bool:
    proc = subprocess.run(
        [str(kat_bin), *KAT_SUITES],
        capture_output=True,
        text=True,
        check=False,
    )
    out = proc.stdout.replace("\r", "")
    err = proc.stderr.replace("\r", "")
    if proc.returncode != 0 or err.strip():
        print(
            f"smoke FAIL [{label}]: exit {proc.returncode}\n--- stdout ---\n{out}\n--- stderr ---\n{err}",
            file=sys.stderr,
        )
        return False
    done_lines = [ln for ln in out.splitlines() if ln.endswith("done.")]
    if len(done_lines) != KAT_EXPECTED_LINES:
        print(
            f"smoke FAIL [{label}]: expected {KAT_EXPECTED_LINES} `done.` lines, got {len(done_lines)}\n{out}",
            file=sys.stderr,
        )
        return False
    print(f"smoke OK [{label}]: {KAT_EXPECTED_LINES} KAT suites green")
    return True


def main() -> int:
    badc = resolve_badc()

    subprocess.run(
        [sys.executable, str(BEAR_DIR / "setup.py")],
        check=True,
    )

    lib_sources = _collect_lib_sources()
    if not lib_sources:
        print("smoke FAIL: no .c sources under demos/bearssl/src", file=sys.stderr)
        return 1

    with tempfile.TemporaryDirectory(prefix="bearssl-smoke-") as work_str:
        work = Path(work_str)

        tu_noopt = work / f"bearssl_smoke.tu{EXE_SUFFIX}"
        tu_opt = work / f"bearssl_smoke.tu.opt{EXE_SUFFIX}"
        srcs = [BEAR_DIR / name for name in lib_sources] + [
            BEAR_DIR / "smoke_main.c"
        ]
        (work / "tu").mkdir(exist_ok=True)
        try:
            _tu_build.build_tu_separate(
                badc, srcs, tu_noopt, optimize=False,
                defines=BUILD_DEFINES, include_paths=INCLUDE_PATHS,
                work_dir=work / "tu",
            )
        except subprocess.CalledProcessError:
            print("smoke FAIL: TU build (no -O) failed", file=sys.stderr)
            return 1
        try:
            _tu_build.build_tu_separate(
                badc, srcs, tu_opt, optimize=True,
                defines=BUILD_DEFINES, include_paths=INCLUDE_PATHS,
                work_dir=work / "tu",
            )
        except subprocess.CalledProcessError:
            print("smoke FAIL: TU build (-O) failed", file=sys.stderr)
            return 1

        ar_noopt = work / f"bearssl_smoke.ar{EXE_SUFFIX}"
        ar_opt = work / f"bearssl_smoke.ar.opt{EXE_SUFFIX}"
        lib_srcs = [BEAR_DIR / name for name in lib_sources]
        driver_srcs = [BEAR_DIR / "smoke_main.c"]
        (work / "ar").mkdir(exist_ok=True)
        try:
            _tu_build.build_tu_archive(
                badc, lib_srcs, driver_srcs, "bearssl", ar_noopt,
                optimize=False, defines=BUILD_DEFINES,
                include_paths=INCLUDE_PATHS, work_dir=work / "ar",
            )
        except subprocess.CalledProcessError:
            print("smoke FAIL: archive build (no -O) failed", file=sys.stderr)
            return 1
        try:
            _tu_build.build_tu_archive(
                badc, lib_srcs, driver_srcs, "bearssl", ar_opt,
                optimize=True, defines=BUILD_DEFINES,
                include_paths=INCLUDE_PATHS, work_dir=work / "ar",
            )
        except subprocess.CalledProcessError:
            print("smoke FAIL: archive build (-O) failed", file=sys.stderr)
            return 1

        # Upstream test/test_crypto.c driver: link the same
        # archive against the upstream KAT harness and run a
        # whitelisted set of fast suites.
        kat_bin = work / f"bearssl_test_crypto{EXE_SUFFIX}"
        kat_driver = [BEAR_DIR / "test" / "test_crypto.c"]
        (work / "kat").mkdir(exist_ok=True)
        try:
            _tu_build.build_tu_archive(
                badc, lib_srcs, kat_driver, "bearssl", kat_bin,
                optimize=False, defines=BUILD_DEFINES,
                include_paths=INCLUDE_PATHS, work_dir=work / "kat",
            )
        except subprocess.CalledProcessError:
            print("smoke FAIL: test_crypto archive build failed", file=sys.stderr)
            return 1

        ok = True
        ok &= run_and_check("tu-no-O", tu_noopt)
        ok &= run_and_check("tu--O", tu_opt)
        ok &= run_and_check("ar-no-O", ar_noopt)
        ok &= run_and_check("ar--O", ar_opt)
        ok &= run_kat_and_check("upstream-test_crypto", kat_bin)
        return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

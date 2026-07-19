#!/usr/bin/env python3
"""Fetch libdill (structured concurrency in C) from upstream github.

Pins the head of `sustrik/libdill@master` by full commit SHA and
verifies a sha256 before extraction; the tree lands under
``demos/libdill/.cache/libdill-<sha>/``.

After extraction two source patches are applied so badc can build the
coroutine core; each is an exact-match string replacement and the
tree is re-extracted on every run, so the result is deterministic:

  1. ``dill_setsp`` gains an explicit one-instruction asm sp move
     under ``DILL_BADC_SETSP``. The build uses upstream's own
     ``DILL_ARCH_FALLBACK`` knob for the sigsetjmp context switch --
     TODO(badc): the x86-64 asm path needs the `%=` template escape,
     `lea <label>(%rip), reg`, explicit-register memory operands
     (`8(%%rdx)`), `.cfi_*` directives inside templates, and the
     multi-alternative `"rax"` constraint -- but the fallback's own
     alloca-based sp move cannot work either: badc's alloca draws
     from a fixed 8 KiB frame arena and traps (brk #1) beyond it.
     The asm move parks sp 64 bytes below the aligned stack top; badc
     wraps a spilled asm operand in a 16-byte sp-relative block and
     unwinds it after the asm, and the gap keeps that unwind and the
     first frame inside the new stack.
  2. ``dill_prologue`` hands the resumption context out through array
     decay (`*(void **)jb = (void *)ctx->r->ctx`). TODO(badc): the
     upstream form `*jb = &ctx->r->ctx` -- a store of an array's
     address through `sigjmp_buf **` -- is silently dropped (the
     parameter is even reported unused), leaving the caller's context
     pointer uninitialized.

Without -DDILL_BADC_SETSP the patched tree builds with gcc/clang
exactly as upstream does; the cr.c change is form-equivalent for any
compiler.

Idempotent: safe to call from CI before each smoke run. Output is
suppressed unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
import urllib.request
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

UPSTREAM_SHA = "32d0e8b733416208e0412a56490332772bc5c6e1"  # sustrik/libdill @ master
URL = f"https://github.com/sustrik/libdill/archive/{UPSTREAM_SHA}.tar.gz"
SHA256 = "a883a38d4073f43612b3221f908428ce9f663f940e5dd89c8dfad14058890380"
SRC_DIRNAME = f"libdill-{UPSTREAM_SHA}"

SETSP_STOCK = """#define dill_setsp(x) \\
    dill_unoptimisable = alloca((char*)alloca(sizeof(size_t)) - (char*)(x));
#endif"""

SETSP_BADC = """#if defined DILL_BADC_SETSP
#include <stdint.h>
#if defined __x86_64__
#define dill_setsp(x) \\
    asm volatile("mov %0, %%rsp" : : "r"((void*)(((uintptr_t)(x) & ~(uintptr_t)15) - 64)));
#elif defined __aarch64__
#define dill_setsp(x) \\
    asm volatile("mov sp, %0" : : "r"((void*)(((uintptr_t)(x) & ~(uintptr_t)15) - 64)));
#else
#error "DILL_BADC_SETSP: unsupported architecture"
#endif
#else
#define dill_setsp(x) \\
    dill_unoptimisable = alloca((char*)alloca(sizeof(size_t)) - (char*)(x));
#endif
#endif"""

PATCHES = (
    ("libdill.h", SETSP_STOCK, SETSP_BADC),
    (
        "cr.c",
        "    *jb = &ctx->r->ctx;",
        "    *(void **)jb = (void *)ctx->r->ctx;",
    ),
)


def apply_patches(src: Path, log) -> None:
    for name, old, new in PATCHES:
        p = src / name
        text = p.read_text()
        if old not in text:
            sys.exit(f"setup: patch anchor not found in {p}:\n{old[:120]}")
        p.write_text(text.replace(old, new, 1))
        log(f"patched {name}")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    cache = Path(__file__).resolve().parent / ".cache"
    cache.mkdir(parents=True, exist_ok=True)
    tar_path = cache / f"libdill-{UPSTREAM_SHA[:8]}.tar.gz"

    if not (tar_path.is_file() and _fetch.sha256_of(tar_path) == SHA256):
        log(f"fetching {URL}")
        with _fetch._urlopen_retry(
            lambda: urllib.request.urlopen(URL)
        ) as resp, tar_path.open("wb") as out:
            shutil.copyfileobj(resp, out)
        actual = _fetch.sha256_of(tar_path)
        if actual != SHA256:
            tar_path.unlink(missing_ok=True)
            sys.exit(f"sha256 mismatch on {URL}: expected {SHA256}, got {actual}")

    src = cache / SRC_DIRNAME
    if src.exists():
        shutil.rmtree(src)
    log("extracting")
    with tarfile.open(tar_path, "r:gz") as tf:
        tf.extractall(cache)
    if not (src / "libdill.h").is_file():
        sys.exit(f"setup: expected {src}/libdill.h after extraction")

    apply_patches(src, log)
    log(f"done -- {src}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

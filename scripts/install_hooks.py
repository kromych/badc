#!/usr/bin/env python3
"""Wire the committed git hooks into `.git/hooks/`.

Run once per fresh checkout. Re-running is idempotent: existing
symlinks are replaced.
"""

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path

HOOKS = ["pre-push", "post-commit"]


def main() -> int:
    out = subprocess.run(
        ["git", "rev-parse", "--show-toplevel"],
        check=True,
        capture_output=True,
        text=True,
    )
    root = Path(out.stdout.strip())
    src_dir = root / "scripts" / "git-hooks"
    dst_dir = root / ".git" / "hooks"
    dst_dir.mkdir(parents=True, exist_ok=True)

    for name in HOOKS:
        src = src_dir / name
        dst = dst_dir / name
        if not src.is_file():
            print(f"{src} missing", file=sys.stderr)
            return 1
        if dst.is_symlink() or dst.exists():
            dst.unlink()
        os.symlink(src, dst)
        src.chmod(src.stat().st_mode | 0o111)
        print(f"installed: {dst} -> {src}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

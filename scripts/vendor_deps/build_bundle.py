#!/usr/bin/env python3
"""Build the vendor-deps release bundle for badc demos.

Demos that pull a third-party library (miniz, kissfft, bzip2,
sqlite3) fetch the upstream archive on first use. CI hitting
the upstream hosts directly turned out to be flaky -- see the
`RemoteDisconnected` failures on macos runners. To fix that we
mirror the upstream archives once on a `kromych/badc` GitHub
release and have each `setup.py` pull from that single URL,
verifying a pinned sha256 before unpacking.

This script is the one-shot that produces the assets:

  - download every upstream archive into a working directory,
  - resolve the upstream commit SHA (or Fossil hash for sqlite)
    so each filename embeds enough provenance to retrace where
    it came from,
  - compute the sha256 of each archive,
  - write a manifest.json next to the assets, and
  - print the `gh release create` command to upload them.

Run it locally when bumping a library version, then upload the
output and bump the matching constants in each demo's
`setup.py`. CI itself does NOT run this script -- it only ever
fetches the already-uploaded assets.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import subprocess
import sys
import urllib.request
from dataclasses import dataclass
from pathlib import Path

DEFAULT_RELEASE_TAG = "vendor-deps-v1"
DEFAULT_REPO = "kromych/badc"


@dataclass
class Source:
    name: str
    version: str
    url: str
    ext: str
    upstream_sha: str
    sha_kind: str  # "git" or "fossil"

    @property
    def asset_name(self) -> str:
        return f"{self.name}-{self.version}-{self.upstream_sha[:8]}{self.ext}"


SOURCES = [
    Source(
        name="miniz",
        version="3.1.1",
        url="https://github.com/richgel999/miniz/releases/download/3.1.1/miniz-3.1.1.zip",
        ext=".zip",
        upstream_sha="d10b03cc73475af673df40f06e5cefd1d5f940d9",
        sha_kind="git",
    ),
    Source(
        name="kissfft",
        version="131.2.0",
        url="https://github.com/mborgerding/kissfft/archive/refs/tags/131.2.0.zip",
        ext=".zip",
        upstream_sha="7bce4153c6bc8aba2db0e889e576f9d00505cbe1",
        sha_kind="git",
    ),
    Source(
        name="bzip2",
        version="1.0.8",
        url="https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz",
        ext=".tar.gz",
        upstream_sha="6a8690fc8d26c815e798c588f796eabe9d684cf0",
        sha_kind="git",
    ),
    Source(
        name="sqlite-amalgamation",
        version="3530000",
        url="https://www.sqlite.org/2026/sqlite-amalgamation-3530000.zip",
        ext=".zip",
        upstream_sha="4525003a53a7fc63ca75c59b22c79608659ca12f0131f52c18637f829977f20b",
        sha_kind="fossil",
    ),
    Source(
        # stb is a collection of single-file public-domain headers
        # with no versioned releases -- pin to a commit instead.
        # Version uses the commit's author date so the asset name
        # carries enough provenance to retrace a bump.
        name="stb",
        version="20260415",
        url="https://github.com/nothings/stb/archive/31c1ad37456438565541f4919958214b6e762fb4.zip",
        ext=".zip",
        upstream_sha="31c1ad37456438565541f4919958214b6e762fb4",
        sha_kind="git",
    ),
    Source(
        # chibicc -- Rui Ueyama's small self-hosting C compiler.
        # No versioned releases; the project's last commit on `main`
        # is the canonical "release". Version embeds the commit's
        # author date for provenance.
        name="chibicc",
        version="20201207",
        url="https://github.com/rui314/chibicc/archive/90d1f7f199cc55b13c7fdb5839d1409806633fdb.zip",
        ext=".zip",
        upstream_sha="90d1f7f199cc55b13c7fdb5839d1409806633fdb",
        sha_kind="git",
    ),
    Source(
        # tinycc -- Fabrice Bellard's TCC, pinned to the `mob` branch
        # because the last release tag (release_0_9_27, 2017). Version
        # embeds the commit's author date.
        name="tinycc",
        version="20260513",
        url="https://github.com/TinyCC/tinycc/archive/757507eb022f7af4be63dc9a72b299761181efbb.zip",
        ext=".zip",
        upstream_sha="757507eb022f7af4be63dc9a72b299761181efbb",
        sha_kind="git",
    ),
    Source(
        # TweetNaCl -- the auditable NaCl implementation. Upstream
        # ships only `tweetnacl.c` + `tweetnacl.h` on a static web
        # page, no tarball, no VCS. Pinned by the sha256 of
        # `tweetnacl.c` (the canonical content identifier); the
        # mirror wraps the two files in a single tar.gz so each
        # demo can fetch with one URL and one sha256.
        name="tweetnacl",
        version="20140427",
        url="https://tweetnacl.cr.yp.to/20140427/tweetnacl.c",
        ext=".tar.gz",
        upstream_sha="02e65bc3013ff2168983365e55906bc783c4c7e0a60d8100f17bb303a17175c4",
        sha_kind="content-sha256",
    ),
    Source(
        # MonoCypher -- modern auditable crypto in two files (plus
        # an optional SHA-512 + RFC 8032 Ed25519 module). The
        # upstream sha is the sha256 of the released tarball
        # itself (github does not expose a stable commit sha for
        # the tag download).
        name="monocypher",
        version="4.0.2",
        url="https://github.com/LoupVaillant/Monocypher/archive/refs/tags/4.0.2.tar.gz",
        ext=".tar.gz",
        upstream_sha="bc1ca30b1b2654e4e7daf2492c0d204200e55137f23fda6b7142fd7d523bd6b4",
        sha_kind="tarball-sha256",
    ),
    Source(
        # BearSSL -- full TLS 1.0-1.2 stack in portable C99. The
        # vendored archive is the upstream `bearssl-0.6.tar.gz`;
        # the demo extracts a focused hash / MAC / KDF subset.
        name="bearssl",
        version="0.6",
        url="https://bearssl.org/bearssl-0.6.tar.gz",
        ext=".tar.gz",
        upstream_sha="6705bba1714961b41a728dfc5debbe348d2966c117649392f8c8139efc83ff14",
        sha_kind="tarball-sha256",
    ),
    Source(
        # CPython 3.14.6 source distribution from www.python.org.
        # Pinned by the sha256 of the released .tgz (the vendored asset
        # is that file renamed to the `name-version-sha8` convention).
        name="python",
        version="3.14.6",
        url="https://www.python.org/ftp/python/3.14.6/Python-3.14.6.tgz",
        ext=".tar.gz",
        upstream_sha="74d0d71d0600e477651a077101d6e62d1e2e69b8e992ba18c993dd643b7ba222",
        sha_kind="tarball-sha256",
    ),
    Source(
        # Lua 5.5.0 -- the interpreter source distribution from
        # www.lua.org. Pinned by the sha256 of the released tarball
        # (Lua is published as standalone tarballs, with no public
        # VCS or commit identifier).
        name="lua",
        version="5.5.0",
        url="https://www.lua.org/ftp/lua-5.5.0.tar.gz",
        ext=".tar.gz",
        upstream_sha="57ccc32bbbd005cab75bcc52444052535af691789dba2b9016d5c50640d68b3d",
        sha_kind="tarball-sha256",
    ),
    Source(
        # curl 8.11.1 -- HTTP client library. Standalone release
        # tarball from curl.se with no VCS identifier in the download
        # name, so pinned by the tarball sha256.
        name="curl",
        version="8.11.1",
        url="https://curl.se/download/curl-8.11.1.tar.gz",
        ext=".tar.gz",
        upstream_sha="a889ac9dbba3644271bd9d1302b5c22a088893719b72be3487bc3d401e5c4e80",
        sha_kind="tarball-sha256",
    ),
    Source(
        # Lua 5.5.0 official test suite -- published as a separate
        # tarball at www.lua.org/tests/. Same pin model as the
        # interpreter source: sha256 of the tarball.
        name="lua-tests",
        version="5.5.0",
        url="https://www.lua.org/tests/lua-5.5.0-tests.tar.gz",
        ext=".tar.gz",
        upstream_sha="5e47bbfad7db2965d69580e918ee64edeb8d8d32de404b8dae9ce5c6d76a1472",
        sha_kind="tarball-sha256",
    ),
    Source(
        # Tcl 8.6.14 -- the interpreter source distribution from
        # SourceForge. Published as a standalone tarball with no public
        # commit identifier, so it is pinned by the tarball sha256. The
        # distribution carries its own `tests/` directory (the suite the
        # demo runs), so no separate test asset is needed.
        name="tcl",
        version="8.6.14",
        url="https://prdownloads.sourceforge.net/tcl/tcl8.6.14-src.tar.gz",
        ext=".tar.gz",
        upstream_sha="5880225babf7954c58d4fb0f5cf6279104ce1cd6aa9b71e9a6322540e1c4de66",
        sha_kind="tarball-sha256",
    ),
    Source(
        # QuickJS -- Fabrice Bellard's JavaScript engine. No versioned
        # release tarball; pin to the github commit. Version embeds the
        # release date from the upstream VERSION file for provenance.
        name="quickjs",
        version="20260604",
        url="https://github.com/bellard/quickjs/archive/3d5e064e9dd67c70f7962836505a7fa067bf0a4e.tar.gz",
        ext=".tar.gz",
        upstream_sha="3d5e064e9dd67c70f7962836505a7fa067bf0a4e",
        sha_kind="git",
    ),
]


def fetch(url: str, dst: Path, log) -> None:
    log(f"fetching {url}")
    with urllib.request.urlopen(url) as resp, dst.open("wb") as out:
        shutil.copyfileobj(resp, out)


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument(
        "--out",
        default="vendor-deps-bundle",
        help="output directory for the assets + manifest (default: ./vendor-deps-bundle)",
    )
    p.add_argument(
        "--tag",
        default=DEFAULT_RELEASE_TAG,
        help=f"release tag to print in the upload command (default: {DEFAULT_RELEASE_TAG})",
    )
    p.add_argument(
        "--repo",
        default=DEFAULT_REPO,
        help=f"GitHub repo for the upload command (default: {DEFAULT_REPO})",
    )
    p.add_argument("-v", "--verbose", action="store_true")
    args = p.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    out_dir = Path(args.out).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)

    manifest: dict[str, dict[str, str]] = {}
    asset_paths: list[Path] = []

    for src in SOURCES:
        asset = out_dir / src.asset_name
        if asset.is_file():
            log(f"already present: {asset.name}")
        else:
            fetch(src.url, asset, log)
        digest = sha256_of(asset)
        manifest[src.name] = {
            "asset": src.asset_name,
            "version": src.version,
            "upstream_sha": src.upstream_sha,
            "upstream_sha_kind": src.sha_kind,
            "upstream_url": src.url,
            "sha256": digest,
        }
        asset_paths.append(asset)
        print(f"{src.asset_name}  sha256={digest}")

    manifest_path = out_dir / "manifest.json"
    manifest_path.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n")
    print(f"\nmanifest -> {manifest_path}")

    rel_paths = " \\\n    ".join(str(p) for p in asset_paths + [manifest_path])
    print(
        "\nUpload with:\n"
        f"  gh release create {args.tag} \\\n"
        f"    --repo {args.repo} \\\n"
        f'    --title "vendor deps for demo smokes" \\\n'
        '    --notes "Mirror of upstream miniz / kissfft / bzip2 / sqlite '
        "amalgamation archives. Filenames embed upstream version + short "
        "commit/fossil SHA. sha256 of each asset is in manifest.json and "
        "pinned in each demo's setup.py.\" \\\n"
        f"    {rel_paths}\n"
        f"\nIf the tag already exists use `gh release upload {args.tag} --repo {args.repo} --clobber <files>` instead."
    )

    if shutil.which("gh") is None:
        print(
            "\n(note: `gh` was not found on PATH -- install GitHub CLI to run the upload command)",
            file=sys.stderr,
        )
    else:
        # Light hint that the user is logged in -- doesn't auto-upload, just diagnostics.
        try:
            subprocess.run(
                ["gh", "auth", "status"],
                check=True,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
        except subprocess.CalledProcessError:
            print(
                "(note: `gh auth status` failed -- run `gh auth login` before the upload command above)",
                file=sys.stderr,
            )

    return 0


if __name__ == "__main__":
    sys.exit(main())

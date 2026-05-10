"""Fetch a vendor-deps release asset with optional token auth.

Used by `demos/<lib>/setup.py`. Single source of truth for the
download path because the token handling has security
implications: the token is only sent to `api.github.com` over
TLS, never echoed in error messages, and never persisted.

Two paths:

  * `GITHUB_TOKEN` (or `GH_TOKEN`) is set -- look the asset up
    by name on the tagged release, then `GET` its api.github.com
    asset URL with `Accept: application/octet-stream`. GitHub
    answers with a 302 to a short-lived signed CDN URL; urllib
    follows that for us. Works for private and public repos.
  * No token -- hit the public
    `https://github.com/<repo>/releases/download/<tag>/<name>`
    URL anonymously. Works once the repo is public; while the
    repo is private GitHub returns 404 to anyone unauthenticated
    (it does not distinguish 401 from 404 to avoid leaking
    repo existence).

CI sets `GITHUB_TOKEN` automatically (the per-job token); local
contributors export their own gh token only when the repo is
private.
"""

from __future__ import annotations

import hashlib
import json
import os
import shutil
import sys
import urllib.error
import urllib.request
from pathlib import Path
from typing import Callable

REPO = "kromych/badc"


def _token() -> str | None:
    """Read the auth token from env. Never log or echo this."""
    return os.environ.get("GITHUB_TOKEN") or os.environ.get("GH_TOKEN")


def _open(url: str, *, accept: str | None = None):
    """urlopen with optional token auth + Accept header."""
    req = urllib.request.Request(url)
    tok = _token()
    if tok:
        req.add_header("Authorization", f"token {tok}")
    if accept:
        req.add_header("Accept", accept)
    return urllib.request.urlopen(req)


def _api_asset_url(release_tag: str, asset_name: str) -> str:
    """Look up an asset's api.github.com URL by name on a tagged release."""
    api = f"https://api.github.com/repos/{REPO}/releases/tags/{release_tag}"
    with _open(api, accept="application/vnd.github+json") as resp:
        release = json.load(resp)
    for asset in release.get("assets", []):
        if asset["name"] == asset_name:
            return asset["url"]
    sys.exit(f"asset {asset_name!r} not found on release {release_tag!r}")


def _download(release_tag: str, asset_name: str, dst: Path) -> None:
    """Stream the asset bytes to dst. Picks the auth or public path
    based on whether a token is in env.
    """
    if _token():
        url = _api_asset_url(release_tag, asset_name)
        opener = lambda: _open(url, accept="application/octet-stream")
    else:
        public = (
            f"https://github.com/{REPO}/releases/download/{release_tag}/{asset_name}"
        )
        opener = lambda: urllib.request.urlopen(public)
    try:
        with opener() as resp, dst.open("wb") as out:
            shutil.copyfileobj(resp, out)
    except urllib.error.HTTPError as e:
        if e.code == 404 and not _token():
            sys.exit(
                f"download failed: HTTP 404 on {asset_name}. The badc repo is "
                "private, so anonymous GitHub release downloads return 404. "
                "Export a token with `export GITHUB_TOKEN=$(gh auth token)` "
                "and re-run."
            )
        raise


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def fetch_and_verify(
    release_tag: str,
    asset_name: str,
    dst: Path,
    expected_sha256: str,
    log: Callable[[str], None] = lambda _msg: None,
) -> None:
    """Ensure dst contains <asset_name> from <release_tag> with the
    expected sha256. A pre-existing matching file is reused; a
    pre-existing mismatching file is deleted and refetched. On
    final hash mismatch the partial file is deleted and the
    process exits with a clear error.
    """
    if dst.is_file() and sha256_of(dst) == expected_sha256:
        return
    if dst.is_file():
        log(f"stale archive at {dst}, refetching")
        dst.unlink()
    log(f"fetching {asset_name}")
    _download(release_tag, asset_name, dst)
    actual = sha256_of(dst)
    if actual != expected_sha256:
        dst.unlink(missing_ok=True)
        sys.exit(
            f"sha256 mismatch on {asset_name}: expected {expected_sha256}, got {actual}"
        )

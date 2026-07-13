# vendor-deps bundle

Demos that pull a third-party library (`miniz`, `kissfft`,
`bzip2`, `sqlite3`, `stb`, `chibicc`, `tinycc`, `tweetnacl`,
`monocypher`, `bearssl`, `lua`, `curl`) fetch the upstream
archive on first use. CI hitting the upstream hosts directly
was flaky -- transient
`RemoteDisconnected` failures from the GitHub release CDN and
sourceware.org. To stop those, the upstream archives are
mirrored once on a `kromych/badc` GitHub release and each
demo's `setup.py` pulls from that single URL with a pinned
sha256 verified before extraction.

## Asset naming

```
<name>-<upstream-version>-<upstream-sha-short>.<ext>
```

`upstream-sha-short` is the first 8 hex chars of the upstream
project's identifier for the release:

| library    | source                                  | sha kind        |
|------------|-----------------------------------------|-----------------|
| miniz      | github richgel999/miniz tag commit      | git             |
| kissfft    | github mborgerding/kissfft tag commit   | git             |
| bzip2      | sourceware.org bzip2 release commit     | git             |
| sqlite     | `SQLITE_SOURCE_ID` Fossil release hash  | fossil          |
| stb        | github nothings/stb pinned commit       | git             |
| chibicc    | github rui314/chibicc last `main` commit| git             |
| tinycc     | github TinyCC/tinycc `mob` HEAD commit  | git             |
| tweetnacl  | tweetnacl.cr.yp.to static `.c` page     | content-sha256  |
| monocypher | github LoupVaillant/Monocypher tag      | tarball-sha256  |
| bearssl    | bearssl.org release tarball             | tarball-sha256  |
| lua        | lua.org source + test-suite tarballs    | tarball-sha256  |
| curl       | curl.se release tarball                 | tarball-sha256  |
| qemu       | git v11.0.2 tag; bundle assembled off   | git (assembled) |

The full sha is recorded in `manifest.json` and in each
demo's `setup.py` constants (`UPSTREAM_SHA`).

## QEMU bundle (assembled)

`qemu` is the one asset that is not a plain upstream archive.
QEMU's build is driven by meson, which generates a large tree of
headers and sources that is not reproducible off-box, so the
demo needs that generated config captured alongside the source.
`build_qemu_bundle.py` assembles the bundle from a configured
QEMU build directory: it trims the source (dropping the git
history, test suite, docs, ROM/firmware blobs, and meson
subprojects -- none are compile inputs) and captures the
meson-generated build inputs (`compile_commands.json`, the
`*.rsp` response files, and every generated `*.h`/`*.c`/`*.inc`/
`*.def`). See that script's header for the per-target capture +
`--pack` flow. Pin the packed asset's sha256 in
`demos/qemu/setup.py` and upload it to the release. `manifest.json`
does not track it (it is not produced by `build_bundle.py`).

## Refreshing the bundle

When bumping a library version (or rotating the bundle for
any reason):

1. Update the `Source` entry in `build_bundle.py` (URL,
   version, upstream SHA) for the lib that changed.
2. Run `python3 scripts/vendor_deps/build_bundle.py -v`. It
   downloads each archive, computes sha256, writes
   `vendor-deps-bundle/manifest.json`, and prints the
   `gh release` command to upload the assets.
3. Run that printed `gh release` command. The default tag is
   `vendor-deps-v1`; bump to `vendor-deps-v2` if you want a
   clean cut without `--clobber`-ing the existing assets, and
   pass `--tag vendor-deps-v2` to the script in step 2 so the
   printed command matches.
4. Update each demo's `setup.py` to point at the new asset:
   - `VERSION`, `UPSTREAM_SHA`, `SHA256` (and `RELEASE_TAG`
     if you cut a new tag in step 3).
   The `ASSET` and `URL` constants are derived from those.
5. Commit + push. CI fetches from the new release on the
   next run.

Local `setup.py` runs use the same code path: cached
archives in `demos/<lib>/.cache/` are reused on a sha256
hit, refetched on a miss.

## Auth model (`_fetch.py`)

Each demo's `setup.py` calls into `_fetch.py`, which has two
download paths:

* **`GITHUB_TOKEN` / `GH_TOKEN` set** -- look the asset up by
  name on the tagged release via `api.github.com`, then GET its
  asset URL with `Accept: application/octet-stream`. GitHub
  redirects to a short-lived signed CDN URL; urllib follows.
  Works for private and public repos.
* **No token** -- hit the public
  `https://github.com/<repo>/releases/download/<tag>/<name>`
  URL anonymously. Works once the repo is public; while the
  repo is private GitHub returns 404 to anyone unauthenticated
  (it does not distinguish 401 from 404 to avoid leaking repo
  existence).

The token is only ever sent to `api.github.com` over TLS,
never echoed in error messages, never persisted. CI's
auto-provisioned `secrets.GITHUB_TOKEN` is mapped into env in
`.github/workflows/ci.yml`; once the repo is public that
mapping (and any local `export GITHUB_TOKEN=$(gh auth token)`)
becomes unnecessary, and external contributors can run the
smokes without ever touching a token.

Local cheat-sheet for a private-repo run:

```sh
export GITHUB_TOKEN=$(gh auth token)
python3 demos/sqlite3/smoke.py    # or any other demo's smoke
```

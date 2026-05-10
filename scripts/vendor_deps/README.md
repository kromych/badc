# vendor-deps bundle

Demos that pull a third-party library (`miniz`, `kissfft`,
`bzip2`, `sqlite3`) fetch the upstream archive on first use.
CI hitting the upstream hosts directly was flaky -- transient
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

| library | source                                 | sha kind |
|---------|----------------------------------------|----------|
| miniz   | github richgel999/miniz tag commit     | git      |
| kissfft | github mborgerding/kissfft tag commit  | git      |
| bzip2   | gitlab bzip2-org/bzip2 tag commit      | git      |
| sqlite  | `SQLITE_SOURCE_ID` Fossil release hash | fossil   |

The full sha is recorded in `manifest.json` and in each
demo's `setup.py` constants (`UPSTREAM_SHA`).

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

# curl

badc compiles the [curl](https://curl.se) 8.11.1 library from source and
builds it three ways -- a static archive, a shared library, and an executable
that links against each -- plus a fourth flavour that links a badc-compiled
client against the platform's **installed** libcurl to prove the frontend
matches the OS ABI.

The vendored library is trimmed to no external dependencies: HTTP, `file://`,
and the WebSocket / URL / multi / easy APIs, with the threaded resolver and
IPv6 on. HTTPS is provided by [BearSSL](../bearssl) when the TLS lane is built
(`USE_BEARSSL`); the system-libcurl flavour gets HTTPS from the OS's own TLS
backend. The other protocols (FTP, SMTP, LDAP, ...) are compiled out via the
`CURL_DISABLE_*` set.

## Layout

`setup.py` fetches the pinned tarball (vendor-deps mirror, falling back to
`curl.se`) and drops curl's `lib/` tree in `src/` and the public headers in
`include/curl/`. Committed alongside:

* `curl_config.h` -- the hand-written build configuration (curl normally
  generates this from configure/CMake). Describes exactly the POSIX surface
  badc ships on macOS and Linux; Windows uses curl's own `lib/config-win32.h`.
* `curl_client.c` -- the driver: version / feature reporting, the URL API,
  escape round-tripping, the string list, a `file://` transfer, and -- when a
  base URL is passed -- an `http(s)://` fetch used by the loopback test.
* `curl_syslink.h` -- `#pragma dylib` / `#pragma binding` bindings for the
  system-libcurl flavour.

## Build flavours

The smoke builds every flavour at `-O0` and `-O`:

* **static** -- `badc --ar` bundles the objects into `libcurl.a`; the driver
  links it with `-L/-l`.
* **shared** -- `badc --shared --export-all` produces `libcurl.{dylib,so,dll}`;
  the driver binds to it through a generated `#pragma` header.
* **system** -- the driver binds to the installed libcurl through
  `curl_syslink.h`. macOS resolves `/usr/lib/libcurl.4.dylib` from the dyld
  shared cache; Linux uses the `libcurl.so.4` soname. Skipped where absent
  (Windows ships no redistributable libcurl).

## Running

```sh
cargo build --release --manifest-path Cargo.toml
python3 demos/curl/smoke.py
```

Each built driver runs the offline scenarios plus a `file://` transfer and an
`http://` transfer against a loopback HTTP server the harness starts on
`127.0.0.1` -- no external network, so it is deterministic under CI.

# curl

badc compiles the [curl](https://curl.se) 8.23.0 library from source and
builds it three ways -- a static archive, a shared library, and an executable
that links against each -- plus a fourth flavor that links a badc-compiled
client against the platform's **installed** libcurl to prove the frontend
matches the OS ABI.

The vendored library is trimmed to no external dependencies: HTTP, `file://`,
and the WebSocket / URL / multi / easy APIs, with the threaded resolver and
IPv6 on. HTTPS is provided by [Mbed TLS](https://github.com/Mbed-TLS/mbedtls)
3.6, compiled by badc in its default configuration, when the TLS lane is built
(`USE_MBEDTLS`); the system-libcurl flavor gets HTTPS from the OS's own TLS
backend. The other protocols (FTP, SMTP, LDAP, ...) are compiled out via the
`CURL_DISABLE_*` set.

## Layout

`setup.py` fetches the pinned tarballs from the vendor-deps mirror and drops
curl's `lib/` tree in `src/`, the public headers in `include/curl/`, and Mbed
TLS's `library/` and `include/` trees in `mbedtls/`. Committed alongside:

* `curl_config.h` -- the hand-written build configuration (curl normally
  generates this from configure/CMake). Describes exactly the POSIX surface
  badc ships on macOS and Linux, and takes `curl_config_win32.h` on Windows.
* `curl_config_win32.h` -- the values curl's CMake build takes for mingw-w64
  (`CMake/win32-cache.cmake`); curl's own `lib/config-win32.h` serves MSVC
  2010-2013 only.
* `_mingw.h`, `afunix.h` -- stand-ins for the mingw-w64 headers curl includes
  under `__MINGW32__`, which the smoke defines on Windows so `curl/system.h`
  takes its LLP64 branch.
* `curl_client.c` -- the driver: version / feature reporting, the URL API,
  escape round-tripping, the string list, a `file://` transfer, and -- when a
  base URL is passed -- an `http(s)://` fetch used by the loopback test.
* `curl_syslink.h` -- `#pragma dylib` / `#pragma binding` bindings for the
  system-libcurl flavor.

## Build flavors

The smoke builds every flavor at `-O0` and `-O`:

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
`127.0.0.1` -- no external network, so it is deterministic under CI. The TLS
lane fetches over `https://` from the same server behind a throwaway
self-signed certificate made with `openssl` (on Windows the one Git for
Windows installs), on every target.

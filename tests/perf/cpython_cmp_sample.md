## CPython build comparison (linux-x64)

| compiler | compile (s) | .text (KiB) | .data (KiB) | .bss (KiB) | file (KiB) | bench (ms) |
|---|--:|--:|--:|--:|--:|--:|
| badc no-O | 8.3 | 8170 | 5079 | 360 | 14885 | 2241.993 |
| badc -O | 23.6 | 8058 | 4698 | 484 | 14083 | FAIL |
| clang no-O | 23.6 | 7188 | 3618 | 261 | 13631 | 1451.948 |
| clang -O | 48.0 | 3248 | 3391 | 261 | 8967 | 56.176 |

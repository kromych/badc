#!/bin/bash
set -u
cd /Users/krom/src/compilers/badc
export TMPDIR=/var/tmp
mkdir -p /var/tmp
for d in monocypher tweetnacl bearssl miniz bzip2 kissfft stb chibicc lua tinycc sqlite3; do
    if [ -f demos/$d/smoke.py ]; then
        echo "=== $d ==="
        if timeout 600 python3 demos/$d/smoke.py 2>&1 | tail -25 | grep -E "smoke OK|FAIL|mismatch|error|Error|Traceback"; then
            :
        else
            echo "(no error lines)"
        fi
    fi
done

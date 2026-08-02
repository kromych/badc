#!/usr/bin/env python3
"""Probe helper: wrap an assembly snippet (file or literal) into file-scope asm."""
import sys
from pathlib import Path


def cstr(text):
    out = []
    for ch in text:
        if ch == "\\":
            out.append("\\\\")
        elif ch == '"':
            out.append('\\"')
        elif ch == "\n":
            out.append("\\n")
        elif ch == "\t":
            out.append("\\t")
        elif ord(ch) < 32 or ord(ch) > 126:
            out.append("\\%03o" % ord(ch))
        else:
            out.append(ch)
    return "".join(out)


body = Path(sys.argv[1]).read_text()
Path(sys.argv[2]).write_text('__asm__("' + cstr(body) + '");\n')

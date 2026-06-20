#!/usr/bin/env python3
"""Distill a self-describing all-builtin manifest from a CPython all-static
build: the `make -n python` link gives the authoritative object list; the trace
gives each object's compile command. Archives (bundled libmpdec/expat) are
resolved to their objects; sources are deduped (shared HACL helpers appear once)
with per-TU defines + extra includes."""
import shlex, json, sys

trace_path, pylink_path, out_manifest = sys.argv[1:4]
COMMON_INC = {'Include', 'Include/internal', '.', 'Include/internal/mimalloc'}

def norm(p):
    return p.lstrip("./")

def norm_inc(tok):
    return norm(tok[2:]) or "."

text = open(trace_path, errors="replace").read().replace("\\\n", " ")
compiles = {}   # obj -> (src, defines, extra_includes)
archives = {}   # archive -> [obj]
for line in text.splitlines():
    s = line.strip()
    if not s:
        continue
    try:
        toks = shlex.split(s)
    except ValueError:
        continue
    if not toks:
        continue
    base0 = toks[0].split("/")[-1]
    if base0 in ("ar", "libtool") or base0.startswith("libtool"):
        a = [t for t in toks if t.endswith(".a")]
        objs = [norm(t) for t in toks if t.endswith(".o")]
        if a and objs:
            archives[norm(a[0])] = objs
        continue
    if base0 in ("gcc", "cc", "clang", "clang++", "g++") and "-c" in toks:
        src = [t for t in toks if t.endswith(".c")]
        obj = [toks[i + 1] for i, t in enumerate(toks)
               if t == "-o" and i + 1 < len(toks) and toks[i + 1].endswith(".o")]
        if src and obj:
            D = [t[2:] for t in toks if t.startswith("-D") and t != "-DNDEBUG"]
            xinc = [norm_inc(t) for t in toks if t.startswith("-I") and norm_inc(t) not in COMMON_INC]
            compiles[norm(obj[0])] = (norm(src[-1]), D, xinc)

ptoks = shlex.split(open(pylink_path).read())
link_objs = [norm(t) for t in ptoks if t.endswith(".o")]
link_archives = [norm(t) for t in ptoks if t.endswith(".a")]

all_objs, seen_obj = [], set()
for o in link_objs:
    if o not in seen_obj:
        seen_obj.add(o); all_objs.append(o)
for a in link_archives:
    if a not in archives:
        print(f"WARN unresolved archive {a}", file=sys.stderr); continue
    for o in archives[a]:
        if o not in seen_obj:
            seen_obj.add(o); all_objs.append(o)

manifest, bysrc, missing = [], {}, []
for o in all_objs:
    if o not in compiles:
        missing.append(o); continue
    src, D, xinc = compiles[o]
    cls = "builtin" if "Py_BUILD_CORE_BUILTIN" in D else "core"
    D = [d for d in D if d not in ("Py_BUILD_CORE", "Py_BUILD_CORE_BUILTIN", "Py_BUILD_CORE_MODULE")]
    if src not in bysrc:
        bysrc[src] = {"src": src, "class": cls, "defines": D, "includes": xinc}
manifest = list(bysrc.values())
# getbuildinfo.c's GIT* defines come from shell command substitution the trace
# captured unexpanded; the build identity is not reproduced here.
for m in manifest:
    if m["src"].endswith("getbuildinfo.c"):
        m["defines"] = ['GITVERSION=""', 'GITTAG=""', 'GITBRANCH=""']
# getpath.c builds via a recipe that shells out to _freeze_module and spans
# multiple lines, so it is not captured as a plain compile. Its install-layout
# defines are a build configuration, not derived; getpath.h is a fetched frozen
# module. Inject it explicitly.
if "Modules/getpath.c" not in bysrc:
    manifest.append({"src": "Modules/getpath.c", "class": "core", "includes": [],
                     "defines": ['PREFIX="/usr/local"', 'EXEC_PREFIX="/usr/local"',
                                 'PLATLIBDIR="lib"', 'VERSION="3.14"', 'VPATH=""',
                                 'PYTHONPATH=""', 'PYTHONFRAMEWORK=""']})
    missing = [m for m in missing if "getpath.o" not in m]
json.dump(manifest, open(out_manifest, "w"), indent=0)

n_core = sum(1 for m in manifest if m["class"] == "core")
n_builtin = len(manifest) - n_core
print(f"link .o={len(link_objs)} archives={link_archives}")
print(f"manifest srcs={len(manifest)} (core={n_core} builtin={n_builtin}) missing_compile={len(missing)}")
if missing:
    print("MISSING:", missing[:25])
for key in ("mathmodule", "_decimal/_decimal.c", "expat/xmlparse", "_hacl/Hacl_Hash_SHA2", "Modules/getpath.c"):
    hit = next((m for m in manifest if key in m["src"]), None)
    if hit:
        print(f"  {hit['src']}  class={hit['class']}  D={hit['defines'][:4]}  I={hit['includes']}")

#!/usr/bin/env python3
"""Clone edk2's complete GCC5 toolchain tag as BADC, overriding the X64 and
AARCH64 CCs to the badc cc-shims (LTO dropped, EFI compat header force-
included). SLINK/DLINK/GenFw/NASM stay GCC5's tools -- badc is the compiler;
the linker/image-gen stay standard for this rung."""
import re, sys
# argv: <tools_def.txt> <x64-shim> <aarch64-shim> <compat-header-path>
conf, x64_shim, aarch64_shim, compat = sys.argv[1:5]
shims = {"X64": x64_shim, "AARCH64": aarch64_shim}
lines = open(conf).read().splitlines()
badc = []
for ln in lines:
    if 'GCC5' not in ln or ln.lstrip().startswith('#'):
        continue
    b = ln.replace('GCC5', 'BADC')
    # badc-ify the X64 / AARCH64 CC paths; leave every other tool as the
    # standard GCC5 one (copied verbatim under the BADC name so build finds it).
    m = re.search(r'_BADC_(X64|AARCH64)_CC_PATH\b', b)
    if m:
        b = re.sub(r'=\s*.*$', f'= {shims[m.group(1)]}', b)
    if re.search(r'_BADC_(X64|IA32_X64|AARCH64)_(CC|DLINK|DLINK2)_FLAGS\b', b) or \
       re.search(r'DEFINE BADC_(X64|IA32_X64|AARCH64)_(CC|DLINK)_FLAGS\b', b):
        b = b.replace('-flto', '').replace('-DUSING_LTO', '')
    if re.search(r'_BADC_(X64|AARCH64)_CC_FLAGS\b', b) or \
       re.search(r'DEFINE BADC_(X64|AARCH64)_CC_FLAGS\b', b):
        b += f' -include {compat}'
    badc.append(b)
open(conf, 'a').write('\n\n' + '\n'.join(badc) + '\n')
print(f'cloned {len(badc)} GCC5 lines as BADC')

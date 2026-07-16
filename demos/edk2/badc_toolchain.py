#!/usr/bin/env python3
"""Clone edk2's complete GCC5 toolchain tag as BADC, overriding only the
X64 CC to the badc cc-shim (LTO dropped, EFI compat header force-included).
SLINK/DLINK/GenFw/NASM stay GCC5's tools -- badc is the compiler; the
linker/image-gen stay standard for this rung."""
import re, sys
conf, shim = sys.argv[1], sys.argv[2]
lines = open(conf).read().splitlines()
badc = []
for ln in lines:
    if 'GCC5' not in ln or ln.lstrip().startswith('#'):
        continue
    b = ln.replace('GCC5', 'BADC')
    # Only badc-ify X64 CC; leave every other tool as the standard GCC5 one
    # (they are copied verbatim under the BADC name so build.py finds them).
    if re.search(r'_BADC_X64_CC_PATH\b', b):
        b = re.sub(r'=\s*.*$', f'= {shim}', b)
    if re.search(r'_BADC_(X64|IA32_X64)_(CC|DLINK|DLINK2)_FLAGS\b', b) or \
       re.search(r'DEFINE BADC_(X64|IA32_X64)_(CC|DLINK)_FLAGS\b', b):
        b = b.replace('-flto', '').replace('-DUSING_LTO', '')
    if re.search(r'_BADC_X64_CC_FLAGS\b', b) or re.search(r'DEFINE BADC_X64_CC_FLAGS\b', b):
        b += ' -include /tmp/badc_efi_compat.h'
    badc.append(b)
open(conf, 'a').write('\n\n' + '\n'.join(badc) + '\n')
print(f'cloned {len(badc)} GCC5 lines as BADC')

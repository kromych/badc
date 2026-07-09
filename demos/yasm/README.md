# yasm demo

Builds the [yasm](https://yasm.tortall.net/) 1.3.0 modular assembler with badc.

yasm is a larger, more modular assembler than NASM (a core library plus
pluggable arch / parser / preprocessor / object-format / debug-format
modules). Its build derives several C sources at build time -- the C
generators (genstring / genmacro / genperf / genmodule / genversion) and, for
the x86 instruction tables, the Python `modules/arch/x86/gen_x86_insn.py`.

## Self-hosting angle

`smoke.py` runs that Python table generator under the **badc-built CPython**
(the python demo): a badc-built interpreter generates the x86 tables that a
badc-built assembler is then compiled from.

## Run

```sh
cargo build --release --features full          # build badc
python3 demos/yasm/setup.py                     # fetch the yasm source
python3 demos/yasm/smoke.py                      # build with badc + test
```

## What the smoke does (POSIX targets)

1. Build CPython with badc and stage it in a temp directory.
2. No `make`, no `./configure`: install a frozen config, build yasm's C
   generators (genperf/genmacro/genstring/genversion/genmodule + the bundled
   re2c) with badc, run `gen_x86_insn.py` under the badc-python, and run the
   generators to derive yasm's C sources.
3. Recompile yasm's translation units (a frozen manifest, `config/tu-list.txt`)
   with badc, archive the library, and link `yasm` with badc's own linker.
4. Build a reference `yasm` from the same sources with the host cc, then
   assemble a mixed-instruction fixture with both in each object format and
   require byte-identical output.

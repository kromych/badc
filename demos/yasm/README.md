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
2. `./configure PYTHON=<badc-python>` + `make`: the C generators build and
   run under the host cc, `gen_x86_insn.py` runs under the badc-python, and a
   reference `yasm` is produced whose object list drives step 3.
3. Recompile each of yasm's translation units with badc, archive the library,
   and link `yasm` with badc's own linker.
4. Assemble a mixed-instruction fixture with the badc-built and reference
   `yasm` in each object format and require byte-identical output.

# Performance

Under construction.

This page will carry what CI's performance job already measures, per commit:
the compile-throughput ratios (`-O0` cost over `-O` cost, and the slowest unit
over the median one) and the QuickJS and CPython benchmark timings for each
target, with the machine each run landed on.

The series that carry meaning across runs are the ratios taken within one run
-- badc against clang on the same machine -- since the hosted runners differ
enough that absolute times report which machine a commit ran on more than they
report the compiler: the CPython badc/clang ratio spans 2.45 to 3.80 across
x86_64 runners of one batch.

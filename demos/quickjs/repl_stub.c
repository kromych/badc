// qjs.c references a `qjsc_repl` bytecode blob that upstream generates from
// repl.js with the `qjsc` bytecode compiler during its own build. The badc
// smoke runs the test suite through the C interpreter and never enters the
// interactive REPL, so an empty blob satisfies the link without building
// qjsc. `qjsc_repl_size == 0` keeps qjs from trying to evaluate it.
#include <stdint.h>
const uint8_t qjsc_repl[1] = {0};
const uint32_t qjsc_repl_size = 0;

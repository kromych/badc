/* `sizeof(<expr>)` runs the regular parser to learn the type
 * of the operand, then drops the emitted bytecode so the
 * operand is never evaluated at runtime (C99 6.5.3.4 makes
 * the operand an unevaluated context). c5 historically only
 * rewound `text` / `source_lines` / `data_imm_positions` --
 * not `fn_call_fixups`, which the parser pushes for every
 * function call so the linker can patch the JsrExt target.
 * The stale fixup pointed into the rewound text region;
 * `apply_fn_call_fixups` then wrote the call target over
 * whatever bytecode word later landed at that PC, drifting
 * the op/operand alignment and ICE'ing the codegen with
 * "bad opcode" once the scanner reached the corrupted byte.
 *
 * Repro shape: `(void)sizeof(call(arg))` followed by any
 * real bytecode. The standard NOTUSED-style macro
 *   #define NOTUSED(v) (void)sizeof(v)
 * expands a use of `v` into exactly this construct. Verify
 * both that the code compiles AND that no fixup landed on the
 * real instruction stream by exercising the surrounding
 * assignments through every call slot.
 */

static int doubled(int x) { return x * 2; }
static int summed(int a, int b) { return a + b; }
static unsigned int read_be(unsigned int hi, unsigned int lo) {
    return (hi << 16) | (lo & 0xffff);
}

static int harness(int s) {
    /* Multiple sizeof(call(...)) patterns interleaved with
     * real expressions. Each sizeof must rewind its parse
     * cleanly so the assignments below land at the right
     * bytecode PCs. */
    (void)sizeof(doubled(s));
    int a = s & 0xff;
    (void)sizeof(summed(s, s));
    int b = (s >> 8) & 0xff;
    (void)sizeof(read_be((unsigned)s, (unsigned)a));
    int c = a + b;
    /* Mixing nested calls inside sizeof too. */
    (void)sizeof(doubled(summed(a, b)));
    int d = c * 2;
    return d;
}

int main(void) {
    /* s = 0x1234 -> a=0x34, b=0x12, c=0x46, d=0x8c */
    if (harness(0x1234) != 0x8c) return 1;
    if (harness(0)      != 0)    return 2;
    if (harness(0xff00) != 0x1fe) return 3;
    return 0;
}

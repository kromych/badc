/* The arm64 bug-table shape: numeric labels defined inside pushed
 * sections recur across asm instances (each definition is its own
 * per-instance symbol), and the table holds a cross-section reference
 * into the merged string section (`.long 14472b - .`). */
static volatile int never;

static void trigger(int x)
{
    if (x)
        asm volatile("1:\tbrk #0x800\n"
            ".pushsection __bug_table,\"aw\"\n"
            ".align 2\n"
            "14470:\t.long 1b - .\n"
            ".pushsection .rodata.str,\"aMS\",@progbits,1\n"
            "14472:\t.string \"f1.c\"\n"
            ".popsection\n"
            "\t.long 14472b - .\n"
            "\t.short %c0\n"
            "\t.short 0\n"
            ".align 2\n"
            ".popsection\n" : : "i" (11));
    else
        asm volatile("1:\tbrk #0x800\n"
            ".pushsection __bug_table,\"aw\"\n"
            ".align 2\n"
            "14470:\t.long 1b - .\n"
            ".pushsection .rodata.str,\"aMS\",@progbits,1\n"
            "14472:\t.string \"f2.c\"\n"
            ".popsection\n"
            "\t.long 14472b - .\n"
            "\t.short %c0\n"
            "\t.short 0\n"
            ".align 2\n"
            ".popsection\n" : : "i" (22));
}

int main(void)
{
    if (never)
        trigger(never);
    return 0;
}

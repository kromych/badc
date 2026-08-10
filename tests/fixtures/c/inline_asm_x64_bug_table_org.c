/* The x86 bug-table shape: an `i`-operand link-time address as a
 * PC-relative section value (`.long %c0 - .`), constant operand words,
 * and `.org 2b + %c3` sizing the entry from a numeric section label. */
struct bug_entry { int bug_addr_disp; int file_disp; unsigned short line; unsigned short flags; };
static volatile int never;

static void trigger(void)
{
    asm volatile("1:\tud2\n"
        ".pushsection __bug_table,\"aw\"\n"
        "2:\t.long 1b - .\n"
        "\t.long %c0 - .\n"
        "\t.word %c1\n"
        "\t.word %c2\n"
        "\t.org 2b+%c3\n"
        ".popsection\n"
        : : "i" (__FILE__), "i" (__LINE__), "i" (0),
            "i" (sizeof(struct bug_entry)));
}

int main(void)
{
    if (never)
        trigger();
    return 0;
}

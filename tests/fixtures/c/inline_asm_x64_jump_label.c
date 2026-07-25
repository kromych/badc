/* The jump-label shape: an `asm goto` whose pushed section stores the
 * label's text offset (`.long %l[l_yes] - .`) and the key address with
 * a constant addend (`.quad %c0 + %c1 - .`). */
struct static_key { int enabled; };
static struct static_key key;

static inline __attribute__((always_inline)) int arch_static_branch(void)
{
    asm goto("1:"
        "jmp %l[l_yes]\n\t"
        ".pushsection __jump_table, \"aw\" \n\t"
        ".balign 8 \n\t"
        ".long 1b - . \n\t"
        ".long %l[l_yes] - . \n\t"
        ".quad %c0 + %c1 - .\n\t"
        ".popsection \n\t"
        : : "i" (&key), "i" (0) : : l_yes);
    return 2;
l_yes:
    return 0;
}

int main(void) { return arch_static_branch(); }

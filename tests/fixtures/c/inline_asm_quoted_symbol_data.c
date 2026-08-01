/* A double-quoted symbol name in a data directive: GNU as accepts
 * `.quad "name"` wherever the bare spelling is valid, referencing the
 * symbol (not string data). The addressable-record shape: the section
 * collects symbol addresses and is discarded from an executable. */

long external_key;

int record(int v) {
    __asm__(".pushsection .discard.addressable,\"aw\"\n"
            ".balign 8\n"
            ".quad \"external_key\"\n"
            ".quad external_key\n"
            ".popsection\n" : : : "memory");
    return v + 1;
}

int main(void) {
    if (record(20) != 21)
        return 1;
    return 42;
}

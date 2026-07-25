/* `.incbin "path"` in a named section embeds the file's raw bytes at
 * that point in the section image; the path resolves against the
 * compile working directory, as GNU as resolves it against the
 * assembler's. The embedded-config shape. */
asm(".pushsection .rodata, \"a\"\n"
    ".ascii \"CFG_ST\"\n"
    ".global config_data\n"
    "config_data:\n"
    ".incbin \"tests/fixtures/c/file_scope_asm_incbin.bin\"\n"
    ".global config_data_end\n"
    "config_data_end:\n"
    ".ascii \"CFG_ED\"\n"
    ".popsection");

int main(void) { return 0; }

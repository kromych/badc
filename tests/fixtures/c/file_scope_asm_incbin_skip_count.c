/* `.incbin "path", skip, count` embeds `count` bytes of the file from
 * offset `skip`; `.incbin "path", skip` the rest of it from there, as GNU
 * as does. The file holds "INCBIN-PAYLOAD-01". Returns 0 when both
 * slices hold the expected bytes. */
asm(".pushsection .rodata, \"a\"\n"
    ".global slice_start\n"
    "slice_start:\n"
    ".incbin \"tests/fixtures/c/file_scope_asm_incbin.bin\", 7, 7\n"
    ".global tail_start\n"
    "tail_start:\n"
    ".incbin \"tests/fixtures/c/file_scope_asm_incbin.bin\", 15\n"
    ".global tail_end\n"
    "tail_end:\n"
    ".popsection");

/* The labels as the asm spells them, on targets that prefix C names too. */
extern const char slice_start[] __asm__("slice_start");
extern const char tail_start[] __asm__("tail_start");
extern const char tail_end[] __asm__("tail_end");

int main(void) {
    static const char slice[] = "PAYLOAD";
    for (int i = 0; i < 7; i++)
        if (slice_start[i] != slice[i])
            return 1 + i;
    if (tail_start != slice_start + 7)
        return 10;
    if (tail_end - tail_start != 2 || tail_start[0] != '0' || tail_start[1] != '1')
        return 11;
    return 0;
}

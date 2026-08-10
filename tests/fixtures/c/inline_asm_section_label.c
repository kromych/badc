/* A label defined inside a named section of a file-scope `asm()` becomes a
 * symbol in that section at its offset within it, so C can name the data the
 * template laid out. `.globl` gives the label external binding; without it
 * the label binds locally (object-level checks live in the linker tests). */

int marked = 7;

asm(".section \".fixture_table\",\"a\"\n"
    ".globl fixture_entry\n"
    "fixture_entry:\n"
    "\t.asciz \"tag\"\n"
    "\t.balign 8\n"
    "\t.quad marked\n"
    ".globl fixture_tail\n"
    "fixture_tail:\n"
    "\t.long 99\n"
    ".previous\n");

extern const char fixture_entry[];
extern const char fixture_tail[];

int main(void) {
    /* The label sits at the section's start: the `.asciz` payload. */
    if (fixture_entry[0] != 't' || fixture_entry[1] != 'a' || fixture_entry[2] != 'g')
        return 1;
    if (fixture_entry[3] != 0)
        return 2;
    /* The second label is 16 bytes in: 4 bytes of string padded to 8, then
     * the 8-byte pointer field. */
    if (fixture_tail - fixture_entry != 16)
        return 3;
    if (*(const int *)fixture_tail != 99)
        return 4;
    /* The `.quad` field holds the address of the C object it named. */
    if (*(int *const *)(fixture_entry + 8) != &marked)
        return 5;
    if (**(int *const *)(fixture_entry + 8) != 7)
        return 6;
    return 42;
}

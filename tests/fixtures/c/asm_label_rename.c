/* GNU asm-label rename: `decl asm("name")` sets the assembler symbol name
 * the declaration emits. The identifier keeps its own identity -- it stays
 * the only spelling the source may use and the lookup key a redeclaration
 * matches -- so the rename composes with the storage classes and attributes
 * without changing what the C code means. */

int renamed_fn(void) __asm__("badc_real_fn");
int renamed_fn(void) { return 11; }

static int renamed_static(void) __asm__("badc_real_static");
static int renamed_static(void) { return 22; }

int renamed_weak(void) __asm__("badc_real_weak") __attribute__((weak));
int renamed_weak(void) { return 33; }

int renamed_hidden(void) __asm__("badc_real_hidden")
    __attribute__((visibility("hidden")));
int renamed_hidden(void) { return 55; }

int renamed_sect(void) __asm__("badc_real_sect")
    __attribute__((section(".text.badc_rename")));
int renamed_sect(void) { return 88; }

int renamed_obj __asm__("badc_real_obj") = 44;
int renamed_arr[3] __asm__("badc_real_arr") = { 1, 2, 3 };
int renamed_bss __asm__("badc_real_bss");

/* An `alias` names the target's assembler symbol, so it takes the label
 * rather than the identifier. */
int alias_fn(void) __attribute__((alias("badc_real_fn")));

/* A static initializer against a renamed object. */
int *renamed_ptr __asm__("badc_real_ptr") = &renamed_obj;

/* Repeating the same label is an ordinary redeclaration. */
int renamed_fn(void) __asm__("badc_real_fn");

/* A rename on a declaration that follows the definition still renames the
 * symbol the unit emits: the label belongs to the entity, not to one
 * declaration of it. */
static int late_named(void) { return 77; }
static int late_named(void) __asm__("badc_real_late");

static int block_scope(void)
{
    /* Static storage duration at block scope carries a label too. */
    static int q __asm__("badc_real_blk_q") = 66;
    /* So does a block-scope prototype of an external function. */
    int renamed_fn(void) __asm__("badc_real_fn");
    return q + renamed_fn();
}

int main(void)
{
    if (renamed_fn() != 11)
        return 1;
    if (renamed_static() != 22)
        return 2;
    if (renamed_weak() != 33)
        return 3;
    if (renamed_hidden() != 55)
        return 4;
    if (renamed_sect() != 88)
        return 12;
    if (renamed_obj != 44)
        return 5;
    if (renamed_arr[0] != 1 || renamed_arr[1] != 2 || renamed_arr[2] != 3)
        return 6;
    if (renamed_bss != 0)
        return 7;
    if (alias_fn() != 11)
        return 8;
    if (*renamed_ptr != 44)
        return 9;
    if (late_named() != 77)
        return 10;
    if (block_scope() != 77)
        return 11;
    return 0;
}

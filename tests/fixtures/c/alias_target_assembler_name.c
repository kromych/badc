/* `alias("name")` names its target by assembler name (gcc: the target is
 * the assembler symbol), so an alias of a static function renamed by an
 * asm label spells the label. The alias keeps the renamed definition: a
 * weak alias, whose own symbol carries no entry, through its target's
 * name, and a strong alias as well. */

static int weak_impl(void) __asm__("badc_alias_weak_impl");
static int weak_impl(void) { return 9; }
int weak_name(void) __attribute__((weak, alias("badc_alias_weak_impl")));

static int strong_impl(void) __asm__("badc_alias_strong_impl");
static int strong_impl(void) { return 11; }
int strong_name(void) __attribute__((alias("badc_alias_strong_impl")));

int main(void) {
    int (*volatile fp)(void) = weak_name;
    if (!fp)
        return 1;
    if (fp() != 9)
        return 2;
    fp = strong_name;
    if (fp() != 11)
        return 3;
    if (weak_name() + strong_name() != 20)
        return 4;
    return 0;
}

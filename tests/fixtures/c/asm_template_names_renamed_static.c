/* A static function renamed by an asm label and named only by an inline
 * asm template, which spells its assembler name. The function has no C
 * reference: badc keeps a definition an asm template names (gcc's
 * contract asks for `used` here), and the template's address must be
 * the unit's own definition. */

static int renamed(void) __asm__("badc_template_named_target");
static int renamed(void) { return 7; }

static void *address_by_name(void) {
    void *p;
#if defined(__aarch64__)
    __asm__("adr %x0, badc_template_named_target" : "=r"(p));
#elif defined(__x86_64__)
    __asm__("lea badc_template_named_target(%%rip), %0" : "=r"(p));
#else
    p = 0;
#endif
    return p;
}

int main(void) {
    void *p = address_by_name();
    if (!p)
        return 1;
    if (((int (*)(void))p)() != 7)
        return 2;
    return 0;
}

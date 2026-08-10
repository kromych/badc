/* `__attribute__((alias("target")))` where the target is defined later in
 * the translation unit. Resolution is retried once the unit is complete, so
 * the declarator's position relative to the definition does not matter, and
 * calls emitted before the definition still reach it.
 */

static int calls;

/* Alias declared before its target, and called before it too. */
void probe(int n) __attribute__((weak, alias("probe_generic")));

static int call_early(void)
{
    probe(1);
    return calls;
}

void probe_generic(int n)
{
    calls += n;
}

/* Object alias whose target is defined later. */
extern const int table_alias __attribute__((alias("table_real")));
const int table_real = 41;

/* An alias to a target defined earlier still works. */
int after(void) { return 5; }
int after_alias(void) __attribute__((alias("after")));

int main(void)
{
    if (call_early() != 1) return 1;

    probe(2);
    if (calls != 3) return 2;

    probe_generic(4);
    if (calls != 7) return 3;

    /* The alias reads the target's storage. The address-identity check is
     * left out: compilers differ on whether they fold a comparison between
     * two declarations that share an address. */
    if (table_alias != 41) return 4;

    if (after_alias() != 5) return 5;

    return 0;
}

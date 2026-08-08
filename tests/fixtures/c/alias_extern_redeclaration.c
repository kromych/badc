/* An `extern` declaration carrying `alias("target")` defines the name at
 * the target's storage. A later no-initializer redeclaration of the name
 * (`extern typeof(x) x;` precedes the kernel's export annotations) denotes
 * that definition; it must not allocate fresh storage or detach the name
 * from the target's bytes. */

static const unsigned fk[4] __attribute__((__aligned__(1 << 6))) = { 1, 2, 3, 4 };
extern const unsigned pub_fk[4] __attribute__((alias("fk")));

/* Redeclared after the alias definition. */
extern typeof(pub_fk) pub_fk;

/* Redeclared while the alias target is still unresolved. */
extern const int fwd_alias __attribute__((alias("fwd_real")));
extern typeof(fwd_alias) fwd_alias;
const int fwd_real = 27;

int main(void)
{
    if (pub_fk[0] != 1 || pub_fk[1] != 2 || pub_fk[2] != 3 || pub_fk[3] != 4)
        return 1;
    if (fwd_alias != 27)
        return 2;
    return 0;
}

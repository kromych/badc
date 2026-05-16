// Locks C99 6.10.3.4 "blue paint": a macro that fired during
// the pre-expansion of a function-like macro's argument must
// not re-fire when the substituted body is rescanned.
//
// The shape comes straight from real-world C code that
// declares a per-state accessor macro (`#define foo s1->foo`)
// alongside a generic iteration helper (`#define for_each(sec)
// sec->...`). Calling the helper with the accessor name as an
// argument must produce a single-level access; a missing
// blue-paint blocklist would re-fire the accessor inside the
// substituted body and double-prefix the access.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

struct Section { int data; };
struct State   { struct Section *symtab_section; };

// Initialise before defining the accessor macro -- once the
// macro is in scope, the bare field name expands to the
// `s1->...` form, so direct field assignment would not parse.
static void init(struct State *st, struct Section *sec) {
    st->symtab_section = sec;
}

#define symtab_section s1->symtab_section
#define section_data(sec) ((sec)->data)
#define section_data_plus(sec, n) ((sec)->data + (n))

// Verify the non-arg path stays unchanged: a bare `symtab_section`
// in source still expands once to `s1->symtab_section`.
static int bare(struct State *s1) {
    return symtab_section->data;
}

// Single-arg helper: arg `symtab_section` pre-expands to
// `s1->symtab_section`; the body's `(sec)->data` substitutes to
// `(s1->symtab_section)->data` with no further `symtab_section`
// expansion.
static int single(struct State *s1) {
    return section_data(symtab_section);
}

// Two-arg helper: same shape with a second un-macroed arg to
// catch a fix that over-blocks (every identifier in any arg
// gets locked out -- a literal `7` arg must not interact with
// the blue-paint set).
static int two_arg(struct State *s1) {
    return section_data_plus(symtab_section, 7);
}

int main(void) {
    struct Section sec;
    sec.data = 100;
    struct State st;
    init(&st, &sec);
    if (bare(&st) != 100) return 11;
    if (single(&st) != 100) return 12;
    if (two_arg(&st) != 107) return 13;
    return 0;
}

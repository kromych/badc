// C99 6.2.1p4: a block-scope `extern` declaration binds the name only for
// its own scope; the file-scope meaning reappears afterwards. That holds
// for the function body's outermost scope exactly as for a nested block,
// so a name that is an enumeration constant or a typedef at file scope
// still is one after the function that shadowed it.

enum { LIMIT = 3 };
typedef int alias_t;

int body_scope_extern(void) {
    extern int LIMIT;
    extern int alias_t;
    return 0;
}

int nested_scope_extern(void) {
    {
        extern int LIMIT;
        extern int alias_t;
    }
    return 0;
}

// The enumeration constant is still an integer constant expression here,
// and the typedef still names a type.
static int after[LIMIT] = { 1, 2, 3 };
static alias_t after_alias = 7;

int main(void) {
    if (body_scope_extern() != 0) return 1;
    if (nested_scope_extern() != 0) return 2;
    if (LIMIT != 3) return 3;
    if (sizeof after / sizeof after[0] != 3) return 4;
    if (after[0] + after[1] + after[2] != 6) return 5;
    if (after_alias != 7) return 6;
    if (sizeof(alias_t) != sizeof(int)) return 7;
    return 0;
}

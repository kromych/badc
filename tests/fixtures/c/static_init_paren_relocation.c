// A relocation-bearing initializer leaf -- a function or a `&global` --
// may be wrapped in redundant parentheses and casts, a real-world shape
// produced by method-table macros: `(target)(((void(*)(void))((fn))))`.
// The function pointers are exercised by calling through them, which
// resolves the code address at the call site on every execution backend;
// the data address is compared directly.

typedef int (*handler)(void *, void *);

int do_work(void *a, void *b) { return 7; }
int global_value = 99;

struct method { const char *name; handler fn; int flags; const char *doc; };

struct method table[] = {
    {"work", ((handler)(((void (*)(void))((do_work))))), 0x82, "doc"},
};

int *paddr = (&global_value);
handler pfn = ((handler)((do_work)));

int main(void) {
    if (table[0].fn(0, 0) != 7) return 1;
    if (table[0].flags != 0x82) return 2;
    if (paddr != &global_value || *paddr != 99) return 3;
    if (pfn(0, 0) != 7) return 4;
    return 0;
}

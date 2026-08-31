// C99 6.2.2: an internal-linkage definition no reachable code or data
// references is unobservable and is not emitted. A section attribute
// selects placement, not retention, so the sweep cascades through one:
// the table drops, the static functions only its initializer named drop
// with it, and the declared-never-defined symbol they called leaves no
// undefined reference behind -- this unit links only because it does.
// A kernel earlycon table takes this shape in a module build, keeping
// the section and losing `used`. `used` pins what it names.

struct entry {
    const char *name;
    int (*setup)(int);
};

// Declared, never defined: only the dropped cascade calls it.
int builtin_only_helper(int v);

static int dead_inner(int v) { return builtin_only_helper(v) + 1; }
static int dead_setup(int v) { return dead_inner(v) * 2; }
static const char dead_name[] = "dead-table-name";

static const struct entry dead_table __attribute__((unused))
    __attribute__((section(".tbl"))) = { dead_name, dead_setup };

static int used_setup(int v) { return v * 3; }

static const struct entry used_table __attribute__((used))
    __attribute__((section(".tbl"))) = { "used-table-name", used_setup };

static int live_setup(int v) { return v + 7; }
static const struct entry live_table = { "live", live_setup };

int main(void) {
    if (live_table.setup(5) != 12) return 1;
    if (live_table.name[0] != 'l' || live_table.name[4] != '\0') return 2;
    return 0;
}

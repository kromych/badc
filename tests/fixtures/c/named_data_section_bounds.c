// Objects placed in a C-identifier-named data section are grouped under that
// name, and `__start_<name>` / `__stop_<name>` bound the group, as GNU ld
// defines them, whatever objects the unit defines between them. A member
// whose bytes are all zero stays in its section rather than in `.bss`.
struct entry {
    const char *name;
    int value;
};

static int before = 1;
__attribute__((used, section("probe_set"))) static const struct entry first = {"a", 1};
static int between[4] = {2, 3, 4, 5};
__attribute__((used, section("probe_set"))) static const struct entry second = {"b", 20};
__attribute__((used, section("probe_set"))) const struct entry third = {"c", 300};
static int after;

__attribute__((used, section("probe_ints"))) int zero_member;
__attribute__((used, section("probe_ints"))) int one_member = 1;

extern const struct entry __start_probe_set[], __stop_probe_set[];
extern int __start_probe_ints[], __stop_probe_ints[];

int main(void)
{
    int sum = 0, n = 0;
    for (const struct entry *e = __start_probe_set; e < __stop_probe_set; e++, n++)
        sum += e->value + (e->name[1] == 0 ? 0 : 1000);
    if (n != 3 || sum != 321)
        return 1;
    if (__stop_probe_ints - __start_probe_ints != 2)
        return 2;
    int *z = &zero_member, *o = &one_member;
    if (z < __start_probe_ints || z >= __stop_probe_ints || o < __start_probe_ints ||
        o >= __stop_probe_ints || *z != 0 || *o != 1)
        return 3;
    return before + between[0] + after == 3 ? 0 : 4;
}

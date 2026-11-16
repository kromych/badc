// Functions placed in a C-identifier-named code section are grouped under
// that name, and `__start_<name>` / `__stop_<name>` bound the group, as GNU
// ld defines them; a function outside the section falls outside the bounds.
__attribute__((section("probe_code"), noinline)) int first(int x)
{
    return x + 1;
}

__attribute__((section("probe_code"), noinline)) int second(int x)
{
    return first(x) * 2;
}

__attribute__((noinline)) int outside(int x)
{
    return x - 1;
}

extern char __start_probe_code[], __stop_probe_code[];

static int within(int (*f)(int))
{
    char *p = (char *)f;
    return p >= __start_probe_code && p < __stop_probe_code;
}

int main(void)
{
    if (!within(first) || !within(second))
        return 1;
    if (within(outside))
        return 2;
    return second(3) == 8 && outside(1) == 0 ? 0 : 3;
}

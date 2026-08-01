// An address constant compared with a null pointer constant decides at
// translation time when the named symbol has a non-weak definition in
// this unit (C99 6.3.2.3p3, 6.5.9p6), so a guarded call to a
// never-defined helper must not reach the link at any optimization
// level -- the front-end fold GCC also performs at -O0. Value-position
// uses of the same comparisons check the decided result at runtime.

extern void absent_fn_arm(void);
extern void absent_obj_arm(void);
extern void absent_arr_arm(void);
extern void absent_not_arm(void);

static int counter = 1;
static int table[4] = {1, 2, 3, 4};

static int bump(int x) { return x + counter; }

int main(void) {
    if ((bump) == ((void *)0))
        absent_fn_arm();
    if (&counter == (int *)0)
        absent_obj_arm();
    if (table == (int *)0)
        absent_arr_arm();
    // The negated shape a compile-time assertion macro expands to.
    if (!(!((bump) == ((void *)0))))
        absent_not_arm();

    int eq = (bump) == ((void *)0);
    int ne = &counter != (int *)0;
    if (eq != 0)
        return 1;
    if (ne != 1)
        return 2;
    if (bump(2) != 3)
        return 3;
    if (table[1] != 2)
        return 4;
    return 0;
}

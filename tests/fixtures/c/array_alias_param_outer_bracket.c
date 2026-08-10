// C99 6.7.7p3 + 6.7.5.3p7: a parameter declared with brackets over an
// array typedef composes both dimension lists before the outermost one
// adjusts to a pointer. `rows_t rows[]` with `typedef struct mask
// rows_t[1]` is `struct mask (*rows)[1]`; `rows[i]` selects row i (one
// row stride) and decays to the element pointer. The kernel's
// cpumask_var_t at CONFIG_CPUMASK_OFFSTACK=n has exactly this shape.

struct mask {
    unsigned long bits[4];
};

typedef struct mask mask1_t[1];

static void clear_row(mask1_t m)
{
    m->bits[0] = 0;
    m->bits[3] = 0;
}

static unsigned long corner_sum(mask1_t rows[], unsigned n)
{
    unsigned long s = 0;
    unsigned i;

    for (i = 0; i < n; i++) {
        // rows[i] decays to `struct mask *`; both the arrow access and
        // re-passing it as a `mask1_t` parameter must type-check.
        s += rows[i]->bits[0] + rows[i]->bits[3];
    }
    return s;
}

static long row_stride(mask1_t rows[])
{
    return (char *)rows[1] - (char *)rows[0];
}

int main(void)
{
    mask1_t d[3];
    unsigned i;

    for (i = 0; i < 3; i++) {
        d[i]->bits[0] = 10 * i + 1;
        d[i]->bits[3] = 10 * i + 2;
    }
    if (corner_sum(d, 3) != 1 + 2 + 11 + 12 + 21 + 22)
        return 1;
    if (row_stride(d) != (long)sizeof(struct mask))
        return 2;
    clear_row(d[1]);
    if (d[1]->bits[0] != 0 || d[1]->bits[3] != 0)
        return 3;
    if (d[0]->bits[0] != 1 || d[2]->bits[3] != 22)
        return 4;
    if (corner_sum(d, 3) != 1 + 2 + 21 + 22)
        return 5;
    return 0;
}

// GNU transparent_union: a union parameter type accepts an argument of
// any member type, a null pointer constant included, and the callee
// reads it through the union. Behavior verified against gcc 16.
struct page { int id; };

typedef union {
    struct page **pages;
    void *raw;
} pages_arg __attribute__((__transparent_union__));

static int first_id(pages_arg arg, int have)
{
    if (!have)
        return 7;
    return arg.pages[0]->id;
}

typedef union { unsigned long v; } count_arg __attribute__((transparent_union));

static unsigned long twice(count_arg c) { return c.v * 2; }

int main(void)
{
    struct page p0 = { 40 };
    struct page *vec[1];
    pages_arg u;
    int acc = 0;

    vec[0] = &p0;
    acc += first_id(vec, 1);        /* member-typed argument */
    u.pages = vec;
    acc += first_id(u, 1);          /* the union itself */
    acc += first_id(0, 0);          /* null pointer constant */
    acc += (int)twice(3UL);         /* integer member */
    return acc - 93;                /* 40 + 40 + 7 + 6 = 93 -> exit 0 */
}

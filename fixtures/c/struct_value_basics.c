// Struct values: declarations + `.` field access. The struct
// occupies multiple 8-byte slots on the c5 stack, and the parser
// suppresses the implicit Li so the expression `s` evaluates to
// the struct's *address*. `.field` then works the same way `->`
// does on a pointer, just without the leading load.
//
// Struct-to-struct assignment (`a = b`) is still rejected -- the
// memcpy-style copy lowering belongs to the next milestone, where
// the ABI work threads through everything else that needs it
// (parameter passing, return values).

struct Point { int x; int y; };
struct Line  { struct Point *a; struct Point *b; int label; };

int main() {
    struct Point p;
    struct Point q;
    int sum;

    p.x = 3;
    p.y = 4;

    if (p.x != 3) return 1;
    if (p.y != 4) return 2;

    // Address-of works on a struct value -- the address is
    // already what `p` evaluates to inside the parser, but
    // `&p` is still a legal expression and re-derives the same
    // pointer. (`&p` lets functions accept it via `struct Point *`
    // until M6 adds by-value parameter passing.)
    {
        struct Point *pp;
        pp = &p;
        if (pp->x != 3) return 3;
        if (pp->y != 4) return 4;
        pp->x = 30;
        pp->y = 40;
    }
    if (p.x != 30) return 5;
    if (p.y != 40) return 6;

    // A second struct local sharing the same type. Both must be
    // disjoint -- writing through one mustn't touch the other.
    q.x = 100;
    q.y = 200;
    if (p.x != 30) return 7;
    if (q.x != 100) return 8;

    // Field arithmetic on multiple struct values.
    sum = p.x + p.y + q.x + q.y;       // 30 + 40 + 100 + 200 = 370
    if (sum != 370) return 9;

    return 0;
}

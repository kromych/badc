// Returns of `void` functions (C99 6.8.6.4): a fall-through, a bare
// `return`, a `return` of a void call, a void conditional operator, a cast
// to void and a self-tail-call, beside `main`, whose closing brace returns 0
// (C99 5.1.2.2.3).

typedef void nothing;

struct pair { long a, b; };

static void set_one(int *p) { *p = 1; }
static void set_two(int *p) { *p = 2; }
__attribute__((noinline)) static void bump(int *p) { *p += 1; }

void copy_pair(struct pair *dst, const struct pair *src) { *dst = *src; }

void clamp(int *p)
{
    if (*p < 0) {
        *p = 0;
        return;
    }
    *p += 1;
}

void forward(int *p) { return set_one(p); }
void pick(int c, int *p) { c ? set_one(p) : set_two(p); }
void discard(int *p) { (void)set_two(p); }
nothing through_typedef(int *p) { *p = 3; }
void call_last(int *p) { *p = 4; bump(p); }

void count_down(int n, int *p)
{
    if (n == 0)
        return;
    *p += n;
    count_down(n - 1, p);
}

int main(void)
{
    struct pair a = {1, 2}, b;
    int v = -1;
    copy_pair(&b, &a);
    clamp(&v);
    forward(&v);
    pick(v, &v);
    discard(&v);
    through_typedef(&v);
    call_last(&v);
    count_down(3, &v);
}

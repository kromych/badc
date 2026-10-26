// C99 6.7.3: a qualifier in a member's declaration, its parameter list
// included, qualifies that member, not the object the enclosing declaration
// declares with the structure type, so both objects below are writable.
// Returns 0.
static int first(const char *s) { return s[0]; }
static struct ops { int (*mk)(const char *); } ops;
struct pair { const int *p; int (*cb)(const char *s); } pair;
static const int k = 2;

int main(void) {
    ops.mk = first;
    pair.cb = first;
    pair.p = &k;
    return ops.mk("a") - 'a' + pair.cb("b") - 'b' + *pair.p - 2;
}

// A zero-sized static object (empty struct, GNU extension) still
// occupies its own slot: the object model identifies objects by start
// offset (static DCE intervals, named-section carving), so two
// distinct objects never share a start.
struct k {};
static struct k a;
static struct k b;
static struct k *pa = &a;
static struct k *pb = &b;

int main(void) {
    if (pa == pb) return 1;
    if ((void *)&a == (void *)&b) return 2;
    return 0;
}

/* C17 7.17.7.5p3: the <stdatomic.h> fetch-and-add and fetch-and-subtract of an
 * atomic pointer move it by pointees, as + and - do (6.5.6p8); the GNU
 * __atomic_fetch_add keeps its documented byte operand. */
#include <stdatomic.h>
struct big { char b[24]; };
int arr[4];
struct big bigs[4];
int main(void) {
    _Atomic(int *) p = arr;
    _Atomic(struct big *) q = bigs;
    int *raw = arr;
    atomic_int n = 5;
    if (atomic_fetch_add(&p, 1) != arr || (char *)p - (char *)arr != 4) return 1;
    atomic_fetch_add_explicit(&p, 2, memory_order_relaxed);
    if (p != arr + 3) return 2;
    if (atomic_fetch_sub(&p, 1) != arr + 3 || p != arr + 2) return 3;
    atomic_fetch_sub_explicit(&p, 2, memory_order_release);
    if (p != arr) return 4;
    atomic_fetch_add(&q, 3);
    if (q != bigs + 3) return 5;
    if (atomic_fetch_add(&n, 2) != 5 || atomic_fetch_sub(&n, 1) != 7 || n != 6) return 6;
    __atomic_fetch_add(&raw, 4, __ATOMIC_SEQ_CST);
    if ((char *)raw - (char *)arr != 4) return 7;
    p += 1;
    if (p != arr + 1) return 8;
    return 0;
}

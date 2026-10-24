// The BSD <sys/queue.h> lists and the <sys/time.h> timeval macros glibc and
// the macOS SDK both define: each list kind is built, walked forward (and
// backward where it links back), and has an element removed; timersub and
// timeradd carry across the microsecond boundary, timercmp orders, and
// timerclear zeroes what timerisset reports. glibc's SIMPLEQ and the SDK's
// removal-tolerant TAILQ_FOREACH_SAFE are checked where each is defined.
#define _DEFAULT_SOURCE 1
#include <stddef.h>
#include <sys/queue.h>
#include <sys/time.h>

struct node {
    int v;
    SLIST_ENTRY(node) s;
    LIST_ENTRY(node) l;
    STAILQ_ENTRY(node) sq;
    TAILQ_ENTRY(node) t;
    CIRCLEQ_ENTRY(node) c;
};
SLIST_HEAD(shead, node);
LIST_HEAD(lhead, node);
STAILQ_HEAD(sqhead, node);
TAILQ_HEAD(thead, node);
CIRCLEQ_HEAD(chead, node);

static struct sqhead sq_static = STAILQ_HEAD_INITIALIZER(sq_static);

static int lists(void) {
    struct node n[3] = {{1}, {2}, {3}}, *p;
    struct shead sh = SLIST_HEAD_INITIALIZER(sh);
    struct lhead lh;
    struct thead th;
    struct chead ch;
    long long acc;
    int i;

    LIST_INIT(&lh);
    TAILQ_INIT(&th);
    CIRCLEQ_INIT(&ch);
    if (!SLIST_EMPTY(&sh) || !LIST_EMPTY(&lh) || !STAILQ_EMPTY(&sq_static) || !TAILQ_EMPTY(&th)
        || !CIRCLEQ_EMPTY(&ch))
        return 1;
    for (i = 0; i < 3; i++) {
        SLIST_INSERT_HEAD(&sh, &n[i], s);
        LIST_INSERT_HEAD(&lh, &n[i], l);
        STAILQ_INSERT_TAIL(&sq_static, &n[i], sq);
        TAILQ_INSERT_TAIL(&th, &n[i], t);
        CIRCLEQ_INSERT_TAIL(&ch, &n[i], c);
    }
    acc = 0;
    SLIST_FOREACH(p, &sh, s) acc = acc * 10 + p->v;
    if (acc != 321) return 2;
    acc = 0;
    LIST_FOREACH(p, &lh, l) acc = acc * 10 + p->v;
    if (acc != 321) return 3;
    acc = 0;
    STAILQ_FOREACH(p, &sq_static, sq) acc = acc * 10 + p->v;
    if (acc != 123) return 4;
    acc = 0;
    TAILQ_FOREACH_REVERSE(p, &th, thead, t) acc = acc * 10 + p->v;
    if (acc != 321 || TAILQ_LAST(&th, thead) != &n[2] || TAILQ_PREV(&n[1], thead, t) != &n[0])
        return 5;
    acc = 0;
    CIRCLEQ_FOREACH(p, &ch, c) acc = acc * 10 + p->v;
    if (acc != 123 || CIRCLEQ_LAST(&ch) != &n[2]) return 6;

    SLIST_REMOVE(&sh, &n[1], node, s);
    LIST_REMOVE(&n[1], l);
    STAILQ_REMOVE(&sq_static, &n[1], node, sq);
    TAILQ_REMOVE(&th, &n[1], t);
    CIRCLEQ_REMOVE(&ch, &n[1], c);
    acc = 0;
    SLIST_FOREACH(p, &sh, s) acc = acc * 10 + p->v;
    LIST_FOREACH(p, &lh, l) acc = acc * 10 + p->v;
    STAILQ_FOREACH(p, &sq_static, sq) acc = acc * 10 + p->v;
    TAILQ_FOREACH(p, &th, t) acc = acc * 10 + p->v;
    CIRCLEQ_FOREACH(p, &ch, c) acc = acc * 10 + p->v;
    if (acc != 3131131313LL) return 7;
    TAILQ_INSERT_BEFORE(&n[2], &n[1], t);
    LIST_INSERT_AFTER(&n[0], &n[1], l);
    acc = 0;
    TAILQ_FOREACH(p, &th, t) acc = acc * 10 + p->v;
    LIST_FOREACH(p, &lh, l) acc = acc * 10 + p->v;
    if (acc != 123312) return 8;
    STAILQ_REMOVE_HEAD(&sq_static, sq);
    if (STAILQ_FIRST(&sq_static) != &n[2] || STAILQ_NEXT(&n[2], sq) != NULL) return 9;
    return 0;
}

#if defined(__linux__)
struct snode {
    int v;
    SIMPLEQ_ENTRY(snode) e;
};
SIMPLEQ_HEAD(sqh, snode);

static int platform_lists(void) {
    struct snode a = {1}, b = {2}, *p;
    struct sqh h = SIMPLEQ_HEAD_INITIALIZER(h);
    int acc = 0;

    SIMPLEQ_INSERT_TAIL(&h, &a, e);
    SIMPLEQ_INSERT_HEAD(&h, &b, e);
    SIMPLEQ_FOREACH(p, &h, e) acc = acc * 10 + p->v;
    SIMPLEQ_REMOVE(&h, &a, snode, e);
    return acc == 21 && SIMPLEQ_FIRST(&h) == &b && SIMPLEQ_NEXT(&b, e) == NULL ? 0 : 14;
}
#elif defined(__APPLE__)
struct snode {
    int v;
    TAILQ_ENTRY(snode) e;
};
TAILQ_HEAD(sth, snode);

static int platform_lists(void) {
    struct snode n[3] = {{1}, {2}, {3}}, *p, *tmp;
    struct sth h = TAILQ_HEAD_INITIALIZER(h);
    int i, acc = 0;

    for (i = 0; i < 3; i++)
        TAILQ_INSERT_TAIL(&h, &n[i], e);
    TAILQ_FOREACH_SAFE(p, &h, e, tmp) {
        if (p->v == 2)
            TAILQ_REMOVE(&h, p, e);
    }
    TAILQ_FOREACH(p, &h, e) acc = acc * 10 + p->v;
    return acc == 13 ? 0 : 14;
}
#else
static int platform_lists(void) { return 0; }
#endif

static int timevals(void) {
    struct timeval a = {5, 100}, b = {3, 900}, d, s;

    timersub(&a, &b, &d);
    timeradd(&a, &b, &s);
    if (d.tv_sec != 1 || d.tv_usec != 999200 || s.tv_sec != 8 || s.tv_usec != 1000) return 10;
    if (!timercmp(&a, &b, >) || timercmp(&a, &b, <) || !timercmp(&a, &a, ==)) return 11;
    if (!timerisset(&d)) return 12;
    timerclear(&d);
    return timerisset(&d) ? 13 : 0;
}

int main(void) {
    int r = lists();
    if (!r) r = platform_lists();
    return r ? r : timevals();
}

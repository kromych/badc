// C99 6.9.2p2: a tentative definition defines its object with the type the
// unit ends with. A `_Thread_local` object declared while its struct type
// was incomplete is sized and aligned by the completed type in the
// thread-local image, so the objects declared after it keep their own
// storage. Returns 0, distinct non-zero per failure.

_Thread_local struct S tv;
_Thread_local int tw;
_Thread_local char tc;
_Thread_local struct A ta;
_Thread_local char td;

static struct S *tv_early(void) { return &tv; }

struct S { long a, b, c; };
struct A { _Alignas(16) long x; long y; };

int main(void) {
    if (tv.a || tv.b || tv.c || ta.y) return 1;
    tv.a = 1;
    tv.b = 2;
    tv.c = 3;
    tw = 0;
    if (tv.b != 2 || tv.c != 3 || tv_early() != &tv) return 2;
    ta.y = 4;
    tc = td = 5;
    if ((unsigned long)&ta % 16 != 0 || ta.y != 4) return 3;
    return 0;
}

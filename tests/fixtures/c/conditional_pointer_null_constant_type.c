// C99 6.5.15p6: in `c ? a : b`, when one arm is a pointer and the other is
// a null pointer constant (`0` or `(void*)0`) or `void*`, the result has the
// pointer arm's type. A struct object pointer must survive, so a following
// `->` on the conditional resolves the member. The same must hold when
// `typeof` reads the type of such a conditional -- including one nested in a
// statement expression, as the container-of / offset-back idiom produces.

typedef unsigned long usize;

struct Base { int tag; usize refs; };
struct Obj { struct Base base; int payload; };
typedef struct Obj Obj;

#define OFFSET(t, m) ((usize)((char *) &((t *) 0)->m - (char *) 0))
#define CONTAINER_OF(p, t, m) ((t *) ((char *) (p) - OFFSET(t, m)))

// Distinct temporaries per level, as a __COUNTER__-based identifier macro
// would produce, so nesting does not shadow.
#define AS_OBJ1(x) ({ typeof((x)) _p1 = (x); _p1 ? CONTAINER_OF(&_p1->base, Obj, base) : ((void *) 0); })
#define AS_OBJ2(x) ({ typeof((x)) _p2 = (x); _p2 ? CONTAINER_OF(&_p2->base, Obj, base) : ((void *) 0); })

static int then_ptr_else_voidnull(Obj *o, int c) { return (c ? (Obj *) o : (void *) 0)->payload; }
static int then_voidnull_else_ptr(Obj *o, int c) { return (c ? (void *) 0 : (Obj *) o)->payload; }
static int then_ptr_else_intnull(Obj *o, int c) { return (c ? (Obj *) o : 0)->payload; }

int main(void) {
    Obj o;
    o.base.tag = 1;
    o.base.refs = 1;
    o.payload = 42;

    if (then_ptr_else_voidnull(&o, 1) != 42) return 1;
    if (then_voidnull_else_ptr(&o, 0) != 42) return 2;
    if (then_ptr_else_intnull(&o, 1) != 42) return 3;

    // typeof of the container-of conditional inside a statement expression
    // must yield Obj *, so `back->payload` reads the object.
    typeof((AS_OBJ1(&o))) back = AS_OBJ1(&o);
    if (back->payload != 42) return 4;

    // Double nesting: typeof over a conditional whose arm is itself such a
    // statement expression (the doubly-wrapped object-cast shape).
    typeof((AS_OBJ2(AS_OBJ1(&o)))) back2 = AS_OBJ2(AS_OBJ1(&o));
    if (back2->payload != 42) return 5;

    return 0;
}

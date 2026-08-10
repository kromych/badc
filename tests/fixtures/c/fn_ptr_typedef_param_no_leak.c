/* An unnamed parameter of function-pointer-typedef type binds no
   declarator, so the prototype's parse must drain the fn-pointer base
   carriers. A leak contaminates the next struct definition's first
   field record with a phantom prototype, and typeof() of that member
   then fails __builtin_types_compatible_p (the kernel container_of
   static assert). */
typedef unsigned long long u64;
typedef unsigned int u32;

struct kref { int refcount; };
struct nvkm_object;
typedef int (*uevent_func)(struct nvkm_object *, u64 token, u32 bits);
/* The unnamed `uevent_func` parameter is the leak site. */
int uevent_add(struct nvkm_object *, int id, u32 bits, uevent_func);

struct chid {
    struct kref kref; /* first field after the prototype */
    int nr;
};

_Static_assert(
    __builtin_types_compatible_p(typeof(((struct chid *)0)->kref), struct kref),
    "member type survives the preceding prototype");

static int seen_token;
static int cb(struct nvkm_object *o, u64 token, u32 bits) {
    (void)o;
    seen_token = (int)(token + bits);
    return 7;
}
/* A named fn-pointer-typedef parameter still carries its prototype. */
static int invoke(uevent_func f, int x) {
    return f(0, 2, 3) + x;
}

static void chid_del(struct kref *kref) {
    /* The container_of shape: typeof(*chid) inside chid's own
       initializer, member and parameter sharing the name `kref`. */
    struct chid *chid = ({
        void *__mptr = (void *)(kref);
        _Static_assert(
            __builtin_types_compatible_p(typeof(*(kref)),
                                         typeof(((typeof(*chid) *)0)->kref)) ||
                __builtin_types_compatible_p(typeof(*(kref)), typeof(void)),
            "pointer type mismatch in container_of()");
        ((typeof(*chid) *)(__mptr - __builtin_offsetof(typeof(*chid), kref)));
    });
    chid->nr = 41;
}

int main(void) {
    struct chid c = { { 1 }, 0 };
    chid_del(&c.kref);
    if (c.nr != 41) return 1;
    if (invoke(cb, 1) != 8) return 2;
    if (seen_token != 5) return 3;
    return 0;
}

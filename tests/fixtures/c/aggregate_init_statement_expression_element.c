// A local aggregate initializer whose element is a GNU statement expression
// is initialized at runtime (a statement expression is not a constant
// expression, C99 6.6). When that statement expression declares its own
// local, the inner declaration must not drain the enclosing aggregate's
// accumulated runtime-init elements -- otherwise an earlier element (here the
// first field/element) is silently dropped and reads garbage.

#define MAX(a, b) ({ typeof(a) _a = (a); typeof(b) _b = (b); _a > _b ? _a : _b; })

struct hdr {
    unsigned magic;
    unsigned version;
    unsigned snaplen;
};

static int check_struct(int seed) {
    // .magic and .version are constant; .snaplen is a statement expression
    // that declares locals. .magic must survive.
    struct hdr h = {
        .magic = 0xa1b2c3d4,
        .version = 2,
        .snaplen = MAX(seed, 256) + 48,
    };
    if (h.magic != 0xa1b2c3d4) return 1;
    if (h.version != 2) return 2;
    if (h.snaplen != (unsigned) (seed > 256 ? seed : 256) + 48) return 3;
    return 0;
}

static int check_array(int r) {
    // The first element is a runtime value; the second is a statement
    // expression that declares a local. Element 0 must survive.
    int a[3] = {r, ({ int x = 20; x + 1; }), 30};
    if (a[0] != r) return 4;
    if (a[1] != 21) return 5;
    if (a[2] != 30) return 6;
    return 0;
}

static int check_nested_aggregate(int r) {
    // The statement-expression element itself declares an aggregate with a
    // runtime initializer; the outer aggregate's first field must survive.
    struct hdr v = {
        r,
        7,
        ({ struct hdr w = {r + 1, r + 2, r + 3}; w.magic + w.version + w.snaplen; }),
    };
    if (v.magic != (unsigned) r) return 7;
    if (v.version != 7) return 8;
    if (v.snaplen != (unsigned) (3 * r + 6)) return 9;
    return 0;
}

int main(void) {
    int rc;
    if ((rc = check_struct(4096)) != 0) return rc;
    if ((rc = check_array(5)) != 0) return rc;
    if ((rc = check_nested_aggregate(9)) != 0) return rc;
    return 0;
}

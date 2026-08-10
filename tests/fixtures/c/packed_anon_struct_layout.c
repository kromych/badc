// `__attribute__((packed))` removes the padding between an aggregate's own
// members, not the padding inside a member's type. A member promoted from an
// anonymous struct/union (C11 6.7.2.1p13) is visible for name lookup but is
// still one member for layout, so every shape below has to lay out exactly
// like the same-typed named member -- that identity is what gcc implements and
// it holds on every data model. The absolute offsets asserted alongside it use
// only `char`/`short`/`int`, whose sizes do not vary across the supported
// targets; the `long` shape is checked against its named counterpart only.
//
// A non-zero exit code is the ordinal of the failing check.

#include <stddef.h>

#define CHECK(c)                                                               \
    do {                                                                       \
        ++k;                                                                   \
        if (!(c)) return k;                                                    \
    } while (0)
#define SAME(A, B)                                                             \
    do {                                                                       \
        CHECK(sizeof(A) == sizeof(B));                                         \
        CHECK(_Alignof(A) == _Alignof(B));                                     \
    } while (0)

// The reported shape, plus the leading-attribute spelling: both orders of the
// attribute run different layout paths and must agree.
struct p_anon { char h; struct { char a; int b; }; char t; } __attribute__((packed));
struct p_named { char h; struct { char a; int b; } m; char t; } __attribute__((packed));
struct __attribute__((packed)) p_lead { char h; struct { char a; int b; }; char t; };

// Nesting: the promoted member carries a promoted member of its own.
struct n_anon { char h; struct { char a; struct { char x; int y; }; }; char t; } __attribute__((packed));
struct n_named { char h; struct { char a; struct { char x; int y; }; } m; char t; } __attribute__((packed));

// Anonymous union member, and an anonymous union inside an anonymous struct in
// both member orders -- the promoted run must not split at the inner union.
struct u_anon { char h; union { char a; int b; }; char t; } __attribute__((packed));
struct u_named { char h; union { char a; int b; } m; char t; } __attribute__((packed));
struct su_anon { char h; struct { char a; union { char b; int c; }; }; char t; } __attribute__((packed));
struct su_named { char h; struct { char a; union { char b; int c; }; } m; char t; } __attribute__((packed));
struct us_anon { char h; struct { union { char b; int c; }; char a; }; char t; } __attribute__((packed));
struct us_named { char h; struct { union { char b; int c; }; char a; } m; char t; } __attribute__((packed));

// The anonymous member's own type is packed.
struct ip_anon { char h; struct { char a; int b; } __attribute__((packed)); char t; } __attribute__((packed));
struct ip_named { char h; struct { char a; int b; } __attribute__((packed)) m; char t; } __attribute__((packed));

// Bit-fields inside the anonymous member, and a bit-field of the outer
// aggregate following one.
struct bf_anon { char h; struct { int a : 3; int b : 5; int c : 20; }; char t; } __attribute__((packed));
struct bf_named { char h; struct { int a : 3; int b : 5; int c : 20; } m; char t; } __attribute__((packed));
struct bo_anon { char h; struct { char a; int b; }; int c : 5; char t; } __attribute__((packed));
struct bo_named { char h; struct { char a; int b; } m; int c : 5; char t; } __attribute__((packed));

// An unnamed bit-field opening the anonymous member: the run starts at the
// member's offset, not at its first named entry.
struct lb_anon { char h; struct { int : 8; char a; }; char t; } __attribute__((packed));
struct lb_named { char h; struct { int : 8; char a; } m; char t; } __attribute__((packed));

// An anonymous member with no named member of its own still reserves its type's
// storage.
struct nb_anon { char h; struct { int : 3; }; char t; } __attribute__((packed));
struct nb_named { char h; struct { int : 3; } m; char t; } __attribute__((packed));

// `packed` drops a member type's alignment; an alignment request inside the
// member sizes that type but does not reach the packed aggregate.
struct al_anon { char h; struct { char a; int b; } __attribute__((aligned(8))); char t; } __attribute__((packed));
struct al_named { char h; struct { char a; int b; } __attribute__((aligned(8))) m; char t; } __attribute__((packed));
struct in_anon { char h; struct { char a; int b __attribute__((aligned(16))); }; char t; } __attribute__((packed));
struct in_named { char h; struct { char a; int b __attribute__((aligned(16))); } m; char t; } __attribute__((packed));

// A packed union: a promoted member spans its type's size, tail padding
// included.
union w_anon { char h; struct { int a; char b; }; } __attribute__((packed));
union w_named { char h; struct { int a; char b; } m; } __attribute__((packed));
union wu_anon { char h; union { int a; char b[5]; }; } __attribute__((packed));
union wu_named { char h; union { int a; char b[5]; } m; } __attribute__((packed));

// An array member and a `long` member: the data model decides the inner size.
struct ar_anon { char h; struct { char a; int b[2]; }; char t; } __attribute__((packed));
struct ar_named { char h; struct { char a; int b[2]; } m; char t; } __attribute__((packed));
struct lg_anon { char h; struct { char a; long b; }; char t; } __attribute__((packed));
struct lg_named { char h; struct { char a; long b; } m; char t; } __attribute__((packed));

// The same shapes without `packed` must be unchanged.
struct np_anon { char h; struct { char a; int b; }; char t; };
struct np_named { char h; struct { char a; int b; } m; char t; };
struct nn_anon { char h; struct { char a; struct { char x; int y; }; }; char t; };
struct nn_named { char h; struct { char a; struct { char x; int y; }; } m; char t; };

int main(void) {
    int k = 0;

    SAME(struct p_anon, struct p_named);
    CHECK(offsetof(struct p_anon, h) == offsetof(struct p_named, h));
    CHECK(offsetof(struct p_anon, a) == offsetof(struct p_named, m.a));
    CHECK(offsetof(struct p_anon, b) == offsetof(struct p_named, m.b));
    CHECK(offsetof(struct p_anon, t) == offsetof(struct p_named, t));
    CHECK(sizeof(struct p_anon) == 10);
    CHECK(_Alignof(struct p_anon) == 1);
    CHECK(offsetof(struct p_anon, h) == 0);
    CHECK(offsetof(struct p_anon, a) == 1);
    CHECK(offsetof(struct p_anon, b) == 5);
    CHECK(offsetof(struct p_anon, t) == 9);
    SAME(struct p_lead, struct p_anon);
    CHECK(offsetof(struct p_lead, a) == offsetof(struct p_anon, a));
    CHECK(offsetof(struct p_lead, b) == offsetof(struct p_anon, b));
    CHECK(offsetof(struct p_lead, t) == offsetof(struct p_anon, t));

    SAME(struct n_anon, struct n_named);
    CHECK(offsetof(struct n_anon, a) == offsetof(struct n_named, m.a));
    CHECK(offsetof(struct n_anon, x) == offsetof(struct n_named, m.x));
    CHECK(offsetof(struct n_anon, y) == offsetof(struct n_named, m.y));
    CHECK(offsetof(struct n_anon, t) == offsetof(struct n_named, t));
    CHECK(sizeof(struct n_anon) == 14);
    CHECK(offsetof(struct n_anon, a) == 1);
    CHECK(offsetof(struct n_anon, x) == 5);
    CHECK(offsetof(struct n_anon, y) == 9);
    CHECK(offsetof(struct n_anon, t) == 13);

    SAME(struct u_anon, struct u_named);
    CHECK(offsetof(struct u_anon, a) == offsetof(struct u_named, m.a));
    CHECK(offsetof(struct u_anon, b) == offsetof(struct u_named, m.b));
    CHECK(offsetof(struct u_anon, t) == offsetof(struct u_named, t));
    CHECK(sizeof(struct u_anon) == 6);
    CHECK(offsetof(struct u_anon, a) == 1);
    CHECK(offsetof(struct u_anon, b) == 1);
    CHECK(offsetof(struct u_anon, t) == 5);

    SAME(struct su_anon, struct su_named);
    CHECK(offsetof(struct su_anon, a) == offsetof(struct su_named, m.a));
    CHECK(offsetof(struct su_anon, b) == offsetof(struct su_named, m.b));
    CHECK(offsetof(struct su_anon, c) == offsetof(struct su_named, m.c));
    CHECK(offsetof(struct su_anon, t) == offsetof(struct su_named, t));
    CHECK(sizeof(struct su_anon) == 10);
    CHECK(offsetof(struct su_anon, a) == 1);
    CHECK(offsetof(struct su_anon, b) == 5);
    CHECK(offsetof(struct su_anon, c) == 5);

    SAME(struct us_anon, struct us_named);
    CHECK(offsetof(struct us_anon, b) == offsetof(struct us_named, m.b));
    CHECK(offsetof(struct us_anon, c) == offsetof(struct us_named, m.c));
    CHECK(offsetof(struct us_anon, a) == offsetof(struct us_named, m.a));
    CHECK(offsetof(struct us_anon, t) == offsetof(struct us_named, t));
    CHECK(sizeof(struct us_anon) == 10);
    CHECK(offsetof(struct us_anon, b) == 1);
    CHECK(offsetof(struct us_anon, a) == 5);

    SAME(struct ip_anon, struct ip_named);
    CHECK(offsetof(struct ip_anon, a) == offsetof(struct ip_named, m.a));
    CHECK(offsetof(struct ip_anon, b) == offsetof(struct ip_named, m.b));
    CHECK(offsetof(struct ip_anon, t) == offsetof(struct ip_named, t));
    CHECK(sizeof(struct ip_anon) == 7);
    CHECK(offsetof(struct ip_anon, b) == 2);
    CHECK(offsetof(struct ip_anon, t) == 6);

    SAME(struct bf_anon, struct bf_named);
    CHECK(offsetof(struct bf_anon, t) == offsetof(struct bf_named, t));
    CHECK(sizeof(struct bf_anon) == 6);
    CHECK(offsetof(struct bf_anon, t) == 5);
    SAME(struct bo_anon, struct bo_named);
    CHECK(offsetof(struct bo_anon, a) == offsetof(struct bo_named, m.a));
    CHECK(offsetof(struct bo_anon, b) == offsetof(struct bo_named, m.b));
    CHECK(offsetof(struct bo_anon, t) == offsetof(struct bo_named, t));
    CHECK(sizeof(struct bo_anon) == 11);
    CHECK(offsetof(struct bo_anon, b) == 5);
    CHECK(offsetof(struct bo_anon, t) == 10);

    SAME(struct lb_anon, struct lb_named);
    CHECK(offsetof(struct lb_anon, a) == offsetof(struct lb_named, m.a));
    CHECK(offsetof(struct lb_anon, t) == offsetof(struct lb_named, t));
    CHECK(offsetof(struct lb_anon, a) == 2);

    SAME(struct nb_anon, struct nb_named);
    CHECK(offsetof(struct nb_anon, t) == offsetof(struct nb_named, t));

    SAME(struct al_anon, struct al_named);
    CHECK(offsetof(struct al_anon, a) == offsetof(struct al_named, m.a));
    CHECK(offsetof(struct al_anon, t) == offsetof(struct al_named, t));
    CHECK(sizeof(struct al_anon) == 10);
    CHECK(_Alignof(struct al_anon) == 1);
    CHECK(offsetof(struct al_anon, a) == 1);

    SAME(struct in_anon, struct in_named);
    CHECK(offsetof(struct in_anon, a) == offsetof(struct in_named, m.a));
    CHECK(offsetof(struct in_anon, b) == offsetof(struct in_named, m.b));
    CHECK(offsetof(struct in_anon, t) == offsetof(struct in_named, t));
    CHECK(sizeof(struct in_anon) == 34);
    CHECK(_Alignof(struct in_anon) == 1);
    CHECK(offsetof(struct in_anon, b) == 17);

    SAME(union w_anon, union w_named);
    CHECK(offsetof(union w_anon, a) == offsetof(union w_named, m.a));
    CHECK(offsetof(union w_anon, b) == offsetof(union w_named, m.b));
    CHECK(sizeof(union w_anon) == 8);
    SAME(union wu_anon, union wu_named);
    CHECK(offsetof(union wu_anon, a) == offsetof(union wu_named, m.a));
    CHECK(sizeof(union wu_anon) == 8);

    SAME(struct ar_anon, struct ar_named);
    CHECK(offsetof(struct ar_anon, b) == offsetof(struct ar_named, m.b));
    CHECK(offsetof(struct ar_anon, t) == offsetof(struct ar_named, t));
    CHECK(sizeof(struct ar_anon) == 14);
    CHECK(offsetof(struct ar_anon, b) == 5);

    SAME(struct lg_anon, struct lg_named);
    CHECK(offsetof(struct lg_anon, a) == offsetof(struct lg_named, m.a));
    CHECK(offsetof(struct lg_anon, b) == offsetof(struct lg_named, m.b));
    CHECK(offsetof(struct lg_anon, t) == offsetof(struct lg_named, t));
    CHECK(offsetof(struct lg_anon, b) == 1 + _Alignof(long));
    CHECK(sizeof(struct lg_anon) == 2 + _Alignof(long) + sizeof(long));

    // Without `packed` the member sits at its natural alignment; nothing here
    // changes.
    SAME(struct np_anon, struct np_named);
    CHECK(offsetof(struct np_anon, a) == 4);
    CHECK(offsetof(struct np_anon, b) == 8);
    CHECK(offsetof(struct np_anon, t) == 12);
    CHECK(sizeof(struct np_anon) == 16);
    CHECK(_Alignof(struct np_anon) == 4);
    SAME(struct nn_anon, struct nn_named);
    CHECK(offsetof(struct nn_anon, x) == 8);
    CHECK(offsetof(struct nn_anon, y) == 12);
    CHECK(sizeof(struct nn_anon) == 20);

    // The promoted entries still address the same bytes they name.
    struct p_anon v;
    char *raw = (char *) &v;
    v.h = 1;
    v.a = 2;
    v.b = 0x03040506;
    v.t = 7;
    CHECK(raw[0] == 1);
    CHECK(raw[1] == 2);
    CHECK(raw[9] == 7);
    CHECK(v.b == 0x03040506);

    return 0;
}

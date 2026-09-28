// C99 6.7.2.2p4, 6.7.2.3: an enum type used before its definition is
// completed by the definition, and every earlier use -- an object, a
// function's result and parameters, a function pointer, a member, a
// typedef -- names the completed type. check() reads each value through a
// declaration made before the definition, ahead of any later declaration
// of the same name, and compares it with the value read through one made
// after it. Each check exits with its own code; success returns 0.

enum E;
enum W;
enum P;

enum E g(void);
extern enum E v;
extern enum E *pv;
enum E (*fp)(void);
long long take(enum E);
void (*setter)(enum E);
typedef enum E te;
typedef enum E (*getter_t)(void);
typedef void sink_t(enum E);
struct ops {
    enum E *m;
    enum E (*get)(void);
    void (*set)(enum E);
    struct {
        enum E *inner;
    };
};
enum E (*(*maker)(void))(enum E);
extern enum W *pw;
extern enum P *pp;
enum E tent;

enum E { E_LO = 1, E_HI = 0x80000000u };
enum W { W_LO = -1, W_HI = 0x7fffffffffffLL };
enum __attribute__((packed)) P { P_A = 1, P_B = 200 };

enum E g_ref(void);
extern enum E v_ref;
static long long seen;
static void store(enum E e);
static enum E (*make(void))(enum E);

#define SAME(a, b) _Generic((a), __typeof__(b): 1, default: 0)

static int check(void) {
    long long hi = g_ref();
    if (!SAME(g(), g_ref()) || (long long)g() != hi) return 1;
    if (!SAME(v, v_ref) || (long long)v != hi) return 2;
    if (!SAME(*pv, v_ref) || (long long)*pv != hi) return 3;
    fp = g;
    if (!SAME(fp(), g_ref()) || (long long)fp() != hi) return 4;
    if (take(E_HI) != hi) return 5;
    setter = store;
    setter(E_HI);
    if (seen != hi) return 6;
    te t = E_HI;
    getter_t gt = g;
    if (!SAME(t, v_ref) || (long long)gt() != hi) return 7;
    sink_t *sk = store;
    seen = 0;
    sk(E_HI);
    if (seen != hi) return 8;
    struct ops o = {pv, g, store, {pv}};
    if (!SAME(*o.m, v_ref) || (long long)*o.m != hi) return 9;
    if ((long long)o.get() != hi || (long long)*o.inner != hi) return 10;
    seen = 0;
    o.set(E_HI);
    if (seen != hi) return 11;
    maker = make;
    if (!SAME(maker()(E_HI), g_ref()) || (long long)maker()(E_HI) != hi) return 12;
    tent = E_HI;
    if (!SAME(tent, v_ref) || (long long)tent != hi) return 13;
    if (sizeof *pw != sizeof(enum W) || *pw != W_HI) return 14;
    if (sizeof *pp != sizeof(enum P) || *pp != P_B) return 15;
    return 0;
}

enum E g(void) { return E_HI; }
enum E g_ref(void) { return E_HI; }
enum E v = E_HI;
enum E v_ref = E_HI;
enum E *pv = &v;
long long take(enum E e) { return e; }
static void store(enum E e) { seen = e; }
static enum E id(enum E e) { return e; }
static enum E (*make(void))(enum E) { return id; }
enum W w_obj = W_HI;
enum W *pw = &w_obj;
enum P p_obj = P_B;
enum P *pp = &p_obj;

int main(void) { return check(); }

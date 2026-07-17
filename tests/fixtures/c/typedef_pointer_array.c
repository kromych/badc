// A typedef of an array-of-pointer type (`typedef T *Name[N]`) must fold its
// dimension onto an object declared with it, the same as any array typedef --
// the element being a pointer does not make the object a scalar. A real-world
// shape is `typedef const char *Strings[N]` initialized
// with `[INDEX] = "string"` designators. Regressions guard that a declarator
// which DOES add a pointer (`A *p`) still yields pointer-to-array, and that a
// scalar-element array typedef still folds. Global, local, and struct-member
// declarations exercise the separate fold sites. Returns 0 on success.

enum { STR_A, STR_B, STR_C, STR_D, STR_MAX };
typedef const char *Strs[STR_MAX];

// Global, designated (the array-of-string-pointer shape).
static const Strs g = {
    [STR_A] = "aa",
    [STR_C] = "cc",
};

// Global, positional.
static const Strs gp = { "w", "x", "y", "z" };

typedef int *IntPtrs[3];
struct Holder {
    Strs names;   // array-of-pointer typedef as a struct member
    int n;
};
static int v0 = 5, v1 = 6, v2 = 7;
static const struct Holder h = {
    .names = { [STR_B] = "bee" },
    .n = 42,
};

// Regression: scalar-element array typedef still folds.
typedef long Longs[4];
// Regression: a declarator that adds a pointer stays pointer-to-array.
typedef int Row[3];
static int backing[3] = { 100, 200, 300 };

// Regression: a function-pointer typedef whose parameter is an array typedef
// (`va_list` is `__va_list_tag[1]` on the SysV/AAPCS ABIs) must NOT pick up
// the parameter's dimension and become an array -- it stays a scalar
// function pointer. This is a common logging-callback shape.
typedef int ArrParam[2];
typedef void (*Callback)(ArrParam);
static Callback cb = 0;

static int check_local(void) {
    // Local object of the array-of-pointer typedef, designated.
    const Strs s = { [STR_A] = "LA", [STR_D] = "LD" };
    if (s[STR_A][0] != 'L' || s[STR_A][1] != 'A') return 30;
    if (s[STR_D][0] != 'L' || s[STR_D][1] != 'D') return 31;
    if (s[STR_B] != 0 || s[STR_C] != 0) return 32;   // gaps NULL

    Longs b = { 1, 2, 3, 4 };                        // scalar typedef folds
    if (sizeof(b) != 4 * sizeof(long) || b[0] != 1 || b[3] != 4) return 33;

    Row *p = &backing;                               // must NOT fold
    if (sizeof(*p) != 3 * sizeof(int)) return 34;
    if ((*p)[0] != 100 || (*p)[2] != 300) return 35;
    return 0;
}

int main(void) {
    if (g[STR_A][0] != 'a' || g[STR_C][0] != 'c') return 1;
    if (g[STR_B] != 0 || g[STR_D] != 0) return 2;    // gaps NULL
    if (gp[0][0] != 'w' || gp[3][0] != 'z') return 3;
    if (h.names[STR_B][0] != 'b' || h.n != 42) return 4;
    if (h.names[STR_A] != 0 || h.names[STR_C] != 0) return 5;

    // Silence unused-typedef/var: touch IntPtrs and the globals.
    static int a = 1, b2 = 2, c = 3;
    IntPtrs ip = { &a, &b2, &c };
    if (*ip[0] != 1 || *ip[2] != 3) return 6;
    if (v0 + v1 + v2 != 18) return 7;
    if (cb != 0) return 8;   // scalar fn-ptr, default-initialized to null

    return check_local();
}

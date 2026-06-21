/* A value defined in a basic block positioned after a block that uses
   it: the block array is not reverse-postorder, so the use precedes
   the definition in array order. Under -O the SSA inliner rebuilds the
   caller; its value remap must be complete before operands resolve, or
   the use reads NO_VALUE and the per-arch emit rejects the malformed
   instruction. Exercised through both a copied call (combine's body
   has a call, so it is not an inline candidate) and an inlined helper
   (scale), whose parameter resolves through the call-argument remap. */

static int sidestate;

static inline int bump(int x) { return x + 1; }

static long combine(long a, long b) {
    sidestate = bump((int)a);
    return a + b;
}

static long scale(long x) { return x * 2; }

long compute(long v) {
    long s;
    long len;
    long sb;
    int t = bump((int)v);
    if (v) {
        sb = v + 100;
        len = v + 1;
        if (sb == 0) {
            return -1;
        }
        s = scale(sb);
    } else {
        return -2;
    }
    return combine(s, len) + t;
}

int main(void) {
    /* v=5: t=6; sb=105; len=6; s=scale(105)=210; combine(210,6)=216;
       216 + 6 = 222. */
    return (int)(compute(5) - 222);
}

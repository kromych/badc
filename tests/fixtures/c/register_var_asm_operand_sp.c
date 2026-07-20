/* A file-scope `register T v asm("rsp")` / `asm("rbp")` variable named
   as an inline-asm register operand binds that operand to the named
   register (the GNU register-variable guarantee), x86-64 extended asm
   here.

   The stack and frame pointers have no storage behind them, so such an
   operand carries no value transfer: nothing is loaded into the
   register before the block and nothing is written back after, and the
   register is not saved across the block. A `"+r"` on the stack pointer
   is therefore a read-write marker telling the compiler the block reads
   and may disturb the stack pointer -- the `call`-wrapping idiom below
   -- and not a request to install a new stack pointer, which the frame
   layout owns. Direct assignment to such a variable stays rejected.

   Only a bare `(v)` operand binds; any larger expression is an ordinary
   rvalue computed from the register's value. */

register unsigned long csp asm("rsp");
register unsigned long cfp asm("rbp");

static int calls;

void bump(void);

void bump(void) {
    calls++;
}

/* The read-write stack-pointer marker around a call: the callee runs
   and the stack pointer is unchanged on return. */
static void call_with_sp_marker(void) {
    __asm__ __volatile__("call bump" : "+r"(csp) : : "memory");
}

/* Bare stack- / frame-pointer operands resolve to `%rsp` / `%rbp`
   themselves; `csp + 8` is not bare, so it is an ordinary rvalue
   computed into a scratch register. All four reads are taken in one
   frame so the comparisons do not depend on frame sizes matching. */
struct sp_reads {
    unsigned long sp_asm;
    unsigned long sp_direct;
    unsigned long fp_asm;
    unsigned long sp_plus_8;
};

static void read_pointers(struct sp_reads *out) {
    unsigned long a;
    unsigned long f;
    unsigned long p;
    __asm__("movq %1, %0" : "=r"(a) : "r"(csp));
    __asm__("movq %1, %0" : "=r"(f) : "r"(cfp));
    __asm__("movq %1, %0" : "=r"(p) : "r"(csp + 8));
    out->sp_asm = a;
    out->sp_direct = csp;
    out->fp_asm = f;
    out->sp_plus_8 = p;
}

int main(void) {
    unsigned long before = csp;
    call_with_sp_marker();
    call_with_sp_marker();
    if (calls != 2) {
        return 1;
    }
    if (csp != before) {
        return 2;
    }

    /* The operand really is the register: within one frame, the
       asm-read stack pointer matches a direct read of the same
       variable, and the frame pointer sits above it. */
    struct sp_reads r;
    read_pointers(&r);
    if (r.sp_asm == 0 || r.fp_asm == 0) {
        return 3;
    }
    if (r.sp_asm != r.sp_direct) {
        return 4;
    }
    if (r.fp_asm < r.sp_asm) {
        return 5;
    }
    if (r.sp_plus_8 != r.sp_asm + 8) {
        return 6;
    }

    return 0;
}

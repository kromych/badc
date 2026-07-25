/* MMX quadword moves (mm<->memory, mm<->mm, mm<->GP64) and the x87
 * WAIT/FWAIT form, as the instruction-emulation FPU paths use them. The
 * asm bodies stay unexecuted; the lock is the encode. */
typedef unsigned long long u64;
static volatile int never;

static void mmx_forms(u64 *data)
{
    asm volatile("movq %%mm0, %0" : "=m"(*data));
    asm volatile("movq %0, %%mm1" : : "m"(*data));
    asm volatile("movq %%mm2, %%mm3");
    u64 v;
    asm volatile("movq %%mm4, %0" : "=r"(v));
    asm volatile("movq %0, %%mm5" : : "r"(v));
    asm volatile("fninit; fwait; emms");
}

int main(void)
{
    u64 d = 0;
    if (never)
        mmx_forms(&d);
    return (int)d;
}

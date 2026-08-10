/* x86-64 percpu accessor shapes: a `%c` / `%P` operand substituted into a
 * `%%gs:` memory reference, at every access width, in load, store and
 * read-modify-write position, and inside an alternative replacement
 * section. The addresses are segment-relative, so the bodies are compiled
 * but not executed. */

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef unsigned long long u64;

u64 this_cpu_off;
u64 current_task;

volatile int run_percpu;

static u64 my_cpu_offset(void) {
    u64 v;
    __asm__("movq %%gs:%P1, %0" : "=r"(v) : "p"(&this_cpu_off));
    return v;
}

static u64 get_current(void) {
    u64 v;
    __asm__("movq %%gs:%c1, %0" : "=r"(v) : "i"(&current_task));
    return v;
}

static u64 percpu_read(long off) {
    u8 b;
    u16 w;
    u32 l;
    u64 q;
    __asm__("movb %%gs:%c1, %0" : "=q"(b) : "i"(0x10));
    __asm__("movw %%gs:%c1, %0" : "=r"(w) : "i"(0x12));
    __asm__("movl %%gs:%c1, %0" : "=r"(l) : "i"(0x14));
    __asm__("movq %%gs:%c1, %0" : "=r"(q) : "i"(0x18));
    return (u64)b + w + l + q + off;
}

static void percpu_write(u64 v) {
    __asm__ volatile("movq %0, %%gs:%c1" : : "r"(v), "i"(0x20) : "memory");
    __asm__ volatile("movl %0, %%gs:%c1" : : "r"((u32)v), "i"(0x28) : "memory");
    __asm__ volatile("addq %0, %%gs:%c1" : : "r"(v), "i"(0x20) : "memory", "cc");
    __asm__ volatile("incq %%gs:%c0" : : "i"(0x30) : "memory", "cc");
    __asm__ volatile("cmpq %0, %%gs:%c1" : : "r"(v), "i"(0x38) : "cc");
}

/* The same reference assembled into a pushed executable section, the
 * alternative-replacement shape. */
static void percpu_alternative(void) {
    __asm__ volatile("nop\n\t"
                     ".pushsection .altinstr_replacement,\"ax\"\n"
                     "771:\n\t"
                     "movq %%gs:%c0, %%rax\n\t"
                     "movq %%gs:%P1, %%rdx\n\t"
                     ".popsection\n"
                     :
                     : "i"(0x40), "p"(&this_cpu_off)
                     : "rax", "rdx", "memory");
}

/* An `%fs:` displacement: the same lowering with the other override. */
static u64 fs_read(void) {
    u64 v;
    __asm__("movq %%fs:%c1, %0" : "=r"(v) : "i"(0x28));
    return v;
}

int main(void) {
    if (run_percpu) {
        percpu_write(my_cpu_offset() + get_current() + percpu_read(1) + fs_read());
        percpu_alternative();
    }
    return 42;
}

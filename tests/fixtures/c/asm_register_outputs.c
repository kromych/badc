// A register output of an inline asm statement written to a scalar
// automatic is the statement's own value, not a store through the
// object's address: the object stays out of the frame. The shapes are a
// plain `=r` output, a `+r` read-write one, two outputs of one statement
// with fixed registers, outputs narrower than a register, an output read
// after a later statement, an output into a volatile object, which is
// written to it, and an output whose object's address escapes elsewhere.
// Exits 0 when every value is right, a distinct code per failure.

static volatile unsigned long long in[] = {7, 5, 3, 0x1234567u, 0x89abu, 42, 11, 9};

static unsigned long long copy(unsigned long long v) {
    unsigned long long out;
#if defined(__x86_64__)
    asm volatile("movq %1, %0" : "=r"(out) : "r"(v));
#elif defined(__aarch64__)
    asm volatile("mov %0, %1" : "=r"(out) : "r"(v));
#else
    out = v;
#endif
    return out;
}

static unsigned long long accumulate(unsigned long long acc, unsigned long long k) {
#if defined(__x86_64__)
    asm volatile("addq %1, %0" : "+r"(acc) : "r"(k));
#elif defined(__aarch64__)
    asm volatile("add %0, %0, %1" : "+r"(acc) : "r"(k));
#else
    acc += k;
#endif
    return acc;
}

static unsigned long long split(unsigned long long v) {
    unsigned int lo, hi;
#if defined(__x86_64__)
    asm volatile("movl %k2, %0\n\tmovl %k2, %1\n\tshrl $1, %1" : "=a"(lo), "=d"(hi) : "r"(v));
#elif defined(__aarch64__)
    asm volatile("mov %w0, %w2\n\tlsr %w1, %w2, #1" : "=r"(lo), "=r"(hi) : "r"(v));
#else
    lo = (unsigned int)v;
    hi = (unsigned int)v >> 1;
#endif
    return (unsigned long long)lo + hi;
}

static unsigned long long narrow(unsigned long long v) {
    unsigned char b;
    unsigned short h;
#if defined(__x86_64__)
    asm volatile("movb %1, %0" : "=r"(b) : "r"((unsigned char)v));
    asm volatile("movw %1, %0" : "=r"(h) : "r"((unsigned short)v));
#elif defined(__aarch64__)
    asm volatile("mov %w0, %w1" : "=r"(b) : "r"((unsigned char)v));
    asm volatile("mov %w0, %w1" : "=r"(h) : "r"((unsigned short)v));
#else
    b = (unsigned char)v;
    h = (unsigned short)v;
#endif
    return (unsigned long long)b + h;
}

static unsigned long long across(unsigned long long v) {
    unsigned long long first, second;
#if defined(__x86_64__)
    asm volatile("movq %1, %0" : "=r"(first) : "r"(v));
    asm volatile("movq %1, %0\n\taddq $1, %0" : "=r"(second) : "r"(first));
#elif defined(__aarch64__)
    asm volatile("mov %0, %1" : "=r"(first) : "r"(v));
    asm volatile("add %0, %1, #1" : "=r"(second) : "r"(first));
#else
    first = v;
    second = first + 1;
#endif
    return first * 100 + second;
}

static unsigned long long volatile_out(unsigned long long v) {
    volatile unsigned long long out;
#if defined(__x86_64__)
    asm volatile("movq %1, %0" : "=r"(out) : "r"(v));
#elif defined(__aarch64__)
    asm volatile("mov %0, %1" : "=r"(out) : "r"(v));
#else
    out = v;
#endif
    return out;
}

static unsigned long long *escaped_at;

static unsigned long long escaped(unsigned long long v) {
    unsigned long long out = 0;
    escaped_at = &out;
#if defined(__x86_64__)
    asm volatile("movq %1, %0" : "=r"(out) : "r"(v));
#elif defined(__aarch64__)
    asm volatile("mov %0, %1" : "=r"(out) : "r"(v));
#else
    out = v;
#endif
    return *escaped_at + out;
}

int main(void) {
    if (copy(in[0]) != 7)
        return 1;
    if (accumulate(in[1], in[2]) != 8)
        return 2;
    if (split(in[3]) != 0x1234567u + (0x1234567u >> 1))
        return 3;
    if (narrow(in[4]) != 0xabu + 0x89abu)
        return 4;
    if (across(in[5]) != 42 * 100 + 43)
        return 5;
    if (escaped(in[6]) != 22)
        return 6;
    if (volatile_out(in[7]) != 9)
        return 7;
    return 0;
}

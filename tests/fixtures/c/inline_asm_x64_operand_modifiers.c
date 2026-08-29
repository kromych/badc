// The x86_64 `%z` (operand-size suffix) and `%h` (legacy high-byte
// register) operand modifiers, and the immediate arm of a
// register-or-immediate constraint (`g`, `ri`, `rI`, `ci`): a constant
// the class admits reaches the instruction as an immediate, any other
// value through a register. Each form is gated on __x86_64__ with a
// portable fallback, so the aarch64 lanes exercise the fallback. Returns
// 42 when every form computes the expected value.

#if defined(__x86_64__)
static unsigned char shr8(unsigned char v) {
    __asm__("shr%z0 $1, %0" : "+r"(v));
    return v;
}
static unsigned short shr16(unsigned short v) {
    __asm__("shr%z0 $1, %0" : "+r"(v));
    return v;
}
static unsigned shr32(unsigned v) {
    __asm__("shr%z0 $1, %0" : "+r"(v));
    return v;
}
static unsigned long shr64(unsigned long v) {
    __asm__("shr%z0 $1, %0" : "+r"(v));
    return v;
}
static void shr16_mem(unsigned short *p) {
    __asm__("shr%z0 $1, %0" : "+m"(*p));
}
static unsigned high_byte(unsigned v) {
    unsigned r;
    __asm__("movb %h1, %b0" : "=a"(r) : "d"(v));
    return r & 0xff;
}
// `g` with a constant: `movl $imm, %r8d` (a 64-bit register name would
// not encode).
static unsigned hypercall_id(void) {
    unsigned r;
    __asm__("movl %1, %%r8d\n\tmovl %%r8d, %0" : "=r"(r) : "g"(0x80000040U) : "r8");
    return r;
}
static long add_ri(long a, long b) {
    __asm__("add %1, %0" : "+r"(a) : "ri"(b));
    return a;
}
static long add_ri_const(long a) {
    __asm__("add %1, %0" : "+r"(a) : "ri"(7));
    return a;
}
// `I` admits 0..31: 3 is the immediate, 40 takes the register.
static long add_rI_in_range(long a) {
    __asm__("add %1, %0" : "+r"(a) : "rI"(3));
    return a;
}
static long add_rI_out_of_range(long a) {
    __asm__("add %1, %0" : "+r"(a) : "rI"(40L));
    return a;
}
static unsigned long shl_ci_const(unsigned long v) {
    __asm__("shl %b1, %0" : "+r"(v) : "ci"(3));
    return v;
}
static unsigned long shl_ci(unsigned long v, int c) {
    __asm__("shl %b1, %0" : "+r"(v) : "ci"(c));
    return v;
}
#else
static unsigned char shr8(unsigned char v) {
    return v >> 1;
}
static unsigned short shr16(unsigned short v) {
    return v >> 1;
}
static unsigned shr32(unsigned v) {
    return v >> 1;
}
static unsigned long shr64(unsigned long v) {
    return v >> 1;
}
static void shr16_mem(unsigned short *p) {
    *p >>= 1;
}
static unsigned high_byte(unsigned v) {
    return (v >> 8) & 0xff;
}
static unsigned hypercall_id(void) {
    return 0x80000040U;
}
static long add_ri(long a, long b) {
    return a + b;
}
static long add_ri_const(long a) {
    return a + 7;
}
static long add_rI_in_range(long a) {
    return a + 3;
}
static long add_rI_out_of_range(long a) {
    return a + 40;
}
static unsigned long shl_ci_const(unsigned long v) {
    return v << 3;
}
static unsigned long shl_ci(unsigned long v, int c) {
    return v << c;
}
#endif

int main(void) {
    unsigned short m = 0x8002;
    if (shr8(0x81) != 0x40) {
        return 1;
    }
    if (shr16(0x8001) != 0x4000) {
        return 2;
    }
    if (shr32(0x80000001u) != 0x40000000u) {
        return 3;
    }
    if (shr64(0x8000000000000001ul) != 0x4000000000000000ul) {
        return 4;
    }
    shr16_mem(&m);
    if (m != 0x4001) {
        return 5;
    }
    if (high_byte(0x12345678u) != 0x56) {
        return 6;
    }
    if (hypercall_id() != 0x80000040U) {
        return 7;
    }
    if (add_ri(30, 12) != 42) {
        return 8;
    }
    if (add_ri_const(35) != 42) {
        return 9;
    }
    if (add_rI_in_range(39) != 42) {
        return 10;
    }
    if (add_rI_out_of_range(2) != 42) {
        return 11;
    }
    if (shl_ci_const(5) != 40) {
        return 12;
    }
    if (shl_ci(21, 1) != 42) {
        return 13;
    }
    return 42;
}

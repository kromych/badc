/* System V AMD64 3.2.3: an aggregate with a member whose offset is not a
   multiple of its type's alignment is MEMORY class -- on the stack as an
   argument, through the hidden pointer as a result -- bit-fields excepted;
   one whose members all lie aligned keeps its eightbyte classes, packed or
   not. On x86-64 System V the naked functions read and set the stack,
   registers and result buffer the convention assigns, so a badc caller and
   a badc callee are each checked against it; elsewhere the same calls go
   through C. The exit code names the first failed check. */

struct __attribute__((packed)) p1 { char c; int x; };      /* memory */
#pragma pack(push, 1)
struct p2 { short a; int b; };                             /* memory */
#pragma pack(pop)
struct __attribute__((packed)) p3 { char c; char d[3]; };  /* rdi */
struct __attribute__((packed)) p4 { char c; int x : 16; }; /* rdi */
struct p5 { char c; struct __attribute__((packed)) { char a; int b; } s; }; /* memory */

__attribute__((noinline)) static long take_p1(long a, struct p1 p) { return a * 1000 + p.c * 100 + p.x; }
__attribute__((noinline)) static long take_p2(struct p2 p, long n) { return p.a * 1000 + p.b * 10 + n; }
__attribute__((noinline)) static long take_p5(struct p5 p, long n) { return p.c * 1000 + p.s.b * 10 + n; }
__attribute__((noinline)) static struct p1 make_p1(char c, int x) { struct p1 r; r.c = c; r.x = x; return r; }
__attribute__((noinline)) static struct p2 make_p2(short a, int b) { struct p2 r; r.a = a; r.b = b; return r; }
__attribute__((noinline)) static struct p3 make_p3(char c) {
    struct p3 r = { c, { 1, 2, 3 } };
    return r;
}

/* gcc at -O0 stores a packed register-passed parameter of a naked function
   into the caller's frame; it takes the C definitions. */
#if defined(__x86_64__) && !defined(_WIN32) && (defined(__clang__) || !defined(__GNUC__))
#define NAKED __attribute__((naked))
/* The integer after the aggregate: rdi when the aggregate is in memory,
   rsi when it takes rdi. */
NAKED static long after_p1(struct p1 p, long n) { __asm__("movq %rdi, %rax\n\tret\n"); }
NAKED static long after_p2(struct p2 p, long n) { __asm__("movq %rdi, %rax\n\tret\n"); }
NAKED static long after_p3(struct p3 p, long n) { __asm__("movq %rsi, %rax\n\tret\n"); }
NAKED static long after_p4(struct p4 p, long n) { __asm__("movq %rsi, %rax\n\tret\n"); }
NAKED static long after_p5(struct p5 p, long n) { __asm__("movq %rdi, %rax\n\tret\n"); }
/* `p.x` of the aggregate the caller left at the first stack slot. */
NAKED static int stack_p1(long a, struct p1 p) { __asm__("movl 9(%rsp), %eax\n\tret\n"); }
/* {5, 42} through the buffer rdi points at, which rax returns. */
NAKED static struct p1 ret_p1(void) {
    __asm__("movb $5, (%rdi)\n\tmovl $42, 1(%rdi)\n\tmovq %rdi, %rax\n\tret\n");
}
/* A call to the badc function with {5, 42} at the first stack slot and 3
   in rdi. */
NAKED static long via_p1(long (*fn)(long, struct p1)) {
    __asm__("movq %rdi, %rax\n\tsubq $24, %rsp\n\tmovb $5, (%rsp)\n\tmovl $42, 1(%rsp)\n\t"
            "movq $3, %rdi\n\tcall *%rax\n\taddq $24, %rsp\n\tret\n");
}
#else
static long after_p1(struct p1 p, long n) { (void)p; return n; }
static long after_p2(struct p2 p, long n) { (void)p; return n; }
static long after_p3(struct p3 p, long n) { (void)p; return n; }
static long after_p4(struct p4 p, long n) { (void)p; return n; }
static long after_p5(struct p5 p, long n) { (void)p; return n; }
static int stack_p1(long a, struct p1 p) { (void)a; return p.x; }
static struct p1 ret_p1(void) { struct p1 r; r.c = 5; r.x = 42; return r; }
static long via_p1(long (*fn)(long, struct p1)) {
    struct p1 p;
    p.c = 5;
    p.x = 42;
    return fn(3, p);
}
#endif

int main(void) {
    struct p1 a;
    struct p2 b;
    struct p3 c = { 1, { 2, 3, 4 } };
    struct p4 d = { 1, 3 };
    struct p5 e;
    a.c = 1;
    a.x = 7;
    b.a = 2;
    b.b = 9;
    e.c = 4;
    e.s.a = 5;
    e.s.b = 6;
    if (after_p1(a, 42) != 42) return 1;
    if (after_p2(b, 42) != 42) return 2;
    if (after_p3(c, 42) != 42) return 3;
    if (after_p4(d, 42) != 42) return 4;
    if (after_p5(e, 42) != 42) return 5;
    if (stack_p1(3, a) != 7) return 6;
    struct p1 r = ret_p1();
    if (r.c != 5 || r.x != 42) return 7;
    if (via_p1(take_p1) != 3542) return 8;
    if (take_p2(b, 3) != 2093) return 9;
    if (take_p5(e, 3) != 4063) return 10;
    r = make_p1(6, 77);
    if (r.c != 6 || r.x != 77) return 11;
    b = make_p2(4, 11);
    if (b.a != 4 || b.b != 11) return 12;
    c = make_p3(8);
    if (c.c != 8 || c.d[2] != 3) return 13;
    return 0;
}

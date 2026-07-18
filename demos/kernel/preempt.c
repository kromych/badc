/* A preemptive multitasking "kernel": a UEFI application, compiled by badc, that
 * installs its own timer interrupt, runs three hardcoded threads, and switches
 * between them on every timer tick. Each thread prints to the serial port under
 * a spin lock, so the round-robin is visible as cleanly interleaved lines.
 *
 * This goes further than demos/kernel/kernel.c (which only exercises inline asm
 * on the boot path): it takes over the interrupt vector table and the timer
 * from the firmware, so it is a live test of badc emitting a real interrupt
 * service routine -- a `__attribute__((naked))` function whose body is the
 * context switch (save every register, pick the next thread, restore, and
 * return through `iretq`).
 *
 * Layout: four saved contexts -- slot 0 is `efi_main`, slots 1..3 are the
 * threads. The first tick saves `efi_main` and switches into thread 1; ticks
 * round-robin 1->2->3->1...; after MAX_TICKS the scheduler stops the timer and
 * switches back to slot 0, so `efi_main` resumes, prints the final marker, and
 * halts. The printed markers are deterministic, so demos/kernel/smoke.py can
 * assert on them.
 *
 * Build:  badc --target=windows-x64 demos/kernel/preempt.c -o preempt-x64.efi
 * Run:    python3 demos/kernel/smoke.py
 *
 * AArch64 preemption (generic timer + GIC + EL1 vectors) is not implemented
 * yet; on that target the kernel prints a banner and halts.
 */

#pragma subsystem(efi_application)
#pragma entrypoint(efi_main)

typedef unsigned long long UINTN;
typedef unsigned long long EFI_STATUS;
typedef void *EFI_HANDLE;

#define EFI_SUCCESS 0
#define NTHREADS 3
#define NCTX (NTHREADS + 1) /* slot 0 is efi_main */
#define STACK_WORDS 1024    /* 8 KiB per thread stack */
#define MAX_TICKS 24        /* ~8 turns per thread, then stop */

/* ---- Scheduler state (shared; the ISR runs with interrupts masked, so no
 *      concurrent mutation of these between ticks on a single core). ---- */

static unsigned long g_ctx_sp[NCTX]; /* saved stack pointer per context */
static int g_cur;                    /* running context (0 = efi_main) */
static volatile unsigned g_ticks;
static volatile unsigned g_done;
static unsigned long g_stacks[NTHREADS][STACK_WORDS];

/* The serial port is shared by all threads; the lock keeps each printed line
 * from being split by a context switch mid-write. */
static volatile unsigned g_print_lock;

static void spin_lock(volatile unsigned *l) {
    while (__atomic_test_and_set(l, __ATOMIC_ACQUIRE)) {
    }
}

static void spin_unlock(volatile unsigned *l) {
    __atomic_clear(l, __ATOMIC_RELEASE);
}

#if defined(__x86_64__)

/* ---- 16550 UART on COM1 (I/O port 0x3F8); QEMU routes it to -serial. ---- */

#define COM1 0x3F8

static void outb(unsigned short port, unsigned char val) {
    __asm__ volatile("outb %0, %1" : : "a"(val), "Nd"(port));
}

static unsigned char inb(unsigned short port) {
    unsigned char v;
    __asm__ volatile("inb %1, %0" : "=a"(v) : "Nd"(port));
    return v;
}

static void serial_init(void) {
    outb(COM1 + 1, 0x00); /* disable UART interrupts */
    outb(COM1 + 3, 0x80); /* DLAB: divisor access */
    outb(COM1 + 0, 0x01); /* 115200 baud, low byte */
    outb(COM1 + 1, 0x00); /* high byte */
    outb(COM1 + 3, 0x03); /* 8 data bits, no parity, 1 stop */
    outb(COM1 + 2, 0xC7); /* enable + clear FIFOs */
    outb(COM1 + 4, 0x03); /* DTR + RTS */
}

static void serial_putc(char c) {
    while ((inb(COM1 + 5) & 0x20) == 0) { /* wait for the holding register */
    }
    outb(COM1, (unsigned char)c);
}

/* ---- Interrupt controller (8259 PIC) and timer (8253/8254 PIT). ---- */

static void pic_remap(void) {
    /* Move the master PIC's vectors to 0x20..0x27 so IRQ0 (the timer) is
     * vector 0x20, clear of the CPU's exception range. */
    outb(0x20, 0x11);
    outb(0xA0, 0x11); /* start init, expect ICW4 */
    outb(0x21, 0x20);
    outb(0xA1, 0x28); /* master base 0x20, slave base 0x28 */
    outb(0x21, 0x04);
    outb(0xA1, 0x02); /* wire slave onto IRQ2 */
    outb(0x21, 0x01);
    outb(0xA1, 0x01); /* 8086 mode */
    outb(0x21, 0xFE); /* master: unmask IRQ0 only */
    outb(0xA1, 0xFF); /* slave: mask all */
}

static void pit_start(void) {
    /* Channel 0, rate generator (mode 3), ~100 Hz. */
    unsigned divisor = 1193182u / 100u;
    outb(0x43, 0x36);
    outb(0x40, (unsigned char)(divisor & 0xFF));
    outb(0x40, (unsigned char)(divisor >> 8));
}

static void pit_stop(void) {
    outb(0x21, 0xFF); /* mask every master IRQ */
}

/* ---- Interrupt descriptor table. One 64-bit interrupt gate for the timer. */

static unsigned char g_idt[256 * 16];

static unsigned short read_cs(void) {
    unsigned short cs;
    __asm__ volatile("mov %%cs, %0" : "=r"(cs));
    return cs;
}

static void lidt(void *base, unsigned short limit) {
    struct {
        unsigned short limit;
        unsigned long base;
    } __attribute__((packed)) idtr = {limit, (unsigned long)base};
    __asm__ volatile("lidt %0" : : "m"(idtr));
}

static void idt_set(int vec, void *handler, unsigned short cs) {
    unsigned long addr = (unsigned long)handler;
    unsigned char *e = &g_idt[vec * 16];
    e[0] = (unsigned char)(addr & 0xFF);
    e[1] = (unsigned char)((addr >> 8) & 0xFF);
    e[2] = (unsigned char)(cs & 0xFF);
    e[3] = (unsigned char)(cs >> 8);
    e[4] = 0;    /* IST 0 */
    e[5] = 0x8E; /* present, DPL 0, 64-bit interrupt gate */
    e[6] = (unsigned char)((addr >> 16) & 0xFF);
    e[7] = (unsigned char)((addr >> 24) & 0xFF);
    e[8] = (unsigned char)((addr >> 32) & 0xFF);
    e[9] = (unsigned char)((addr >> 40) & 0xFF);
    e[10] = (unsigned char)((addr >> 48) & 0xFF);
    e[11] = (unsigned char)((addr >> 56) & 0xFF);
    e[12] = e[13] = e[14] = e[15] = 0;
}

/* The scheduler: called from the ISR with the interrupted context's saved
 * stack pointer; returns the stack pointer to switch to. */
unsigned long schedule(unsigned long sp) {
    g_ctx_sp[g_cur] = sp;
    g_ticks++;
    int next;
    if (g_ticks >= MAX_TICKS) {
        pit_stop();
        g_done = 1;
        next = 0; /* back to efi_main */
    } else {
        next = (g_cur >= NTHREADS) ? 1 : g_cur + 1;
    }
    g_cur = next;
    return g_ctx_sp[next];
}

/* The timer ISR. Naked: no compiler prologue/epilogue, so the body is exactly
 * the context switch. On entry the CPU has pushed the interrupt frame
 * (SS:RSP:RFLAGS:CS:RIP); we push the general registers on top, hand the
 * resulting stack pointer to schedule(), load the returned pointer, restore,
 * and `iretq` into the chosen thread. schedule() takes its argument in RCX
 * (the Microsoft x64 ABI these PE binaries use); the `and`/`sub` give it a
 * 16-byte-aligned stack with the mandatory 32-byte shadow space below the
 * saved registers, which stay intact above it. */
__attribute__((naked)) void timer_isr(void) {
    __asm__ volatile(
        "push %rax\n\t"
        "push %rbx\n\t"
        "push %rcx\n\t"
        "push %rdx\n\t"
        "push %rsi\n\t"
        "push %rdi\n\t"
        "push %rbp\n\t"
        "push %r8\n\t"
        "push %r9\n\t"
        "push %r10\n\t"
        "push %r11\n\t"
        "push %r12\n\t"
        "push %r13\n\t"
        "push %r14\n\t"
        "push %r15\n\t"
        "mov $0x20, %al\n\t" /* end-of-interrupt to the master PIC */
        "outb %al, $0x20\n\t"
        "mov %rsp, %rcx\n\t" /* arg1 = interrupted stack pointer */
        "and $-16, %rsp\n\t"
        "sub $32, %rsp\n\t"
        "call schedule\n\t" /* rax = next context's stack pointer */
        "mov %rax, %rsp\n\t"
        "pop %r15\n\t"
        "pop %r14\n\t"
        "pop %r13\n\t"
        "pop %r12\n\t"
        "pop %r11\n\t"
        "pop %r10\n\t"
        "pop %r9\n\t"
        "pop %r8\n\t"
        "pop %rbp\n\t"
        "pop %rdi\n\t"
        "pop %rsi\n\t"
        "pop %rdx\n\t"
        "pop %rcx\n\t"
        "pop %rbx\n\t"
        "pop %rax\n\t"
        "iretq\n\t");
}

/* Build a thread's initial context so the first switch-in `iretq`s into
 * `entry(id)`. The saved block mirrors the ISR's push order (r15 lowest, rax
 * highest) followed by the interrupt frame; the argument register (RCX, MS x64
 * ABI) carries the thread id. */
static void thread_setup(int slot, void (*entry)(int), int id, unsigned long *stack_top) {
    unsigned long ss, cs;
    __asm__ volatile("mov %%ss, %0" : "=r"(ss));
    cs = read_cs();
    unsigned long *f = stack_top - 20; /* 15 GP + 5 interrupt-frame words */
    for (int i = 0; i < 20; i++) {
        f[i] = 0;
    }
    f[12] = (unsigned long)id;        /* RCX (pop order: r15..r8,rbp,rdi,rsi,rdx,rcx) */
    f[15] = (unsigned long)entry;     /* RIP */
    f[16] = cs;                       /* CS */
    f[17] = 0x202;                    /* RFLAGS: interrupts enabled */
    f[18] = (unsigned long)(stack_top - 1); /* RSP after iretq (16-aligned - 8) */
    f[19] = ss;                       /* SS */
    g_ctx_sp[slot] = (unsigned long)f;
}

static void sti(void) { __asm__ volatile("sti"); }
static void cli(void) { __asm__ volatile("cli"); }
static void halt(void) { __asm__ volatile("hlt"); }

static void arch_start_scheduler(void) {
    idt_set(0x20, (void *)timer_isr, read_cs());
    lidt(g_idt, sizeof(g_idt) - 1);
    pic_remap();
    pit_start();
    sti();
}

#elif defined(__aarch64__)

/* PL011 UART on QEMU's virt machine. */
#define PL011 0x09000000UL

static void serial_init(void) {}

static void serial_putc(char c) {
    volatile unsigned *dr = (volatile unsigned *)(PL011 + 0x00);
    volatile unsigned *fr = (volatile unsigned *)(PL011 + 0x18);
    while (*fr & (1u << 5)) { /* TXFF: FIFO full */
    }
    *dr = (unsigned char)c;
}

/* Preemptive scheduling on AArch64 needs the generic timer, a GIC, and an EL1
 * vector table; not implemented here yet. */
static void arch_start_scheduler(void) {}
static void thread_setup(int slot, void (*entry)(int), int id, unsigned long *stack_top) {
    (void)slot;
    (void)entry;
    (void)id;
    (void)stack_top;
}
static void halt(void) { __asm__ volatile("wfi"); }
static void cli(void) {}

#endif

/* ---- Portable serial helpers and the thread body. ---- */

static void serial_puts(const char *s) {
    for (int i = 0; s[i]; i++) {
        serial_putc(s[i]);
    }
}

static void serial_putdec(unsigned v) {
    char buf[11];
    int n = 0;
    if (v == 0) {
        buf[n++] = '0';
    }
    while (v) {
        buf[n++] = (char)('0' + v % 10);
        v /= 10;
    }
    while (n) {
        serial_putc(buf[--n]);
    }
}

static void print_line(int id, unsigned turn) {
    spin_lock(&g_print_lock);
    serial_puts("[thread ");
    serial_putc((char)('0' + id));
    serial_puts("] turn ");
    serial_putdec(turn);
    serial_puts("\r\n");
    spin_unlock(&g_print_lock);
}

/* Each thread prints its turn count, then burns a little time so the timer
 * preempts it mid-loop and hands the CPU to the next thread. */
static void thread_main(int id) {
    unsigned turn = 0;
    for (;;) {
        print_line(id, turn++);
        for (volatile unsigned d = 0; d < 400000u; d++) {
        }
    }
}

EFI_STATUS efi_main(EFI_HANDLE ImageHandle, void *SystemTable) {
    (void)ImageHandle;
    (void)SystemTable;

    serial_init();
    serial_puts("BADC-PREEMPT: start\r\n");

#if defined(__x86_64__)
    for (int i = 0; i < NTHREADS; i++) {
        thread_setup(i + 1, thread_main, i, &g_stacks[i][STACK_WORDS]);
    }
    g_cur = 0;
    arch_start_scheduler();

    /* The first tick saves this context and switches to thread 1; when the
     * scheduler has run MAX_TICKS it stops the timer and switches back here. */
    while (!g_done) {
        halt();
    }
    cli();
    serial_puts("BADC-PREEMPT: scheduler done\r\n");
    serial_puts("BADC-PREEMPT-OK\r\n");
#else
    serial_puts("BADC-PREEMPT: aarch64 preemption pending\r\n");
    serial_puts("BADC-PREEMPT-OK\r\n");
#endif

    for (;;) {
        halt();
    }
    return EFI_SUCCESS;
}

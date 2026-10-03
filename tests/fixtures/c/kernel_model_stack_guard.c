// snapshot-flags: -c -mcmodel=kernel -fstack-protector-strong
// x86-64 kernel code model, stack protector on, no guard register named, as
// Linux 5.10 to 6.12 build: the canary is read from %gs:0x28, the per-CPU
// slot the kernel fills, as gcc and clang read it. The shape is
// arch/x86/kernel/idt.c's. aarch64 rejects the flag, so this snapshots for
// x64 only.

struct idt_data {
    unsigned int vector;
    unsigned int segment;
    unsigned long addr;
};

extern char idt_table[];
extern void idt_setup_from_table(void *table, const struct idt_data *t, int size, _Bool sys);

void set_intr_gate(unsigned int n, const void *addr) {
    struct idt_data data = {n, 0x10, (unsigned long)addr};
    idt_setup_from_table(idt_table, &data, 1, 0);
}

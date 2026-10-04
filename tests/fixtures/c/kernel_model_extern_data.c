// snapshot-flags: -c -mcmodel=kernel
// x86-64 kernel code model: external-data addresses materialize as
// sign-extended 32-bit absolutes (`mov reg, $sym` + R_X86_64_32S), never
// as a GOT load -- a consumer that applies the relocations itself
// implements no GOT. Scalar, address-of, member and indexed accesses;
// aarch64 rejects the flag, so this snapshots for x64 only.

extern unsigned long ticks;
extern struct net_t {
    int ifindex;
} net0;
extern struct cpu_t {
    unsigned char family;
} cpu0;
extern unsigned long cpu_offset[];
extern const unsigned char class_tab[];
extern int strcmp(const char *, const char *);

unsigned long read_ticks(void) { return ticks; }
unsigned long *ticks_addr(void) { return &ticks; }
int net_index(void) { return net0.ifindex; }
unsigned char family(void) { return cpu0.family; }
unsigned long cpu_base(int cpu) { return cpu_offset[cpu]; }
int char_class(int c) { return class_tab[c & 0xff]; }
int (*cmp_fn(void))(const char *, const char *) { return &strcmp; }

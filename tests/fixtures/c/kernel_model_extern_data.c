// snapshot-flags: -c -mcmodel=kernel
// x86-64 kernel code model: external-data addresses materialize as
// sign-extended 32-bit absolutes (`mov reg, $sym` + R_X86_64_32S), never
// as a GOT load -- a consumer that applies the relocations itself
// implements no GOT. Access patterns and symbol names mirror kernel
// objects; aarch64 rejects the flag, so this snapshots for x64 only.

extern unsigned long jiffies;
extern struct net_t {
    int ifindex;
} init_net;
extern struct cpu_t {
    unsigned char family;
} cpu_info;
extern unsigned long __per_cpu_offset[];
extern const unsigned char _ctype[];
extern int strcmp(const char *, const char *);

unsigned long read_jiffies(void) { return jiffies; }
unsigned long *jiffies_addr(void) { return &jiffies; }
int net_index(void) { return init_net.ifindex; }
unsigned char family(void) { return cpu_info.family; }
unsigned long pcpu_base(int cpu) { return __per_cpu_offset[cpu]; }
int ctype_class(int c) { return _ctype[c & 0xff]; }
int (*cmp_fn(void))(const char *, const char *) { return &strcmp; }

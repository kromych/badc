// The -fcrash-report handler. Installed before main by the constructor below,
// it reports a fatal signal the program takes (an exception no handler takes,
// on Windows) -- the signal and the address it names, the registers, and the
// frames, which the frame records chain (the system unwinder finds them on
// Windows), each with the function the dynamic loader, the symbol table or
// DbgHelp names and its offset in its module -- and lets the signal end the
// program as it would have. The driver links it with `-u __badc_crash_report`.
//
// The report is formatted on the stack and written straight to the stderr
// descriptor: the fault may have stopped the program inside stdio or the
// allocator.

#if __STDC_HOSTED__ && (defined(__linux__) || defined(__APPLE__) || defined(_WIN32))
#if defined(_WIN32)
#include <windows.h>
#include <stdint.h>
#else
#define _GNU_SOURCE 1
#include <dlfcn.h>
#if defined(__linux__)
#include <elf.h>
#include <fcntl.h>
#endif
#include <signal.h>
#include <stdint.h>
#include <string.h>
#include <sys/ucontext.h>
#include <unistd.h>
#endif

struct __badc_crash_out {
    char buf[256];
    unsigned n;
};

static void __badc_crash_flush(struct __badc_crash_out *o) {
    if (o->n) {
#if defined(_WIN32)
        DWORD written;
        WriteFile(GetStdHandle(STD_ERROR_HANDLE), o->buf, o->n, &written, 0);
#else
        write(2, o->buf, o->n);
#endif
    }
    o->n = 0;
}

static void __badc_crash_str(struct __badc_crash_out *o, const char *s) {
    for (; *s; s++) {
        if (o->n == sizeof o->buf)
            __badc_crash_flush(o);
        o->buf[o->n++] = *s;
    }
}

static void __badc_crash_hex(struct __badc_crash_out *o, uintptr_t v) {
    char digits[2 + 2 * sizeof v + 1];
    char *p = digits + sizeof digits - 1;
    *p = 0;
    do {
        *--p = "0123456789abcdef"[v & 15];
        v >>= 4;
    } while (v);
    *--p = 'x';
    *--p = '0';
    __badc_crash_str(o, p);
}

static void __badc_crash_dec(struct __badc_crash_out *o, unsigned v) {
    char digits[12];
    char *p = digits + sizeof digits - 1;
    *p = 0;
    do {
        *--p = (char)('0' + v % 10);
        v /= 10;
    } while (v);
    __badc_crash_str(o, p);
}

static void __badc_crash_name(struct __badc_crash_out *o, uintptr_t pc, uintptr_t at);

static void __badc_crash_frame(struct __badc_crash_out *o, unsigned k, uintptr_t pc, uintptr_t at) {
    __badc_crash_str(o, "  #");
    __badc_crash_dec(o, k);
    __badc_crash_str(o, " ");
    __badc_crash_hex(o, pc);
    __badc_crash_name(o, pc, at);
    __badc_crash_str(o, "\n");
    __badc_crash_flush(o);
}

static void __badc_crash_reg(struct __badc_crash_out *o, const char *name, uintptr_t v,
                             unsigned *column) {
    __badc_crash_str(o, "  ");
    __badc_crash_str(o, name);
    __badc_crash_str(o, "=");
    __badc_crash_hex(o, v);
    if (++*column == 4) {
        __badc_crash_str(o, "\n");
        *column = 0;
    }
}

#if defined(_WIN32)
// DbgHelp's SYMBOL_INFO, which the bundled headers do not declare.
typedef struct {
    ULONG SizeOfStruct;
    ULONG TypeIndex;
    ULONG64 Reserved[2];
    ULONG Index;
    ULONG Size;
    ULONG64 ModBase;
    ULONG Flags;
    ULONG64 Value;
    ULONG64 Address;
    ULONG Register;
    ULONG Scope;
    ULONG Tag;
    ULONG NameLen;
    ULONG MaxNameLen;
    CHAR Name[1];
} __badc_symbol_info;

typedef BOOL(WINAPI *__badc_sym_initialize)(HANDLE, const char *, BOOL);
typedef BOOL(WINAPI *__badc_sym_from_addr)(HANDLE, DWORD64, DWORD64 *, __badc_symbol_info *);
typedef DWORD(WINAPI *__badc_sym_set_options)(DWORD);

static __badc_sym_from_addr __badc_crash_sym_from_addr;

// DbgHelp, loaded when the report needs it and found: it names an address
// by the module's PDB or exports.
static void __badc_crash_dbghelp(void) {
    HMODULE dbghelp = LoadLibraryA("dbghelp.dll");
    if (!dbghelp)
        return;
    __badc_sym_set_options set = (__badc_sym_set_options)GetProcAddress(dbghelp, "SymSetOptions");
    __badc_sym_initialize init = (__badc_sym_initialize)GetProcAddress(dbghelp, "SymInitialize");
    __badc_sym_from_addr from =
        (__badc_sym_from_addr)GetProcAddress(dbghelp, "SymFromAddr");
    if (!init || !from)
        return;
    if (set)
        set(0x2 | 0x4); // SYMOPT_UNDNAME | SYMOPT_DEFERRED_LOADS
    if (init(GetCurrentProcess(), 0, TRUE))
        __badc_crash_sym_from_addr = from;
}

static void __badc_crash_name(struct __badc_crash_out *o, uintptr_t pc, uintptr_t at) {
    if (__badc_crash_sym_from_addr) {
        union {
            __badc_symbol_info info;
            char bytes[sizeof(__badc_symbol_info) + 256];
        } symbol;
        DWORD64 displacement = 0;
        symbol.info.SizeOfStruct = sizeof symbol.info;
        symbol.info.MaxNameLen = 256;
        // SymFromAddr answers with a neighbor for an address no symbol
        // covers.
        if (__badc_crash_sym_from_addr(GetCurrentProcess(), at, &displacement, &symbol.info) &&
            symbol.info.Address <= at &&
            (!symbol.info.Size || at < symbol.info.Address + symbol.info.Size)) {
            __badc_crash_str(o, " in ");
            __badc_crash_str(o, symbol.info.Name);
            __badc_crash_str(o, "+");
            __badc_crash_hex(o, pc - (uintptr_t)symbol.info.Address);
        }
    }
    HMODULE module;
    char path[MAX_PATH];
    if (!GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                                GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                            (const char *)at, &module) ||
        !GetModuleFileNameA(module, path, sizeof path))
        return;
    const char *name = path;
    for (const char *s = path; *s; s++)
        if (*s == '\\' || *s == '/')
            name = s + 1;
    __badc_crash_str(o, " (");
    __badc_crash_str(o, name);
    __badc_crash_str(o, "+");
    __badc_crash_hex(o, pc - (uintptr_t)module);
    __badc_crash_str(o, ")");
}

static const char *__badc_crash_exception_name(DWORD code) {
    switch (code) {
    case EXCEPTION_ACCESS_VIOLATION:
        return "EXCEPTION_ACCESS_VIOLATION";
    case EXCEPTION_IN_PAGE_ERROR:
        return "EXCEPTION_IN_PAGE_ERROR";
    case EXCEPTION_ILLEGAL_INSTRUCTION:
        return "EXCEPTION_ILLEGAL_INSTRUCTION";
    case EXCEPTION_PRIV_INSTRUCTION:
        return "EXCEPTION_PRIV_INSTRUCTION";
    case EXCEPTION_INT_DIVIDE_BY_ZERO:
        return "EXCEPTION_INT_DIVIDE_BY_ZERO";
    case EXCEPTION_INT_OVERFLOW:
        return "EXCEPTION_INT_OVERFLOW";
    case EXCEPTION_STACK_OVERFLOW:
        return "EXCEPTION_STACK_OVERFLOW";
    case EXCEPTION_BREAKPOINT:
        return "EXCEPTION_BREAKPOINT";
    case EXCEPTION_DATATYPE_MISALIGNMENT:
        return "EXCEPTION_DATATYPE_MISALIGNMENT";
    case EXCEPTION_ARRAY_BOUNDS_EXCEEDED:
        return "EXCEPTION_ARRAY_BOUNDS_EXCEEDED";
    }
    return "an exception";
}

// The frames the system unwinder finds from `c` through the modules'
// .pdata; code no entry covers is a leaf, its return address at the stack
// pointer (x64) or in the link register (arm64).
static void __badc_crash_unwind(struct __badc_crash_out *o, const CONTEXT *c) {
    CONTEXT walk = *c;
    __badc_crash_str(o, "frames:\n");
    __badc_crash_flush(o);
    for (unsigned k = 0; k < 64; k++) {
#if defined(__aarch64__)
        DWORD64 pc = walk.Pc, sp = walk.Sp;
#else
        DWORD64 pc = walk.Rip, sp = walk.Rsp;
#endif
        if (!pc)
            break;
        __badc_crash_frame(o, k, pc, k ? pc - 1 : pc);
        DWORD64 base, frame;
        void *data;
        RUNTIME_FUNCTION *f = RtlLookupFunctionEntry(pc, &base, 0);
        if (f)
            RtlVirtualUnwind(UNW_FLAG_NHANDLER, base, pc, f, &walk, &data, &frame, 0);
#if defined(__aarch64__)
        else
            walk.Pc = walk.Lr;
        if (walk.Pc == pc && walk.Sp == sp)
            break;
#else
        else {
            walk.Rip = *(DWORD64 *)walk.Rsp;
            walk.Rsp += 8;
        }
        if (walk.Rip == pc && walk.Rsp == sp)
            break;
#endif
    }
}

static LONG WINAPI __badc_crash_filter(EXCEPTION_POINTERS *e) {
    struct __badc_crash_out o = {.n = 0};
    EXCEPTION_RECORD *record = e->ExceptionRecord;
    CONTEXT *c = e->ContextRecord;
    DWORD code = record->ExceptionCode;
    __badc_crash_str(&o, "badc: the program took ");
    __badc_crash_str(&o, __badc_crash_exception_name(code));
    __badc_crash_str(&o, " (");
    __badc_crash_hex(&o, code);
    __badc_crash_str(&o, ") at address ");
    // An access names the address it touched; any other exception, the
    // instruction's.
    int access = (code == EXCEPTION_ACCESS_VIOLATION || code == EXCEPTION_IN_PAGE_ERROR) &&
                 record->NumberParameters >= 2;
    __badc_crash_hex(&o, access ? (uintptr_t)record->ExceptionInformation[1]
                                : (uintptr_t)record->ExceptionAddress);
    __badc_crash_str(&o, "\n");
    unsigned column = 0;
#if defined(__aarch64__)
    static const char *const names[29] = {"x0",  "x1",  "x2",  "x3",  "x4",  "x5",  "x6",  "x7",
                                          "x8",  "x9",  "x10", "x11", "x12", "x13", "x14", "x15",
                                          "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23",
                                          "x24", "x25", "x26", "x27", "x28"};
    for (int i = 0; i < 29; i++)
        __badc_crash_reg(&o, names[i], c->X[i], &column);
    __badc_crash_reg(&o, "fp", c->X[29], &column);
    __badc_crash_reg(&o, "lr", c->X[30], &column);
    __badc_crash_reg(&o, "sp", c->Sp, &column);
    __badc_crash_reg(&o, "pc", c->Pc, &column);
#else
    __badc_crash_reg(&o, "rax", c->Rax, &column);
    __badc_crash_reg(&o, "rbx", c->Rbx, &column);
    __badc_crash_reg(&o, "rcx", c->Rcx, &column);
    __badc_crash_reg(&o, "rdx", c->Rdx, &column);
    __badc_crash_reg(&o, "rsi", c->Rsi, &column);
    __badc_crash_reg(&o, "rdi", c->Rdi, &column);
    __badc_crash_reg(&o, "rbp", c->Rbp, &column);
    __badc_crash_reg(&o, "rsp", c->Rsp, &column);
    __badc_crash_reg(&o, "r8", c->R8, &column);
    __badc_crash_reg(&o, "r9", c->R9, &column);
    __badc_crash_reg(&o, "r10", c->R10, &column);
    __badc_crash_reg(&o, "r11", c->R11, &column);
    __badc_crash_reg(&o, "r12", c->R12, &column);
    __badc_crash_reg(&o, "r13", c->R13, &column);
    __badc_crash_reg(&o, "r14", c->R14, &column);
    __badc_crash_reg(&o, "r15", c->R15, &column);
    __badc_crash_reg(&o, "rip", c->Rip, &column);
    __badc_crash_reg(&o, "eflags", c->EFlags, &column);
#endif
    if (column)
        __badc_crash_str(&o, "\n");
    __badc_crash_dbghelp();
    __badc_crash_unwind(&o, c);
    // The exception ends the program as it would have without the filter.
    return EXCEPTION_CONTINUE_SEARCH;
}

void __badc_crash_report(void) {
    // Stack the filter can run on after the thread's has overflowed.
    ULONG reserve = 65536;
    SetThreadStackGuarantee(&reserve);
    SetUnhandledExceptionFilter(__badc_crash_filter);
}

__attribute__((constructor)) static void __badc_crash_report_install(void) {
    __badc_crash_report();
}
#else
static const char *__badc_crash_signal_name(int sig) {
    switch (sig) {
    case SIGSEGV:
        return "SIGSEGV";
    case SIGBUS:
        return "SIGBUS";
    case SIGILL:
        return "SIGILL";
    case SIGFPE:
        return "SIGFPE";
    case SIGABRT:
        return "SIGABRT";
    case SIGTRAP:
        return "SIGTRAP";
    }
    return "a signal";
}

#if defined(__linux__)
// The function of the ELF symbol table of `path` holding file address `off`:
// its name into `name` and its address, read with pread so a fault in the
// allocator or stdio does not stop it. The dynamic loader names only the
// exported symbols; an executable that is not stripped names them all.
static int __badc_crash_symtab(const char *path, uintptr_t off, char *name, unsigned cap,
                               uintptr_t *start) {
    int fd = open(path, O_RDONLY);
    if (fd < 0)
        return 0;
    int found = 0;
    Elf64_Ehdr eh;
    Elf64_Shdr symtab, strtab;
    if (pread(fd, &eh, sizeof eh, 0) != (long)sizeof eh || memcmp(eh.e_ident, ELFMAG, SELFMAG) ||
        eh.e_shentsize != sizeof(Elf64_Shdr))
        goto done;
    for (unsigned i = 0; i < eh.e_shnum; i++) {
        if (pread(fd, &symtab, sizeof symtab, eh.e_shoff + i * sizeof symtab) != (long)sizeof symtab)
            goto done;
        if (symtab.sh_type != SHT_SYMTAB)
            continue;
        if (pread(fd, &strtab, sizeof strtab, eh.e_shoff + symtab.sh_link * sizeof strtab) !=
            (long)sizeof strtab)
            goto done;
        Elf64_Sym syms[64];
        uint32_t best_name = 0;
        for (uint64_t at = 0; at < symtab.sh_size; at += sizeof syms) {
            long got = pread(fd, syms, sizeof syms, symtab.sh_offset + at);
            if (got <= 0)
                break;
            for (long k = 0; k < got / (long)sizeof syms[0]; k++) {
                Elf64_Sym *s = &syms[k];
                if (ELF64_ST_TYPE(s->st_info) == STT_FUNC && s->st_value <= off &&
                    off < s->st_value + s->st_size) {
                    best_name = s->st_name;
                    *start = s->st_value;
                    found = 1;
                }
            }
        }
        if (found) {
            long got = pread(fd, name, cap - 1, strtab.sh_offset + best_name);
            name[got > 0 ? got : 0] = 0;
            name[cap - 1] = 0;
        }
        break;
    }
done:
    close(fd);
    return found && name[0];
}
#endif

// ` in symbol+0xoff (module+0xoff)` for `pc`, as far as the code at `at` is
// known: by the symbol the dynamic loader has for it, else, on Linux, by the
// module's symbol table; every address by its module. A return address is
// looked up one byte back, inside the call.
static void __badc_crash_name(struct __badc_crash_out *o, uintptr_t pc, uintptr_t at) {
    Dl_info info;
    if (!dladdr((void *)at, &info) || !info.dli_fname)
        return;
#if defined(__linux__)
    if (!info.dli_sname) {
        // The loader records the program by its argv[0], which may be relative.
        const char *path = info.dli_fname[0] == '/' ? info.dli_fname : "/proc/self/exe";
        char name[128];
        uintptr_t start, base = (uintptr_t)info.dli_fbase;
        Elf64_Ehdr *eh = (Elf64_Ehdr *)info.dli_fbase;
        uintptr_t bias = eh->e_type == ET_EXEC ? 0 : base;
        if (__badc_crash_symtab(path, at - bias, name, sizeof name, &start)) {
            __badc_crash_str(o, " in ");
            __badc_crash_str(o, name);
            __badc_crash_str(o, "+");
            __badc_crash_hex(o, pc - bias - start);
        }
    }
#endif
    if (info.dli_sname && info.dli_saddr) {
        __badc_crash_str(o, " in ");
        __badc_crash_str(o, info.dli_sname);
        __badc_crash_str(o, "+");
        __badc_crash_hex(o, pc - (uintptr_t)info.dli_saddr);
    }
    const char *module = info.dli_fname;
    for (const char *s = module; *s; s++)
        if (*s == '/')
            module = s + 1;
    __badc_crash_str(o, " (");
    __badc_crash_str(o, module);
    __badc_crash_str(o, "+");
    __badc_crash_hex(o, pc - (uintptr_t)info.dli_fbase);
    __badc_crash_str(o, ")");
}

// The registers, and the program counter and frame pointer the walk starts at.
static void __badc_crash_registers(struct __badc_crash_out *o, ucontext_t *uc, uintptr_t *pc,
                                   uintptr_t *fp) {
    unsigned column = 0;
#if defined(__APPLE__)
    static const char *const names[29] = {"x0",  "x1",  "x2",  "x3",  "x4",  "x5",  "x6",  "x7",
                                          "x8",  "x9",  "x10", "x11", "x12", "x13", "x14", "x15",
                                          "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23",
                                          "x24", "x25", "x26", "x27", "x28"};
    struct __darwin_arm_thread_state64 *ss = &uc->uc_mcontext->__ss;
    for (int i = 0; i < 29; i++)
        __badc_crash_reg(o, names[i], ss->__x[i], &column);
    __badc_crash_reg(o, "fp", ss->__fp, &column);
    __badc_crash_reg(o, "lr", ss->__lr, &column);
    __badc_crash_reg(o, "sp", ss->__sp, &column);
    __badc_crash_reg(o, "pc", ss->__pc, &column);
    *pc = ss->__pc;
    *fp = ss->__fp;
#elif defined(__x86_64__)
    static const struct {
        const char *name;
        int reg;
    } regs[] = {{"rax", REG_RAX}, {"rbx", REG_RBX}, {"rcx", REG_RCX}, {"rdx", REG_RDX},
                {"rsi", REG_RSI}, {"rdi", REG_RDI}, {"rbp", REG_RBP}, {"rsp", REG_RSP},
                {"r8", REG_R8},   {"r9", REG_R9},   {"r10", REG_R10}, {"r11", REG_R11},
                {"r12", REG_R12}, {"r13", REG_R13}, {"r14", REG_R14}, {"r15", REG_R15},
                {"rip", REG_RIP}, {"eflags", REG_EFL}};
    for (unsigned i = 0; i < sizeof regs / sizeof regs[0]; i++)
        __badc_crash_reg(o, regs[i].name, (uintptr_t)uc->uc_mcontext.gregs[regs[i].reg], &column);
    *pc = (uintptr_t)uc->uc_mcontext.gregs[REG_RIP];
    *fp = (uintptr_t)uc->uc_mcontext.gregs[REG_RBP];
#else
    static const char *const names[29] = {"x0",  "x1",  "x2",  "x3",  "x4",  "x5",  "x6",  "x7",
                                          "x8",  "x9",  "x10", "x11", "x12", "x13", "x14", "x15",
                                          "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23",
                                          "x24", "x25", "x26", "x27", "x28"};
    mcontext_t *mc = &uc->uc_mcontext;
    for (int i = 0; i < 29; i++)
        __badc_crash_reg(o, names[i], mc->regs[i], &column);
    __badc_crash_reg(o, "fp", mc->regs[29], &column);
    __badc_crash_reg(o, "lr", mc->regs[30], &column);
    __badc_crash_reg(o, "sp", mc->sp, &column);
    __badc_crash_reg(o, "pc", mc->pc, &column);
    *pc = mc->pc;
    *fp = mc->regs[29];
#endif
    if (column)
        __badc_crash_str(o, "\n");
}

// Frame #0 at `pc`, then the frames the records from `fp` chain: each holds
// the caller's record and the return address, and the walk stops at a
// record that does not lie above the one before. The caller of a frameless
// function is in no record.
// TODO(#878, #2144): step by the unwind tables once badc's images describe
// every function.
static void __badc_crash_frames(struct __badc_crash_out *o, uintptr_t pc, uintptr_t fp) {
    __badc_crash_str(o, "frames:\n");
    __badc_crash_flush(o);
    __badc_crash_frame(o, 0, pc, pc);
    for (unsigned k = 1; k < 64 && fp && !(fp & 7); k++) {
        uintptr_t next = ((uintptr_t *)fp)[0];
        uintptr_t ret = ((uintptr_t *)fp)[1];
        if (!ret)
            break;
        __badc_crash_frame(o, k, ret, ret - 1);
        if (next <= fp)
            break;
        fp = next;
    }
}

static const int __badc_crash_signals[] = {SIGSEGV, SIGBUS, SIGILL, SIGFPE, SIGABRT, SIGTRAP};

static void __badc_crash_handler(int sig, siginfo_t *si, void *context) {
    // A fault while reporting, as from a frame record that is not one, ends
    // the program by its default action; SA_NODEFER leaves it unblocked.
    for (unsigned i = 0; i < sizeof __badc_crash_signals / sizeof __badc_crash_signals[0]; i++)
        signal(__badc_crash_signals[i], SIG_DFL);
    struct __badc_crash_out o = {.n = 0};
    __badc_crash_str(&o, "badc: the program took ");
    __badc_crash_str(&o, __badc_crash_signal_name(sig));
    if (sig != SIGABRT) {
        __badc_crash_str(&o, " at address ");
        __badc_crash_hex(&o, (uintptr_t)si->si_addr);
    }
    __badc_crash_str(&o, "\n");
    uintptr_t pc, fp;
    __badc_crash_registers(&o, (ucontext_t *)context, &pc, &fp);
    __badc_crash_frames(&o, pc, fp);
    raise(sig);
}

static char __badc_crash_stack[65536];

void __badc_crash_report(void) {
    // A separate stack, so the report runs when the program's has overflowed.
    stack_t ss;
    memset(&ss, 0, sizeof ss);
    ss.ss_sp = __badc_crash_stack;
    ss.ss_size = sizeof __badc_crash_stack;
    sigaltstack(&ss, 0);
    struct sigaction sa;
    memset(&sa, 0, sizeof sa);
    sa.sa_sigaction = __badc_crash_handler;
    sa.sa_flags = SA_SIGINFO | SA_ONSTACK | SA_NODEFER;
    sigemptyset(&sa.sa_mask);
    for (unsigned i = 0; i < sizeof __badc_crash_signals / sizeof __badc_crash_signals[0]; i++)
        sigaction(__badc_crash_signals[i], &sa, 0);
}

__attribute__((constructor)) static void __badc_crash_report_install(void) {
    __badc_crash_report();
}
#endif
#endif

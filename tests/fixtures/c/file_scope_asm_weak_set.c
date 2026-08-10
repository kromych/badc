/* File-scope asm symbol-table directives: `.weak name` + `.set name,
 * target` defines a weak alias of a function in this unit (the
 * conditional-syscall shape); `.weak` alone on a section label binds the
 * label weak; `.weak` of a name defined nowhere yields a weak undefined
 * symbol. */
long ni_syscall(void) { return -38; }

asm(".weak sys_alias_one\n\t"
    ".set  sys_alias_one,ni_syscall");
asm(".weak sys_alias_two\n\t"
    ".set  sys_alias_two,ni_syscall");

asm(".pushsection .rodata,\"a\"\n"
    ".weak weak_marker\n"
    "weak_marker:\n"
    ".long 7\n"
    ".popsection");

asm(".weak optional_hook");

int main(void) { return ni_syscall() == -38 ? 0 : 1; }

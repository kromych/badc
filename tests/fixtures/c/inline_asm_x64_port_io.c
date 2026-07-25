// x86-64 string port-I/O primitives (ins / outs) through inline asm: the
// byte / word / dword suffixes, plain and under `rep`. Port I/O is privileged
// and faults in user space, so this fixture is compiled and linked but not
// executed -- it locks the encodings the way the executed string-primitive
// fixture locks movs / stos. The functions have external linkage so they are
// emitted without being called. Native x86-64 only.

void port_out_bytes(const void *src, unsigned long n, unsigned short port) {
    __asm__ volatile("rep outsb" : "+S"(src), "+c"(n) : "d"(port) : "memory");
}

void port_out_words(const void *src, unsigned long n, unsigned short port) {
    __asm__ volatile("rep outsw" : "+S"(src), "+c"(n) : "d"(port) : "memory");
}

void port_out_dwords(const void *src, unsigned long n, unsigned short port) {
    __asm__ volatile("rep outsl" : "+S"(src), "+c"(n) : "d"(port) : "memory");
}

void port_in_bytes(void *dst, unsigned long n, unsigned short port) {
    __asm__ volatile("rep insb" : "+D"(dst), "+c"(n) : "d"(port) : "memory");
}

void port_in_words(void *dst, unsigned long n, unsigned short port) {
    __asm__ volatile("rep insw" : "+D"(dst), "+c"(n) : "d"(port) : "memory");
}

void port_in_dwords(void *dst, unsigned long n, unsigned short port) {
    __asm__ volatile("rep insl" : "+D"(dst), "+c"(n) : "d"(port) : "memory");
}

void port_out_one(const void *src, unsigned short port) {
    __asm__ volatile("outsb" : "+S"(src) : "d"(port) : "memory");
}

void port_in_one(void *dst, unsigned short port) {
    __asm__ volatile("insb" : "+D"(dst) : "d"(port) : "memory");
}

int main(void) {
    return 0;
}

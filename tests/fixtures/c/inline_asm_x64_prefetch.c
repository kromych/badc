// x86-64 sizeless-memory prefetch hints via inline asm, reached through the
// catalogue passthrough: the SSE read hints (prefetchnta / prefetcht0 /
// prefetcht1 / prefetcht2, 0F 18 /0../3) and the 3DNow prefetch / write-
// prefetch (prefetch / prefetchw, 0F 0D /0,/1). Each acts on the cache line
// of a memory operand without changing its value. Compile-only: prefetch /
// prefetchw need the 3DNOWPREFETCH feature and #UD on a host without it, so
// this fixture locks the encodings without executing them. Native x86-64 only.

void prefetch_hints(const void *p) {
    __asm__ volatile(
        "prefetchnta %0\n\t"
        "prefetcht0 %0\n\t"
        "prefetcht1 %0\n\t"
        "prefetcht2 %0\n\t"
        "prefetch %0\n\t"
        "prefetchw %0"
        : : "m"(*(const char *)p) : "memory");
}

int main(void) {
    return 0;
}

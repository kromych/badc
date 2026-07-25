// One asm-holding callee inlined at eight sites: the splice pools the
// relocated locals region across call-free bodies and the -O compaction
// drops promoted slots, so the caller frame grows by one region, not
// eight (each object's lifetime ends when the inlined body exits, C99
// 6.2.4p2, so the sites never need distinct storage).

static long step(long v) {
    long acc = v;
    __asm__("" : "+r"(acc));
    return acc + 1;
}

int main(void) {
    long t = 0;
    t = step(t);
    t = step(t);
    t = step(t);
    t = step(t);
    t = step(t);
    t = step(t);
    t = step(t);
    t = step(t);
    return t == 8 ? 0 : 1;
}

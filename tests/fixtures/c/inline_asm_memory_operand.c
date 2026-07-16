/* An inline-asm `"m"` / `"+m"` operand is a memory reference, not a
   register. edk2's BaseSynchronizationLib reaches the interlocked
   primitives through `lock cmpxchg %2, %1` / `lock xadd %0, %1` with `%1`
   constrained `"+m"(*Value)`. Treating the operand as a register emitted
   `lock cmpxchg %reg`, an invalid encoding that faults (#UD) at runtime --
   which crashed the badc-built firmware in early boot. The operand now
   emits `(%reg)`, so the instruction reads and writes memory directly and
   the `lock` prefix is valid. The checks confirm the memory object is
   updated (compare-and-swap succeeds / fails, exchange-and-add). */

typedef unsigned int       U32;
typedef unsigned long long U64;

static U32 cas32(U32 *p, U32 cmp, U32 xchg) {
    U32 old;
    __asm__ __volatile__("lock \n\t cmpxchgl %2, %1 \n\t"
                         : "=a"(old), "+m"(*p)
                         : "q"(xchg), "0"(cmp)
                         : "memory", "cc");
    return old;
}

static U32 xadd32(U32 *p, U32 add) {
    U32 old = add; /* the accumulator holds the addend in, the old value out */
    __asm__ __volatile__("lock \n\t xadd %0, %1 \n\t"
                         : "+a"(old), "+m"(*p)
                         :
                         : "memory", "cc");
    return old;
}

static U64 cas64(U64 *p, U64 cmp, U64 xchg) {
    U64 old;
    __asm__ __volatile__("lock \n\t cmpxchgq %2, %1 \n\t"
                         : "=a"(old), "+m"(*p)
                         : "q"(xchg), "0"(cmp)
                         : "memory", "cc");
    return old;
}

int main(void) {
    U32 v = 10;
    if (cas32(&v, 10, 20) != 10 || v != 20)   /* match -> swaps */
        return 1;
    if (cas32(&v, 99, 30) != 20 || v != 20)   /* mismatch -> unchanged */
        return 2;

    U32 w = 5;
    if (xadd32(&w, 3) != 5 || w != 8)          /* returns old, adds */
        return 3;

    U64 q = 100;
    if (cas64(&q, 100, 200) != 100 || q != 200)
        return 4;

    return 0;
}

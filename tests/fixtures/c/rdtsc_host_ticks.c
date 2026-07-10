/* x86-64 `rdtsc` inline-asm shape (QEMU timer.h `cpu_get_host_ticks`) as
   Intrinsic::Rdtsc: two 32-bit register-tied outputs, no inputs. Native
   x86-64 emits `rdtsc`; the VM zeroes the outputs (no host clock), so the
   assembled 64-bit value is 0 here. Other native targets gate it out. */

static long long host_ticks(void) {
    unsigned low, high;
    __asm__ volatile("rdtsc" : "=a"(low), "=d"(high));
    return ((long long)high << 32) | low;
}

int main(void) {
    long long t = host_ticks();
    return (int)(t & 0); /* VM: rdtsc reads 0 -> 0 */
}

/* A one-word-struct-returning helper that also writes through a pointer
   parameter (an escaping store) must stay out of line: redirecting the
   result slot is fine, but the escaping store has no caller equivalent.
   The write-admission filter keeps it out of line; this locks that the
   escaping write still happens. */
typedef union { unsigned long bits; } SR;

static SR mkesc(unsigned long v, unsigned long *out) {
    *out = v;
    return (SR){.bits = v};
}

int main(void) {
    unsigned long seen = 0;
    SR r = mkesc(42, &seen);
    return (r.bits == 42 && seen == 42) ? 0 : 1;
}

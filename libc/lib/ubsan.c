// UndefinedBehaviorSanitizer handlers, provided on demand: the functions a
// failed `-fsanitize=` check calls, with the data layout gcc and clang pass
// them, reporting as clang's runtime does. The native-link driver pulls this
// object in only when a unit references a handler, so an image built
// without -fsanitize carries none of it. A site reports once: its column is
// set to all ones when it does. The `_abort` forms, which
// -fno-sanitize-recover selects, end the program after the report.

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

struct __ubsan_source_location {
    const char *file;
    uint32_t line;
    uint32_t column;
};

struct __ubsan_type_descriptor {
    uint16_t kind;
    uint16_t info;
    char name[];
};

struct __ubsan_overflow_data {
    struct __ubsan_source_location loc;
    const struct __ubsan_type_descriptor *type;
};

// Whether the site at `loc` reports now: the first failure claims it.
static int __ubsan_claim(struct __ubsan_source_location *loc, uint32_t *column) {
    *column = __atomic_exchange_n(&loc->column, 0xffffffffu, __ATOMIC_RELAXED);
    return *column != 0xffffffffu;
}

// An integer operand as its type reads it: the low `bits` bits, sign-extended
// for a signed type.
static void __ubsan_print_int(const struct __ubsan_type_descriptor *t, uintptr_t v) {
    unsigned bits = 1u << (t->info >> 1);
    unsigned shift = bits < 64 ? 64 - bits : 0;
    if (t->info & 1)
        fprintf(stderr, "%lld", (long long)((int64_t)((uint64_t)v << shift) >> shift));
    else
        fprintf(stderr, "%llu", (unsigned long long)(((uint64_t)v << shift) >> shift));
}

static void __ubsan_overflow(struct __ubsan_overflow_data *d, uintptr_t lhs, uintptr_t rhs,
                             const char *op) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    fprintf(stderr, "%s:%u:%u: runtime error: signed integer overflow: ", d->loc.file,
            d->loc.line, column);
    __ubsan_print_int(d->type, lhs);
    fprintf(stderr, " %s ", op);
    __ubsan_print_int(d->type, rhs);
    fprintf(stderr, " cannot be represented in type %s\n", d->type->name);
}

void __ubsan_handle_add_overflow(struct __ubsan_overflow_data *d, uintptr_t l, uintptr_t r) {
    __ubsan_overflow(d, l, r, "+");
}

void __ubsan_handle_sub_overflow(struct __ubsan_overflow_data *d, uintptr_t l, uintptr_t r) {
    __ubsan_overflow(d, l, r, "-");
}

void __ubsan_handle_mul_overflow(struct __ubsan_overflow_data *d, uintptr_t l, uintptr_t r) {
    __ubsan_overflow(d, l, r, "*");
}

_Noreturn void __ubsan_handle_add_overflow_abort(struct __ubsan_overflow_data *d, uintptr_t l,
                                                 uintptr_t r) {
    __ubsan_overflow(d, l, r, "+");
    abort();
}

_Noreturn void __ubsan_handle_sub_overflow_abort(struct __ubsan_overflow_data *d, uintptr_t l,
                                                 uintptr_t r) {
    __ubsan_overflow(d, l, r, "-");
    abort();
}

_Noreturn void __ubsan_handle_mul_overflow_abort(struct __ubsan_overflow_data *d, uintptr_t l,
                                                 uintptr_t r) {
    __ubsan_overflow(d, l, r, "*");
    abort();
}

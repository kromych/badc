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

struct __ubsan_shift_data {
    struct __ubsan_source_location loc;
    const struct __ubsan_type_descriptor *lhs_type;
    const struct __ubsan_type_descriptor *rhs_type;
};

// Whether the site at `loc` reports now: the first failure claims it.
static int __ubsan_claim(struct __ubsan_source_location *loc, uint32_t *column) {
    *column = __atomic_exchange_n(&loc->column, 0xffffffffu, __ATOMIC_RELAXED);
    return *column != 0xffffffffu;
}

static unsigned __ubsan_bits(const struct __ubsan_type_descriptor *t) {
    return 1u << (t->info >> 1);
}

// An integer operand as its type reads it: the low bits of its width,
// sign-extended for a signed type.
static int64_t __ubsan_signed(const struct __ubsan_type_descriptor *t, uintptr_t v) {
    unsigned shift = 64 - __ubsan_bits(t);
    return (int64_t)((uint64_t)v << shift) >> shift;
}

static int __ubsan_negative(const struct __ubsan_type_descriptor *t, uintptr_t v) {
    return (t->info & 1) && __ubsan_signed(t, v) < 0;
}

static void __ubsan_print_int(const struct __ubsan_type_descriptor *t, uintptr_t v) {
    unsigned shift = 64 - __ubsan_bits(t);
    if (t->info & 1)
        fprintf(stderr, "%lld", (long long)__ubsan_signed(t, v));
    else
        fprintf(stderr, "%llu", (unsigned long long)(((uint64_t)v << shift) >> shift));
}

static void __ubsan_shift(struct __ubsan_shift_data *d, uintptr_t lhs, uintptr_t rhs) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    fprintf(stderr, "%s:%u:%u: runtime error: ", d->loc.file, d->loc.line, column);
    if (__ubsan_negative(d->rhs_type, rhs)) {
        fprintf(stderr, "shift exponent ");
        __ubsan_print_int(d->rhs_type, rhs);
        fprintf(stderr, " is negative\n");
    } else if ((uint64_t)rhs >= __ubsan_bits(d->lhs_type)) {
        fprintf(stderr, "shift exponent ");
        __ubsan_print_int(d->rhs_type, rhs);
        fprintf(stderr, " is too large for %u-bit type %s\n", __ubsan_bits(d->lhs_type),
                d->lhs_type->name);
    } else if (__ubsan_negative(d->lhs_type, lhs)) {
        fprintf(stderr, "left shift of negative value ");
        __ubsan_print_int(d->lhs_type, lhs);
        fprintf(stderr, "\n");
    } else {
        fprintf(stderr, "left shift of ");
        __ubsan_print_int(d->lhs_type, lhs);
        fprintf(stderr, " by ");
        __ubsan_print_int(d->rhs_type, rhs);
        fprintf(stderr, " places cannot be represented in type %s\n", d->lhs_type->name);
    }
}

void __ubsan_handle_shift_out_of_bounds(struct __ubsan_shift_data *d, uintptr_t l, uintptr_t r) {
    __ubsan_shift(d, l, r);
}

_Noreturn void __ubsan_handle_shift_out_of_bounds_abort(struct __ubsan_shift_data *d, uintptr_t l,
                                                        uintptr_t r) {
    __ubsan_shift(d, l, r);
    abort();
}

static void __ubsan_divrem(struct __ubsan_overflow_data *d, uintptr_t lhs, uintptr_t rhs) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    fprintf(stderr, "%s:%u:%u: runtime error: ", d->loc.file, d->loc.line, column);
    if ((d->type->info & 1) && __ubsan_signed(d->type, rhs) == -1) {
        fprintf(stderr, "division of ");
        __ubsan_print_int(d->type, lhs);
        fprintf(stderr, " by -1 cannot be represented in type %s\n", d->type->name);
    } else {
        fprintf(stderr, "division by zero\n");
    }
}

void __ubsan_handle_divrem_overflow(struct __ubsan_overflow_data *d, uintptr_t l, uintptr_t r) {
    __ubsan_divrem(d, l, r);
}

_Noreturn void __ubsan_handle_divrem_overflow_abort(struct __ubsan_overflow_data *d, uintptr_t l,
                                                    uintptr_t r) {
    __ubsan_divrem(d, l, r);
    abort();
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

static void __ubsan_negate(struct __ubsan_overflow_data *d, uintptr_t v) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    fprintf(stderr, "%s:%u:%u: runtime error: negation of ", d->loc.file, d->loc.line, column);
    __ubsan_print_int(d->type, v);
    fprintf(stderr,
            " cannot be represented in type %s; cast to an unsigned type to negate this value to "
            "itself\n",
            d->type->name);
}

void __ubsan_handle_negate_overflow(struct __ubsan_overflow_data *d, uintptr_t v) {
    __ubsan_negate(d, v);
}

_Noreturn void __ubsan_handle_negate_overflow_abort(struct __ubsan_overflow_data *d, uintptr_t v) {
    __ubsan_negate(d, v);
    abort();
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

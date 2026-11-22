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

struct __ubsan_invalid_value_data {
    struct __ubsan_source_location loc;
    const struct __ubsan_type_descriptor *type;
};

struct __ubsan_out_of_bounds_data {
    struct __ubsan_source_location loc;
    const struct __ubsan_type_descriptor *array_type;
    const struct __ubsan_type_descriptor *index_type;
};

struct __ubsan_implicit_conversion_data {
    struct __ubsan_source_location loc;
    const struct __ubsan_type_descriptor *from_type;
    const struct __ubsan_type_descriptor *to_type;
    unsigned char kind;
    unsigned int bitfield_bits;
};

struct __ubsan_float_cast_data {
    struct __ubsan_source_location loc;
    const struct __ubsan_type_descriptor *from_type;
    const struct __ubsan_type_descriptor *to_type;
};
struct __ubsan_type_mismatch_data {
    struct __ubsan_source_location loc;
    const struct __ubsan_type_descriptor *type;
    unsigned char log_alignment;
    unsigned char type_check_kind;
};
struct __ubsan_pointer_overflow_data {
    struct __ubsan_source_location loc;
};
struct __ubsan_vla_bound_data {
    struct __ubsan_source_location loc;
    const struct __ubsan_type_descriptor *type;
};
struct __ubsan_unreachable_data {
    struct __ubsan_source_location loc;
};
// Whether the site at `loc` reports now: the first failure claims it.
static int __ubsan_claim(struct __ubsan_source_location *loc, uint32_t *column) {
    *column = __atomic_exchange_n(&loc->column, 0xffffffffu, __ATOMIC_RELAXED);
    return *column != 0xffffffffu;
}

// The line that closes a report, as clang's runtime writes it.
static void __ubsan_summary(const struct __ubsan_source_location *loc, uint32_t column) {
    fprintf(stderr, "SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior %s:%u:%u \n",
            loc->file, loc->line, column);
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
    __ubsan_summary(&d->loc, column);
}

void __ubsan_handle_shift_out_of_bounds(struct __ubsan_shift_data *d, uintptr_t l, uintptr_t r) {
    __ubsan_shift(d, l, r);
}

_Noreturn void __ubsan_handle_shift_out_of_bounds_abort(struct __ubsan_shift_data *d, uintptr_t l,
                                                        uintptr_t r) {
    __ubsan_shift(d, l, r);
    abort();
}

static void __ubsan_out_of_bounds(struct __ubsan_out_of_bounds_data *d, uintptr_t index) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    fprintf(stderr, "%s:%u:%u: runtime error: index ", d->loc.file, d->loc.line, column);
    __ubsan_print_int(d->index_type, index);
    fprintf(stderr, " out of bounds for type %s\n", d->array_type->name);
    __ubsan_summary(&d->loc, column);
}

void __ubsan_handle_out_of_bounds(struct __ubsan_out_of_bounds_data *d, uintptr_t index) {
    __ubsan_out_of_bounds(d, index);
}

_Noreturn void __ubsan_handle_out_of_bounds_abort(struct __ubsan_out_of_bounds_data *d,
                                                  uintptr_t index) {
    __ubsan_out_of_bounds(d, index);
    abort();
}

static void __ubsan_invalid_value(struct __ubsan_invalid_value_data *d, uintptr_t value) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    fprintf(stderr, "%s:%u:%u: runtime error: load of value ", d->loc.file, d->loc.line, column);
    __ubsan_print_int(d->type, value);
    fprintf(stderr, ", which is not a valid value for type %s\n", d->type->name);
    __ubsan_summary(&d->loc, column);
}

void __ubsan_handle_load_invalid_value(struct __ubsan_invalid_value_data *d, uintptr_t value) {
    __ubsan_invalid_value(d, value);
}

_Noreturn void __ubsan_handle_load_invalid_value_abort(struct __ubsan_invalid_value_data *d,
                                                       uintptr_t value) {
    __ubsan_invalid_value(d, value);
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
    __ubsan_summary(&d->loc, column);
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
    fprintf(stderr, "%s:%u:%u: runtime error: %s integer overflow: ", d->loc.file,
            d->loc.line, column, (d->type->info & 1) ? "signed" : "unsigned");
    __ubsan_print_int(d->type, lhs);
    fprintf(stderr, " %s ", op);
    __ubsan_print_int(d->type, rhs);
    fprintf(stderr, " cannot be represented in type %s\n", d->type->name);
    __ubsan_summary(&d->loc, column);
}

static void __ubsan_negate(struct __ubsan_overflow_data *d, uintptr_t v) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    fprintf(stderr, "%s:%u:%u: runtime error: negation of ", d->loc.file, d->loc.line, column);
    __ubsan_print_int(d->type, v);
    fprintf(stderr, " cannot be represented in type %s%s\n", d->type->name,
            (d->type->info & 1)
                ? "; cast to an unsigned type to negate this value to itself"
                : "");
    __ubsan_summary(&d->loc, column);
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

static void __ubsan_implicit_conversion(struct __ubsan_implicit_conversion_data *d, uintptr_t src,
                                        uintptr_t dst) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    const struct __ubsan_type_descriptor *from = d->from_type, *to = d->to_type;
    fprintf(stderr, "%s:%u:%u: runtime error: implicit conversion from type %s of value ",
            d->loc.file, d->loc.line, column, from->name);
    __ubsan_print_int(from, src);
    fprintf(stderr, " (%u-bit, %ssigned) to type %s changed the value to ", __ubsan_bits(from),
            (from->info & 1) ? "" : "un", to->name);
    __ubsan_print_int(to, dst);
    fprintf(stderr, " (%u-bit, %ssigned)\n", __ubsan_bits(to), (to->info & 1) ? "" : "un");
    __ubsan_summary(&d->loc, column);
}

void __ubsan_handle_implicit_conversion(struct __ubsan_implicit_conversion_data *d, uintptr_t src,
                                        uintptr_t dst) {
    __ubsan_implicit_conversion(d, src, dst);
}

_Noreturn void __ubsan_handle_implicit_conversion_abort(struct __ubsan_implicit_conversion_data *d,
                                                        uintptr_t src, uintptr_t dst) {
    __ubsan_implicit_conversion(d, src, dst);
    abort();
}

_Noreturn void __ubsan_handle_builtin_unreachable(struct __ubsan_unreachable_data *d) {
    uint32_t column;
    if (__ubsan_claim(&d->loc, &column)) {
        fprintf(stderr, "%s:%u:%u: runtime error: execution reached an unreachable program point\n",
                d->loc.file, d->loc.line, column);
        __ubsan_summary(&d->loc, column);
    }
    abort();
}

static void __ubsan_vla_bound(struct __ubsan_vla_bound_data *d, uintptr_t bound) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    fprintf(stderr, "%s:%u:%u: runtime error: variable length array bound evaluates to "
            "non-positive value ", d->loc.file, d->loc.line, column);
    __ubsan_print_int(d->type, bound);
    fprintf(stderr, "\n");
    __ubsan_summary(&d->loc, column);
}

void __ubsan_handle_vla_bound_not_positive(struct __ubsan_vla_bound_data *d, uintptr_t bound) {
    __ubsan_vla_bound(d, bound);
}

_Noreturn void __ubsan_handle_vla_bound_not_positive_abort(struct __ubsan_vla_bound_data *d,
                                                           uintptr_t bound) {
    __ubsan_vla_bound(d, bound);
    abort();
}

// The accesses `type_check_kind` names, as clang's runtime words them.
static const char *const __ubsan_access_kinds[] = {
    "load of",
    "store to",
    "reference binding to",
    "member access within",
    "member call on",
    "constructor call on",
    "downcast of",
    "downcast of",
    "upcast of",
    "cast to virtual base of",
    "_Nonnull binding to",
    "dynamic operation on",
};

static void __ubsan_type_mismatch(struct __ubsan_type_mismatch_data *d, uintptr_t pointer) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    size_t kinds = sizeof __ubsan_access_kinds / sizeof __ubsan_access_kinds[0];
    const char *kind =
        d->type_check_kind < kinds ? __ubsan_access_kinds[d->type_check_kind] : "access of";
    unsigned long long alignment = 1ull << d->log_alignment;
    unsigned long long address = pointer;
    fprintf(stderr, "%s:%u:%u: runtime error: ", d->loc.file, d->loc.line, column);
    if (!pointer)
        fprintf(stderr, "%s null pointer of type %s\n", kind, d->type->name);
    else if (address & (alignment - 1))
        fprintf(stderr,
                "%s misaligned address 0x%012llx for type %s, which requires %llu byte "
                "alignment\n",
                kind, address, d->type->name, alignment);
    else
        fprintf(stderr, "%s address 0x%012llx with insufficient space for an object of type %s\n",
                kind, address, d->type->name);
    __ubsan_summary(&d->loc, column);
}

void __ubsan_handle_type_mismatch_v1(struct __ubsan_type_mismatch_data *d, uintptr_t pointer) {
    __ubsan_type_mismatch(d, pointer);
}

_Noreturn void __ubsan_handle_type_mismatch_v1_abort(struct __ubsan_type_mismatch_data *d,
                                                     uintptr_t pointer) {
    __ubsan_type_mismatch(d, pointer);
    abort();
}

// A pointer step from `base` to `result`, named by which is null and, for
// two others, by the signs they have as signed integers.
static void __ubsan_pointer_overflow(struct __ubsan_pointer_overflow_data *d, uintptr_t base,
                                     uintptr_t result) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    unsigned long long from = base, to = result;
    fprintf(stderr, "%s:%u:%u: runtime error: ", d->loc.file, d->loc.line, column);
    if (!from && !to)
        fprintf(stderr, "applying zero offset to null pointer\n");
    else if (!from)
        fprintf(stderr, "applying non-zero offset %llu to null pointer\n", to);
    else if (!to)
        fprintf(stderr,
                "applying non-zero offset to non-null pointer 0x%012llx produced null pointer\n",
                from);
    else if (((intptr_t)base >= 0) == ((intptr_t)result >= 0))
        fprintf(stderr, "%s 0x%012llx overflowed to 0x%012llx\n",
                from > to ? "addition of unsigned offset to" : "subtraction of unsigned offset from",
                from, to);
    else
        fprintf(stderr, "pointer index expression with base 0x%012llx overflowed to 0x%012llx\n",
                from, to);
    __ubsan_summary(&d->loc, column);
}

void __ubsan_handle_pointer_overflow(struct __ubsan_pointer_overflow_data *d, uintptr_t base,
                                     uintptr_t result) {
    __ubsan_pointer_overflow(d, base, result);
}

_Noreturn void __ubsan_handle_pointer_overflow_abort(struct __ubsan_pointer_overflow_data *d,
                                                     uintptr_t base, uintptr_t result) {
    __ubsan_pointer_overflow(d, base, result);
    abort();
}

// -mgeneral-regs-only and -mno-sse withhold the registers a floating value
// needs, and no unit so built converts one.
#if defined __SSE2__ || defined __ARM_FP
// A floating operand: its bits in the value where its width, `info`, is 64
// or less, else at the address the value holds.
static void __ubsan_print_float(const struct __ubsan_type_descriptor *t, uintptr_t value) {
    union {
        uint64_t bits;
        double d;
        uint32_t bits32;
        float f;
    } u;
    if (t->info == 32) {
        u.bits32 = (uint32_t)value;
        fprintf(stderr, "%g", (double)u.f);
    } else if (t->info == 64) {
        u.bits = value;
        fprintf(stderr, "%g", u.d);
    } else {
        fprintf(stderr, "%Lg", *(const long double *)value);
    }
}

static void __ubsan_float_cast(struct __ubsan_float_cast_data *d, uintptr_t from) {
    uint32_t column;
    if (!__ubsan_claim(&d->loc, &column))
        return;
    fprintf(stderr, "%s:%u:%u: runtime error: ", d->loc.file, d->loc.line, column);
    __ubsan_print_float(d->from_type, from);
    fprintf(stderr, " is outside the range of representable values of type %s\n",
            d->to_type->name);
    __ubsan_summary(&d->loc, column);
}

void __ubsan_handle_float_cast_overflow(struct __ubsan_float_cast_data *d, uintptr_t from) {
    __ubsan_float_cast(d, from);
}

_Noreturn void __ubsan_handle_float_cast_overflow_abort(struct __ubsan_float_cast_data *d,
                                                        uintptr_t from) {
    __ubsan_float_cast(d, from);
    abort();
}
#endif

// A deferred-size array typedef (`typedef T X[]`) used to declare an object
// makes the object a deferred array sized by its initializer, the same as a
// direct `T x[]`. QEMU's `typedef struct ClockPortInitElem ClockPortInitArray[]`
// is initialized with designated-struct elements from the QDEV_CLOCK_IN macro.
// A fixed-size array typedef (`X[N]`) and a scalar struct typedef are the
// regressions. Returns 0 on success.

struct Elem {
    const char *name;
    int is_output;
    int offset;
};

// Deferred array typedef; size comes from the initializer (3 elements).
typedef struct Elem ElemArray[];
static const ElemArray clocks = {
    { .name = "hsi16", .is_output = 0, .offset = 4 },
    { .name = "msi", .is_output = 0, .offset = 8 },
    { .name = "hse", .is_output = 0, .offset = 12 },
};

// Regression: fixed-size array typedef still binds as an array.
typedef struct Elem ElemArray2[2];
static const ElemArray2 pair = {
    { .name = "a", .offset = 1 },
    { .name = "b", .offset = 2 },
};

// Regression: a scalar struct typedef is unaffected (not an array).
typedef struct Elem OneElem;
static const OneElem one = { .name = "solo", .offset = 99 };

// C99 6.7.5.3p7: a parameter of the deferred array typedef adjusts to a
// pointer to the element, so `clocks[i]` indexes it -- QEMU's
// `void qdev_init_clocks(DeviceState *, const ClockPortInitArray)`.
static int total_offset(const ElemArray clocks, int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        sum += clocks[i].offset;
    }
    return sum;
}

int main(void) {
    if (sizeof(clocks) / sizeof(clocks[0]) != 3) return 1;
    if (clocks[0].name[0] != 'h' || clocks[0].offset != 4) return 2;
    if (clocks[1].name[0] != 'm' || clocks[1].offset != 8) return 3;
    if (clocks[2].name[0] != 'h' || clocks[2].offset != 12) return 4;
    if (sizeof(pair) / sizeof(pair[0]) != 2) return 5;
    if (pair[0].offset != 1 || pair[1].offset != 2) return 6;
    if (one.name[0] != 's' || one.offset != 99) return 7;
    if (total_offset(clocks, 3) != 24) return 8;   // 4 + 8 + 12
    return 0;
}

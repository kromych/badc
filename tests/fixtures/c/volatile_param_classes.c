/* Volatile-qualified parameters must keep their band classification
   (C99 6.7.3, 6.7.5.3): a `volatile double` still arrives in an FP
   argument register, a `volatile float` keeps its narrow entry copy,
   and the qualifier must not push either onto the integer path. */
typedef struct Acc {
    double sum;
    long long cnt;
} Acc;

static void step(volatile Acc *a, volatile double r) {
    volatile double s = a->sum;
    a->sum = s + r;
}

static double half(volatile float f) {
    return (double)f * 0.5;
}

static void bump(Acc *a, double v) {
    a->cnt++;
    step(a, v);
}

int main(void) {
    Acc a = {0.0, 0};
    bump(&a, 1.5);
    bump(&a, 2.5);
    bump(&a, 3.5);
    if (a.sum != 7.5 || a.cnt != 3) {
        return 1;
    }
    if (half(5.0f) != 2.5) {
        return 2;
    }
    return 0;
}

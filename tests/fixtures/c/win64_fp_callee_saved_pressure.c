// Win64 marks xmm6..xmm15 non-volatile; System V marks every xmm
// volatile. A function with more floating values live across calls
// than the volatile bank holds must put the rest in the callee-saved
// xmms on Win64 (the prologue and every exit save and restore the full
// 128 bits of each one used) and spill them on System V. This fixture
// keeps eleven doubles live across interleaved calls, past the Win64
// volatile set (xmm0..xmm5), and checks the results, so a save or
// restore from the wrong slot fails the run. The seed values are
// volatile so the calls are emitted and the save / restore paths run.
__attribute__((noinline)) static double rt(double v) {
    volatile double t = v;
    return t;
}

__attribute__((noinline)) static double mix3(double a, double b, double c, double z) {
    return a * rt(b) + c * rt(a) + b * rt(z) + z;
}

double pressure(double x, double y) {
    volatile double sx = x, sy = y;
    double v0 = sx + 1.0, v1 = sy + 2.0, v2 = sx * sy + 3.0;
    double v3 = sx - sy + 4.0, v4 = sx + sy * 5.0, v5 = sx * 6.0 + sy;
    double v6 = sx / 7.0 + sy, v7 = sx + sy / 8.0, v8 = sx * sy + 9.0;
    double v9 = sx * 10.0 + sy, v10 = sx + sy * 11.0;
    v0 = mix3(v0, v1, v2, v10);
    v1 = mix3(v1, v2, v3, v9);
    v2 = mix3(v2, v3, v4, v8);
    v3 = mix3(v3, v4, v5, v7);
    v4 = mix3(v4, v5, v6, v6);
    v5 = mix3(v5, v6, v7, v5);
    v6 = mix3(v6, v7, v8, v4);
    v7 = mix3(v7, v8, v9, v3);
    v8 = mix3(v8, v9, v10, v2);
    v9 = mix3(v9, v10, v0, v1);
    v10 = mix3(v10, v0, v1, v0);
    return v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7 + v8 + v9 + v10;
}

int main(void) {
    double a = pressure(0.5, 2.0);
    double b = pressure(0.5, 2.0);
    if (a != b) {
        return 1;
    }
    if (a <= 0.0) {
        return 2;
    }
    return 0;
}
